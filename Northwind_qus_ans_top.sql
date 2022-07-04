# --------------------------    BIGGINER LEVEL   -----------------------------------
/*
QUESTION:
# Which shippers do we have?
*/
select
	*
from shippers;

/*
 Certain fields from Categories
In the Categories table, selecting all the fields using this SQL:
Select * from Categories
…will return 4 columns. We only want to see two columns,
CategoryName and Description
*/

select
	categories.category_name,
    categories.description
from categories;

/*
Sales Representatives
We’d like to see just the FirstName, LastName, and HireDate of all the
employees with the Title of Sales Representative. Write a SQL
statement that returns only those employees
*/

select
	first_name,
    last_name,
    title, 
    hire_date
from employees
	where title = 'Sales Representative';
    
/*
Sales Representatives in the United States
Now we’d like to see the same columns as above, but only for those
employees that both have the title of Sales Representative, and also are
in the United States
*/
    
select
	first_name,
    last_name,
    title, 
    hire_date,
    country
from employees
	where title = 'Sales Representative'
    and country = 'USA';
    
/*
Orders placed by specific EmployeeID
Show all the orders placed by a specific employee. The EmployeeID for
this Employee (Steven Buchanan) is 5.
*/

select
	order_id,
    order_date
from orders
	order by order_date desc;
    

/*
6. Suppliers and ContactTitles
In the Suppliers table, show the SupplierID, ContactName, and
ContactTitle for those Suppliers whose ContactTitle is not Marketing
Manager
*/

select 
	supplier_id,
    contact_name,
    contact_title
from suppliers
	where contact_title != 'Marketing Manager';
    
/*
7. Products with “queso” in ProductName
In the products table, we’d like to see the ProductID and ProductName
for those products where the ProductName includes the string “queso”.
*/

select
	product_id,
    product_name
from products
	where product_name like '%queso%';

/*
8. Orders shipping to France or Belgium
Looking at the Orders table, there’s a field called ShipCountry. Write a
query that shows the OrderID, CustomerID, and ShipCountry for the
orders where the ShipCountry is either France or Belgium.
*/

select
	order_id,
    customer_id,
    ship_country
from orders
	where ship_country in('France', 'Belgium');

/*
9. Orders shipping to any country in Latin America
Now, instead of just wanting to return all the orders from France of
Belgium, we want to show all the orders from any Latin American
country. But we don’t have a list of Latin American countries in a table
in the Northwind database. So, we’re going to just use this list of Latin
American countries that happen to be in the Orders table:
Brazil
Mexico
Argentina
Venezuela
It doesn’t make sense to use multiple Or statements anymore, it would
get too convoluted. Use the In statement
*/

select
	order_id,
    customer_id,
    ship_country
from orders
	where ship_country in('Brazil', 'Mexico', 'Argentina' , 'Venezuela');

/*
10. Employees, in order of age
For all the employees in the Employees table, show the FirstName,
LastName, Title, and BirthDate. Order the results by BirthDate, so we
have the oldest employees first.
*/

select
	first_name,
    last_name,
    title,
    birth_date
from employees
	order by birth_date ;
    
/*
11. Showing only the Date with a DateTime field
In the output of the query above, showing the Employees in order of
BirthDate, we see the time of the BirthDate field, which we don’t want.
Show only the date portion of the BirthDate field
*/

SELECT 
	first_name,
    last_name,
    title,
    day (birth_date)as Only_dateOfBirth
from employees
	order by birth_date;
	
	
/*
12. Employees full name
Show the FirstName and LastName columns from the Employees table,
and then create a new column called FullName, showing FirstName and
LastName joined together in one column, with a space in-between.
*/

select
	first_name,
    last_name,
    concat(first_name, ' ', last_name) as full_name
from employees;

/*
13. OrderDetails amount per line item
In the OrderDetails table, we have the fields UnitPrice and Quantity.
Create a new field, TotalPrice, that multiplies these two together. We’ll
ignore the Discount field for now.
In addition, show the OrderID, ProductID, UnitPrice, and Quantity.
Order by OrderID and ProductID
*/

