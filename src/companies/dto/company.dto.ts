import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsString, IsNotEmpty, IsOptional, IsInt } from 'class-validator';

export class CreateCompanyDto {
  @ApiProperty({
    description: 'The name of the company',
    example: 'Clinic A',
  })
  @IsString()
  @IsNotEmpty()
  name!: string;
}

export class UpdateCompanyDto {
  @ApiPropertyOptional({
    description: 'The name of the company',
    example: 'Clinic A Updated',
  })
  @IsString()
  @IsOptional()
  name?: string;
}

export class CompanyDto {
  @ApiProperty({
    description: 'The unique identifier of the company',
    example: 1,
  })
  @IsInt()
  id!: number;

  @ApiProperty({
    description: 'The name of the company',
    example: 'Clinic A',
  })
  @IsString()
  name!: string;

  @ApiPropertyOptional({
    description: 'Number of agents in this company',
    example: 5,
  })
  agentCount?: number;

  @ApiPropertyOptional({
    description: 'Number of calls for this company',
    example: 150,
  })
  callCount?: number;
}
