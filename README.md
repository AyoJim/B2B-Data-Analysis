This project involves analyzing the B2B sales pipeline data for a company that sells computer hardware. The dataset includes comprehensive information on customer accounts, product offerings, sales teams, and sales opportunities. 

##Aim 
To gain insights into sales performance, identify top-selling products, and evaluate the effectiveness of sales teams, ultimately driving strategic business decisions and enhancing revenue growth.

The main objectives of this project:
1. Gain Insights into Sales Performance by analyzing the sales pipeline data, uncovering overall sales trends across various sectors over a period of time.

2. Identify Top-Selling Products in different markets and customer segments to optimize inventory management and focus marketing efforts on high-demand items.

3. Evaluate the Effectiveness of Sales Teams by analyzing their success rates, customer interactions, and regional performance, with the goal of identifying areas for improvement and best practices to enhance overall sales efficiency.

## Tools
PostgreSQL. Techniques used across the three SQL files:
- **Data cleaning**: handling nulls, standardizing values, replacing placeholder data (`CRM Data cleaning.sql`)
- **Aggregate analysis**: revenue and close-value summaries by sector, team, and product; win/loss counts per sales agent (`CRM Data Query & Analysis.sql`)
- **Window functions**: ranking accounts by revenue within office locations, quartile/percentile segmentation, sequential sector comparisons (`CRM Windows function.sql`)
- **Tableau**: visualized the above for a non-technical audience (see screenshot below)

## Dashboard
![B2B Analytics](B2B%20Analytics.png)

## How to run
Load the CRM dataset into PostgreSQL with four tables — `Accounts`, `Sales_pipeline`, `Sales_team`, `Products` — joined on `Account`, `Sales_agent`, and `Product`. Run `CRM Data cleaning.sql` first, then the analysis and window function files.
