# Table: UserActivity

# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | username      | varchar |
# | activity      | varchar |
# | startDate     | Date    |
# | endDate       | Date    |
# +---------------+---------+
# There is no primary key for this table. It may contain duplicates.
# This table contains information about the activity performed by each user in a period of time.
# A person with username performed an activity from startDate to endDate.
# ?

# Write an SQL query to show the second most recent activity of each user.

# If the user only has one activity, return that one. A user cannot perform more than one activity at the same time.

# Return the result table in any order.

# LeetCode£©
# https://leetcode-cn.com/problems/get-the-second-most-recent-activity



# Write your MySQL query statement below
with rk as
(select 
username,
activity,
startDate,
endDate,
row_number() over (partition by username order by startDate desc) as rk
from 
UserActivity)
(select 
username,
activity,
startDate,
endDate
from rk 
where rk =2)
union all 
(select 
username,
activity,
startdate,
enddate
from rk 
where rk =1 
and username not in (select username from rk group by username having max(rk)>1))