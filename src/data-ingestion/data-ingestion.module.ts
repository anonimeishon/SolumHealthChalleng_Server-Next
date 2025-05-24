import { Module } from '@nestjs/common';
import { DataIngestionService } from './data-ingestion.service';
import { DataIngestionController } from './data-ingestion.controller';
import {
  CompanyRepository,
  AgentRepository,
  UserRepository,
  CallRepository,
  HumanEvaluationRepository,
  LlmEvaluationRepository,
} from './repositories/data-ingestion.repositories';
import { PrismaModule } from '../prisma/prisma.module';

@Module({
  imports: [PrismaModule],
  controllers: [DataIngestionController],
  providers: [
    DataIngestionService,
    CompanyRepository,
    AgentRepository,
    UserRepository,
    CallRepository,
    HumanEvaluationRepository,
    LlmEvaluationRepository,
  ],
  exports: [DataIngestionService],
})
export class DataIngestionModule {}
