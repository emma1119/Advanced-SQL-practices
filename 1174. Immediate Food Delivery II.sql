# +-----------------------------+---------+
# | Column Name                 | Type    |
# +-----------------------------+---------+
# | delivery_id                 | int     |
# | customer_id                 | int     |
# | order_date                  | date    |
# | customer_pref_delivery_date | date    |
# +-----------------------------+---------+
# delivery_id is the primary key of this table.
# The table holds information about food delivery to customers that make orders at some date and specify a preferred delivery date (on the same order date or after it).


# If the customer's preferred delivery date is the same as the order date, then the order is called immediate; otherwise, it is called scheduled.

# The first order of a customer is the order with the earliest order date that the customer made. It is guaranteed that a customer has precisely one first order.

# Write an SQL query to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.

# The query result format is in the following example.

# source£ºhttps://leetcode-cn.com/problems/immediate-food-delivery-ii

# Write your MySQL query statement below
with first_order as 
(select 
customer_id,
delivery_id,
case when order_date=customer_pref_delivery_date then 1 else 0 end as immediate_order,
row_number() over (partition by customer_id order by order_date) as rk
from delivery)
select
round(sum(immediate_order)*100/count(customer_id),2) as immediate_percentage
from first_order
where rk =1
