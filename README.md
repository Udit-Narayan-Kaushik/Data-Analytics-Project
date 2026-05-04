# Sales & Customer Analytics Project
Analysed customer behaviour and product trend across 18.4K users and $29.36M in revenue.

# The Business Problem:
An international retailer with 18,469 customers and $29.36M in revenue faced extreme category dependency. While 96.5% of revenue was driven by high-cost bikes, the brand struggled to convert its 80.2% "New" customer base into repeat buyers for high-margin accessories.

# The business needed to identify:

#### . Where is the customer lifecycle stalling?  
#### . How can we unlock hidden profit in lower-tier inventory? 
#### . Why are "High-Performer" products becoming stagnant? 
#### . What is the "Profit Gap" between volume and value? 

## Visuals

<img width="800" height="800" alt="image" src="https://github.com/user-attachments/assets/9cb02384-04c2-4658-922b-6e4fbb5932eb" />
<img width="1000" height="600" alt="image" src="https://github.com/user-attachments/assets/64c4a081-9715-44f7-8b0d-78ed79f5c166" />

## Project Structure

```
├── sql_scripts/
│   ├── 01_data_cleaning_segmentation.sql    # Data_Segmentation.sql logic
│   ├── 02_product_performance_metrics.sql   # Product_Report.sql logic
│   ├── 03_customer_lifecycle_analysis.sql   # Customer_Report.sql logic
│   ├── 04_proportional_sales_impact.sql     # Proportional_Analysis.sql logic
│   ├── 05_growth_velocity_trends.sql        # Change_Over_Time.sql logic
│   └── 06_cumulative_running_totals.sql     # Cumulative_Analysis.sql logic
├── python_notebooks/
│   ├── 01_exploratory_data_analysis.ipynb   # Initial data profiling
│   ├── 02_profit_margin_calculation.py      # Category-level margin scripts
│   └── 03_inventory_risk_modeling.py        # Dead-stock and recency logic
├── visualizations/
│   ├── reports/
│   │   ├── 01_revenue_by_category.png       # Proportional sales chart
│   │   ├── 02_customer_segment_split.png    # VIP vs. New pie chart
│   │   ├── 03_product_cost_distribution.png # Catalog cost segmentation
│   │   └── 04_growth_rate_velocity.png      # MoM growth line chart
│   └── dashboard_exports/
│       ├── page1_executive_overview.pdf
│       ├── page2_customer_deep_dive.pdf
│       └── page3_inventory_health.pdf
├── data_assets/
│   ├── raw/                                 # Original source files
│   ├── processed/                           # Final .csv outputs
│   └── data_dictionary.md                   # Column definitions
└── documentation/
    ├── analysis_summary.md                  # Methodology
    └── business_recommendations.pdf         # Strategy for stakeholders
```

# Key Findings

#### . Key InsightsThe 96% Category Concentration: Bikes generate $28.3M of the total revenue, creating a significant risk if bike market demand fluctuates.  
#### . High-Margin Opportunity: Accessories and Clothing carry margins of 60%+, yet they currently represent only 3.5% of the total sales volume.  
#### . Massive New Lead Base: 14,815 customers are currently in the "New" category, providing a massive pool for retention-focused marketing. 
#### . Inventory Stagnation: 66 high-revenue products have zero sales in the last 12 months, tying up capital that could be reinvested in mid-range stock. 
#### . VIP Engagement Gap: 137 VIP customers are "one-time high spenders" with low order counts, indicating a failure in the post-purchase service funnel. 


# Business Recommendations

#### . Implement "High-Margin Bundling": Force-bundle 62.8% margin accessories with every bike sale to increase the current $1.04M non-bike revenue pool.  
#### . Launch New-to-Regular Conversion: Targeted 3-phase email sequence for the 14,815 New customers at the 6-month mark to prevent churn. 
#### . VIP Reactivation Campaign: Offer "Complimentary First Service" to the 137 low-engagement VIPs to secure high-margin aftermarket sales. 
#### . Inventory Liquidation: Discount the 66 "Dead Stock" items to clear warehouse space for the more balanced $500–$1,500 product segment. 

# Tools Used

#### MySQL: CTEs, CASE WHEN, LAG(), TIMESTAMPDIFF
#### Python: Pandas for Margin Analysis, Seaborn for Data Visualization
#### Analytics: Customer Lifespan Analysis, Inventory Aging, Gross Margin Optimization
