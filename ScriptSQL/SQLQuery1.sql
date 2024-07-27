
  select count(*) from [Sales].[SalesOrderHeader];
   --using Sum,GroupBy,OrderBy
     select SD.ProductID,PR.Name, sum(SD.UnitPrice) ,sum(PR.StandardCost), sum(SD.OrderQty),sum(SD.UnitPrice*SD.OrderQty) as TotalLine, sum(SD.UnitPrice*SD.OrderQty-(PR.StandardCost*OrderQty) )as Profit  from 
   [Sales].[SalesOrderHeader] as SH
   inner join
   [Sales].[SalesOrderDetail] as SD
   on SH.SalesOrderID= SD.SalesOrderID
   inner join
   [Production].[Product] as PR
   on SD.ProductID = PR.ProductID
   Group by SD.ProductID,PR.Name
   order by Profit desc;
   -----------------
   -- verification join with order header and details
      select count(*) from 
   [Sales].[SalesOrderHeader] as SH
   inner join
   [Sales].[SalesOrderDetail] as SD
   on SH.SalesOrderID= SD.SalesOrderID
   ----------------------------------------
   -- pricipal query using count *
   select count(*) 
  from 
   [Sales].[SalesOrderHeader] as SH
  inner join
   [Sales].[SalesOrderDetail] as SD
   on SH.SalesOrderID= SD.SalesOrderID
   left join
   Person.Address as PerAdd
   on SH.ShipToAddressID=PerAdd.AddressID
   left join
   person.StateProvince as prov
   on PerAdd.StateProvinceID=prov.StateProvinceID
 LEFT JOIN (
    SELECT StateProvinceID, SUM(TaxRate) AS TaxRate
    FROM sales.SalesTaxRate
    GROUP BY StateProvinceID
) AS TAXR ON TAXR.StateProvinceID = prov.StateProvinceID
left join Production.Product as PR
on SD.ProductID=PR.ProductID
left join Sales.CurrencyRate as CuRat
on SH.CurrencyRateID=CuRat.CurrencyRateID
left join sales.Currency as CURR 
on CuRat.ToCurrencyCode=CURR.CurrencyCode
left join  Sales.Customer as Custom
on SH.CustomerID=Custom.CustomerID
left  join Production.ProductSubcategory as PRSUBC
on PR.ProductSubcategoryID=PRSUBC.ProductSubcategoryID
left join Production.ProductCategory as PRCAT
on PRSUBC.ProductCategoryID=PRCAT.ProductCategoryID
left join sales.store as STO
on Custom.storeId= sto.BusinessEntityId




------------------------------------------------------------

WITH SalesCTE AS (
-- pricipal query with disply columns
select  SH.SalesOrderNumber,
ROW_NUMBER() OVER (PARTITION BY SH.SalesOrderID ORDER BY SD.SalesOrderDetailID) AS SalesOrderNumberLine,
SD.ProductID,
PERS.BusinessEntityID as PersonId, SD.SpecialOfferID,
ISNULL(CURR.CurrencyCode, 'NA') AS CurrencyCode,
SH.TerritoryID,
PRCAT.ProductCategoryID as categoryProdId,
sto.name as StoreName,
  SH.RevisionNumber,SD.OrderQty,
  SD.UnitPrice,
  SD.UnitPrice*SD.OrderQty as ExtendedAmount,
  SD.UnitPriceDiscount as UnitPriceDiscountPct,
    SD.UnitPriceDiscount*SD.OrderQty AS DiscountAmount,
	 PR.StandardCost,
	 PR.StandardCost*OrderQty as TotalProductCost,
	 ( SD.UnitPrice*SD.OrderQty)- (SD.UnitPriceDiscount*SD.OrderQty) as SalesAmount,   
 (( SD.UnitPrice*SD.OrderQty)- (SD.UnitPriceDiscount*SD.OrderQty)) *(TaxRate/100) as AmntTax,
  (( SD.UnitPrice*SD.OrderQty)- (SD.UnitPriceDiscount*SD.OrderQty)) *(SHIP.ShipRate/100) as Freight,
-- SD.UnitPrice*SD.OrderQty-(PR.StandardCost*OrderQty) as Profit,
SH.OrderDate,SH.DueDate,
SH.ShipDate
  from 
   [Sales].[SalesOrderHeader] as SH
  inner join
   [Sales].[SalesOrderDetail] as SD
   on SH.SalesOrderID= SD.SalesOrderID
   left join
   Person.Address as PerAdd
   on SH.ShipToAddressID=PerAdd.AddressID
   left join
   person.StateProvince as prov
   on PerAdd.StateProvinceID=prov.StateProvinceID
 LEFT JOIN (
    SELECT StateProvinceID, SUM(TaxRate) AS TaxRate
    FROM sales.SalesTaxRate
    GROUP BY StateProvinceID
) AS TAXR ON TAXR.StateProvinceID = prov.StateProvinceID
left join Production.Product as PR
on SD.ProductID=PR.ProductID
left join Sales.CurrencyRate as CuRat
on SH.CurrencyRateID=CuRat.CurrencyRateID
left join sales.Currency as CURR 
on CuRat.ToCurrencyCode=CURR.CurrencyCode
left join  Sales.Customer as Custom
on SH.CustomerID=Custom.CustomerID
left join Person.Person as PERS
on Custom.PersonID=PERS.BusinessEntityID
left join Purchasing.ShipMethod as SHIP
on SH.ShipMethodID= SHIP.ShipMethodID
left  join Production.ProductSubcategory as PRSUBC
on PR.ProductSubcategoryID=PRSUBC.ProductSubcategoryID
left join Production.ProductCategory as PRCAT
on PRSUBC.ProductCategoryID=PRCAT.ProductCategoryID
left join sales.store as STO
on Custom.storeId= sto.BusinessEntityId
--where SalesOrderNumber='SO43661'
--where PersonID is null
--where StoreId is null
--where SH.TerritoryID is null
)
select 
SalesOrderNumber,
SalesOrderNumberLine,
ProductID,
PersonId,
SpecialOfferID,
CurrencyCode,
TerritoryID,
categoryProdId,
ISNULL(StoreName,'Unknown') as StoreName,
RevisionNumber,
OrderQty,
UnitPrice,
ExtendedAmount,
UnitPriceDiscountPct,
DiscountAmount,
StandardCost,
TotalProductCost,
SalesAmount,
ISNULL(AmntTax,0) as AmntTax,
Freight,
SalesAmount-(ISNULL(AmntTax,0)+Freight) as profit,
OrderDate,
DueDate,
ShipDate
from SalesCTE
--WHERE categoryProdName IS NULL; 
--where ProductID =424;


