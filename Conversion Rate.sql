select * from behavior
limit 10

-- 复购率

with ub 
as 
(
select user_id,
sum(case when behavior_type = 'view' then 1 else 0 end) as 点击数,
sum(case when behavior_type = 'cart' then 1 else 0 end) as 加购数,
sum(case when behavior_type = 'favrate' then 1 else 0 end) as 收藏数,
sum(case when behavior_type = 'buy' then 1 else 0 end) as 购买数
from behavior 
group by user_id 
)
select 
count(购买数) as 购买用户数,
sum(case when 购买数>1 then 1 else 0 end) as 复购用户数,
sum(case when 购买数>1 then 1 else 0 end)/count(购买数) as 复购率
from ub 
where 购买数>0

-- 购买次数转化分析
with ub 
as 
(
select user_id,
sum(case when behavior_type = 'view' then 1 else 0 end) as 点击数,
sum(case when behavior_type = 'cart' then 1 else 0 end) as 加购数,
sum(case when behavior_type = 'favrate' then 1 else 0 end) as 收藏数,
sum(case when behavior_type = 'buy' then 1 else 0 end) as 购买数
from behavior 
group by user_id 
)
select 
sum(case when 购买数>=1 then 1 else 0 end) as '购买至少1次',
sum(case when 购买数>=2 then 1 else 0 end) as '购买至少2次',
sum(case when 购买数>=3 then 1 else 0 end) as '购买至少3次',
sum(case when 购买数>=4 then 1 else 0 end) as '购买至少4次',
sum(case when 购买数>=5 then 1 else 0 end) as '购买至少5次'
from ub 