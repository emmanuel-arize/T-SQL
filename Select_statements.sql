

USE [AdventureWorks2019]
GO
select * FROM HumanResources.Employee;


-- Table Aliases

select E.* FROM HumanResources.Employee as E;


select E.NationalIDNumber AS [Nat ID],E.JobTitle AS Job, E.Gender FROM HumanResources.Employee as E;


SELECT HE.JobTitle, HE.MaritalStatus FROM (SELECT JobTitle, MaritalStatus,Gender FROM HumanResources.Employee) AS HE;


-- the BETWEEN Search Condition

SELECT ProductNumber, ListPrice, Color FROM  [AdventureWorks2019].[Production].[Product] where ListPrice between 100 and 150;

-- USING IN
SELECT [Name],CountryRegionCode, StateProvinceCode  FROM Person.StateProvince  WHERE StateProvinceCode IN ('AB','NC', 'WV');

SELECT [Name],CountryRegionCode, StateProvinceCode  FROM Person.StateProvince  WHERE 'US' IN (CountryRegionCode) ;

SELECT FirstName, LastName  FROM Person.Person  WHERE 'Ken' IN (FirstName, LastName);

SELECT [Name],CountryRegionCode, StateProvinceCode  FROM Person.StateProvince  WHERE StateProvinceCode NOT IN ('AB','NC', 'WV');


	/* the LIKE Search Condition
	The LIKE search condition uses wildcards to search for patterns within a string.
	*/

		-- SEARCH FOR NAMES THAT BEGING WITH A
SELECT [Name],CountryRegionCode, StateProvinceCode  FROM Person.StateProvince  WHERE Name LIKE 'A%' ;


-- SEARCH FOR NAMES THAT END WITH A
SELECT [Name],CountryRegionCode, StateProvinceCode  FROM Person.StateProvince  WHERE Name LIKE '%A' ;

-- SEARCH FOR NAMES STARTING AND ENDING WITH A
SELECT [Name],CountryRegionCode, StateProvinceCode  FROM Person.StateProvince  WHERE Name LIKE 'A%A' ;

-- select NAMEs CONTAING "a" as the scond position
SELECT [Name],CountryRegionCode, StateProvinceCode  FROM Person.StateProvince  WHERE Name LIKE '_A%' ;


-- select NAMEs CONTAING "a" as the third position
SELECT [Name],CountryRegionCode, StateProvinceCode  FROM Person.StateProvince  WHERE Name LIKE '__A%' ;

--Finds any names that have "Al" in any position
USE [AdventureWorks2019]
GO
SELECT Name,CountryRegionCode, StateProvinceCode    FROM Person.StateProvince  WHERE Name LIKE '%Al%';

--Finds names that begining with letters between "a" and "d" in inclusive

SELECT Name,CountryRegionCode, StateProvinceCode    FROM Person.StateProvince  WHERE Name LIKE '[A-c]%';


--Finds names that start with characters within the bracket

SELECT Name,CountryRegionCode, StateProvinceCode    FROM Person.StateProvince  WHERE Name LIKE '[ABCD]%';

--Finds names that start with characters not in the bracket

SELECT Name,CountryRegionCode, StateProvinceCode    FROM Person.StateProvince  WHERE Name LIKE '[^ABCD]%';

--- MULTIPLE WHERE CLAUSES
SELECT ProductID, Name FROM Production.Product WHERE Name LIKE 'Ch%' OR ProductID BETWEEN 320 AND 324 AND Name Like '%s%';
 
SELECT *  FROM Person.StateProvince WHERE Name='Arizona';

-- Specifying the ORDER BY Using Column Names

select FirstName, MiddleName, LastName FROM Person.Person order by LastName;

select FirstName, MiddleName, LastName FROM Person.Person order by LastName, FirstName;

select DISTINCT FirstName + ' ' + LastName AS FullName FROM Person.Person order by FirstName + ' ' + LastName;


SELECT Description, LEN(Description) as TextLength FROM Production.ProductDescription WHERE
Description LIKE '%rider.' order by TextLength;

	/*  If the Description includes a leading “This,” then the CASE expression removes it 
	from the data and passes to the ORDER BY:*/


 SELECT Description, LEN(Description) as TextLength     FROM Production.ProductDescription
