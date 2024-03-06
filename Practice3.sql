--ex1
select Name
from STUDENTS
where Marks > 75
order by RIGHT(Name,3), ID
--ex2
select user_id, concat(upper(left(name,1)),lower(right(name,length(name)-1))) as name
from Users
where name IS NOT NULL
order by user_id
--ex3
SELECT manufacturer, concat('$',round(sum(total_sales)/1000000), ' million') as sale 
FROM pharmacy_sales
group by manufacturer
order by sum(total_sales) desc
--ex4
SELECT extract(month from submit_date) as mth
,product_id as product
,round(avg(stars),2) as avg_stars
from reviews
group by extract(month from submit_date), product_id
order by extract(month from submit_date), product_id
--ex5
select sender_id
,count(message_id)
from messages
where extract(month from sent_date) = '08' and extract(year from sent_date) = '2022'
group by sender_id
order by count(message_id) DESC
limit 2
--ex6
select tweet_id
from Tweets
where length(content) > 15
--ex7
select activity_date as day
,count(distinct user_id) as active_users
from Activity
where activity_type in ('open_session', 'end_session', 'scroll_down', 'send_message') and activity_date between date_sub('2019-07-27', interval 29 day) and '2019-07-27'
group by activity_date
--ex8
select count(id) as total_employee
from employees
where joining_date between '2022-01-01' and '2022-07-31'
--ex9
select position("a" in "Amitah") as position_of_a
from worker
--ex10
select title, substring(title,length(winery) + 2, 4) as year
from winemag_p2
where title LIKE '%2%'
