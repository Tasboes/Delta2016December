-- 1 Hent 10 filmtitler fra et år (baseret på årstallet i titlen)
SELECT *
FROM MovielensOptim.movies
WHERE title REGEXP '[1-2][0-9][0-9][0-9])$'
AND LEFT(RIGHT(title, 5),4) = '2001'
LIMIT 10;
-- 2 Hent top 10 (højst ratede – med minimum 10 ratings) filmtitler fra det seneste år (baseret på årstallet i titlen)
select movies.movieId,title, avg(rating) as avgRating from MovielensOptim.ratings, MovielensOptim.movies where ratings.movieId in (
select sub1.movieId from (SELECT movies.movieId,title, COUNT(ratings.rating) as countRatings
FROM MovielensOptim.movies, MovielensOptim.ratings
WHERE movies.movieId = ratings.movieId
AND LEFT(RIGHT(title, 5),4) = (SELECT MAX(LEFT(RIGHT(title, 5),4)) as yearInDate
	FROM MovielensOptim.movies
	WHERE title REGEXP '[1-2][0-9][0-9][0-9])$')
GROUP BY movies.movieId) AS sub1
WHERE sub1.countRatings > 10)
and movies.movieId = ratings.movieId
group by movies.movieId
order by avgRating desc
limit 10;


select movies.movieId, movies.title, avg(rating) as avgRating from MovielensOptim.ratings, MovielensOptim.movies
where ratings.movieId in (127098,119145,129428,129354,130073,120637,120466,130490,128488,127096,113345,124867,120635,120825,129937,130075,126548,128975,125916,129030)
and movies.movieId = ratings.movieId
group by movies.movieId
order by avgRating desc;

-- 3 Hent en specific film (defineret ved movieID) og list alle relationer (title, year, average rating, antal ratings, genre, tags)
select movies.title, (select count(rating) from MovielensOptim.ratings where movieId = 50) ,(select avg(rating) from MovielensOptim.ratings where movieId = 50), group_concat(distinct genres.genreName separator ', '), group_concat( distinct tags.tag separator ', ') from MovielensOptim.genres, MovielensOptim.MoviesGenres, MovielensOptim.tags, MovielensOptim.movies
where genres.genreId = MoviesGenres.genreId
and tags.movieId = MoviesGenres.movieId
and movies.movieId = MoviesGenres.movieId
and MoviesGenres.movieId = 50;
-- 4 Hent alle film med samme givne tags (>0,75 relevance) som filmen (givet ved movieId)
select sub1.movieId, movies.title from (select distinct movieId, count(tagId) as tagCounter
from MovielensOptim.genome_scores 
where tagId in (select tagId from MovielensOptim.genome_scores where movieId = 3 and relevance > 0.75)
and relevance > 0.75
group by movieId) as sub1, MovielensOptim.movies
where tagCounter = (select count(tagId) from MovielensOptim.genome_scores where movieId = 3 and relevance > 0.75)
and sub1.movieId = movies.movieId
order by movieId;

select * from MovielensOptim.genome_scores where movieId = 2683 and tagId in (230,451,742,901,902);
-- 5 Hent de 10 mest populære der har samme genre (givet ved mindst alle genrer) som filmen (givet ved movieId) har
select sub1.movieId, movies.title, avg(ratings.rating) as avgRating from (
	select movieId, count(genreId) as genreCounter from MovielensOptim.MoviesGenres where genreId in(select genreId from MovielensOptim.MoviesGenres where movieId = 5)
    group by movieId) 
as sub1, MovielensOptim.movies, MovielensOptim.ratings
where sub1.genreCounter = (select count(genreId) from MovielensOptim.MoviesGenres where movieId = 5)
and sub1.movieId = movies.movieId
and sub1.movieId = ratings.movieId
group by movieId
order by avgRating desc
limit 10;


select * from MovielensOptim.MoviesGenres where movieId in (3,4,7,11,39);
select * from MovielensOptim.MoviesGenres where movieId in (5,109571,93707);
-- 6 Hent de 10 højest bedømte (average rating - mindst 10 ratings) film i 2010 (givet ved rating timestamp)
select * from (select movies.title, avg(ratings.rating) as agvRating, count(ratings.rating) as countRatings
from MovielensOptim.movies, MovielensOptim.ratings 
where movies.movieId = ratings.movieId
and ratings.timestamp < unix_timestamp('2011-01-01 00:00:00')
and ratings.timestamp > unix_timestamp('2010-01-01 00:00:00')
group by ratings.movieId
order by avg(ratings.rating) desc) as sub1
where countRatings >= 10
limit 10;
-- 7 Hent de 10 højest bedømte (average rating – mindst 10 ratings) film nogensinde
select * from (select movies.title, avg(ratings.rating) as agvRating, count(ratings.rating) as countRatings
from MovielensOptim.movies, MovielensOptim.ratings 
where movies.movieId = ratings.movieId
group by ratings.movieId
order by avg(ratings.rating) desc) as sub1
where countRatings >= 100
limit 10;
-- 8 Hent alle film der er bedømt 4 eller derover af bruger (defineret ved userId)
select movies.title 
from MovielensOptim.movies, MovielensOptim.ratings
where movies.movieId = ratings.movieId
and ratings.rating > 4
and ratings.userId = 5;
-- 9 Hent alle film hvor relevans er over en given værdi (relevance > 0,9) for et givent sæt af (3) tags (givet ved tagId’er).
select distinct movies.title
from MovielensOptim.movies, MovielensOptim.genome_scores
where movies.movieId = genome_scores.movieId
and genome_scores.relevance > 0.9
and genome_scores.tagId in (1,2,3);
-- 10 Hent de film der har været bedømt for sidste gang i 2009 (rating time)
select distinct movies.title
from MovielensOptim.movies, MovielensOptim.ratings
where movies.movieId = ratings.movieId
and ratings.timestamp < unix_timestamp('2010-01-01 00:00:00')
and ratings.timestamp > unix_timestamp('2009-01-01 00:00:00')
and ratings.movieId not in (select movieId from MovielensOptim.ratings where timestamp >= unix_timestamp('2010-01-01 00:00:00'));
-- 11 Hent den højst bedømte genre (givet ved 1 genre) uge 3 2015
select genres.genreName, genres.genreId, avg(ratings.rating) as avgRating
from MovielensOptim.movies, MovielensOptim.ratings, MovielensOptim.MoviesGenres, MovielensOptim.genres
where movies.movieId = ratings.movieId
and movies.movieId = MoviesGenres.movieId
and MoviesGenres.genreId = genres.genreId
and ratings.timestamp < unix_timestamp('2015-01-19 00:00:00')
and ratings.timestamp > unix_timestamp('2015-01-12 00:00:00')
group by MoviesGenres.genreId
order by avgRating desc
limit 10;





