# Write your MySQL query statement below

# select 
# cust.customer_id,
# cust.customer_name
# from orders as a 
# inner join 
# orders as b 
# on a.customer_id = b.customer_id and a.product_name = 'A' and b.product_name = 'B'
# left join 
# orders as c 
# on a.customer_id= c.customer_id and c.product_name = 'C' 
# inner join 
# customers as cust 
# on a.customer_id = cust.customer_id
# where c.customer_id is null 
# group by cust.customer_id,
# cust.customer_name

select o.customer_id, customer_name
from orders o, customers c
where o.customer_id = c.customer_id
group by o.customer_id
having  sum(product_name='A') > 0 and sum(product_name='B') > 0 and sum(product_name='C') = 0