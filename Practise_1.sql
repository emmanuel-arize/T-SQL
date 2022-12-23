


 /* creating a  database */
 
 create database MyDatabase;
 create database Sample;

		/* when this database is created it will create two files
		 Sample2.mdf is the data file which contain the actual data and 

		 Sample2_log.ldf: transaction log file which is basically used to recover the database.
		 The Database Engine use the transaction log file keeps a record of each change it makes 
		 to the database

		 */

 /* renaming a database */

 alter database MyDatabase modify name=Tutorials;
 alter database Sample modify name=MySamples;


 /* renaming a database using stored procedures*/

 sp_renameDB "MySamples","MySampless";


 /* DROPING A DATABASE*/

 Drop database IF EXISTS MySampless;

 /* you cannot drop a database if is currently in use */

-- alter the database name from AdventureWorksDW2020-DAX-Docs to AdventureWorksDW2020

-- the USE command specifies the current database to use.

USE [master]
GO
ALTER DATABASE "AdventureWorksDW2020-DAX-Docs" MODIFY NAME=AdventureWorksDW2020;

-- CREATING TABLES


  use [MySample1]
 GO
 create table tblCustomers
	(
	CustomerID varchar(100) NOT NULL PRIMARY KEY,
	CustomerName varchar(100) NOT NULL,
    Address1 varchar(100),
    Country varchar(100),
    City varchar(100),
    States varchar(100),
    ZipCode varchar(100)
 );


 drop table if exists tblInvoiceDetails;
 create table tblInvoiceDetails
 (
	InvoiceNumber varchar(100) not null ,
	Quantity int,
	UnitCost Numeric Not Null,
	UnitPrice Numeric Not Null
 
 );
 
 
  create table tblInvoiceHeader
 (
	InvoiceDate Date,
	InvoiceNumber varchar(100) not null primary key ,
	CustomerID  varchar(100) not null 
 );

 

 -- DROP Table if EXISTS Persons;


 
CREATE TABLE tblPersons (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address1 varchar(255),
    City varchar(255)
);



USE [Tutorials]
GO

DROP TABLE IF EXISTS dbo.Employees;

CREATE TABLE dbo.Employees
			(
			empid INT NOT NULL,
			firstname VARCHAR(30) NOT NULL,
			lastname VARCHAR(30) NOT NULL,
			hiredate DATE NOT NULL,
			mgrid INT NULL,
			ssn VARCHAR(20) NOT NULL,
			salary MONEY NOT NULL
			);




-- adding a primary key
	/*
	Primary keys and foreign keys are two types of constraints that can be used to enforce 
	data integrity in SQL Server tables
	*/

alter table dbo.Employees ADD CONSTRAINT PK_Employees_empid PRIMARY KEY (empid);

-- Unique constraints

use [Tutorials]
go
alter table dbo.Employees add constraint UNQ_Employees_ssn UNIQUE (ssn);

--DROPPING A UNIGUE KEY CONSTRAINT

ALTER TABLE  dbo.Employees drop constraint UNQ_Employees_ssn;
-- creating an order table

DROP TABLE IF EXISTS dbo.Orders;
CREATE TABLE dbo.Orders
						(
						orderid  INT   NOT NULL,
						empid    INT   NOT NULL,
 						custid  VARCHAR(10) NOT NULL,
						orderts  DATETIME2 NOT NULL,
						qty real  not null,
						-- setting orderid as primary key
						CONSTRAINT PK_Orders PRIMARY KEY (orderid)

						);

 -- Foreign-key constraints: A foreign-key enforces referential integrity.

 -- USE (InvoiceNumber) COLUMN IN  DETAILS AS A FOREIGN KEY REFERENCING (InvoiceNumber) IN HEADER AS THE PRIMARY KEY

 USE [MySample1]
 GO
ALTER TABLE tblInvoiceDetails ADD CONSTRAINT FK_tblInvoiceDetails_InvoiceNumber FOREIGN KEY (InvoiceNumber) 
REFERENCES tblInvoiceHeader (InvoiceNumber) ON UPDATE CASCADE ON DELETE CASCADE;

USE [Tutorials]
GO
 alter table dbo.orders add constraint FK_Orders_Employess FOREIGN KEY (empid) 
 references dbo.Employees (empid);

 -- if you want to know about the table highlight the table and press alt+f1


 /* MAKING CHANGES TO THE CustomerID COLUMN */

 USE [MySample1]
 GO
