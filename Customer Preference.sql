select * from behavior
limit 10

with goods_record as
(
select 
item_id,
item_category,
sum(case when behavior_type = 'view' then 1 else 0 end) as 点击数,
sum(case when behavior_type = 'favrate' then 1 else 0 end) as 收藏数,
sum(case when behavior_type = 'cart' then 1 else 0 end) as 加购数,
sum(case when behavior_type = 'buy' then 1 else 0 end) as 购买数
from behavior
group by item_category, item_id
order by item_category, item_id
)
(select 'Top10 点击商品' as 项目, item_id as 维度,
点击数 as 指标
from goods_record 
order by 点击数 desc
limit 10)
union all
(select 
'Top10 点击种类' as 项目,
item_category as 维度,
sum(点击数) as 指标
from goods_record 
group by item_category
order by sum(点击数) desc
limit 10)