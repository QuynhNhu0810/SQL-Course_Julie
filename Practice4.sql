select 
sum(case when device_type in ('phone','tablet') then 1 else 0 end) as mobile_views,
sum(case when device_type ='laptop' then 1 else 0 end) as laptop_views
from viewership
--ex2
select x,y,z,
case when x+y > z and x+z > x and z+x > y then 'Yes' else 'No' end as triangle
from Triangle
--ex3
select
 round(100.0 * 
  sum(case when call_category IS NULL OR call_category = 'n/a'
  then 1 else 0 end)
  /count(case_id), 1) as call_percentage
from callers
--ex4
select name
from Customer
where referee_id != 2 or referee_id IS NULL
--ex5
select survived
,sum(case when pclass = 1 then 1 else 0 end) as first_class
,sum(case when pclass = 2 then 1 else 0 end) as second_class
,sum(case when pclass = 3 then 1 else 0 end) as third_class
from titanic
group by survived
