

-- DATE/TIME FUNCTIONS

SELECT GETDATE();--current local date and time from your system
SELECT CURRENT_TIMESTAMP;
SELECT SYSDATETIME();
SELECT GETUTCDATE();
select SYSUTCDATETIME();
SELECT SYSDATETIMEOFFSET();

SELECT DAY(GETDATE());
SELECT MONTH(GETDATE());
SELECT YEAR(GETDATE());

-- The DATENAME() function returns a specified part of a date.
-- DATENAME: This function returns a character string representing the specified datepart of the specified date.
-- DATENAME ( datepart , date )  

SELECT DATENAME(YEAR, GETDATE())     AS 'Year';        
SELECT DATENAME(YY,GETDATE())        AS 'Year1';
SELECT DATENAME(QUARTER, GETDATE())  AS 'Quarter';     


SELECT DATENAME(MONTH, GETDATE())    AS 'Month Name'; 
SELECT DATENAME(m, GETDATE())        AS 'Month Name 1';


SELECT DATENAME(DAYOFYEAR, GETDATE())   AS 'DayOfYear';   
SELECT DATENAME(DAY, GETDATE())         AS 'Day';         
SELECT DATENAME(WEEK, GETDATE())        AS 'WeekOfYear';
SELECT DATENAME(WEEKDAY, GETDATE())     AS 'Day of the Week';
SELECT DATENAME(DW, GETDATE())     AS 'Day of the Week1';
SELECT DATENAME(HOUR, GETDATE())        AS 'Hour';   
-- MINUTES
SELECT DATENAME(MINUTE, GETDATE())      AS 'Minute';    
SELECT DATENAME(MI, GETDATE())      AS 'Minute1';
SELECT DATENAME(n, GETDATE())      AS 'Minute2';

SELECT DATENAME(SECOND, GETDATE())      AS 'Second';      
SELECT DATENAME(MILLISECOND, GETDATE()) AS 'MilliSecond'; 
SELECT DATENAME(MICROSECOND, GETDATE()) AS 'MicroSecond'; 
SELECT DATENAME(NANOSECOND, GETDATE())  AS 'NanoSecond';  
SELECT DATENAME(ISO_WEEK, GETDATE())    AS 'Week';


/* The DATEPART() function returns a specified part of a date.

This function returns the result as an integer value.

DATEAPART This function returns an integer representing the specified datepart of the specified date.

DATENAME ( datepart , date )
*/
  
SELECT DATEPART(DAY, GETDATE())         AS 'Day';   
SELECT DATEPART(d, GETDATE())         AS 'Day 1'; 
SELECT DATEPART(dd, GETDATE())         AS 'Day 2'; 

SELECT DATENAME(WEEK, GETDATE())        AS 'Week';        
SELECT DATEPART(WEEKDAY, GETDATE())     AS 'Day of the Week';    


/*
The DATEADD() function adds a time/date interval to a date and then returns the date.

DATEADD(interval, number, date)
*/

SELECT DATEADD(month, 2, '2017/08/25') AS DateAdd; -- add 2 to the month

SELECT ISDATE('23 : 99 : 99'); --0 (NO)

SELECT ISDATE('2020-04-30 ' ); --1 (YES)
SELECT ISDATE('2020-04-31'); --0
SELECT ISDATE('23 : 59:59'); --1


use [AdventureWorks2019]
GO

SELECT TOP (20)[Name] ,[ProductNumber] ,[SafetyStockLevel] ,[ReorderPoint]
      ,[StandardCost]  ,[ListPrice]  ,[SellStartDate]    
  FROM [Production].[Product] WHERE SellEndDate >'2011-10-24' AND SellEndDate <'2012-7-21';



  USE [Northwind]
  GO
  -- DATEDIFF (datepart, datetime_expr1, datetime_expr2)
SELECT OrderID, CustomerID,OrderDate,ShippedDate, ShipCity, ShipPostalCode ,ShipCountry,
		CASE 
			WHEN DATEDIFF( day	,OrderDate,  ShippedDate)> 7 THEN 'More than 7 days due'
			WHEN DATEDIFF( day	,OrderDate,  ShippedDate)> 0 THEN '1 to 6 days due'
			ELSE 'Due day'
			END AS STATUS

  FROM Orders;
   

   /*The CAST() function converts a value (of any type) into a specified datatype.

CAST(expression AS datatype(length))
   
   */

select cast(GETDATE() AS DATE);
SELECT CAST(25.65 AS varchar);

USE [AdventureWorks2019]
GO

SELECT SUBSTRING(Name, 1, 30) AS ProductName, ListPrice
FROM Production.Product WHERE CAST(ListPrice AS INT) LIKE '33%';

/*
The CONVERT() function converts a value (of any type) into a specified datatype.
CONVERT ( data_type [ ( length ) ] , expression [ , style ] )

CONVERT(data_type(length), expression, style)
*/

SELECT SUBSTRING(Name, 1, 30) AS ProductName, ListPrice
FROM Production.Product WHERE CONVERT(INT, ListPrice) LIKE '33%';

select CONvert(DATE, GETDATE() );

