/*
  Warnings:

  - You are about to drop the `Company` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
DROP TABLE "Company";

-- CreateTable
CREATE TABLE "companies" (
    "id_company" TEXT NOT NULL,
    "trading_name" TEXT NOT NULL,
    "legal_name" TEXT NOT NULL,
    "tax_id" TEXT NOT NULL,
    "company_email" TEXT NOT NULL,
    "company_phone" TEXT NOT NULL,
    "industry" TEXT NOT NULL,
    "segment" TEXT NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "companies_pkey" PRIMARY KEY ("id_company")
);

-- CreateIndex
CREATE UNIQUE INDEX "companies_trading_name_key" ON "companies"("trading_name");

-- CreateIndex
CREATE UNIQUE INDEX "companies_tax_id_key" ON "companies"("tax_id");
