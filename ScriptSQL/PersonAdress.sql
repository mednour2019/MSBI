/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [AddressID]
      ,[AddressLine1]
      ,[AddressLine2]
      ,[City]
      ,[StateProvinceID]
      ,[PostalCode]
      ,[SpatialLocation]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2019].[Person].[Address]
  --where AddressID=17526
 where StateProvinceID=63
 --where AddressLine1 like'1314%'
 
--where PostalCode like'13%'