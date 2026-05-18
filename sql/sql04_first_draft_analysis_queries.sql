GO

--Revenue trends
SELECT
	YEAR(InvoiceDate) AS Sales_Year,
	MONTH(InvoiceDate) AS Sales_Month,
	SUM(Revenue) AS Total_Monthly_Revenue,
	SUM(Quantity) AS Total_Units_Sold,
	COUNT(DISTINCT InvoiceNo) AS Total_Orders,
	SUM(Revenue) / COUNT(DISTINCT InvoiceNo) AS Avg_Revenue_Per_Order
FROM
	sales_overall
GROUP BY
	YEAR(InvoiceDate),
	MONTH(InvoiceDate)
ORDER BY
	YEAR(InvoiceDate) ASC,
	MONTH(InvoiceDate) ASC

GO

--Sales by country
SELECT
	Country,
	SUM(Revenue) AS Total_Revenue
FROM
	sales_overall
GROUP BY
	Country
ORDER BY
	Total_Revenue DESC

GO

--Sales by stock_code
SELECT
	StockCode,
	Description,
	SUM(Revenue) AS Total_Revenue
FROM
	sales_overall
GROUP BY
	StockCode,
	Description
ORDER BY
	Total_Revenue DESC

GO

--Customer level sales
SELECT
	CustomerID,
	SUM(Revenue) AS Total_Revenue
FROM
	customer_level_sales
GROUP BY
	CustomerID
ORDER BY
	Total_Revenue DESC

GO

--Cancelled orders
SELECT
	InvoiceNo,
	SUM(Revenue) AS Total_Revenue_Lost
FROM
	cancelled_sales
GROUP BY
	InvoiceNo
ORDER BY
	SUM(Revenue) ASC

GO