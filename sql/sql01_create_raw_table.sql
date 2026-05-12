USE [retail_sales_analytics]
GO

/****** Object:  Table [dbo].[online_retail_raw_data]    Script Date: 5/12/2026 3:17:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[online_retail_raw_data](
	[InvoiceNo] [nvarchar](50) NULL,
	[StockCode] [nvarchar](50) NULL,
	[Description] [nvarchar](260) NULL,
	[Quantity] [nvarchar](50) NULL,
	[InvoiceDate] [nvarchar](50) NULL,
	[UnitPrice] [nvarchar](50) NULL,
	[CustomerID] [nvarchar](50) NULL,
	[Country] [nvarchar](75) NULL
) ON [PRIMARY]
GO


