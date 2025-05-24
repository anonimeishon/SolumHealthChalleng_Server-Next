import { PartialType } from '@nestjs/mapped-types';

export class CreateLlmExaminationDto {
  // Define properties for creating an LLM examination
  // Example:
  // readonly callId: number;
  // readonly report: string;
  // readonly score: number;
}

export class UpdateLlmExaminationDto extends PartialType(
  CreateLlmExaminationDto,
) {}
