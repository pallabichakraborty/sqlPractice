/*
SQL Schema
Table: Weather

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the primary key for this table.
This table contains information about the temperature in a certain day.
 

Write an SQL query to find all dates' id with higher temperature compared to its previous dates (yesterday).

Return the result table in any order.

The query result format is in the following example:

Weather
+----+------------+-------------+
| id | recordDate | Temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
+----+------------+-------------+

Result table:
+----+
| id |
+----+
| 2  |
| 4  |
+----+
In 2015-01-02, temperature was higher than the previous day (10 -> 25).
In 2015-01-04, temperature was higher than the previous day (20 -> 30).
*/


/*
Test Data
drop table if exists Weather;

create table Weather
(
id int primary key,
recordDate Date,
temperature int
);

insert into Weather 
values(1,str_to_date('2015-01-01','%Y-%m-%d'),10),
(2,str_to_date('2015-01-02','%Y-%m-%d'),25),
(3,str_to_date('2015-01-03','%Y-%m-%d'),20),
(4,str_to_date('2015-01-04','%Y-%m-%d'),30);

*/
