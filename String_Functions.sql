
USE [Northwind]
GO
SELECT LOWER(CompanyName) AS NAME ,LEN(CompanyName) AS LenghtOfCName, UPPER(ContactName) AS CotactName, 
LEFT(CompanyName,5)  as First5etters FROM dbo.Customers;


USE [AdventureWorks2019]
GO

select *  FROM Person.EmailAddress;


select EmailAddress, CHARINDEX('@', EmailAddress) FROM Person.EmailAddress;

select EmailAddress, LEFT(EmailAddress, CHARINDEX('@', EmailAddress)-1) FROM Person.EmailAddress;


select EmailAddress, RIGHT(EmailAddress, LEN(EmailAddress)-CHARINDEX('@', EmailAddress)) as Domain FROM 
Person.EmailAddress;


select substring(EmailAddress, CHARINDEX('@', EmailAddress)+1,LEN(EmailAddress)-CHARINDEX('@', EmailAddress)) 
FROM Person.EmailAddress;

-- Space function 

USE [Northwind]
GO

SELECT FirstName, LastName, FirstName + SPACE(6)+ LastName AS FullName  FROM dbo.Employees;

-- DATE TIME FUNCTIONS

SELECT GETDATE();
SELECT CURRENT_TIMESTAMP;
SELECT SYSDATETIME();
SELECT GETUTCDATE();
select SYSUTCDATETIME();
SELECT SYSDATETIMEOFFSET();

SELECT DAY(GETDATE());
SELECT MONTH(GETDATE());
SELECT YEAR(GETDATE());

-- DATENAME: This function returns a character string representing the specified datepart of the specified date.
-- DATENAME ( datepart , date )  
SELECT DATENAME(YEAR, GETDATE())        AS 'Year';        
SELECT DATENAME(QUARTER, GETDATE())     AS 'Quarter';     

SELECT DATENAME(MONTH, GETDATE())       AS 'Month Name'; 

SELECT DATENAME(DAYOFYEAR, GETDATE())   AS 'DayOfYear';   
SELECT DATENAME(DAY, GETDATE())         AS 'Day';         
SELECT DATENAME(WEEK, GETDATE())        AS 'Week';        
SELECT DATENAME(WEEKDAY, GETDATE())     AS 'Day of the Week';
SELECT DATENAME(DW, GETDATE())     AS 'Day of the Week1';
SELECT DATENAME(HOUR, GETDATE())        AS 'Hour';        
SELECT DATENAME(MINUTE, GETDATE())      AS 'Minute';      
SELECT DATENAME(SECOND, GETDATE())      AS 'Second';      
SELECT DATENAME(MILLISECOND, GETDATE()) AS 'MilliSecond'; 
SELECT DATENAME(MICROSECOND, GETDATE()) AS 'MicroSecond'; 
SELECT DATENAME(NANOSECOND, GETDATE())  AS 'NanoSecond';  
SELECT DATENAME(ISO_WEEK, GETDATE())    AS 'Week';

--DATEAPART This function returns an integer representing the specified datepart of the specified date.
-- DATENAME ( datepart , date )  
SELECT DATEPART(DAY, GETDATE())         AS 'Day';         
SELECT DATENAME(WEEK, GETDATE())        AS 'Week';        
SELECT DATEPART(WEEKDAY, GETDATE())     AS 'Day of the Week';    


-- next time 29