alter table tblCustomers alter column CustomerID  varchar(100) NOT NULL;

-- ADDing a new column  with default value to the table

Alter table tblPersons ADD Income numeric DEFAULT 26;


/* You can't delete a column that has a CHECK constraint. You must first delete the constraint.
You can't delete a column that has PRIMARY KEY or FOREIGN KEY constraints or other
dependencies except when using the Table Designer in SSMS.*/

ALTER TABLE tblPersons DROP CONSTRAINT DF__tblPerson__Incom__398D8EEE;
ALTER TABLE tblPersons DROP COLUMN Income;

-- check constraints

use [Tutorials]
go
alter table dbo.Employees add constraint CK_Employees_salary CHECK (salary>0);

-- default condtraints

ALTER TABLE dbo.Orders add constraint DEF_Orders_qty default 0 for qty;

ALTER TABLE dbo.Orders add constraint DEF_Orders_orderts default (SYSDATETIME()) for orderts;


--  all databases
 SELECT name, database_id, create_date from sys.databases;
  SELECT * from sys.databases;


 -- IDENTITY COLUMN

 	/*  IDENTITY column by specifying the keyword identity, instead of null or not null,
		in the create table statement. IDENTITY columns must have a datatype of numeric and
		scale of 0, or any integer type. Define the IDENTITY column with any desired precision, from
		1 to 38 digits, in a new table:

		create table table_name
		(column_name numeric(precision ,0) identity)
		The maximum possible column value is 10^(precision) - 1*/
 
		/* creating a table with an identity column.
		An IDENTITY column contains a value for each row, generated automatically that uniquely identifies the 
		row within the table.
		
		When creating an Identity column  You must specify both the seed and increment or neither. 
		If neither is specified, the default is (1,1).*/
USE [MySample1]
GO
CREATE TABLE new_employees  
(  
 id_num int IDENTITY(1,1),  --(1,1) is increament and seed
 fname varchar (20),  
 minit char(1),  
 lname varchar(30)  
);  
  
INSERT new_employees  
   (fname, minit, lname)  
VALUES  
   ('Karin', 'F', 'Josephs');  
  
INSERT new_employees  
   (fname, minit, lname)  
VALUES  
   ('Pirkko', 'O', 'Koskitalo'); 

select * from new_employees;

delete from new_employees where id_num=1;

select * from new_employees;

---- to enable users to insert cumstomer value in the identity column we have to set the identity column on

set identity_insert new_employees   on;
INSERT new_employees  
   (id_num,fname, minit, lname)  
VALUES  
   (1,'Karin', 'F', 'Josephs');  

select * from new_employees;

-- if we don't want to supply the value of the identity column explictly then we have to turn the 
--  identity column off
set identity_insert  new_employees off;

-- if we delete all row and we want to reset the identity column to start from zero
delete from new_employees;
select * from new_employees;

DBCC CHECKIDENT(new_employees, reseed,0);

INSERT new_employees  
   (fname, minit, lname)  
VALUES  
   ('Karin', 'F', 'Josephs');  
  
INSERT new_employees  
   (fname, minit, lname)  
VALUES  
   ('Pirkko', 'O', 'Koskitalo'); 

select * from new_employees;


create table students (

				 studentId int primary key identity (1,1), --(1,1) is increament and seed
				 studentname varchar(100)
				 );
							

--RETRIEVING THE LAST THE IDENTITY COLUMN VALUE  

CREATE table test1 (

				id int identity(1,1),
				value nvarchar(20)
				
				);

CREATE table test2 (

				id int identity(1,1),
				value nvarchar(20)
				
				);
insert into test1 values ('X');

create trigger toForInsert on test1 FOR INSERT
	as
	Begin
	 INSERT INTO test2 VALUES ('YYY');
	End;

SELECT * FROM test1;
SELECT * FROM test2;

-- to retrieve the last identity element

select SCOPE_IDENTITY();
select @@IDENTITY;
SELECT IDENT_CURRENT('test2');


/* The following code
changes the AdventureWorks database collation so that it becomes case-sensitive:
*/

CREATE DATABASE CollateChange
GO
   ALTER DATABASE CollateChange COLLATE SQL_Latin1_General_CP1_CS_AS;
GO
	SELECT DATABASEPROPERTYEX('CollateChange','Collation') AS DatabaseCollation;


