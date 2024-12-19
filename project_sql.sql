--EDA with sql --
SELECT * FROM walmart;
drop table walmart
-- 
SELECT COUNT(*) FROM walmart; 

SELECT DISTINCT payment_method FROM walmart;

SELECT
	payment_method,
	COUNT(*) 
FROM walmart
GROUP BY payment_method;

SELECT COUNT (DISTINCT branch) FROM walmart;

SELECT MAX(quantity) FROM walmart;
SELECT MIN(quantity) FROM walmart;

-- Business problems
--Q.1 - Find different payment method and the number of transactions, number of qty sold
SELECT
	payment_method,
	COUNT(*) as no_transactions,
	SUM(quantity) as no_qty_sold
FROM walmart
GROUP BY payment_method;

--Q.2 -Identify  the highest-rated category in each branch, displaying the branch,
--category, AVG Rating
SELECT *
FROM
(	SELECT
		branch,
		category,
		AVG(rating) as avg_rating,
		RANK() OVER(PARTITION BY branch ORDER BY AVG(rating) DESC) as rank
	FROM walmart
	GROUP BY 1,2
)
WHERE rank = 1;

--Q.3 - Identify the busiest day for each branch based on the number of transactions
SELECT *
FROM
	(SELECT 
		branch,
		TO_CHAR(TO_DATE(date, 'DD/MM/YY'), 'Day') as day_name,
		COUNT(*) as no_transactions,
		RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) as rank
	FROM walmart
	GROUP BY 1,2
	)
WHERE rank = 1;

--Q.4 -Calculate the total qty of items sold per payment method, list payment_method and
-- total_quantity
SELECT payment_method,
	SUM(quantity) as no_qty_sold
FROM walmart
GROUP BY payment_method
--Q.5 - Determine the average, minimum, and maximum rating of category for each city.
-- List the city, average_rating, min_rating, and max_rating
SELECT
	city,
	category,
	AVG(rating) as avg_rating,
	MIN(rating) as min_rating,
	MAX(rating) as max_rating
FROM walmart
GROUP BY 1,2

--Q.6 -Calculate total profit for each category by considering total_profit as 
--(unit_price * quantity * profit_margin).
--List category and total_profit, ordered from highest to lowest profit.
SELECT 
	category,
	SUM(total) as total_revenue,
	SUM(total * profit_margin) as profit 
FROM walmart
GROUP BY 1
ORDER BY 3 DESC

--Q.7 - 
--Determine the most common payment method for each Branch.
--Display Branch and the preferred_payment_method
WITH cte
AS
(SELECT
	branch,
	payment_method,
	COUNT(*) as total_trans,
	RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) as rank
FROM walmart
GROUP BY 1, 2
)
SELECT *
FROM cte
WHERE rank = 1

-- Categoraize sales into 3 group MORNING, AFTERNOON, EVENING
-- Find out each of the  shift and number of invoices
SELECT 
	branch,
	CASE 
		WHEN EXTRACT (HOUR FROM(time ::time)) < 12 THEN 'Morning'
		WHEN EXTRACT (HOUR FROM(time ::time)) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END day_time,
	COUNT(*)
FROM walmart 
GROUP BY 1,2 
ORDER BY 1,2 DESC -- Afternon has the higest sales

--Q.9 - Identify 5 branch with highest decrease ratio in
--revenue compare to last year(current year 2023 and last year 2022)
--rdr = (last_rev - crent_rev) / last_rev * 100

-- 2022 sales
WITH revenue_2022 
AS
(	
	SELECT
		branch,
		SUM(total) as revenue
	FROM walmart
	WHERE EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) = 2022
	GROUP BY 1
),

revenue_2023
AS
(
	SELECT
		branch,
		SUM(total) as revenue
	FROM walmart
	WHERE EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) = 2023
	GROUP BY 1
)
SELECT 
	ls.branch,
	ls.revenue as last_year_revenue,
	cs.revenue as cr_year_revenue,
	ROUND((ls.revenue - cs.revenue)::numeric/ 
	ls.revenue::numeric * 100, -- converting it to numeric
	2)  as rev_dec_ratio-- ROUNDING IT WITH ONLY 2 
FROM revenue_2022 as ls
JOIN
revenue_2023 as cs
ON ls.branch = cs.branch
WHERE ls.revenue > cs.revenue
ORDER BY  4 DESC
LIMIT 5

-- Q.10 - What is the 3 cities with the highest revenue
SELECT 
	city,
	branch,
	SUM(total) AS total_revenue
FROM walmart
GROUP BY city, branch 
ORDER BY total_revenue DESC
LIMIT 3;

--Q.11 - What category line had the largest revenue? R.(Fashion accessories)
SELECT
	category,
	--SUM(total) as total_revenue
	CAST(SUM(total) as NUMERIC(10,2)) as total_revenue --converts the sum result to a numeric type
FROM walmart
GROUP BY category
ORDER BY total_revenue DESC


--
select * from walmart









