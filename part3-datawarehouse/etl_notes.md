## ETL Decisions

### Decision 1 — Fixing Date Format
Problem: The date column had different formats like dd/mm/yyyy, dd-mm-yyyy, and yyyy-mm-dd.
Resolution: I converted all dates into one standard format (YYYY-MM-DD) using STR_TO_DATE() and CASE statements. This made the data consistent.

### Decision 2 — Handling Missing Values
Problem:
Some columns like store name and city had NULL (missing) values.

Resolution:
I replaced NULL values with 'Unknown' using the COALESCE() function so that no data is lost and joins work properly.

### Decision 3 — Fixing Category Values

Problem:
The category column had inconsistent values like Electronics, electronics, and ELECTRONICS.

Resolution:
I converted all category values to lowercase using LOWER() to make them consistent for analysis.