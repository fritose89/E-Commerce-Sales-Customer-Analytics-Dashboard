# E-Commerce-Sales-Customer-Analytics-Dashboard

## Project Overview
In this project I am cleaning messy retail e-commerce data and using this data to identify trends and to give relevant business insight. This project is very similar to my work done as a Business Data Analyst for Nawlins Vape LLC.

## Tools
- SQL Server (SSMS 22)
- Power BI
- Python (pandas)
- Excel
- GitHub

## Business Questions
1. What are the main revenue trends?
2. What are the best selling products (Highest Revenue)
3. Which countries generate the most revenue?
4. Who are the highest-value customers?
5. How do cancellations affect bottom line?

## Dataset
UCI Online Retail dataset

## Status Updates
### 5/11 
- Used Excel to change file format of data from .xlsx to .csv for importing into SSMS
- When importing the data into SSMS I set the data types to the nvarchar type to prevent any import problems:
  - InvoiceNo - nvarchar(50)
  - StockCode - nvarchar(50)
  - Description - nvarchar(260)
  - Quantity - nvarchar(50)
  - InvoiceDate - nvarchar(50)
  - UnitPrice - nvarchar(50)
  - CustomerID - nvarchar(50)
  - Country - nvarchar(75)

### 5/12
- Created database schema for SSMS and added creation script
- During data profiling in SSMS I noticed that orders that are cancelled have a negative quantity, meaning negative quantities whose invoice number does not start with 'c' should be processed separately
- When testing converting InvoiceDate, Quantity, and UnitPrice to their proper datatypes as follows:
   - InvoiceDate - datetime2(7)
   - Quantity - int
   - UnitPrice - decimal(12, 2)
  there were no issues to be noted
- There are many rows that are missing customer ids, which will be included in overall trend and sales calculations but will be left out during customer-level analysis
#### Cleaning Rules
- Convert Quantity from NVARCHAR to INT
- Convert InvoiceDate from NVARCHAR to DATETIME2
- Convert UnitPrice from NVARCHAR TO DECIMAL(12, 2)
- Revenue row added by multiplying Quantity and UnitPrice
- Rows where the InvoiceNo begins with C are marked as cancelled
- Cancelled invoices and rows will not be included in the revenue calculation
- UnitPrices that are zero or less will be excluded from the revenue and sales analysis
- Rows that have negative Quantities that are not cancellations will be analyzed separately
- Missing customer id rows will be analyzed separately from customer-level analysis
- Missing customer id rows will be included in overall analysis


