

USE [AdventureWorks2019]
GO
select * FROM HumanResources.Employee;


-- Table Aliases

select E.* FROM HumanResources.Employee as E;


select E.NationalIDNumber AS [Nat ID],E.JobTitle AS Job, E.Gender FROM HumanResources.Employee as E;


SELECT HE.JobTitle, HE.MaritalStatus FROM (SELECT JobTitle, MaritalStatus,Gender FROM HumanResources.Employee) AS HE;



 -- WHERE STATEMENTS
 SELECT *  FROM Person.StateProvince WHERE Name='Arizona';
select JobTitle,MaritalStatus,Gender from HumanResources.Employee where MaritalStatus='M';
select JobTitle,MaritalStatus,Gender from HumanResources.Employee where JobTitle='Marketing Assistant' AND  Gender='F';
select JobTitle,MaritalStatus,Gender from HumanResources.Employee where MaritalStatus='M'OR  Gender='F' ;
 select JobTitle,MaritalStatus,Gender from HumanResources.Employee where NOT JobTitle='Design Engineer';

select JobTitle,MaritalStatus,Gender from HumanResources.Employee where NOT JobTitle='Design Engineer' AND (MaritalStatus='M' OR Gender='M');
select JobTitle,MaritalStatus,Gender from HumanResources.Employee where NOT JobTitle='Design Engineer' AND (MaritalStatus='M' AND Gender='M');
select JobTitle,MaritalStatus,Gender from HumanResources.Employee where NOT JobTitle='Design Engineer' AND NOT JobTitle='Senior Tool Designer';

-- ORDER BY
select JobTitle AS JOB,MaritalStatus,Gender from HumanResources.Employee where NOT JobTitle='Design Engineer' ORDER BY JobTitle;
select JobTitle AS JOB,MaritalStatus,Gender from HumanResources.Employee where NOT JobTitle='Design Engineer' ORDER BY JobTitle desc;
select JobTitle AS JOB,MaritalStatus,Gender from HumanResources.Employee where NOT JobTitle='Design Engineer' ORDER BY JobTitle asc;
select JobTitle AS JOB,MaritalStatus,Gender from HumanResources.Employee where NOT JobTitle='Design Engineer' ORDER BY JobTitle , MaritalStatus;

select JobTitle AS JOB,MaritalStatus,Gender from HumanResources.Employee where NOT JobTitle='Design Engineer'  ORDER BY JobTitle DESC, MaritalStatus DESC;


select FirstName, MiddleName, LastName FROM Person.Person order by LastName;

select FirstName, MiddleName, LastName FROM Person.Person order by LastName, FirstName;

select DISTINCT FirstName + ' ' + LastName AS FullName FROM Person.Person order by FirstName + ' ' + LastName;



 --DISTINCT
 -- The SELECT DISTINCT statement is used to return only distinct values.
select distinct JobTitle as job from HumanResources.Employee;
 select count( distinct JobTitle) as job from HumanResources.Employee;
select distinct JobTitle as job ,MaritalStatus as MStatus  from HumanResources.Employee;

SELECT DISTINCT(P.Name) FROM Production.ProductModel AS P;



 /* TOP Clause


The TOP clause specifies the first n rows of the query result that are to be retrieved. This clause should always
be used with the ORDER BY clause, because the result of such a query is always well defined and can be used in table expressions
*/
-- First 10 employees hired first
select TOP(10) OrganizationLevel, JobTitle , HireDate from HumanResources.Employee Order By HireDate ASC;

-- 8 top MOST Expensive product based on listPrice
SELECT TOP(8) [Name],StandardCost, ListPrice, SellStartDate FROM Production.Product ORDER BY ListPrice DESC;


select * from Production.Product;
select * from HumanResources.Employee ;

  /* The WITH TIES Option
The WITH TIES option is important to the TOP() predicate. It enables the last place to
include multiple rows if those rows have equal values in the columns used in the ORDER BY
clause.*/

-- First 10 employees hired first
--select TOP(10) OrganizationLevel, JobTitle , HireDate from HumanResources.Employee Order By HireDate ASC;
select TOP(10) WITH TIES  OrganizationLevel, JobTitle , HireDate from HumanResources.Employee Order By HireDate ASC;

