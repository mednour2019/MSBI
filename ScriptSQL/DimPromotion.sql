/****** Script for SelectTopNRows command from SSMS  ******/
SELECT*
  FROM [AdventureWorksDW2019].[dbo].[DimPromotion]
  --where PromotionKey=1
  where MinQty<>0