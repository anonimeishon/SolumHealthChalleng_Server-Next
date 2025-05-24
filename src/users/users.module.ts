import { Module } from '@nestjs/common';
import { UsersController } from 'src/users/users.controller';
import { UsersRepository } from 'src/users/users.repository';
import { UsersService } from 'src/users/users.service';
import { PrismaModule } from '../prisma/prisma.module';

@Module({
  controllers: [UsersController],
  providers: [UsersService, UsersRepository],
  imports: [PrismaModule],
  exports: [UsersService],
})
export class UsersModule {}
