# Walmart-Sales-Analysis-Project
![End to end pytheon + sql + power bi project](https://github.com/user-attachments/assets/38573361-04b8-45b2-b77e-423f1536c552)

## Walmart Data Analysis: End-to-End SQL + Python + Poer BI Project

## Project Overview


#### This project is an end-to-end data analysis solution designed to extract critical business insights from Walmart sales data.I utilized Python for data processing and analysis, SQL for advanced querying, and structured problem-solving techniques to solve key business questions and then power Bi for data visualizton.
---

## Tools Used

	 Visual Studio Code (VS Code), Python, SQL (PostgreSQL),Power BI
   
## Exploring the data

### 1. Data Cleaning
   - **Remove Duplicates**: Identify and remove duplicate entries to avoid skewed results.
   - **Handle Missing Values**: Drop rows or columns with missing values if they are insignificant; fill values where essential.
   - **Fix Data Types**: Ensure all columns have consistent data types (e.g., dates as `datetime`, prices as `float`).
   - **Currency Formatting**: Use `.replace()` to handle and format currency values for analysis.
   - **Validation**: Check for any remaining inconsistencies and verify the cleaned data.

### 2. Feature Engineering
   - **Create New Columns**:I Calculated the `Total Amount` for each transaction by multiplying `unit_price` by `quantity` and adding this as a new column.

### 3 Load Data into PostgreSQL

### 4. SQL Analysis: Complex Queries and Business Problem Solving:
     - Revenue trends across branches and categories.
     - Identifying best-selling product categories.
     - Sales performance by time, city, and payment method.
     - Analyzing peak sales periods and customer buying patterns.
     - Profit margin analysis by branch and category.
     - What category line had the largest revenue?
     - Top 5 Branches with the higest rating

## 5. Power BI Vizualization:
- I created a new column called `Profit` for each transaction.


## Data Source:
   Kaggle’s Walmart Sales Dataset
