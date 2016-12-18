LOAD DATA LOCAL INFILE '/Users/andersbloch/ml-20m/my/MoviesCleaned.csv' INTO TABLE MovielensOptim.movies FIELDS TERMINATED BY ';';
LOAD DATA LOCAL INFILE '/Users/andersbloch/ml-20m/my/links.csv' INTO TABLE MovielensOptim.links FIELDS TERMINATED BY ',';
LOAD DATA LOCAL INFILE '/Users/andersbloch/ml-20m/my/tagsCleaned.csv' INTO TABLE MovielensOptim.tags FIELDS TERMINATED BY ',';
LOAD DATA LOCAL INFILE '/Users/andersbloch/ml-20m/my/genome-tags.csv' INTO TABLE MovielensOptim.genome_tags FIELDS TERMINATED BY ',';
LOAD DATA LOCAL INFILE '/Users/andersbloch/ml-20m/my/genome-scores.csv' INTO TABLE MovielensOptim.genome_scores FIELDS TERMINATED BY ','; -- 162 sekunder
LOAD DATA LOCAL INFILE '/Users/andersbloch/ml-20m/my/ratings.csv' INTO TABLE MovielensOptim.ratings FIELDS TERMINATED BY ','; -- 313 sekunder
LOAD DATA LOCAL INFILE '/Users/andersbloch/ml-20m/my/GenreForImport.csv' INTO TABLE MovielensOptim.genres FIELDS TERMINATED BY ';'; 
LOAD DATA LOCAL INFILE '/Users/andersbloch/ml-20m/my/MovieGenreForImport.csv' INTO TABLE MovielensOptim.MoviesGenres FIELDS TERMINATED BY ';';

ALTER TABLE `MovielensOptim`.`ratings` 
ADD INDEX `Index_MovieIdUserId` (`movieId` ASC, `userId` ASC),
ADD INDEX `Index_MovieIdRating` (`movieId` ASC, `rating` ASC),
ADD INDEX `Index_Timestamp` (`timestamp` ASC);						-- 178 sekunder

ALTER TABLE `MovielensOptim`.`genome_scores`
ADD INDEX `Index_MovieIdTagId` (`tagId` ASC,`movieId` ASC);			-- 45 sekunder

ALTER TABLE `MovielensOptim`.`tags`
ADD INDEX `Index_Tag_MovieId` (`tag`(100) ASC,`movieId` ASC);		-- 4 sekunder

select count(*) from MovielensOptim2.movies;			-- 27278
select count(*) from MovielensOptim2.links;				-- 27278
select count(*) from MovielensOptim2.tags;				-- 465564
select count(*) from MovielensOptim2.genome_tags;		-- 1128
select count(*) from MovielensOptim2.genome_scores;		-- 11709768
select count(*) from MovielensOptim2.ratings;			-- 20000263