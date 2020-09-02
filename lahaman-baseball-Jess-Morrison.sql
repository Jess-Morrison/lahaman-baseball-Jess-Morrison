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
				   --***
Select 
CASE WHEN pos= 'OF' then 'Outfield' 	
when pos IN('SS','1B','2B','3B') then 'Infield'	
when pos IN('P', 'C') then 'Battery' 
end as position , sum(po) as putouts
from fielding
inner join people
on fielding.playerid=people.playerid
where yearid= '2016'				   
group by position
order by position				   
				   
--				   
select coalesce(pos) as pos_c, sum(po) as po_sum, yearid,
case when fielding.pos= 'OF' then 'Outfield' end as position
from fielding
where yearid= '2016' 				   
group by fielding.po, fielding.pos, yearid	
				   
	---			   
select
sum(case pos when 'OF' THEN 1 ELSE 0 END) 
"Outfield",
sum(case pos when 'SS' THEN 1 WHEN '1B' THEN 1 WHEN'2B' THEN 1 WHEN'3B' THEN 1 else 0 end)			  
"Infield",
sum(case pos when 'P' then 1 WHEN 'C' then 1 else 0 end )			  
"Battery",po,playerid
from fielding
where yearid= '2016'
group by fielding.po, fielding.pos, fielding.playerid
--				   
Select concat(namefirst,' ',namelast) as players,
CASE WHEN pos= 'OF' then 'Outfield' 	
when pos= 'SS'and pos='1B' and pos='2B'and pos='3B' then 'Infield'	
when pos= 'P' and pos= 'C' then 'Battery' 
end as position , po, yearid	
from fielding
inner join people
on fielding.playerid=people.playerid				   
where yearid= '2016' 		   
group by people.namefirst,people.namelast,fielding.po,
fielding.yearid, fielding.pos
order by position, po desc		   
				   

				   
				   --
/*#4Correct*/				   
Select 
CASE WHEN pos= 'OF' then 'Outfield' 	
when pos IN('SS','1B','2B','3B') then 'Infield'	
when pos IN('P', 'C') then 'Battery' 
end as position , sum(po) as putouts
from fielding
inner join people
on fielding.playerid=people.playerid
where yearid= '2016'				   
group by position
order by position
/*#5a*/
select round(avg(so),2) as avg_so,count(g) as per_game,
yearid
from battingpost
where yearid   				   
group by battingpost.g, battingpost.yearid
---
/*#5a corect */				   
Select round(sum (so)::numeric/(sum(g)::numeric/2),2) as avg_strikeout,sum(so) as strikeout,
				   sum(g)/2 as games,
case when yearid between 1920 and 1929 then '1920-1930'
when yearid between 1930 and 1939 then '1930-1940'
when yearid between 1940 and 1949 then '1940-1950'
when yearid between 1950 and 1959 then '1950-1960'
when yearid between 1960 and 1969 then '1960-1970'
when yearid between 1970 and 1979 then '1970-1980'
when yearid between 1980 and 1989 then '1980-1990'
when yearid between 1990 and 1999 then '1990-2000'
when yearid between 2000 and 2009 then '2000-2010'
when yearid between 2010 and 2016 then '2000-NOW'				   
				   end as decade 
FROM teams
where yearid >=1920 
group by decade	   
order by decade asc				   
---
/*#5b correct*/				   
Select round(sum (hr)::numeric/(sum(g)::numeric/2),2) as avg_homeruns,sum(hr) as homeruns,
				   sum(g)/2 as games,
case when yearid between 1920 and 1929 then '1920-1930'
when yearid between 1930 and 1939 then '1930-1940'
when yearid between 1940 and 1949 then '1940-1950'
when yearid between 1950 and 1959 then '1950-1960'
when yearid between 1960 and 1969 then '1960-1970'
when yearid between 1970 and 1979 then '1970-1980'
when yearid between 1980 and 1989 then '1980-1990'
when yearid between 1990 and 1999 then '1990-2000'
when yearid between 2000 and 2009 then '2000-2010'
when yearid between 2010 and 2016 then '2000-NOW'				   
				   end as decade 
FROM teams
where yearid >=1920 
group by decade	   
order by decade asc	


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
/*#7a*/
select franchname, w,wswin,yearid,
case when yearid between 1970 and 2016 then '1970-2016'
end as golden_hour				   
FROM teams
INNER join teamsfranchises
on teams.franchid=teamsfranchises.franchid
where wswin ='N' and '1970-2016' is not null
group by teamsfranchises.franchname, teams.w, teams.wswin,
teams.yearid				   
ORDER BY W desc
--Seattle Mariners--
/*#7b*/				   
select franchname, w,wswin,yearid,
case when yearid between 1970 and 2016 then '1970-2016'
end as golden_hour				   
FROM teams
INNER join teamsfranchises
on teams.franchid=teamsfranchises.franchid
where wswin ='N' and yearid >=1970
group by teamsfranchises.franchname, teams.w, teams.wswin,
teams.yearid 			   
ORDER BY W asc				   