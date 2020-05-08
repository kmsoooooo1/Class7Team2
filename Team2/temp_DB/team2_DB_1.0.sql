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
-- Table structure for table `team2_goods`
--

DROP TABLE IF EXISTS `team2_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team2_goods` (
  `num` int(11) NOT NULL,
  `category` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `sub_category` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sub_category_index` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `g_name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `g_code` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `g_thumbnail` text COLLATE utf8_unicode_ci NOT NULL,
  `g_amount` int(11) NOT NULL,
  `g_price_origin` int(11) NOT NULL,
  `g_discount_rate` int(11) DEFAULT NULL,
  `g_price_sale` int(11) DEFAULT NULL,
  `g_mileage` int(11) DEFAULT NULL,
  `g_delivery` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `g_option` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8_unicode_ci,
  `g_view_count` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team2_goods`
--

LOCK TABLES `team2_goods` WRITE;
/*!40000 ALTER TABLE `team2_goods` DISABLE KEYS */;
INSERT INTO `team2_goods` VALUES (1,'사육용품','사육장','유리/테라리움','NOMOY 우드 렙타일 케이지 50cm(서랍형)','g-100','374f96c6effc1ee3895ad64ea8aac2be.jpg',150,70000,5,66500,1000,'일반배송','','		   		   <br>\r\n					<span style=\"font-weight: bold\"> 관련 동물(종) </span> :  \r\n				   <br>\r\n		   		',8,'2020-05-05'),(2,'먹이','칼슘/약품','-','엑소테라 칼슘 비타민D3 0%','g-101','e28add91001352c222f715598ff95077.jpg',0,6500,10,5850,100,'일반배송','','		   		   <br>\r\n					<span style=\"font-weight: bold\"> 관련 동물(종) </span> :  \r\n				   <br>\r\n		   		',23,'2020-05-05'),(3,'사육용품','램프','소켓','줄스 라이트 커버','g-102','db082d79ceb5136508d237d35cc338a3.jpg',0,25000,20,20000,400,'일반배송','5.5(inch)','		   		   <br>\r\n					<span style=\"font-weight: bold\"> 관련 동물(종) </span> :  \r\n				   <br>\r\n		   		',66,'2020-05-05'),(4,'먹이','인공사료','-','테트라 렙토민 250ml','g-103','c86248059f920bb4f7c884608d598f5f.jpg',100,7500,10,6750,100,'일반배송','','		   		   <br>\r\n					<span style=\"font-weight: bold\"> 관련 동물(종) </span> :  \r\n				   <br>\r\n		   		',8,'2020-05-05'),(5,'먹이','칼슘/약품','-','렙칼 멀티 비타민','g-104','ccbdce702d8ee41c3a8e2be6cebd1663.jpg',200,23800,20,19040,300,'일반배송','','		   		   <br>\r\n					<span style=\"font-weight: bold\"> 관련 동물(종) </span> :  \r\n				   <br>\r\n		   		',12,'2020-05-05'),(7,'사육용품','온/습도 관련','온도조절기','test2','g-105','thumb-202020_500x500.jpg',100,10000,0,10000,100,'선택배송','','		   		   <br>\r\n					<span style=\"font-weight: bold\"> 관련 동물(종) </span> :  \r\n				   <br>\r\n		   		',25,'2020-05-05'),(8,'먹이','생먹이','-','test','g-106','thumb-202020_500x500.jpg',10,10,0,10,0,'일반배송','20(cm)','<br>\r\n				<span style=\"font-weight: bold\"> 관련 동물(종) </span> : rest<br><br>\r\n				  <br>\r\n		   		',19,'2020-05-06'),(9,'먹이','생먹이','-','test','g-106','thumb-202020_500x500.jpg',10,10,0,10,0,'일반배송','40(cm)','<br>\r\n				<span style=\"font-weight: bold\"> 관련 동물(종) </span> : rest<br><br>\r\n				  <br>\r\n		   		',19,'2020-05-06'),(10,'먹이','생먹이','-','test','g-106','thumb-202020_500x500.jpg',10,10,0,10,0,'일반배송','60(cm)','<br>\r\n				<span style=\"font-weight: bold\"> 관련 동물(종) </span> : rest<br><br>\r\n				  <br>\r\n		   		',19,'2020-05-06'),(11,'사육용품','램프','소켓','줄스 라이트 커버','g-102','db082d79ceb5136508d237d35cc338a3.jpg',100,25000,20,20000,400,'일반배송','8.5(inch)','<br>\r\n				<span style=\"font-weight: bold\"> 관련 동물(종) </span> : <br><br>\r\n				  <br>\r\n		   		',62,'2020-05-06');
/*!40000 ALTER TABLE `team2_goods` ENABLE KEYS */;
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

-- Dump completed on 2020-05-08 17:10:39
