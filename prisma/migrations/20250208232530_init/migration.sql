-- CreateTable
CREATE TABLE "Company" (
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

    CONSTRAINT "Company_pkey" PRIMARY KEY ("id_company")
);

-- CreateIndex
CREATE UNIQUE INDEX "Company_trading_name_key" ON "Company"("trading_name");

-- CreateIndex
CREATE UNIQUE INDEX "Company_tax_id_key" ON "Company"("tax_id");
