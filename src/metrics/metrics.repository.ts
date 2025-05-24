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
    console.log(
      '🚀 ~ metrics.repository.ts:51 ~ MetricsRepository ~ getHumanEvaluationScore ~ whereClause:',
      whereClause,
    );

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

    console.log(
      '🚀 ~ metrics.repository.ts:87 ~ MetricsRepository ~ getResolvedCallRate ~ whereClause:',
      whereClause,
    );
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
}
