1336. Number of Transactions per Visit
# Write an SQL query to find how many users visited the bank and didn't do any transactions, how many visited the bank and did one transaction and so on.

# The result table will contain two columns:

# transactions_count which is the number of transactions done in one visit.
# visits_count which is the corresponding number of users who did transactions_count in one visit to the bank.
# transactions_count should take all values from 0 to max(transactions_count) done by one or more users.

# Return the result table ordered by transactions_count.

# The query result format is in the following example.

# £¨LeetCode£©
# https://leetcode-cn.com/problems/number-of-transactions-per-visit


# Write your MySQL query statement below

# need one recurvie table by recurseive and union all a
# create another table with transaction frequency
# join with frequency to create the histogram 

with
recursive t1 as (
    select 0 as n
    union all
    select n + 1 from t1 where n +1 <= (select max(number)
from (select user_id,transaction_date,count(*) over(partition by user_id,transaction_date) as number
from Transactions) b)
)
select a.n as transactions_count,
count(b.user_id) as visits_count
from t1 as a 
left join 
(
select ifnull(count(b.transaction_date),0) as trans_ct, 
a.user_id,
 a.visit_date
from visits as a left join 
Transactions as b 
on a.user_id = b.user_id and a.visit_date = b.transaction_date
group by a.user_id, a.visit_date
)
 as b 
on a.n = b.trans_ct
group by a.n order by a.n



1384. Total Sales Amount by Year

# # Write your MySQL query statement below

# Better solution to draw the logic on paper and use if


select t.product_id,product_name,report_year,sum(total_amount)total_amount from 
(
select product_id,
"2020" as report_year,
(datediff(if(period_end<"2021-01-01",period_end,date("2020-12-31")),
if(period_start>"2020-01-01",period_start,date("2020-01-01")))+1)*average_daily_sales total_amount 
from Sales having total_amount>0 
union all
select product_id,"2019" report_year,(datediff(if(period_end<"2020-01-01",period_end,date("2019-12-31")),if(period_start>"2019-01-01",period_start,date("2019-01-01")))+1)*average_daily_sales total_amount from Sales having total_amount>0  
union all
select product_id,"2018" report_year,(datediff(if(period_end<"2019-01-01",period_end,date("2018-12-31")),if(period_start>"2018-01-01",period_start,date("2018-01-01")))+1)*average_daily_sales total_amount from Sales having total_amount>0  
)t left join product p on p.product_id=t.product_id                               
group by product_id,report_year order by product_id,report_year



# My case when solution 
select product_id,
'2018' as report_year,
case when left(period_start,4) = '2018' and left(period_end,4) ='2018'
then average_daily_sales*(datediff(period_end,period_start)+1)  
when left(period_start,4) < '2018' and  left(period_end,4) ='2018'
then average_daily_sales*(datediff(period_end,date('2018-01-01'))+1) 
when left(period_start,4) < '2018' and  left(period_end,4) !='2018'
then average_daily_sales*365 
when left(period_start,4) = '2018' and left(period_end,4) !='2018'
then average_daily_sales*(datediff(date('2018-12-31'),period_start)+1) 
end as total_amount
from Sales
union all
 select product_id,
'2019' as report_year,
case when left(period_start,4) = '2019' and left(period_end,4) ='2019'
then average_daily_sales*(datediff(period_end,period_start)+1)  
when left(period_start,4) < '2019' and  left(period_end,4) ='2019'
then average_daily_sales*(datediff(period_end,date('2019-01-01'))+1) 
when left(period_start,4) < '2019' and  left(period_end,4) !='2019'
then average_daily_sales*365 
when left(period_start,4) = '2019' and left(period_end,4) !='2019'
then average_daily_sales*(datediff(date('2019-12-31'),period_start)+1) 
end as total_amount
from Sales
union all 
select product_id,
'2020' as report_year,
case when left(period_start,4) = '2020' and left(period_end,4) ='2020'
then average_daily_sales*(datediff(period_end,period_start)+1)  
when left(period_start,4) < '2020' and  left(period_end,4) ='2020'
then average_daily_sales*(datediff(period_end,date('2020-01-01'))+1) 
when left(period_start,4) < '2020' and  left(period_end,4) !='2020'
then average_daily_sales*365 
when left(period_start,4) = '2020' and left(period_end,4) !='2020'
then average_daily_sales*(datediff(date('2020-12-31'),period_start)+1) 
end as total_amount
from Sales

1543. Fix Product Name Format

# Write your MySQL query statement below


select product_name,
sale_date,
max(rk) as total from 
(
select 
lower(trim(product_name)) as product_name,
date_format(sale_date,'%Y-%m') as sale_date,
row_number() over (partition by lower(trim(product_name)) , date_format(sale_date,'%Y-%m') order by sale_id) as rk 
from sales )  as a 
group by product_name, sale_date
order by product_name, sale_date

# solution 2
select lower(trim(product_name)) as product_name,
       left(sale_date,7)  as sale_date,
       count(*) as total
from sales
group by LOWER(TRIM(product_name)), left(sale_date,7) 
order by product_name,sale_date



