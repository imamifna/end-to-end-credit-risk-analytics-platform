/**
 * DATA PROFILING & QUALITY AUDIT
 * Project: End-to-End Lending Club Credit Risk Analytics
 * File: sql/data_profiling.sql
 * Layer: Testing & Quality Assurance Layer
 * Description: Runs structural audits on raw data to detect data leaks, null rates, 
 * and check categorical distributions before transformation.
 */

USE credit_risk_analytics;

-- Query 1: Detect Data Leakage (NULL Rate & Empty String Analysis)
SELECT 
    COUNT(*) AS total_records,
    SUM(CASE WHEN annual_inc IS NULL OR TRIM(annual_inc) = '' THEN 1 ELSE 0 END) AS null_annual_inc,
    SUM(CASE WHEN loan_status IS NULL OR TRIM(loan_status) = '' THEN 1 ELSE 0 END) AS null_loan_status
FROM master_lending_club;

-- Query 2: Audit Target Categorical Values (Loan Status Unique Values Distribution)
SELECT 
    loan_status, 
    COUNT(*) AS total_nasabah
FROM master_lending_club
GROUP BY loan_status
ORDER BY total_nasabah DESC;
