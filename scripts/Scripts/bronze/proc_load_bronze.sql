/*

===============================================================================

Stored Procedure: Load Bronze Layer (Source -> Bronze) 

=============================================================================== 

Script purpose:
       This Stored Procedure load data into the 'bronze' schema from external CSV files. 
       It performs the following actions:
       - Truncates the bronze tables before loading data.
       - uses the 'BULK INSERT' Command to load data from CSV files to bronze Tables.

parameters:
    None. 

   This stored procedure does not accept any parameters or return any values.


Usage Examples: 
      EXEC bronze.load_bronze;


=============================================================================== 
*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN 
     DECLARE @Start_time DATETIME , @end_time DATETIME ,@batch_Start_time DATETIME , @batch_end_time DATETIME;
BEGIN TRY 
     
     SET @batch_Start_time = GETDATE();
     print('=================================================================');
     print('Loading bronze layer');
     print('=================================================================');


     print('--------------------------------------------------------------');
     print('loading CRM Tables');
     print('--------------------------------------------------------------');

     SET @Start_time = GETDATE();
     print('>> truncating Table: bronze.crm_cust_info');
     TRUNCATE TABLE  bronze.crm_cust_info;

     print('>> Inserting Data Into: bronze.crm_cust_info');
     BULK INSERT bronze.crm_cust_info 
     FROM 'C:\Users\cp\Downloads\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
     WITH (
     FIRSTROW = 2,
     FIELDTERMINATOR = ',',
     TABLOCK   );
     SET @end_time = GETDATE();
     PRINT('>> Load Duration:' +  CAST(DATEDIFF(Second , @Start_time , @end_time) AS NVARCHAR)) + 'Seconds';
     PRINT('----------');
  
     SET @Start_time = GETDATE();
     print('>> truncating Table: bronze.crm_prd_info');
     TRUNCATE TABLE  bronze.crm_prd_info;

     print('>> Inserting Data Into: bronze.crm_prd_info');
     BULK INSERT bronze.crm_prd_info
     FROM  'C:\Users\cp\Downloads\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
     WITH (
     FIRSTROW = 2,
     FIELDTERMINATOR = ',',
     TABLOCK   );  
     SET @end_time = GETDATE();
     PRINT('>> Load Duration:' +  CAST(DATEDIFF(Second , @Start_time , @end_time) AS NVARCHAR)) + 'Seconds';
     PRINT('----------');
 
     SET @Start_time = GETDATE();
     print('>> truncating Table: bronze.crm_Sales_details');
     TRUNCATE TABLE  bronze.crm_Sales_details;
     print('>> Inserting Data Into: bronze.crm_Sales_details');
     BULK INSERT bronze.crm_Sales_details
     FROM  'C:\Users\cp\Downloads\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_crm\Sales_details.csv'
     WITH (
     FIRSTROW = 2,
     FIELDTERMINATOR = ',',
     TABLOCK   );  
     SET @end_time = GETDATE();
     PRINT('>> Load Duration:' +  CAST(DATEDIFF(Second , @Start_time , @end_time) AS NVARCHAR)) + 'Seconds';
     PRINT('----------');

    print('--------------------------------------------------------------');
    print('loading ERP Tables');
    print('--------------------------------------------------------------');


     
     SET @Start_time = GETDATE();  
     print('>> truncating Table: bronze.erp_cust_AZ12');
     TRUNCATE TABLE  bronze.erp_cust_AZ12;

     print('>> Inserting Data Into: bronze.erp_cust_AZ12');
     BULK INSERT bronze.erp_cust_AZ12 
     FROM 'C:\Users\cp\Downloads\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
     WITH (
     FIRSTROW = 2,
     FIELDTERMINATOR = ',',
     TABLOCK   );  
     SET @end_time = GETDATE();
     PRINT('>> Load Duration:' +  CAST(DATEDIFF(Second , @Start_time , @end_time) AS NVARCHAR)) + 'Seconds';
     PRINT('----------');

      
      SET @Start_time = GETDATE();  
      print('>> truncating Table: bronze.erp_loc_a101');
      TRUNCATE TABLE  bronze.erp_loc_a101;

      print('>> Inserting Data Into: bronze.erp_loc_a101');
      BULK INSERT bronze.erp_loc_a101
      FROM 'C:\Users\cp\Downloads\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
      WITH (
      FIRSTROW = 2,
      FIELDTERMINATOR = ',',
      TABLOCK);  
      SET @end_time = GETDATE();
      PRINT('>> Load Duration:' +  CAST(DATEDIFF(Second , @Start_time , @end_time) AS NVARCHAR)) + 'Seconds';
      PRINT('----------');
   
      SET @Start_time = GETDATE(); 
      print('>> truncating Table: bronze.erp_PX_CAT_g1v2');
      TRUNCATE TABLE  bronze.erp_PX_CAT_g1v2;

      print('>> Inserting Data Into: bronze.erp_PX_CAT_g1v2');  
      BULK INSERT bronze.erp_PX_CAT_g1v2
      FROM 'C:\Users\cp\Downloads\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_erp\PX_CAT_g1v2.csv'
      WITH (
      FIRSTROW = 2,
      FIELDTERMINATOR = ',',
      TABLOCK );  
      SET @end_time = GETDATE();
      PRINT('>> Load Duration:' +  CAST(DATEDIFF(SECOND , @Start_time , @end_time) AS NVARCHAR)) + 'Seconds';
      PRINT('----------'); 

      
      SET @batch_end_time = GETDATE(); 
      PRINT('=====================================');
      PRINT('loading Bronze layer is completed');
      PRINT('  - Total Load Duration : ' + CAST (DATEDIFF(SECOND,@batch_Start_time , @batch_end_time) AS NVARCHAR)) + 'Seconds';
      PRINT('=====================================');

     END TRY 
     BEGIN CATCH 
     print('==========================================')
     print('ERROR OCCURED DURING LOADING BRONZE LAYER')
     print('ERROR MESSAGE' + ERROR_MESSAGE() )
     print('ERROR MESSAGE' + CAST(ERROR_NUMBER() AS NVARCHAR))
     print('==========================================')
     END CATCH 
END
