USE retail_sales_analytics;
GO

--Cleaned sales view that converts features to appropriate data types
--Created tags for cancelled, negative quantity, and null or missing ids
--Created individualized views for different business insights

--Cleaned view that converts proper data types and adds aforementioned flags
--Filters out any data that does not convert sucessfully
CREATE OR ALTER VIEW dbo.sales_clean AS 
SELECT
	InvoiceNo,
	StockCode,
	Description,
	TRY_CONVERT(INT, Quantity) AS Quantity,
	TRY_CONVERT(DATETIME2, InvoiceDate, 101) AS InvoiceDate,
	TRY_CONVERT(DECIMAL(12, 2), UnitPrice) AS UnitPrice,
	CustomerID,
	Country,
	TRY_CONVERT(INT, Quantity) * TRY_CONVERT(DECIMAL(12, 2), UnitPrice) AS Revenue,
	CASE
		WHEN InvoiceNo LIKE 'C%' THEN 1 ELSE 0 END AS IsCancelled,
	CASE
		WHEN TRY_CONVERT(INT, Quantity) < 0 AND InvoiceNo NOT LIKE 'C%' THEN 1 ELSE 0 END AS NegativeQuantityNotCancelled,
	CASE
		WHEN CustomerID IS NULL OR CustomerID = '' THEN 1 ELSE 0 END AS NullOrMissingID
FROM
	retail_sales_analytics.dbo.online_retail_raw_data
WHERE
	TRY_CONVERT(INT, Quantity) IS NOT NULL AND
	TRY_CONVERT(DATETIME2, InvoiceDate, 101) IS NOT NULL AND
	TRY_CONVERT(DECIMAL(12, 2), UnitPrice) IS NOT NULL

GO

--Cleaned sales view that filters out cancelled, and negative non cancelled invoices
--This will be the view that is used for most of the broad analysis
CREATE OR ALTER VIEW sales_overall AS
SELECT
	*
FROM 
	sales_clean
WHERE
	IsCancelled = 0 AND
	NegativeQuantityNotCancelled = 0 AND
	Quantity > 0 AND
	UnitPrice > 0

GO

--Cancelled invoices view based on clean sales view
CREATE OR ALTER VIEW cancelled_sales AS
SELECT
	*
FROM
	sales_clean
WHERE
	IsCancelled = 1 AND
	NegativeQuantityNotCancelled = 0

GO

--Customer level analysis view
CREATE OR ALTER VIEW customer_level_sales AS
SELECT
	*
FROM
	sales_clean
WHERE
	NullOrMissingID = 0 AND
	Quantity > 0 AND
	UnitPrice > 0

GO

--Missing customer ID view
CREATE OR ALTER VIEW missingID_sales AS 
SELECT
	*
FROM
	sales_clean
WHERE
	NullOrMissingID = 1 AND
	Quantity > 0 AND
	UnitPrice > 0

GO

--Negative quantity not cancelled view
CREATE OR ALTER VIEW negative_quant_no_cancel AS
SELECT
	*
FROM
	sales_clean
WHERE
	NegativeQuantityNotCancelled = 1