--query load DimProduct

select 
PR.ProductID,PR.Name,
CASE
    WHEN PR.MakeFlag =0 THEN 'Purchased'
    WHEN PR.MakeFlag =1 THEN 'Manufacturing in house'
    ELSE 'Default'
END AS MakeFlagProduct,
CASE
    WHEN PR.FinishedGoodsFlag =0 THEN 'Product Not salable'
    WHEN PR.FinishedGoodsFlag =1 THEN 'Product salable'
END AS FinishedGoodFlag,
ISNULL(PR.Color, 'Unknown') AS ProductColor,
ISNULL(PR.Size, 'Unknown') AS ProductSize,
pr.DaysToManufacture,
CASE
    WHEN PR.ProductLine ='R' THEN 'Road'
    WHEN PR.ProductLine ='M' THEN 'Mountain'
	    WHEN PR.ProductLine ='T' THEN 'Touring'
		 WHEN PR.ProductLine ='S' THEN 'Standard'
		 ELSE'Unknown'
END AS ProductLine,
CASE
    WHEN PR.Class ='H' THEN 'High'
    WHEN PR.Class ='M' THEN 'Meduim'
	    WHEN PR.Class ='L' THEN 'Low'
		 ELSE'Unknown'
END AS ProductClass,
CASE
    WHEN PR.style ='W' THEN 'Womens'
    WHEN PR.Style ='M' THEN 'Mens'
	    WHEN PR.Style ='U' THEN 'Universal'
		 ELSE'Unknown'
END AS ProductStyle,
ISNULL(PRSUB.Name, 'Unknown') AS SubCategoryName,
ISNULL(PRMOD.Name, 'Unknown') AS ModelName
from Production.Product as PR
left join Production.ProductSubcategory as PRSUB
on PR.ProductSubcategoryID=PRSUB.ProductSubcategoryID
left join Production.ProductModel as PRMOD
on PR.ProductModelID=PRMOD.ProductModelID
----------------------------


-- join with count * 
select count(*)
from Production.Product as PR
left join Production.ProductSubcategory as PRSUB
on  PR.ProductSubcategoryID= PRSUB.ProductSubcategoryID
left join Production.ProductModel as PRMOD
on pr.ProductModelID=PRMOD.ProductModelID;
-----------------------
--*************Load Dimension Customer*****************
select PER.BusinessEntityId as CustomerId,
   CASE
		WHEN PER.PersonType ='SC' THEN 'Store Contact'
		WHEN PER.PersonType ='IN' THEN 'Individual customer'
		 WHEN PER.PersonType ='SP' THEN 'Sales person'
		WHEN PER.PersonType ='EM' THEN 'Employee'
		 WHEN PER.PersonType ='VC' THEN 'Vendor contact'
		  WHEN PER.PersonType ='GC' THEN 'General contact'
	END AS CustomerType,
  case 
    when per.title='Mr.' then 'Male'
    when per.title='Ms.' then 'Female'
	 ELSE'Unknown'
END AS CustomerGender,
PER.FirstName,
ISNULL(PER.MiddleName, 'Unknown') AS MiddleName,
PER.LastName,
PER.FirstName+' '+ISNULL(PER.MiddleName, ' ')+' '+PER.LastName AS FullName,
case
when per.EmailPromotion=0 then 'Contact does not wish to receive e-mail promotions'
when per.EmailPromotion=1 then 'Contact does wish to receive e-mail promotions '
when per.EmailPromotion=2 then ' Contact does wish to receive e-mail promotions 
from AdventureWorks and selected partners'
END AS EmailPromotion
from person.person as PER;
--************************************************
--*************Load Dim Territory with country region***********
select  ST.TerritoryID,ST.Name,ST.[Group],CR.Name as CRegion
from sales.SalesTerritory as ST
left join person.CountryRegion as CR
on st.CountryRegionCode=CR.CountryRegionCode
--**************************************************************








 
   





  




