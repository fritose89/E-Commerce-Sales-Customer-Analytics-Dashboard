GO

--Monthy revenue trends
--CREATE OR ALTER VIEW dbo.monthly_sales_summary AS
SELECT
	YEAR(InvoiceDate) AS Sales_Year,
	MONTH(InvoiceDate) AS Sales_Month,
	SUM(Revenue) AS Total_Monthly_Revenue,
	SUM(Quantity) AS Total_Units_Sold,
	COUNT(DISTINCT InvoiceNo) AS Total_Orders,
	SUM(Revenue) / NULLIF(COUNT(DISTINCT InvoiceNo), 0) AS Avg_Revenue_Per_Order
FROM
	sales_overall
GROUP BY
	YEAR(InvoiceDate),
	MONTH(InvoiceDate)

GO

--Sales by country
--CREATE OR ALTER VIEW dbo.geographic_sales_summary AS
SELECT
	Country,
	SUM(Revenue) AS Total_Revenue,
	SUM(Quantity) AS Total_Units_Sold,
	COUNT(DISTINCT InvoiceNo) AS Total_Orders,
	COUNT(DISTINCT CustomerID) AS Unique_Customers,
	SUM(Revenue) / NULLIF(COUNT(DISTINCT InvoiceNo), 0) AS Avg_Revenue_Per_Order
FROM
	sales_overall
GROUP BY
	Country

GO

--Sales by stock_code
--CREATE OR ALTER VIEW dbo.product_sales_summary AS
SELECT
	StockCode,
	Description,
	SUM(Revenue) AS Total_Revenue,
	SUM(Quantity) AS Total_Units_Sold,
	COUNT(DISTINCT InvoiceNo) AS Total_Orders,
	COUNT(DISTINCT CustomerID) AS Unique_Customers
FROM
	sales_overall
GROUP BY
	StockCode,
	Description


GO

--Customer level sales
--CREATE OR ALTER VIEW dbo.customer_level_sales_summary AS
SELECT
	CustomerID,
	SUM(Revenue) AS Total_Revenue,
	SUM(Quantity) AS Total_Units_Sold,
	COUNT(DISTINCT InvoiceNo) AS Total_Orders,
	MIN(InvoiceDate) AS First_Order_Date,
	MAX(InvoiceDate) AS Last_Order_Date,
	SUM(Revenue) / NULLIF(COUNT(DISTINCT InvoiceNo), 0) AS Avg_Revenue_Per_Order
FROM
	customer_level_sales
GROUP BY
	CustomerID


GO

--Cancelled orders
--CREATE OR ALTER VIEW dbo.cancelled_orders_summary AS
SELECT
	InvoiceNo,
	CustomerID,
	Country,
	SUM(Quantity) AS Total_Cancelled_Units,
	SUM(Revenue) AS Total_Revenue_Lost
	 
FROM
	cancelled_sales
GROUP BY
	InvoiceNo,
	CustomerID,
	Country


GO