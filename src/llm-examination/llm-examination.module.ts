import { Module } from '@nestjs/common';
import { LlmExaminationService } from './llm-examination.service';
import { LlmExaminationController } from './llm-examination.controller';
import { PrismaModule } from '../prisma/prisma.module';
import { LlmExaminationRepository } from './llm-examination.repository';

@Module({
  imports: [PrismaModule],
  controllers: [LlmExaminationController],
  providers: [LlmExaminationService, LlmExaminationRepository],
})
export class LlmExaminationModule {}
