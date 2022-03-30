# Table: Movies

# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | movie_id      | int     |
# | title         | varchar |
# +---------------+---------+
# movie_id is the primary key for this table.
# title is the name of the movie.
# ?

# Table: Users

# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | user_id       | int     |
# | name          | varchar |
# +---------------+---------+
# user_id is the primary key for this table.
# ?

# Table: MovieRating

# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | movie_id      | int     |
# | user_id       | int     |
# | rating        | int     |
# | created_at    | date    |
# +---------------+---------+
# (movie_id, user_id) is the primary key for this table.
# This table contains the rating of a movie by a user in their review.
# created_at is the user's review date. 
# ?

# Write an SQL query to:

# Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
# Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.
# The query result format is in the following example.

# ?

# £¨LeetCode£©
# https://leetcode-cn.com/problems/movie-rating


# Write your MySQL query statement below


(select u.name as results
from MovieRating as m
left join users as u
on m.user_id=u.user_id
group by m.user_id
order by count(*) desc,u.name
limit 1)
union all
(select 
b.title as results
from movierating  as a 
left join 
movies as b 
on a.movie_id = b.movie_id
where a.created_at like '2020-02%'
group by a.movie_id
order by avg(a.rating) desc, title 
limit 1)