import { Controller, Get, Query, ParseIntPipe } from '@nestjs/common';
import { MetricsService } from './metrics.service';
import { parseDatePipeInstance } from '../util/parse-date.pipe';
import { ApiTags, ApiOperation, ApiResponse, ApiQuery } from '@nestjs/swagger';
import {
  DashboardMetricsDto,
  MetricScoreDto,
  CallDurationDto,
  ResolvedCallRateDto,
  TotalCallsDto,
  PerformanceTrendDto,
} from './dto/metrics.dto';

@ApiTags('metrics')
@Controller('metrics')
export class MetricsController {
  constructor(private readonly metricsService: MetricsService) {}

  @Get('dashboard')
  @ApiOperation({ summary: 'Get all dashboard metrics in a single response' })
  @ApiQuery({
    name: 'from',
    required: false,
    type: String,
    description: 'Start date filter (ISO string)',
  })
  @ApiQuery({
    name: 'to',
    required: false,
    type: String,
    description: 'End date filter (ISO string)',
  })
  @ApiQuery({
    name: 'companyId',
    required: false,
    type: Number,
    description: 'Company ID filter',
  })
  @ApiResponse({
    status: 200,
    description: 'Dashboard metrics retrieved successfully',
    type: DashboardMetricsDto,
  })
  async getDashboardMetrics(
    @Query('from', parseDatePipeInstance) from?: Date,
    @Query('to', parseDatePipeInstance) to?: Date,
    @Query('companyId', new ParseIntPipe({ optional: true }))
    companyId?: number,
  ) {
    const filters = { from, to, companyId };

    // Fetch all metrics concurrently
    const [
      totalCallsData,
      averageCallDurationData,
      averageAiScoreData,
      resolvedCallRateData,
      humanEvaluationScoreData,
      performanceTrendData,
    ] = await Promise.all([
      this.metricsService.getTotalCalls(filters),
      this.metricsService.getAverageCallDuration(filters),
      this.metricsService.getAverageAiScore(filters),
      this.metricsService.getResolvedCallRate(filters),
      this.metricsService.getHumanEvaluationScore(filters),
      this.metricsService.getPerformanceTrend(filters),
    ]);

    return {
      totalCalls: totalCallsData.totalCalls,
      averageCallDuration: Math.round(
        averageCallDurationData.averageDuration || 0,
      ),
      averageAiScore: Number((averageAiScoreData.averageScore || 0).toFixed(1)),
      resolvedCallRate: Number(resolvedCallRateData.resolvedRate.toFixed(1)),
      averageHumanScore: Number(
        (humanEvaluationScoreData.averageScore || 0).toFixed(1),
      ),
      callVolumeChange: performanceTrendData.trend || 0,
      performanceTrend: performanceTrendData,
    };
  }

  @Get('average-ai-score')
  @ApiOperation({ summary: 'Get average AI score' })
  @ApiQuery({
    name: 'from',
    required: false,
    type: String,
    description: 'Start date filter (ISO string)',
  })
  @ApiQuery({
    name: 'to',
    required: false,
    type: String,
    description: 'End date filter (ISO string)',
  })
  @ApiQuery({
    name: 'company_id',
    required: false,
    type: Number,
    description: 'Company ID filter',
  })
  @ApiResponse({
    status: 200,
    description: 'Average AI score retrieved successfully',
    type: MetricScoreDto,
  })
  getAverageAiScore(
    @Query('from', parseDatePipeInstance) from?: Date,
    @Query('to', parseDatePipeInstance) to?: Date,
    @Query('company_id', new ParseIntPipe({ optional: true }))
    companyId?: number,
  ) {
    return this.metricsService.getAverageAiScore({ from, to, companyId });
  }

  @Get('performance-trend')
  @ApiOperation({ summary: 'Get performance trend data' })
  @ApiQuery({
    name: 'from',
    required: false,
    type: String,
    description: 'Start date filter (ISO string)',
  })
  @ApiQuery({
    name: 'to',
    required: false,
    type: String,
    description: 'End date filter (ISO string)',
  })
  @ApiQuery({
    name: 'company_id',
    required: false,
    type: Number,
    description: 'Company ID filter',
  })
  @ApiResponse({
    status: 200,
    description: 'Performance trend retrieved successfully',
    type: PerformanceTrendDto,
  })
  getPerformanceTrend(
    @Query('from', parseDatePipeInstance) from?: Date,
    @Query('to', parseDatePipeInstance) to?: Date,
    @Query('company_id', new ParseIntPipe({ optional: true }))
    companyId?: number,
  ) {
    return this.metricsService.getPerformanceTrend({ from, to, companyId });
  }

