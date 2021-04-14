/*
SQL Schema
Write a SQL query to find all duplicate emails in a table named Person.

+----+---------+
| Id | Email   |
+----+---------+
| 1  | a@b.com |
| 2  | c@d.com |
| 3  | a@b.com |
+----+---------+
For example, your query should return the following for the above table:

+---------+
| Email   |
+---------+
| a@b.com |
+---------+
Note: All emails are in lowercase.
*/
/*
CREATE TABLE Person
(
id int primary key,
Email varchar(50)
);


INSERT INTO Person VALUES (1,'a@b.com'),(2,'c@d.com'),(3,'a@b.com');

*/

select distinct email `Email`
from
(select email, count(email) over (partition by email) emailcount
from Person) Duplicates
where emailcount>1
