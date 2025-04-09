-- Importing large data more than lakhs of rows
use nikitasql;

-- 1. Create the table athletes
create table athletes(
	Id int,
    Name varchar(200),
    Sex char(1),
    Age int,
    Height float,
    Weight float,
    Team varchar(200),
    NOC char(3),
    Games varchar(200),
    Year int,
    Season varchar(200),
    City varchar(200),
    Sport varchar(200),
    Event varchar(200),
    Medal Varchar(50));

-- View the blank Athletes table

select * from athletes;

load data infile "C:/ProgramData/MySQL/MySQL Server 9.2/Uploads/Athletes_Cleaned.csv"
into table athletes
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

select * from athletes;

-- Check number of rows in the table
select count(*) from athletes;

-- view the athletes table
show tables;
select * from athletes;

/* SQL Olymics project */

-- Q1. Show how many medal counts present for entire data.
select count(distinct medal) from athletes;

select count(medal) from athletes
where medal <> "nomedal";
-- where not medal = "nomedal"

-- Q2. Show count of unique Sports are present in olympics.
select * from athletes;
select distinct(sport) from athletes;
select count(distinct(sport)) from athletes;

-- Q3. Show how many different medals won by Team India in data.
select team,count(medal) from athletes
where team ="india" and medal <> "nomedal"
group by team;

-- Q3. Alternate solution

/* Q4. Show event wise medals won by india show from highest to 
lowest medals won in order. */
select event,count(medal) from athletes
where team = "india" and medal <> "nomedal"
group by event
order by count(medal) desc;

-- Q5. Show event and yearwise medals won by india in order of year.

select event,year,count(medal) ,team from athletes
where team = "india" and medal <> "nomedal"
group by event,year,team
order by year;

-- Q6. Show the country with maximum medals won gold, silver, bronze
select * from athletes;

select team,event,medal,count(medal) as medal_count from athletes
where medal in("gold","silver","broze")
group by team ,event,medal
order by medal_count desc; 
/* select team,event, max(medal )as medal_count from athletes
group by team ,event,medal
where medal in("gold", "silver", "bronze")
order by medal_count;*/

-- Q7. Show the top 10 countries with respect to gold medals
select team,event, count(medal) from athletes
where medal="gold"
group by team,event
order by count(medal) desc
limit 10  ;

-- Q8. Show in which year did United States won most medals
select * from athletes;
select year,count(medal) as medal_count from athletes
where team="united states" and medal<>"nomedal"
group by year 
order by medal_count desc
 limit 1 ;




-- Q9. In which sports United States has most medals
select * from athletes;
 select sport,count(medal) as medal_count from athletes
where team="united states" and medal<>"nomedal"
group by sport
order by medal_count desc
 limit 1 ;
/* SELECT sport, COUNT(*) AS medal_count
FROM athletes
WHERE team= 'United States'
GROUP BY sport
ORDER BY medal_count DESC
LIMIT 1;*/


-- Q10. Find top 3 players who have won most medals along with their sports and country
select name,sport ,team , count(medal) as medal_count from athletes
where medal<>"nomedal"
group by name ,sport,team
order by  medal_count desc
limit 3; 
-- Q11. Find player with most gold medals in cycling along with his country.
select name,team,count(medal) as medal_count from athletes
where sport ="cycling" and  medal ="gold"
group by name,team
order by medal_count desc
limit 1;

-- Q12. Find player with most medals (Gold + Silver + Bronze) in Basketball also show his country.
select name ,team ,count(medal) as medal_count from athletes
where  medal in ("gold","silver","bronze" ) and sport ="basketball" 
group by name , team
order by medal_count desc
limit 1;

-- Q13. Find out the count of different medals of the top basketball player.
select * from athletes;
select name,sport ,medal,count(medal) from athletes
where sport ="Basketball" and medal<>"nomedal"
group by sport,name,medal
order by count(medal) desc
limit 1;



-- Q14. Find out medals won by male, female each year.
select * from athletes;
/*select name ,sex,year,medal,count(*) as medal_count from athletes
where sex="M" and sex="f"
group by name ,sex,year,medal
order by sex,medal,year  desc; */
select sex,year,count(medal) as medalcount from athletes
where medal <> "nomedal"
group by sex,year;