select
	order_id,
    product_id,
    unit_price,
    quantity,
    unit_price * quantity as Total_price
from order_details
	order by order_id
		and product_id;

	-- here, first I went to the 'order_details' table from SCHEMAS just did the right click 
    -- and select the option alter: from there I added 'Total_price' column, and apply.
    -- after just input 'unit_price * quantity as Total_price' 
    -- and got the answer.

/*
14. How many customers?
How many customers do we have in the Customers table? Show one
value only, and don’t rely on getting the recordcount at the end of a
resultset
*/

select
 count(*)customer_id 
 from customers;
	
/*
15. When was the first order?
Show the date of the first order ever made in the Orders table
*/

select
	min(order_date) as first_Order
from orders;
	

	-- ANSWER:
    -- from the out-put table we can say that 
    -- '1996-07-04' was the first date when the first order ever made in the order table.

/*
16. Countries where there are customers
Show a list of countries where the Northwind company has customers.
*/

select
	country
from customers
	group by country;

/*
17. Contact titles for customers
Show a list of all the different values in the Customers table for
ContactTitles. Also include a count for each ContactTitle.
This is similar in concept to the previous question “Countries where
there are customers”
, except we now want a count for each ContactTitle
*/

select
	contact_title,
    count(contact_title) as total_Contact_Title
from customers
	group by contact_title
    order by total_Contact_Title desc;
	
/*
18. Products with associated supplier names
We’d like to show, for each product, the associated Supplier. Show the
ProductID, ProductName, and the CompanyName of the Supplier. Sort
by ProductID.
This question will introduce what may be a new concept, the Join clause
in SQL. The Join clause is used to join two or more relational database
tables together in a logical way.
Here’s a data model of the relationship between Products and Suppliers
*/

select
	products.product_id,
    products.product_name,
    suppliers.company_name
from suppliers
	left join products
		on suppliers.supplier_id = products.supplier_id;
        

/*
19. Orders and the Shipper that was used
We’d like to show a list of the Orders that were made, including the
Shipper that was used. Show the OrderID, OrderDate (date only), and
CompanyName of the Shipper, and sort by OrderID.
In order to not show all the orders (there’s more than 800), show only
those rows with an OrderID of less than 10300
*/


select
	orders.order_id,
    orders.order_date,
	# orders.ship_via as join_id
    shippers.shipper_id as join_id,
    shippers.company_name
from orders
	inner join shippers
		on orders.ship_via = shippers.shipper_id
	where orders.order_id < 10300
    group by order_id;


# ----------------------      INTERMEDIATE LEVEL    ----------------------------------

/*
20. Categories, and the total products in each category
For this problem, we’d like to see the total number of products in each
category. Sort the results by the total number of products, in descending
order
*/

select
	products.category_id,
    count(products.category_id) as total_product,
    categories.category_name
from products
	left join categories
		on products.category_id = categories.category_id
	group by category_name
    order by total_product desc;

/*
21. Total customers per country/city
In the Customers table, show the total number of customers per Country
and City
*/

select
	city,
    country,
	count(customers.customer_id) as total_customer
from customers
	group by city, country
    order by total_customer desc;

/*
22. Products that need reordering
What products do we have in our inventory that should be reordered?
For now, just use the fields UnitsInStock and ReorderLevel, where
UnitsInStock is less than the ReorderLevel, ignoring the fields
UnitsOnOrder and Discontinued.
Order the results by ProductID
*/

select
	product_id,
    product_name,
    units_in_stock ,
    reorder_level
from products
	where units_in_stock < reorder_level
	group by product_id
    order by product_id;

/*
23. Products that need reordering, continued
Now we need to incorporate these fields—UnitsInStock, UnitsOnOrder,
ReorderLevel, Discontinued—into our calculation. We’ll define
“products that need reordering” with the following:
UnitsInStock plus UnitsOnOrder are less than or equal to
ReorderLevel
The Discontinued flag is false (0).
*/

select
	product_id,
    product_name,
    units_in_stock,
    units_on_order,
    reorder_level,
    discontinued
from products
	where (units_in_stock + units_on_order) <= reorder_level
    and discontinued = 0;

