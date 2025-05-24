import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PrismaModule } from './prisma/prisma.module'; // Import PrismaModule
import { UsersModule } from './users/users.module';
import { DataIngestionModule } from './data-ingestion/data-ingestion.module';
import { CallsModule } from 'src/calls/calls.module';
import { LlmExaminationModule } from './llm-examination/llm-examination.module';
import { HumanExaminationModule } from './human-examination/human-examination.module';

@Module({
  imports: [
    PrismaModule,
    UsersModule,
    DataIngestionModule,
    CallsModule,
    LlmExaminationModule,
    HumanExaminationModule,
  ], // Add DataIngestionModule to imports
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
