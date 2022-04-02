# Write your MySQL query statement below





# Table: Players

# +----------------+---------+
# | Column Name    | Type    |
# +----------------+---------+
# | player_id      | int     |
# | player_name    | varchar |
# +----------------+---------+
# player_id is the primary key for this table.
# Each row in this table contains the name and the ID of a tennis player.
# ?

# Table: Championships

# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | year          | int     |
# | Wimbledon     | int     |
# | Fr_open       | int     |
# | US_open       | int     |
# | Au_open       | int     |
# +---------------+---------+
# year is the primary key for this table.
# Each row of this table contains the IDs of the players who won one each tennis tournament of the grand slam.
# ?

# Write an SQL query to report the number of grand slam tournaments won by each player. Do not include the players who did not win any tournament.

# Return the result table in any order.

# The query result format is in the following example.

# LeetCode£©
# https://leetcode-cn.com/problems/grand-slam-titles

#better solution of pivot from wide to tall table 


select player_id,
player_name, 
count(*) as grand_slams_count 
from
players join 
(select wimbledon from championships
union all
select fr_open from championships
union all 
select us_open from championships
union all
select au_open from championships)t
on player_id=wimbledon
group by player_id,player_name


# #
# select 
# d.player_id,
# d.player_name,
# coalesce(a.grand_slams_count, b.grand_slams_count, c.grand_slams_count) as grand_slams_count
# from 
# players d
# left join
# (
# select 
# 1 as player_id,
# sum(if(Wimbledon=1,1,0) +if(Fr_open=1,1,0)+if(US_open=1,1,0)+ if(Au_open=1,1,0)) as grand_slams_count
# FROM Championships 
# ) a 
# on a.player_id = d.player_id
# left join 
# (select 
# 2 as player_id,
# sum(if(Wimbledon=2,1,0) +if(Fr_open=2,1,0)+if(US_open=2,1,0)+ if(Au_open=2,1,0)) as grand_slams_count
# FROM Championships 
# ) b 
# on b.player_id = d.player_id
# left join 
# (select 
# 3 as player_id,
# sum(if(Wimbledon=3,1,0) +if(Fr_open=3,1,0)+if(US_open=3,1,0)+ if(Au_open=3,1,0)) as grand_slams_count
# FROM Championships 
# ) c
# on c.player_id = d.player_id
# where 
# coalesce(a.grand_slams_count, b.grand_slams_count, c.grand_slams_count) >0