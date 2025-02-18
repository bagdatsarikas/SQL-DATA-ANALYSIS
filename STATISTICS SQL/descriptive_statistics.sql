

-- 1. What is the total number of transactions recorded?

/* 
Explanation:

This query calculates the total number of rows in the daily_sales table, which represents the total number of daily transactions recorded.
*/

SELECT COUNT(*) as total_transaction 
FROM daily_sales;



--  What is the overall total revenue?

/*
Explanation:

This query sums up the total_revenue column to determine the overall revenue generated across all recorded days.
*/



SELECT SUM(total_revenue) as overall_total_revenue
FROM daily_sales;



--  What is the average revenue per day?

/*
Explanation:

This query calculates the average revenue per recorded transaction date by dividing the total revenue by the number of days.

*/

SELECT AVG(total_revenue) AS avg_daily_revenue 
FROM daily_sales;


-- What is the highest and lowest daily revenue recorded?

/*
Explanation:

Finding the minimum and maximum values in the total_revenue column helps identify the best and worst performing days in terms of sales.
*/

SELECT MAX(total_revenue) as highest_revenue,
		MIN(total_revenue) as lowest_revenue
FROM daily_sales;



-- How does revenue vary across different months?

/*
Explanation:

Grouping data by the month column and summing total_revenue helps analyze revenue trends across different months.

*/

SELECT SUM(total_revenue) as monthly_revenue, 
		month 
FROM daily_sales
GROUP BY month 
ORDER BY month;


-- Minimum and Maximum Employees per Shift for Each Month

/*
This groups the data by month_of_year and finds the max and min number of employees working per shift in each month.
*/


SELECT MIN(shift_count) as minimum_employees,
		MAX(shift_count) as maximum_employees,
            month
FROM daily_sales 
GROUP BY month
order by month;
            
-- Variance & Standard Deviation

-- Spread of Quantity Sold Per Month (Variance & Standard Deviation)

SELECT month,
		SUM(quantity_sold) as total_unit_sold, 
        ROUND(AVG(quantity_sold),2) as avg_unit_sold, 
        VAR_POP(quantity_sold) as variation_quantity,
        STDDEV_POP(quantity_sold) AS stddev_quantity_sold
FROM daily_sales
GROUP BY month
ORDER BY month;

-- Interpreting the Results

/* 

High variance values indicate that unit sales fluctuate significantly within a month.
Standard deviation provides a better understanding of how much actual daily sales deviate from the average.


February has the highest variance (35,341.67), indicating that sales fluctuated significantly from day to day.

June has the lowest variance (13,780.00), meaning daily sales were more consistent.

A higher SD means sales numbers vary a lot from the average, while a lower SD suggests more consistent sales.

February has the highest SD (187.99 units), confirming that sales in this month were highly inconsistent.

june has the lowest SD (117.39 units), meaning sales were relatively stable compared to other months.


*/

