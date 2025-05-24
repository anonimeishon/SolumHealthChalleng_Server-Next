import { PartialType } from '@nestjs/mapped-types';
import {
  IsInt,
  IsOptional,
  IsString,
  IsNumber,
  IsBoolean,
  IsDate,
} from 'class-validator';

export class CreateHumanExaminationDto {
  @IsInt()
  callId!: number;

  @IsInt()
  evaluatorId!: number;

  @IsDate()
  @IsOptional()
  timestamp?: Date;

  @IsNumber()
  @IsOptional()
  overallScore?: number; // Prisma schema uses Float, which maps to number in TS

  // @IsInt()
  // @IsOptional()
  // politenessScore?: number;

  @IsBoolean()
  @IsOptional()
  resolutionStatus?: boolean;

  // @IsString()
  // @IsOptional()
  // accuracyRating?: string;

  // @IsInt()
  // @IsOptional()
  // clarityScore?: number;

  // @IsInt()
  // @IsOptional()
  // empathyScore?: number;

  // @IsBoolean()
  // @IsOptional()
  // adherenceToScript?: boolean;

  @IsBoolean()
  @IsOptional()
  problemSolved?: boolean;

  @IsString()
  @IsOptional()
  overallComment?: string;

  // @IsString()
  // @IsOptional()
  // status?: string;
}

export class UpdateHumanExaminationDto extends PartialType(
  CreateHumanExaminationDto,
) {}
