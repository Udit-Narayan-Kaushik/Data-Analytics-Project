
-- Change Over Time Analysis

-- 1. Monthly Sales Trend
-- Question:
-- How does total sales change month over month?
-- What you analyze: Growth, seasonality, decline periods.

SELECT 
    SUM(sales_amount),
    MONTH(order_date) AS month_num,
    MONTHNAME(order_date) AS sales_month,
    YEAR(order_date) AS sales_year
FROM
    sample_dataset.`gold.fact_sales`
WHERE
    order_date IS NOT NULL
        AND sales_amount IS NOT NULL
GROUP BY MONTH(order_date) , MONTHNAME(order_date) , YEAR(order_date)
ORDER BY month_num , sales_year;



-- 2. Monthly New Customers Trend
-- Question:
-- How many new customers are acquired each month?
-- What you analyze: Customer acquisition trend.


SELECT 
    yearandmonth,
    new_customers,
    LAG(new_customers) OVER (ORDER BY yearandmonth) AS prev_month,
    new_customers - LAG(new_customers) OVER (ORDER BY yearandmonth) AS growth
FROM (
    SELECT 
        DATE_FORMAT(create_date, '%Y-%m') AS yearandmonth,
        COUNT(customer_id) AS new_customers
    FROM sample_dataset.`gold.dim_customers`
    GROUP BY yearandmonth
)t;


-- 3. Sales Growth Rate Month Over Month
-- Question:
-- What is the month-over-month sales growth rate?
-- What you analyze: Business growth speed.

WITH monthly_sales AS (
    SELECT 
        SUM(sales_amount) AS total_monthly_sales,
        DATE_FORMAT(order_date, '%Y-%m') AS yearandmonth
    FROM sample_dataset.`gold.fact_sales`
    WHERE DATE_FORMAT(order_date, '%Y-%m') IS NOT NULL 
      AND sales_amount IS NOT NULL
    GROUP BY yearandmonth
)

SELECT
    yearandmonth,
    total_monthly_sales,
    LAG(total_monthly_sales) OVER (ORDER BY yearandmonth) AS prev_month,
    total_monthly_sales - LAG(total_monthly_sales) OVER (ORDER BY yearandmonth) AS growth,
    (
        (total_monthly_sales - LAG(total_monthly_sales) OVER (ORDER BY yearandmonth))
        / LAG(total_monthly_sales) OVER (ORDER BY yearandmonth)
    ) * 100 AS growth_rate
FROM monthly_sales;



-- 4. Top Selling Products Over Time
-- Question:
-- Which products are generating the most revenue each month?
-- What you analyze: Product performance trend.

With monthly_sales_product as 
(select p.product_key, p.product_name, date_format(s.order_date, '%y-%m') as yearmonth, 
sum(s.sales_amount) as total_sales
from sample_dataset.`gold.fact_sales` as s
join sample_dataset.`gold.dim_products` as p
on s.product_key = p.product_key
where date_format(s.order_date, '%y-%m') is not null
group by p.product_key, p.product_name, yearmonth
order by yearmonth, total_sales),

top_products as (
select *,
rank() over(partition by yearmonth 
            order by total_sales desc) as rnk
from monthly_sales_product
)

select product_key,
    product_name,
    yearmonth,
    total_sales
FROM top_products
WHERE rnk = 1
ORDER BY yearmonth;



-- 5. Customer Retention Over Time
-- Question:
-- How many customers are repeat customers each month?
-- What you analyze: Retention vs new customers.

select count(distinct customer_id) unique_cust, date_format(create_date, '%Y-%m') as yearmonth
from sample_dataset.`gold.dim_customers` 
group by yearmonth
order by yearmonth;













 