/*
24. Customer list by region
A salesperson for Northwind is going on a business trip to visit
customers, and would like to see a list of all customers, sorted by
region, alphabetically.
However, he wants the customers with no region (null in the Region
field) to be at the end, instead of at the top, where you’d normally find
the null values. Within the same region, companies should be sorted by
CustomerID
*/

select
	customer_id,
    company_name,
    region,
    (case when region is null then 1 else 0 end) as region_order
from customers
	order by region_order;
    
/*
 25. High freight charges
Some of the countries we ship to have very high freight charges. We'd
like to investigate some more shipping options for our customers, to be
able to offer them lower freight charges. Return the three ship countries
with the highest average freight overall, in descending order by average
freight   
*/

select
	order_id,
    ship_country,
    avg(freight) as avg_freight_charges
from orders
	group by ship_country
	order by avg_freight_charges desc;
    
/*
26. High freight charges - 2015 			# choose 1997 insted 2015.coz there is no0 data for 2015.
We're continuing on the question above on high freight charges. Now,
instead of using all the orders we have, we only want to see orders from
the year 2015.
*/

select
	ship_country,
    year(order_date) as only_year,
    avg(freight) as avg_freight_charges
from orders
	where order_date between '1997/1/1' and '1997/12/31'
	group by ship_country
    order by avg_freight_charges desc limit 3;
	
    
/*
27. High freight charges with between
Another (incorrect) answer to the problem above is this:
Select Top 3
ShipCountry
,AverageFreight = avg(freight)
From Orders
Where
OrderDate between '1/1/2015' and '12/31/2015'
Group By ShipCountry
Order By AverageFreight desc;
Notice when you run this, it gives Sweden as the ShipCountry with the
third highest freight charges. However, this is wrong - it should be
France.
What is the OrderID of the order that the (incorrect) answer above is
missing
*/

select 
	order_id,
	ship_country,
    
    avg(freight) as avg_freight_charges
from orders
	where order_date between '1997/12/1' and '1997/12/31' 
    group by ship_country
    order by avg_freight_charges desc;

		
        
/*
 28. High freight charges - last year
We're continuing to work on high freight charges. We now want to get
the three ship countries with the highest average freight charges. But
instead of filtering for a particular year, we want to use the last 12
months of order data, using as the end date the last OrderDate in Orders       
 */       

select
	ship_country,
    avg(freight) as avg_freight_charges,
	max(order_date) as last_date,
    date_add('1997/12/31', interval 1 year) as last12Months
from orders
	group by ship_country
    order by avg_freight_charges desc;


/*
29. Inventory list
We're doing inventory, and need to show information like the below, for
all orders. Sort by OrderID and Product ID
*/

select
	employees.employee_id,
    employees.last_name,
    order_details.order_id,
    order_details.product_id,
    products.product_name,
    order_details.quantity
from employees
	left join orders
		on employees.employee_id = orders.employee_id
	left join order_details
		on orders.order_id = order_details.order_id
	left join products
		on order_details.product_id = products.product_id
order by order_id;

/*
30. Customers with no orders
There are some customers who have never actually placed an order.
Show these customers
*/

select
	customers.customer_id,
    orders.order_id
from customers
	left join orders
		on customers.customer_id = orders.customer_id
where order_id is null 
	group by customer_id;
    
  /*
  31. Customers with no orders for EmployeeID 4
One employee (Margaret Peacock, EmployeeID 4) has placed the most
orders. However, there are some customers who've never placed an order
with her. Show only those customers who have never placed an order
with her
*/

select
	employees.employee_id,
    orders.customer_id,
    orders.order_id
from employees
	left outer join orders
		on employees.employee_id = orders.employee_id
	left outer join customers
		on orders.customer_id = customers.customer_id
	
where orders.customer_id is null
	and orders.employee_id != 4;
    
   
    
/*
32. High-value customers
We want to send all of our high-value customers a special VIP gift.
We're defining high-value customers as those who've made at least 1
order with a total value (not including the discount) equal to $10,000 or
more. We only want to consider orders made in the year 2016.
*/

