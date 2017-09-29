use AdventureWorks2012;

/*a.	Show First name and last name of employees whose job title is “Sales Representative”, 
ranking from oldest to youngest. You may use HumanResources.Employee table and Person.Person table. (14 rows)*/

Select hre.JobTitle, hre.BirthDate, firstName, LastName from person.person
Join HumanResources.Employee as hre
on hre.BusinessEntityID = person.person.BusinessEntityID
where hre.JobTitle = 'Sales Representative'
order by hre.BirthDate

/*b.	Find out all the products which sold more than $5000 in total. Show product ID and name and 
total amount collected after selling the products. You may use LineTotal from Sales.SalesOrderDetail 
table and Production.Product table. (254 rows)*/

select Sub. ProductID, sum(LineTotal) as apple  from (
	Select  pp.ProductID, (LineTotal), name from sales.SalesOrderDetail
	join Production.Product as PP
	on sales.SalesOrderDetail.productID = pp.ProductID
	) Sub 
group by ProductID 
Order by ProductID
where  (apple > 5000)



/*c.	Show BusinessEntityID, territory name and SalesYTD of all sales persons whose SalesYTD is 
greater than $500,000, regardless of whether they are assigned a territory. 
You may use Sales.SalesPerson table and Sales.SalesTerritory table. (16 rows)*/
select sales.salesperson.SalesYTD, Sales.SalesPerson.territoryID from Sales.SalesPerson
Left Join sales.SalesTerritory 
on (sales.salesperson.TerritoryID=sales.SalesTerritory.TerritoryID or sales.SalesPerson.TerritoryID=NULL)
where sales.salesperson.salesYTD > 500000

/*d.	Show the sales order ID of those orders in the year 2008 of which the total due is great 
than the average total due of all the orders of the same year. (3200 rows)*/
select (TotalDue), OrderDate from (
	Select *
	FROM sales.SalesOrderHeader 
	where ((OrderDate BETWEEN '2008-01-01 00:00:00:000' AND '2008-12-31 00:00:00:000') )
	) sub
Where totaldue > (SELECT AVG(totaldue) FROM sales.SalesOrderHeader where(OrderDate BETWEEN '2008-01-01 00:00:00:000' AND '2008-12-31 00:00:00:000') )

