CREATE DATABASE  IF NOT EXISTS `team2_project` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `team2_project`;
-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: localhost    Database: team2_project
-- ------------------------------------------------------
-- Server version	5.6.45-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `team2_animals`
--

DROP TABLE IF EXISTS `team2_animals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team2_animals` (
  `num` int(11) NOT NULL,
  `category` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `sub_category` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sub_category_index` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `a_morph` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `a_sex` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `a_status` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `a_code` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `a_image` text COLLATE utf8_unicode_ci NOT NULL,
  `a_amount` int(11) NOT NULL,
  `a_price` int(11) NOT NULL,
  `category_num` int(11) DEFAULT NULL,
  `sub_category_num` int(11) DEFAULT NULL,
  `sub_category_index_num` int(11) DEFAULT NULL,
  `content` text COLLATE utf8_unicode_ci,
  `a_view_count` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team2_animals`
--

LOCK TABLES `team2_animals` WRITE;
/*!40000 ALTER TABLE `team2_animals` DISABLE KEYS */;
/*!40000 ALTER TABLE `team2_animals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team2_board`
--

DROP TABLE IF EXISTS `team2_board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team2_board` (
  `b_idx` int(11) NOT NULL AUTO_INCREMENT,
  `b_category` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `b_p_cate` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `b_title` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `b_writer` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `b_content` varchar(2000) COLLATE utf8_unicode_ci NOT NULL,
  `b_ref` int(11) NOT NULL,
  `b_like` int(11) DEFAULT '0',
  `b_view` int(11) DEFAULT '0',
  `b_reg_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `ip_addr` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `b_file` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`b_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team2_board`
--

LOCK TABLES `team2_board` WRITE;
/*!40000 ALTER TABLE `team2_board` DISABLE KEYS */;
/*!40000 ALTER TABLE `team2_board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'team2_project'
--

--
-- Dumping routines for database 'team2_project'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-28 19:14:20
