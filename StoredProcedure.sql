
USE [Northwinds]
GO
-- LET DECLARE A VARIABLE
/*
 T-SQL variables are created with the DECLARE command. The DECLARE command is followed by the vari￾able name and data type.
*/

DECLARE @Test INT ,@TestTwo NVARCHAR(25);

SET @Test = 1;
SET @TestTwo = 'a value';
SELECT @Test AS TEST, @TestTwo AS TES2;
GO

DECLARE @Count as int;
SET @Count=(SELECT COUNT(*) FROM Customers);
SELECT @Count AS [@COUNT] ;

DECLARE @Country nvarchar(40)='UK';
select CustomerName,Country from Customers where Country=@Country;


DECLARE @Country1 nvarchar(40)
set @Country1='UK';
select CustomerName,Country from Customers where Country=@Country1;


/*
A stored procedure is a prepared SQL code that you can save, so the code can be reused over and over again.

So if you have an SQL query that you write over and over again, save it as a stored procedure, and then just call it to execute it.

You can also pass parameters to a stored procedure, so that the stored procedure can act based on the parameter value(s) that is passed.

Stored Procedure Syntax
CREATE PROCEDURE procedure_name
AS
sql_statement
GO;

Execute a Stored Procedure
 EXEC procedure_name;
*/
CREATE PROCEDURE SelectAllCustomerS
				AS
				SELECT * FROM Customers
				GO


-- EXCUTING THE STORED PROCEDURE

EXEC SelectAllCustomers;

USE [AdventureWorks2019]
GO

CREATE PROCEDURE Bonus
AS
BEGIN
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

END

EXECUTE Bonus;

-- -- to view the definition of  a STORED PROCEDURE
sp_helptext Bonus;



/*
Stored Procedure With One Parameter
The following SQL statement creates a stored procedure that selects Customers from a particular City from the "Customers" table:
*/
USE [Northwinds]
GO
sp_help Customers;-- all simple highlight Customers and press alt + f1

CREATE PROCEDURE SelectCustomerFromACity @City nvarchar(40)
AS
SELECT * FROM Customers where City=@City
GO

EXEC  SelectCustomerFromACity @City="Berlin";

/*
Stored Procedure With Multiple Parameters
Setting up multiple parameters is very easy. Just list each parameter and the data type separated by a comma as shown below.
*/


CREATE PROCEDURE SelectCertainCityOrCountry
	@City nvarchar(40),
	@Country nvarchar(50)
	AS
BEGIN
			SELECT * FROM Customers where City=@City Or Country=@Country
END
GO

EXECUTE SelectCertainCityOrCountry "Berlin", "UK";

-- to view the definition of  a STORED PROCEDURE
sp_helptext SelectCertainCityOrCountry;


-- to change or alter the definition of stored procedure

ALTER PROCEDURE SelectCertainCityOrCountry @City nvarchar(40), @Country nvarchar(50)
AS
BEGIN
   SELECT CustomerID,CustomerName,City,Country FROM Customers where City=@City Or Country=@Country
END
GO 


ALTER PROCEDURE SelectCertainCityOrCountry @City nvarchar(40), @Country nvarchar(50)
WITH ENCRYPTION --WITH THIS USERS CANNOT USE sp_helptext to access the definition
AS
BEGIN
   SELECT CustomerID,CustomerName,City,Country FROM Customers where City=@City Or Country=@Country
END
GO 


EXECUTE SelectCertainCityOrCountry "Berlin", "UK";


-- to view the definition of  a STORED PROCEDURE

sp_helptext SelectCertainCityOrCountry;

-- getting help on stored procedure
sp_help SelectCertainCityOrCountry;

--dropping a procedure

drop proc  SelectAllCustomers;

USE [AdventureWorks2019]
GO
CREATE PROCEDURE ProductIDandName
AS 
BEGIN
	SET NOCOUNT ON;
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
	 END AS ProductName FROM Production.Product;
END

EXEC ProductIDandName;


CREATE PROCEDURE MyProducts
AS
BEGIN
SET NOCOUNT ON;
SELECT ProductName, Name  from 
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
					END AS ProductName FROM Production.Product) as PP WHERE ProductName='Dairy Products';

END


ALTER PROCEDURE MyProducts @ProductName NVARCHAR(50)
AS
BEGIN
SET NOCOUNT ON;
SELECT ProductName, Name  from 
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
					END AS ProductName FROM Production.Product) as PP WHERE ProductName=@ProductName
END

					
EXEC MyProducts "Dairy Products";



--STORED PROCEDURE WITH OUTPUT PARAMETER


CREATE PROC ProcWithOutputParameter @Product as nvarchar(50), @ProuctCount int output
AS
BEGIN
SET NOCOUNT ON;
SELECT  @ProuctCount= count(*) from 
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
					HAVING ProductName=@Product
		END


-- TO EXEC PROC WITH AN OUTPUT PARAMETER WE HAVE TO DECLARE A VARIABLE THAT WILL HOLD THE OUTPUT PARA RESULTS
DECLARE @TotalNumProduct int;
EXEC ProcWithOutputParameter @Product="Dairy Products",@ProuctCount=@TotalNumProduct output;
PRINT @TotalNumProduct ;

DECLARE @TotalNumProduct int;
EXEC ProcWithOutputParameter "Dairy Products", @TotalNumProduct output;
PRINT 'The number of rows containing Dairy Products is ' + cast(@TotalNumProduct as varchar) ;

--info about the stored procedure
sp_help  ProcWithOutputParameter ;

--text of the proc
sp_helptext ProcWithOutputParameter ;

-- viewing dependances of the proc

sp_depends ProcWithOutputParameter ;






--- NEXT TIME 20