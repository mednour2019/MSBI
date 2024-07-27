/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [CurrencyRateID]
      ,[CurrencyRateDate]
      ,[FromCurrencyCode]
      ,[ToCurrencyCode]
      ,[AverageRate]
      ,[EndOfDayRate]
      ,[ModifiedDate]
  FROM [AdventureWorks2019].[Sales].[CurrencyRate]