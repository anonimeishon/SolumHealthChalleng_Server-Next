-- AlterTable
ALTER TABLE "Call" ADD COLUMN     "customer_name" TEXT,
ADD COLUMN     "dob" TEXT,
ADD COLUMN     "insurance" TEXT;

-- AlterTable
ALTER TABLE "HumanEvaluation" ADD COLUMN     "status" TEXT;

-- AlterTable
ALTER TABLE "LlmEvaluation" ADD COLUMN     "call_type" TEXT,
ADD COLUMN     "call_type_confidence" DOUBLE PRECISION,
ADD COLUMN     "call_type_reasoning" TEXT,
ADD COLUMN     "feedback" TEXT,
ADD COLUMN     "outcome_confidence" DOUBLE PRECISION,
ADD COLUMN     "outcome_reasoning" TEXT,
ADD COLUMN     "protocol_confidence" DOUBLE PRECISION,
ADD COLUMN     "protocol_reasoning" TEXT,
ADD COLUMN     "sentiment_confidence" DOUBLE PRECISION,
ADD COLUMN     "sentiment_reasoning" TEXT,
ADD COLUMN     "vapi_score" DOUBLE PRECISION;
