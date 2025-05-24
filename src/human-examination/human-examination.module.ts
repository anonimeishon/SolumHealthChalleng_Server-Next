import { Module } from '@nestjs/common';
import { HumanExaminationService } from './human-examination.service';
import { HumanExaminationController } from './human-examination.controller';
import { PrismaModule } from '../prisma/prisma.module';
import { HumanExaminationRepository } from './human-examination.repository';
import { UsersRepository } from 'src/users/users.repository';

@Module({
  imports: [PrismaModule],
  controllers: [HumanExaminationController],
  providers: [
    HumanExaminationService,
    HumanExaminationRepository,
    UsersRepository,
  ],
})
export class HumanExaminationModule {}
