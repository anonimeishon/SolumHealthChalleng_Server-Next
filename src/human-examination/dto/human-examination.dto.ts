import { PartialType } from '@nestjs/mapped-types';

export class CreateHumanExaminationDto {
  // Define properties for creating a Human examination
  // Example:
  // readonly callId: number;
  // readonly report: string;
  // readonly score: number;
}

export class UpdateHumanExaminationDto extends PartialType(
  CreateHumanExaminationDto,
) {}
