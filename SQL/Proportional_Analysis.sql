-- Part to whole, Proportional Anlaysis

-- Task - Find out which category contribute the most for overall sales

With category_wise_sales as (select category, sum(sales_amount) as sales_per_category
from sample_dataset.`gold.fact_sales` s
join sample_dataset.`gold.dim_products` p
on s.product_key = p.product_key
group by category)

select category, sales_per_category , sum(sales_per_category) over() as overall_sales,
round((sales_per_category/ sum(sales_per_category) over()* 100), 2) as percent_contribution
from category_wise_sales
order by percent_contribution desc;

