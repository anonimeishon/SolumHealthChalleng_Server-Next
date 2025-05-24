/*
  Warnings:

  - The `adherence_to_script` column on the `LlmEvaluation` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- CreateEnum
CREATE TYPE "SentimentValue" AS ENUM ('very_positive', 'positive', 'neutral', 'negative', 'very_negative');

-- AlterTable
ALTER TABLE "LlmEvaluation" DROP COLUMN "adherence_to_script",
ADD COLUMN     "adherence_to_script" DOUBLE PRECISION;