WHERE Description LIKE 'Replacement%' ORDER BY CASE WHEN LEFT(Description, 5) = 'This '
THEN Stuff(Description, 1, 5, '') ELSE Description END;


-- The function reports the installed collation options and the current collation server property:

SELECT * FROM fn_helpcollations();

-- The following query reports the current server collation:

 select SERVERPROPERTY('Collation') as ServerCollation;

 --  The following query sorts according to the Danish collation, without regard to case or accents:

 SELECT [Name], ListPrice FROM Production.Product ORDER BY [Name] COLLATE Danish_Norwegian_CS_AI;


 	-----ALL

USE [AdventureWorks2019]
GO
 SELECT ALL P.Name FROM Production.ProductModel AS P;

 --DISTINCT

  SELECT DISTINCT(P.Name) FROM Production.ProductModel AS P;


  -- TOP () The SELECT TOP clause is used to specify the number of records to return.

  SELECT TOP(3) PERCENT ProductNumber, [Name], ListPrice, SellStartDate
  FROM Production.Product ORDER BY ListPrice DESC;

  /* The WITH TIES Option
The WITH TIES option is important to the TOP() predicate. It enables the last place to
include multiple rows if those rows have equal values in the columns used in the ORDER BY
clause.*/

use [AdventureWorks2019]
	GO
SELECT TOP(6) WITH TIES ProductNumber, Name, ListPrice, SellStartDate FROM Production.Product ORDER BY ListPrice DESC;

SELECT TOP(6) ProductNumber, Name, ListPrice, SellStartDate FROM Production.Product ORDER BY ListPrice DESC;


USE [Tutorials]
GO
CREATE TABLE weather (
		city varchar(80),
		temp_lo int, -- low temperature
		temp_hi int, -- high temperature
		prcp real, -- precipitation
		date date
);

INSERT INTO weather VALUES ('San Francisco', 46, 50, 0.25,'1994-11-27');

INSERT INTO weather (city, temp_lo, temp_hi, prcp, date) VALUES ('San Francisco', 43, 57, 0.0, '1994-11-29');

INSERT INTO weather (date, city, temp_hi, temp_lo) VALUES ('1994-11-29', 'Hayward', 54, 37);


INSERT INTO weather (date, city, temp_hi, temp_lo,prcp) VALUES ('1994-11-29', 'Hayward', 53, 38,0.4);

INSERT INTO weather (city, temp_lo, temp_hi, prcp, date) VALUES ('San Francisco', 45, 52, 0.1, '1994-11-30');

--The GROUP BY clause
/*
	  The groups are determined by the elements you specify in the GROUP BY clause.
	Each group is ultimately represented by a single row in the final result of the query. 
	This implies that all expressions you specify in clauses that are processed in phases
	subsequent to the GROUP BY phase are required to guarantee returning a scalar (single value)
	per group
*/
select * from weather;
select city, SUM(temp_lo) as sum_temp_lo from weather GROUP BY city;
select city, AVG(temp_lo) as avg_temp_Lo from weather GROUP BY city;


select city, AVG(temp_lo+temp_hi) as avg_temp from weather GROUP BY city;


USE [AdventureWorks2019]
GO
SELECT * from Production.Product ;

SELECT Color,SUM(ListPrice) as Price from Production.Product where ListPrice>0  GROUP BY Color;

-- The HAVING clause 

-- Whereas the WHERE clause is a row filter, the HAVING clause is a group filter

-- sum of listprice where LP>0 AND the number of times a color appears in a row is more than 30 
-- group by color
SELECT Color,SUM(ListPrice) as Price from Production.Product where ListPrice>0  GROUP BY Color HAVING COUNT(*)>30;


SELECT Color,SUM(ListPrice) as Price from Production.Product where ListPrice>0  GROUP BY Color HAVING COUNT(*)<30

---JOINS

