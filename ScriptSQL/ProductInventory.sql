/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ProductID]
      ,[LocationID]
      ,[Shelf]
      ,[Bin]
      ,[Quantity]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2019].[Production].[ProductInventory]