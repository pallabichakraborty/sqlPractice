/*
SQL Schema
Get the highest answer rate question from a table survey_log with these columns: id, action, question_id, answer_id, q_num, timestamp.

id means user id; action has these kind of values: "show", "answer", "skip"; answer_id is not null when action column is "answer", while is null for "show" and "skip"; q_num is the numeral order of the question in current session.

Write a sql query to identify the question which has the highest answer rate.

Example:

Input:
+------+-----------+--------------+------------+-----------+------------+
| id   | action    | question_id  | answer_id  | q_num     | timestamp  |
+------+-----------+--------------+------------+-----------+------------+
| 5    | show      | 285          | null       | 1         | 123        |
| 5    | answer    | 285          | 124124     | 1         | 124        |
| 5    | show      | 369          | null       | 2         | 125        |
| 5    | skip      | 369          | null       | 2         | 126        |
+------+-----------+--------------+------------+-----------+------------+
Output:
+-------------+
| survey_log  |
+-------------+
|    285      |
+-------------+
Explanation:
question 285 has answer rate 1/1, while question 369 has 0/1 answer rate, so output 285.
 

Note: The highest answer rate meaning is: answer number's ratio in show number in the same question.
*/

/*
Test Data
drop table survey_log;
create table survey_log
(
id int, 
action enum ("show","answer","skip"), 
question_id int, 
answer_id int, 
q_num int, 
timestamp int,
primary key(id, question_id,action)
);

insert into survey_log(id, action, question_id, answer_id, q_num, timestamp)
values(5,'show',285,null,1,123),
(5,'answer',285,124124,1,124),
(5,'show',369,null,2,125),
(5,'skip',369,null,2,125);
*/
# Write your MySQL query statement below

select question_id survey_log
from
(select q_show.question_id,q_show.no_q_show, ifnull(q_answered.no_q_answer,0) no_q_answer
from
(select question_id,count(*) no_q_show
from survey_log
where action="show"
group by question_id) q_show
left outer join
(select question_id,count(*) no_q_answer
from survey_log
where action="answer"
group by question_id) q_answered
on (q_show.question_id= q_answered.question_id)) survey_stats
order by no_q_answer*100/no_q_show desc
limit 1
