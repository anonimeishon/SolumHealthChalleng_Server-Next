import { Module } from '@nestjs/common';
import { HumanExaminationService } from './human-examination.service';
import { HumanExaminationController } from './human-examination.controller';
import { PrismaModule } from '../prisma/prisma.module';
import { HumanExaminationRepository } from './human-examination.repository';

@Module({
  imports: [PrismaModule],
  controllers: [HumanExaminationController],
  providers: [HumanExaminationService, HumanExaminationRepository],
})
export class HumanExaminationModule {}
