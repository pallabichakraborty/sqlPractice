/*
SQL Schema
The Employee table holds all employees. Every employee has an Id, a salary, and there is also a column for the department Id.

+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Jim   | 90000  | 1            |
| 3  | Henry | 80000  | 2            |
| 4  | Sam   | 60000  | 2            |
| 5  | Max   | 90000  | 1            |
+----+-------+--------+--------------+
The Department table holds all departments of the company.

+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+
Write a SQL query to find employees who have the highest salary in each of the departments. For the above tables, your SQL query should return the following rows (order of rows does not matter).

+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Jim      | 90000  |
| Sales      | Henry    | 80000  |
+------------+----------+--------+
Explanation:

Max and Jim both have the highest salary in the IT department and Henry has the highest salary in the Sales department.
*/


/*
Test Data
drop table if exists Department;

create table Department
(
Id int primary key,
Name varchar(50)
);

drop table if exists employee;

create table Employee
(
Id int primary key,
Name varchar(50),
Salary int,
DepartmentId int,
foreign key(DepartmentId) references Department(Id)
);


insert into Department values(1,'IT'),(2,'Sales');
insert into employee 
values(1,'Joe',70000,1),
		   (2,'Jim',90000,1),
           (3,'Henry',80000,2),
           (4,'Sam',60000,2),
           (5,'Max',90000,1);
*/

	select DepartmentName `Department`,EmployeeName `Employee`,Salary
    from
    (select Department.Name `DepartmentName`,Employee.Name `EmployeeName`,Salary, dense_rank() over (partition by Department.id order by Salary desc) SalaryRanking
    from Department Department
    inner join
    Employee Employee
    on (department.id=employee.departmentid)) EmployeeData
    where SalaryRanking=1
