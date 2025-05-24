import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { MetricsFilters } from './dto/metrics.dto';

@Injectable()
export class MetricsRepository {
  constructor(private readonly prisma: PrismaService) {}

  async getAverageAiScore(filters: MetricsFilters) {
    const { from, to, companyId } = filters;

    const whereClause: any = {};

    if (from || to) {
      whereClause.call = {
        start_date: {},
      };
      if (from) whereClause.call.start_date.gte = from;
      if (to) whereClause.call.start_date.lte = to;
    }

    if (companyId) {
      whereClause.call = {
        ...whereClause.call,
        company_id: companyId,
      };
    }

    const result = await this.prisma.llmEvaluation.aggregate({
      where: whereClause,
      _avg: {
        overall_score: true,
      },
      _count: {
        id: true,
      },
    });

    return {
      averageScore: result._avg.overall_score,
      totalEvaluations: result._count.id,
    };
  }

  async getHumanEvaluationScore(filters: MetricsFilters) {
    const { from, to, companyId } = filters;

    const whereClause: any = {};

    if (from || to) {
      whereClause.call = {
        start_date: {},
      };
      if (from) whereClause.call.start_date.gte = from;
      if (to) whereClause.call.start_date.lte = to;
    }

    if (companyId) {
      whereClause.call = {
        ...whereClause.call,
        company_id: companyId,
      };
    }

    const result = await this.prisma.humanEvaluation.aggregate({
      where: whereClause,
      _avg: {
        overall_score: true,
      },
      _count: {
        id: true,
      },
    });

    return {
      averageScore: result._avg.overall_score,
      totalEvaluations: result._count.id,
    };
  }

  async getResolvedCallRate(filters: MetricsFilters) {
    const { from, to, companyId } = filters;

    const whereClause: any = {};

    if (from || to) {
      whereClause.start_date = {};
      if (from) whereClause.start_date.gte = from;
      if (to) whereClause.start_date.lte = to;
    }

    if (companyId) {
      whereClause.company_id = companyId;
    }

    const totalCalls = await this.prisma.call.count({
      where: whereClause,
    });

    const resolvedCalls = await this.prisma.call.count({
      where: {
        ...whereClause,
        llm_evaluations: {
          some: {
            problem_solved: true,
          },
        },
      },
    });

    return {
      totalCalls,
      resolvedCalls,
      resolvedRate: totalCalls > 0 ? (resolvedCalls / totalCalls) * 100 : 0,
    };
  }

  async getAverageCallDuration(filters: MetricsFilters) {
    const { from, to, companyId } = filters;

    const whereClause: any = {};

    if (from || to) {
      whereClause.start_date = {};
      if (from) whereClause.start_date.gte = from;
      if (to) whereClause.start_date.lte = to;
    }

    if (companyId) {
      whereClause.company_id = companyId;
    }

    const result = await this.prisma.call.aggregate({
      where: whereClause,
      _avg: {
        duration_seconds: true,
      },
      _count: {
        id: true,
      },
    });

    return {
      averageDuration: result._avg.duration_seconds,
      totalCalls: result._count.id,
    };
  }

  async getTotalCalls(filters: MetricsFilters) {
    const { from, to, companyId } = filters;

    const whereClause: any = {};

    if (from || to) {
      whereClause.start_date = {};
      if (from) whereClause.start_date.gte = from;
      if (to) whereClause.start_date.lte = to;
    }

    if (companyId) {
      whereClause.company_id = companyId;
    }

    const totalCalls = await this.prisma.call.count({
      where: whereClause,
    });

    return {
      totalCalls,
    };
  }

  async getTopPerformingAgent(filters: MetricsFilters) {
    const { from, to, companyId } = filters;

    // Build the where clause for filtering calls
    const callWhereClause: any = {};

    if (from || to) {
      callWhereClause.start_date = {};
      if (from) callWhereClause.start_date.gte = from;
      if (to) callWhereClause.start_date.lte = to;
    }

    if (companyId) {
      callWhereClause.company_id = companyId;
    }

    // Query to get agents with their combined evaluation scores
    const agentsWithScores = await this.prisma.agent.findMany({
      where: companyId ? { company_id: companyId } : {},
      include: {
        calls: {
          where: callWhereClause,
          include: {
            llm_evaluations: {
              select: {
                overall_score: true,
              },
            },
            human_evaluations: {
              select: {
                overall_score: true,
              },
            },
          },
        },
        company: {
          select: {
            name: true,
          },
        },
      },
    });

    //TODO make this logic work on the DB side

    // Calculate combined scores for each agent
    const agentScores = agentsWithScores.map((agent) => {
      let totalLlmScore = 0;
      let llmCount = 0;
      let totalHumanScore = 0;
      let humanCount = 0;
      let callCount = 0;

      agent.calls.forEach((call) => {
        callCount++;

        // Sum LLM scores
        call.llm_evaluations.forEach((evaluation) => {
          if (evaluation.overall_score !== null) {
            totalLlmScore += evaluation.overall_score;
            llmCount++;
          }
        });

        // Sum Human scores
        call.human_evaluations.forEach((evaluation) => {
          if (evaluation.overall_score !== null) {
            totalHumanScore += evaluation.overall_score;
            humanCount++;
          }
        });
      });

      const avgLlmScore = llmCount > 0 ? totalLlmScore / llmCount : 0;
      const avgHumanScore = humanCount > 0 ? totalHumanScore / humanCount : 0;

      // Combined score: if both evaluations exist, average them; otherwise use the available one
      const hasEvaluations = llmCount > 0 || humanCount > 0;
      let combinedScore = 0;

      if (llmCount > 0 && humanCount > 0) {
        combinedScore = (avgLlmScore + avgHumanScore) / 2;
      } else if (llmCount > 0) {
        combinedScore = avgLlmScore;
      } else if (humanCount > 0) {
        combinedScore = avgHumanScore;
      }

      return {
        id: agent.id,
        name: agent.name,
        companyName: agent.company.name,
        combinedScore,
        avgLlmScore,
        avgHumanScore,
        callCount,
        evaluationCount: llmCount + humanCount,
        hasEvaluations,
      };
    });

    // Filter agents with evaluations and sort by combined score
    const validAgents = agentScores
      .filter((agent) => agent.hasEvaluations && agent.callCount > 0)
      .sort((a, b) => b.combinedScore - a.combinedScore);

    // Return top performing agent or null if no agents found
    return validAgents.length > 0 ? validAgents[0] : null;
  }
}
