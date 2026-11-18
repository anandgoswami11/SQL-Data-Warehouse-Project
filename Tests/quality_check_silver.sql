/*
===============================================================================
Quality Checks: Silver Layer
===============================================================================
Script Purpose:
    This script performs quality and data integrity checks on the 'silver' schema 
    tables. It validates uniqueness, null constraints, referential integrity, 
    data types, and standardization rules after the Silver ETL load.
===============================================================================
*/

-- ============================================================================
-- Checking 'silver.crm_cust_info'
-- ============================================================================

-- Check for NULLs or Duplicates in Primary Key (cst_id)
-- Expectation: No Results
SELECT 
    cst_id,
    COUNT(*) AS duplicate_count
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Check for unwanted spaces in names (Firstname / Lastname)
-- Expectation: No Results
SELECT 
    cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);

-- Check standardization of Marital Status
-- Expectation: Only 'Single', 'Married', or 'n/a'
SELECT DISTINCT 
    cst_marital_status
FROM silver.crm_cust_info;

-- Check standardization of Gender
-- Expectation: Only 'Female', 'Male', or 'n/a'
SELECT DISTINCT 
    cst_gndr
FROM silver.crm_cust_info;


-- ============================================================================
-- Checking 'silver.crm_prd_info'
-- ============================================================================

-- Check for NULLs or Duplicates in Primary Key (prd_id)
-- Expectation: No Results
SELECT 
    prd_id,
    COUNT(*) AS duplicate_count
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Check for negative or null product costs
-- Expectation: No Results (Costs should be >= 0)
SELECT 
    prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- Check standardization of Product Line
-- Expectation: Valid categories or 'n/a'
SELECT DISTINCT 
    prd_line
FROM silver.crm_prd_info;

-- Check for invalid product start/end dates (Start Date > End Date)
-- Expectation: No Results
SELECT 
    *
FROM silver.crm_prd_info
WHERE prd_start_date > prd_end_date;


-- ============================================================================
-- Checking 'silver.crm_sales_details'
-- ============================================================================

-- Check for invalid dates (Order Date > Ship Date or Due Date)
-- Expectation: No Results
SELECT 
    *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt 
   OR sls_order_dt > sls_due_dt;

-- Check data consistency: Sales = Quantity * Price
-- Expectation: No Results
SELECT 
    sls_sales,
    sls_quantity,
    sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
   OR sls_sales IS NULL 
   OR sls_quantity IS NULL 
   OR sls_price IS NULL;


-- ============================================================================
-- Checking 'silver.erp_cust_az12'
-- ============================================================================

-- Check birthdates in the future (Invalid Birthdate)
-- Expectation: No Results
SELECT 
    bdate
FROM silver.erp_cust_az12
WHERE bdate > GETDATE();

-- Check gender standardization
-- Expectation: Only 'Female', 'Male', or 'n/a'
SELECT DISTINCT 
    gen
FROM silver.erp_cust_az12;


-- ============================================================================
-- Checking 'silver.erp_loc_a101'
-- ============================================================================

-- Check country standardization and cleanup (e.g., 'DE' -> 'Germany', 'US' -> 'United States')
-- Expectation: Fully standardized country names
SELECT DISTINCT 
    cntry
FROM silver.erp_loc_a101
ORDER BY cntry;


-- ============================================================================
-- Checking 'silver.erp_px_cat_g1v2'
-- ============================================================================

-- Check for unhandled spaces in maintenance or category values
-- Expectation: No Results
SELECT 
    maintenance
FROM silver.erp_px_cat_g1v2
WHERE maintenance != TRIM(maintenance);
```[cite: 1]
