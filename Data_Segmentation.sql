-- Data Segmentation

-- this will help calculating mesure by measure
-- ex - total customer by age ,  total product by sales range


-- Task 1 - > Segment products into cost ranges and count how many products falls into each segment

-- cost < 100 THEN 'Below 100'
-- cost between 100 and 500
-- cost between 500 and 1500
-- cost > 1500 

WITH cost_segmentation as (
select product_key, product_name, cost,
CASE 
 WHEN cost < 100 THEN 'Below 100'
 WHEN cost between 100 and 500 THEN '100-500'
 WHEN cost between 500 and 1500 THEN '500-1500'
 WHEN cost > 1500 THEN 'Above 1500'
 ELSE 'ELITE'
END as product_distribution
from sample_dataset.`gold.dim_products`
where cost > 0 )


select product_distribution, 
       count(product_key) as product_key
from cost_segmentation
group by product_distribution
order by product_key desc;


-- Task 2-> 

-- Group customers into three segments based on their spending behavior:

-- - VIP: at least 12 months of history and spending more than €5,000.
-- - Regular: at least 12 months of history but spending €5,000 or less.
-- - New: lifespan less than 12 months.

-- And find the total number of customers for each group

WITH cust_data as (
select c.customer_key, 
	sum(s.sales_amount) as total_spent,
	max(s.order_date) as latest_order,
    min(s.order_date) as first_order,
    timestampdiff(month, min(s.order_date), max(s.order_date)) as lifespan_in_month
from sample_dataset.`gold.fact_sales` s
left join sample_dataset.`gold.dim_customers` c
on c.customer_key = s.customer_key
group by c.customer_key)


select customer_type,
count(customer_key)
from
(select customer_key,
	   total_spent,
       lifespan_in_month, 
       CASE 
           WHEN total_spent > 5000 and lifespan_in_month >= 12 THEN 'VIP'
           WHEN total_spent <= 5000 and lifespan_in_month >= 12 THEN 'Regular'
		   WHEN lifespan_in_month < 12 THEN 'New'
           END
           as customer_type
from cust_data
where lifespan_in_month is not null )t
group by customer_type;

