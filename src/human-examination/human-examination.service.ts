import { Injectable } from '@nestjs/common';
import { UpdateHumanExaminationDto } from './dto/human-examination.dto';
import { HumanExaminationRepository } from './human-examination.repository';
import { Prisma } from '@prisma/client';
import { UsersRepository } from 'src/users/users.repository';

@Injectable()
export class HumanExaminationService {
  constructor(
    private readonly humanExaminationRepository: HumanExaminationRepository,
    private readonly usersRepository: UsersRepository,
  ) {}

  async create(
    createHumanExaminationDto: Prisma.HumanEvaluationUncheckedCreateInput,
  ) {
    let { evaluator_id } = createHumanExaminationDto;

    if (!evaluator_id) {
      const evaluator = await this.usersRepository.findOne({ name: 'Guest' });
      if (evaluator) {
        evaluator_id = evaluator.id;
      } else {
        throw new Error('Evaluator not found');
      }
    }

    return this.humanExaminationRepository.create({
      ...createHumanExaminationDto,
      evaluator_id,
    });
  }

  async findAll() {
    return this.humanExaminationRepository.findAll();
  }

  async findOne(id: number) {
    return this.humanExaminationRepository.findOne(id);
  }

  async update(
    id: number,
    updateHumanExaminationDto: UpdateHumanExaminationDto,
  ) {
    return this.humanExaminationRepository.update(
      id,
      updateHumanExaminationDto,
    );
  }

  async remove(id: number) {
    return this.humanExaminationRepository.remove(id);
  }
}
