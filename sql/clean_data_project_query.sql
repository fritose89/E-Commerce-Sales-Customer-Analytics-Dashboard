
--Creating a clean view with correct typing, and handling of cleaning rules
CREATE OR ALTER VIEW dbo.sales_clean AS
	SELECT
		InvoiceNo,
		StockCode,
		Description,
		TRY_CONVERT(INT, Quantity) AS Quantity,
		TRY_CONVERT(DATETIME2, InvoiceDate) AS InvoiceDate,
		TRY_CONVERT(DECIMAL(12, 2), UnitPrice) AS UnitPrice,
		CustomerID,
		Country,
		TRY_CONVERT(INT, Quantity) * TRY_CONVERT(DECIMAL(12, 2), UnitPrice) AS Revenue,
		CASE WHEN InvoiceNo LIKE 'C%' THEN 1 ELSE 0 END AS Cancelled,
		CASE WHEN TRY_CONVERT(INT, Quantity) < 0 AND InvoiceNo NOT LIKE 'C%' THEN 1 ELSE 0 END AS NegativeQuantNotCancelled,
		CASE WHEN CustomerID IS NULL OR CustomerID = '' THEN 1 ELSE 0 END AS MissingCustomerID
	 FROM [retail_sales_analytics].[dbo].[online_retail_raw_data];
GO
	  
--S		
CREATE OR ALTER VIEW dbo.sales_standard_view AS
	SELECT
		*
	FROM
		dbo.sales_clean
	WHERE
		Cancelled = 0 AND
		NegativeQuantNotCancelled = 0 AND
		Quantity > 0 AND
		UnitPrice > 0;
GO


CREATE OR ALTER VIEW dbo.sales_cancelled AS
	SELECT
		*
	FROM
		dbo.sales_clean
	WHERE
		Cancelled = 1;
GO


CREATE OR ALTER VIEW dbo.customer_level_sales AS
	SELECT
		*
	FROM
		dbo.sales_clean
	WHERE
		MissingCustomerID = 0;
GO

CREATE OR ALTER VIEW dbo.negative_quant_not_cancelled AS
	SELECT
		*
	FROM
		dbo.sales_clean
	WHERE
		NegativeQuantNotCancelled = 1;
GO
