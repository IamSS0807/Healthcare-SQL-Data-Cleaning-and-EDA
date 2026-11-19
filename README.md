# Healthcare Data Cleaning and Exploratory Data Analysis using SQL

## Project Overview

This project focuses on data exploration, data cleaning and exploratory data analysis (EDA) using MySQL.

The objective is to investigate a healthcare dataset, identify data quality issues, standardise inconsistent information, remove confirmed duplicate records and analyse the cleaned data to identify patterns and trends.

## Dataset

**Source:** [Healthcare Dataset – Kaggle](https://www.kaggle.com/datasets/prasad22/healthcare-dataset)

The dataset contains synthetic healthcare records, including:

- Patient demographics
- Medical conditions
- Hospital admission information
- Insurance providers
- Billing amounts
- Medication and test results

**Note:** The dataset is synthetic and does not represent real patients or actual hospital performance.

## Tools and Technologies

- MySQL
- MySQL Workbench
- SQL
- GitHub

## 1. Data Exploration

The original dataset was investigated to understand its structure and identify potential data quality issues.

Activities included:
- Inspecting records and table structure.
- Counting total records.
- Identifying distinct values.
- Investigating missing values.
- Examining age and billing ranges.

## 2. Data Cleaning

A separate working table was created to preserve the original dataset.

Cleaning activities included:
- Identifying exact duplicate records using `ROW_NUMBER()`.
- Removing confirmed duplicate records.
- Standardising patient name formatting.
- Cleaning inconsistent hospital name formatting.
- Standardising insurance provider names.
- Converting admission and discharge dates into DATE format.
- Validating the cleaned dataset.

## 3. Exploratory Data Analysis

The cleaned dataset was analysed to investigate:

- Admissions by medical condition.
- Admissions by gender.
- Average billing by medical condition.
- Admissions by insurance provider.
- Admissions by admission type.
- Monthly admission trends.
- Average length of stay.

## SQL Skills Demonstrated

- SELECT, WHERE and ORDER BY
- GROUP BY and HAVING
- Aggregate functions
- DISTINCT
- Common Table Expressions (CTEs)
- Window functions
- ROW_NUMBER()
- UPDATE and DELETE
- Date functions
- Data validation and cleaning

## Key Findings

Medical conditions: Arthritis was the most frequently recorded medical condition, while Asthma had the lowest count.

Demographics: Male and female records were almost equally distributed.

Admission patterns: Elective admissions were the most common admission type, followed closely by urgent and emergency admissions.

Billing analysis: Obesity had the highest average billing amount across the six medical conditions.

Insurance providers: Cigna had the highest number of records, while Aetna had the lowest.

## Conclusion

This project involved cleaning and analysing a healthcare dataset using MySQL. The process included identifying duplicate records, standardising inconsistent text values, correcting formatting issues and converting date columns into appropriate data types.

Exploratory Data Analysis was then performed to examine medical condition distributions, patient demographics, admission types, insurance providers, medication distributions, billing amounts and admission dates.

The analysis demonstrated practical applications of SQL for data exploration, data cleaning and extracting meaningful insights from structured datasets.

## Disclaimer

The dataset is synthetic and should not be interpreted as evidence of real-world healthcare outcomes.
