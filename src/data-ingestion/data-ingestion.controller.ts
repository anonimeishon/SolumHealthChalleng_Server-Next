import { Controller, Post, Body, Logger, Get } from '@nestjs/common';
import { DataIngestionService } from './data-ingestion.service';
import { IngestPayloadDto } from './dto/ingest-payload.dto';

@Controller('data-ingestion')
export class DataIngestionController {
  private readonly logger = new Logger(DataIngestionController.name);

  constructor(private readonly dataIngestionService: DataIngestionService) {}

  @Post('ingest')
  async ingestCsvData(@Body() payload: IngestPayloadDto) {
    this.logger.log(`Received ${payload.rows.length} rows for ingestion`);

    try {
      await this.dataIngestionService.ingestData(
        payload.rows,
        payload.companyName,
      );
      return {
        message: `Successfully ingested ${payload.rows.length} rows for company ${payload.companyName}`,
      };
    } catch (error) {
      this.logger.error('Data ingestion failed:', error);
      throw error;
    }
  }

  // @Get('status')
  // async getStatus(): Promise<any> {
  //   this.logger.log('Checking database status');
  //   try {
  //     return await this.dataIngestionService.getDatabaseStatus();
  //   } catch (error) {
  //     this.logger.error('Status check failed:', error);
  //     throw error;
  //   }
  // }
}
