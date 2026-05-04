-- Performance Analysis -  Comparing current value to a target value

-- Analyse the yearly sales of products
-- By compairing each products sales to both it's average sales performance and previous year's sale.


WITH yearly_product_sales AS (SELECT 
    p.product_id,
    p.product_name,
    SUM(sales_amount) AS current_sales,
    DATE_FORMAT(order_date, '%Y') AS orderyear
FROM
    sample_dataset.`gold.fact_sales` s
	JOIN
    sample_dataset.`gold.dim_products` p ON p.product_key = s.product_key
WHERE
    DATE_FORMAT(order_date, '%y') IS NOT NULL
GROUP BY orderyear , p.product_name , p.product_id
)
SELECT product_id,
       product_name,
       orderyear,
       current_sales,
       ROUND(AVG(current_sales) OVER(PARTITION BY product_name), 2) AS avergae_sales,
       ROUND(current_sales - AVG(current_sales) OVER(PARTITION BY product_name), 2) AS diff_avg,
       CASE WHEN current_sales - AVG(current_sales) OVER(PARTITION BY product_name) > 0 THEN 'Above Avg'
            WHEN current_sales - AVG(current_sales) OVER(PARTITION BY product_name) < 0 THEN 'Below Avg'
            ELSE 'Avg'
       END AS performace_category,
       LAG(current_sales) OVER(PARTITION BY product_name ORDER BY orderyear) AS prev_year_sales,
       ROUND((current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY orderyear)),2) AS py_diff,
       CASE WHEN current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY orderyear) > 0 THEN 'Increasing'
            WHEN current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY orderyear) < 0 THEN 'Decreasing'
            ELSE 'No Change'
	   END AS PY_comparison
FROM
yearly_product_sales
ORDER BY product_name, orderyear;