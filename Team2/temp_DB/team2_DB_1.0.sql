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
-- Table structure for table `team2_order`
--

DROP TABLE IF EXISTS `team2_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team2_order` (
  `o_num` int(11) NOT NULL,
  `o_trade_num` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `o_p_code` text COLLATE utf8_unicode_ci,
  `o_p_amount` int(11) DEFAULT NULL,
  `o_p_option` text COLLATE utf8_unicode_ci,
  `o_p_delivery_method` text COLLATE utf8_unicode_ci,
  `o_m_id` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `o_receive_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `o_receive_zipcode` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `o_receive_addr1` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `o_receive_addr2` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `o_receive_mobile` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `o_receive_phone` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `o_memo` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `o_sum_money` int(11) DEFAULT NULL,
  `o_trade_type` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `o_trade_payer` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `o_trade_date` date DEFAULT NULL,
  `o_trans_num` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `o_date` date DEFAULT NULL,
  `o_status` int(11) DEFAULT NULL,
  PRIMARY KEY (`o_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team2_order`
--

LOCK TABLES `team2_order` WRITE;
/*!40000 ALTER TABLE `team2_order` DISABLE KEYS */;
INSERT INTO `team2_order` VALUES (1,'20200524-1','g-404',1,'','일반포장','coduo25','박정훈','46294','부산 금정구 금강로 225 (장전동, 벽산블루밍디자인시티)','208동 2104호','01062419520','01062419520','test',165500,'무통장입금','박정훈','2020-05-24','','2020-05-24',0),(2,'20200524-1','a-103',1,'','퀵서비스','coduo25','박정훈','46294','부산 금정구 금강로 225 (장전동, 벽산블루밍디자인시티)','208동 2104호','01062419520','01062419520','test',165500,'무통장입금','박정훈','2020-05-24','','2020-05-24',0),(3,'20200524-1','a-103',1,'','일반포장','coduo25','박정훈','46294','부산 금정구 금강로 225 (장전동, 벽산블루밍디자인시티)','208동 2104호','01062419520','01062419520','test',165500,'무통장입금','박정훈','2020-05-24','','2020-05-24',0);
/*!40000 ALTER TABLE `team2_order` ENABLE KEYS */;
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

-- Dump completed on 2020-05-24 11:14:53
