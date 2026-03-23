select * from behavior
limit 10

select 
hour,
sum(case when behavior_type = 'view' then 1 else 0 end) as 点击数,
sum(case when behavior_type = 'cart' then 1 else 0 end) as 加购数,
sum(case when behavior_type = 'favrate' then 1 else 0 end) as 收藏数,
sum(case when behavior_type = 'buy' then 1 else 0 end) as 购买数
from behavior 
group by hour 
order by hour

-- 各时段转化率
with table_1 as 
(
select 
hour,
sum(case when behavior_type = 'view' then 1 else 0 end) as 点击数,
sum(case when behavior_type = 'cart' then 1 else 0 end) as 加购数,
sum(case when behavior_type = 'favrate' then 1 else 0 end) as 收藏数,
sum(case when behavior_type = 'buy' then 1 else 0 end) as 购买数
from behavior 
group by hour 
order by hour
)
select 
hour,
购买数/点击数 as 转化率
from table_1
