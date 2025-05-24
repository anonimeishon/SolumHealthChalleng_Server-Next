import {
  Injectable,
  NotFoundException,
  BadRequestException,
} from '@nestjs/common';
import {
  TranscribeClient,
  StartTranscriptionJobCommand,
} from '@aws-sdk/client-transcribe';
import { CallsRepository } from './calls.repository';
// import { CreateCallDto } from './dto/create-call.dto'; // Example DTO
// import { UpdateCallDto } from './dto/update-call.dto'; // Example DTO

@Injectable()
export class CallsService {
  private transcribeClient: TranscribeClient;

  constructor(private readonly callsRepository: CallsRepository) {
    this.transcribeClient = new TranscribeClient({
      region: process.env.AWS_REGION || 'us-east-1',
      credentials: {
        accessKeyId: process.env.AWS_ACCESS_KEY_ID || '',
        secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY || '',
      },
    });
  }

  // create(createCallDto: CreateCallDto) {
  //   return 'This action adds a new call';
  // }

  findAll(params: {
    withTranscript?: boolean;
    from?: Date;
    to?: Date;
    companyId?: number;
  }) {
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

  async generateTranscript(id: number) {
    // First, get the call to ensure it exists and has a recording URL
    const call = await this.callsRepository.findOne(id);
    if (!call) {
      throw new NotFoundException(`Call with ID ${id} not found`);
    }

    if (!call.recording_url) {
      throw new BadRequestException('Call does not have a recording URL');
    }

    if (call.transcript) {
      return {
        message: 'Transcript already exists',
        transcript: call.transcript,
        status: call.transcription_status,
      };
    }

    // Check if transcription is already in progress
    if (call.transcription_status === 'PENDING') {
      return {
        message: 'Transcription is already in progress',
        status: call.transcription_status,
      };
    }

    try {
      // Generate a unique job name
      const jobName = `call-${id}-${Date.now()}`;

      // Start transcription job
      const startCommand = new StartTranscriptionJobCommand({
        TranscriptionJobName: jobName,
        Media: {
          MediaFileUri: call.recording_url,
        },
        MediaFormat: 'mp3', // Adjust based on your audio format
        LanguageCode: 'en-US',
        OutputBucketName: process.env.AWS_TRANSCRIBE_OUTPUT_BUCKET,
      });

      await this.transcribeClient.send(startCommand);

      // Save the PENDING status to the database before returning
      await this.callsRepository.updateTranscriptionStatus(id, 'PENDING');

      return {
        message: 'Transcription job started successfully',
        jobName,
        status: 'PENDING',
      };
    } catch (error) {
      console.error('Transcription error:', error);
      // Set status to failed if not already set
      await this.callsRepository.updateTranscriptionStatus(id, 'FAILED');
      throw new BadRequestException('Failed to generate transcript');
    }
  }
}
