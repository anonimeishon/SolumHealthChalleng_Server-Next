import { Injectable } from '@nestjs/common';
import { CreateHumanExaminationDto } from './dto/human-examination.dto';
import { UpdateHumanExaminationDto } from './dto/human-examination.dto';
import { HumanExaminationRepository } from './human-examination.repository';

@Injectable()
export class HumanExaminationService {
  constructor(
    private readonly humanExaminationRepository: HumanExaminationRepository,
  ) {}

  create(createHumanExaminationDto: CreateHumanExaminationDto) {
    return this.humanExaminationRepository.create(createHumanExaminationDto);
  }

  findAll() {
    return this.humanExaminationRepository.findAll();
  }

  findOne(id: number) {
    return this.humanExaminationRepository.findOne(id);
  }

  update(id: number, updateHumanExaminationDto: UpdateHumanExaminationDto) {
    return this.humanExaminationRepository.update(
      id,
      updateHumanExaminationDto,
    );
  }

  remove(id: number) {
    return this.humanExaminationRepository.remove(id);
  }
}
