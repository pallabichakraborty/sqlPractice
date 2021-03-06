/*
SQL Schema
Table: Days

+-------------+------+
| Column Name | Type |
+-------------+------+
| day         | date |
+-------------+------+
day is the primary key for this table.
 

Write an SQL query to convert each date in Days into a string formatted as "day_name, month_name day, year".

Return the result table in any order.

The query result format is in the following example:

 

Days table:
+------------+
| day        |
+------------+
| 2022-04-12 |
| 2021-08-09 |
| 2020-06-26 |
+------------+

Result table:
+-------------------------+
| day                     |
+-------------------------+
| Tuesday, April 12, 2022 |
| Monday, August 9, 2021  |
| Friday, June 26, 2020   |
+-------------------------+
Please note that the output is case-sensitive.
*/


/*

Test Data

create table Days
(
day date primary key
);

insert into Days(day)
values(str_to_date('2022-04-12','%Y-%m-%d')),
(str_to_date('2021-08-09','%Y-%m-%d')),
(str_to_date('2020-06-26','%Y-%m-%d'));
*


# Write your MySQL query statement below
# %e is to remove 0 in the beginning, for month it is %c
select date_format(day,'%W, %M %e, %Y') day
from Days
