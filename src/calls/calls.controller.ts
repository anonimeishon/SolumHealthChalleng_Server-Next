import {
  Controller,
  Get,
  Param,
  Delete,
  Query,
  ParseBoolPipe,
  ParseDatePipe,
  ParseIntPipe,
  Post,
} from '@nestjs/common';
import { CallsService } from './calls.service';

@Controller('calls')
export class CallsController {
  constructor(private readonly callsService: CallsService) {}

  // @Post()
  // create(@Body() createCallDto: CreateCallDto) {
  //   return this.callsService.create(createCallDto);
  // }

  @Get()
  findAll(
    @Query('with-transcript', new ParseBoolPipe({ optional: true }))
    withTranscript: boolean,
    @Query('from', new ParseDatePipe({ optional: true })) from: Date, // Use the imported instance
    @Query('to', new ParseDatePipe({ optional: true })) to: Date, // Use the imported instance
    @Query('companyId', new ParseIntPipe({ optional: true })) companyId: number, // Use the imported instance
  ) {
    return this.callsService.findAll({ withTranscript, from, to, companyId });
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.callsService.findOne(+id);
  }

  // @Put(':id')
  // update(@Param('id') id: string, @Body() updateCallDto: UpdateCallDto) {
  //   return this.callsService.update(+id, updateCallDto);
  // }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.callsService.remove(+id);
  }

  @Post(':id/transcript')
  generateTranscript(@Param('id') id: string) {
    return this.callsService.generateTranscript(+id);
  }
}
