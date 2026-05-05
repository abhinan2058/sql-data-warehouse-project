/*

===================================================================
Create Database and Schemas
===================================================================
Script Purpose:
  This script creates a new database named 'DataWarehouse' after checking if it already exists.
  If the database exists, it is dropped and recreated. Additonally, the scripts sets up three schemas within the database: 'bronze', 'silver' and 'gold'/

WARINING:
  Running this script will drop the entire 'DataWarehouse' database if it exists.
  All data in the databas will be permanently deleted. Proceed with caution
  and esnure you have proper backups before running this scripts.

*/


USE master;
GO

-- Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name='Datawarehouse')
BEGIN
  ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE DataWarehouse;
END;
GO

 -- Create the 'DataWarehoue' database 
CREATE DATABASE DataWarehouse;

USE DataWarehouse;


--Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
