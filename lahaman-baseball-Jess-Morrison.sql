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




