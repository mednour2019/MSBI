/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [UnitMeasureCode]
      ,[Name]
      ,[ModifiedDate]
  FROM [AdventureWorks2019].[Production].[UnitMeasure]
  where UnitMeasureCode='CM'