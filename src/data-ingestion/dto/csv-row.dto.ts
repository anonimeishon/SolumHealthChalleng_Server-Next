import { Type } from 'class-transformer';
import { ValidateNested, IsArray, IsString, IsOptional } from 'class-validator';

// This DTO represents the structure of a single row of data expected from the parsed CSV.
// All fields are optional to accommodate different CSV structures.
// Fields are mostly strings, as they would appear in a CSV, to be converted by the service.
export class CsvRowDto {
  // --- Common Identifiers ---
  @IsOptional()
  @IsString()
  call_id?: string; // Maps to Call.external_id

  @IsOptional()
  @IsString()
  assistant?: string; // Maps to Agent.external_id (from 'assistant' header)

  // --- Company & Agent Info (assuming these are provided or derived consistently) ---
  @IsOptional()
  @IsString()
  company_name?: string; // Maps to Company.name

  @IsOptional()
  @IsString()
  agent_name?: string; // Maps to Agent.name

  // --- Call Timestamps & Duration ---
  @IsOptional()
  @IsString()
  call_start_time?: string; // ISO 8601, maps to Call.start_date

  @IsOptional()
  @IsString()
  call_ended_time?: string; // ISO 8601, maps to Call.end_date

  @IsOptional()
  @IsString()
  duration?: string; // In seconds, maps to Call.duration_seconds

  @IsOptional()
  @IsString()
  date?: string; // DD/M/YYYY (Clinic A specific, for potential cross-reference)

  // --- Call Properties ---
  @IsOptional()
  @IsString()
  ended_reason?: string; // Maps to Call.call_status

  @IsOptional()
  @IsString()
  recording_url?: string; // Maps to Call.recording_url

  @IsOptional()
  @IsString()
  call_transcript?: string; // Maps to Call.transcript (if available)

  // --- Customer Information ---
  @IsOptional()
  @IsString()
  customer_phone?: string; // From Clinic A

  @IsOptional()
  @IsString()
  customer_phone_number?: string; // From Clinic B, C (alternative to customer_phone)

  @IsOptional()
  @IsString()
  customer_name?: string; // From Clinic B, maps to Call.customer_name

  @IsOptional()
  @IsString()
  customer_email?: string; // Maps to Call.customer_email (if available)

  @IsOptional()
  @IsString()
  customer_identifier?: string; // Maps to Call.customer_identifier (if available)

  @IsOptional()
  @IsString()
  insurance?: string; // Clinic B specific

  @IsOptional()
  @IsString()
  dob?: string; // Clinic B specific (Date of Birth)

  // --- Call Context & Type ---
  @IsOptional()
  @IsString()
  type?: string; // Clinic B specific (e.g., inboundPhoneCall), maps to Call.call_type

  @IsOptional()
  @IsString()
  call_type_value?: string; // Clinic A specific, maps to Call.call_type

  @IsOptional()
  @IsString()
  call_reason?: string; // Clinic B specific, maps to Call.reason_for_call

  @IsOptional()
  @IsString()
  call_status?: string; // Generic call status (if different from ended_reason)

  @IsOptional()
  @IsString()
  reason_for_call?: string; // Generic reason (if different from call_reason)

  @IsOptional()
  @IsString()
  department?: string; // Maps to Call.department (if available)

  @IsOptional()
  @IsString()
  service_provided?: string; // Maps to Call.service_provided (if available)

  // --- LLM Evaluation Specific (Primarily Clinic A) ---
  @IsOptional()
  @IsString()
  summary?: string; // General call summary, can be LLM.summary

  @IsOptional()
  @IsString()
  vapi_score?: string; // Clinic A, LLM overall score

  @IsOptional()
  @IsString()
  sentiment?: string; // Clinic A, LLM sentiment

  @IsOptional()
  @IsString()
  protocol_adherence?: string; // Clinic A, LLM protocol adherence

  @IsOptional()
  @IsString()
  llm_feedback?: string; // Clinic A ('llm_feedback' header)

  @IsOptional()
  @IsString()
  outcome?: string; // Clinic A, call outcome

  @IsOptional()
  @IsString()
  call_type_confidence?: string; // Clinic A

  @IsOptional()
  @IsString()
  call_type_reasoning?: string; // Clinic A

