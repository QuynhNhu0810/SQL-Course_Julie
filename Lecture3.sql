--Ex 1
select name
from CITY
where COUNTRYCODE = 'USA' and POPULATION > 120000;
--Ex2
select *
from CITY
where COUNTRYCODE = 'JPN'
--Ex3
select CITY, STATE
from STATION
--Ex4
--Cách 1
select DISTINCT CITY 
from STATION
where CITY like 'a%' or CITY like 'e%' or CITY like 'i%' or CITY like 'o%' or CITY like 'u%'
--Cách 2
select DISTINCT CITY 
from STATION
where LEFT(CITY,1) in ('A','E','I','O','U')
--Ex5
select DISTINCT CITY 
from STATION
where CITY like '%a' or CITY like '%e' or CITY like '%i' or CITY like '%o' or CITY like '%u'
--Ex6
select DISTINCT CITY 
from STATION
where LEFT(CITY,1) not in ('A','E','I','O','U')
--Ex7
select name
from Employee
order by name
--Ex8
select name
from Employee
where salary > 2000 and months < 10
order by employee_id 
--Ex9
select product_id
from Products
where low_fats = 'Y' and recyclable = 'Y'
--Ex10
select name
from Customer
where referee_id != 2 or referee_id IS NULL
--Ex11
select name, population, area
from World
where area >= 3000000 or population >= 25000000 
--Ex12
select distinct author_id as id
from Views
where author_id = viewer_id
order by author_id 
--Ex13
SELECT part, assembly_step 
from parts_assembly
where finish_date is null
--Ex14
select * from lyft_drivers
where yearly_salary <=30000 or yearly_salary>=70000
--Ex15
select advertising_channel from uber_advertising
where money_spent > 100000 and year = 2019
