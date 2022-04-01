# Write your MySQL query statement below
with price as 
(select 
stock_name,
operation,
operation_day,
price,
row_number() over (partition by stock_name, operation  order by operation_day) as day_order
from stocks )
select 
a.stock_name,
sum(a.price-b.price) as capital_gain_loss
from price as a 
inner join price as b 
on a.stock_name = b.stock_name 
and a.day_order=b.day_order 
where a.operation = 'Sell' and b.operation = 'Buy'
group by a.stock_name


#2nd solution, when there is buy and sell matching for sure
select stock_name,
sum(case when operation='buy' then -price
else  price  end ) as 'capital_gain_loss'
from Stocks
group by stock_name
