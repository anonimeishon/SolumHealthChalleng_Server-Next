import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { HumanEvaluation, Prisma } from '@prisma/client'; // Import HumanEvaluation type
import { UpdateHumanExaminationDto } from './dto/human-examination.dto';

@Injectable()
export class HumanExaminationRepository {
  constructor(private readonly prisma: PrismaService) {}

  async create(
    createHumanExaminationDto: Prisma.HumanEvaluationUncheckedCreateInput,
  ): Promise<HumanEvaluation> {
    // Added return type
    return this.prisma.humanEvaluation.create({
      data: createHumanExaminationDto,
    });
  }

  async findAll(): Promise<HumanEvaluation[]> {
    // Added return type
    return this.prisma.humanEvaluation.findMany();
  }

  async findOne(id: number): Promise<HumanEvaluation | null> {
    // Added return type
    return await this.prisma.humanEvaluation.findUnique({ where: { id } });
  }

  async update(
    id: number,
    updateHumanExaminationDto: UpdateHumanExaminationDto,
  ): Promise<HumanEvaluation> {
    // Added return type
    const response: HumanEvaluation = await this.prisma.humanEvaluation.update({
      // Explicitly typed response
      where: { id },
      data: updateHumanExaminationDto,
    });
    return response;
  }

  async remove(id: number): Promise<HumanEvaluation> {
    // Added return type
    return this.prisma.humanEvaluation.delete({ where: { id } });
  }
}