  @Get('human-evaluation-score')
  @ApiOperation({ summary: 'Get human evaluation score' })
  @ApiQuery({
    name: 'from',
    required: false,
    type: String,
    description: 'Start date filter (ISO string)',
  })
  @ApiQuery({
    name: 'to',
    required: false,
    type: String,
    description: 'End date filter (ISO string)',
  })
  @ApiQuery({
    name: 'company_id',
    required: false,
    type: Number,
    description: 'Company ID filter',
  })
  @ApiResponse({
    status: 200,
    description: 'Human evaluation score retrieved successfully',
    type: MetricScoreDto,
  })
  getHumanEvaluationScore(
    @Query('from', parseDatePipeInstance) from?: Date,
    @Query('to', parseDatePipeInstance) to?: Date,
    @Query('company_id', new ParseIntPipe({ optional: true }))
    companyId?: number,
  ) {
    return this.metricsService.getHumanEvaluationScore({ from, to, companyId });
  }

  @Get('resolved-call-rate')
  @ApiOperation({ summary: 'Get resolved call rate' })
  @ApiQuery({
    name: 'from',
    required: false,
    type: String,
    description: 'Start date filter (ISO string)',
  })
  @ApiQuery({
    name: 'to',
    required: false,
    type: String,
    description: 'End date filter (ISO string)',
  })
  @ApiQuery({
    name: 'company_id',
    required: false,
    type: Number,
    description: 'Company ID filter',
  })
  @ApiResponse({
    status: 200,
    description: 'Resolved call rate retrieved successfully',
    type: ResolvedCallRateDto,
  })
  getResolvedCallRate(
    @Query('from', parseDatePipeInstance) from?: Date,
    @Query('to', parseDatePipeInstance) to?: Date,
    @Query('company_id', new ParseIntPipe({ optional: true }))
    companyId?: number,
  ) {
    return this.metricsService.getResolvedCallRate({ from, to, companyId });
  }

  @Get('average-call-duration')
  @ApiOperation({ summary: 'Get average call duration' })
  @ApiQuery({
    name: 'from',
    required: false,
    type: String,
    description: 'Start date filter (ISO string)',
  })
  @ApiQuery({
    name: 'to',
    required: false,
    type: String,
    description: 'End date filter (ISO string)',
  })
  @ApiQuery({
    name: 'company_id',
    required: false,
    type: Number,
    description: 'Company ID filter',
  })
  @ApiResponse({
    status: 200,
    description: 'Average call duration retrieved successfully',
    type: CallDurationDto,
  })
  getAverageCallDuration(
    @Query('from', parseDatePipeInstance) from?: Date,
    @Query('to', parseDatePipeInstance) to?: Date,
    @Query('company_id', new ParseIntPipe({ optional: true }))
    companyId?: number,
  ) {
    return this.metricsService.getAverageCallDuration({ from, to, companyId });
  }

  @Get('total-calls')
  @ApiOperation({ summary: 'Get total calls count' })
  @ApiQuery({
    name: 'from',
    required: false,
    type: String,
    description: 'Start date filter (ISO string)',
  })
  @ApiQuery({
    name: 'to',
    required: false,
    type: String,
    description: 'End date filter (ISO string)',
  })
  @ApiQuery({
    name: 'company_id',
    required: false,
    type: Number,
    description: 'Company ID filter',
  })
  @ApiResponse({
    status: 200,
    description: 'Total calls count retrieved successfully',
    type: TotalCallsDto,
  })
  getTotalCalls(
    @Query('from', parseDatePipeInstance) from?: Date,
    @Query('to', parseDatePipeInstance) to?: Date,
    @Query('company_id', new ParseIntPipe({ optional: true }))
    companyId?: number,
  ) {
    return this.metricsService.getTotalCalls({ from, to, companyId });
  }
}
