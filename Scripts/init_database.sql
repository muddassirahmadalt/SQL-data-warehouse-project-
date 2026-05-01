/* 

=======================================================================
Create Database and Schemas 
=======================================================================

Script Purpose:
    This scripts create a new database named 'Datawarehouse' after checking  if it already exists. 
    if the database exists it is dropped and recreated. Additionally the script sets up three schemas
    within the database: 'bronze','silver' and 'gold'.


WARNING:
    Running this script will drop the entire 'Datawarehouse' database if it exists.
    All data in database will be permenantly deleted . proceed with caution 
    and ensure u have proper backups before running  this script.

*/

USE master;
GO

--Drop and recreate the 'Datawarehouse' database 

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'Datawarehouse')
BEGIN 
    ALTER DATABASE Datawarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Datawarehouse;
END;
GO 

-- create the 'Datawarehouse' database 

CREATE DATABASE Datawarehouse;
GO 


USE Datawarehouse;
GO 

-- create schemas 

CREATE SCHEMA Bronze; 
GO 

CREATE SCHEMA silver; 
GO 

CREATE SCHEMA Gold;
GO 