select
	orders.order_id,
    customers.customer_id,
    customers.company_name,
    (order_details.unit_price * order_details.quantity) as Total_Amount
 from customers
	left join orders 
		on customers.customer_id = orders.customer_id
	left join order_details
		on orders.order_id = order_details.order_id
	where orders.order_date >= '1997/01/01'
		and orders.order_date <= '1998/12/31'
		having Total_Amount >= 10000 
        order by Total_Amount desc;
        
  /*
  33. High-value customers - total orders
The manager has changed his mind. Instead of requiring that customers
have at least one individual orders totaling $10,000 or more, he wants to
define high-value customers as those who have orders totaling $15,000
or more in 2016. How would you change the answer to the problem
above?
*/

select
	orders.order_id,
    customers.customer_id,
    customers.company_name,
    (order_details.unit_price * order_details.quantity) as Total_Amount
 from customers
	left join orders 
		on customers.customer_id = orders.customer_id
	left join order_details
		on orders.order_id = order_details.order_id
	where orders.order_date >= '1997/01/01'
		and orders.order_date <= '1998/12/31'
		having Total_Amount >= 15000 
        order by Total_Amount desc; 
  
/*  
34. High-value customers - with discount
Change the above query to use the discount when calculating high-value
customers. Order by the total amount which includes the discount  
*/

select
	orders.order_id,
    customers.customer_id,
    customers.company_name,
   
    (order_details.unit_price * order_details.quantity * (1-discount)) as Total_With_Discount,
     (order_details.unit_price * order_details.quantity) as Total_without_Discount
 from customers
	left join orders 
		on customers.customer_id = orders.customer_id
	left join order_details
		on orders.order_id = order_details.order_id
	where orders.order_date >= '1997/01/01'
		and orders.order_date <= '1998/12/31'
		group by customer_id
        order by Total_without_discount desc; 
	
    
    
/*
35. Month-end orders
At the end of the month, salespeople are likely to try much harder to get
orders, to meet their month-end quotas. Show all orders made on the last
day of the month. Order by EmployeeID and OrderID
*/

select 
	employees.employee_id,
    orders.order_id,
    last_day(order_date) as last_day_OF_month
from employees 
	left join orders
		on employees.employee_id = orders.employee_id
	group by order_id
    order by employee_id ;
      
/*
36. Orders with many line items
The Northwind mobile app developers are testing an app that customers
will use to show orders. In order to make sure that even the largest
orders will show up correctly on the app, they'd like some samples of
orders that have lots of individual line items. Show the 10 orders with
the most line items, in order of total line items
*/

select
	order_id,
    customer_id,
    count(customer_id) as total_details_of_customer
from orders
	group by(customer_id)
    order by total_details_of_customer desc;
	
/*
37. Orders - random assortment
The Northwind mobile app developers would now like to just get a
random assortment of orders for beta testing on their app. Show a
random set of 2% of all orders.
*/

select
	order_id,
    customer_id,
    Rand(2) as random_order
from orders
	group by customer_id;

   

/*
38. Orders - accidental double-entry
Janet Leverling, one of the salespeople, has come to you with a request.
She thinks that she accidentally double-entered a line item on an order,
with a different ProductID, but the same quantity. She remembers that
the quantity was 60 or more. Show all the OrderIDs with line items that
match this, in order of OrderID
*/

select
	order_id,
    product_id,
    quantity
from order_details
	where quantity >= 60
    group by quantity and order_id;
	
	
    
/*    
39. Orders - accidental double-entry details
Based on the previous question, we now want to show details of the
order, for orders that match the above criteria.
*/

select
	order_id,
    product_id,
    unit_price,
    discount,
    quantity
from order_details
	group by order_id, quantity
	having count(*) > 1
    order by order_id, product_id;

	
    
/*
40. Orders - accidental double-entry details, derived table
Here's another way of getting the same results as in the previous
problem, using a derived table instead of a CTE. However, there's a bug
in this SQL. It returns 20 rows instead of 16. Correct the SQL.
Problem SQL:
*/
select
	order_details.order_id,
    order_details.product_id,
    order_details.unit_price,
    order_details.quantity,
	order_details.discount
