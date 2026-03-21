-- Q1: List all customers along with the total number of orders they have placed

SELECT 
    c.customer_id,
    c.name as custumer_name,
    COUNT(o.order_id) AS total_orders
FROM 'datasets/customers.csv' c
LEFT JOIN 'datasets/orders.json' o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;





-- Q2: Find the top 3 customers by total order value

SELECT 
    c.customer_id,
    c.name as customer_name,
    SUM(o.total_amount) AS total_value
FROM 'datasets/customers.csv' c
JOIN 'datasets/orders.json' o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_value DESC
LIMIT 3;




-- Q3: List all products purchased by customers from Bangalore

SELECT DISTINCT
    p.product_name,
FROM 'datasets/products.parquet' p
JOIN 'datasets/orders.json' o
on p.order_id=o.order_id
JOIN 'datasets/customers.csv' c
 on o.customer_id=c.customer_id
WHERE c.city = 'Bangalore';

 
 
 

-- Q4: Join all three files to show: customer name, order date, product name, and quantity

SELECT 
	c.name as customer_name,
	o.order_date,
    p.product_name,
    p.quantity 
from 'datasets/customers.csv' c 
join 'datasets/orders.json' o 
on c.customer_id=o.customer_id 
join 'datasets/products.parquet' p 
on o.order_id=p.order_id;

