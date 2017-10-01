use AdventureWorksDW2012;


/*1, Display number of orders and total sales amount(sum of SalesAmount) of Internet Sales in 1st quarter 
each year in each country. Note: your result set should produce a total of 18 rows. */

Select sum(SalesAmount) as TotalSales,t.SalesTerritoryCountry, dd.CalendarYear from dbo.FactInternetSales as sellers
join dbo.DimSalesTerritory as t
on t.SalesTerritoryKey = sellers.SalesTerritoryKey
join dbo.DimDate as dd
on DateKey = sellers.OrderDateKey
Where dd.CalendarQuarter=1
Group by t.SalesTerritoryCountry, dd.CalendarYear
 
/*2, Show 
total reseller sales amount (sum of SalesAmount), 
calendar quarter of order date, 
product category name 
reseller’s business type 
	by quarter 
	by category and 
	by business type in 2006. 
Note: your result set should produce a total of 44 rows. */

select distinct dd.calendarQuarter,  pcat.EnglishProductcategoryName,  dr.BusinessType, sum(SalesAmount) as Sales from dbo.FactResellerSales as rs
join dbo.DimDate as dd
on DateKey = rs.OrderDateKey
Join dbo.DimReseller as dr
on dr.resellerKey =rs.ResellerKey
Join dbo.DimProduct as pc
on  pc.ProductKey = rs.ProductKey
Join dbo.DimProductSubcategory as sub
on sub.productSubCategoryKey = pc.ProductSubcategoryKey
join dbo.DimProductCategory as pcat
on pcat.ProductCategoryKey = sub.productCategoryKey
join dbo.DimReseller 
on rs.ResellerKey = dr.ResellerKey
where dd.CalendarYear = 2006
Group by dd.CalendarQuarter,  dr.BusinessType, pcat.EnglishProductcategoryName
Order by dd.CalendarQuarter, pcat.EnglishProductcategoryName, dr.BusinessType asc

/*3, Based on 2, perform an OLAP operation: slice. In comment, describe how you perform the slicing, 
i.e. what do you do to what dimension(s)? Why is it a operation of slicing?*/

/*The result from P2 is a 3-dimension cube where the dimensions are "CalendarQuarter", "Product Category" 
and "Business Type". "Sum(SalesAmount) is the Measure.  */

/* For P3, I sliced the "Time Dimension" by selecting a single calendar quarter "slice" for the analysis. 
The result is now a 2-dimension cube where the dimensions are "Product Category" 
and "Business Type".  Note that the number of rows decreased to 10.  The measure continue to be sum(SalesAmount)*/

select  dd.calendarQuarter,  pcat.EnglishProductcategoryName,  dr.BusinessType, sum(SalesAmount) from dbo.FactResellerSales as rs 
join dbo.DimDate as dd
on DateKey = rs.OrderDateKey
Join dbo.DimReseller as dr
on dr.resellerKey =rs.ResellerKey
Join dbo.DimProduct as pc
on  pc.ProductKey = rs.ProductKey
Join dbo.DimProductSubcategory as sub
on sub.productSubCategoryKey = pc.ProductSubcategoryKey
join dbo.DimProductCategory as pcat
on pcat.ProductCategoryKey = sub.productCategoryKey
join dbo.DimReseller 
on rs.ResellerKey = dr.ResellerKey
where dd.CalendarYear = 2006 and dd.calendarQuarter=1
Group by dd.CalendarQuarter,  dr.BusinessType, pcat.EnglishProductcategoryName
Order by dd.CalendarQuarter, pcat.EnglishProductcategoryName, dr.BusinessType asc

/*4, Based on 2, perform an OLAP operation: drill-down. In comment, describe how you perform the 
drill-down, i.e. what do you do to what dimension(s)? Why is it a operation of drilling-down?*/

/* For P4, I drillect-down the category dimension by adding the "EnglishProductSubCategory" to the analysis. 
The result is now a 4-dimension cube where the dimensions are "CalendarQuarter", "Product Category", "ProductSubCategory" 
and "Business Type".  Note that the number of rows increased to 126*/

select  dd.calendarQuarter,  pcat.EnglishProductcategoryName,  sub.EnglishProductSubcategoryName, dr.BusinessType, sum(SalesAmount) as Sales from dbo.FactResellerSales as rs
join dbo.DimDate as dd
on DateKey = rs.OrderDateKey
Join dbo.DimReseller as dr
on dr.resellerKey =rs.ResellerKey
Join dbo.DimProduct as pc
on  pc.ProductKey = rs.ProductKey
Join dbo.DimProductSubcategory as sub
on sub.productSubCategoryKey = pc.ProductSubcategoryKey
join dbo.DimProductCategory as pcat
on pcat.ProductCategoryKey = sub.productCategoryKey
join dbo.DimReseller 
on rs.ResellerKey = dr.ResellerKey
where dd.CalendarYear = 2006
Group by dd.CalendarQuarter,  dr.BusinessType, pcat.EnglishProductcategoryName,sub.EnglishProductSubcategoryName
Order by dd.CalendarQuarter, pcat.EnglishProductcategoryName, dr.BusinessType asc