/* ==========================================
   RETAIL SALES ANALYSIS PROJECT
   Author: Ahmed Akeeb A.
   ========================================== */

/* ==========================================
   DATABASE CREATION
   ========================================== */

CREATE DATABASE retail_sales_project;
USE retail_sales_project;


/* ==========================================
   DATA EXPLORATION
   ========================================== */

-- Total records in dataset
SELECT COUNT(*) AS total_records
FROM retail_sales_datasets;

-- Check unique customers
SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales_datasets;

-- View available categories
SELECT DISTINCT category
FROM retail_sales_datasets;

-- Preview first 10 rows
SELECT *
FROM retail_sales_datasets
LIMIT 10;


/* ==========================================
   DATA CLEANING
   ========================================== */

-- Rename incorrect column names
ALTER TABLE retail_sales_datasets
RENAME COLUMN quantiy TO quantity;

ALTER TABLE retail_sales_datasets
RENAME COLUMN ï»¿transactions_id TO transactions_id;

-- Check for missing values
SELECT *
FROM retail_sales_datasets
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

-- Convert columns to proper data types
ALTER TABLE retail_sales_datasets
MODIFY COLUMN sale_date DATE;

ALTER TABLE retail_sales_datasets
MODIFY COLUMN sale_time TIME;

ALTER TABLE retail_sales_datasets
MODIFY COLUMN gender VARCHAR(10);

ALTER TABLE retail_sales_datasets
MODIFY COLUMN category VARCHAR(50);


/* ==========================================
   DATA VALIDATION
   ========================================== */

-- Check duplicate transaction IDs
SELECT transactions_id,
       COUNT(*) AS duplicate_count
FROM retail_sales_datasets
GROUP BY transactions_id
HAVING COUNT(*) > 1;

-- Check null transaction IDs
SELECT *
FROM retail_sales_datasets
WHERE transactions_id IS NULL;

-- Set transaction ID as primary key
ALTER TABLE retail_sales_datasets
MODIFY COLUMN transactions_id INT NOT NULL;

ALTER TABLE retail_sales_datasets
ADD PRIMARY KEY (transactions_id);

-- Confirm table structure
DESCRIBE retail_sales_datasets;


/* ==========================================
   BUSINESS ANALYSIS
   ========================================== */

------------------------------------------------
-- QUESTION 1
-- Sales made on 5 November 2022
------------------------------------------------

SELECT *
FROM retail_sales_datasets
WHERE sale_date = '2022-11-05';

SELECT COUNT(*) AS total_transactions
FROM retail_sales_datasets
WHERE sale_date = '2022-11-05';


------------------------------------------------
-- QUESTION 2
-- Clothing transactions with quantity > 4
-- during November 2022
------------------------------------------------

SELECT *
FROM retail_sales_datasets
WHERE category = 'Clothing'
  AND quantity > 4
  AND MONTH(sale_date) = 11
  AND YEAR(sale_date) = 2022;


------------------------------------------------
-- QUESTION 3
-- Total sales by category
------------------------------------------------

SELECT category,
       SUM(total_sale) AS total_sales
FROM retail_sales_datasets
GROUP BY category;


------------------------------------------------
-- QUESTION 4
-- Average age of Beauty customers
------------------------------------------------

SELECT AVG(age) AS average_age
FROM retail_sales_datasets
WHERE category = 'Beauty';


------------------------------------------------
-- QUESTION 5
-- High-value transactions
------------------------------------------------

SELECT *
FROM retail_sales_datasets
WHERE total_sale > 1000;

SELECT COUNT(*) AS high_value_transactions
FROM retail_sales_datasets
WHERE total_sale > 1000;


------------------------------------------------
-- QUESTION 6
-- Transactions by gender and category
------------------------------------------------

SELECT gender,
       category,
       COUNT(transactions_id) AS total_transactions
FROM retail_sales_datasets
GROUP BY gender, category;


------------------------------------------------
-- QUESTION 7
-- Top 5 customers by sales
------------------------------------------------

SELECT customer_id,
       SUM(total_sale) AS total_sales
FROM retail_sales_datasets
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;


------------------------------------------------
-- QUESTION 8
-- Unique customers by category
------------------------------------------------

SELECT category,
       COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales_datasets
GROUP BY category;
----------------------------------------------------------

SELECT*FROM retail_sales_datasets;

CREATE VIEW retail_dashboard AS
SELECT
    transactions_id,
    sale_date,
    sale_time,
    customer_id,
    gender,
    age,
    category,
    quantity,
    price_per_unit,
    cogs,
    total_sale
FROM retail_sales_datasets;

SELECT * FROM retail_dashboard;

SELECT COUNT(*) AS total_rows
FROM retail_dashboard;

SELECT COUNT(*) AS total_rows
FROM retail_sales_datasets;