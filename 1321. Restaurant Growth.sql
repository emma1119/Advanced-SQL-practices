
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | customer_id   | int     |
# | name          | varchar |
# | visited_on    | date    |
# | amount        | int     |
# +---------------+---------+
# (customer_id, visited_on) is the primary key for this table.
# This table contains data about customer transactions in a restaurant.
# visited_on is the date on which the customer with ID (customer_id) has visited the restaurant.
# amount is the total paid by a customer.

# £¨LeetCode£©
# https://leetcode-cn.com/problems/restaurant-growth


# Write your MySQL query statement below
with amt as
(select visited_on,
sum(amount) as amount
from customer
group by  visited_on)
select 
a.visited_on,
round(sum(b.amount), 2) as amount,
round(avg(b.amount), 2) as average_amount
from amt as a 
left join 
amt
as b 
on datediff(a.visited_on, b.visited_on) <=6 and datediff(a.visited_on, b.visited_on)>=0
group by a.visited_on
having count(distinct b.visited_on)=7
order by a.visited_on