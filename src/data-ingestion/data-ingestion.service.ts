/* eslint-disable @typescript-eslint/no-unused-vars */
import {
  Injectable,
  Logger,
  InternalServerErrorException,
  NotFoundException,
} from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CsvRowDto } from './dto/csv-row.dto';
import { Prisma } from '@prisma/client';
import {
  HumanEvaluationRepository,
  LlmEvaluationRepository,
} from './repositories/data-ingestion.repositories';

const GUEST_REVIEWER_NAME = 'Guest Reviewer';
const GUEST_REVIEWER_EMAIL = 'guest.reviewer@example.com';

@Injectable()
export class DataIngestionService {
  private readonly logger = new Logger(DataIngestionService.name);
  constructor(
    private readonly prisma: PrismaService,
    private readonly humanEvaluationRepository: HumanEvaluationRepository,
    private readonly llmEvaluationRepository: LlmEvaluationRepository,
  ) {}

  private parseOptionalFloat(value: string | undefined): number | null {
    if (value === undefined || value === null || value.trim() === '') {
      return null;
    }
    const parsed = parseFloat(value);
    return isNaN(parsed) ? null : parsed;
  }

  private parseOptionalBoolean(value: string | undefined): boolean | null {
    if (value === undefined || value === null || value.trim() === '') {
      return null;
    }
    const lowerValue = value.toLowerCase();
    if (lowerValue === 'true' || lowerValue === 'yes' || lowerValue === '1') {
      return true;
    }
    if (lowerValue === 'false' || lowerValue === 'no' || lowerValue === '0') {
      return false;
    }
    return null;
  }

  async processCsvRow(row: CsvRowDto, companyName: string): Promise<void> {
    this.logger.log(`Processing row for call ID: ${row.call_id}`);

    // Find or create Company
    let company = await this.prisma.company.findUnique({
      where: { name: companyName },
    });
    if (!company) {
      company = await this.prisma.company.create({
        data: { name: companyName },
      });
    }

    // Find or create Agent
    let agent: any = null;
    if (row.assistant) {
      agent = await this.prisma.agent.findFirst({
        where: { name: row.assistant },
      });
      if (!agent) {
        agent = await this.prisma.agent.create({
          data: {
            name: row.assistant,
            external_id: row.assistant,
            company_id: company.id, // Associate agent with the company
          },
        });
      }
    }

    // Find or create User (Evaluator)
    const reviewerNameInCsv = row['Reviewer']?.trim();
    let resolvedReviewerName: string;
    let resolvedReviewerEmail: string;

    if (!reviewerNameInCsv || reviewerNameInCsv === '') {
      resolvedReviewerName = GUEST_REVIEWER_NAME;
      resolvedReviewerEmail = GUEST_REVIEWER_EMAIL;
    } else {
      resolvedReviewerName = reviewerNameInCsv;
      resolvedReviewerEmail = `${resolvedReviewerName
        .replace(/\s+/g, '.')
        .toLowerCase()}@csv.example.com`;
    }

    let evaluator = await this.prisma.user.findFirst({
      where: {
        OR: [{ email: resolvedReviewerEmail }, { name: resolvedReviewerName }],
      },
    });

    if (!evaluator) {
      evaluator = await this.prisma.user.create({
        data: {
          name: resolvedReviewerName,
          email: resolvedReviewerEmail,
          role: 'QA_Agent',
        },
      });
      this.logger.log(
        `Created new user: ${resolvedReviewerName} (${resolvedReviewerEmail})`,
      );
    } else {
      this.logger.debug(
        `Found existing user: ${evaluator.name} (${evaluator.email})`,
      );
    }

    const callData: Prisma.CallUncheckedCreateInput = {
      external_id: row.call_id || '',
      company_id: company.id, // Associate call with the company
      agent_id: agent?.id, // Associate call with the agent, if agent exists
      start_date: row.call_start_time
        ? new Date(row.call_start_time)
        : new Date(),
      end_date: row.call_ended_time
        ? new Date(row.call_ended_time)
        : new Date(),
      duration_seconds: row.duration ? parseInt(row.duration, 10) : 0,
      recording_url: row.recording_url || 'N/A',
      ended_reason: row.ended_reason,
      customer_identifier: row.customer_phone || row.customer_phone_number,
      customer_name: row.customer_name,
      insurance: row.insurance,
      dob: row.dob,
      call_type: row.type,
      reason_for_call: row.call_reason,
    };

    const call = await this.prisma.call.upsert({
      where: { external_id: row.call_id },
      update: callData,
      create: callData,
    });
    this.logger.debug(
      `Upserted call ${call.id} (external: ${call.external_id})`,
    );

    const llmEvaluationData: Prisma.LlmEvaluationUncheckedCreateInput = {
      call_id: call.id,
      llm_summary: row.summary,
      vapi_score: this.parseOptionalFloat(
        row.vapi_score || row['Vapi QA Score'],
      ),
      llm_sentiment: row.sentiment || '',
      adherence_to_script: row.protocol_adherence
        ? parseFloat(row.protocol_adherence)
        : null,

      feedback: row.llm_feedback,
      problem_solved: this.parseOptionalBoolean(row.outcome || row.evaluation),
      call_type: row.call_type_value || row.type,
      call_type_confidence: this.parseOptionalFloat(row.call_type_confidence),
      call_type_reasoning: row.call_type_reasoning,
      sentiment_reasoning: row.sentiment_reasoning,
      sentiment_confidence: this.parseOptionalFloat(row.sentiment_confidence),
      protocol_reasoning: row.protocol_reasoning,
      protocol_confidence: this.parseOptionalFloat(row.protocol_confidence),
      outcome_reasoning: row.outcome_reasoning,
      outcome_confidence: this.parseOptionalFloat(row.outcome_confidence),
    };

    if (
      llmEvaluationData.llm_summary ||
      llmEvaluationData.vapi_score !== null
    ) {
      await this.llmEvaluationRepository.create(llmEvaluationData);
      this.logger.debug(`Created LlmEvaluation for call ${call.id}`);
    }

    const humanEvaluatorPresent =
      row.check ||
      row.evaluation ||
      row.feedback ||
      row['Reviewer'] ||
      row['QA Check'] ||
      row['Evaluation'] ||
      row['Feedback QA'] ||
      row.status_feedback_engineer ||
      row['Status Feedback Engineer'] ||
      row.comments_engineer ||
      row['Comments Engineer'];

    if (humanEvaluatorPresent) {
      const humanEvaluationData: Prisma.HumanEvaluationUncheckedCreateInput = {
        call_id: call.id,
        evaluator_id: evaluator.id,
        overall_comment:
          row.feedback ||
          row['Feedback QA'] ||
          row.comments_engineer ||
          row['Comments Engineer'] ||
          '',
        status:
          row.status_feedback_engineer ||
          row['Status Feedback Engineer'] ||
          row['QA Check'],
        problem_solved: this.parseOptionalBoolean(
          row.evaluation || row['Evaluation'],
        ),
        accuracy_rating: row.evaluation || row['Evaluation'],
      };
      await this.humanEvaluationRepository.create(humanEvaluationData);
      this.logger.debug(`Created HumanEvaluation for call ${call.id}`);
    }
  }

