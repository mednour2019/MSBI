-- sum(TaxAmt)
SELECT *
  FROM [AdventureWorksDW2019].[dbo].[FactInternetSales]
  --where OrderQuantity<>1
 --where SalesOrderLineNumber=5
where SalesOrderNumber='SO75122';
