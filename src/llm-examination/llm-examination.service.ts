import { Injectable } from '@nestjs/common';
import { CreateLlmExaminationDto } from './dto/llm-examination.dto';
import { UpdateLlmExaminationDto } from './dto/llm-examination.dto';
import { LlmExaminationRepository } from './llm-examination.repository';

@Injectable()
export class LlmExaminationService {
  constructor(
    private readonly llmExaminationRepository: LlmExaminationRepository,
  ) {}

  create(createLlmExaminationDto: CreateLlmExaminationDto) {
    return this.llmExaminationRepository.create(createLlmExaminationDto);
  }

  findAll() {
    return this.llmExaminationRepository.findAll();
  }

  findOne(id: number) {
    return this.llmExaminationRepository.findOne(id);
  }

  update(id: number, updateLlmExaminationDto: UpdateLlmExaminationDto) {
    return this.llmExaminationRepository.update(id, updateLlmExaminationDto);
  }

  remove(id: number) {
    return this.llmExaminationRepository.remove(id);
  }
}
