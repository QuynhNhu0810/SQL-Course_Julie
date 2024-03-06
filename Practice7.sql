-ex1
select year, product_id, curr_year_spend, prev_year_spend
,round((curr_year_spend - prev_year_spend)/prev_year_spend*100.0,2) as yoy_rate
from 
(select
extract (year from transaction_date) as year
,product_id
,spend as curr_year_spend
,lag(spend) over(partition by product_id order by product_id, extract (year from transaction_date)) as prev_year_spend
from user_transactions
) as new_table
--ex2
from
(select card_name, issued_amount
,concat(issue_month,issue_year) as issue_date
,min (concat(issue_month,issue_year)) over (partition by card_name) as launch_date
from monthly_cards_issued
) as launch
where issue_date = launch_date
order by issued_amount desc
--ex3
select user_id, spend, transaction_date
from(
select *
,rank() over(partition by user_id order by transaction_date ) as ranking
from transactions
) as r
where ranking = 3
--ex4
select transaction_date, user_id, count(product_id) as purchase_count
from (
select *
,rank() over(partition by user_id order by transaction_date desc) as ranking
from user_transactions
) as new
where ranking = 1
group by transaction_date, user_id
-ex5
select user_id
,tweet_date
,round(avg(tweet_count) over(partition by user_id order by tweet_date rows between 2 preceding and current row),2) as rolling_avg_3d 
from tweets
--ex6
select count(transaction_id) as payment_count
from (
select transaction_id
,transaction_timestamp - lag(transaction_timestamp) over(partition by merchant_id, credit_card_id, amount order by transaction_timestamp) as diff_time
from transactions
) as prev
where diff_time <= INTERVAL '10 minutes'
--ex 7
select category,product,total_spend
from(
select category
,product 
,sum(spend) as total_spend
,rank() over (partition by category order by sum(spend) DESC) as ranking
from product_spend
where extract (year from transaction_date) = 2022
group by category, product
) as ranked_table
where ranking <= 2
order by category
--ex8
select artist_name, artist_rank
from (
select a.artist_name, 
dense_rank() over (order by count(s.song_id) desc) as artist_rank
from global_song_rank as g
inner join songs as s on s.song_id = g.song_id
inner join artists as a on a.artist_id = s.artist_id
where g.rank <= 10
group by a.artist_name
) as top10
where artist_rank <= 5
