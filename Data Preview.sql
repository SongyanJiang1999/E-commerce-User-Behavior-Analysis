select * from behavior
limit 10

select count(*) from behavior

select
count(user_id),
count(item_id),
count(behavior_type),
count(item_category),
count(date),
count(hour)
from behavior

select * from behavior
where
user_id < 0 or item_id < 0 or item_category <0 or date < 0

select behavior_type, count(*)
from behavior
group by behavior_type


select date, count(user_id)
from behavior 
group by date
order by date

