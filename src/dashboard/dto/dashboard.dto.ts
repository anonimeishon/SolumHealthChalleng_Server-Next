import { ApiProperty } from '@nestjs/swagger';

export class DashboardSummaryDto {
  @ApiProperty({
    description: 'Dashboard summary text',
    example:
      'Based on the analysis of recent calls, the AI agents are performing exceptionally well...',
  })
  summary!: string;
}

export class DateRangeCommentDto {
  @ApiProperty({
    description: 'Date range specific comment',
    example:
      'For the period from 01/01/2024 to 01/31/2024, the system has maintained consistent performance...',
  })
  comment!: string;
}
