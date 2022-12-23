

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






