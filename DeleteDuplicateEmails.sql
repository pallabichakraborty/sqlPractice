/*
SQL Schema
Write a SQL query to delete all duplicate email entries in a table named Person, keeping only unique emails based on its smallest Id.

+----+------------------+
| Id | Email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
| 3  | john@example.com |
+----+------------------+
Id is the primary key column for this table.
For example, after running your query, the above Person table should have the following rows:

+----+------------------+
| Id | Email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
+----+------------------+
Note:

Your output is the whole Person table after executing your sql. Use delete statement.
*/

/*
Test Data
drop table if exists Person;

create table Person
(
Id int primary key,
Email varchar(50)
);


insert into Person values (1,'john@example.com'),(2,'bob@example.com'),(3,'john@example.com');
*/

# Write your MySQL query statement below
delete from Person
where Id in 
(select Id
from
(select Id, Email, dense_rank() over (partition by Email order by Id) emailcount
from Person) a
where emailcount>1)
