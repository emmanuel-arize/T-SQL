
SELECT POWER(5,2); --25

SELECT FLOOR(2.5); --2

DECLARE @COUNTER INT;
SET @COUNTER=1;
WHILE (@COUNTER<=6)
Begin
	 PRINT FLOOR( RAND()*10); 
	 set @COUNTER=@COUNTER+1;
End
SELECT CEILING(2.5); ---3

SELECT SQUARE(4);

USE [Northwind]
GO
SELECT COUNT(ProductName) AS Product FROM Products;

--ROUND
--Returns a numeric value, rounded to the specified length or precision.
/* 

ROUND ( numeric_expression , length [ ,function ] ) 

Returns a numeric value, rounded to the specified length or precision.

length

Is the precision to which numeric_expression is to be rounded. length must be an expression of type 
tinyint, smallint, or int. When length is a positive number, numeric_expression is rounded to the number o
f decimal positions specified by length. When length is a negative number, numeric_expression is rounded on the 
left side of the decimal point, as specified by length.

function
*/

print ROUND(4536.44553,2);

print ROUND(4536.44553,1,2);

print ROUND(4536.44553,-2);

print ROUND(4536.44553,-1);
print ROUND(4536.44553,-3);
