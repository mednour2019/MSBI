/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [CurrencyCode]
      ,[Name]
      ,[ModifiedDate]
  FROM [AdventureWorks2019].[Sales].[Currency]
 -- where CurrencyCode='CAD'