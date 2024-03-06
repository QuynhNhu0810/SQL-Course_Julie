--ex1
select DISTINCT CITY
from STATION
where mod(ID,2) = 0
--ex2
select COUNT(CITY) - COUNT(DISTINCT CITY) as difference
from STATION
--ex3
select CEIL(avg(Salary) - avg(REPLACE(Salary,'0',''))) as error_cal
from EMPLOYEES
--ex4
select ROUND(sum(item_count::DECIMAL*order_occurrences)/sum(order_occurrences),1) as mean
from items_per_order
--ex5
SELECT candidate_id
FROM candidates
group by candidate_id
having count(case when skill in ('Python','Tableau','PostgreSQL') then 1 else null end) = 3
order by 1
--ex6
SELECT user_id,
date(max(post_date)) - date(min(post_date)) as days_between 
FROM posts
where EXTRACT(YEAR FROM post_date) = 2021
group by(user_id)
having count(post_id) >= 2
--ex7
SELECT card_name,
max(issued_amount) - min(issued_amount) as difference
FROM monthly_cards_issued
group by (card_name)
order by 2 desc
--ex8
SELECT manufacturer
,count(drug) as drug_count
,abs(sum(total_sales - cogs)) as total_loss
FROM pharmacy_sales
where total_sales - cogs < 0
group by manufacturer
order by 3 desc
--ex9
select *
from Cinema
where mod(id,2) != 0 and description != 'boring'
order by 4 desc
--ex10
select teacher_id
,count(distinct subject_id) as cnt
from Teacher
group by teacher_id
--ex11
select user_id
, count(follower_id) as followers_count
from Followers
group by user_id
order by user_id
-ex12
select class
from Courses
group by class
having count(student) >= 5