from order_details
	join (
    select
		order_id
	from order_details
		where quantity >= 60
        group by order_id, quantity
        having count(*) > 1)
        PotentialProblemOrders on PotentialProblemOrders.order_id = order_details.order_id
        order by order_id, product_id;

select
	order_id
from order_details
	where quantity >= 60
    group by order_id, quantity
    having count(*) > 1 ;

		
        
/*
    41. Late orders
Some customers are complaining about their orders arriving late. Which
orders are late?
*/

select
	order_id,
    order_date,
    required_date,
    shipped_date,
    count('shipped_date') as late_order
from orders
	where shipped_date > required_date
    group by order_id;
	

/*
42. Late orders - which employees?
Some salespeople have more orders arriving late than others. Maybe
they're not following up on the order process, and need more training.
Which salespeople have the most orders arriving late?
*/

select
	orders.order_id,
    employees.employee_id,
    employees.last_name,
    count('shipped_date') as late_order
from employees
	left join orders
		on employees.employee_id = orders.employee_id
	where shipped_date > required_date
	group by last_name
	order by late_order desc ;

	

/*
43. Late orders vs. total orders
Andrew, the VP of sales, has been doing some more thinking some more
about the problem of late orders. He realizes that just looking at the
number of orders arriving late for each salesperson isn't a good idea. It
needs to be compared against the total number of orders per
salesperson. Return results like the following:
*/

select
	employees.employee_id,
    employees.last_name,
    sum(order_id) as total_order,
    count('shipped_date') as late_orders
from orders
	left join employees
		on orders.employee_id = employees.employee_id
	where shipped_date > required_date
    group by employee_id
    order by employee_id;

		
        

/*  
44. Late orders vs. total orders - missing employee
There's an employee missing in the answer from the problem above. Fix
the SQL to show all employees who have taken orders
*/

select
	employees.employee_id,
    employees.last_name,
    sum(order_id) as total_order,
    count('shipped_date') as late_orders
 
from orders
	left outer join employees
		on orders.employee_id = employees.employee_id
	where shipped_date > required_date  
	group by employee_id
    order by employee_id;
    
   
/*
45. Late orders vs. total orders - fix null
Continuing on the answer for above query, let's fix the results for row 5
- Buchanan. He should have a 0 instead of a Null in LateOrders
*/

select
	employees.employee_id,
    employees.last_name,
    sum(order_id) as total_order,
    count('shipped_date') as late_orders
 
from orders
	left outer join employees
		on orders.employee_id = employees.employee_id
	where shipped_date > required_date
	group by employee_id
    order by employee_id;

		
/*
46. Late orders vs. total orders - percentage
Now we want to get the percentage of late orders over total orders
  */
  
select
	employees.employee_id,
    employees.last_name,
    sum(order_id) as total_order,
    count('shipped_date') as late_orders,
	(count(order_id)*100 / (Select count(*) from orders)) as percentage_late_order
from orders
	left outer join employees
		on orders.employee_id = employees.employee_id
	where shipped_date > required_date
    group by employee_id
    order by employee_id;
    

/*47. Late orders vs. total orders - fix decimal
So now for the PercentageLateOrders, we get a decimal value like we
should. But to make the output easier to read, let's cut the
PercentLateOrders off at 2 digits to the right of the decimal point    
*/

select
	employees.employee_id,
    employees.last_name,
    sum(order_id) as total_order,
    count('shipped_date') as late_orders,
    (count(order_id)*100 / (Select count(*) from orders)) as percentage_late_order,
	cast(avg('late_order') as decimal(10,2)) as percentage_in_decimal,
    round(0.2410,2) as round_decimal

from orders
	left outer join employees
		on orders.employee_id = employees.employee_id
	where shipped_date > required_date
    group by employee_id
    order by employee_id;
    
   
/*
48. Customer grouping
Andrew Fuller, the VP of sales at Northwind, would like to do a sales
campaign for existing customers. He'd like to categorize customers into
groups, based on how much they ordered in 2016. Then, depending on
which group the customer is in, he will target the customer with
different sales materials.
The customer grouping categories are 0 to 1,000, 1,000 to 5,000, 5,000
to 10,000, and over 10,000.
A good starting point for this query is the answer from the problem
“High-value customers - total orders. We don’t want to show customers
who don’t have any orders in 2016.
Order the results by CustomerID
*/

