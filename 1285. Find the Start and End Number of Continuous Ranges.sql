# Table: Logs

# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | log_id        | int     |
# +---------------+---------+
# log_id is the primary key for this table.
# Each row of this table contains the ID in a log Table.
# ?

# Write an SQL query to find the start and end number of continuous ranges in the table Logs.

# Return the result table ordered by start_id.

# The query result format is in the following example.

# £¨LeetCode£©
# https://leetcode-cn.com/problems/find-the-start-and-end-number-of-continuous-ranges



# Write your MySQL query statement below
with new_table as 
(select 
log_id,
log_id-row_number() over (Order BY log_id) as delta
from logs )
select 
min(log_id) as start_id,
max(log_id) as end_id
from new_table a 
group by delta
