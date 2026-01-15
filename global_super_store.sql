
#  1      Which markets and regions contribute the highest and lowest total sales?

#Lowest Sales
select region,market,round(sum(sales),2) as total_sales from orders group by region,market order by sum(sales) limit 1;

#Highest Sales
select region,market,round(sum(sales),2) as total_sales from orders group by region,market order by sum(sales) desc limit 1;


#  2      Which product categories and sub-categories are most and least profitable?

#Most Profit
select category,`sub-category`,round(sum(profit),2) from orders group by category,`sub-category` order by sum(profit) desc limit 1;

#Least Profit
select category,`sub-category`,round(sum(profit),2) from orders group by category,`sub-category` order by sum(profit) limit 1;


#  3       Which products are responsible for the highest losses?
    
select `product_name` , round(sum(profit)) from orders group by `product_name` order by sum(profit) limit 1;


#  4       How do sales and profit trends change monthly and yearly?

select year(order_date) as year, month(order_date) as month, round(sum(sales),2) as total_sales, round(sum(profit),2) as total_profit from orders group by year(order_date), month(order_date) order by year(order_date), month(order_date);



#  5        What is the average order value (AOV) by market and segment?

select market, segment, round(sum(sales)/count(distinct order_id),2) as aov from orders group by market, segment order by market, segment;


#   6       Which shipping modes lead to higher profit margins?

select ship_mode, round(sum(profit)/sum(sales)*100,2) as profit_margin_pct from orders group by ship_mode order by profit_margin_pct desc;


#   7       Which months show seasonal spikes or drops in sales?
select month(order_date) as month, round(sum(sales),2) as total_sales from orders group by month(order_date) order by total_sales desc;


#    8       Which markets rely heavily on discounts to drive sales?

select market, round(sum(discount * sales)/sum(sales)*100,2) as discount_dependency_pct from orders group by market order by discount_dependency_pct desc;


#    9       Which orders have unusually high discounts but low revenue?
    
select order_id, round(sales,2) as sales, discount from orders where discount > 0.3 and sales < (select avg(sales) from orders) order by discount desc, sales asc limit 5;


#   10       What percentage of orders are unprofitable?

select round(sum(case when profit < 0 then 1 else 0 end)/count(*)*100,2) as unprofitable_order_pct from orders;