select
	customers.customer_id,
    customers.company_name,
    sum(order_details.quantity * order_details.unit_price) as total_order_amt,
	case
		when (sum(order_details.quantity * order_details.unit_price )) <= 1000 then 'low'
        when(sum(order_details.quantity * order_details.unit_price )) between 1000 and 5000 then 'medium'
        when(sum(order_details.quantity * order_details.unit_price )) between 5001 and 10000 then 'high'
        when(sum(order_details.quantity * order_details.unit_price )) > 10001 then 'very high'
        else 'error'
        end as 'customer_group'
from customers
	left join orders
		on customers.customer_id = orders.customer_id
	left join order_details
		on orders.order_id = order_details.order_id
	where order_date = '1997/01/01' <= '1997/01/31'
    group by customers.customer_id, company_name
    order by total_order_amt desc;
    
    
/*
49. Customer grouping - fix null
There's a bug with the answer for the previous question. The
CustomerGroup value for one of the rows is null.
Fix the SQL so that there are no nulls in the CustomerGroup field
*/

select
	customers.customer_id,
    customers.company_name,
    sum(order_details.quantity * order_details.unit_price) as total_order_amt,
	case
		when (sum(order_details.quantity * order_details.unit_price )) <= 102 then 'null'
		when (sum(order_details.quantity * order_details.unit_price )) between 103 and 1000 then 'low'
        when(sum(order_details.quantity * order_details.unit_price )) between 1000 and 5000 then 'medium'
        when(sum(order_details.quantity * order_details.unit_price )) between 5001 and 10000 then 'high'
        when(sum(order_details.quantity * order_details.unit_price )) > 10001 then 'very high'
        else 'error'
        end as 'customer_group'
from customers
	left join orders
		on customers.customer_id = orders.customer_id
	left join order_details
		on orders.order_id = order_details.order_id
	where order_date = '1997/01/01' <= '1997/01/31' 
	group by customers.customer_id, company_name
	order by total_order_amt desc;

	
    

/*
50. Customer grouping with percentage
Based on the above query, show all the defined CustomerGroups, and
the percentage in each. Sort by the total in each group, in descending
order
*/

select
	customers.customer_id,
     sum(order_details.quantity * order_details.unit_price) as total_order_amt,
     avg(order_details.quantity * order_details.unit_price)/100 as avg_amt,
	case
		when (sum(order_details.quantity * order_details.unit_price )) <= 102 then 'null'
		when (sum(order_details.quantity * order_details.unit_price )) between 103 and 1000 then 'low'
        when(sum(order_details.quantity * order_details.unit_price )) between 1000 and 5000 then 'medium'
        when(sum(order_details.quantity * order_details.unit_price )) between 5001 and 10000 then 'high'
        when(sum(order_details.quantity * order_details.unit_price )) > 10001 then 'very high'
        else 'error'
        end as 'customer_group'
from  customers
	left join orders
		on customers.customer_id = orders.customer_id
	left join order_details
		on orders.order_id = order_details.order_id
	where order_date = '1997/01/01' <= '1997/01/31' 
	group by customer_id, company_name
	order by total_order_amt desc;
	
    
/*
51. Customer grouping - flexible
Andrew, the VP of Sales is still thinking about how best to group
customers, and define low, medium, high, and very high value
customers. He now wants complete flexibility in grouping the
customers, based on the dollar amount they've ordered. He doesn’t want
to have to edit SQL in order to change the boundaries of the customer
groups.
How would you write the SQL?
There's a table called CustomerGroupThreshold that you will need to
use. Use only orders from 2016
*/

select
	customers.customer_id,
    customers.company_name,
	sum(order_details.quantity * order_details.unit_price) as total_order_amt,
     
	case
		
		when (sum(order_details.quantity * order_details.unit_price )) between 100 and 1000 then 'low'
        when(sum(order_details.quantity * order_details.unit_price )) between 1000 and 5000 then 'medium'
        when(sum(order_details.quantity * order_details.unit_price )) between 5001 and 10000 then 'high'
        when(sum(order_details.quantity * order_details.unit_price )) > 10001 then 'very high'
        else 'error'
        end as 'customer_group'
