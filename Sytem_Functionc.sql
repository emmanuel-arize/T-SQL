--USE master --AdventureWorks2019;  
--GO  
-- select name,database_id,create_date FROM sys.databases;

USE [Northwinds]
GO


--AGGREGATE FUNCTIONCS

---APPROX_COUNT_DISTINCT 
-- This function returns the approximate number of unique non-null values in a group.

SELECT APPROX_COUNT_DISTINCT(CategoryID) AS approx_distinct_category_id  FROM Products;
select distinct(CategoryID) AS  Unique_Cate_ID FROM Products;


SELECT APPROX_COUNT_DISTINCT(ProductName) AS approx_distinct_category_id  FROM Products;
select distinct(ProductName) AS  Unique_Cate_ID FROM Products;


--This example returns the approximate number of different productName by Category Id from the Product table
-- in other words how many DIFFERENT product names do the various  CATEGORY ID CONTAINS

SELECT CategoryID, APPROX_COUNT_DISTINCT(ProductName) AS approx_distinct_category_id  FROM Products Group BY CategoryID;


-- -------AVG

/*-This function returns the average of the values in a group. It ignores null values

 AVG () computes the average of a set of values by dividing the sum of those values by the count of nonnull
values.
*/
SELECT AVG(Price) AS Avg_Price  FROM Products;

-- THE AVERAGE PRICE OF EACH CATEGORY by category id

SELECT CategoryID, AVG(Price) AS Avg_Price  FROM Products Group BY CategoryID;


 SELECT CountryRegionCode, AVG(SalesYTD) AS Avg_YTD_Sales from  [AdventureWorks2019].[Sales].[SalesTerritory] group by CountryRegionCode ORDER BY 
 Avg_YTD_Sales DESC;



-- SUM
SELECT SUM(Price) as [Total Price] FROM Products;

SELECT CategoryID, AVG(Price) AS [Avg Price], SUM(Price) AS [Total Price]  FROM Products Group BY CategoryID;
 
  SELECT CountryRegionCode, AVG(SalesYTD) AS Avg_YTD_Sales,  sum(SalesYTD) AS Total_YTD_Sales from  [AdventureWorks2019].[Sales].[SalesTerritory] group by CountryRegionCode ORDER BY 
 Total_YTD_Sales DESC;


 --- Here’s a simple query that returns the total sum of sales for each year.
   select BusinessEntityID, DATEPART(yy,ModifiedDate) AS SalesYear,  
   SUM(SalesYTD) OVER( partition BY DATEPART(yy,ModifiedDate)) AS CumulativeTotal   FROM [AdventureWorks2019].[Sales].[SalesPerson]
   
   
 --- Here’s a simple query that returns the total sum AND AVG of sales for each year.
   
 select BusinessEntityID, DATEPART(yy,ModifiedDate) AS SalesYear, SUM(SalesYTD) OVER(ORDER BY DATEPART(yy,ModifiedDate)) AS CumulativeTotal,  
 AVG(SalesYTD) OVER(ORDER BY DATEPART(yy,ModifiedDate)) AS MovingAvg	  FROM [AdventureWorks2019].[Sales].[SalesPerson] ORDER BY SalesYear DESC;

 

