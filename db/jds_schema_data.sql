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
) ENGINE=InnoDB AUTO_INCREMENT=193 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` VALUES (23,'Agra'),(5,'Ahmedabad'),(123,'Ahmednagar'),(148,'Aizawl'),(80,'Ajmer'),(103,'Akola'),(54,'Aligarh'),(36,'Allahabad'),(136,'Alwar'),(93,'Ambattur'),(168,'Ambernath'),(66,'Amravati'),(34,'Amritsar'),(164,'Anantapur'),(165,'Arrah'),(77,'Asansol'),(32,'Aurangabad'),(126,'Avadi'),(147,'Bally'),(3,'Bangalore'),(172,'Baranagar'),(137,'Bardhaman'),(51,'Bareilly'),(152,'Bathinda'),(91,'Belgaum'),(108,'Bellary'),(111,'Bhagalpur'),(170,'Bharatpur'),(114,'Bhatpara'),(74,'Bhavnagar'),(68,'Bhilai'),(120,'Bhilwara'),(61,'Bhiwandi'),(16,'Bhopal'),(57,'Bhubaneswar'),(184,'Bidar'),(183,'Bidhan Nagar'),(144,'Bihar Sharif'),(131,'Bijapur'),(65,'Bikaner'),(129,'Bilaspur'),(106,'Bokaro'),(121,'Brahmapur'),(192,'cdassd'),(48,'Chandigarh'),(134,'Chandrapur'),(6,'Chennai'),(39,'Coimbatore'),(71,'Cuttack'),(146,'Darbhanga'),(101,'Davanagere'),(75,'Dehradun'),(2,'Delhi'),(191,'Deoli'),(149,'Dewas'),(33,'Dhanbad'),(117,'Dhule'),(160,'Durg'),(76,'Durgapur'),(167,'Etawah'),(25,'Faridabad'),(158,'Farrukhabad'),(72,'Firozabad'),(185,'Gandhinagar'),(96,'Gaya'),(21,'Ghaziabad'),(110,'Gopalpur'),(63,'Gorakhpur'),(81,'Gulbarga'),(64,'Guntur'),(47,'Guwahati'),(41,'Gwalior'),(163,'Hapur'),(142,'Hisar'),(186,'Hosapete'),(38,'Howrah'),(50,'Hubballi-Dharwad'),(4,'Hyderabad'),(150,'Ichalkaranji'),(161,'Imphal'),(14,'Indore'),(40,'Jabalpur'),(10,'Jaipur'),(55,'Jalandhar'),(97,'Jalgaon'),(153,'Jalna'),(89,'Jammu'),(82,'Jamnagar'),(69,'Jamshedpur'),(86,'Jhansi'),(43,'Jodhpur'),(139,'Kakinada'),(28,'Kalyan-Dombivali'),(128,'Kamarhati'),(12,'Kanpur'),(166,'Karimnagar'),(73,'Kochi (Cochin)'),(79,'Kolhapur'),(7,'Kolkata'),(125,'Kollam (Quilon)'),(119,'Korba'),(46,'Kota'),(102,'Kozhikode (Calicut)'),(138,'Kulti'),(104,'Kurnool'),(116,'Latur'),(84,'Loni'),(11,'Lucknow'),(22,'Ludhiana'),(44,'Madurai'),(99,'Maheshtala'),(95,'Malegaon'),(92,'Mangalore'),(124,'Mathura'),(156,'Mau'),(26,'Meerut'),(59,'Mira-Bhayandar'),(175,'Mirzapur'),(190,'Mohali'),(52,'Moradabad'),(1,'Mumbai'),(113,'Muzaffarnagar'),(122,'Muzaffarpur'),(53,'Mysore'),(13,'Nagpur'),(181,'Naihati'),(78,'Nanded'),(187,'Nangloi Jat'),(24,'Nashik'),(35,'Navi Mumbai'),(88,'Nellore'),(171,'New Delhi'),(140,'Nizamabad'),(67,'Noida'),(169,'North Dumdum'),(143,'Ozhukarai'),(177,'Pali'),(115,'Panihati'),(145,'Panipat'),(189,'Panvel'),(141,'Parbhani'),(109,'Patiala'),(19,'Patna'),(18,'Pimpri-Chinchwad'),(9,'Pune'),(154,'Purnia'),(176,'Raichur'),(45,'Raipur'),(127,'Rajahmundry'),(27,'Rajkot'),(105,'Rajpur Sonarpur'),(178,'Ramagundam'),(132,'Rampur'),(37,'Ranchi'),(162,'Ratlam'),(174,'Rewa'),(118,'Rohtak'),(159,'Sagar'),(62,'Saharanpur'),(58,'Salem'),(90,'Sangli-Miraj & Kupwad'),(155,'Satna'),(130,'Shahjahanpur'),(133,'Shivamogga (Shimoga)'),(85,'Siliguri'),(182,'Singrauli'),(49,'Solapur'),(157,'Sonipat'),(107,'South Dumdum'),(179,'Sri Ganganagar'),(31,'Srinagar'),(188,'Srirampur'),(8,'Surat'),(15,'Thane'),(60,'Thiruvananthapuram'),(135,'Thrissur'),(56,'Tiruchirappalli'),(94,'Tirunelveli'),(151,'Tirupati'),(100,'Tirupur'),(173,'Tiruvottiyur'),(112,'Tumakuru (Tumkur)'),(98,'Udaipur'),(83,'Ujjain'),(87,'Ulhasnagar'),(180,'Uluberia'),(20,'Vadodara'),(30,'Varanasi'),(29,'Vasai-Virar'),(42,'Vijayawada'),(17,'Visakhapatnam'),(70,'Warangal');
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (1,'India'),(2,'USA');
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `currency`
--

LOCK TABLES `currency` WRITE;
/*!40000 ALTER TABLE `currency` DISABLE KEYS */;
INSERT INTO `currency` VALUES (1,'INR',1),(2,'USD',0.02);
/*!40000 ALTER TABLE `currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `districts`
--

