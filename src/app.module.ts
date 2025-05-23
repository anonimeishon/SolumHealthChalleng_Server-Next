import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PrismaModule } from './prisma/prisma.module'; // Import PrismaModule
import { UsersModule } from './users.module';
import { UsersService } from './users.service';
import { UsersController } from './users.controller';

@Module({
  imports: [PrismaModule, UsersModule], // Add PrismaModule to imports
  controllers: [AppController, UsersController],
  providers: [AppService, UsersService],
})
export class AppModule {}
