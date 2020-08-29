/*#1*/
SELECT min(yearid),max(yearid)
from teams
--1871-2016
---
/*#2*/
Select CONCAT(namefirst,' ',namelast),people.playerid,
height,g_all,franchname
from people
LEFT JOIN appearances
ON people.playerid=appearances.playerid
LEFT JOIN teams
on appearances.teamid=teams.teamid
LEFT JOIN teamsfranchises
on teams.franchid=teamsfranchises.franchid
group by namefirst,namelast,people.playerid,height,g_all,
teams.franchid,franchname
order by height asc
--- "Eddie Gaedel WAS 43" and played on game with the B.Orioles
---
/*#3*/
Select namefirst,namelast,schoolname as School,
sum(salary) as salary
From people
WHERE playerid in ( Select people,collegeplaying 
				   from people inner join collegeplaying
				   on people.playerid=collegeplaying.playerid
				   where schools.schoolid= 'vandy'
INNER JOIN schools
ON collegeplaying.schoolid=schools.schoolid
INNER JOIN salaries
ON people.playerid=salaries.playerid
INNER JOIN appearances
ON salaries.lgid=appearances.lgid 
group by namefirst,namelast, School, salary
order by salary desc
---
Select people.playerid
From people
INNER JOIN salaries
ON people.playerid=salaries.playerid
INNER JOIN appearances
ON salaries.lgid=appearances.lgid
WHERE people.playerid in (SELECT distinct namefirst,namelast,schoolname as School
				from people
				INNER join collegeplaying
ON people.playerid=collegeplaying.playerid
INNER JOIN schools
ON collegeplaying.schoolid=schools.schoolid
				   where schools.schoolid= 'vandy')
group by namefirst, namelast, School, salary
order by sum(salary) desc				   
--
Select unique(namefirst,namelast),schoolname as School,
sum(salary) as salary
From people
INNER join collegeplaying
ON people.playerid=collegeplaying.playerid  
INNER JOIN schools
ON collegeplaying.schoolid=schools.schoolid
INNER JOIN salaries
ON people.playerid=salaries.playerid
INNER JOIN appearances
ON salaries.lgid=appearances.lgid
WHERE schools.schoolid= 'vandy' 
group by namefirst,namelast,School, salary
order by school desc
---skipped 3
/*#4*/				   




----------
/* #6*/
select CONCAT(namefirst, ' ',namelast),batting.playerid,sb,
cs,(sb+cs) as stolen_base_attempts,
ROUND(CAST(sb AS numeric)/(sb+cs)*100) as success
from batting
left join people as p
on batting.playerid = p.playerid
where yearid ='2016'and (sb+cs)>=20
group by p.namefirst,p.namelast, batting.playerid,batting.sb,
batting.cs
order by success desc
---





