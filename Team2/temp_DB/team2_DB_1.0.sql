CREATE DATABASE  IF NOT EXISTS `team2_project` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `team2_project`;
-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: team2_project
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
-- Table structure for table `team2_wishlist`
--

DROP TABLE IF EXISTS `team2_wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team2_wishlist` (
  `w_num` int(11) NOT NULL,
  `id` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `w_code` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`w_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team2_wishlist`
--

LOCK TABLES `team2_wishlist` WRITE;
/*!40000 ALTER TABLE `team2_wishlist` DISABLE KEYS */;
INSERT INTO `team2_wishlist` VALUES (1,'coduo25','a-200'),(6,'coduo25','a-100'),(8,'coduo25','g-105'),(9,'coduo25','g-106'),(10,'test','a-200'),(12,'test','a-100'),(13,'test','g-105'),(14,'test','g-100'),(15,'test','g-104'),(16,'test','g-106'),(17,'test','a-11'),(18,'coduo25','g-104'),(20,'coduo25','g-101'),(21,'coduo25','g-100'),(22,'coduo25','a-11'),(23,'admin','a-100');
/*!40000 ALTER TABLE `team2_wishlist` ENABLE KEYS */;
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

-- Dump completed on 2020-05-22 14:59:09
