/*
SQL Schema
Table: Employee

+---------------+---------+
| Column Name   |  Type   |
+---------------+---------+
| employee_id   | int     |
| department_id | int     |
| primary_flag  | varchar |
+---------------+---------+
(employee_id, department_id) is the primary key for this table.
employee_id is the id of the employee.
department_id is the id of the department to which the employee belongs.
primary_flag is an ENUM of type ('Y', 'N'). If the flag is 'Y', the department is the primary department for the employee. If the flag is 'N', the department is not the primary.
 

Employees can belong to multiple departments. When the employee joins other departments, they need to decide which department is their primary department. Note that when an employee belongs to only one department, their primary column is 'N'.

Write an SQL query to report all the employees with their primary department. For employees who belong to one department, report their only department.

Return the result table in any order.

The query result format is in the following example.

 

Employee table:
+-------------+---------------+--------------+
| employee_id | department_id | primary_flag |
+-------------+---------------+--------------+
| 1           | 1             | N            |
| 2           | 1             | Y            |
| 2           | 2             | N            |
| 3           | 3             | N            |
| 4           | 2             | N            |
| 4           | 3             | Y            |
| 4           | 4             | N            |
+-------------+---------------+--------------+

Result table:
+-------------+---------------+
| employee_id | department_id |
+-------------+---------------+
| 1           | 1             |
| 2           | 1             |
| 3           | 3             |
| 4           | 3             |
+-------------+---------------+
- The Primary department for employee 1 is 1.
- The Primary department for employee 2 is 1.
- The Primary department for employee 3 is 3.
- The Primary department for employee 4 is 3.
*/
/*
Test Data
drop table employee;

create table employee
(
employee_id int,
department_id int,
primary_flag enum('Y','N'),
primary key(employee_id, department_id) 
);


insert into employee(employee_id,department_id,primary_flag)
values(1,1,'N'),
(2,1,'Y'),
(2,2,'N'),
(3,3,'N'),
(4,2,'N'),
(4,3,'Y'),
(4,4,'Y')
*/
# Write your MySQL query statement below
with emp_multiple_dept AS
(
 select employee_id
 from Employee
 where primary_flag='Y'
)
select employee_id, department_id
from Employee
where employee_id in (select employee_id from emp_multiple_dept)
and primary_flag='Y'
UNION
select employee_id, department_id
from Employee
where employee_id not in (select employee_id from emp_multiple_dept)
