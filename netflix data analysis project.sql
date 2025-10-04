-- netflix project

drop table if exists netflix;
create table  netflix
                (
				    show_id varchar(10) primary key,
					type	varchar(10),
					title varchar(150),
					director	varchar(208),
					casts	varchar(1000),
					country varchar(150),
					date_added varchar(50),
					release_year int,
					rating varchar(10),	
					duration  varchar(15),
					listed_in	varchar(100),
					descriptio varchar(250)
                );
select* from netflix;

select 
   count(*) as total_content
from netflix;


select 
   distinct type 
from netflix;



Here’s the text from the image converted into a clean, typed format for you:


--- 15 Business Problems & Solutions

-- 1. Count the number of Movies vs TV Shows
select 
      type,
	  count(*) as total_content
from netflix
GROUP BY type

-- 2. Find the most common rating for movies and TV shows

select 
     type,
	 rating
from	

(
   SELECT 
      type,
	  rating,
	  count(*),
	  rank() over(partition by type order by  count(*) desc) as ranking
   from netflix 
   group by 1,2
) as t1
where
    ranking = 1

-- 3. List all movies released in a specific year (e.g., 2020)

-- filter 2020
-- movies
select * from netflix
where
     type = 'movie'
	 and
	 release_year = 2020

--4. Find the top 5 countries with the most content on Netflix

select 
      unnest(string_to_array(country,',')) as new_country,
	 count(show_id) as total_content 
from netflix
group by 1
order by 2 desc
limit 5

-- 5. Identify the longest movie or TV show duration

select * from netflix
where
    type = 'movie'
	and
	duration = (select max(duration) from netflix)


-- 6. Find content added in the last 5 years

select 
      *
from netflix
where 
    TO_DATE(date_added,'Month','DD','YYYY') date_added >= current - interval '5 years'

select current_date - interval '5 years'
	


-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'

SELECT * FROM NETFLIX
where director ilike '%Rajiv Chilaka%'


-- 8. List all TV shows with more than 5 seasons
select 
    *,
	aplit_part(duration, ' ', 1) as sessions
from netflix
where 
      type = 'TV Show'
      duration > 5 sessions




-- 9. Count the number of content items in each genre

select 
      unnest(string_to_array(listed_in,',')) as genre,
	  count(show_id) as total_content
from netflix
group by 1


-- 10. Find the average release year for content produced in a specific country
select 
     extract(year from to_date(date_added,'Month DD,YYYY')) as date,
	 count(*) as yearly_content,
	 round(
	 count(*)::numeric/(select count(*) from netflix where country = 'India') * 100,2 as avg_content_per_year
     
from netflix
where country = 'India'
group by 1

 --11. List all movies that are documentaries
select * from netflix
where
    listed_in ilike '%documentaries%'


-- 12. Find all content without a director

select * from netflix
where
    director is null



-- 13. Find how many movies actor 'Salman Khan' appeared in the last 10 years

select * from netflix
where
    casts ilike '%Salman Khan%'
	and
	release_year > extract(year from current_date) - 10


-- 14. Find the top 10 actors who have appeared in the highest number of movies produced

select
-- show_id,
-- casts,
unnest(string_to_array(casts,',')) as actors,
count(*) as total_content
from netflix
where country ilike '&India'
group by 1
order by 2 desc
limit 10


-- 15. Categorize the content based on the presence of the keywords 'kill' and 'violence' in the description field.
--Label content containing these keywords as 'Bad' Label all other content as 'Good'
-- Count how many items fall into each category.
with new_table
as
(
select 
*,
    case
	when descriptio ilike '%kill%' or
	  descriptio ilike '%violence%' then 'bad_content'
	  else 'good_content'
	end category
from netflix
)
select
     category,
	 count(*) as total_content
from new_table
group by 1
	 


where 
    descriptio ilike '%kill%'
	or
	descriptio ilike '%violence%'





















				