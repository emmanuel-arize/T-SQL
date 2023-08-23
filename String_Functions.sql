
select ASCII('7');

-- PRINT THE numbers 0 to 9

DECLARE @start int;
set @start=48
PRINT 'Numbers 0 TO 9';
while(@start<=57)
BEGIN
	PRINT CHAR(@start)
    SET @start=@start+1
END

USE [Northwind]
GO
select * from Customers;

SELECT LOWER(CompanyName) AS NAME ,LEN(CompanyName) AS LenghtOfCName, UPPER(ContactName) AS CotactName, 
LEFT(CompanyName,5)  as [First 5 etters] FROM dbo.Customers;


USE [AdventureWorks2019]
GO

select *  FROM Person.EmailAddress;

------------------------------------------

-- The CHARINDEX() function searches for a substring in a string, and returns the position.\
-- CHARINDEX ( expressionToFind , expressionToSearch [ , start_location ] )





--Search for "@" in string "EmailAddress", and return position:
select EmailAddress, CHARINDEX('@', EmailAddress) FROM Person.EmailAddress;

select EmailAddress, LEFT(EmailAddress, CHARINDEX('@', EmailAddress)-1) FROM Person.EmailAddress;


select EmailAddress, RIGHT(EmailAddress, LEN(EmailAddress)-CHARINDEX('@', EmailAddress)) as Domain FROM 
Person.EmailAddress;

DECLARE @document VARCHAR(64);  
SELECT @document = 'Reflectors are vital safety' +  ' components of your bicycle.';  
SELECT CHARINDEX('bicycle', @document);  

/*
 Searching from a specific position
This example uses the optional start_location parameter to start the search for vital at the fifth 
character of the searched string value variable @document.
*/
DECLARE @document2 VARCHAR(64);  
SELECT @document2 = 'Reflectors are vital safety' +  ' components of your bicycle.';  
SELECT CHARINDEX('Bicycle', @document2,20); 

--case-sensitive search;  

DECLARE @document1 VARCHAR(64);  
SELECT @document1 = 'Reflectors are vital safety' +  ' components of your bicycle.';  
SELECT CHARINDEX('Bicycle', @document1 COLLATE Latin1_General_CS_AS); 

---------------------------------------------------------------

-- The SUBSTRING() function extracts some characters from a string.
-- SUBSTRING(string, start, length)

---Extract 3 characters from a string, starting in position 1:
SELECT SUBSTRING('SQL Tutorial', 1, 3) AS ExtractString;



select substring(EmailAddress, CHARINDEX('@', EmailAddress)+1,LEN(EmailAddress)-CHARINDEX('@', EmailAddress)) 
FROM Person.EmailAddress;

-------


-- Space function 
-- Returns a string of repeated spaces

-- SPACE ( integer_expression )

-- integer_expression: Is a positive integer that indicates the number of spaces. If integer_expression is negative, a null string is returned


USE [Northwind]
GO

SELECT FirstName, LastName, FirstName + SPACE(3)+ LastName AS FullName  FROM dbo.Employees;

---------------------------
--Patindex

-- Returns the starting position of the first occurrence of a pattern in a specified expression, or zero if the pattern is not found, on all valid text and character data types.

--- PATINDEX ( '%pattern%' , expression )

SELECT POSITION= Patindex('%SQL%' ,'Transact SQL')

----------------

---Replaces all occurrences of a specified string value with another string value

--REPLACE ( string_expression , string_pattern , string_replacement )

SELECT REPLACE('MYSQL','MY','TRANSACT-');

