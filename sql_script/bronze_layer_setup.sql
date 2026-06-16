/**
 * DATABASE ENVIRONMENT SETUP
 * Project: End-to-End Lending Club Credit Risk Analytics
 * File: sql/bronze_layer_setup.sql
 * Layer: Bronze Layer (Raw Ingestion Table)
 * Description: Prepares the initial landing table for 2.26 million rows of raw financial data.
 * Safety Mode: Defensive DDL (Using IF NOT EXISTS to prevent accidental data destruction)
 */

CREATE DATABASE IF NOT EXISTS credit_risk_analytics;
USE credit_risk_analytics;

-- Create the Bronze Layer table schema with a synthetic primary key surrogate.
-- 'IF NOT EXISTS' ensures idempotency without dropping existing production data.
CREATE TABLE IF NOT EXISTS master_lending_club (
    -- Auto-incremented surrogate key to bypass missing 'id' values in the source CSV
    synthetic_id INT AUTO_INCREMENT PRIMARY KEY, 
    
    -- Original columns preserved as VARCHAR/TEXT to accommodate raw, uncleaned text data from source
    id VARCHAR(50),                              
    memberid VARCHAR(50),                        
    loan_amnt VARCHAR(50),
    funded_amnt VARCHAR(50),
    term VARCHAR(50),
    int_rate VARCHAR(50),
    installment VARCHAR(50),
    grade VARCHAR(10),
    sub_grade VARCHAR(10),
    emp_length VARCHAR(50),
    home_ownership VARCHAR(50),
    annual_inc VARCHAR(50),
    verification_status VARCHAR(100),
    issue_d VARCHAR(50),
    loan_status VARCHAR(100),
    purpose TEXT,
    addr_state VARCHAR(10),
    dti VARCHAR(50),
    out_prncp VARCHAR(50),
    recoveries VARCHAR(50)
);
