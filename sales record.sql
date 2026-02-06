create database zepto;
use zepto;

-- All data explore----

SELECT * FROM zepto_record;

-- DATA EXPLORATION ------

SELECT Category FROM zepto_record;

-- COUNT OF ROW-----------

select count(*) FROM zepto_record;

-- Checking null value -----
 select * from zepto_record
 where Category is null
 or name is null
 or mrp is null
 or discountPercent is null
 or availableQuantity is null
 or discountedSellingPrice is null
 or weightInGms is null
 or outOfStock is null
 or quantity is null;

-- what kind of product category we have

select distinct Category from
zepto_record order by Category;

 -- product in stock vs out of stock-------

SELECT  outOfStock, COUNT(*) FROM zepto_record
GROUP BY outOfStock;

-- --Those product which is appear in more than once ----

select name , count(*)
from  zepto_record  group by name 
having count(*) > 1
order by count(*) desc;

-- Data cleaning---

-- product with price 0----------
select * from zepto_record
where mrp=0;

select * from zepto_record
where discountedSellingprice = 0;

delete from zepto_record
where mrp =0;

-- Convert paisa to Rupees
update zepto_record set mrp= 100.0,
discountedSellingprice = discountedSellingprice/100.0;


-- --------------------------Data Analysis--------------------

-- Q.1  find the top 10 best value product based  on the discount percentage.

select distinct Category, name , discountpercent 
from zepto_record 
order by discountpercent  desc
limit 10;
 
-- Q..2 WHAT are the products with high MRP  BUT out os stock 

select * from  zepto_record 
where outOfStock ='true'
order by mrp desc limit 10;

-- Q3 calculate estimate revenue for each category 
SELECT category,
SUM(discountedSellingPrice * availableQuantity) 
AS total_revenue FROM zepto_record
GROUP BY category
ORDER BY total_revenue DESC
LIMIT 5;

-- Q.4 Find all product where is MRP is greater than 500 rupees and dicount is less than 10%. 
 
 select distinct name, mrp , discountpercent
 from zepto_record 
 where mrp > 500 and discountpercent < 10
 order by mrp desc , discountpercent desc limit 10;
-- Q.5 Identify the top categories offering the highest average discount percentage. 

select category,
round (avg (discountpercent),2) as avg_discount
from zepto_record 
group by Category
order by avg_discount desc  limit 5;

-- Q.6 Find the price per gram for product above 100g and short  best value.

select distinct name, weightInGms, discountedSellingPrice,
ROUND (discountedSellingPrice/weightInGms) AS price_per_gram
from  zepto_record 
where weightInGms >=100
order by price_per_gram desc limit 10;

--  q.7  group the product onto ctegories like low , medium , bulk.
SELECT DISTINCT 
  name,
  weightInGms,
  CASE 
    WHEN weightInGms < 1000 THEN 'low'
    WHEN weightInGms < 5000 THEN 'medium'
    ELSE 'bulk'
  END AS weight_categories
FROM zepto_record
;

  -- Q.8 What is total Inventary Weight per category
  select Category ,  
  SUM(weightInGms*availableQuantity) as total_weight 
  from zepto_record 
  group by category 
  order by Total_weight desc;
  
  
  
  -- ---- END PROJECT---------------------------------------------