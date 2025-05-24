import { Module } from '@nestjs/common';
import { CallsController } from './calls.controller';
import { CallsService } from './calls.service';
import { CallsRepository } from './calls.repository';
import { PrismaModule } from '../prisma/prisma.module';

@Module({
  controllers: [CallsController],
  providers: [CallsService, CallsRepository],
  imports: [PrismaModule],
  exports: [CallsService],
})
export class CallsModule {}
