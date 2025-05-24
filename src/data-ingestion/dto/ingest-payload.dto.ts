import { CsvRowDto } from './csv-row.dto';
import { IsString, IsArray, ValidateNested, IsNotEmpty } from 'class-validator';
import { Type } from 'class-transformer';

export class IngestPayloadDto {
  @IsString()
  @IsNotEmpty()
  companyName!: string;

  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => CsvRowDto)
  rows!: CsvRowDto[];
}
