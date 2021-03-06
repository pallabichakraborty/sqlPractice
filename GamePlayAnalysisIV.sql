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
 

Write an SQL query that reports the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, then divide that number by the total number of players.

The query result format is in the following example:

Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-03-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+

Result table:
+-----------+
| fraction  |
+-----------+
| 0.33      |
+-----------+
Only the player with id 1 logged back in after the first day he had logged in so the answer is 1/3 = 0.33
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
(1,2,str_to_date('2016-03-02','%Y-%m-%d'),6),
(2,3,str_to_date('2017-06-25','%Y-%m-%d'),1),
(3,1,str_to_date('2016-03-02','%Y-%m-%d'),0),
(3,4,str_to_date('2018-07-03','%Y-%m-%d'),5);
*/

select  round(consecutivedateloginPlayers/numberOfPlayers,2) fraction
from
(select count(distinct player_id)  numberOfPlayers
 from Activity) Activity,
(
select count(distinct Activity.player_id) consecutivedateloginPlayers
from 
(select player_id, min(event_date) first_login_date
from Activity
group  by player_id ) firstlogin
inner join
Activity
on (firstlogin.player_id=Activity.player_id
AND date_add(first_login_date, interval 1 DAY)=Activity.event_date)
) consecutivedatelogin
