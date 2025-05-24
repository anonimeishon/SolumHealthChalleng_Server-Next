-- CreateEnum
CREATE TYPE "TranscriptionStatus" AS ENUM ('NOT_STARTED', 'PENDING', 'FINISHED', 'FAILED');

-- AlterTable
ALTER TABLE "Call" ADD COLUMN     "transcription_status" "TranscriptionStatus" NOT NULL DEFAULT 'NOT_STARTED';