/*
Most queries involve combining data from multiple tables, and one of the main tools used for this purpose is a join clause.
 A JOIN clause is used to combine rows from two or more tables, based on a related column between them.

 Inner join, Left outer join, Right outer join, Full outer join, Cross join

LEFT (OUTER) JOIN: Return all records from the left table, and the matched records from the right table

RIGHT (OUTER) JOIN: Return all records from the right table, and the matched records from the left table

FULL (OUTER) JOIN: Return all records when there is a match in either left or right table
*/

/*
CROSS JOIN
A cross join returns the Cartesian product of rows from the rowsets in the join. In other words,
it will combine each row from the first rowset with each row from the second rowset.
So if we have m rows in one table and n rows in the other, we get m×n rows in the result.
*/

use [Northwind]
GO

SELECT O.OrderID, O.Freight, C.ContactName FROM Orders AS O CROSS JOIN Customers AS C  WHERE O.Freight>400 ;



--(INNER) JOIN: Returns records that have matching values in both tables

	--- DOWNLOAD THE SCRIPT FROM

-- https://github.com/microsoft/sql-server-samples/blob/master/samples/databases/northwind-pubs/instnwnd.sql

USE [Northwind]
GO
SELECT Orders.OrderID, Customers.ContactName FROM Orders INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

SELECT O.ShipName, C.ContactName, OD.Discount FROM ((Orders AS O
		INNER JOIN Customers AS C ON O.CustomerID = C.CustomerID)
		INNER JOIN [Order Details] AS OD ON OD.OrderID=O.OrderID)
/*
The LEFT JOIN keyword returns all records from the left table (table1), and the matched records from 
the right table (table2). The result is NULL from the right side, if there is no match
*/

SELECT Orders.OrderID, Customers.ContactName FROM Orders LEFT JOIN Customers ON  Customers.CustomerID=Orders.CustomerID;

SELECT O.ShipName, C.ContactName, OD.Discount FROM ((Orders AS O
		LEFT JOIN Customers AS C ON O.CustomerID = C.CustomerID)
		LEFT JOIN [Order Details] AS OD ON OD.OrderID=O.OrderID) ORDER BY C.ContactName;

/*
The RIGHT (OUTER) JOIN keyword returns all records from the right table (table2), and the matched records 
from the left table (table1). The result is NULL from the left side, when there is no match.
*/

SELECT O.OrderID, O.Freight, C.ContactName FROM Orders AS O RIGHT JOIN Customers AS C ON O.CustomerID = C.CustomerID 
WHERE O.Freight>30 ;

SELECT O.OrderID, O.Freight, C.ContactName FROM Orders AS O RIGHT OUTER JOIN Customers AS C ON O.CustomerID = C.CustomerID 
WHERE O.Freight>30 ;

/*
The FULL (OUTER) JOIN keyword return all records when there is a match in either left (table1) or right (table2) table records.
*/

SELECT O.OrderID, O.Freight, C.ContactName FROM Orders AS O FULL OUTER JOIN Customers AS C ON O.CustomerID = C.CustomerID 
WHERE O.Freight>70 ;

SELECT O.OrderID, O.Freight, C.ContactName FROM Orders AS O FULL JOIN Customers AS C ON O.CustomerID = C.CustomerID 
WHERE O.Freight>70 ;

/*
A self JOIN is a regular join, but the table is joined with itself.
*/


SELECT A.ContactName AS Name_A, B.ContactName AS Name_B from Customers A, Customers B 
 WHERE B.ContactName<>A.ContactName AND A.City=B.City ;

SELECT A.ContactName AS AName, B.ContactName AS BName from Customers A INNER JOIN Customers B 
ON A.CustomerID=B.CustomerID ;




USE [Tutorials]
GO
INSERT INTO weather (city, temp_lo, temp_hi, prcp, date) VALUES ('San Francisco', 45, 52, 0.1, '1994-11-30');

INSERT INTO weather (city,temp_lo,temp_hi,prcp,[date]) VALUES('Accra' , 43.0,60,NULL,'2021-10-11'),
('Takoradi',47,60,NULL,'2021-10-11');

--- different ways to replace null values
/*
The ISNULL function accepts two arguments as input and returns the first that is not NULL, otherwise NULL if both are NULL.
For example ISNULL(col, '') returns the col value if it isn’t NULL and an empty string if it is NULL.

The syntax of the ISNULL function
ISNULL(check_expression, replacement_ value)

*/

