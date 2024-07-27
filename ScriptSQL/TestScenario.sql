-----------------test scenario1-------
 select count (*) 
 from [Sales].[SalesOrderHeader] as SH
   inner join
   [Sales].[SalesOrderDetail] as SD
    on SH.SalesOrderID= SD.SalesOrderID
---------------------------------------

-----------test scenario2----------
  select  count(*)
  from 
   [Sales].[SalesOrderHeader] as SH
   inner join
   [Sales].[SalesOrderDetail] as SD
   on SH.SalesOrderID= SD.SalesOrderID
   left join
   [Production].[Product] as PR
   on SD.ProductID = PR.ProductID
  left join
   [Sales].[CurrencyRate] as CR
   on SH.CurrencyRateId=CR.CurrencyRateId
   left join 
    [Sales].[Currency] as CUR
	on CR.ToCurrencyCode=CUR.CurrencyCode
	left join
	[Sales].[Customer] as CUS
	on SH.CustomerID=CUS.CustomerID
	left join
	[Person].[Person] as PERS
	on CUS.PersonID=PERS.BusinessEntityID
 -------------------------------