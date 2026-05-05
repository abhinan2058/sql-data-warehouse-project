/*
========================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
========================================================================
Script Purpose:
  This stored procedure loads data into the 'bronze' schema from external CSV files.
  It performs the following actions:
  - Truncates the bronze tables before loading data.
  - Uses the 'BULK INSERT' command to load from csv Files to bronze tables.

Parameters:
  None
  This stored procedure doesn't accept any parameters or return any values.

Usage Example:
  EXEC bronze.load_bronze;
=========================================================================
*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME
	begin try
	SET @batch_start_time = getdate();
	print '=========================================================';
	PRINT 'lOADING Bronze Layer';
	print '=========================================================';

	print '----------------------------------------------------------';
	print 'Loading CRM Tables';
	print '----------------------------------------------------------';

	SET @start_time = GETDATE();
	PRINT '>>>truncating table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
	PRINT '>>> Inserting Data into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		from 'C:\Users\kchy1\OneDrive\Desktop\SQL_DATAWAREHOUSE\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with (
		firstrow =2,
		fieldterminator =',',
		tablock
		);
	SET @end_time =GETDATE();
	PRINT'>>Load Duration:' + cast(datediff(second,@start_time,@end_time) as nvarchar) + ' seconds';
	print'==========================================================';

	SET @start_time = GETDATE();
	PRINT '>>>truncating table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;
    PRINT '>>> Inserting Data into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		from 'C:\Users\kchy1\OneDrive\Desktop\SQL_DATAWAREHOUSE\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with (
		firstrow =2,
		fieldterminator =',',
		tablock
		);
	SET @end_time =GETDATE();
	PRINT'>>Load Duration:' + cast(datediff(second,@start_time,@end_time) as nvarchar) + ' seconds';
	print'==========================================================';

	SET @start_time = GETDATE();
	print'Truncating table: bronze.crm_sales_details ';
	
		TRUNCATE TABLE bronze.crm_sales_details;
	print'Bulk inserting into bronze.crm_sales_details ';
		BULK INSERT bronze.crm_sales_details
		from 'C:\Users\kchy1\OneDrive\Desktop\SQL_DATAWAREHOUSE\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with (
		firstrow =2,
		fieldterminator =',',
		tablock
		);
	SET @end_time =GETDATE();
	PRINT'>>Load Duration:' + cast(datediff(second,@start_time,@end_time) as nvarchar) + ' seconds';
	print'==========================================================';

	print '----------------------------------------------------------';
	print 'Loading ERP Tables';
	print '----------------------------------------------------------';
	print'Truncating table: bronze.erp_CUST_AZ12 ';
	
	SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_CUST_AZ12;
		print'Bulk inserting into bronze.erp_CUST_AZ12 ';
		BULK INSERT bronze.erp_CUST_AZ12
		from 'C:\Users\kchy1\OneDrive\Desktop\SQL_DATAWAREHOUSE\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		with (
		firstrow =2,
		fieldterminator =',',
		tablock
		);
	SET @end_time =GETDATE();
	PRINT'>>Load Duration:' + cast(datediff(second,@start_time,@end_time) as nvarchar) + ' seconds';
	print'==========================================================';

	SET @start_time = GETDATE();
	print'Truncating table: bronze.erp_LOC_A101 ';
	
		TRUNCATE TABLE bronze.erp_LOC_A101;
		print'Bulk inserting into bronze.erp_LOC_A101 ';
		BULK INSERT bronze.erp_LOC_A101
		from 'C:\Users\kchy1\OneDrive\Desktop\SQL_DATAWAREHOUSE\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		with (
		firstrow =2,
		fieldterminator =',',
		tablock
		);
	SET @end_time =GETDATE();
	PRINT'>>Load Duration:' + cast(datediff(second,@start_time,@end_time) as nvarchar) + ' seconds';
	print'==========================================================';

	SET @start_time = GETDATE();
	print'Truncating table: bronze.erp_PX_CAT_G1V2 ';
	
		TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;
		print'Bulk inserting into bronze.erp_PX_CAT_G1V2 ';
		BULK INSERT bronze.erp_PX_CAT_G1V2
		from 'C:\Users\kchy1\OneDrive\Desktop\SQL_DATAWAREHOUSE\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		with (
		firstrow =2,
		fieldterminator =',',
		tablock
		);
	SET @end_time =GETDATE();
	PRINT'>>Load Duration:' + cast(datediff(second,@start_time,@end_time) as nvarchar) + ' seconds';
	print'==========================================================';
	print 'Loading COmpleted';
	set @batch_end_time = GETDATE();
	PRINT'>>Whole Batch Loading Time:' + cast(datediff(second,@batch_start_time,@batch_end_time) as nvarchar)+ ' seconds';
	end try

	begin catch
	print'===================================================';
	PRINT 'eRROR OCCURRED DURING LOADING BRONZE LAYER';
	print'Error'+ ERROR_MESSAGE();
	print'Error'+ cast (ERROR_NUMBER() as Nvarchar);
	print'Error'+ cast (ERROR_STATE() as Nvarchar);
	print'===================================================';
	end catch
END