  async ingestData(rows: CsvRowDto[], companyName: string): Promise<any> {
    this.logger.log(`Starting ingestion for ${rows.length} rows`);
    let successfulIngestions = 0;
    let failedIngestions = 0;

    for (const row of rows) {
      try {
        await this.processCsvRow(row, companyName);
        successfulIngestions++;
      } catch (error: any) {
        failedIngestions++;
        this.logger.error(
          `Failed to process row for call ID: ${row.call_id || 'UNKNOWN'}`,
          error instanceof Error ? error.stack : String(error),
        );
      }
    }
    this.logger.log(
      `Ingestion complete. Successful: ${successfulIngestions}, Failed: ${failedIngestions}`,
    );

    const callCount = await this.prisma.call.count();
    const humanEvalCount = await this.prisma.humanEvaluation.count();
    const llmEvalCount = await this.prisma.llmEvaluation.count();

    return {
      message: `Ingestion complete. Successful: ${successfulIngestions}, Failed: ${failedIngestions}`,
      totals: {
        calls: callCount,
        humanEvaluations: humanEvalCount,
        llmEvaluations: llmEvalCount,
      },
    };
  }

  async deleteAllData(): Promise<void> {
    this.logger.warn(
      'Deleting all data from LlmEvaluation, HumanEvaluation, and Call tables',
    );
    await this.prisma.llmEvaluation.deleteMany({});
    await this.prisma.humanEvaluation.deleteMany({});
    // Consider if Agent and Company should be deleted if they are only created via CSVs
    // For now, only deleting evaluations and calls to allow re-ingestion without losing all setup.
    // await this.prisma.user.deleteMany({ where: { email: { endsWith: '@csv.example.com' } } }); // Example: delete only CSV-generated users
    // await this.prisma.user.deleteMany({ where: { email: GUEST_REVIEWER_EMAIL } }); // Example: delete guest user
    await this.prisma.call.deleteMany({});
    this.logger.log('All data deleted successfully.');
  }

  async getStatus(): Promise<any> {
    const callCount = await this.prisma.call.count();
    const humanEvalCount = await this.prisma.humanEvaluation.count();
    const llmEvalCount = await this.prisma.llmEvaluation.count();
    const companyCount = await this.prisma.company.count();
    const agentCount = await this.prisma.agent.count();
    const userCount = await this.prisma.user.count();

    return {
      message: 'Data ingestion service status',
      databaseCounts: {
        companies: companyCount,
        agents: agentCount,
        users: userCount,
        calls: callCount,
        humanEvaluations: humanEvalCount,
        llmEvaluations: llmEvalCount,
      },
      lastIngestionRun: null,
    };
  }
}