USE [Tutorials]
GO
SELECT * FROM weather;
-- return the value of prcp if not null otherwise return 2 and we named this column new_prcp
SELECT city, prcp, ISNULL(prcp,2) new_prcp from weather;

/* COALESCE IS SIMILAR TO ISNULL but more flexible because it lets you specify a list of values. Then, it
returns the first non-null value in the list. By contrast,
*/
SELECT city, prcp, COALESCE(prcp,2) new_prcp from weather;

USE [AdventureWorks2019]
GO
--select * from Production.Product;
--select * from Purchasing.ProductVendor;

select PP.Name , COALESCE(CAST(PPV.OnOrderQty AS VARCHAR),'Unknown') AS QTY from Production.Product AS PP 
LEFT JOIN Purchasing.ProductVendor AS PPV  ON PP.ProductID=PPV.ProductID;

/*
CASE expressions
A CASE expression is a scalar expression that returns a value based on conditional logic.

There are two forms of CASE expressions: simple and searched.
*/

--simple CASE function
USE [Tutorials]
GO
SELECT city,temp_hi,
	CASE temp_hi 
	WHEN 50 THEN 'Good Weather'
	WHEN 52 THEN 'The Weather is ok'
	WHEN 53 THEN 'Bad Weather'
	WHEN 54 THEN 'Worse Weather'
	WHEN 57 THEN 'Worst Weather'
	ELSE 'Too High' END AS Weather_Condition FROM weather;

	-- searched CASE function
USE [AdventureWorks2019]
GO
SELECT [Name], ProductID,
	CASE 
		WHEN ProductID < 100 THEN 'Beverages'
		WHEN ProductID < 200THEN 'Condiments'
		WHEN ProductID  < 300 THEN 'Confections'
		WHEN ProductID < 350 THEN 'Dairy Products'
		WHEN ProductID < 490 THEN 'Grains/Cereals'
		WHEN ProductID < 550 THEN 'Meat/Poultry'
		WHEN ProductID < 500 THEN 'Produce'
		WHEN ProductID < 600THEN 'Seafood'
	ELSE 'Unknown Category'
END AS ProductName FROM Production.Product

USE [AdventureWorks2019]
GO

SELECT ProductName, count(*) as Count from 
				(SELECT [Name], ProductID,
						CASE 
							WHEN ProductID < 100 THEN 'Beverages'
							WHEN ProductID < 200THEN 'Condiments'
							WHEN ProductID  < 300 THEN 'Confections'
							WHEN ProductID < 350 THEN 'Dairy Products'
							WHEN ProductID < 490 THEN 'Grains/Cereals'
							WHEN ProductID < 550 THEN 'Meat/Poultry'
							WHEN ProductID < 500 THEN 'Produce'
							WHEN ProductID < 600THEN 'Seafood'
						ELSE 'Unknown Category'
					END AS ProductName FROM Production.Product) as PP GROUP BY ProductName 
					HAVING ProductName='Beverages' OR ProductName='Dairy Products';



--- UNION

/* The UNION operator is used to combine the result-set of two or more SELECT statements.
It Specifies that multiple result sets are to be combined and returned as a single result
  
  1. Every SELECT statement within UNION must have the same number of columns
T 2. he columns must also have similar data types
  3.The columns in every SELECT statement must also be in the same order

The UNION operator selects only distinct values by default. To allow duplicate values, use UNION ALL:

SELECT column_name(s) FROM table1
UNION ALL
SELECT column_name(s) FROM table2;

-- copy the script from this site and run to get the database used here
https://en.wikiversity.org/wiki/Database_Examples/Northwind/SQL_Server
*/

--returns the cities (only distinct values) from both the "Customers" and the "Suppliers" table:

USE [Northwinds] 
GO
select City from Customers 
UNION
SELECT City from Suppliers;


select City, ContactName from Customers 
UNION
SELECT City , ContactName from Suppliers;


--Union all allows duplicate

select City, ContactName from Customers 
UNION all
SELECT City , ContactName from Suppliers;




