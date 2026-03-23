select * from behavior
limit 10

with rf as 
( 
select 
user_id,
timestampdiff(day,max(date),'2014/12/18') as R,
count(user_id) as F
from behavior 
where behavior_type = 'buy'
group by user_id 
order by user_id

),
avgs as  
(  
select 
avg(R) as avg_r,
avg(F) as avg_f
from rf
)
select 
a.user_id,
a.R,
a.F,
b.avg_r,
b.avg_f,
case 
	when a.R < b.avg_r and a.F > b.avg_f then '价值用户'
	when a.R < b.avg_r and a.F <= b.avg_f then '发展用户'
	when a.R > b.avg_r and a.F > b.avg_f then '保留用户'
	else '挽留用户'
end
from rf as a, avgs as b