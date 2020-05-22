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
-- Table structure for table `team2_dailypointcheck`
--

DROP TABLE IF EXISTS `team2_dailypointcheck`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team2_dailypointcheck` (
  `num` int(11) NOT NULL,
  `id` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `point` int(11) DEFAULT NULL,
  `point_description` text COLLATE utf8_unicode_ci,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team2_dailypointcheck`
--

LOCK TABLES `team2_dailypointcheck` WRITE;
/*!40000 ALTER TABLE `team2_dailypointcheck` DISABLE KEYS */;
INSERT INTO `team2_dailypointcheck` VALUES (1,'coduo27',2000,'회원가입','2020-05-22');
/*!40000 ALTER TABLE `team2_dailypointcheck` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team2_member`
--

DROP TABLE IF EXISTS `team2_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team2_member` (
  `id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `pass` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `zipcode` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `addr1` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `addr2` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `mileage` int(11) DEFAULT NULL,
  `reg_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team2_member`
--

LOCK TABLES `team2_member` WRITE;
/*!40000 ALTER TABLE `team2_member` DISABLE KEYS */;
INSERT INTO `team2_member` VALUES ('admin','1234','관리자','010',NULL,NULL,NULL,'coduo25@gmail.com',100,'2020-04-28 15:00:00'),('coduo25','1234','coduo25','01062419520','46294','부산광역시 금정구 금강로 225','208동 2104호','coduo250@gmail.com',12700,'2020-04-28 15:00:00'),('coduo26','Qwer1234','박정훈','01062419520','46294','부산 금정구 금강로 225 (장전동, 벽산블루밍디자인시티)','208동 2104호','coduo25@gmail.com',0,'2020-05-20 08:07:24'),('coduo27','qwer1234','박정훈','01062419520','46294','부산 금정구 금강로 225 (장전동, 벽산블루밍디자인시티)','208동 2104호','coduo25@gmail.com',2000,'2020-05-22 00:44:32'),('test','qwer1234','테스트','4141221111','','','','coduo25@gmail.com',100,'2020-05-03 04:03:32'),('test1','qwer1234','홍길동','4141221111','','','','1132@u.uyfg',0,'2020-05-03 04:04:34');
/*!40000 ALTER TABLE `team2_member` ENABLE KEYS */;
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

-- Dump completed on 2020-05-22 10:08:05
