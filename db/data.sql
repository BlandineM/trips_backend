-- MySQL dump 10.13  Distrib 5.7.30, for Linux (x86_64)
--
-- Host: localhost    Database: voyage_2
-- ------------------------------------------------------
-- Server version	5.7.30-0ubuntu0.18.04.1

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
-- Table structure for table `assoc_countries_periods`
--

DROP TABLE IF EXISTS `assoc_countries_periods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assoc_countries_periods` (
  `id_countries` int(11) NOT NULL,
  `id_periods` int(11) NOT NULL,
  `temperature` decimal(10,2) DEFAULT NULL,
  `precipitation` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_countries`,`id_periods`),
  KEY `fk_assoc-countries-periods_2_idx` (`id_periods`),
  CONSTRAINT `fk_assoc-countries-periods_1` FOREIGN KEY (`id_countries`) REFERENCES `countries` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_assoc-countries-periods_2` FOREIGN KEY (`id_periods`) REFERENCES `periods` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assoc_countries_periods_types`
--

DROP TABLE IF EXISTS `assoc_countries_periods_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assoc_countries_periods_types` (
  `id_countries` int(11) NOT NULL,
  `id_periods` int(11) NOT NULL,
  `is_ok` tinyint(4) NOT NULL,
  `id_types` int(11) NOT NULL,
  PRIMARY KEY (`id_countries`,`id_periods`,`id_types`),
  KEY `fk_assoc_pays_periodes_types_2_idx` (`id_periods`),
  KEY `fk_assoc_pays_periodes_types_3_idx` (`id_types`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `capitalCity` varchar(255) DEFAULT NULL,
  `region` varchar(255) DEFAULT NULL,
  `code` varchar(45) DEFAULT NULL,
  `nameFr` varchar(255) DEFAULT NULL,
  `flag` varchar(255) DEFAULT NULL,
  `pictures` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1090 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `periods`
--

DROP TABLE IF EXISTS `periods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `periods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `month` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trips`
--

DROP TABLE IF EXISTS `trips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trips` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_countries` int(11) NOT NULL,
  `id_periods` int(11) DEFAULT NULL,
  `id_users` int(11) NOT NULL,
  `year` year(4) DEFAULT NULL,
  `check` tinyint(4) DEFAULT '0',
  `description` varchar(100) DEFAULT NULL,
  `picture` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_assoc_pays_periodes_users_2_idx` (`id_periods`),
  KEY `fk_assoc_pays_periodes_users_3_idx` (`id_users`),
  KEY `fk_assoc_pays_periodes_users_1_idx` (`id_countries`),
  CONSTRAINT `fk_assoc_pays_periodes_users_3` FOREIGN KEY (`id_users`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `types`
--

DROP TABLE IF EXISTS `types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `login` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login_UNIQUE` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `weather-countries`
--

DROP TABLE IF EXISTS `weather-countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `weather-countries` (
  `id_pays` int(11) NOT NULL,
  `id periode` int(11) NOT NULL,
  `annee` int(11) NOT NULL,
  `temperature moyenne` int(11) DEFAULT NULL,
  `temperature max` int(11) DEFAULT NULL,
  `temperature min` int(11) DEFAULT NULL,
  `humidite` int(11) DEFAULT NULL,
  `precipitation moyenne par jour` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_pays`,`id periode`),
  KEY `fk_weather-countries_2_idx` (`id periode`),
  CONSTRAINT `fk_weather-countries_1` FOREIGN KEY (`id_pays`) REFERENCES `countries` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_weather-countries_2` FOREIGN KEY (`id periode`) REFERENCES `periods` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
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

-- Dump completed on 2020-06-19 14:16:31
