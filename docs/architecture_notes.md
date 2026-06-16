# Architecture Notes

## Solution Architecture Overview

The project follows a simplified Medallion Architecture design pattern consisting of two data layers:

### Bronze Layer

Raw Data Storage

### Silver Layer

Cleaned and Analytics-Ready Data

The architecture ensures data integrity, auditability, and analytical consistency.

---

## Architecture Flow

```text
Raw CSV File
        │
        ▼
Bronze Layer
(master_lending_club)
        │
        ▼
Data Profiling
&
Quality Audit
        │
        ▼
SQL ETL Pipeline
        │
        ▼
Silver Layer
(fact_loan_analytics)
        │
        ▼
Star Schema Model
        │
        ▼
Power BI Semantic Layer
        │
        ▼
Executive Dashboard
```

---

## Bronze Layer

Table:

```text
master_lending_club
```

Purpose:

* Preserve source data
* Prevent data loss
* Enable auditability
* Support future reprocessing

Characteristics:

* Raw ingestion layer
* VARCHAR/TEXT dominant schema
* Minimal transformation

---

## Silver Layer

Table:

```text
fact_loan_analytics
```

Purpose:

* Clean and standardized dataset
* Business-ready analytics layer
* Power BI integration

Characteristics:

* Typed columns
* Standardized dates
* Feature engineered attributes
* Credit risk classifications

---

## Business Logic Layer

The ETL pipeline introduces additional business logic:

### Customer Identifier Generation

```text
CUST-000001
```

### Loan Risk Classification

Good Loan:

* Fully Paid
* Current
* Does not meet credit policy (Fully Paid)

Bad Loan:

* Charged Off
* Default
* Late Statuses

---

## Power BI Layer

Semantic Model Components:

### Fact Table

```text
fact_loan_analytics
```

### Dimension Tables

```text
DimDate
DimState
```

### Measure Layer

```text
_Key Metrics
```

Features:

* 61 DAX Measures
* Portfolio Intelligence KPIs
* Risk Monitoring Metrics
* Time Intelligence Analysis

---

## Scalability Considerations

The architecture successfully supports:

* 2.26 Million Records
* Large-scale aggregations
* Financial KPI reporting
* Executive dashboard consumption

The design can be extended into a full Bronze → Silver → Gold architecture for enterprise-scale analytics environments.
