import { Injectable } from '@nestjs/common';
import { MetricsRepository } from './metrics.repository';
import { MetricsFilters } from './dto/metrics.dto';

@Injectable()
export class MetricsService {
  constructor(private readonly metricsRepository: MetricsRepository) {}

  async getAverageAiScore(filters: MetricsFilters) {
    return this.metricsRepository.getAverageAiScore(filters);
  }

  async getPerformanceTrend(filters: MetricsFilters) {
    const { from, to, companyId } = filters;

    if (from && to) {
      // Calculate the duration between from and to
      const duration = to.getTime() - from.getTime();

      // Calculate the previous period
      const previousTo = new Date(from.getTime());
      const previousFrom = new Date(from.getTime() - duration);

      const currentPeriod = await this.metricsRepository.getAverageAiScore({
        from,
        to,
        companyId,
      });

      const previousPeriod = await this.metricsRepository.getAverageAiScore({
        from: previousFrom,
        to: previousTo,
        companyId,
      });

      return {
        current: currentPeriod,
        previous: previousPeriod,
        trend:
          currentPeriod.averageScore && previousPeriod.averageScore
            ? ((currentPeriod.averageScore - previousPeriod.averageScore) /
                previousPeriod.averageScore) *
              100
            : null,
      };
    } else {
      // Default to last month vs previous month
      const now = new Date();
      const lastMonthEnd = new Date(now.getFullYear(), now.getMonth(), 0);
      const lastMonthStart = new Date(now.getFullYear(), now.getMonth() - 1, 1);
      const previousMonthEnd = new Date(
        now.getFullYear(),
        now.getMonth() - 1,
        0,
      );
      const previousMonthStart = new Date(
        now.getFullYear(),
        now.getMonth() - 2,
        1,
      );

      const currentPeriod = await this.metricsRepository.getAverageAiScore({
        from: lastMonthStart,
        to: lastMonthEnd,
        companyId,
      });

      const previousPeriod = await this.metricsRepository.getAverageAiScore({
        from: previousMonthStart,
        to: previousMonthEnd,
        companyId,
      });

      return {
        current: currentPeriod,
        previous: previousPeriod,
        trend:
          currentPeriod.averageScore && previousPeriod.averageScore
            ? ((currentPeriod.averageScore - previousPeriod.averageScore) /
                previousPeriod.averageScore) *
              100
            : null,
      };
    }
  }

  async getHumanEvaluationScore(filters: MetricsFilters) {
    return this.metricsRepository.getHumanEvaluationScore(filters);
  }

  async getResolvedCallRate(filters: MetricsFilters) {
    return this.metricsRepository.getResolvedCallRate(filters);
  }

  async getAverageCallDuration(filters: MetricsFilters) {
    return this.metricsRepository.getAverageCallDuration(filters);
  }

  async getTotalCalls(filters: MetricsFilters) {
    return this.metricsRepository.getTotalCalls(filters);
  }
}
