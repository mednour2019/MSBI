/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [SalesOrderID]
      ,[RevisionNumber]
      ,[OrderDate]
      ,[DueDate]
      ,[ShipDate]
      ,[Status]
      ,[OnlineOrderFlag]
      ,[SalesOrderNumber]
      ,[PurchaseOrderNumber]
      ,[AccountNumber]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[TerritoryID]
      ,[BillToAddressID]
      ,[ShipToAddressID]
      ,[ShipMethodID]
      ,[CreditCardID]
      ,[CreditCardApprovalCode]
      ,[CurrencyRateID]
      ,[SubTotal]
      ,[TaxAmt]
      ,[Freight]
      ,[TotalDue]
      ,[Comment]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2019].[Sales].[SalesOrderHeader]
  where[SalesOrderNumber]='SO51178'

  select count(*) from [Sales].[SalesOrderHeader]

  /* numero ordrer , produit number, produit name, price unitore , total price , sales order number */
  select SH.SalesOrderNumber,SD.ProductID,PR.Name, SD.UnitPrice,PR.StandardCost, SD.OrderQty,SD.UnitPrice*SD.OrderQty as TotalLine, SD.UnitPrice*SD.OrderQty-(PR.StandardCost*OrderQty) as Profit  from 
   [Sales].[SalesOrderHeader] as SH
   inner join
   [Sales].[SalesOrderDetail] as SD
   on SH.SalesOrderID= SD.SalesOrderID
   inner join
   [Production].[Product] as PR
   on SD.ProductID = PR.ProductID


     select SD.ProductID,PR.Name, sum(SD.UnitPrice) ,sum(PR.StandardCost), sum(SD.OrderQty),sum(SD.UnitPrice*SD.OrderQty) as TotalLine, sum(SD.UnitPrice*SD.OrderQty-(PR.StandardCost*OrderQty) )as Profit  from 
   [Sales].[SalesOrderHeader] as SH
   inner join
   [Sales].[SalesOrderDetail] as SD
   on SH.SalesOrderID= SD.SalesOrderID
   inner join
   [Production].[Product] as PR
   on SD.ProductID = PR.ProductID
   Group by SD.ProductID,PR.Name
   order by Profit desc
   