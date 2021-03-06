/*
SQL Schema
Table: Trips

+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| Id          | int      |
| Client_Id   | int      |
| Driver_Id   | int      |
| City_Id     | int      |
| Status      | enum     |
| Request_at  | date     |     
+-------------+----------+
Id is the primary key for this table.
The table holds all taxi trips. Each trip has a unique Id, while Client_Id and Driver_Id are foreign keys to the Users_Id at the Users table.
Status is an ENUM type of (‘completed’, ‘cancelled_by_driver’, ‘cancelled_by_client’).
 

Table: Users

+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| Users_Id    | int      |
| Banned      | enum     |
| Role        | enum     |
+-------------+----------+
Users_Id is the primary key for this table.
The table holds all users. Each user has a unique Users_Id, and Role is an ENUM type of (‘client’, ‘driver’, ‘partner’).
Status is an ENUM type of (‘Yes’, ‘No’).
 

Write a SQL query to find the cancellation rate of requests with unbanned users (both client and driver must not be banned) each day between "2013-10-01" and "2013-10-03".

The cancellation rate is computed by dividing the number of canceled (by client or driver) requests with unbanned users by the total number of requests with unbanned users on that day.

Return the result table in any order. Round Cancellation Rate to two decimal points.

The query result format is in the following example:

 

Trips table:
+----+-----------+-----------+---------+---------------------+------------+
| Id | Client_Id | Driver_Id | City_Id | Status              | Request_at |
+----+-----------+-----------+---------+---------------------+------------+
| 1  | 1         | 10        | 1       | completed           | 2013-10-01 |
| 2  | 2         | 11        | 1       | cancelled_by_driver | 2013-10-01 |
| 3  | 3         | 12        | 6       | completed           | 2013-10-01 |
| 4  | 4         | 13        | 6       | cancelled_by_client | 2013-10-01 |
| 5  | 1         | 10        | 1       | completed           | 2013-10-02 |
| 6  | 2         | 11        | 6       | completed           | 2013-10-02 |
| 7  | 3         | 12        | 6       | completed           | 2013-10-02 |
| 8  | 2         | 12        | 12      | completed           | 2013-10-03 |
| 9  | 3         | 10        | 12      | completed           | 2013-10-03 |
| 10 | 4         | 13        | 12      | cancelled_by_driver | 2013-10-03 |
+----+-----------+-----------+---------+---------------------+------------+

Users table:
+----------+--------+--------+
| Users_Id | Banned | Role   |
+----------+--------+--------+
| 1        | No     | client |
| 2        | Yes    | client |
| 3        | No     | client |
| 4        | No     | client |
| 10       | No     | driver |
| 11       | No     | driver |
| 12       | No     | driver |
| 13       | No     | driver |
+----------+--------+--------+

Result table:
+------------+-------------------+
| Day        | Cancellation Rate |
+------------+-------------------+
| 2013-10-01 | 0.33              |
| 2013-10-02 | 0.00              |
| 2013-10-03 | 0.50              |
+------------+-------------------+

On 2013-10-01:
  - There were 4 requests in total, 2 of which were canceled.
  - However, the request with Id=2 was made by a banned client (User_Id=2), so it is ignored in the calculation.
  - Hence there are 3 unbanned requests in total, 1 of which was canceled.
  - The Cancellation Rate is (1 / 3) = 0.33
On 2013-10-02:
  - There were 3 requests in total, 0 of which were canceled.
  - The request with Id=6 was made by a banned client, so it is ignored.
  - Hence there are 2 unbanned requests in total, 0 of which were canceled.
  - The Cancellation Rate is (0 / 2) = 0.00
On 2013-10-03:
  - There were 3 requests in total, 1 of which was canceled.
  - The request with Id=8 was made by a banned client, so it is ignored.
  - Hence there are 2 unbanned request in total, 1 of which were canceled.
  - The Cancellation Rate is (1 / 2) = 0.50
  */


/*
Test Data
drop table if exists Trips;
drop table if exists Users;

create table Users
(
users_id int primary key,
Banned enum('Yes','No'),
`Role` enum('client','driver','partner')
);

create table Trips
(
Id int primary key,
Client_Id int,
Driver_Id int,
City_Id int,
`Status` enum('completed', 'cancelled_by_driver', 'cancelled_by_client'),
Request_at date,
foreign key(Client_Id) references users(users_id),
foreign key(Driver_Id) references users(users_id)
);

insert into users(users_id, Banned,`Role`)
values(1,'No','client'),
           (2,'Yes','client'),
           ( 3,'No','client'),
           ( 4,'No','client'),
           (10,'No','driver'),
           ( 11 ,'No','driver'),
           (12 ,'No' ,'driver'),
           (13,'No' ,'driver');
           
insert into Trips
values(1,1,10 ,1 ,'completed',str_to_date('2013-10-01','%Y-%m-%d')),
(2 ,2 ,11 ,1  ,'cancelled_by_driver',str_to_date('2013-10-01','%Y-%m-%d')),
( 3 ,3  ,12  ,6  ,'completed',str_to_date('2013-10-01','%Y-%m-%d')),
(4 ,4  ,13  ,6 ,'cancelled_by_client',str_to_date('2013-10-01','%Y-%m-%d')),
(5  ,1  ,10 , 1 ,'completed',str_to_date('2013-10-02','%Y-%m-%d')),
(6 ,2  ,11 ,6 ,'completed ',str_to_date('2013-10-02','%Y-%m-%d')),
(7 ,3 ,12   ,6 ,'completed ',str_to_date('2013-10-02','%Y-%m-%d')),
(8 ,2  ,12  ,12,'completed ',str_to_date('2013-10-03','%Y-%m-%d')),
(9 ,3 ,10 ,12 ,'completed',str_to_date('2013-10-03','%Y-%m-%d')),
(10,4  , 13 ,12,'cancelled_by_driver',str_to_date('2013-10-03','%Y-%m-%d'));

*/


# Write your MySQL query statement below
select allTrips.Request_at `Day`,round(ifnull(cancelledTrips.cancelledCount/allTrips.allTripsCount,0.00),2) `Cancellation Rate`
from
(
select Trips.Request_at,count(*) allTripsCount
from (select  Id, Client_Id, Driver_Id, `Status` tripstatus,request_at from  Trips where request_at between str_to_date('2013-10-01','%Y-%m-%d') and str_to_date('2013-10-03','%Y-%m-%d')) Trips,
(select Users_id  User_id from users where Role='client' and Banned='No') unbannedclient,
(select Users_id  User_id from users where Role='driver' and Banned='No') unbanneddriver
where trips.client_id=unbannedclient.User_id
and trips.driver_id=unbanneddriver.User_id
group by Trips.request_at
) allTrips
left outer join
(select Trips.Request_at,count(*) cancelledCount
from (select  Id, Client_Id, Driver_Id, `Status` tripstatus,request_at from  Trips) Trips,
(select Users_id  User_id from users where Role='client' and Banned='No') unbannedclient,
(select Users_id  User_id from users where Role='driver' and Banned='No') unbanneddriver
where trips.client_id=unbannedclient.User_id
and trips.driver_id=unbanneddriver.User_id
and (tripstatus='cancelled_by_driver'
or tripstatus='cancelled_by_client')
group by Trips.request_at
) cancelledTrips
on (allTrips.Request_at=cancelledTrips.Request_at)
