# End-to-End Lending Club Credit Risk Analytics Platform

## Executive Summary

Built an end-to-end Credit Risk Analytics Platform using a large-scale Lending Club financial dataset containing over **2.26 million loan records**.

The project demonstrates the complete analytics lifecycle, including:

* Raw data ingestion
* Data quality auditing
* ETL pipeline development
* Data modeling
* Business rule implementation
* Credit risk segmentation
* Executive reporting in Power BI

The final solution leverages a modern **Medallion Architecture (Bronze → Silver)**, processes over **2.26 million records**, and delivers a Power BI analytics layer powered by **61 DAX measures** for portfolio intelligence and risk monitoring.

---

## Project Highlights

### Large-Scale Financial Data Processing

* Processed **2,260,668 loan records**
* Built analytics-ready datasets from raw Lending Club loan data
* Developed a scalable SQL ETL workflow

### Data Quality Recovery

Raw source files contained critical data quality issues:

* Missing loan identifiers
* Missing member identifiers
* Empty numeric values
* Inconsistent date formats

To overcome this, a custom surrogate key architecture was implemented using:

```sql
synthetic_id AUTO_INCREMENT
```

ensuring reliable record tracking and future scalability.

### Modern Medallion Architecture

The project separates data into isolated analytical layers:

#### Bronze Layer

Raw CSV ingestion

#### Silver Layer

Cleaned, standardized, analytics-ready data

This architecture improves maintainability, traceability, and analytical reliability.

---

## Business Problem

Financial institutions need to continuously monitor portfolio quality and identify factors that contribute to loan defaults.

Key questions addressed:

* What proportion of the portfolio is considered high risk?
* Which borrower segments contribute most to default exposure?
* How do income, credit grade, and borrower characteristics impact repayment behavior?
* Which states and loan purposes generate the highest bad loan exposure?

---

## Solution Architecture

```mermaid
flowchart LR

A[Raw CSV File<br>2.26M Records]

--> B[Bronze Layer<br>master_lending_club]

--> C[SQL Data Profiling<br>Data Audit]

--> D[Silver Layer<br>fact_loan_analytics]

--> E[Star Schema Model]

--> F[Power BI Dashboard]

--> G[Executive Portfolio Intelligence]
```

---

## Technology Stack

### Data Engineering

* MySQL
* DBeaver
* SQL ETL Development

### Business Intelligence

* Power BI
* DAX
* Star Schema Modeling

### Dataset

* Lending Club Loan Dataset
* Source: Kaggle
* Historical Period: 2007–2018

Dataset Size:

* 2,260,668 Records
* 20 Selected Financial Features
* 95.5 MB Power BI Model

---

## Data Engineering Workflow

### Bronze Layer Setup

Raw data ingestion table:

```sql
master_lending_club
```

Key design decisions:

* Defensive DDL using IF NOT EXISTS
* All columns stored as VARCHAR/TEXT
* Prevent ingestion failures
* Preserve raw source integrity

Only the 20 highest-value financial fields were selected from the original dataset to improve processing efficiency.

---

### Data Profiling & Audit

Before transformation, a comprehensive audit was performed.

Findings:

| Audit Item                    | Result                |
| ----------------------------- | --------------------- |
| Total Records                 | 2,260,668             |
| Missing Income Records        | 4                     |
| Credit Status Categories      | Multiple Risk Classes |
| Missing IDs                   | Present               |
| Date Standardization Required | Yes                   |

---

### Silver Layer ETL

Final analytical table:

```sql
fact_loan_analytics
```

Total Fields:

22 Columns

Transformations performed:

### Data Sanitization

* TRIM()
* NULLIF()
* CAST()

### String Parsing

* REGEXP_REPLACE()

### Date Standardization

* STR_TO_DATE()

### Risk Classification

Automatically categorized borrowers into:

#### Good Loan

* Fully Paid
* Current
* Does not meet credit policy - Fully Paid

#### Bad Loan

* Charged Off
* Default
* Late
* Other Delinquent Statuses

### Customer ID Engineering

Generated business-friendly identifiers:

```text
CUST-000001
CUST-000002
CUST-000003
```

---

## Data Model

Star Schema Architecture

### Fact Table

```text
fact_loan_analytics
```

### Dimension Tables

```text
DimDate
DimState
```

### Measure Table

```text
_Key Metrics
```

The semantic model contains:

* 61 DAX Measures
* Time Intelligence Metrics
* YoY Growth Analysis
* Portfolio Risk Metrics

---

## Power BI Dashboard

### Executive Commercial Performance

Provides executive-level visibility into:

* Total Funded Amount
* Total Customers
* Interest Rate Trends
* NPL Ratio
* Funding Growth

---

### Portfolio Quality

Analyzes:

* Good Loan vs Bad Loan
* Recovery Rate
* Bad Loan Exposure
* Geographic Risk Distribution

---

### Underwriting Insights

Explores:

* Credit Grade Risk
* Income Band Analysis
* Income Verification Impact
* Home Ownership Risk
* Debt-to-Income Performance

---

## Portfolio Validation Results

### Loan Risk Segmentation

| Risk Category | Borrowers | Average Income | Total Funded Amount |
| ------------- | --------: | -------------: | ------------------: |
| Good Loan     | 1,963,631 |     $79,017.32 |             $29.35B |
| Bad Loan      |   297,033 |     $71,217.03 |              $4.66B |

---

## Key Business Insights

### Insight 1

Borrowers classified as Bad Loan exhibit lower average annual income than Good Loan borrowers.

### Insight 2

Default rates increase significantly as credit quality deteriorates from Grade A to Grade G.

### Insight 3

Debt Consolidation loans contribute the largest share of bad loan exposure.

### Insight 4

Renters demonstrate higher default risk than mortgage holders.

### Insight 5

Lower income bands consistently exhibit higher default rates.

---

## Business Recommendations

### Strengthen Credit Approval Rules

Introduce stricter underwriting requirements for high-risk credit grades.

### Enhance Income-Based Risk Assessment

Use annual income as a stronger factor in credit scoring models.

### Monitor High-Risk Loan Purposes

Increase monitoring for debt consolidation and other high-risk loan categories.

### Geographic Risk Surveillance

Apply additional controls in states with elevated bad loan exposure.

---

## Project Outcomes

This project demonstrates capabilities across:

### Data Engineering

* ETL Development
* Data Quality Management
* Data Modeling
* SQL Optimization

### Business Intelligence

* Dashboard Development
* KPI Design
* DAX Development
* Executive Reporting

### Financial Analytics

* Credit Risk Analysis
* Portfolio Intelligence
* Underwriting Analytics
* Lending Performance Monitoring

---

## Author

Aspiring Data Analyst | Business Intelligence Analyst

Focused on transforming large-scale financial data into actionable business insights through SQL, Power BI, and modern analytics engineering practices.