  @IsOptional()
  @IsString()
  sentiment_reasoning?: string; // Clinic A (JSON-like)

  @IsOptional()
  @IsString()
  sentiment_confidence?: string; // Clinic A

  @IsOptional()
  @IsString()
  protocol_reasoning?: string; // Clinic A ('protocol_reasoning' header, JSON-like)

  @IsOptional()
  @IsString()
  protocol_confidence?: string; // Clinic A

  @IsOptional()
  @IsString()
  outcome_reasoning?: string; // Clinic A

  @IsOptional()
  @IsString()
  outcome_confidence?: string; // Clinic A

  // --- Human Evaluation / QA ---
  @IsOptional()
  @IsString()
  evaluator_email?: string; // User.email

  @IsOptional()
  @IsString()
  evaluator_name?: string; // User.name (if email not present, or to supplement)

  @IsOptional()
  @IsString()
  evaluator_role?: string; // User.role

  @IsOptional()
  @IsString()
  Reviewer?: string; // Clinic B, C ('Reviewer' header)

  @IsOptional()
  @IsString()
  'Vapi QA Score'?: string; // Clinic B ('Vapi QA Score' header)

  @IsOptional()
  @IsString()
  evaluation?: string; // Clinic A ('evaluation' header)

  @IsOptional()
  @IsString()
  Evaluation?: string; // Clinic B, C ('Evaluation' header)

  @IsOptional()
  @IsString()
  'QA Check'?: string; // Clinic B, C ('QA Check' header)

  @IsOptional()
  @IsString()
  feedback?: string; // Clinic A general feedback

  @IsOptional()
  @IsString()
  'Feedback QA'?: string; // Clinic B, C ('Feedback QA' header)

  // Human Evaluation Metrics (generic names from original DTO, map from above QA fields if possible)
  @IsOptional()
  @IsString()
  human_eval_overall_score?: string;

  @IsOptional()
  @IsString()
  human_eval_politeness_score?: string;

  @IsOptional()
  @IsString()
  human_eval_resolution_status?: string; // e.g., from evaluation_status_string = "Pass"

  @IsOptional()
  @IsString()
  human_eval_accuracy_rating?: string;

  @IsOptional()
  @IsString()
  human_eval_clarity_score?: string;

  @IsOptional()
  @IsString()
  human_eval_empathy_score?: string;

  @IsOptional()
  @IsString()
  human_eval_adherence_to_script?: string;

  @IsOptional()
  @IsString()
  human_eval_problem_solved?: string;

  @IsOptional()
  @IsString()
  human_eval_overall_comment?: string;

  // --- LLM Evaluation Metrics (generic names from original DTO, map from Clinic A LLM fields) ---
  @IsOptional()
  @IsString()
  llm_eval_overall_score?: string;

  @IsOptional()
  @IsString()
  llm_eval_politeness_score?: string;

  @IsOptional()
  @IsString()
  llm_eval_resolution_status?: string;

  @IsOptional()
  @IsString()
  llm_eval_accuracy_rating?: string;

  @IsOptional()
  @IsString()
  llm_eval_clarity_score?: string;

  @IsOptional()
  @IsString()
  llm_eval_empathy_score?: string;

  @IsOptional()
  @IsString()
  llm_eval_adherence_to_script?: string;

  @IsOptional()
  @IsString()
  llm_eval_problem_solved?: string;

  @IsOptional()
  @IsString()
  llm_eval_summary?: string; // Maps to Evaluation.llm_summary

  @IsOptional()
  @IsString()
  llm_eval_sentiment?: string; // Maps to Evaluation.llm_sentiment

  @IsOptional()
  @IsString()
  human_eval_timestamp?: string; // For Evaluation.timestamp (HUMAN)

  @IsOptional()
  @IsString()
  llm_eval_timestamp?: string; // For Evaluation.timestamp (LLM)

  // --- Other / Status ---
  @IsOptional()
  @IsString()
  check?: string; // Clinic A (Boolean 'TRUE'/'FALSE')

  @IsOptional()
  @IsString()
  status_feedback_engineer?: string; // All clinics

  @IsOptional()
  @IsString()
  comments_engineer?: string; // All clinics
}

// This DTO will be used for the request body in the controller
export class IngestDataDto {
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => CsvRowDto)
  data!: CsvRowDto[]; // Added definite assignment assertion
}
