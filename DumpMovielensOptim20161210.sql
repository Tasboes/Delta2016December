CREATE DATABASE  IF NOT EXISTS `MovielensOptim` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `MovielensOptim`;
-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: localhost    Database: MovielensOptim
-- ------------------------------------------------------
-- Server version	8.0.0-dmr

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `MoviesGenres`
--

DROP TABLE IF EXISTS `MoviesGenres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MoviesGenres` (
  `movieId` int(11) NOT NULL,
  `genreId` int(11) NOT NULL,
  KEY `FK_movieId_idx` (`movieId`),
  KEY `FK_genreId_idx` (`genreId`),
  CONSTRAINT `FK_genreId` FOREIGN KEY (`genreId`) REFERENCES `genres` (`genreId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_movieId` FOREIGN KEY (`movieId`) REFERENCES `movies` (`movieId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `genome_scores`
--

DROP TABLE IF EXISTS `genome_scores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `genome_scores` (
  `movieId` int(11) DEFAULT NULL,
  `tagId` int(11) DEFAULT NULL,
  `relevance` double DEFAULT NULL,
  KEY `FK_Movies_GenomeScores_idx` (`movieId`),
  KEY `FK_GenomeTags_GenomeScores_idx` (`tagId`),
  -- KEY `Index_MovieIdTagId` (`tagId`,`movieId`),
  CONSTRAINT `FK_GenomeTags_GenomeScores` FOREIGN KEY (`tagId`) REFERENCES `genome_tags` (`tagId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Movies_GenomeScores` FOREIGN KEY (`movieId`) REFERENCES `movies` (`movieId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `genome_tags`
--

DROP TABLE IF EXISTS `genome_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `genome_tags` (
  `tagId` int(11) NOT NULL,
  `tag` text,
  PRIMARY KEY (`tagId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `genres` (
  `genreId` int(11) NOT NULL,
  `genreName` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`genreId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `links`
--

DROP TABLE IF EXISTS `links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `links` (
  `movieId` int(11) DEFAULT NULL,
  `imdbId` text,
  `tmdbId` int(11) DEFAULT NULL,
  KEY `FK_Movies_Links_idx` (`movieId`),
  CONSTRAINT `FK_Movies_Links` FOREIGN KEY (`movieId`) REFERENCES `movies` (`movieId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `movies`
--

DROP TABLE IF EXISTS `movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movies` (
  `movieId` int(11) NOT NULL,
  `title` text,
  PRIMARY KEY (`movieId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ratings` (
  `userId` int(11) DEFAULT NULL,
  `movieId` int(11) DEFAULT NULL,
  `rating` double DEFAULT NULL,
  `timestamp` int(11) DEFAULT NULL,
  KEY `FK_Ratings_Movies_idx` (`movieId`),
  -- KEY `Index_MovieIdUserId` (`movieId`,`userId`),
  -- KEY `Index_MovieIdRating` (`movieId`,`rating`),
  -- KEY `Index_Timestamp` (`timestamp`),
  CONSTRAINT `FK_Movies_Ratings` FOREIGN KEY (`movieId`) REFERENCES `movies` (`movieId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `userId` int(11) DEFAULT NULL,
  `movieId` int(11) DEFAULT NULL,
  `tag` text,
  `timestamp` int(11) DEFAULT NULL,
  KEY `FK_Movies_Tags_idx` (`movieId`),
  -- KEY `Index_Tag_MovieId` (`tag`(100),`movieId`),
  CONSTRAINT `FK_Movies_Tags` FOREIGN KEY (`movieId`) REFERENCES `movies` (`movieId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-12-10 15:00:02
