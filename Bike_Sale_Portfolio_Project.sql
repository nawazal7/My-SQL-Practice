-- Products Analysis

-- Q1: Find the total number of products for each product category.
select PRODCATEGORYID ,count(PRODCATEGORYID) as Total_No_of_Products
from products 
group by PRODCATEGORYID 
order by Total_No_of_Products DESC;

-- Q2: List the top 5 most expensive products.
SELECT TOP 5 *
FROM products
ORDER BY price DESC;

-- Q3: List the total sales amount (gross) for each product category.
SELECT SUBSTRING(PRODUCTID, 1, 2) AS PRODCATEGORY, 
SUM(GROSSAMOUNT) AS GROSS_SALES_AMT 
FROM SALESORDERITEMS 
GROUP BY SUBSTRING(PRODUCTID, 1, 2);

-- Q4: List the top 5 suppliers by total product sales.
SELECT SALESORG, SUM(GROSSAMOUNT) AS TotalGrossAmount, SUM(NETAMOUNT) AS TotalNetAmount
FROM SalesOrders
GROUP BY SALESORG;

-- Q5: Find the total number of products created by each employee.
SELECT 
    e.EMPLOYEEID,
    e.NAME_FIRST,
    e.NAME_LAST,
    COUNT(p.PRODUCTID) AS total_products_created
FROM 
    Employees e
LEFT JOIN 
    products p ON e.EMPLOYEEID = p.CREATEDBY
GROUP BY 
    e.EMPLOYEEID,
    e.NAME_FIRST,
    e.NAME_LAST
ORDER BY 
    total_products_created DESC;

-- Q6: List the employees who have changed product details the most.
SELECT e.EMPLOYEEID, e.NAME_FIRST, e.NAME_LAST, COUNT(p.CHANGEDBY) AS ChangeCount
FROM employees e
JOIN products p ON e.EMPLOYEEID = p.CHANGEDBY
GROUP BY e.EMPLOYEEID, e.NAME_FIRST, e.NAME_LAST
ORDER BY ChangeCount DESC;

-- Sales Orders Items Analysis
-- Q7: Calculate the total gross amount for each sales order.
select SALESORDERID, sum(grossamount) as Total_Gross_Amt
from salesorders
group by SALESORDERID;
-- Q8: Find the sales order items for a specific product ID.
select productid, sum(salesorderitem) as total_soi 
from SalesOrderItems
group by PRODUCTID;
-- Business Partners Analysis
-- Q9: How many business partners are there for each partner role?
select partnerid, sum(partnerrole) as Partner_Role
from BusinessPartners
group by partnerid;
-- Q10: List the top 5 companies with the most recent creation dates.
select top 5 partnerid, companyname, createdat from BusinessPartners;

-- Employees Analysis
-- Q11: Find the number of employees for each sex.
select sex, count(sex) as Gender_Count from employees group by sex;

-- Product Categories Analysis
-- Q12: List all product categories along with their descriptions.
select ProdCategoryID, SHORT_DESCR from ProductCategorytext;
-- Q13: Find all products that belong to the 'Mountain Bike' category.
select * from Products where PRODCATEGORYID='MB';

-- Addresses Analysis
-- Q14: Count the number of addresses in each country.
select country, count(REGION) as No_of_Add_each_Country 
from Addresses
group by COUNTRY;
-- Q15: Find the number of business partners in each region.
select a.region, count(b.ADDRESSID) as Partners_in_Region
from BusinessPartners b 
left join Addresses a
on b.ADDRESSID=a.ADDRESSID
group by a.REGION;

-- Sales Orders Analysis
-- Q16: Find the top 5 sales orders by net amount.
select top 5 * from SalesOrders order by NETAMOUNT DESC;


-- Combining Data from Multiple Tables
-- Q17: List the top 5 employees who have created the most sales orders.
select top 5 e.EMPLOYEEID, 
		concat(e.NAME_FIRST, ' ' ,e.NAME_LAST) as Full_Name, 
		count(*) as total_sales 
from EMPLOYEES e 
left join SALESORDERS s 
on e.EMPLOYEEID = s.CREATEDBY
group by e.EMPLOYEEID, e.NAME_FIRST, e.NAME_LAST
order by total_sales desc;
