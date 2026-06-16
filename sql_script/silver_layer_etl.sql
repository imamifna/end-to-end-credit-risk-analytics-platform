/**
 * DATA TRANSFORMATION & ETL PIPELINE
 * Project: End-to-End Lending Club Credit Risk Analytics
 * File: sql/silver_layer_etl.sql
 * Layer: Silver Layer (Cleaned, Formatted, and Modeled Data)
 * Target Table: fact_loan_analytics
 * Description: Implements strict data sanitization, type-casting, string parsing, 
 * and business logic injection via robust MySQL functions.
 */

USE credit_risk_analytics;

-- Step 1: Create the Silver Layer Fact Table Schema (Analytical Data Model)
CREATE TABLE IF NOT EXISTS fact_loan_analytics (
    loan_key INT AUTO_INCREMENT PRIMARY KEY, -- Internal data warehouse surrogate key
    loan_id VARCHAR(50),                     -- Mapped from Bronze synthetic_id
    customer_id VARCHAR(50),                 -- Custom business format (CUST-000000)
    loan_amount DECIMAL(15,2),               -- Sanitized metric converted to decimal
    funded_amount DECIMAL(15,2),
    term_months INT,                         -- Parsed string integer (e.g., '36 months' -> 36)
    interest_rate DECIMAL(5,2),
    installment_amount DECIMAL(15,2),
    credit_grade VARCHAR(10),
    credit_sub_grade VARCHAR(10),
    employment_length_years INT,             -- Parsed employment duration integer
    home_ownership_status VARCHAR(50),
    annual_income DECIMAL(15,2),
    income_verification_status VARCHAR(100),
    issue_date DATE,                         -- Standardized date formatting (YYYY-MM-DD)
    loan_status VARCHAR(100),
    loan_risk_category VARCHAR(20),          -- Business feature engineering (Good/Bad Loan)
    loan_purpose TEXT,
    borrower_state VARCHAR(10),
    debt_to_income_ratio DECIMAL(5,2),
    outstanding_principal DECIMAL(15,2),
    recovered_amount DECIMAL(15,2)
);

-- Step 2: Execute Robust ETL Migration Script (Bronze to Silver)
INSERT INTO fact_loan_analytics (
    loan_id, customer_id, loan_amount, funded_amount, term_months, 
    interest_rate, installment_amount, credit_grade, credit_sub_grade, 
    employment_length_years, home_ownership_status, annual_income, 
    income_verification_status, issue_date, loan_status, loan_risk_category, 
    loan_purpose, borrower_state, debt_to_income_ratio, outstanding_principal, 
    recovered_amount
)
SELECT 
    synthetic_id AS loan_id,
    CONCAT('CUST-', LPAD(synthetic_id, 6, '0')) AS customer_id,
    
    -- Numerical Data Sanitization: Converts empty strings into proper NULLs before casting
    CAST(NULLIF(TRIM(loan_amnt), '') AS DECIMAL(15,2)) AS loan_amount,
    CAST(NULLIF(TRIM(funded_amnt), '') AS DECIMAL(15,2)) AS funded_amount,
    
    -- Regular Expression Parsing: Extracts numerical values from text-based loan terms
    CASE 
        WHEN NULLIF(TRIM(term), '') IS NULL THEN NULL
        ELSE CAST(REGEXP_REPLACE(term, '[^0-9]', '') AS UNSIGNED)
    END AS term_months,
    
    CAST(NULLIF(TRIM(int_rate), '') AS DECIMAL(5,2)) AS interest_rate,
    CAST(NULLIF(TRIM(installment), '') AS DECIMAL(15,2)) AS installment_amount,
    
    NULLIF(TRIM(grade), '') AS credit_grade,
    NULLIF(TRIM(sub_grade), '') AS credit_sub_grade,
    
    -- Strict Validation: Parses employment length text and prevents Data Truncation Error [1292]
    CASE 
        WHEN NULLIF(TRIM(emp_length), '') IS NULL THEN NULL
        WHEN REGEXP_REPLACE(emp_length, '[^0-9]', '') = '' THEN NULL
        ELSE CAST(REGEXP_REPLACE(emp_length, '[^0-9]', '') AS UNSIGNED)
    END AS employment_length_years,
    
    NULLIF(TRIM(home_ownership), '') AS home_ownership_status,
    CAST(NULLIF(TRIM(annual_inc), '') AS DECIMAL(15,2)) AS annual_income,
    NULLIF(TRIM(verification_status), '') AS income_verification_status,
    
    -- Date Standardization: Parses text 'MMM-YYYY' format into a proper SQL standard DATE type
    CASE 
        WHEN NULLIF(TRIM(issue_d), '') IS NULL THEN NULL
        ELSE STR_TO_DATE(CONCAT('01-', TRIM(issue_d)), '%d-%b-%Y')
    END AS issue_date,
    
    NULLIF(TRIM(loan_status), '') AS loan_status,
    
    -- Credit Risk Feature Engineering: Implements conditional categorizations for risk modeling
    CASE 
        WHEN TRIM(loan_status) IN ('Fully Paid', 'Current', 'Does not meet the credit policy. Status:Fully Paid') THEN 'Good Loan'
        ELSE 'Bad Loan'
    END AS loan_risk_category,
    
    purpose AS loan_purpose,
    NULLIF(TRIM(addr_state), '') AS borrower_state,
    CAST(NULLIF(TRIM(dti), '') AS DECIMAL(5,2)) AS debt_to_income_ratio,
    CAST(NULLIF(TRIM(out_prncp), '') AS DECIMAL(15,2)) AS outstanding_principal,
    CAST(NULLIF(TRIM(recoveries), '') AS DECIMAL(15,2)) AS recovered_amount
FROM master_lending_club
-- Data Filtering Layer: Excludes records with critical missing income attributes
WHERE annual_inc IS NOT NULL AND TRIM(annual_inc) != '';

-- Step 3: Data Ingestion Verification (Smoke Test)
SELECT loan_id, customer_id, loan_amount, loan_risk_category, issue_date 
FROM fact_loan_analytics 
LIMIT 5;

-- Step 4: Analytical Data Validation & Business Metrics Verification
SELECT 
    loan_risk_category,
    COUNT(*) AS total_nasabah,
    FORMAT(AVG(annual_income), 2) AS rata_rata_pendapatan,
    FORMAT(SUM(loan_amount), 2) AS total_kucuran_dana
FROM fact_loan_analytics
GROUP BY loan_risk_category;

-- Step 5: Final Dataset Extraction for Business Intelligence Tools (Power BI / Tableau)
SELECT * FROM credit_risk_analytics.fact_loan_analytics;
