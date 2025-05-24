import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { LlmExaminationService } from './llm-examination.service';
import { CreateLlmExaminationDto } from './dto/llm-examination.dto';
import { UpdateLlmExaminationDto } from './dto/llm-examination.dto';

@Controller('llm-examination')
export class LlmExaminationController {
  constructor(private readonly llmExaminationService: LlmExaminationService) {}

  @Post()
  create(@Body() createLlmExaminationDto: CreateLlmExaminationDto) {
    return this.llmExaminationService.create(createLlmExaminationDto);
  }

  @Get()
  findAll() {
    return this.llmExaminationService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.llmExaminationService.findOne(+id);
  }

  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updateLlmExaminationDto: UpdateLlmExaminationDto,
  ) {
    return this.llmExaminationService.update(+id, updateLlmExaminationDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.llmExaminationService.remove(+id);
  }
}
