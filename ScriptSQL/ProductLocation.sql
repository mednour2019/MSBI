/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [LocationID]
      ,[Name]
      ,[CostRate]
      ,[Availability]
      ,[ModifiedDate]
  FROM [AdventureWorks2019].[Production].[Location]