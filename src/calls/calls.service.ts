import { Injectable } from '@nestjs/common';
import { CallsRepository } from './calls.repository';
// import { CreateCallDto } from './dto/create-call.dto'; // Example DTO
// import { UpdateCallDto } from './dto/update-call.dto'; // Example DTO

@Injectable()
export class CallsService {
  constructor(private readonly callsRepository: CallsRepository) {}

  // create(createCallDto: CreateCallDto) {
  //   return 'This action adds a new call';
  // }

  findAll(params: { withTranscript?: boolean; from?: Date; to?: Date }) {
    return this.callsRepository.findAll(params);
  }

  findOne(id: number) {
    return this.callsRepository.findOne(id);
  }

  // update(id: number, updateCallDto: UpdateCallDto) {
  //   return `This action updates a #${id} call`;
  // }

  remove(id: number) {
    return this.callsRepository.remove(id);
  }
}
