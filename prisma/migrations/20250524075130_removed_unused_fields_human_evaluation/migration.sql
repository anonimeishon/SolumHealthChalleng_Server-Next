/*
  Warnings:

  - You are about to drop the column `accuracy_rating` on the `HumanEvaluation` table. All the data in the column will be lost.
  - You are about to drop the column `adherence_to_script` on the `HumanEvaluation` table. All the data in the column will be lost.
  - You are about to drop the column `clarity_score` on the `HumanEvaluation` table. All the data in the column will be lost.
  - You are about to drop the column `empathy_score` on the `HumanEvaluation` table. All the data in the column will be lost.
  - You are about to drop the column `politeness_score` on the `HumanEvaluation` table. All the data in the column will be lost.
  - You are about to drop the column `status` on the `HumanEvaluation` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "HumanEvaluation" DROP COLUMN "accuracy_rating",
DROP COLUMN "adherence_to_script",
DROP COLUMN "clarity_score",
DROP COLUMN "empathy_score",
DROP COLUMN "politeness_score",
DROP COLUMN "status";
