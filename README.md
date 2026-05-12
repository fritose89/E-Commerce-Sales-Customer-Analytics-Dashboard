# E-Commerce-Sales-Customer-Analytics-Dashboard

## Project Overview
In this project I am cleaning messy retail e-commerce data and using this data to identify trends and to give relevant business insight. This project is very similar to my work done as a Business Data Analyst for Nawilins Vape LLC.

## Tools
- SQL Server (SSMS 22)
- Power BI
- Python (pandas)
- Excel
- GitHub

## Business Questions
1. What are the main profit trends?
2. What are the best selling products (Highest Profit)
3. Which countries generate the most revenue?
4. Who are the highest-value customers?
5. How do cancellations affect bottom line?

## Dataset
UCI Online Retail dataset

## Status Updates
### 5/11 
- Used Excel to change file format of data from .xlsv to .csv for importing into SSMS
- When importing the data into SSMS I set the data types to thier most appropriate types as follows:
  - InvoiceNo - nvarchar(50)
  - StockCode - nvarchar(50)
  - Description - nvarchar(50)
  - Quantity - int
  - InvoiceDate - datetime2(7)
  - UnitPrice - float
  - CustomerID - nvarchar(50)
  - Country - nvarchar(50)
