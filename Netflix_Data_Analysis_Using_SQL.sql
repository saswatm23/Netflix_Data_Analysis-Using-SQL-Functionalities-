CREATE TABLE NETFLIX_DATA(
ID varchar(100),
	TITLE varchar(200),
	TYPE varchar(200),
	RELEASE_YEAR INTEGER,
	AGE_CERTIFICATION VARCHAR(20),
	RUNTIME INTEGER,
	GENRE VARCHAR(100),
	PRODUCTION_COUNTRIES VARCHAR(200),
	SEASONS INTEGER,
	IMDB_SCORE NUMERIC,
	IMDB_VOTES INTEGER
)

select * from netflix_data

(Q1)List top 10 movies withthe Highest Average Rating

select title,avg_rating from
(select title,round(avg(imdb_score),1) as avg_rating
from netflix_data
group by title
order by avg_rating desc)
where avg_rating is not null
limit 10

(Q2)Calculate the percentage of movie that belong to each genre in the database

select genre,count(*) as movie_count,round((count(*)*100.0/(select count(*) from netflix_data)),2)|| '%' as percentage
from netflix_data
group by genre
order by percentage desc
limit 10

(Q3)Rank the Movie & Tv series on the basis of their IMDB Score

select title,imdb_score,rank() over(order by imdb_score desc) as RNK
from netflix_data
where imdb_score is not null
limit 10

(Q4)Find the average rating for the movie that belong to multiple genre

select genre,avg_rating from 
(select genre,round(avg(imdb_score),1) as avg_rating
from netflix_data
group by genre
order by avg_rating desc
)where avg_rating is not null
limit 10

(Q5)Categories the Genre according to Age-Certification

select 
	Case
	  when Age_Certification<='PG' Then 'Children'
	  when Age_Certification<='PG_13' Then 'Teen'
	  when Age_Certification in ('R','TV-MA') Then 'Adult'
else 'Unknown'
end as Age_Category,Genre,
Count(*) as Genre_Count
from netflix_data
GROUP BY Age_Category,Genre
limit 10;

(Q6)Find the 2nd Highest Ranked Movie that is Made in the the year 2022

select title,imdb_score
from netflix_data
where release_year=2022 and imdb_score=(select Max(Imdb_score) from netflix_data 
									where release_year=2022 and imdb_score<
			