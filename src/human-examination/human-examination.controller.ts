import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { HumanExaminationService } from './human-examination.service';
import { UpdateHumanExaminationDto } from './dto/human-examination.dto';
import { Prisma } from '@prisma/client';

@Controller('human-examination')
export class HumanExaminationController {
  constructor(
    private readonly humanExaminationService: HumanExaminationService,
  ) {}

  @Post()
  create(
    @Body()
    createHumanExaminationDto: Prisma.HumanEvaluationUncheckedCreateInput,
  ) {
    return this.humanExaminationService.create(createHumanExaminationDto);
  }

  @Get()
  findAll() {
    return this.humanExaminationService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.humanExaminationService.findOne(+id);
  }

  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updateHumanExaminationDto: UpdateHumanExaminationDto,
  ) {
    return this.humanExaminationService.update(+id, updateHumanExaminationDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.humanExaminationService.remove(+id);
  }
}
