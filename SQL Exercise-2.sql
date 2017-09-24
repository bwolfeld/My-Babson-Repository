USE AdventureWorks2012; /*Set current database*/
select * from sales.salesorderdetail


/*1. Display the total amount collected from the orders for each order date. */
SELECT ModifiedDate, SUM(LineTotal) AS dollars	
FROM sales.SalesOrderDetail
GROUP BY ModifiedDate


/*2. Display the total amount collected after selling the products, 774 and 777. */
Select ProductID,
	Sum(LineTotal) AS Dollars
FROM Sales.SalesOrderDetail
WHERE ProductID=774 OR ProductID=777
Group By ProductID 


/*3. Write a query to display the sales person BusinessEntityID, last name and first name of
 ALL the sales persons and the name of the territory to which they belong, even though they don't 
 belong to any territory*/
Select person.person.BusinessEntityID, LastName, FirstName, sales.SalesTerritory.Name
FROM HumanResources.Employee 
Join person.person
ON HumanResources.Employee.BusinessEntityID = person.person.BusinessEntityID 
Join Sales.SalesPerson
ON person.person.BusinessEntityID = Sales.SalesPerson.businessEntityID
Join sales.SalesTerritory
ON Sales.SalesPerson.TerritoryID=sales.SalesTerritory.TerritoryID
Where JobTitle='Sales representative'


/*4. Write a query to display the Business Entities of the customers that have the 'Vista' credit card.*/
SELECT PCC.BusinessEntityID, PCC.CreditCardID, SCC.CardType, SS.Name, SS.BusinessEntityID
FROM Sales.PersonCreditCard AS PCC
Join Sales.CreditCard AS SCC
ON SCC.CreditCardID = PCC.CreditCardID 
Left Join Sales.Store AS SS
On PCC.BusinessEntityID = SS.BusinessEntityID 
Where SCC.CardType = 'vista'


/*5, Write a query to display all the country region codes along with their corresponding territory IDs*/
Select CountryRegionCode, TerritoryID  From sales.SalesTerritory


/*6. Find out the average of the total dues of all the orders.*/
Select AVG(TotalDue)  From Sales.SalesOrderHeader AS TD;


/*7. Write a query to report the sales order ID of those orders where the total value is greater than the average of the total value of all the orders.*/
Select SalesOrderID, TotalDue  From Sales.SalesOrderHeader
where totalDue > (Select avg(TotalDue) From Sales.SalesOrderHeader);













