/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
  FROM [AdventureWorks2019].[Production].[Product]
 --where MakeFlag=null
 --where FinishedGoodsFlag=null
 --where DaysToManufacture=null
 --where ProductID=776
 where ProductSubcategoryID is null


 select count(*)
 from Production.Product