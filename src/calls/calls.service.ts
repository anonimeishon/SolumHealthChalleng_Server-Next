import {
  Injectable,
  NotFoundException,
  BadRequestException,
} from '@nestjs/common';
import { CallsRepository } from './calls.repository';
import { LlmEvaluationRepository } from '../data-ingestion/repositories/data-ingestion.repositories';
import * as jwt from 'jsonwebtoken';
// import { CreateCallDto } from './dto/create-call.dto'; // Example DTO
// import { UpdateCallDto } from './dto/update-call.dto'; // Example DTO

@Injectable()
export class CallsService {
  constructor(
    private readonly callsRepository: CallsRepository,
    private readonly llmEvaluationRepository: LlmEvaluationRepository,
  ) {}

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
      // Generate JWT token for authentication
      const secret = process.env.WEBHOOK_SECRET;
      if (!secret) {
        throw new BadRequestException('WEBHOOK_SECRET not configured');
      }

      const token = jwt.sign(
        {
          callData: call,
          iat: Math.floor(Date.now() / 1000),
          exp: Math.floor(Date.now() / 1000) + 300, // 5 minutes
        },
        secret,
        { algorithm: 'HS256' },
      );

      // Call external transcription webhook
      const webhookUrl =
        'https://smainero.app.n8n.cloud/webhook/8e2415d4-ffb0-4331-b438-6b07562ce5c4';

      const response = await fetch(webhookUrl, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify(call),
      });

      if (!response.ok) {
        throw new Error(
          `Webhook call failed: ${response.status} ${response.statusText}`,
        );
      }

      // Save the PENDING status to the database before returning
      await this.callsRepository.updateTranscriptionStatus(id, 'PENDING');

      return {
        message: 'Transcription job started successfully',
        status: 'PENDING',
      };
    } catch (error) {
      console.error('Transcription error:', error);
      // Set status to failed if not already set
      await this.callsRepository.updateTranscriptionStatus(id, 'FAILED');
      throw new BadRequestException('Failed to generate transcript');
    }
  }

  async handleTranscriptionWebhook(
    id: string,
    data: {
      aiReviewToParse: string;
      transcription: string;
      jobName?: string;
    },
  ) {
    try {
      // Extract call ID from job name (format: call-{id}-{timestamp})
      const callId = Number(id);

      // Parse the AI review JSON from the text
      let aiReview: { review: string; score: number } | null = null;

      try {
        // Extract JSON from the aiReviewToParse text
        const jsonMatch = data.aiReviewToParse.match(/```json\n(.*?)\n```/s);
        if (jsonMatch) {
          const jsonString = jsonMatch[1];
          aiReview = JSON.parse(jsonString);
        }
      } catch (parseError) {
        console.warn('Failed to parse AI review JSON:', parseError);
        // Continue without AI review if parsing fails
      }

      // Update the call with the transcription
      await this.callsRepository.updateTranscript(callId, data.transcription);

      // Create LLM evaluation if we successfully parsed the AI review
      if (aiReview) {
        await this.llmEvaluationRepository.create({
          call_id: callId,
          overall_score: aiReview.score,
          llm_summary: aiReview.review,
          feedback: data.aiReviewToParse, // Store the full text for reference
        });
      }

      return {
        message: 'Transcription updated successfully',
        callId,
        transcription: data.transcription,
        aiReview: aiReview,
        status: 'FINISHED',
      };
    } catch (error) {
      console.error('Webhook processing error:', error);
      throw new BadRequestException('Failed to process transcription webhook');
    }
  }
}
