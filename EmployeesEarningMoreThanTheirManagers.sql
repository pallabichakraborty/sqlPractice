/*
SQL Schema
The Employee table holds all employees including their managers. Every employee has an Id, and there is also a column for the manager Id.

+----+-------+--------+-----------+
| Id | Name  | Salary | ManagerId |
+----+-------+--------+-----------+
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | NULL      |
| 4  | Max   | 90000  | NULL      |
+----+-------+--------+-----------+
Given the Employee table, write a SQL query that finds out employees who earn more than their managers. For the above table, Joe is the only employee who earns more than his manager.

+----------+
| Employee |
+----------+
| Joe      |
+----------+
*/

/*

CREATE TABLE employee
(
Id int primary key,
Name varchar(10),
Salary int,
ManagerId int
);


insert into employee
values
(1,'Joe',70000,3),
(2,'Henry',80000,4),
(3,'Sam',60000,null),
(4,'Max',90000,null);

*/


# Write your MySQL query statement below
select employee.Name as `Employee`
 from
 (select id,Name,salary,ManagerId
 from employee) employee
inner join
 (select id,Salary
 from employee) manager
 on (employee.ManagerId=manager.id)
 where employee.Salary>manager.Salary
 
