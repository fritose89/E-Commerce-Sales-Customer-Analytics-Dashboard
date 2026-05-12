--Total Row Count
SELECT
	COUNT(*) AS total_rows
FROM 
	[retail_sales_analytics].[dbo].[online_retail_raw_data];


--Unique values from each column
SELECT
	COUNT(DISTINCT InvoiceNo) AS unique_invoices,
	COUNT(DISTINCT CustomerID) AS unique_customers,
	COUNT(DISTINCT Country) AS unique_countries,
	COUNT(DISTINCT StockCode) AS unique_products
FROM
	[retail_sales_analytics].[dbo].[online_retail_raw_data];


--Missing values and Null values
SELECT
	SUM(CASE WHEN CustomerID IS NULL OR CustomerID = '' THEN 1 ELSE 0 END) AS num_missing_customer_id,
	SUM(CASE WHEN Description IS NULL OR Description = '' THEN 1 ELSE 0 END) AS num_missing_description,
	SUM(CASE WHEN InvoiceDate IS NULL OR InvoiceDate = '' THEN 1 ELSE 0 END) AS num_missing_invoice_date,
	SUM(CASE WHEN InvoiceNo IS NULL OR InvoiceNo = '' THEN 1 ELSE 0 END) AS num_missing_invoice_no,
	SUM(CASE WHEN StockCode IS NULL OR StockCode = '' THEN 1 ELSE 0 END) AS num_missing_stock_code,
	SUM(CASE WHEN Quantity IS NULL OR Quantity = '' THEN 1 ELSE 0 END) AS num_missing_quantity,
	SUM(CASE WHEN UnitPrice IS NULL OR UnitPrice = '' THEN 1 ELSE 0 END) AS num_missing_unit_price,
	SUM(CASE WHEN Country IS NULL OR Country = '' THEN 1 ELSE 0 END) AS num_missing_country
FROM
	[retail_sales_analytics].[dbo].[online_retail_raw_data];


--Negative quantities that are not cancellations
SELECT
	COUNT(*) AS num_negative_quantity,
	SUM(CASE WHEN InvoiceNo NOT LIKE 'C%' THEN 1 ELSE 0 END) AS num_negative_quantity_not_cancel
FROM 
	[retail_sales_analytics].[dbo].[online_retail_raw_data]
WHERE
	TRY_CONVERT(INT, Quantity) < 0;


--Cancelled rows and cancelled invoices (If InvoiceNo starts with 'c')
SELECT
	COUNT(*) AS num_cancelled_rows,
	COUNT(DISTINCT InvoiceNo) AS num_cancelled_invoices
FROM
	[retail_sales_analytics].[dbo].[online_retail_raw_data]
WHERE
	InvoiceNo LIKE 'C%';


--Zero or negative prices
SELECT
	SUM(CASE WHEN TRY_CONVERT(DECIMAL(12, 2), UnitPrice) = 0.00 THEN 1 ELSE 0 END) AS num_zero_price,
	SUM(CASE WHEN TRY_CONVERT(DECIMAL(12, 2), UnitPrice) < 0.00 THEN 1 ELSE 0 END) AS num_negative_price
FROM
	[retail_sales_analytics].[dbo].[online_retail_raw_data];



--Bad data from conversion
SELECT
	SUM(CASE WHEN TRY_CONVERT(INT, Quantity) IS NULL THEN 1 ELSE 0 END) AS bad_quantity_row_count,
	SUM(CASE WHEN TRY_CONVERT(DATETIME2, InvoiceDate, 101) IS NULL THEN 1 ELSE 0 END) AS bad_date_row_count,
	SUM(CASE WHEN TRY_CONVERT(DECIMAL(12, 2), UnitPrice) IS NULL THEN 1 ELSE 0 END) AS bad_price_row_count
FROM
	[retail_sales_analytics].[dbo].[online_retail_raw_data];


--Min and Max Dates
SELECT
	MIN(TRY_CONVERT(DATETIME2, InvoiceDate, 101)) AS first_invoice_date,
	MAX(TRY_CONVERT(DATETIME2, InvoiceDate, 101)) AS most_recent_invoice_date
FROM
	[retail_sales_analytics].[dbo].[online_retail_raw_data];



