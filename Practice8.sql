--ex 1
with cte as (
select *
from(
select *
,rank () over (partition by customer_id order by order_date) as ranking 
from Delivery) a
where ranking = 1)

select round(sum(case when customer_pref_delivery_date = order_date then 1 else 0 end)/count(customer_id) * 100.0 ,2) as immediate_percentage
from cte
--ex2
select round(count(*) / (select count(distinct player_id) from activity), 2) as fraction 
from
(select
player_id,
event_date,
lead(event_date) over(partition by player_id order by event_date) as next_login,
row_number() over(partition by player_id order by event_date) as ranking
from activity) t
where ranking=1
and next_login - event_date =1
--ex3
elect id, 
coalesce(case when id%2=0 then lag(student) over() else lead(student) over() end, student) as student
from seat
--ex4
select a.visited_on as visited_on,
sum(b.day_sum) as amount,
round(sum(b.day_sum)/7,2) as average_amount
from (
select visited_on, sum(amount) as day_sum from Customer group by visited_on) as a,
(select visited_on, sum(amount) as day_sum from Customer group by visited_on) as b
where datediff(a.visited_on , b.visited_on) between 0 and 6
group by a.visited_on
having a.visited_on >= (select min(visited_on) from Customer) + 6
order by a.visited_on
--ex5
select round(sum(tiv_2016),2) as tiv_2016
from 
(select *
,count(*) over (partition by tiv_2015) as tiv
,count(*) over (partition by lat,lon) as city
from Insurance
) as compare
where tiv >= 2 and city = 1
--ex6
select Department
,Employee
,Salary
from(
select d.name as Department , e.name as Employee, e.salary as Salary
,dense_rank() over(partition by d.id order by e.salary desc) as ranking
from Employee as e
inner join Department as d on d.id = e.departmentId
) as new
where ranking <= 3
--ex7
select person_name
from 
(select *
,sum(weight) over (order by turn) as total_weight
from Queue
) as r
where total_weight <= 1000
order by total_weight desc 
limit 1 
--ex8
elect P.product_id
,coalesce (price,10) as price
from(
select distinct product_id
from Products) as p
left join (
select distinct product_id
,first_value (new_price) over (partition by product_id order by change_date desc) as price
from Products
where change_date <= '2019-08-16'
) as r using (product_id)
