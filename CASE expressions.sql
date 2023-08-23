
/*
CASE expressions
A CASE expression is a scalar expression that returns a value based on conditional logic.

There are two forms of CASE expressions: simple and searched.
*/

--simple CASE function
--- CASE WHEN <spreading_col> = <target_col_element> THEN <expression> END
-- A CASE expression with no ELSE clause has an implicit ELSE NULL.

USE [Tutorials]
GO
SELECT city,temp_hi,
	CASE temp_hi 
	WHEN 50 THEN 'Good Weather'
	WHEN 52 THEN 'The Weather is ok'
	WHEN 53 THEN 'Bad Weather'
	WHEN 54 THEN 'Worse Weather'
	--WHEN 57 THEN 'Worst Weather'
	ELSE 'Too High' END AS Weather_Condition FROM weather;

	-- searched CASE function
USE [AdventureWorks2019]
GO



select top(3) * from HumanResources.Department;


select TOP(3) * from HumanResources.EmployeeDepartmentHistory

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
					END AS ProductName FROM Production.Product) as PP GROUP BY ProductName ;

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


select  PP.FirstName +' '+PP.LastName as Name, HD.DepartmentID,HD.GroupName,HD.Name AS [Dept Name] ,HE.OrganizationLevel,
 CASE
	WHEN HE.OrganizationLevel =1 THEN 1000
	WHEN HE.OrganizationLevel =2 THEN 500
	ELSE 100
	END AS Bonus 

from (((HumanResources.Department as HD 
LEFT JOIN HumanResources.EmployeeDepartmentHistory AS HED ON HD.DepartmentID=HED.BusinessEntityID)
LEFT JOIN HumanResources.Employee AS HE ON HE.BusinessEntityID=HED.BusinessEntityID)
LEFT JOIN Person.Person AS PP ON PP.BusinessEntityID=HE.BusinessEntityID)

-- Search Case
--The searched CASE form is more flexible in the sense you can specify predicates in the WHEN clauses rather than being 
--restricted to using equality comparisons

SELECT ProductName, count(*) as Count from 
				(SELECT [Name], ProductID,
						CASE 
							WHEN ProductID IN ( 100,200,300) THEN 'Beverages'
							WHEN ProductID IN ( 400,500) THEN 'Condiments'
		
						ELSE 'Unknown Category'
					END AS ProductName FROM Production.Product) as PP GROUP BY ProductName ;

SELECT [Name], ProductID,
						CASE 
							WHEN ProductID IN ( 100,200,300) THEN 'Beverages'
							WHEN ProductID IN ( 400,500) THEN 'Condiments'
						ELSE 'Seafood'
					END AS ProductName FROM Production.Product;

SELECT [Name], ProductID,
						CASE 
							WHEN ProductID BETWEEN 0 AND 301 THEN 'Beverages'
							WHEN ProductID IN ( 400,500) THEN 'Condiments'
						ELSE 'Seafood'
					END AS ProductName FROM Production.Product;
SELECT * FROM Production.Product;

select  PP.FirstName +' '+PP.LastName as Name, HD.DepartmentID,HD.GroupName,HD.Name AS [Dept Name] ,HE.OrganizationLevel,
 CASE
	WHEN HE.OrganizationLevel in (1,2) THEN 1000
	WHEN HE.OrganizationLevel =3 THEN 500
	ELSE 100
	END AS Bonus 

from (((HumanResources.Department as HD 
LEFT JOIN HumanResources.EmployeeDepartmentHistory AS HED ON HD.DepartmentID=HED.BusinessEntityID)
LEFT JOIN HumanResources.Employee AS HE ON HE.BusinessEntityID=HED.BusinessEntityID)
LEFT JOIN Person.Person AS PP ON PP.BusinessEntityID=HE.BusinessEntityID)
 

