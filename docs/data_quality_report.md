# Data Quality Assessment Report

## Dataset Overview

Source:
Lending Club Loan Dataset

Records Processed:
2,260,668

Project Environment:
MySQL + Power BI

---

## Data Quality Audit Summary

Prior to transformation, a comprehensive data audit was performed on the raw dataset.

The objective was to identify structural issues that could impact data integrity, reporting accuracy, and analytical outcomes.

---

## Issue 1: Missing Loan Identifiers

### Problem

The source dataset contained missing values within key identifier fields.

Affected Columns:

* id
* member_id

### Risk

Missing identifiers can:

* Break record traceability
* Prevent reliable joins
* Create duplicate tracking issues

### Resolution

Implemented a surrogate key strategy:

```sql
synthetic_id AUTO_INCREMENT
```

Result:

Every record received a unique system-generated identifier.

---

## Issue 2: Missing Income Records

### Problem

Several records contained blank annual income values.

Affected Column:

```text
annual_inc
```

Records Impacted:

4 rows

### Risk

Income is a critical variable used in credit risk assessment.

Missing values would distort portfolio analysis.

### Resolution

Records with missing income values were excluded during ETL processing.

---

## Issue 3: Text-Based Numerical Fields

### Problem

Multiple numeric fields were stored as text.

Examples:

* loan_amnt
* funded_amnt
* installment
* int_rate
* dti

### Risk

Aggregation and analytical calculations could fail or produce inaccurate results.

### Resolution

Applied:

* TRIM()
* NULLIF()
* CAST()

to convert raw strings into valid numerical data types.

---

## Issue 4: Date Standardization

### Problem

Loan issue dates were stored in non-standard formats.

Example:

```text
Dec-2018
```

### Risk

Time intelligence calculations would not function correctly.

### Resolution

Converted dates using:

```sql
STR_TO_DATE()
```

Result:

All dates transformed into SQL DATE format.

---

## Issue 5: Employment Length Parsing

### Problem

Employment duration was stored as text.

Examples:

```text
10+ years
< 1 year
5 years
```

### Resolution

Implemented regular expression parsing:

```sql
REGEXP_REPLACE()
```

to extract numerical values and create a standardized employment length field.

---

## Final Validation Results

| Metric                         | Result     |
| ------------------------------ | ---------- |
| Raw Records                    | 2,260,668  |
| Missing Income Records Removed | 4          |
| Surrogate Keys Generated       | 2,260,668  |
| Analytics Ready Dataset        | Successful |
| Data Validation Status         | Passed     |

---

## Conclusion

The ETL process successfully transformed a large-scale raw financial dataset into a clean and analytics-ready model suitable for reporting, dashboarding, and risk analysis.