DROP TABLE IF EXISTS `districts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `districts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `district` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `districts`
--

LOCK TABLES `districts` WRITE;
/*!40000 ALTER TABLE `districts` DISABLE KEYS */;
INSERT INTO `districts` VALUES (1,'Puri'),(2,'Bhadrak'),(3,'Balasore'),(4,'Jaleshwar'),(5,'Chakradharpur'),(6,'Chaibasa'),(7,'Bikaner');
/*!40000 ALTER TABLE `districts` ENABLE KEYS */;
UNLOCK TABLES;

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
  `paymentMode` int(11) DEFAULT NULL,
  `chqddNumber` int(11) DEFAULT NULL,
  `paymentDate` date DEFAULT NULL,
  `amount` float DEFAULT '0',
  `currency` int(11) DEFAULT NULL,
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
  UNIQUE KEY `inward_no_UNIQUE` (`inwardNumber`),
  KEY `city` (`city`),
  KEY `inwardCreationDate` (`inwardCreationDate`),
  KEY `inwardPurpose` (`inwardPurpose`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inward`
--

LOCK TABLES `inward` WRITE;
/*!40000 ALTER TABLE `inward` DISABLE KEYS */;
INSERT INTO `inward` VALUES (67,'11L-00001','abc',1,13,147,0,'','','','2011-12-25','0',1,4,0,'2011-12-25',0,1,0,NULL,NULL,0,NULL,'','',NULL,1),(68,'11L-00002','abc',1,13,3,0,'','','','2011-12-25','0',1,4,0,'2011-12-25',0,1,0,NULL,NULL,0,NULL,'','',NULL,0),(69,'11L-00003','test',1,21,57,0,'','','','2011-12-25','0',5,1,0,'2011-12-25',0,2,0,NULL,NULL,0,NULL,'','',NULL,0),(70,'11L-00004','test',1,13,147,0,'','','','2011-12-25','0',1,4,0,'2011-12-25',0,1,0,NULL,NULL,0,NULL,'','',NULL,0),(71,'11L-00005','test',1,13,147,0,'','','','2011-12-25','0',1,4,0,'2011-12-25',0,1,0,NULL,'',0,NULL,'','',NULL,0),(72,'11L-00006','Mrs Kamala Pachisia',1,1,23,0,'','','','2011-12-25','0',3,2,0,'2011-12-28',0,1,0,NULL,NULL,0,NULL,'','',NULL,0),(73,'11L-00007','Kamala Pachisia',1,1,23,0,'','','','2011-12-25','0',3,2,0,'2011-12-25',0,2,0,NULL,'',0,NULL,'','',NULL,0),(74,'11L-00008','abc',1,1,23,0,'','','','2011-12-25','0',3,4,0,'2011-12-25',0,1,0,NULL,NULL,0,NULL,'','',NULL,0),(75,'11L-00009','abc',1,1,23,0,'','','','2011-12-25','0',3,4,0,'2011-12-25',0,1,0,NULL,NULL,0,NULL,'','',NULL,0),(76,'11L-00010','abc',1,1,23,0,'','','','2011-12-25','0',3,4,0,'2011-12-25',0,1,0,NULL,NULL,0,NULL,'','',NULL,0),(77,'11L-00011','abc',1,1,23,0,'','','','2011-12-25','0',3,1,0,'2011-12-28',0,2,0,NULL,NULL,0,NULL,'','',NULL,0),(78,'11L-00012','abc',1,1,5,0,'','','','2011-12-25','0',7,4,0,'2011-12-25',0,1,0,NULL,NULL,0,NULL,'','',NULL,0),(79,'11L-00013','abc',1,1,23,0,'','','','2011-12-25','0',3,4,0,'2011-12-25',0,1,0,NULL,NULL,0,NULL,'','',NULL,0),(80,'11L-00014','abc',1,1,23,0,'','','','2011-12-25','0',3,4,0,'2011-12-25',0,1,0,NULL,NULL,0,NULL,'','',NULL,0),(81,'11L-00015','abc',1,1,23,0,'','','','2011-12-25','0',3,4,0,'2011-12-25',0,1,0,NULL,NULL,0,NULL,'','',NULL,0),(82,'11L-00016','abc',1,1,23,0,'','','','2011-12-25','0',3,4,0,'2011-12-25',0,1,0,NULL,NULL,0,NULL,'','',NULL,0),(83,'11L-00017','abc',1,1,23,0,'','','','2011-12-25','0',7,4,0,'2011-12-25',0,1,0,NULL,NULL,0,NULL,'','',NULL,0),(84,'11L-00018','munnu',1,1,23,0,'sm@test.com','','','2011-12-25','0',3,1,12345,'2011-12-25',0,1,0,NULL,NULL,0,NULL,'','State Bank of india',NULL,0),(85,'11L-00019','mun',1,1,5,0,'','','','2011-12-25','0',3,4,0,'2011-12-25',0,1,0,NULL,NULL,0,NULL,'','',NULL,0),(86,'11L-00020','hjh',1,1,80,0,'','','','2011-12-25','0',3,4,0,'2011-12-25',0,1,0,NULL,NULL,0,NULL,'','',NULL,0),(87,'11L-00021','abc',1,1,168,0,'','test','test','2011-12-25','0',3,1,0,'2011-12-25',4560,1,0,NULL,NULL,0,NULL,'','ICICI Bank',NULL,0),(88,'11L-00022','Pinki Pachisia',1,13,3,560067,'pinki.pachisia@gmail.com','SAP Labs','SRM','2011-12-26','0',1,4,52152,'2011-12-26',0,1,0,NULL,NULL,0,NULL,'','CitiBank',NULL,0),(89,'11L-00023','a',1,1,23,0,'','','','2011-12-26','0',3,4,0,'2011-12-26',0,1,0,NULL,NULL,0,NULL,'','',NULL,0),(90,'11L-00024','a',1,1,23,0,'','','','2011-12-26','0',3,4,0,'2011-12-26',0,1,0,NULL,NULL,0,NULL,'','',NULL,0),(91,'11L-00025','Pinki Pachisia',1,13,3,560067,'pinki.pachisia@gmail.com','SAP Labs','SRM','2011-12-26','0',1,2,252512,'2011-12-26',1200,1,0,NULL,NULL,0,NULL,'test remarks','ICICI Bank',NULL,0),(92,'11L-00026','b',1,1,23,0,'','','','2011-12-26','0',3,4,0,'2011-12-26',0,1,0,NULL,NULL,0,NULL,'sd','',NULL,0),(93,'11L-00027','abc',1,1,23,0,'','','','2011-12-26','0',3,4,0,'2011-12-26',0,1,0,NULL,NULL,0,NULL,'sdf','',NULL,0),(94,'11L-00028','abc',1,1,23,0,'','','','2011-12-26','0',3,4,0,'2011-12-26',0,1,0,NULL,NULL,0,NULL,'','',NULL,0),(95,'11L-00029','abc',1,1,23,0,'','','','2011-12-26','0',3,4,0,'2011-12-26',0,1,0,NULL,NULL,0,NULL,'','',NULL,0),(96,'11L-00030','abc',1,1,23,0,'','','','2011-12-26','0',3,4,0,'2011-12-26',0,1,0,NULL,NULL,0,NULL,'','',NULL,0),(97,'11L-00031','abc',1,1,5,0,'','','','2011-12-26','0',3,1,0,'2011-12-26',0,1,0,NULL,NULL,0,NULL,'test','',NULL,0),(98,'11L-00032','abc',1,1,23,0,'','','','2011-12-26','0',3,4,0,'2011-12-26',0,1,0,NULL,NULL,0,NULL,'test','',NULL,0),(99,'11L-00033','test',1,13,3,0,'','','','2011-12-28','0',1,4,0,'2011-12-28',0,1,0,NULL,NULL,0,NULL,'','',NULL,0),(100,'11L-00034','test',1,13,3,560067,'pinki.pachisia@gmail.com','','','2011-12-28','0',1,4,12345,'2011-12-28',654,1,0,NULL,NULL,0,NULL,'','CitiBank',NULL,0),(101,'11L-00035','abc',1,1,5,0,'','','','2011-12-29','0',3,4,0,'2011-12-29',0,NULL,0,NULL,NULL,0,NULL,'','',NULL,0),(102,'11L-00036','abc',1,1,23,0,'','','','2011-12-29','0',3,4,0,'2011-12-29',0,NULL,0,NULL,NULL,0,NULL,'','',NULL,0),(103,'11L-00037','abc',1,1,5,0,'','','','2011-12-29','0',1,4,0,'2011-12-29',0,NULL,0,NULL,NULL,0,NULL,'','',NULL,0),(104,'11L-00038','hg',1,1,23,0,'','','','2011-12-29','0',3,4,0,'2011-12-29',0,1,0,NULL,NULL,0,NULL,'','',NULL,0),(105,'11L-00039','test',1,1,23,0,'','','','2011-12-29','0',3,NULL,0,'2011-12-29',0,NULL,0,NULL,NULL,0,NULL,'','',NULL,0),(106,'11L-00040','test',1,1,23,0,'','','','2011-12-29','0',3,NULL,0,'2011-12-29',0,NULL,0,NULL,NULL,0,NULL,'','',NULL,0),(107,'11L-00041','test',1,1,23,0,'','','','2011-12-29','0',3,NULL,0,'2011-12-29',0,NULL,0,NULL,NULL,0,NULL,'','',NULL,0),(108,'11L-00042','test',1,1,23,0,'','','','2011-12-29','0',3,NULL,0,'2011-12-29',0,NULL,0,NULL,NULL,0,NULL,'','',NULL,0),(109,'11L-00043','abc',1,1,23,0,'','','','2011-12-29','0',3,NULL,0,'2011-12-29',0,NULL,0,NULL,NULL,0,NULL,'','',NULL,0),(110,'11L-00044','abc',1,1,23,0,'','','','2011-12-29','0',3,NULL,0,'2011-12-29',0,NULL,0,NULL,NULL,0,NULL,'','',NULL,0),(111,'11L-00045','abc',1,1,23,0,'','','','2011-12-29','0',3,NULL,0,'2011-12-29',0,NULL,0,NULL,NULL,0,NULL,'','',NULL,0),(112,'11L-00046','abc',1,1,23,0,'','','','2011-12-29','0',3,NULL,0,'2011-12-29',0,NULL,0,NULL,NULL,0,NULL,'','',NULL,0),(113,'11L-00047','abc',1,1,23,0,'','','','2011-12-29','0',3,NULL,0,'2011-12-29',0,NULL,0,NULL,NULL,0,NULL,'','',NULL,0),(114,'11L-00048','',1,3,5,0,'','','','2011-12-29','0',3,1,0,'2011-12-29',0,1,0,NULL,NULL,0,NULL,'trt','',NULL,0),(115,'11L-00049','',1,1,23,0,'','','','2011-12-29','0',3,NULL,0,'2011-12-29',0,NULL,0,NULL,NULL,0,NULL,'','',NULL,0),(116,'11L-00050','adsad',1,1,23,0,'','','','2011-12-29','0',3,NULL,0,'2011-12-29',0,NULL,0,NULL,NULL,0,NULL,'','',NULL,0);
/*!40000 ALTER TABLE `inward` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `inward_purpose`
--

LOCK TABLES `inward_purpose` WRITE;
/*!40000 ALTER TABLE `inward_purpose` DISABLE KEYS */;
INSERT INTO `inward_purpose` VALUES (3,'Address Change'),(7,'Advertisement'),(8,'Manuscript'),(5,'Missing Issue'),(1,'New Subscription'),(9,'Others'),(2,'Renew Subscription'),(6,'Reprint'),(4,'Request For Invoice');
/*!40000 ALTER TABLE `inward_purpose` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `inward_return_reasons`
--

LOCK TABLES `inward_return_reasons` WRITE;
/*!40000 ALTER TABLE `inward_return_reasons` DISABLE KEYS */;
INSERT INTO `inward_return_reasons` VALUES (3,'Cheque/ DD not in favour of Indian Academy of Sciences'),(11,'Cheque/DD to be corrected'),(1,'For want of Client\'s address'),(9,'Insufficient funds'),(8,'Only one Cheque/DD to be drawn for all the journals'),(13,'Others'),(6,'Payment already received for current year'),(4,'Personal Subscription accepted for minimum of TWO years only'),(12,'Provide residential address for Personal Subscription'),(10,'Revalidate the Cheque/DD'),(2,'Short Payment'),(5,'Subscriptions are accepted for Calendar year only (Jan-Dec)'),(7,'The issues ordered are out of stock');
/*!40000 ALTER TABLE `inward_return_reasons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jds_format_helper`
--

DROP TABLE IF EXISTS `jds_format_helper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jds_format_helper` (
  `year` int(11) NOT NULL,
  `last_inward_number` int(11) NOT NULL DEFAULT '0',
  `last_subscriber_number` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`year`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Remembers the last inward number and subscriber number. Helps in generating the next inward & subscriber number';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jds_format_helper`
--

LOCK TABLES `jds_format_helper` WRITE;
/*!40000 ALTER TABLE `jds_format_helper` DISABLE KEYS */;
/*!40000 ALTER TABLE `jds_format_helper` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `payment_mode`
--

LOCK TABLES `payment_mode` WRITE;
/*!40000 ALTER TABLE `payment_mode` DISABLE KEYS */;
INSERT INTO `payment_mode` VALUES (4,'Cash'),(1,'Cheque'),(2,'Demand Draft'),(3,'Money Order');
/*!40000 ALTER TABLE `payment_mode` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `states`
--

LOCK TABLES `states` WRITE;
/*!40000 ALTER TABLE `states` DISABLE KEYS */;
INSERT INTO `states` VALUES (1,'Andhra Pradesh'),(2,'Arunachal Pradesh'),(3,'Assam'),(4,'Bihar'),(5,'Chattisgarh'),(7,'Goa'),(8,'Gujarat'),(10,'Haryana'),(9,'Himachal Pradesh'),(12,'Jammu & Kashmir'),(11,'Jharkhand'),(13,'Karnataka'),(14,'Kerela'),(18,'Madhya Pradesh'),(17,'Maharastra'),(15,'Manipur'),(16,'Meghalaya'),(19,'Mizoram'),(20,'Nagaland'),(6,'New Delhi'),(21,'Orissa'),(23,'Pondicherry'),(22,'Punjab'),(24,'Rajasthan'),(25,'Sikkim'),(26,'Tamilnadu'),(27,'Tripura'),(28,'Uttar Pradesh'),(29,'Uttaranchal'),(30,'West Bengal');
/*!40000 ALTER TABLE `states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriber`
--

DROP TABLE IF EXISTS `subscriber`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscriber` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `subscriberNumber` varchar(20) NOT NULL,
  `subscriberCreationDate` date NOT NULL,
  `subscriberName` varchar(64) NOT NULL,
  `department` varchar(64) DEFAULT NULL,
  `institution` varchar(64) DEFAULT NULL,
  `subscriberAddress` varchar(64) NOT NULL,
  `city` int(11) NOT NULL,
  `district` int(11) DEFAULT NULL,
  `state` int(11) NOT NULL,
  `country` int(11) NOT NULL,
  `pincode` varchar(45) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `subtype` int(11) DEFAULT NULL,
  `agent_id` int(11) DEFAULT '0',
  `deactive` tinyint(1) DEFAULT '0',
  `deactivation_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subscriber_id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriber`
--

LOCK TABLES `subscriber` WRITE;
/*!40000 ALTER TABLE `subscriber` DISABLE KEYS */;
INSERT INTO `subscriber` VALUES (24,'11L-00001','2011-12-27','Shailendra Mahapatra',NULL,NULL,'# 1075, Sobha Amethyst\r\nKannamangala, Kadugodi, Whitefield',3,1,13,1,'560067',NULL,NULL,0,0,NULL),(25,'11L-00002','2011-12-27','4354353',NULL,NULL,'rewrwrwrw',5,2,1,1,'43224242',NULL,1,0,0,NULL),(26,'11L-00003','2011-12-27','sadadad',NULL,NULL,'dsadadad',123,NULL,4,1,'0',NULL,4,0,0,NULL),(27,'11L-00004','2011-12-27','eweq',NULL,NULL,'eweqqqqqqqqqq',23,NULL,2,1,'0',NULL,1,0,0,NULL),(28,'11L-00005','2011-12-27','eweq',NULL,NULL,'eweqqqqqqqqqq',23,NULL,2,1,'0',NULL,1,0,0,NULL),(29,'11L-00006','2011-12-27',' yrty','ewrwrw','rewrwrwr','ertretet',23,2,1,1,'0','pinki.pachisia@sap.com',1,0,0,NULL),(30,'11L-00007','2011-12-27','ASssdsa','trtetret','rewrwrwr','dgterstret',5,3,5,1,'543534','pinki.pachisia@sap.com',2,0,0,NULL),(31,'11L-00008','2011-12-27','65757','trtetret','ertetre','rewtwtw',123,2,2,1,'0','pinki.pachisia@sap.com',2,0,0,NULL),(32,'11L-00009','2011-12-27',' yrty','trtete','','reeyeye',5,NULL,1,1,'0','',4,0,0,NULL),(33,'11L-00010','2011-12-27','dwaeq','trtete','','jj',93,6,9,1,'4535353','',5,0,0,NULL),(34,'11L-00011','2011-12-27','fdsfds','','','fdssf',5,NULL,5,1,'0','',2,0,0,NULL),(35,'11L-00012','2011-12-27','4354353','','','tftdyt',103,NULL,15,2,'0','',4,0,0,NULL),(36,'11L-00013','2011-12-27','dsafsaf','','','erwreq',80,3,7,1,'0','',4,0,0,NULL),(37,'11L-00014','2011-12-27','df','','','grdtt',103,NULL,10,2,'0','',2,0,0,NULL),(38,'11L-00015','2011-12-28','weqeq','','','ewqeqe',123,NULL,2,1,'0','',5,0,0,NULL),(39,'11L-00016','2011-12-28','weqeq','','','ewqeqe',123,NULL,2,1,'0','',5,0,0,NULL),(40,'11L-00017','2011-12-28','weqeq','','','ewqeqe',123,NULL,2,1,'0','',5,0,0,NULL),(41,'11L-00018','2011-12-28','vfds','','','dsfs',5,NULL,1,1,'0','',2,0,0,NULL),(42,'11L-00019','2011-12-28','ewq','','','ewqe',80,NULL,3,2,'0','',1,0,0,NULL),(43,'11L-00020','2011-12-28','tytryr','etretewt','tertret','ytyr',123,2,2,1,'5433335','pinki.pachisia@sap.com',3,0,0,NULL),(44,'11L-00021','2011-12-28','ferwer','rewrwr','wrwrrw','rewr',123,3,4,1,'42432424','pinki.pachisia@sap.com',2,0,0,NULL),(45,'11L-00022','2011-12-28','r4wetr4535','5435','ertete','543535',5,3,3,1,'543535','pinki.pachisia@sap.com',2,0,0,NULL),(46,'11L-00023','2011-12-28','er435','rewrwr','rewrwrwr','5435435',148,4,2,2,'4333','pinki.pachisia@sap.com',2,0,0,NULL),(47,'11L-00024','2011-12-28','dad','','','546464',148,NULL,10,2,'0','',5,0,0,NULL),(48,'11L-00025','2011-12-28','564','','','rete',103,NULL,12,1,'0','',3,0,0,NULL),(49,'11L-00026','2011-12-28','564','','','432424',80,NULL,10,1,'0','',1,0,0,NULL),(50,'11L-00027','2011-12-28','Deepali Gokhale','IAS','IAS','Kasturinagar',3,NULL,13,1,'560067','hghjg',1,0,0,NULL),(51,'11L-00028','2011-12-28','er435','','','rwqrqr',54,NULL,7,2,'0','',1,0,0,NULL),(52,'11L-00029','2011-12-28','rewrer','','','rewrwr',148,NULL,7,1,'0','',1,0,0,NULL),(53,'11L-00030','2011-12-28','dsada','','','dsada',103,NULL,10,2,'0','',1,0,0,NULL),(54,'11L-00031','2011-12-28','rwetewtw','','','rewrwr',103,NULL,8,1,'0','',2,0,0,NULL),(55,'11L-00032','2011-12-28','43242','','','43',123,NULL,5,1,'0','',3,0,0,NULL),(56,'11L-00033','2011-12-28','grret','','','tret',54,NULL,10,1,'0','',1,0,0,NULL),(57,'11L-00034','2011-12-28','ryr','','','yty',126,NULL,20,1,'0','',3,0,0,NULL),(58,'11L-00035','2011-12-28','rte','','','trete',54,NULL,3,1,'0','',2,0,0,NULL),(59,'11L-00036','2011-12-28','fsdfsfs','','','fdsfds',54,NULL,7,2,'0','',2,0,0,NULL),(60,'11L-00037','2011-12-28','rgtet','','','tret',5,NULL,5,1,'0','',1,0,0,NULL),(61,'11L-00038','2011-12-28','tretet','','','trete',148,NULL,3,1,'0','',1,0,0,NULL),(62,'11L-00039','2011-12-28','ytryr','','','ytryr',123,2,4,1,'0','',1,0,0,NULL),(63,'11L-00040','2011-12-28','fdsfsf','','','fdsff',123,NULL,4,1,'0','',3,0,0,NULL),(64,'11L-00041','2011-12-28','trewt','','','tretet',148,NULL,5,1,'0','',1,0,0,NULL),(65,'11L-00042','2011-12-28','fdsfsfsf','','','sfdsfsfdsf',80,NULL,3,1,'0','',1,0,0,NULL),(66,'11L-00043','2011-12-28','dasda','','','ewqeq',148,4,2,1,'0','',1,0,0,NULL),(67,'11L-00044','2011-12-28','dwaeq','IAS','wrwrrw','jhjkhlkjljlkkl;k;;;;;;hjuhkjjjjjjjjjjjjjjjjjjjjjj',80,1,3,1,'0','pinki.pachisia@sap.com',1,0,0,NULL),(68,'11L-00045','2011-12-28','wqreqewq','','','eeqweqew',123,2,3,1,'0','',1,0,0,NULL),(69,'11L-00046','2011-12-28','43443234','','','weqweqe',123,NULL,4,2,'0','',3,0,0,NULL),(70,'11L-00047','2011-12-28','dwaeq','','','324242',80,3,3,1,'0','',3,0,0,NULL),(71,'11L-00048','2011-12-28','tret','','','tret',123,NULL,5,2,'0','',1,0,0,NULL),(72,'11L-00049','2011-12-28','tret','','','tret',5,NULL,3,1,'0','',4,0,0,NULL),(73,'11L-00050','2011-12-28','ewrwr','','','rewr',54,NULL,3,1,'0','',1,0,0,NULL),(74,'11L-00051','2011-12-28','fd','','','fds',54,NULL,2,2,'0','',1,0,0,NULL),(75,'11L-00052','2011-12-28','tretetetete','','','tretre',103,NULL,5,1,'0','',1,0,0,NULL),(76,'11L-00053','2011-12-28','tretetertet','','','tretet',54,NULL,3,1,'0','',2,0,0,NULL),(77,'11L-00054','2011-12-28','rerwer','','','rewrwrewrwrw',148,NULL,1,1,'0','',1,0,0,NULL),(78,'11L-00055','2011-12-28','trnb','','','nbn',148,NULL,7,2,'0','',1,0,0,NULL),(79,'11L-00056','2011-12-28','54','','','rew',80,NULL,10,1,'0','',1,0,0,NULL),(80,'11L-00057','2011-12-28','dddd','','','dddd',148,NULL,2,1,'0','',3,0,0,NULL),(81,'11L-00058','2011-12-29','fsd','','','sd',5,NULL,3,1,'0','',2,0,0,NULL),(82,'11L-00059','2011-12-29','fa','','','f',123,NULL,8,2,'0','',1,0,0,NULL),(83,'11L-00060','2011-12-29','dsadadadaada','','','dsdad',136,NULL,7,1,'0','',2,0,0,NULL),(84,'11L-00061','2011-12-29','xzczc','','','cxzczc',123,NULL,3,2,'0','',1,0,0,NULL),(85,'11L-00062','2011-12-29','ryr','','','fdf',36,NULL,7,2,'0','',3,0,0,NULL),(86,'11L-00063','2011-12-29','nbv','','','nb',80,NULL,7,1,'0','',3,0,0,NULL),(87,'11L-00064','2011-12-29','mkmk','','','mkmk',170,NULL,26,1,'0','',1,0,0,NULL),(88,'11L-00065','2011-12-29','nnn','','','nnn',54,NULL,8,2,'0','',5,0,0,NULL),(89,'11L-00066','2011-12-29','xzz','','','xzx',80,NULL,28,1,'0','',3,0,0,NULL),(90,'11L-00067','2011-12-29','qqq','','','qqqq',23,2,4,1,'111111','',2,0,0,NULL),(91,'11L-00068','2011-12-29','wwwww','','','wwwwwww',32,4,11,2,'3333333','',1,0,0,NULL),(92,'11L-00069','2011-12-29','xxxxxxxxxxxxxx','','','xxxxxxx',54,NULL,8,2,'0','',3,0,0,NULL),(93,'11L-00070','2011-12-29','zzzzzz','','','zzzzzz',148,4,3,1,'0','',1,0,0,NULL),(94,'11L-00071','2011-12-29','xxxxxxxx','','','xxxx',123,NULL,3,1,'0','',1,0,0,NULL),(95,'11L-00072','2011-12-29','c','','','c',80,NULL,4,2,'0','',3,0,0,NULL),(96,'11L-00073','2011-12-29','uuuu','','','uuu',103,NULL,3,1,'0','',3,0,0,NULL),(97,'11L-00074','2011-12-29','uuuuuuuu','','','uu',80,NULL,10,2,'0','',1,0,0,NULL),(98,'11L-00075','2011-12-29','cxcx','','','cxc',36,NULL,7,1,'0','',2,0,0,NULL),(99,'11L-00076','2011-12-29','sdadadada','','','dsad',36,NULL,4,1,'0','',1,0,0,NULL),(100,'11L-00077','2011-12-29','mmmmmmmmmmm','','','mmmmm',103,NULL,4,1,'0','',2,0,0,NULL),(101,'11L-00078','2011-12-29','jjjjjjj','','','jjjjjjjj',54,NULL,4,2,'0','',1,0,0,NULL),(102,'11L-00079','2011-12-29','vvvvvvvvvvv','','','vvvvvv',54,NULL,7,1,'0','',2,0,0,NULL),(103,'11L-00080','2011-12-29','dddddddd','','','dddd',148,NULL,4,1,'0','',5,0,0,NULL),(104,'11L-00081','2011-12-29','xxxx','','','xxxx',5,NULL,1,2,'0','',5,0,0,NULL),(105,'11L-00082','2011-12-29','zzzz','','','dsds',103,NULL,7,1,'0','',3,0,0,NULL),(106,'11L-00083','2011-12-29','zz','','','zz',36,NULL,16,1,'0','',3,0,0,NULL),(107,'11L-00084','2011-12-29','xxxx','','','xx',5,NULL,3,1,'0','',1,0,0,NULL),(108,'11L-00085','2011-12-29','ssss','','','ssss',148,NULL,4,1,'0','',3,0,0,NULL),(109,'11L-00086','2011-12-29','gfg','','','gfg',148,NULL,3,1,'0','',5,0,0,NULL),(110,'11L-00087','2011-12-29','sd','','','sas',80,NULL,5,1,'0','',4,0,0,NULL),(111,'11L-00088','2011-12-29','ghghhgh','','','llll',80,1,20,1,'0','',2,0,0,NULL),(112,'11L-00089','2011-12-29','xcvc','','','vc',80,NULL,2,1,'0','',1,0,0,NULL),(113,'11L-00090','2011-12-29','ggggg','','','hghhghghg',74,5,24,1,'0','',5,0,0,NULL),(114,'11L-00091','2011-12-29','waeq','','','ewqeqe',103,4,5,2,'0','',3,0,0,NULL),(115,'11L-00092','2011-12-29','43242','','','hgh',23,NULL,1,1,'0','',1,0,0,NULL);
/*!40000 ALTER TABLE `subscriber` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriber_type`
--

DROP TABLE IF EXISTS `subscriber_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscriber_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subtypecode` char(5) DEFAULT NULL,
  `subtypedesc` char(64) DEFAULT NULL,
  `subtype` char(32) DEFAULT NULL,
  `subtypeindian` char(1) DEFAULT NULL,
  `freejrnl` int(8) DEFAULT NULL,
  `discount` float(8,3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriber_type`
--

LOCK TABLES `subscriber_type` WRITE;
/*!40000 ALTER TABLE `subscriber_type` DISABLE KEYS */;
INSERT INTO `subscriber_type` VALUES (1,'IC','Indian Schools and Colleges','Free','X',NULL,NULL),(2,'II','Indian Institutes','Free','X',NULL,NULL),(3,'IP','Indian Institute of Science','Paid','Y',NULL,NULL),(4,'FELGM','Fellows','Paid','Y',NULL,NULL),(5,'XXX','Summer Fellows','Free','Y',NULL,NULL);
/*!40000 ALTER TABLE `subscriber_type` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES ('jds@ias.com','user'),('shail@ias.com','user'),('tomcat','manager-script');
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('jds@ias.com','jds'),('shail@ias.com','shail'),('tomcat','tomcat');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-12-30  0:05:58