-- 8 top MOST Expensive product based on listPrice
SELECT TOP(8) WITH TIES [Name],StandardCost, ListPrice, SellStartDate FROM Production.Product ORDER BY ListPrice DESC;






--- PERCENT

--This example limits SELECT result to 15 percentage of total row count.
select * from HumanResources.Employee where NOT JobTitle='Design Engineer';--- TOTAL ROW COUNT=287
select TOP 10 PERCENT * from HumanResources.Employee where NOT JobTitle='Design Engineer';--10% OF 287=28.7=29






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

		-- SEARCH FOR NAMES THAT BEGIN  WITH A
SELECT [Name],CountryRegionCode, StateProvinceCode  FROM Person.StateProvince  WHERE Name LIKE 'A%' ;


-- SEARCH FOR NAMES THAT END WITH A
SELECT [Name],CountryRegionCode, StateProvinceCode  FROM Person.StateProvince  WHERE Name LIKE '%A' ;

-- SEARCH FOR NAMES STARTING AND ENDING WITH A
SELECT [Name],CountryRegionCode, StateProvinceCode  FROM Person.StateProvince  WHERE Name LIKE 'A%A' ;

-- select NAMEs CONTAING "a" as the scond position
SELECT [Name],CountryRegionCode, StateProvinceCode  FROM Person.StateProvince  WHERE Name LIKE '_A%' ;


-- select NAMEs CONTAING "a" as the third position
SELECT [Name],CountryRegionCode, StateProvinceCode  FROM Person.StateProvince  WHERE Name LIKE '__A%' ;

--Finds any names that have "Al" in any position OR name that contain AI

SELECT Name,CountryRegionCode, StateProvinceCode    FROM Person.StateProvince  WHERE Name LIKE '%Al%';

--Finds names that begining with letters between "a" and "d" in inclusive

SELECT Name,CountryRegionCode, StateProvinceCode    FROM Person.StateProvince  WHERE Name LIKE '[a-d]%';


--Finds names that start with characters within the bracket

SELECT Name,CountryRegionCode, StateProvinceCode    FROM Person.StateProvince  WHERE Name LIKE '[ABCD]%';

--Finds names that start with characters not in the bracket

SELECT Name,CountryRegionCode, StateProvinceCode    FROM Person.StateProvince  WHERE Name LIKE '[^ABCD]%';

--- MULTIPLE WHERE CLAUSES
SELECT ProductID, Name FROM Production.Product WHERE Name LIKE 'Ch%' OR ProductID BETWEEN 320 AND 324 AND Name Like '%s%';
 



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

select city, SUM(temp_lo) as sum_temp_lo from weather GROUP BY city;
select city, AVG(temp_lo) as avg_temp_Lo from weather GROUP BY city;


select city, AVG(temp_lo+temp_hi) as avg_temp from weather GROUP BY city;


USE [AdventureWorks2019]
GO

SELECT  Color,SUM(ListPrice) as Price from Production.Product where ListPrice>0  GROUP BY Color;

-- The HAVING clause 

-- Whereas the WHERE clause is a row filter, the HAVING clause is a group filter

-- sum of listprice where LP>0 AND the number of times a color appears in a row is more than 30 
-- group by color

SELECT Color,SUM(ListPrice) as Price, COUNT(*) AS Count from Production.Product where ListPrice>0  GROUP BY Color HAVING COUNT(*)>30;


SELECT Color,SUM(ListPrice) as Price,  COUNT(*) AS Count from Production.Product where ListPrice>0  GROUP BY Color HAVING COUNT(*)<30



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

select PP.Name,PPV.OnOrderQty, COALESCE(CAST(PPV.OnOrderQty AS VARCHAR),'Unknown') AS QTY  from Production.Product AS PP 
LEFT JOIN Purchasing.ProductVendor AS PPV  ON PP.ProductID=PPV.ProductID;


////

SELECT MAX(VacationHours) AS [Max Vacation Hours] from HumanResources.Employee;

SELECT MIN(VacationHours) AS [Min Vacation Hours]  from HumanResources.Employee;


