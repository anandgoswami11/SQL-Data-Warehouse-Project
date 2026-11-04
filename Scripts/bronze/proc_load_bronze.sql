/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files.
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None.
    This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/
/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files.
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None.
    This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
    PRINT '=============================================================';
    PRINT 'LOADING BRONZE LAYER';
    PRINT '=============================================================';

    -- 1. CRM CUSTOMER INFO
    PRINT '>> Truncating & Loading: bronze.crm_cust_info';
    TRUNCATE TABLE bronze.crm_cust_info;
    BULK INSERT bronze.crm_cust_info
    FROM 'C:\Users\goswa\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '0x0a',
        CODEPAGE = '65001',
        TABLOCK
    );

    -- 2. CRM PRODUCT INFO
    PRINT '>> Truncating & Loading: bronze.crm_prd_info';
    TRUNCATE TABLE bronze.crm_prd_info;
    BULK INSERT bronze.crm_prd_info
    FROM 'C:\Users\goswa\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '0x0a',
        CODEPAGE = '65001',
        TABLOCK
    );

    -- 3. CRM SALES DETAILS
    PRINT '>> Truncating & Loading: bronze.crm_sales_details';
    TRUNCATE TABLE bronze.crm_sales_details;
    BULK INSERT bronze.crm_sales_details
    FROM 'C:\Users\goswa\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '0x0a',
        CODEPAGE = '65001',
        TABLOCK
    );

    -- 4. ERP CUSTOMER AZ12
    PRINT '>> Truncating & Loading: bronze.erp_cust_AZ12';
    TRUNCATE TABLE bronze.erp_cust_AZ12;
    BULK INSERT bronze.erp_cust_AZ12
    FROM 'C:\Users\goswa\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_AZ12.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '0x0a',
        CODEPAGE = '65001',
        TABLOCK
    );

    -- 5. ERP LOCATION A101
    PRINT '>> Truncating & Loading: bronze.erp_loc_A101';
    TRUNCATE TABLE bronze.erp_loc_A101;
    BULK INSERT bronze.erp_loc_A101
    FROM 'C:\Users\goswa\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\loc_A101.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '0x0a',
        CODEPAGE = '65001',
        TABLOCK
    );

    -- 6. ERP PRODUCT CATEGORY
    PRINT '>> Truncating & Loading: bronze.erp_px_cat_g1v2';
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;
    BULK INSERT bronze.erp_px_cat_g1v2
    FROM 'C:\Users\goswa\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '0x0a',
        CODEPAGE = '65001',
        TABLOCK
    );

    PRINT '=============================================================';
    PRINT 'BRONZE LAYER LOADING COMPLETED';
    PRINT '=============================================================';
END;
GO
```[cite: 2]  
