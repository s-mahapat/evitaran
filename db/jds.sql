-- MySQL dump 10.13  Distrib 5.5.16, for Win64 (x86)
--
-- Host: localhost    Database: jds
-- ------------------------------------------------------
-- Server version	5.5.16

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
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `city` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `city_UNIQUE` (`city`)
) ENGINE=InnoDB AUTO_INCREMENT=192 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `country_UNIQUE` (`country`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `currency`
--

DROP TABLE IF EXISTS `currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currency` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `currency` varchar(20) NOT NULL,
  `conversion_factor` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `currency_UNIQUE` (`currency`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inward`
--

DROP TABLE IF EXISTS `inward`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inward` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `inwardNumber` varchar(9) NOT NULL,
  `from` varchar(64) NOT NULL,
  `country` int(11) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `city` int(11) NOT NULL,
  `pincode` int(11) DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `institution` varchar(64) DEFAULT NULL,
  `department` varchar(64) DEFAULT NULL,
  `inwardCreationDate` date NOT NULL,
  `subscriberId` varchar(15) DEFAULT NULL,
  `inwardPurpose` int(11) NOT NULL,
  `paymentMode` int(11) NOT NULL,
  `chqddNumber` int(11) DEFAULT NULL,
  `paymentDate` date DEFAULT NULL,
  `amount` float DEFAULT '0',
  `currency` int(11) NOT NULL,
  `chequeDDReturn` tinyint(1) NOT NULL DEFAULT '0',
  `chequeDDReturnReason` int(11) DEFAULT NULL,
  `chequeDDReturnReasonOther` varchar(20) DEFAULT NULL,
  `receiptNumber` int(11) DEFAULT NULL,
  `ackDate` date DEFAULT NULL,
  `remarks` text,
  `bankName` varchar(64) DEFAULT NULL,
  `returnDate` date DEFAULT NULL,
  `completed` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `inward_no_UNIQUE` (`inwardNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inward_purpose`
--

DROP TABLE IF EXISTS `inward_purpose`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inward_purpose` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purpose` varchar(25) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `purpose_UNIQUE` (`purpose`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inward_return_reasons`
--

DROP TABLE IF EXISTS `inward_return_reasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inward_return_reasons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `return_reason` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `return_reason_UNIQUE` (`return_reason`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment_mode`
--

DROP TABLE IF EXISTS `payment_mode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_mode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `payment_mode` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `payment_mode_UNIQUE` (`payment_mode`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `states`
--

DROP TABLE IF EXISTS `states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `states` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `state_UNIQUE` (`state`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role` (
  `username` varchar(20) NOT NULL,
  `role` varchar(20) NOT NULL,
  PRIMARY KEY (`username`,`role`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  PRIMARY KEY (`username`)
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

-- Dump completed on 2011-12-25 23:59:01
