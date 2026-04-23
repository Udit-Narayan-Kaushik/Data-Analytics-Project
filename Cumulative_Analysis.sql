-- Calculate total sales per month
-- and running total of sales over time.

WITH sales_per_month AS (
    SELECT 
        DATE_FORMAT(order_date, '%Y-%m') AS yearmonth,
        SUM(sales_amount) AS monthly_sales
    FROM sample_dataset.`gold.fact_sales`
    WHERE DATE_FORMAT(order_date, '%Y-%m') IS NOT NULL 
      AND sales_amount IS NOT NULL
    GROUP BY yearmonth
)

SELECT 
    *,
    SUM(monthly_sales) OVER (
        partition by yearmonth
        ORDER BY yearmonth
    ) AS running_total
FROM sales_per_month
ORDER BY yearmonth;