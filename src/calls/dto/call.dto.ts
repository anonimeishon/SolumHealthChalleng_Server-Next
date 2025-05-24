// src/calls/dto/call.dto.ts
import {
  IsInt,
  IsString,
  IsDate,
  IsOptional,
  IsNotEmpty,
} from 'class-validator';

export class CallDto {
  @IsInt()
  @IsNotEmpty()
  id!: number;

  @IsString()
  @IsNotEmpty()
  external_id!: string;

  @IsInt()
  @IsNotEmpty()
  company_id!: number;

  @IsString()
  @IsOptional()
  transcript?: string;

  @IsInt()
  @IsNotEmpty()
  agent_id!: number;

  @IsDate()
  @IsNotEmpty()
  start_date!: Date;

  @IsDate()
  @IsNotEmpty()
  end_date!: Date;

  @IsInt()
  @IsNotEmpty()
  duration_seconds!: number;

  @IsString()
  @IsNotEmpty()
  recording_url!: string;

  @IsString()
  @IsOptional()
  customer_identifier?: string;

  @IsString()
  @IsOptional()
  call_type?: string;

  @IsString()
  @IsOptional()
  call_status?: string;

  @IsString()
  @IsOptional()
  reason_for_call?: string;

  @IsString()
  @IsOptional()
  department?: string;

  @IsString()
  @IsOptional()
  service_provided?: string;

  @IsString()
  @IsOptional()
  ended_reason?: string;

  @IsString()
  @IsOptional()
  customer_name?: string;

  @IsString()
  @IsOptional()
  insurance?: string;

  @IsString()
  @IsOptional()
  dob?: string;
}

// You might want to create separate DTOs for Create and Update operations
// For example, CreateCallDto might omit `id` and make other fields required.
// export class CreateCallDto { ... }
// export class UpdateCallDto { ... }
