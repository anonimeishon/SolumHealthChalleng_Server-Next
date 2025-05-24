/*
  Warnings:

  - You are about to drop the `Evaluation` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Evaluation" DROP CONSTRAINT "Evaluation_callId_fkey";

-- DropForeignKey
ALTER TABLE "Evaluation" DROP CONSTRAINT "Evaluation_evaluatorId_fkey";

-- DropTable
DROP TABLE "Evaluation";

-- CreateTable
CREATE TABLE "HumanEvaluation" (
    "id" SERIAL NOT NULL,
    "callId" INTEGER NOT NULL,
    "evaluatorId" INTEGER NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "overall_score" DOUBLE PRECISION,
    "politeness_score" INTEGER,
    "resolution_status" BOOLEAN,
    "accuracy_rating" TEXT,
    "clarity_score" INTEGER,
    "empathy_score" INTEGER,
    "adherence_to_script" BOOLEAN,
    "problem_solved" BOOLEAN,
    "overall_comment" TEXT,

    CONSTRAINT "HumanEvaluation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LlmEvaluation" (
    "id" SERIAL NOT NULL,
    "callId" INTEGER NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "overall_score" DOUBLE PRECISION,
    "politeness_score" INTEGER,
    "resolution_status" BOOLEAN,
    "accuracy_rating" TEXT,
    "clarity_score" INTEGER,
    "empathy_score" INTEGER,
    "adherence_to_script" BOOLEAN,
    "problem_solved" BOOLEAN,
    "llm_summary" TEXT,
    "llm_sentiment" TEXT,

    CONSTRAINT "LlmEvaluation_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "HumanEvaluation" ADD CONSTRAINT "HumanEvaluation_callId_fkey" FOREIGN KEY ("callId") REFERENCES "Call"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HumanEvaluation" ADD CONSTRAINT "HumanEvaluation_evaluatorId_fkey" FOREIGN KEY ("evaluatorId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LlmEvaluation" ADD CONSTRAINT "LlmEvaluation_callId_fkey" FOREIGN KEY ("callId") REFERENCES "Call"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