from  customers
	left join orders
		on customers.customer_id = orders.customer_id
	left join order_details
		on orders.order_id = order_details.order_id
	where order_date >= '1997/01/01' and order_date < '1998/01/01' 
	group by customer_id, company_name
	order by total_order_amt desc;
	
/*
52. Countries with suppliers or customers
Some Northwind employees are planning a business trip, and would like
to visit as many suppliers and customers as possible. For their planning,
they’d like to see a list of all countries where suppliers and/or customers
are based
*/

create view Diff_Country as(
select
	suppliers.company_name,
    country
from suppliers
	
	union
select
	customers.company_name,
    country
from customers)
	;

select
 country
 from diff_country
 group by country;


/*
53. Countries with suppliers or customers, version 2
The employees going on the business trip don’t want just a raw list of
countries, they want more details. We’d like to see output like the
below, in the Expected Results.
*/

select
	suppliers.company_name,
    suppliers.country as supplier_country,
    customers.country as customer_country
from suppliers
	left join customers
		on suppliers.company_name = customers.company_name
	
	group by suppliers.country , customers.country
	order by suppliers.country , customers.country desc;

		
        
/*
54. Countries with suppliers or customers - version 3
The output of the above is improved, but it’s still not ideal
What we’d really like to see is the country name, the total suppliers, and
the total customers
*/

select
	
    count(suppliers.country) as total_supplier,
    count(customers.country) as total_customer
    
from suppliers
	left join customers
		on suppliers.company_name = customers.company_name
	
	group by suppliers.country , customers.country
	order by suppliers.country , customers.country desc;

		


/*
55. First order in each country
Looking at the Orders table—we’d like to show details for each order
that was the first in that particular country, ordered by OrderID.
So, we need one row per ShipCountry, and CustomerID, OrderID, and
OrderDate should be of the first order from that country.
*/
with OrderByCountry as(
select
	ship_country,
    customer_id,
    order_id,
    convert(order_date, date) as order_date,
	row_number()
		over(partition by ship_country order by ship_country, order_id) as RowNoPerCountry
from orders)
select
	ship_country,
    customer_id,
    order_id,
	order_date
from OrderByCountry
	where RowNoPerCountry = 1
    order by ship_country;
	
    
    

/*
56. Customers with multiple orders in 5 day period
There are some customers for whom freight is a major expense when
ordering from Northwind.
However, by batching up their orders, and making one larger order
instead of multiple smaller orders in a short period of time, they could
reduce their freight costs significantly.
Show those customers who have made more than 1 order in a 5 day
period. The sales people will use this to help customers reduce their
costs.
Note: There are more than one way of solving this kind of problem. For
this problem, we will not be using Window functions
*/

select
	Initial_order.customer_id,
    Initial_order.order_id as Initial_order_id,
    convert(Initial_order.order_date, date) as initial_order_date,
	next_order.order_id as next_order_id,
    convert(next_order.order_date, date) as  next_order_date,
    datediff(Initial_order.order_date,next_order.order_date) as DaysBetween
from orders Initial_order
	join orders next_order
		on Initial_order.customer_id = next_order.customer_id
	where Initial_order.order_id < next_order.order_id
		and datediff(Initial_order.order_date, next_order.order_date) <=5
        order by Initial_order.customer_id, Initial_order.order_id;
    
    
    
/*
57. Customers with multiple orders in 5 day period, version
2
There’s another way of solving the problem above, using Window
functions. We would like to see the following results
*/

with NextOrderDate as (
select
	customer_id,
    convert(order_date, date) as OrderDate,
    convert(Lead(order_date,1), date) 
    over(partition by customer_id order by customer_id, order_date) as NextorderDate)
      
from orders
)    
select
	customer_id,
    order_date,
    NextOrderDate,
    datediff(order_date, NextOrderDate) as DaysBetweenOrders
from NextOrderDate
	where datediff(order_date, NextOrderDate) <=5
    






























































































