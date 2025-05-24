import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class DashboardRepository {
  constructor(private readonly prisma: PrismaService) {}

  async getDashboardStats(from?: string, to?: string, companyId?: string) {
    const whereClause: any = {};

    if (from && to) {
      whereClause.start_date = {
        gte: new Date(from),
        lte: new Date(to),
      };
    }

    if (companyId) {
      whereClause.company_id = parseInt(companyId);
    }

    try {
      // Get total calls
      const totalCalls = await this.prisma.call.count({
        where: whereClause,
      });

      // Get average duration
      const durationAgg = await this.prisma.call.aggregate({
        where: whereClause,
        _avg: {
          duration_seconds: true,
        },
      });

      console.log(
        '🚀 ~ dashboard.repository.ts:36 ~ DashboardRepository ~ getDashboardStats ~ durationAgg:',
        durationAgg,
      );

      // Get average AI score
      console.log(
        '🚀 ~ dashboard.repository.ts:49 ~ DashboardRepository ~ getDashboardStats ~ whereClause:',
        whereClause,
      );
      const aiScoreAgg = await this.prisma.llmEvaluation.aggregate({
        where: {
          call:
            whereClause.start_date || whereClause.company_id
              ? { ...whereClause }
              : undefined,
        },
        _avg: {
          overall_score: true,
        },
      });

      // Get resolved call rate
      const resolvedCalls = await this.prisma.llmEvaluation.count({
        where: {
          resolution_status: true,
          call:
            whereClause.start_date || whereClause.company_id
              ? { ...whereClause }
              : undefined,
        },
      });

      // Get average human evaluation score
      const humanScoreAgg = await this.prisma.humanEvaluation.aggregate({
        where: {
          call:
            whereClause.start_date || whereClause.company_id
              ? { ...whereClause }
              : undefined,
        },
        _avg: {
          overall_score: true,
        },
      });

      const resolvedRate =
        totalCalls > 0 ? (resolvedCalls / totalCalls) * 100 : 0;

      return {
        totalCalls,
        avgDuration: durationAgg._avg.duration_seconds || 0,
        avgAiScore: aiScoreAgg._avg.overall_score || 4.5,
        resolvedRate: Math.round(resolvedRate),
        avgHumanScore: humanScoreAgg._avg.overall_score || 4.2,
      };
    } catch (error) {
      console.error('Database error in getDashboardStats:', error);
      throw error;
    }
  }
}
