/*
SQL Schema
Table: Activity

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key of this table.
This table shows the activity of players of some game.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on some day using some device.
 

Write a SQL query that reports the device that is first logged in for each player.

The query result format is in the following example:

Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-05-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+

Result table:
+-----------+-----------+
| player_id | device_id |
+-----------+-----------+
| 1         | 2         |
| 2         | 3         |
| 3         | 1         |
+-----------+-----------+
*/

/* Test Data

drop table if exists Activity;
create table Activity
(
player_id    int,
device_id    int,
event_date  date,
games_played int ,
primary key(player_id, event_date)
);

INSERT INTO `Activity`
(`player_id`,
`device_id`,
`event_date`,
`games_played`)
VALUES
(1,2,str_to_date('2016-03-01','%Y-%m-%d'),5),
(1,2,str_to_date('2016-05-02','%Y-%m-%d'),6),
(2,3,str_to_date('2017-06-25','%Y-%m-%d'),1),
(3,1,str_to_date('2016-03-02','%Y-%m-%d'),0),
(3,4,str_to_date('2018-07-03','%Y-%m-%d'),5);

*/

# Write your MySQL query statement below
select Activity.player_id,Activity.device_id
from
	(
		select player_id, min(event_date) first_login
		from Activity
		group by player_id
    ) firstloginDetails
    inner join
	Activity
on (firstloginDetails.player_id=Activity.player_id
       and 
	  firstloginDetails.first_login=Activity.event_date)
