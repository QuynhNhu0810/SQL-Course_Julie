--ex1
select c1.CONTINENT
,floor(avg(c2.POPULATION)) as avg_pop
from COUNTRY as c1
inner join CITY as c2 on c1.CODE = c2.COUNTRYCODE
group by c1.CONTINENT
--ex2
SELECT ROUND(SUM(CASE WHEN t1.signup_action = 'Confirmed' THEN 1 ELSE 0 END)::DECIMAL/ COUNT(DISTINCT e1.email_id),2) as confirm_rate
FROM emails as e1
LEFT JOIN texts as t1 on e1.email_id = t1.email_id
--ex3
SELECT a2.age_bucket 
,round(sum(case when a1.activity_type = 'send' then time_spent else 0 end)/ sum(case when a1.activity_type in ('open','send') then time_spent else 0 end)*100.0,2) as send_perc
,round(sum(case when a1.activity_type = 'open' then time_spent else 0 end)/ sum(case when a1.activity_type in ('open','send') then time_spent else 0 end)*100.0,2)as open_perc
FROM activities as a1 INNER JOIN age_breakdown as a2 on a1.user_id = a2.user_id
group by a2.age_bucket
--ex4
SELECT C.customer_id
FROM customer_contracts as C inner join products as P on C.product_id = P.product_id
GROUP BY C.customer_id
HAVING COUNT(DISTINCT P.product_category) = 3
--ex5
select e1.employee_id, e1.name
,count(e2.employee_id) as reports_count
,round(avg(e2.age)) as average_age
from Employees as e1 inner join Employees as e2 on e1.employee_id = e2.reports_to
group by e1.employee_id
order by e1.employee_id
--ex6
select P.product_name, sum(O.unit) as unit
from Products as P inner join Orders as O on P.product_id = O.product_id
where year(O.order_date) = 2020 and month(O.order_date) = 02 
group by P.product_name
having sum(O.unit) >= 100 
--ex7
SELECT p1.page_id
FROM pages as p1 left join page_likes as p2 on p1.page_id = p2.page_id
group by p1.page_id
having count(p2.user_id) = 0
