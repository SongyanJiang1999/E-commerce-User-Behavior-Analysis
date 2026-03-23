select * from behavior
limit 10

with firstlogin as
(
select t1.user_id,
min(date) as new_date
from behavior as t1
where date between '2014/11/18' and '2014/12/12'
group by t1.user_id 
),
t4 as 
(
select
t2.user_id,
new_date,
date,
timestampdiff(day,t2.new_date,t3.date) as 间隔天数
from firstlogin as t2
left join 
(select user_id, date from behavior group by user_id, date) as t3
on t2.user_id = t3.user_id
order by t2.user_id, t2.new_date, t3.date
)
select 
t4.new_date,
count(if(间隔天数=0,user_id,null)) as 0天后留存用户数,
count(if(间隔天数=1,user_id,null)) as 1天后留存用户数,
count(if(间隔天数=3,user_id,null)) as 3天后留存用户数,
count(if(间隔天数=7,user_id,null)) as 7天后留存用户数,
count(if(间隔天数=1,user_id,null))/count(if(间隔天数=0,user_id,null)) as 1天后留存率,
count(if(间隔天数=3,user_id,null))/count(if(间隔天数=0,user_id,null)) as 3天后留存率,
count(if(间隔天数=7,user_id,null))/count(if(间隔天数=0,user_id,null)) as 7天后留存率
from t4
group by t4.new_date 
order by t4.new_date 








