USE Sales;

-- 1) Monthly Performance Analysis
SELECT 
	YEAR(Order_Date) AS Year,
    MONTH(Order_Date) AS Month,
    SUM(Sales) AS Monthly_Sales,
	SUM(Profit) AS Monthly_Profit
FROM Orders
GROUP BY Year, Month
ORDER BY Year, Month;
 
 
-- 2) Growth Rate Calculation (Using Subquery)
SELECT
	t1.Month,
    t1.Monthly_Sales,
    t2.Monthly_Sales AS Previous_Month_Sales,
    ((t1.Monthly_Sales - t2.Monthly_Sales) / t2.Monthly_Sales)* 100 AS Growth_Percentage
FROM 
	(SELECT MONTH(Order_Date) AS Month,
			SUM(Sales) AS Monthly_Sales
	 FROM Orders
     GROUP BY MONTH) t1
JOIN 
	(SELECT MONTH(Order_Date) AS Month,
			SUM(Sales) AS Monthly_Sales
	 FROM Orders
     GROUP BY MONTH) t2
ON t1.Month = t2.Month + 1;


-- 3) Using CASE for Business Classification
SELECT 
	Order_ID,
	Sales,
    CASE
		WHEN Sales > 1000 THEN 'High Value'
        WHEN Sales BETWEEN 500 AND 1000 THEN 'Medium Value'
        ELSE 'Low Value'
	END AS Order_Type
From Orders;


-- 4) Identify underperfforming Regions
SELECT
	c.Region,
    SUM(o.Profit) AS Total_Profit
FROM Orders o
JOIN Customers c
ON o.Customer_ID = c.Customer_ID
GROUP BY c.Region
HAVING Total_Profit < 1000;


