Create database sql_project_p1;
-- CREATING TABLE

Create Table reatil_sales_tb
         (
         Transaction_id INT,
         sale_date INT,
         sale_time INT,
         customer_id VARCHAR(15),
         gender VARCHAR(15),
         age INT,
         category VARCHAR(18),
         quantity INT,
         price_per_unit FLOAT,
         cogs FLOAT,
         total_sale FLOAT
         )
         
         

SELECT * FROM sql_project_p1.retail_sales_tb limit 10;
-- DATA CLEANING

SELECT count(*) from sql_project_p1.retail_sales_tb;

SELECT * from retail_sales_tb 
where transactions_id is NULL
      OR sale_date is NULL
      OR sale_time is NULL
      OR customer_id is NULL
      OR gender is NULL
      OR age is NULL
      OR category is NULL
      OR quantiy is NULL
      OR price_per_unit is NULL
      OR cogs is NULL
      OR total_sale is NULL;
      
      
      
      
	
-- DATA EXPLORATION

-- HOW MANY SALES WE HAVE?
SELECT count(*) as total_sales from retail_sales_tb;



-- HOW MANY UNIQUE CUSTOMERS WE HAVE?
SELECT count(DISTINCT(customer_id)) as cutomer_count from retail_sales_tb;



-- DATA ANALYSIS



-- Q.1 WRITE a SQl query to retrieve all columns for sales made on '2022-11-05'
SELECT * 
from retail_sales_tb 
where sale_date = '2022-11-05';




-- Q.2 Write a SQL query to retrieve all transactions where the category is 'clothing' and the quantity sold is more than 4
-- in the month of nov-2022?
    SELECT *
    from sql_project_p1.retail_sales_tb 
    WHERE category = 'clothing'
    AND quantiy > 4
    AND sale_date >= '2022-11-01'
    AND sale_date < '2022-12-01';
	
    

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category
SELECT
 category,
SUM(total_sale) as net_sale,
COUNT(*) as total_orders 
FROM sql_project_p1.retail_sales_tb
GROUP BY 1;



-- Q.4 Write a SQL query to find the average age of customers who purchased items from 'Beauty' category. 
SELECT 
category,
Round(avg(age),2) as average_age
from sql_project_p1.retail_sales_tb
where category='Beauty'
group by 1;



-- Q.5 Write a SQl query to find all transactions where the total_sale is greater than 1000. 
SELECT
*
from sql_project_p1.retail_sales_tb
where total_sale>1000;



-- Q.6 Write a  SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT
 category,
 gender,
 count(*) as total_tran
 from sql_project_p1.retail_sales_tb
 group by category,gender;
 


-- Q.7 Write a SQL query to calculate the average sale for each month. find out the best selling month in each year.
 with cte as
 (
 SELECT 
 extract(YEAR from sale_date) as YEAR,
 extract(MONTH from sale_date) as MONTH,
 avg(total_sale) as avg_sale,
 RANK() over(partition by extract(YEAR from sale_date) order by avg(total_sale)desc) as rank_1
 from sql_project_p1.retail_sales_tb 
 group by 1,2
 )
 select 
      YEAR,
       MONTH,
       avg_sale 
  from cte where rank_1 = 1;
 
 

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sale.
 SELECT
    customer_id,
    sum(total_sale) as total_sale
    from sql_project_p1.retail_sales_tb 
   group by customer_id
   order by 2 desc
    limit 5;
    


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
    category,
      count(distinct customer_id) as unique_customers
    from sql_project_p1.retail_sales_tb 
    group by category;
    


-- Q.10 Write a SQL query to create each shift and number of orders (Example morning <12, Afternoon between 12 & 17, Evening >17)
with cte as
(
SELECT *,
    CASE
       when extract(HOUR from sale_time)<12 then 'Morning'
       when extract(HOUR from sale_time) between 12 and 17 then 'Afternoon'
       else 'Evening'
       end as shift
 from sql_project_p1.retail_sales_tb 
 )
 select 
       shift,
       count(*) as total_orders
 from cte
 group by shift

 
 
 -- END OF THE PROJECT
 
 



 
     