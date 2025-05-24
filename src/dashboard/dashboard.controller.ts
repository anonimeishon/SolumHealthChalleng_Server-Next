import { Controller, Get, Query } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiQuery } from '@nestjs/swagger';
import { DashboardService } from './dashboard.service';
import { DashboardSummaryDto, DateRangeCommentDto } from './dto/dashboard.dto';

@ApiTags('dashboard')
@Controller()
export class DashboardController {
  constructor(private readonly dashboardService: DashboardService) {}

  @Get('dashboard-summary')
  @ApiOperation({ summary: 'Get dashboard summary' })
  @ApiQuery({
    name: 'from',
    required: false,
    description: 'Start date (ISO string)',
  })
  @ApiQuery({
    name: 'to',
    required: false,
    description: 'End date (ISO string)',
  })
  @ApiResponse({
    status: 200,
    description: 'Dashboard summary retrieved successfully',
    type: DashboardSummaryDto,
  })
  async getDashboardSummary(
    @Query('from') from?: string,
    @Query('to') to?: string,
    @Query('companyId') companyId?: string,
  ): Promise<DashboardSummaryDto> {
    return this.dashboardService.getDashboardSummary(from, to, companyId);
  }

  @Get('date-range-comment')
  @ApiOperation({ summary: 'Get date range comment' })
  @ApiQuery({
    name: 'from',
    required: false,
    description: 'Start date (ISO string)',
  })
  @ApiQuery({
    name: 'to',
    required: false,
    description: 'End date (ISO string)',
  })
  @ApiResponse({
    status: 200,
    description: 'Date range comment retrieved successfully',
    type: DateRangeCommentDto,
  })
  async getDateRangeComment(
    @Query('from') from?: string,
    @Query('to') to?: string,
    @Query('companyId') companyId?: string,
  ): Promise<DateRangeCommentDto> {
    return this.dashboardService.getDateRangeComment(from, to, companyId);
  }
}
