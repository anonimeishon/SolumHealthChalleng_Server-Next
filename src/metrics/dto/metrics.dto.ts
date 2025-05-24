import { ApiProperty } from '@nestjs/swagger';

export interface MetricsFilters {
  from?: Date;
  to?: Date;
  companyId?: number;
}

export class TopPerformingAgentDto {
  @ApiProperty({
    description: 'Agent ID',
    example: 1,
  })
  id!: number;

  @ApiProperty({
    description: 'Agent name',
    example: 'John Doe',
  })
  name!: string;

  @ApiProperty({
    description: 'Company name',
    example: 'Clinic A',
  })
  companyName!: string;

  @ApiProperty({
    description: 'Combined evaluation score (average of AI and human)',
    example: 4.7,
  })
  combinedScore!: number;

  @ApiProperty({
    description: 'Average AI evaluation score',
    example: 4.8,
  })
  avgLlmScore!: number;

  @ApiProperty({
    description: 'Average human evaluation score',
    example: 4.6,
  })
  avgHumanScore!: number;

  @ApiProperty({
    description: 'Number of calls handled',
    example: 45,
  })
  callCount!: number;

  @ApiProperty({
    description: 'Total number of evaluations',
    example: 38,
  })
  evaluationCount!: number;
}

export class DashboardMetricsDto {
  @ApiProperty({
    description: 'Total number of calls',
    example: 1247,
  })
  totalCalls!: number;

  @ApiProperty({
    description: 'Average call duration in seconds',
    example: 180,
  })
  averageCallDuration!: number;

  @ApiProperty({
    description: 'Average AI evaluation score',
    example: 4.5,
  })
  averageAiScore!: number;

  @ApiProperty({
    description: 'Percentage of resolved calls',
    example: 92.3,
  })
  resolvedCallRate!: number;

  @ApiProperty({
    description: 'Average human evaluation score',
    example: 4.2,
  })
  averageHumanScore!: number;

  @ApiProperty({
    description: 'Percentage change in call volume compared to previous period',
    example: 15.2,
  })
  callVolumeChange!: number;

  @ApiProperty({
    description:
      'Performance trend data with current and previous period comparison',
    example: {
      current: { averageScore: 4.5, totalEvaluations: 150 },
      previous: { averageScore: 4.2, totalEvaluations: 140 },
      trend: 7.1,
    },
  })
  performanceTrend!: {
    current: any;
    previous: any;
    trend: number | null;
  };

  @ApiProperty({
    description: 'Top performing agent with best combined evaluation score',
    type: TopPerformingAgentDto,
    nullable: true,
  })
  topPerformingAgent!: TopPerformingAgentDto | null;
}

export class MetricScoreDto {
  @ApiProperty({
    description: 'Average score value',
    example: 4.5,
    nullable: true,
  })
  averageScore!: number | null;

  @ApiProperty({
    description: 'Total number of evaluations',
    example: 150,
  })
  totalEvaluations!: number;
}

export class CallDurationDto {
  @ApiProperty({
    description: 'Average duration in seconds',
    example: 180,
    nullable: true,
  })
  averageDuration!: number | null;

  @ApiProperty({
    description: 'Total number of calls',
    example: 1247,
  })
  totalCalls!: number;
}

export class ResolvedCallRateDto {
  @ApiProperty({
    description: 'Total number of calls',
    example: 1247,
  })
  totalCalls!: number;

  @ApiProperty({
    description: 'Number of resolved calls',
    example: 1150,
  })
  resolvedCalls!: number;

  @ApiProperty({
    description: 'Resolved rate as percentage',
    example: 92.3,
  })
  resolvedRate!: number;
}

export class TotalCallsDto {
  @ApiProperty({
    description: 'Total number of calls',
    example: 1247,
  })
  totalCalls!: number;
}

export class PerformanceTrendDto {
  @ApiProperty({
    description: 'Current period metrics',
    type: MetricScoreDto,
  })
  current!: MetricScoreDto;

  @ApiProperty({
    description: 'Previous period metrics',
    type: MetricScoreDto,
  })
  previous!: MetricScoreDto;

  @ApiProperty({
    description: 'Trend percentage change',
    example: 15.2,
    nullable: true,
  })
  trend!: number | null;
}
