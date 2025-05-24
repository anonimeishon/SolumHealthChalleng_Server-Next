import { Module } from '@nestjs/common';
import { CallsController } from './calls.controller';
import { CallsService } from './calls.service';
import { CallsRepository } from './calls.repository';
import { PrismaModule } from '../prisma/prisma.module';
import { LlmEvaluationRepository } from '../data-ingestion/repositories/data-ingestion.repositories';

@Module({
  controllers: [CallsController],
  providers: [CallsService, CallsRepository, LlmEvaluationRepository],
  imports: [PrismaModule],
  exports: [CallsService],
})
export class CallsModule {}
