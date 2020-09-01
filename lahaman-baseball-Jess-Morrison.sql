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
/*#3 with dupl*/
Select namefirst,namelast,schoolname as School,
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
group by namefirst,namelast, School, salary
order by salary desc
----
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
---skipped 3 w/o dupl
/*#4*/
select playerid, pos as pos.o, pos as pos.i, pos as pos.b
from fielding
where pos.o = 'OF' AND pos = 'SS', '1B', '2B','3B'
				   --
Select 
CASE WHEN pos= 'OF' then 'Outfield'	
when pos= 'SS,1B,2B,3B' then 'Infield'	
when pos= 'P' or pos= 'C' then 'Battery'	
Else 'Null'	end as position, po, yearid
from fielding
inner join people
on fielding.playerid=people.playerid				   
where yearid= '2016' 				   
group by fielding.pos,
fielding.yearid, fielding.po
			  ORDER BY sum(cast(fielding.pos)
	---			   
select
sum(case pos when 'OF' THEN 1 ELSE 0 END) 
"Outfield",
sum(case pos when 'SS' THEN 1 WHEN '1B' THEN 1 WHEN'2B' THEN 1 WHEN'3B' THEN 1 else 0 end)			  
"Infield",
sum(case pos when 'P' then 1 WHEN 'C' then 1 else 0 end )			  
"Battery", yearid as year
			  from fielding
where yearid= '2016'
group by fielding.yearid
order by sum(po)						   
				   
				   
				   --
				   

			 
				   
				   




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





