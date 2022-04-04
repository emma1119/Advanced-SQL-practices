# Write your MySQL query statement below
# find student who doesn't have the highest or the lowest score
#need a table to have the min and max for the exam and link by exam_id , not in

with exm 
as 
(select exam_id ,
min(score) as min_score,
max(score) as max_score
from exam
group by exam_id
),
std as (
select 
a.student_id 
from 
exam a inner join exm b 
on a.exam_id = b.exam_id and (a.score = b.min_score or a.score=b.max_score))
select 
distinct
b.student_id,
b.student_name 
from
exam as  a 
inner join
student as b 
on a.student_id = b.student_id
where a.student_id not in (select student_id from std)
order by a.student_id

# create a bin chart!! common mistake, use group by will not able to produce bin with 0 counts
# assign bin value and count(*) and union all 

# Write your MySQL query statement below

#correct answer to have all bins is to create the bin and count to union 

select '[0-5>' bin, count(*) as total from Sessions where floor(duration/(60*5))=0
union
select '[5-10>' bin, count(*) as total from Sessions where floor(duration/(60*5))=1 
union
select '[10-15>' bin, count(*) as total from Sessions where floor(duration/(60*5))=2
union
select '15 or more' bin, count(*) as total from Sessions where floor(duration/(60*5))>=3
order by bin

# #will miss the bin where there is no count
# select 
# bin
# ,count(*) as total
# from 
# (select session_id,
# case when duration/60 <5 then '[0-5>'
# when duration/60 <10 then '[5-10>'
# when duration/60 <15 then '[10-15>'
# else '15 or more'
# end as bin 
# from sessions ) a 
# group by bin 

# regexp in SQL to filter for valid email address 
# [a-zA-Z]: letters A to z
# []+[] to indicate the different position 
#0-9
# \\ before the sign

# Write your MySQL query statement below
select * 
from users 
where mail regexp '^[a-zA-Z]+[a-zA-Z0-9_\\./\\-]*@leetcode\\.com$'

#wildcard
# select first position , second position '% DIAB1%'
# Write your MySQL query statement below
select 
* 
from patients 
where conditions like 'DIAB1%' or conditions like '% DIAB1%'
