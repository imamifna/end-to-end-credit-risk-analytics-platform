# Data Dictionary (Silver Layer: fact_loan_analytics)

| Column Name | Data Type | Description | Primary/Surrogate Key |
| :--- | :--- | :--- | :--- |
| `loan_key` | `INT` | Internal data warehouse auto-incremented surrogate key. | Primary Key |
| `loan_id` | `VARCHAR(50)` | Unique loan identifier mapped directly from the Bronze layer's `synthetic_id`. | - |
| `customer_id` | `VARCHAR(50)` | Custom-formatted business identifier for individual borrowers (e.g., `CUST-000001`). | - |
| `loan_amount` | `DECIMAL(15,2)` | The listed amount of the loan applied for by the borrower. | - |
| `funded_amount` | `DECIMAL(15,2)` | The total amount committed to that loan by the institution at that point in time. | - |
| `term_months` | `INT` | The number of payments on the loan. Values are murni integers expressed in months (e.g., `36` or `60`). | - |
| `interest_rate` | `DECIMAL(5,2)` | Interest rate on the loan (expressed as percentage values). | - |
| `installment_amount` | `DECIMAL(15,2)` | The monthly payment owed by the borrower if the loan originates. | - |
| `credit_grade` | `VARCHAR(10)` | LC assigned loan macro-credit grade (`A` through `G`). | - |
| `credit_sub_grade` | `VARCHAR(10)` | LC assigned loan micro-credit subgrade (e.g., `A1`, `B3`, `C5`). | - |
| `employment_length_years` | `INT` | Employment length in years. Cleaned and parsed from string text to integers. | - |
| `home_ownership_status` | `VARCHAR(50)` | The home ownership status provided by the borrower during registration (`RENT`, `OWN`, `MORTGAGE`). | - |
| `annual_income` | `DECIMAL(15,2)` | The self-reported annual income provided by the borrower during co-registration. | - |
| `income_verification_status` | `VARCHAR(100)`| Indicates if the co-borrowers' income was verified by LC, not verified, or if the income source was verified. | - |
| `issue_date` | `DATE` | The month and year which the loan was funded. Standardized into SQL `YYYY-MM-DD` format. | - |
| `loan_status` | `VARCHAR(100)`| Current status of the loan (e.g., `Fully Paid`, `Current`, `Charged Off`, `Late`). | - |
| `loan_risk_category` | `VARCHAR(20)` | **Feature Engineered Column.** Classified risk profile: `Good Loan` (Performing) vs `Bad Loan` (Non-Performing). | - |
| `loan_purpose` | `TEXT` | A category provided by the borrower for the loan request (e.g., `debt_consolidation`, `credit_card`). | - |
| `borrower_state` | `VARCHAR(10)` | The state provided by the borrower in the loan application (2-letter US state code). | - |
| `debt_to_income_ratio` | `DECIMAL(5,2)` | A ratio calculated using the borrower’s total monthly debt payments divided by monthly income. | - |
| `outstanding_principal` | `DECIMAL(15,2)` | Remaining outstanding principal for total amount funded. | - |
| `recovered_amount` | `DECIMAL(15,2)` | Post charge-off gross recovery amount collected from non-performing portfolios. | - |
