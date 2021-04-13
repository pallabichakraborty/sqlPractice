/*
Write a SQL query to get the second highest salary from the Employee table.

+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
For example, given the above Employee table, the query should return 200 as the second highest salary. If there is no second highest salary, then the query should return null.

+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
*/

# Write your MySQL query statement below

select IFNULL(b.Salary,a.placeholder) as "SecondHighestSalary"
from
(select null as "placeholder") a
left outer join
(select Salary
from
(select id, Salary, DENSE_RANK() over (order by Salary desc)  rownum
from Employee) a
where a.rownum=2
limit 1) b
on (1=1)
