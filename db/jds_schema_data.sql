-- MySQL dump 10.13  Distrib 5.5.25, for Win32 (x86)
--
-- Host: localhost    Database: jds
-- ------------------------------------------------------
-- Server version	5.5.25

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
-- Table structure for table `agents`
--

DROP TABLE IF EXISTS `agents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `agentName` varchar(64) NOT NULL,
  `regDate` date DEFAULT NULL,
  `emailId` varchar(64) DEFAULT NULL,
  `address` text,
  `cityId` int(11) DEFAULT NULL,
  `districtId` int(11) DEFAULT NULL,
  `stateId` int(11) DEFAULT NULL,
  `countryId` int(11) DEFAULT NULL,
  `pinCode` int(11) DEFAULT NULL,
  `discount` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_agent_name` (`agentName`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agents`
--

LOCK TABLES `agents` WRITE;
/*!40000 ALTER TABLE `agents` DISABLE KEYS */;
INSERT INTO `agents` VALUES (1,'KVPY',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,'Kumari Ali Mera Trust',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `agents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `back_issue_list`
--

DROP TABLE IF EXISTS `back_issue_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `back_issue_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subscription_detail_id` int(11) NOT NULL,
  `journal_id` int(11) NOT NULL,
  `month` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `issue_number` int(11) NOT NULL,
  `copies` int(11) NOT NULL,
  `sent_to_subscriber` tinyint(4) NOT NULL DEFAULT '0',
  `sent_on` date DEFAULT NULL,
  `added_on` date NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `back_issue_list`
--

LOCK TABLES `back_issue_list` WRITE;
/*!40000 ALTER TABLE `back_issue_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `back_issue_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `circulation_figure`
--

DROP TABLE IF EXISTS `circulation_figure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `circulation_figure` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `journalCode` char(5) DEFAULT NULL,
  `journalName` varchar(128) DEFAULT NULL,
  `instIndia` int(11) DEFAULT NULL,
  `instAbroad` int(11) DEFAULT NULL,
  `indiIndia` int(11) DEFAULT NULL,
  `indiAbroad` int(11) DEFAULT NULL,
  `comp` int(11) DEFAULT NULL,
  `auth` int(11) DEFAULT NULL,
  `totalCopies` int(11) DEFAULT NULL,
  `printOrder` int(11) DEFAULT NULL,
  `balanceCopies` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `circulation_figure`
--

LOCK TABLES `circulation_figure` WRITE;
/*!40000 ALTER TABLE `circulation_figure` DISABLE KEYS */;
INSERT INTO `circulation_figure` VALUES (9,'CURR','Current Science',1227,0,499,0,0,0,1726,2400,674);
/*!40000 ALTER TABLE `circulation_figure` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=239 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` VALUES (1,'Agra'),(2,'Ahmedabad'),(3,'Ahmednagar'),(4,'Aizawl'),(5,'Ajmer'),(6,'Akola'),(7,'Aligarh'),(8,'Allahabad'),(9,'Alwar'),(10,'Ambattur'),(11,'Ambernath'),(12,'Amravati'),(13,'Amritsar'),(14,'Anantapur'),(15,'Arrah'),(16,'Asansol'),(17,'Aurangabad'),(18,'Avadi'),(19,'Bally'),(20,'Bangarpet'),(21,'Baranagar'),(22,'Bardhaman'),(23,'Bareilly'),(24,'Baripada'),(25,'Bathinda'),(26,'Belgaum'),(27,'Bellary'),(28,'Bengaluru'),(29,'Berhampur'),(30,'Bhagalpur'),(31,'Bharatpur'),(32,'Bhatpara'),(33,'Bhavnagar'),(34,'Bhilai'),(35,'Bhilwara'),(36,'Bhiwandi'),(37,'Bhopal'),(38,'Bhubaneswar'),(39,'Bhuj'),(40,'Bidar'),(41,'Bidhan Nagar'),(42,'Bihar Sharif'),(43,'Bijapur'),(44,'Bikaner'),(45,'Bilaspur'),(46,'Bokaro'),(47,'Brahmapur'),(48,'Chandigarh'),(49,'Chandrapur'),(50,'Chennai'),(51,'Chittoor'),(52,'Coimbatore'),(53,'Cuttack'),(54,'Darbhanga'),(55,'Davanagere'),(56,'Davangere'),(57,'Dehradun'),(58,'Delhi'),(59,'Deoli'),(60,'Dewas'),(61,'Dhanbad'),(62,'Dharwad'),(63,'Dhule'),(64,'Dona Paula'),(65,'Durg'),(66,'Durgapur'),(67,'Ernakulam'),(68,'Etawah'),(69,'Faridabad'),(70,'Farrukhabad'),(71,'Firozabad'),(72,'Gandhinagar'),(73,'Gaya'),(74,'Ghaziabad'),(75,'Gopalpur'),(76,'Gorakhpur'),(77,'Gulbarga'),(78,'Guntur'),(79,'Gurgaon'),(80,'Guwahati'),(81,'Gwalior'),(82,'Hapur'),(83,'Hisar'),(84,'Hosapete'),(85,'Howrah'),(86,'Hubballi-Dharwad'),(87,'Hyderabad'),(88,'Ichalkaranji'),(89,'Imphal'),(90,'Indore'),(91,'Jabalpur'),(92,'Jaipur'),(93,'Jalandhar'),(94,'Jalgaon'),(95,'Jalna'),(96,'Jammu'),(97,'Jamnagar'),(98,'Jamshedpur'),(99,'Jhansi'),(100,'Jodhpur'),(101,'Kadapa'),(102,'Kakinada'),(103,'Kalpakkam'),(104,'Kalyan-Dombivali'),(105,'Kalyani'),(106,'Kamarhati'),(107,'Kanpur'),(108,'Kanyakumari'),(109,'Karaikkudi'),(110,'Karimnagar'),(111,'Kattankulathur'),(112,'Kharagpur'),(113,'Kishangarh'),(114,'Kochi'),(115,'Kolhapur'),(116,'Kolkata'),(117,'Kollam (Quilon)'),(118,'Korba'),(119,'Kota'),(120,'Kozhikode (Calicut)'),(121,'Krishangarh'),(122,'Kulti'),(123,'Kurnool'),(124,'Kushalnagar'),(125,'Latur'),(126,'Loni'),(127,'Lucknow'),(128,'Ludhiana'),(129,'Madurai'),(130,'Maheshtala'),(131,'Malegaon'),(132,'Manauli'),(133,'Mangalore'),(134,'Manipal'),(135,'Mathura'),(136,'Mau'),(137,'Meerut'),(138,'Mira-Bhayandar'),(139,'Mirzapur'),(140,'Mohali'),(141,'Moradabad'),(142,'Mumbai'),(143,'Muzaffarnagar'),(144,'Muzaffarpur'),(145,'Mysore'),(146,'Nadia'),(147,'Nagercoil'),(148,'Nagpur'),(149,'Naihati'),(150,'Nainital'),(151,'Nanded'),(152,'Nangloi Jat'),(153,'Nashik'),(154,'Navi Mumbai'),(155,'Nellore'),(156,'New Delhi'),(157,'Nizamabad'),(158,'Noida'),(159,'North Dumdum'),(160,'Ozhukarai'),(161,'Palakkad'),(162,'Pali'),(163,'Panchkula'),(164,'Panihati'),(165,'Panipat'),(166,'Panvel'),(167,'Parbhani'),(168,'Patiala'),(169,'Patna'),(170,'Pimpri-Chinchwad'),(171,'Prasanti Nilayam'),(172,'Puducherry'),(173,'Pune'),(174,'Purnia'),(175,'Radaur'),(176,'Raichur'),(177,'Raipur'),(178,'Rajahmundry'),(179,'Rajkot'),(180,'Rajpur Sonarpur'),(181,'Ramagundam'),(182,'Rampur'),(183,'Ranchi'),(184,'Ratlam'),(185,'Rewa'),(186,'Rohtak'),(187,'Roorkee'),(188,'Sagar'),(189,'Saharanpur'),(190,'Salem'),(191,'Sangli-Miraj & Kupwad'),(192,'Santiniketan'),(193,'SAS Nagar'),(194,'Satna'),(195,'Secunderabad'),(196,'Shahjahanpur'),(197,'Shillong'),(198,'Shimla'),(199,'Shivamogga (Shimoga)'),(200,'Silchar'),(201,'Siliguri'),(202,'Sindhudurg'),(203,'Singrauli'),(204,'Sivakasi'),(205,'Solapur'),(206,'Sonipat'),(207,'South Dumdum'),(208,'Sri Ganganagar'),(209,'Srinagar'),(210,'Sriperumbudur'),(211,'Srirampur'),(212,'Sultanpur'),(213,'Surat'),(214,'Surathkal'),(215,'Tezpur'),(216,'Thane'),(217,'Thiruvananthapuram'),(218,'Thrissur'),(219,'Tiruchirapalli'),(220,'Tirunelveli'),(221,'Tirupati'),(222,'Tirupur'),(223,'Tiruvottiyur'),(224,'Tumakuru (Tumkur)'),(225,'Udaipur'),(226,'Ujjain'),(227,'Ulhasnagar'),(228,'Uluberia'),(229,'Vadodara'),(230,'Vallabh Vidyanagar'),(231,'Varanasi'),(232,'Vasai-Virar'),(233,'Vellore'),(234,'Vijayawada'),(235,'Visakhapatnam'),(236,'Warangal'),(237,'Yamunanagar'),(238,'Yeddumailaram');
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
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (2,'Afghanistan'),(3,'Argentina'),(1,'Australia'),(4,'Belgium'),(5,'Brazil'),(6,'Canada'),(7,'Chile'),(8,'China'),(9,'Czech Republic'),(10,'Denmark'),(11,'Finland'),(12,'France'),(13,'Germany'),(14,'India'),(15,'Israel'),(16,'Italy'),(17,'Japan'),(18,'Jordan'),(19,'Macedonia'),(20,'Madagascar'),(21,'Malaysia'),(22,'Moldava'),(23,'Nepal'),(24,'Netherlands'),(25,'Norway'),(26,'Pakistan'),(27,'Poland'),(29,'Romania'),(28,'Russia'),(30,'Saudi Arabia'),(31,'Singapore'),(32,'Spain'),(33,'Sri Lanka'),(34,'Sweden'),(35,'Switzerland'),(36,'Taiwan'),(37,'Uganda'),(38,'UK'),(39,'USA');
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `district_idx_1` (`district`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=588 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `districts`
--

LOCK TABLES `districts` WRITE;
/*!40000 ALTER TABLE `districts` DISABLE KEYS */;
INSERT INTO `districts` VALUES (538,'24 Parganas North'),(539,'24 Parganas South'),(1,'Adilabad'),(2,'Agra'),(3,'Ahmedabad'),(4,'Ahmednagar'),(5,'Aizawl'),(6,'Ajmer'),(7,'Akola'),(8,'Alappuzha'),(9,'Aligarh'),(10,'Allahabad'),(11,'Almora'),(12,'Alwar'),(13,'Ambala'),(14,'Ambedkar Nagar'),(15,'Amravati'),(16,'Amreli'),(17,'Amritsar'),(18,'Anand'),(19,'Anantapur'),(20,'Anantnag'),(21,'Andaman Islands'),(22,'Angul'),(23,'Araria'),(24,'Ariyalur'),(25,'Auraiya'),(26,'Aurangabad'),(27,'Azamgarh'),(28,'Badaun'),(29,'Badgam'),(30,'Bagalkot'),(31,'Bageshwar'),(32,'Baghpat'),(33,'Bahraich'),(34,'Balaghat'),(35,'Baleshwar'),(36,'Ballia'),(37,'Balrampur'),(38,'Banas Kantha'),(39,'Banda'),(41,'Bangalore Rural'),(42,'Banka'),(43,'Bankura'),(44,'Banswara'),(45,'Barabanki'),(46,'Baragarh'),(47,'Baramula'),(48,'Baran'),(49,'Bardhaman'),(50,'Bareilly'),(51,'Barmer'),(52,'Barpeta'),(53,'Barwani'),(54,'Bastar'),(55,'Basti'),(56,'Bathinda'),(57,'Begusarai'),(58,'Belgaum'),(59,'Bellary'),(40,'Bengaluru'),(60,'Betul'),(61,'Bhadrak'),(62,'Bhagalpur'),(63,'Bhandara'),(64,'Bharatpur'),(65,'Bharuch'),(66,'Bhavnagar'),(67,'Bhilwara'),(68,'Bhind'),(69,'Bhiwani'),(70,'Bhojpur'),(71,'Bhopal'),(72,'Bid'),(73,'Bidar'),(74,'Bijapur'),(75,'Bijnor'),(76,'Bikaner'),(77,'Bilaspur'),(78,'Birbhum'),(79,'Bishnupur'),(80,'Bokaro'),(81,'Bolangir'),(82,'Bongaigaon'),(83,'Boudh'),(84,'Bulandshahr'),(85,'Buldhana'),(86,'Bundi'),(87,'Buxar'),(88,'Cachar'),(89,'Chamba'),(90,'Chamoli'),(91,'Champawat'),(92,'Champhai'),(93,'Chamrajnagar'),(94,'Chandauli'),(95,'Chandel'),(96,'Chandigarh'),(97,'Chandrapur'),(98,'Changlang'),(99,'Chatra'),(100,'Chennai'),(101,'Chhatarpur'),(102,'Chhindwara'),(103,'Chikmagalur'),(104,'Chitradurga'),(105,'Chitrakoot'),(106,'Chittoor'),(107,'Chittorgarh'),(108,'Churachandpur'),(109,'Churu'),(110,'Coimbatore'),(111,'Cuddalore'),(112,'Cuddapah'),(113,'Cuttack'),(114,'Dadra and Nagar Haveli'),(115,'Dahod'),(117,'Dakshin Dinajpur'),(116,'Dakshina Kannada'),(118,'Daman'),(119,'Damoh'),(120,'Dantewada'),(121,'Darbhanga'),(122,'Darjeeling'),(123,'Darrang'),(124,'Datia'),(125,'Dausa'),(126,'Davanagere'),(586,'Davangere'),(127,'Dehradun'),(128,'Delhi'),(129,'Deogarh'),(130,'Deoghar'),(131,'Deoria'),(132,'Dewas'),(133,'Dhalai'),(134,'Dhamtari'),(135,'Dhanbad'),(136,'Dhar'),(137,'Dharmapuri'),(138,'Dharwad'),(139,'Dhemaji'),(140,'Dhenkanal'),(141,'Dholpur'),(142,'Dhubri'),(143,'Dhule'),(144,'Dibang Valley'),(145,'Dibrugarh'),(146,'Dimapur'),(147,'Dindigul'),(148,'Dindori'),(149,'Diu'),(150,'Doda'),(151,'Dumka'),(152,'Dungarpur'),(153,'Durg'),(154,'East Garo Hills'),(155,'East Godavari'),(156,'East Imphal'),(157,'East Kameng'),(158,'East Khasi Hills'),(159,'East Nimar'),(160,'East Siang'),(161,'East Sikkim'),(162,'Ernakulam'),(163,'Erode'),(164,'Etah'),(165,'Etawah'),(166,'Faizabad'),(167,'Faridabad'),(168,'Faridkot'),(169,'Farrukhabad'),(170,'Fatehabad'),(171,'Fatehgarh Sahib'),(172,'Fatehpur'),(173,'Firozabad'),(174,'Firozpur'),(175,'Gadag'),(176,'Gadchiroli'),(177,'Gajapati'),(178,'Gandhinagar'),(179,'Ganganagar'),(180,'Ganjam'),(181,'Garhwa'),(583,'Garhwal'),(182,'Gautam Buddha Nagar'),(183,'Gaya'),(184,'Ghaziabad'),(185,'Ghazipur'),(186,'Giridih'),(187,'Goalpara'),(188,'Godda'),(189,'Golaghat'),(190,'Gonda'),(191,'Gondiya'),(192,'Gopalganj'),(193,'Gorakhpur'),(194,'Gulbarga'),(195,'Gumla'),(196,'Guna'),(197,'Guntur'),(198,'Gurdaspur'),(199,'Gurgaon'),(200,'Gwalior'),(201,'Hailakandi'),(202,'Hamirpur'),(203,'Hanumangarh'),(204,'Harda'),(205,'Hardoi'),(206,'Haridwar'),(207,'Hassan'),(208,'Hathras'),(209,'Haveri'),(210,'Hazaribagh'),(211,'Hingoli'),(212,'Hissar'),(213,'Hooghly'),(214,'Hoshangabad'),(215,'Hoshiarpur'),(216,'Howrah'),(217,'Hyderabad'),(218,'Idukki'),(219,'Indore'),(220,'Jabalpur'),(221,'Jagatsinghpur'),(222,'Jaintia Hills'),(223,'Jaipur'),(224,'Jaisalmer'),(225,'Jajpur'),(226,'Jalandhar'),(227,'Jalaun'),(228,'Jalgaon'),(229,'Jalna'),(230,'Jalore'),(231,'Jalpaiguri'),(232,'Jammu'),(233,'Jamnagar'),(234,'Jamui'),(235,'Janjgir-Champa'),(236,'Jashpur'),(237,'Jaunpur'),(238,'Jehanabad'),(239,'Jhabua'),(240,'Jhajjar'),(241,'Jhalawar'),(242,'Jhansi'),(243,'Jharsuguda'),(244,'Jhunjhunun'),(245,'Jind'),(246,'Jodhpur'),(247,'Jorhat'),(248,'Junagadh'),(249,'Jyotiba Phule Nagar'),(250,'Kachchh'),(251,'Kaimur'),(252,'Kaithal'),(253,'Kalahandi'),(254,'Kamrup'),(255,'Kancheepuram'),(256,'Kandhamal'),(257,'Kangra'),(258,'Kanker'),(259,'Kannauj'),(260,'Kannur'),(261,'Kanpur'),(262,'Kanpur Dehat'),(263,'Kanyakumari'),(264,'Kapurthala'),(265,'Karaikal'),(266,'Karauli'),(267,'Karbi Anglong'),(268,'Kargil'),(269,'Karimganj'),(270,'Karimnagar'),(271,'Karnal'),(272,'Karur'),(582,'Kasaragod'),(273,'Kasargod'),(274,'Kathua'),(275,'Katihar'),(276,'Katni'),(277,'Kaushambi'),(278,'Kawardha'),(279,'Kendrapara'),(280,'Keonjhar'),(281,'Khagaria'),(282,'Khammam'),(283,'Kheda'),(284,'Khordha'),(285,'Kinnaur'),(286,'Kishanganj'),(287,'Koch Bihar'),(288,'Kodagu'),(289,'Koderma'),(290,'Kohima'),(291,'Kokrajhar'),(292,'Kolar'),(293,'Kolasib'),(294,'Kolhapur'),(295,'Kolkata'),(296,'Kollam'),(297,'Koppal'),(298,'Koraput'),(299,'Korba'),(300,'Koriya'),(301,'Kota'),(302,'Kottayam'),(303,'Kozhikode'),(304,'Krishna'),(305,'Kulu'),(306,'Kupwara'),(307,'Kurnool'),(308,'Kurukshetra'),(309,'Kushinagar'),(310,'Lahaul and Spiti'),(311,'Lakhimpur'),(312,'Lakhimpur Kheri'),(313,'Lakhisarai'),(314,'Lakshadweep'),(315,'Lalitpur'),(316,'Latur'),(317,'Lawngtlai'),(318,'Leh'),(319,'Lohardaga'),(320,'Lohit'),(321,'Lower Subansiri'),(322,'Lucknow'),(323,'Ludhiana'),(324,'Lunglei'),(325,'Madhepura'),(326,'Madhubani'),(327,'Madurai'),(330,'Mahabubnagar'),(328,'Maharajganj'),(329,'Mahasamund'),(331,'Mahe'),(332,'Mahendragarh'),(333,'Mahesana'),(334,'Mahoba'),(335,'Mainpuri'),(336,'Malappuram'),(337,'Malda'),(338,'Malkangiri'),(339,'Mamit'),(340,'Mandi'),(341,'Mandla'),(342,'Mandsaur'),(343,'Mandya'),(344,'Mansa'),(345,'Marigaon'),(346,'Mathura'),(347,'Maunathbhanjan'),(348,'Mayurbhanj'),(349,'Medak'),(350,'Meerut'),(351,'Midnapore'),(352,'Mirzapur'),(353,'Moga'),(354,'Mokokchung'),(355,'Mon'),(356,'Moradabad'),(357,'Morena'),(358,'Muktsar'),(359,'Mumbai City'),(360,'Mumbai Suburban'),(361,'Munger'),(362,'Murshidabad'),(363,'Muzaffarnagar'),(364,'Muzaffarpur'),(365,'Mysore'),(366,'Nabarangpur'),(367,'Nadia'),(368,'Nagaon'),(369,'Nagapattinam'),(370,'Nagaur'),(371,'Nagpur'),(372,'Nainital'),(373,'Nalanda'),(374,'Nalbari'),(375,'Nalgonda'),(376,'Namakkal'),(377,'Nanded'),(378,'Nandurbar'),(379,'Narmada'),(380,'Narsinghpur'),(381,'Nashik'),(382,'Navsari'),(383,'Nawada'),(384,'Nawan Shehar'),(385,'Nayagarh'),(386,'Neemuch'),(387,'Nellore'),(388,'Nicobar Islands'),(389,'Nilgiris'),(390,'Nizamabad'),(391,'North Cachar Hills'),(392,'North Goa'),(393,'North Sikkim'),(394,'North Tripura'),(395,'Nuapada'),(396,'Osmanabad'),(397,'Pakur'),(398,'Palakkad'),(399,'Palamu'),(400,'Pali'),(402,'Panch Mahals'),(401,'Panchkula'),(403,'Panipat'),(404,'Panna'),(405,'Papum Pare'),(406,'Parbhani'),(407,'Pashchim Champaran'),(408,'Pashchim Singhbhum'),(409,'Patan'),(410,'Pathanamthitta'),(411,'Patiala'),(412,'Patna'),(413,'Pauri Garhwal'),(414,'Perambalur'),(415,'Phek'),(416,'Pilibhit'),(417,'Pithoragarh'),(419,'Poonch'),(420,'Porbandar'),(421,'Prakasam'),(422,'Pratapgarh'),(418,'Puducherry'),(423,'Pudukkottai'),(424,'Pulwama'),(425,'Pune'),(426,'Purba Champaran'),(427,'Purba Singhbhum'),(428,'Puri'),(429,'Purnia'),(430,'Purulia'),(431,'Rae Bareli'),(432,'Raichur'),(433,'Raigarh'),(434,'Raipur'),(435,'Raisen'),(436,'Rajauri'),(437,'Rajgarh'),(438,'Rajkot'),(439,'Rajnandgaon'),(440,'Rajsamand'),(441,'Ramanathapuram'),(442,'Rampur'),(443,'Ranchi'),(444,'Rangareddi'),(445,'Ratlam'),(446,'Ratnagiri'),(447,'Rayagada'),(448,'Rewa'),(449,'Rewari'),(450,'Ri-Bhoi'),(451,'Rohtak'),(452,'Rohtas'),(453,'Rudra Prayag'),(454,'Rupnagar'),(455,'Sabar Kantha'),(456,'Sagar'),(457,'Saharanpur'),(458,'Saharsa'),(459,'Sahibganj'),(460,'Saiha'),(461,'Salem'),(462,'Samastipur'),(463,'Sambalpur'),(464,'Sangli'),(465,'Sangrur'),(466,'Sant Kabir Nagar'),(467,'Sant Ravi Das Nagar'),(468,'Saran'),(469,'Satara'),(470,'Satna'),(471,'Sawai Madhopur'),(472,'Sehore'),(473,'Senapati'),(474,'Seoni'),(475,'Serchhip'),(476,'Shahdol'),(477,'Shahjahanpur'),(478,'Shajapur'),(479,'Sheikhpura'),(480,'Sheohar'),(481,'Sheopur'),(482,'Shimla'),(483,'Shimoga'),(484,'Shivpuri'),(485,'Shravasti'),(486,'Sibsagar'),(487,'Siddharth Nagar'),(488,'Sidhi'),(489,'Sikar'),(490,'Sindhudurg'),(491,'Sirmaur'),(492,'Sirohi'),(493,'Sirsa'),(494,'Sitamarhi'),(495,'Sitapur'),(496,'Sivaganga'),(497,'Siwan'),(498,'Solan'),(499,'Solapur'),(500,'Sonbhadra'),(501,'Sonepat'),(502,'Sonepur'),(503,'Sonitpur'),(504,'South Garo Hills'),(505,'South Goa'),(506,'South Sikkim'),(507,'South Tripura'),(508,'Srikakulam'),(509,'Srinagar'),(510,'Sultanpur'),(511,'Sundargarh'),(512,'Supaul'),(513,'Surat'),(514,'Surendranagar'),(515,'Surguja'),(516,'Tamenglong'),(517,'Tawang'),(518,'Tehri Garhwal'),(519,'Thane'),(520,'Thanjavur'),(521,'The Dangs'),(522,'Theni'),(523,'Thiruvallur'),(524,'Thiruvananthapuram'),(525,'Thiruvarur'),(526,'Thoothukudi'),(527,'Thoubal'),(528,'Thrissur'),(529,'Tikamgarh'),(530,'Tinsukia'),(531,'Tirap'),(532,'Tiruchirappalli'),(533,'Tirunelveli'),(534,'Tiruvannamalai'),(535,'Tonk'),(536,'Tuensang'),(537,'Tumkur'),(540,'Udaipur'),(542,'Udham Singh Nagar'),(541,'Udhampur'),(543,'Udupi'),(544,'Ujjain'),(545,'Ukhrul'),(546,'Umaria'),(547,'Una'),(548,'Unnao'),(549,'Upper Siang'),(550,'Upper Subansiri'),(552,'Uttar Dinajpur'),(551,'Uttara Kannada'),(553,'Uttarkashi'),(554,'Vadodara'),(555,'Vaishali'),(556,'Valsad'),(557,'Varanasi'),(558,'Vellore'),(559,'Vidisha'),(560,'Villupuram'),(561,'Virudhunagar'),(562,'Vishakhapatnam'),(563,'Vizianagaram'),(564,'Warangal'),(565,'Wardha'),(566,'Washim'),(567,'Wayanad'),(568,'West Garo Hills'),(569,'West Godavari'),(570,'West Imphal'),(571,'West Kameng'),(572,'West Khasi Hills'),(573,'West Nimar'),(574,'West Siang'),(575,'West Sikkim'),(576,'West Tripura'),(577,'Wokha'),(578,'Yamuna Nagar'),(587,'Yamunanagar'),(579,'Yanam'),(580,'Yavatmal'),(581,'Zunheboto');
/*!40000 ALTER TABLE `districts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `invoiceNumber` varchar(32) NOT NULL,
  `subscriptionId` int(15) DEFAULT NULL,
  `invoiceCreationDate` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
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
  `country` int(11) NOT NULL DEFAULT '0',
  `state` int(11) DEFAULT '0',
  `district` int(11) DEFAULT '0',
  `city` int(11) NOT NULL DEFAULT '0',
  `pincode` int(11) DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `institution` varchar(64) DEFAULT NULL,
  `department` varchar(64) DEFAULT NULL,
  `inwardCreationDate` date NOT NULL,
  `subscriberId` int(15) unsigned DEFAULT NULL,
  `inwardPurpose` int(11) NOT NULL,
  `paymentMode` int(11) DEFAULT NULL,
  `chqddNumber` int(11) DEFAULT NULL,
  `paymentDate` date DEFAULT NULL,
  `amount` float DEFAULT '0',
  `currency` int(11) DEFAULT NULL,
  `chequeDDReturn` tinyint(1) NOT NULL DEFAULT '0',
  `chequeDDReturnReason` int(11) unsigned DEFAULT NULL,
  `chequeDDReturnReasonOther` varchar(64) DEFAULT NULL,
  `receiptNumber` int(11) DEFAULT NULL,
  `ackDate` date DEFAULT NULL,
  `remarks` text,
  `bankName` varchar(64) DEFAULT NULL,
  `returnDate` date DEFAULT NULL,
  `completed` tinyint(4) NOT NULL DEFAULT '0',
  `language` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `inward_no_UNIQUE` (`inwardNumber`),
  KEY `city` (`city`),
  KEY `inwardCreationDate` (`inwardCreationDate`),
  KEY `inwardPurpose` (`inwardPurpose`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inward`
--

LOCK TABLES `inward` WRITE;
/*!40000 ALTER TABLE `inward` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inward_purpose`
--

LOCK TABLES `inward_purpose` WRITE;
/*!40000 ALTER TABLE `inward_purpose` DISABLE KEYS */;
INSERT INTO `inward_purpose` VALUES (3,'Address Change'),(7,'Advertisement'),(8,'Manuscript'),(5,'Missing Issue'),(1,'New Subscription'),(9,'Others'),(10,'Payment'),(2,'Renew Subscription'),(6,'Reprint'),(4,'Request For Invoice');
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
-- Table structure for table `issues`
--

DROP TABLE IF EXISTS `issues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issues` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `issueNumber` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issues`
--

LOCK TABLES `issues` WRITE;
/*!40000 ALTER TABLE `issues` DISABLE KEYS */;
INSERT INTO `issues` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),(11,11),(12,12),(13,13),(14,14),(15,15),(16,16),(17,17),(18,18),(19,19),(20,20),(21,21),(22,22),(23,23),(24,24);
/*!40000 ALTER TABLE `issues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journal_group_contents`
--

DROP TABLE IF EXISTS `journal_group_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journal_group_contents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `journalGroupId` int(11) NOT NULL,
  `journalId` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal_group_contents`
--

LOCK TABLES `journal_group_contents` WRITE;
/*!40000 ALTER TABLE `journal_group_contents` DISABLE KEYS */;
INSERT INTO `journal_group_contents` VALUES (1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,5,5),(6,6,6),(7,7,7),(8,8,8),(9,9,9),(10,10,10),(11,11,11),(12,12,1),(13,12,2),(14,12,3),(15,12,4),(16,12,5),(17,12,6),(18,12,7),(19,12,8),(20,12,9),(21,12,10),(22,12,11),(23,13,1),(24,13,2),(25,13,3),(26,13,4),(27,13,5),(28,13,6),(29,13,7),(30,13,8),(31,13,9),(32,13,10);
/*!40000 ALTER TABLE `journal_group_contents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journal_groups`
--

DROP TABLE IF EXISTS `journal_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journal_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `journalGroupName` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal_groups`
--

LOCK TABLES `journal_groups` WRITE;
/*!40000 ALTER TABLE `journal_groups` DISABLE KEYS */;
INSERT INTO `journal_groups` VALUES (1,'Pramana - Journal of Physics'),(2,'Journal of Astrophysics and Astronomy'),(3,'Proceedings (Mathematical Sciences)'),(4,'Journal of Earth System Science (formerly Proc. Earth Planet Sci.)'),(5,'Journal of Chemical Sciences (formerly Proc. Chemical Sci.)'),(6,'Bulletin of Materials Science'),(7,'Sadhana (Engineering Sciences)'),(8,'Journal of Biosciences'),(9,'Journal of Genetics'),(10,'Resonanace - Journal of Science Education'),(11,'Current Science'),(12,'1-11 All Journals'),(13,'1-10 Journals');
/*!40000 ALTER TABLE `journal_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journals`
--

DROP TABLE IF EXISTS `journals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `journalCode` varchar(4) NOT NULL,
  `journalName` varchar(128) NOT NULL,
  `issnNo` text NOT NULL,
  `pages` int(11) NOT NULL DEFAULT '0',
  `startYear` int(11) DEFAULT NULL,
  `issues` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`,`journalName`,`journalCode`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journals`
--

LOCK TABLES `journals` WRITE;
/*!40000 ALTER TABLE `journals` DISABLE KEYS */;
INSERT INTO `journals` VALUES (1,'P','Pramana - Journal of Physics','0304-4289',1800,1987,12),(2,'JAA','Journal of Astrophysics and Astronomy','0250-6335',400,1234,4),(3,'MS','Proceedings (Mathematical Sciences)','0253-4142',400,2010,4),(4,'EPS','Journal of Earth System Science (formerly Proc. Earth Planet Sci.)','0253-4126',600,1991,6),(5,'CS','Journal of Chemical Sciences (formerly Proc. Chemical Sci.)','0253-4134',600,2000,6),(6,'BMS','Bulletin of Materials Science','0250-4707',600,1995,6),(7,'S','Sadhana (Engineering Sciences)','0256-2499',600,1980,6),(8,'JB','Journal of Biosciences','0250-5991',500,2010,4),(9,'JG','Journal of Genetics','0022-1333',400,2011,3),(10,'RES','Resonanace - Journal of Science Education','0971-8044',1200,2000,12),(11,'CURR','Current Science','0011-3891',3000,2000,24);
/*!40000 ALTER TABLE `journals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `languages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES (1,'English'),(2,'Hindi'),(3,'Others');
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mailing_list`
--

DROP TABLE IF EXISTS `mailing_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mailing_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `journalId` int(11) NOT NULL,
  `issue` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `month` int(11) NOT NULL,
  `mlDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mailing_list`
--

LOCK TABLES `mailing_list` WRITE;
/*!40000 ALTER TABLE `mailing_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `mailing_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mailing_list_detail`
--

DROP TABLE IF EXISTS `mailing_list_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mailing_list_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mailinglistId` int(11) NOT NULL,
  `subscriberId` int(10) unsigned NOT NULL,
  `subscriptionId` int(11) NOT NULL,
  `subscriptionDetailId` int(11) NOT NULL,
  `journalId` int(11) NOT NULL,
  `journalCode` varchar(4) NOT NULL,
  `subtypecode` char(5) NOT NULL,
  `subscriberNumber` varchar(20) NOT NULL,
  `subscriberName` varchar(64) NOT NULL,
  `department` varchar(64) DEFAULT NULL,
  `institution` varchar(64) DEFAULT NULL,
  `address` varchar(64) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `district` varchar(64) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL,
  `pincode` int(11) DEFAULT NULL,
  `copies` int(11) NOT NULL DEFAULT '0',
  `startYear` int(11) DEFAULT NULL,
  `startMonth` int(11) DEFAULT NULL,
  `endYear` int(11) DEFAULT NULL,
  `issue` int(11) NOT NULL,
  `endMonth` int(11) DEFAULT NULL,
  `month` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `bilid` int(11) DEFAULT NULL,
  `miId` int(11) DEFAULT NULL,
  `bildate` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mailing_list_detail`
--

LOCK TABLES `mailing_list_detail` WRITE;
/*!40000 ALTER TABLE `mailing_list_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `mailing_list_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `missing_issue`
--

DROP TABLE IF EXISTS `missing_issue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `missing_issue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inwardId` int(11) NOT NULL,
  `subscriberId` int(11) NOT NULL,
  `msEntryDate` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `subscriber_id_index` (`subscriberId`),
  KEY `inward_id_index` (`inwardId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `missing_issue`
--

LOCK TABLES `missing_issue` WRITE;
/*!40000 ALTER TABLE `missing_issue` DISABLE KEYS */;
/*!40000 ALTER TABLE `missing_issue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `missing_issue_journals`
--

DROP TABLE IF EXISTS `missing_issue_journals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `missing_issue_journals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `missingissueId` int(11) NOT NULL,
  `subscriptiondetailId` int(11) NOT NULL,
  `journalGroupId` int(11) NOT NULL,
  `journalId` int(11) NOT NULL,
  `month` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `missingCopies` int(11) NOT NULL,
  `action` char(1) DEFAULT NULL,
  `sentOn` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `foreign_key_index` (`missingissueId`),
  KEY `journal_id_index` (`journalId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `missing_issue_journals`
--

LOCK TABLES `missing_issue_journals` WRITE;
/*!40000 ALTER TABLE `missing_issue_journals` DISABLE KEYS */;
/*!40000 ALTER TABLE `missing_issue_journals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `months`
--

DROP TABLE IF EXISTS `months`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `months` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `month` char(10) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `months`
--

LOCK TABLES `months` WRITE;
/*!40000 ALTER TABLE `months` DISABLE KEYS */;
INSERT INTO `months` VALUES (1,'January'),(2,'February'),(3,'March'),(4,'April'),(5,'May'),(6,'June'),(7,'July'),(8,'August'),(9,'September'),(10,'October'),(11,'November'),(12,'December');
/*!40000 ALTER TABLE `months` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inwardID` int(11) NOT NULL,
  `subscriptionID` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_inward` (`inwardID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Save the relation between different inwards and a subscription. Subscriber can pay multiple times for the same subscription';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_mode`
--

LOCK TABLES `payment_mode` WRITE;
/*!40000 ALTER TABLE `payment_mode` DISABLE KEYS */;
INSERT INTO `payment_mode` VALUES (5,'Bank Transfer'),(4,'Cash'),(1,'Cheque'),(2,'Demand Draft'),(3,'Money Order');
/*!40000 ALTER TABLE `payment_mode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `print_order`
--

DROP TABLE IF EXISTS `print_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `print_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `year` int(11) NOT NULL,
  `journalId` int(11) NOT NULL,
  `issueNo` int(11) NOT NULL,
  `printOrder` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `print_order`
--

LOCK TABLES `print_order` WRITE;
/*!40000 ALTER TABLE `print_order` DISABLE KEYS */;
INSERT INTO `print_order` VALUES (1,2012,1,1,1000),(2,2012,1,2,2000),(3,2012,1,3,3000),(4,2012,1,4,5000),(5,2012,2,1,200),(6,2012,7,1,120),(7,2012,7,2,200);
/*!40000 ALTER TABLE `print_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reminder_details`
--

DROP TABLE IF EXISTS `reminder_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reminder_details` (
  `id` int(11) NOT NULL DEFAULT '0',
  `reminderId` int(11) NOT NULL,
  `medium` int(11) NOT NULL,
  `language` int(11) NOT NULL,
  `sent_date` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reminder_details`
--

LOCK TABLES `reminder_details` WRITE;
/*!40000 ALTER TABLE `reminder_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `reminder_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reminders`
--

DROP TABLE IF EXISTS `reminders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reminders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subscriptionId` int(11) NOT NULL,
  `balance` double NOT NULL,
  `reminderType` int(11) NOT NULL,
  `reminderDate` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `subscriptionId` (`subscriptionId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reminders`
--

LOCK TABLES `reminders` WRITE;
/*!40000 ALTER TABLE `reminders` DISABLE KEYS */;
/*!40000 ALTER TABLE `reminders` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `states`
--

LOCK TABLES `states` WRITE;
/*!40000 ALTER TABLE `states` DISABLE KEYS */;
INSERT INTO `states` VALUES (32,'Andaman & Nicobar'),(1,'Andhra Pradesh'),(2,'Arunachal Pradesh'),(3,'Assam'),(4,'Bihar'),(5,'Chandigarh'),(6,'Chattisgarh'),(33,'Daman & Diu'),(7,'Goa'),(8,'Gujarat'),(9,'Haryana'),(10,'Himachal Pradesh'),(11,'Jammu & Kashmir'),(12,'Jharkhand'),(13,'Karnataka'),(14,'Kerala'),(34,'Lakshadweep'),(15,'Madhya Pradesh'),(16,'Maharashtra'),(17,'Manipur'),(18,'Meghalaya'),(19,'Mizoram'),(20,'Nagaland'),(21,'New Delhi'),(22,'Odisha'),(23,'Pondicherry'),(24,'Punjab'),(25,'Rajasthan'),(26,'Sikkim'),(27,'Tamil Nadu'),(28,'Tripura'),(29,'Uttar Pradesh'),(30,'Uttarakhand'),(31,'West Bengal');
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
  `subscriberNumber` varchar(12) NOT NULL,
  `subscriberCreationDate` date NOT NULL DEFAULT '0000-00-00',
  `subscriberName` varchar(64) NOT NULL,
  `department` varchar(64) DEFAULT NULL,
  `institution` varchar(64) DEFAULT NULL,
  `shippingAddress` varchar(128) NOT NULL,
  `invoiceAddress` varchar(128) NOT NULL,
  `city` int(11) NOT NULL DEFAULT '0',
  `district` int(11) DEFAULT NULL,
  `state` int(11) NOT NULL DEFAULT '0',
  `country` int(11) NOT NULL DEFAULT '0',
  `pincode` varchar(45) DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `subtype` int(11) unsigned NOT NULL DEFAULT '0',
  `agent` int(11) DEFAULT NULL,
  `deactive` tinyint(1) NOT NULL DEFAULT '0',
  `deactivationDate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subscriber_id_UNIQUE` (`subscriberNumber`) USING BTREE,
  KEY `subscriberName` (`subscriberName`),
  KEY `subscriberCity` (`city`),
  KEY `subscriberPincode` (`pincode`),
  KEY `department` (`department`,`institution`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriber`
--

LOCK TABLES `subscriber` WRITE;
/*!40000 ALTER TABLE `subscriber` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscriber` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `jds`.`setDeactivationDate` BEFORE UPDATE







    ON jds.subscriber FOR EACH ROW







BEGIN















    IF new.deactive = True THEN















      SET new.deactivationDate = CURRENT_DATE;















    ELSE















      SET new.deactivationDate = NULL;















    END IF;















END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `subscriber_type`
--

DROP TABLE IF EXISTS `subscriber_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscriber_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subtypecode` char(6) NOT NULL,
  `subtypedesc` char(64) NOT NULL,
  `subtype` char(32) NOT NULL,
  `nationality` char(1) NOT NULL,
  `institutional` char(1) NOT NULL,
  `freejrnl` int(8) DEFAULT NULL,
  `discount` float(8,3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_UNIQUE` (`subtypecode`,`subtypedesc`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriber_type`
--

LOCK TABLES `subscriber_type` WRITE;
/*!40000 ALTER TABLE `subscriber_type` DISABLE KEYS */;
INSERT INTO `subscriber_type` VALUES (1,'FELJM','Fellows','Free','I','P',2,0.000),(2,'AS','Associate','Free','I','P',2,0.000),(3,'EBALL','Editorial Board Member','Free','I','P',1,0.000),(4,'EI','Indian Exchange','Free','I','I',0,0.000),(5,'EF','Foreign Exchange','Free','F','I',0,0.000),(6,'GRANT','Grant','Free','I','P',2,0.000),(7,'AUTH','AUTHOR','Free','I','P',1,0.000),(8,'II','Indian Universities and Institutions','Paid','I','I',0,0.000),(9,'IC','Indian Schools and Colleges','Paid','I','I',0,0.000),(10,'IN','Industry Corporates','Paid','I','I',0,0.000),(11,'IP','Indian Personnel','Paid','I','P',0,0.000),(12,'FP','Foreign Personnel','Paid','F','P',0,0.000),(13,'FI','Foreign Institutions','Paid','F','I',0,0.000),(14,'SF','Summer Fellows','Free','I','P',1,0.000),(15,'KVPY','Kishore Vaigyanik Protsahan Yojana','Paid','I','I',0,0.000),(16,'HONFEL','Honorary Fellow','Free','I','P',0,0.000);
/*!40000 ALTER TABLE `subscriber_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription`
--

DROP TABLE IF EXISTS `subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscription` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subscriberID` int(11) NOT NULL,
  `inwardID` int(11) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `subscriptionDate` date NOT NULL DEFAULT '0000-00-00',
  `legacy` tinyint(4) NOT NULL DEFAULT '0',
  `legacy_amount` float NOT NULL DEFAULT '0',
  `legacy_balance` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `subscription_idx_1` (`subscriberID`) USING BTREE,
  KEY `subscription_idx_4` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription`
--

LOCK TABLES `subscription` WRITE;
/*!40000 ALTER TABLE `subscription` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription_rates`
--

DROP TABLE IF EXISTS `subscription_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscription_rates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `journalGroupId` int(11) NOT NULL,
  `subtypeId` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `period` int(11) NOT NULL,
  `rate` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=550 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription_rates`
--

LOCK TABLES `subscription_rates` WRITE;
/*!40000 ALTER TABLE `subscription_rates` DISABLE KEYS */;
INSERT INTO `subscription_rates` VALUES (1,0,0,0,0,0),(2,11,10,2012,1,10000),(3,1,8,2012,1,750),(4,2,8,2012,1,300),(5,3,8,2012,1,300),(6,4,8,2012,1,400),(7,5,8,2012,1,400),(8,6,8,2012,1,400),(9,7,8,2012,1,400),(10,8,8,2012,1,400),(11,9,8,2012,1,300),(12,10,8,2012,1,500),(13,11,8,2012,1,4000),(14,12,8,2012,1,7000),(15,13,8,2012,1,3300),(16,10,8,2012,2,900),(17,10,8,2012,3,1300),(18,10,8,2012,5,2000),(19,11,8,2012,2,7500),(20,11,8,2012,3,10000),(21,11,8,2012,5,16000),(22,1,9,2012,1,750),(23,2,9,2012,1,300),(24,3,9,2012,1,300),(25,4,9,2012,1,400),(26,5,9,2012,1,400),(27,6,9,2012,1,400),(28,7,9,2012,1,400),(29,8,9,2012,1,400),(30,9,9,2012,1,300),(31,10,9,2012,1,500),(32,11,9,2012,1,1500),(33,12,9,2012,1,4800),(34,13,9,2012,1,3300),(35,10,9,2012,2,900),(36,10,9,2012,3,1300),(37,10,9,2012,5,2000),(38,11,9,2012,2,2250),(39,11,9,2012,3,3500),(40,11,9,2012,5,6000),(41,1,11,2012,2,700),(42,2,11,2012,2,400),(43,3,11,2012,2,400),(44,4,11,2012,2,500),(45,5,11,2012,2,500),(46,6,11,2012,2,500),(47,7,11,2012,2,500),(48,8,11,2012,2,500),(49,9,11,2012,2,400),(50,10,11,2012,2,400),(51,11,11,2012,2,1250),(52,10,11,2012,3,650),(53,10,11,2012,5,1010),(54,11,11,2012,3,1750),(55,11,11,2012,5,3000),(56,1,1,2012,1,0),(57,2,1,2012,1,0),(58,3,1,2012,1,0),(59,4,1,2012,1,0),(60,5,1,2012,1,0),(61,6,1,2012,1,0),(62,7,1,2012,1,0),(63,8,1,2012,1,0),(64,9,1,2012,1,0),(65,10,1,2012,1,0),(66,11,1,2012,1,0),(67,1,2,2012,1,0),(68,2,2,2012,1,0),(69,3,2,2012,1,0),(70,4,2,2012,1,0),(71,5,2,2012,1,0),(72,6,2,2012,1,0),(73,7,2,2012,1,0),(74,8,2,2012,1,0),(75,9,2,2012,1,0),(76,10,2,2012,1,0),(77,11,2,2012,1,0),(78,1,3,2012,1,0),(79,2,3,2012,1,0),(80,3,3,2012,1,0),(81,4,3,2012,1,0),(82,5,3,2012,1,0),(83,6,3,2012,1,0),(84,7,3,2012,1,0),(85,8,3,2012,1,0),(86,9,3,2012,1,0),(87,10,3,2012,1,0),(88,11,3,2012,1,0),(89,1,4,2012,1,0),(90,2,4,2012,1,0),(91,3,4,2012,1,0),(92,4,4,2012,1,0),(93,5,4,2012,1,0),(94,6,4,2012,1,0),(95,7,4,2012,1,0),(96,8,4,2012,1,0),(97,9,4,2012,1,0),(98,10,4,2012,1,0),(99,11,4,2012,1,0),(100,1,5,2012,1,0),(101,2,5,2012,1,0),(102,3,5,2012,1,0),(103,4,5,2012,1,0),(104,5,5,2012,1,0),(105,6,5,2012,1,0),(106,7,5,2012,1,0),(107,8,5,2012,1,0),(108,9,5,2012,1,0),(109,10,5,2012,1,0),(110,11,5,2012,1,0),(111,1,6,2012,1,0),(112,2,6,2012,1,0),(113,3,6,2012,1,0),(114,4,6,2012,1,0),(115,5,6,2012,1,0),(116,6,6,2012,1,0),(117,7,6,2012,1,0),(118,8,6,2012,1,0),(119,9,6,2012,1,0),(120,10,6,2012,1,0),(121,11,6,2012,1,0),(122,1,7,2012,1,0),(123,2,7,2012,1,0),(124,3,7,2012,1,0),(125,4,7,2012,1,0),(126,5,7,2012,1,0),(127,6,7,2012,1,0),(128,7,7,2012,1,0),(129,8,7,2012,1,0),(130,9,7,2012,1,0),(131,10,7,2012,1,0),(132,11,7,2012,1,0),(133,1,14,2012,1,0),(134,2,14,2012,1,0),(135,3,14,2012,1,0),(136,4,14,2012,1,0),(137,5,14,2012,1,0),(138,6,14,2012,1,0),(139,7,14,2012,1,0),(140,8,14,2012,1,0),(141,9,14,2012,1,0),(142,10,14,2012,1,0),(143,11,14,2012,1,0),(144,1,8,2011,1,750),(145,2,8,2011,1,300),(146,3,8,2011,1,300),(147,4,8,2011,1,400),(148,5,8,2011,1,400),(149,6,8,2011,1,400),(150,7,8,2011,1,400),(151,8,8,2011,1,400),(152,9,8,2011,1,300),(153,10,8,2011,1,500),(154,11,8,2011,1,4000),(155,12,8,2011,1,6000),(156,13,8,2011,1,3300),(157,10,8,2011,2,900),(158,10,8,2011,3,1300),(159,10,8,2011,5,2000),(160,11,8,2011,2,5400),(161,11,8,2011,3,8000),(162,11,8,2011,5,12000),(163,1,9,2011,1,750),(164,2,9,2011,1,300),(165,3,9,2011,1,300),(166,4,9,2011,1,400),(167,5,9,2011,1,400),(168,6,9,2011,1,400),(169,7,9,2011,1,400),(170,8,9,2011,1,400),(171,9,9,2011,1,300),(172,10,9,2011,1,500),(173,11,9,2011,1,1500),(174,12,9,2011,1,4200),(175,13,9,2011,1,3300),(176,10,9,2011,2,900),(177,10,9,2011,3,1300),(178,10,9,2011,5,2000),(179,11,9,2011,2,1750),(180,11,9,2011,3,2500),(181,11,9,2011,5,4500),(182,1,11,2011,2,700),(183,2,11,2011,2,400),(184,3,11,2011,2,400),(185,4,11,2011,2,500),(186,5,11,2011,2,500),(187,6,11,2011,2,500),(188,7,11,2011,2,500),(189,8,11,2011,2,500),(190,9,11,2011,2,400),(191,10,11,2011,2,400),(192,11,11,2011,2,1250),(193,10,11,2011,3,650),(194,10,11,2011,5,1010),(195,11,11,2011,3,1600),(196,11,11,2011,5,2700),(197,1,1,2011,1,0),(198,2,1,2011,1,0),(199,3,1,2011,1,0),(200,4,1,2011,1,0),(201,5,1,2011,1,0),(202,6,1,2011,1,0),(203,7,1,2011,1,0),(204,8,1,2011,1,0),(205,9,1,2011,1,0),(206,10,1,2011,1,0),(207,11,1,2011,1,0),(208,1,2,2011,1,0),(209,2,2,2011,1,0),(210,3,2,2011,1,0),(211,4,2,2011,1,0),(212,5,2,2011,1,0),(213,6,2,2011,1,0),(214,7,2,2011,1,0),(215,8,2,2011,1,0),(216,9,2,2011,1,0),(217,10,2,2011,1,0),(218,11,2,2011,1,0),(219,1,3,2011,1,0),(220,2,3,2011,1,0),(221,3,3,2011,1,0),(222,4,3,2011,1,0),(223,5,3,2011,1,0),(224,6,3,2011,1,0),(225,7,3,2011,1,0),(226,8,3,2011,1,0),(227,9,3,2011,1,0),(228,10,3,2011,1,0),(229,11,3,2011,1,0),(230,1,4,2011,1,0),(231,2,4,2011,1,0),(232,3,4,2011,1,0),(233,4,4,2011,1,0),(234,5,4,2011,1,0),(235,6,4,2011,1,0),(236,7,4,2011,1,0),(237,8,4,2011,1,0),(238,9,4,2011,1,0),(239,10,4,2011,1,0),(240,11,4,2011,1,0),(241,1,5,2011,1,0),(242,2,5,2011,1,0),(243,3,5,2011,1,0),(244,4,5,2011,1,0),(245,5,5,2011,1,0),(246,6,5,2011,1,0),(247,7,5,2011,1,0),(248,8,5,2011,1,0),(249,9,5,2011,1,0),(250,10,5,2011,1,0),(251,11,5,2011,1,0),(252,1,6,2011,1,0),(253,2,6,2011,1,0),(254,3,6,2011,1,0),(255,4,6,2011,1,0),(256,5,6,2011,1,0),(257,6,6,2011,1,0),(258,7,6,2011,1,0),(259,8,6,2011,1,0),(260,9,6,2011,1,0),(261,10,6,2011,1,0),(262,11,6,2011,1,0),(263,1,7,2011,1,0),(264,2,7,2011,1,0),(265,3,7,2011,1,0),(266,4,7,2011,1,0),(267,5,7,2011,1,0),(268,6,7,2011,1,0),(269,7,7,2011,1,0),(270,8,7,2011,1,0),(271,9,7,2011,1,0),(272,10,7,2011,1,0),(273,11,7,2011,1,0),(274,1,14,2011,1,0),(275,2,14,2011,1,0),(276,3,14,2011,1,0),(277,4,14,2011,1,0),(278,5,14,2011,1,0),(279,6,14,2011,1,0),(280,7,14,2011,1,0),(281,8,14,2011,1,0),(282,9,14,2011,1,0),(283,10,14,2011,1,0),(284,11,14,2011,1,0),(285,1,8,2010,1,750),(286,2,8,2010,1,300),(287,3,8,2010,1,300),(288,4,8,2010,1,400),(289,5,8,2010,1,400),(290,6,8,2010,1,400),(291,7,8,2010,1,400),(292,8,8,2010,1,400),(293,9,8,2010,1,300),(294,10,8,2010,1,500),(295,11,8,2010,1,4000),(296,12,8,2010,1,6000),(297,13,8,2010,1,3300),(298,10,8,2010,2,900),(299,10,8,2010,3,1300),(300,10,8,2010,5,2000),(301,11,8,2010,2,5400),(302,11,8,2010,3,8000),(303,11,8,2010,5,12000),(304,1,9,2010,1,750),(305,2,9,2010,1,300),(306,3,9,2010,1,300),(307,4,9,2010,1,400),(308,5,9,2010,1,400),(309,6,9,2010,1,400),(310,7,9,2010,1,400),(311,8,9,2010,1,400),(312,9,9,2010,1,300),(313,10,9,2010,1,500),(314,11,9,2010,1,1500),(315,12,9,2010,1,4200),(316,13,9,2010,1,3300),(317,10,9,2010,2,900),(318,10,9,2010,3,1300),(319,10,9,2010,5,2000),(320,11,9,2010,2,1750),(321,11,9,2010,3,2500),(322,11,9,2010,5,4500),(323,1,11,2010,2,700),(324,2,11,2010,2,400),(325,3,11,2010,2,400),(326,4,11,2010,2,500),(327,5,11,2010,2,500),(328,6,11,2010,2,500),(329,7,11,2010,2,500),(330,8,11,2010,2,500),(331,9,11,2010,2,400),(332,10,11,2010,2,400),(333,11,11,2010,2,1250),(334,10,11,2010,3,650),(335,10,11,2010,5,1010),(336,11,11,2010,3,1600),(337,11,11,2010,5,2700),(338,1,1,2010,1,0),(339,2,1,2010,1,0),(340,3,1,2010,1,0),(341,4,1,2010,1,0),(342,5,1,2010,1,0),(343,6,1,2010,1,0),(344,7,1,2010,1,0),(345,8,1,2010,1,0),(346,9,1,2010,1,0),(347,10,1,2010,1,0),(348,11,1,2010,1,0),(349,1,2,2010,1,0),(350,2,2,2010,1,0),(351,3,2,2010,1,0),(352,4,2,2010,1,0),(353,5,2,2010,1,0),(354,6,2,2010,1,0),(355,7,2,2010,1,0),(356,8,2,2010,1,0),(357,9,2,2010,1,0),(358,10,2,2010,1,0),(359,11,2,2010,1,0),(360,1,3,2010,1,0),(361,2,3,2010,1,0),(362,3,3,2010,1,0),(363,4,3,2010,1,0),(364,5,3,2010,1,0),(365,6,3,2010,1,0),(366,7,3,2010,1,0),(367,8,3,2010,1,0),(368,9,3,2010,1,0),(369,10,3,2010,1,0),(370,11,3,2010,1,0),(371,1,4,2010,1,0),(372,2,4,2010,1,0),(373,3,4,2010,1,0),(374,4,4,2010,1,0),(375,5,4,2010,1,0),(376,6,4,2010,1,0),(377,7,4,2010,1,0),(378,8,4,2010,1,0),(379,9,4,2010,1,0),(380,10,4,2010,1,0),(381,11,4,2010,1,0),(382,1,5,2010,1,0),(383,2,5,2010,1,0),(384,3,5,2010,1,0),(385,4,5,2010,1,0),(386,5,5,2010,1,0),(387,6,5,2010,1,0),(388,7,5,2010,1,0),(389,8,5,2010,1,0),(390,9,5,2010,1,0),(391,10,5,2010,1,0),(392,11,5,2010,1,0),(393,1,6,2010,1,0),(394,2,6,2010,1,0),(395,3,6,2010,1,0),(396,4,6,2010,1,0),(397,5,6,2010,1,0),(398,6,6,2010,1,0),(399,7,6,2010,1,0),(400,8,6,2010,1,0),(401,9,6,2010,1,0),(402,10,6,2010,1,0),(403,11,6,2010,1,0),(404,1,7,2010,1,0),(405,2,7,2010,1,0),(406,3,7,2010,1,0),(407,4,7,2010,1,0),(408,5,7,2010,1,0),(409,6,7,2010,1,0),(410,7,7,2010,1,0),(411,8,7,2010,1,0),(412,9,7,2010,1,0),(413,10,7,2010,1,0),(414,11,7,2010,1,0),(415,1,14,2010,1,0),(416,2,14,2010,1,0),(417,3,14,2010,1,0),(418,4,14,2010,1,0),(419,5,14,2010,1,0),(420,6,14,2010,1,0),(421,7,14,2010,1,0),(422,8,14,2010,1,0),(423,9,14,2010,1,0),(424,10,14,2010,1,0),(425,11,14,2010,1,0),(426,11,10,2009,1,4000),(427,1,11,2009,2,600),(428,2,11,2009,2,350),(429,3,11,2009,2,350),(430,4,11,2009,2,400),(431,5,11,2009,2,400),(432,6,11,2009,2,400),(433,7,11,2009,2,400),(434,8,11,2009,2,350),(435,9,11,2009,2,350),(436,10,11,2009,2,350),(437,11,11,2009,2,900),(438,1,8,2009,1,500),(439,2,8,2009,1,250),(440,3,8,2009,1,250),(441,4,8,2009,1,300),(442,5,8,2009,1,300),(443,6,8,2009,1,300),(444,7,8,2009,1,300),(445,8,8,2009,1,250),(446,9,8,2009,1,250),(447,10,8,2009,1,400),(448,11,8,2009,1,2000),(449,12,8,2009,1,4300),(450,1,9,2009,1,500),(451,2,9,2009,1,250),(452,3,9,2009,1,250),(453,4,9,2009,1,300),(454,5,9,2009,1,300),(455,6,9,2009,1,300),(456,7,9,2009,1,300),(457,8,9,2009,1,250),(458,9,9,2009,1,250),(459,10,9,2009,1,400),(460,11,9,2009,1,750),(461,12,9,2009,1,3200),(462,1,1,2009,1,0),(463,2,1,2009,1,0),(464,3,1,2009,1,0),(465,4,1,2009,1,0),(466,5,1,2009,1,0),(467,6,1,2009,1,0),(468,7,1,2009,1,0),(469,8,1,2009,1,0),(470,9,1,2009,1,0),(471,10,1,2009,1,0),(472,11,1,2009,1,0),(473,1,2,2009,1,0),(474,2,2,2009,1,0),(475,3,2,2009,1,0),(476,4,2,2009,1,0),(477,5,2,2009,1,0),(478,6,2,2009,1,0),(479,7,2,2009,1,0),(480,8,2,2009,1,0),(481,9,2,2009,1,0),(482,10,2,2009,1,0),(483,11,2,2009,1,0),(484,1,3,2009,1,0),(485,2,3,2009,1,0),(486,3,3,2009,1,0),(487,4,3,2009,1,0),(488,5,3,2009,1,0),(489,6,3,2009,1,0),(490,7,3,2009,1,0),(491,8,3,2009,1,0),(492,9,3,2009,1,0),(493,10,3,2009,1,0),(494,11,3,2009,1,0),(495,1,4,2009,1,0),(496,2,4,2009,1,0),(497,3,4,2009,1,0),(498,4,4,2009,1,0),(499,5,4,2009,1,0),(500,6,4,2009,1,0),(501,7,4,2009,1,0),(502,8,4,2009,1,0),(503,9,4,2009,1,0),(504,10,4,2009,1,0),(505,11,4,2009,1,0),(506,1,5,2009,1,0),(507,2,5,2009,1,0),(508,3,5,2009,1,0),(509,4,5,2009,1,0),(510,5,5,2009,1,0),(511,6,5,2009,1,0),(512,7,5,2009,1,0),(513,8,5,2009,1,0),(514,9,5,2009,1,0),(515,10,5,2009,1,0),(516,11,5,2009,1,0),(517,1,6,2009,1,0),(518,2,6,2009,1,0),(519,3,6,2009,1,0),(520,4,6,2009,1,0),(521,5,6,2009,1,0),(522,6,6,2009,1,0),(523,7,6,2009,1,0),(524,8,6,2009,1,0),(525,9,6,2009,1,0),(526,10,6,2009,1,0),(527,11,6,2009,1,0),(528,1,7,2009,1,0),(529,2,7,2009,1,0),(530,3,7,2009,1,0),(531,4,7,2009,1,0),(532,5,7,2009,1,0),(533,6,7,2009,1,0),(534,7,7,2009,1,0),(535,8,7,2009,1,0),(536,9,7,2009,1,0),(537,10,7,2009,1,0),(538,11,7,2009,1,0),(539,1,14,2009,1,0),(540,2,14,2009,1,0),(541,3,14,2009,1,0),(542,4,14,2009,1,0),(543,5,14,2009,1,0),(544,6,14,2009,1,0),(545,7,14,2009,1,0),(546,8,14,2009,1,0),(547,9,14,2009,1,0),(548,10,14,2009,1,0),(549,11,14,2009,1,0);
/*!40000 ALTER TABLE `subscription_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriptiondetails`
--

DROP TABLE IF EXISTS `subscriptiondetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscriptiondetails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subscriptionID` int(11) NOT NULL,
  `journalGroupID` int(11) NOT NULL,
  `copies` int(11) NOT NULL DEFAULT '0',
  `startYear` int(11) NOT NULL,
  `startMonth` int(11) NOT NULL,
  `endMonth` int(11) NOT NULL DEFAULT '0',
  `endYear` int(11) NOT NULL,
  `active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `journalPriceGroupID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_subscription` (`subscriptionID`,`journalGroupID`),
  KEY `startYear` (`startYear`),
  KEY `endYear` (`endYear`),
  CONSTRAINT `subscription_fk` FOREIGN KEY (`subscriptionID`) REFERENCES `subscription` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriptiondetails`
--

LOCK TABLES `subscriptiondetails` WRITE;
/*!40000 ALTER TABLE `subscriptiondetails` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscriptiondetails` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `jds`.`add_back_issues` AFTER INSERT
    ON jds.subscriptiondetails FOR EACH ROW
BEGIN

    call addBackIssues(new.id, new.startMonth, new.startYear, new.journalGroupID, new.copies);

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `jds`.`edit_bil` BEFORE UPDATE
    ON jds.subscriptiondetails FOR EACH ROW
BEGIN

    begin_level_1: BEGIN

    declare is_sent_to_subscriber tinyint default 0;

    declare proceed_further tinyint default true;

    declare done int default 0;

    declare _journal_id int;

    declare _month int ;

    declare _year int ;

    declare _copies int;

    declare _issue_number int;

    declare _active tinyint default 0;

    declare diff int default 0;

    declare back_issue_list_id int;

    declare updated_flag tinyint default 0;

    declare count_not_sent int default 0;

    declare count_sent int default 0;

    declare copies_already_sent_subscriber int default 0;

    declare cur1 cursor for select t3.id,

                                   t3.journal_id,

                                   t3.month,

                                   t3.`year`,

                                   t3.copies,

                                   t3.issue_number,

                                   t3.sent_to_subscriber,

                                   t3.active 

                            from  subscriptiondetails t1, 

                                  journal_group_contents t2, 

                                  back_issue_list t3 

                            where t1.journalGroupID=t2.journalGroupId 

                            and t3.journal_id=t2.journalId 

                            and t3.subscription_detail_id=old.id 

                            and t3.active=true

                            and t3.sent_to_subscriber=true

                            group by t3.id,t3.journal_id,t3.month,t3.`year`,t3.issue_number,t3.sent_to_subscriber,t3.active;

                            

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    

    if new.startYear > old.startYear and new.startYear > year(CURRENT_DATE()) then

      update back_issue_list set active=false

        where subscription_detail_id=old.id

        and sent_to_subscriber=false

        and back_issue_list.year = old.startYear;

      

      leave begin_level_1;

        

    elseif new.startYear < old.startYear and new.startYear = year(CURRENT_DATE()) then

      

      select copies into copies_already_sent_subscriber 

      from back_issue_list

      where subscription_detail_id=old.id

      and sent_to_subscriber=true

      and active=true LIMIT 1;

      set diff := old.copies - copies_already_sent_subscriber;     

      if diff > 0 then

        

        call addBackIssues(old.id, new.startMonth, new.startYear, new.journalGroupID, diff);

      end if;

      

    end if;

   

   

   

    if new.startMonth > old.startMonth then

      update back_issue_list set active=false

      where subscription_detail_id=old.id

      and sent_to_subscriber=false

      and back_issue_list.month < new.startMonth;

    ELSEIF new.startMonth < old.startMonth then

    	

    	

    	update back_issue_list set active=false

    	where subscription_detail_id=old.id

    	AND sent_to_subscriber=FALSE

    	AND back_issue_list.month >= new.startMonth;

      set diff := getDeltaCopies(old.id);

      if diff > 0 then

        

        call addBackIssues(old.id, new.startMonth, new.startYear, new.journalGroupID, diff);

      else

        call addBackIssues(old.id, new.startMonth, new.startYear, new.journalGroupID, new.copies);

      end if;

      

    end if;

    

    if new.active=false and old.active=true then

      update back_issue_list set active=false

      where subscription_detail_id=old.id

      and sent_to_subscriber=false;

      leave begin_level_1; 

    elseif new.active=true and old.active=false then

      update back_issue_list set active=true

      where subscription_detail_id=old.id

      and sent_to_subscriber=false;

    end if;

    

    if old.copies <> new.copies then

    

      

      

      

      select count(*) into count_sent 

        from back_issue_list

        where subscription_detail_id=old.id

        and sent_to_subscriber=true 

        and active=true limit 1;

      

      

      

      if count_sent = 0 then

        update back_issue_list set copies=new.copies

        where subscription_detail_id=old.id

        and sent_to_subscriber=false 

        and active=true;

      end if;

      

      

      OPEN cur1;

      read_loop: LOOP

        FETCH cur1 into back_issue_list_id, _journal_id, _month, _year, _copies, _issue_number, is_sent_to_subscriber, _active;

        IF done = 1 THEN

            LEAVE read_loop;

        END IF;

        

        

        SET diff := new.copies - _copies;

      

        

        

        select count(*) into count_not_sent 

        from back_issue_list t1

        where t1.subscription_detail_id=old.id

        and t1.journal_id=_journal_id

        and t1.month=_month

        and t1.`year`=_year

        and t1.issue_number=_issue_number

        and sent_to_subscriber=0 

        and active=true limit 1;

        

        if diff > 0 then

          

          

          

          if count_not_sent = 1 then

            update back_issue_list t1 set t1.copies=diff 

            where t1.id <> back_issue_list_id

            and t1.journal_id=_journal_id

            and t1.month=_month

            and t1.`year`=_year

            and t1.issue_number=_issue_number

            and sent_to_subscriber=0 

            and active=true;

          else

            

            

            insert into back_issue_list(subscription_detail_id,

                                        journal_id,

                                        `month`,

                                        `year`,

                                        issue_number,

                                        copies,

                                        sent_to_subscriber,

                                        added_on,

                                        active)

                                  values( old.id,

                                          _journal_id,

                                          _month,

                                          _year,

                                          _issue_number,

                                          diff,

                                          false,

                                          CURRENT_DATE(),

                                          true );

          end if;

        else

          

          

          

          

          if count_not_sent = 1 then

            update back_issue_list t1 set t1.copies=new.copies 

            where t1.id <> back_issue_list_id

            and t1.journal_id=_journal_id

            and t1.month=_month

            and t1.`year`=_year

            and t1.issue_number=_issue_number

            and sent_to_subscriber=0 

            and active=true;

          end if;

        end if;

      END LOOP;

      CLOSE cur1;

    end if;

    END begin_level_1;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `temp_sub_rate`
--

DROP TABLE IF EXISTS `temp_sub_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_sub_rate` (
  `journalGroupId` int(11) DEFAULT NULL,
  `journalGroupName` varchar(128) DEFAULT NULL,
  `subTypeDesc` varchar(64) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `year1` int(11) NOT NULL DEFAULT '0',
  `year2` int(11) NOT NULL DEFAULT '0',
  `year3` int(11) NOT NULL DEFAULT '0',
  `year5` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temp_sub_rate`
--

LOCK TABLES `temp_sub_rate` WRITE;
/*!40000 ALTER TABLE `temp_sub_rate` DISABLE KEYS */;
/*!40000 ALTER TABLE `temp_sub_rate` ENABLE KEYS */;
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
INSERT INTO `user_role` VALUES ('admin@ias.com','admin'),('jds@ias.com','admin'),('shail@ias.com','user'),('tomcat','manager-script');
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
  `firstName` varchar(20) NOT NULL,
  `lastName` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('admin@ias.com','admin','Admin',''),('jds@ias.com','jds','JDS',''),('shail@ias.com','shail','Shail',''),('tomcat','tomcat','Tomcat','');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `year`
--

DROP TABLE IF EXISTS `year`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `year` (
  `yearId` int(11) NOT NULL AUTO_INCREMENT,
  `year` text NOT NULL,
  PRIMARY KEY (`yearId`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `year`
--

LOCK TABLES `year` WRITE;
/*!40000 ALTER TABLE `year` DISABLE KEYS */;
INSERT INTO `year` VALUES (1,'2005'),(2,'2006'),(3,'2007'),(4,'2008'),(5,'2009'),(6,'2010'),(7,'2011'),(8,'2012'),(9,'2013'),(10,'2014'),(11,'2015'),(12,'2016'),(13,'2017'),(14,'2018'),(15,'2019'),(16,'2020'),(17,'2021'),(18,'2022'),(19,'2023'),(20,'2024'),(21,'2025'),(22,'2026'),(23,'2027'),(24,'2028'),(25,'2029'),(41,'2030'),(42,'2031'),(43,'2032'),(44,'2033'),(45,'2034'),(46,'2035'),(47,'2036'),(48,'2037'),(49,'2038'),(50,'2039'),(51,'2040'),(52,'2041'),(53,'2042'),(54,'2043'),(55,'2044'),(56,'2045'),(57,'2046'),(58,'2047'),(59,'2048'),(60,'2049'),(61,'2050');
/*!40000 ALTER TABLE `year` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'jds'
--
/*!50003 DROP PROCEDURE IF EXISTS `addBackIssues` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `addBackIssues`(IN _subscription_detail_id int,

                                  IN _new_startMonth int, 

                                  IN _new_startYear int,

                                  IN _new_journalGroupID int,

                                  IN _new_copies int)
BEGIN

  declare journal_id int;

  declare _month int ;

  declare _year int ;

  declare issue_number int ;

  declare dummy int;

  declare done int default 0;

  

  



  DECLARE cur1 CURSOR FOR  select t2.journalID, 

                                  t3.month, 

                                  t3.year, 

                                  t3.issue 

                            from  journal_group_contents t2, 

                                  mailing_list t3

                            where t2.journalGroupID = _new_journalGroupID

                            and t2.journalID=t3.journalid

                            and t3.month >= _new_startMonth

                            and t3.year = _new_startYear;



  

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;



  OPEN cur1;

  read_loop: LOOP

    FETCH cur1 into journal_id, _month, _year, issue_number;

    IF done = 1 THEN

        LEAVE read_loop;

    END IF;



    insert into back_issue_list(subscription_detail_id,

                                journal_id,

                                back_issue_list.month,

                                back_issue_list.year,

                                copies,

                                issue_number,

                                added_on)

                        values(_subscription_detail_id,

                                journal_id,

                                _month,

                                _year,

                                _new_copies,

                                issue_number,

                                CURRENT_DATE());

  END LOOP;

  CLOSE cur1;
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `circulation_figures` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `circulation_figures`(IN cir_year int)
BEGIN
            
      DECLARE journal_id                 int;

      DECLARE journal_code               varchar(20);

      DECLARE journal_name               VARCHAR(128);
      
      DECLARE print_order_value               int default 0;
      
      DECLARE inst_i                    int default 0;
      
      DECLARE inst_f                    int default 0;
      
      DECLARE ind_i                    int default 0;
      
      DECLARE ind_f                    int default 0;
      
      DECLARE auth                      int default 0;
      
      DECLARE comp                      int default 0;
      
      DECLARE total_copies               int default 0;
      
      DECLARE balance_copies             int default 0;    
      
      DECLARE done int default 0;

      

	    DECLARE

         cur1 CURSOR FOR SELECT id, journalCode, journalName from journals;
 
      DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
      
      delete from circulation_figure;
   
   OPEN cur1;
   
     read_loop: LOOP

          FETCH cur1 INTO journal_id, journal_code, journal_name;


          IF done = 1 THEN

            LEAVE read_loop;

                    END IF;       


          select printOrder into print_order_value from print_order where `year` = cir_year and journalId = journal_id;

          

          select sum(mailing_list_detail.copies) into inst_i
          from mailing_list_detail left join subscriber_type on mailing_list_detail.subtypecode = subscriber_type.subtypecode
          where subscriber_type.nationality = 'I' AND subscriber_type.institutional = 'I'
          and mailing_list_detail.`year` = cir_year and subscriber_type.subtype = 'PAID' 
          and mailing_list_detail.journalId = journal_id
          group by                    mailing_list_detail.journalId, mailing_list_detail.`year`, subscriber_type.institutional, subscriber_type.nationality;




          select sum(mailing_list_detail.copies) into inst_f
          from mailing_list_detail left join subscriber_type on mailing_list_detail.subtypecode = subscriber_type.subtypecode
          where subscriber_type.nationality = 'F' AND subscriber_type.institutional = 'I'
          and mailing_list_detail.`year` = cir_year and subscriber_type.subtype = 'PAID' 
          and mailing_list_detail.journalId = journal_id
          group by                    mailing_list_detail.journalId, mailing_list_detail.`year`, subscriber_type.institutional, subscriber_type.nationality;


          select sum(mailing_list_detail.copies) into ind_i
          from mailing_list_detail left join subscriber_type on mailing_list_detail.subtypecode = subscriber_type.subtypecode
          where subscriber_type.nationality = 'I' AND subscriber_type.institutional = 'P'
          and mailing_list_detail.`year` = cir_year and subscriber_type.subtype = 'PAID' 
          and mailing_list_detail.journalId = journal_id
          group by                    mailing_list_detail.journalId, mailing_list_detail.`year`, subscriber_type.institutional, subscriber_type.nationality;




          select sum(mailing_list_detail.copies) into ind_f
          from mailing_list_detail left join subscriber_type on mailing_list_detail.subtypecode = subscriber_type.subtypecode
          where subscriber_type.nationality = 'F' AND subscriber_type.institutional = 'P'
          and mailing_list_detail.`year` = cir_year and subscriber_type.subtype = 'PAID' 
          and mailing_list_detail.journalId = journal_id
          group by                    mailing_list_detail.journalId, mailing_list_detail.`year`, subscriber_type.institutional, subscriber_type.nationality;


          select sum(mailing_list_detail.copies) into auth
          from mailing_list_detail left join subscriber_type on mailing_list_detail.subtypecode = subscriber_type.subtypecode
          where subscriber_type.subtypecode = 'AUTH'
          and mailing_list_detail.`year` = cir_year
          and mailing_list_detail.journalId = journal_id
          group by                    mailing_list_detail.journalId, mailing_list_detail.`year`;


          select sum(mailing_list_detail.copies) into comp
          from mailing_list_detail left join subscriber_type on mailing_list_detail.subtypecode = subscriber_type.subtypecode
          where subscriber_type.subtype = 'FREE'
          and mailing_list_detail.`year` = cir_year
          and mailing_list_detail.journalId = journal_id
          group by                    mailing_list_detail.journalId, mailing_list_detail.`year`;        
          
          SET total_copies = inst_i + inst_f + ind_i + ind_f + auth + comp;
          
          set balance_copies = print_order_value - total_copies;


            insert into circulation_figure ( journalCode ,journalName, instIndia, instAbroad, indiIndia, 
            indiAbroad, comp, auth, totalCopies, printOrder, balanceCopies) 
            VALUES (
              journal_code
              ,journal_name
              ,inst_i
              ,inst_f
              ,ind_i
              ,ind_f
              ,comp
              ,auth
              ,total_copies
              ,print_order_value
              ,balance_copies
            );
          
       END LOOP;
      
    CLOSE cur1;
    
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cir_subscription_rates` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `cir_subscription_rates`(IN cir_year        int,
                                              IN sub_type_desc   varchar(64))
BEGIN


 DECLARE price_rate int default 0;
 DECLARE rat_period int default 0;
 DECLARE journal_gp_id int;
 DECLARE journal_gp_name varchar(128);
 declare done int default 0;

DECLARE

     cur1 CURSOR FOR select id, journalGroupName from journal_groups;

      DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

      delete from temp_sub_rate;

      OPEN cur1;

      read_loop: LOOP


      fetch cur1 into journal_gp_id, journal_gp_name;

        IF done = 1 THEN


            LEAVE read_loop;

         END IF;

        select subscription_rates.rate into price_rate 
          from 
          subscription_rates, subscriber_type 
          where  
          subscription_rates.`year` = cir_year AND subscription_rates.period = 1 
          AND subscription_rates.journalGroupId = journal_gp_id AND subscription_rates.subtypeId = subscriber_type.id 
          and subscriber_type.subtypedesc = sub_type_desc;


          insert into temp_sub_rate 
          (journalGroupId, journalGroupName, subTypeDesc, `year`, year1)           VALUES 
          (journal_gp_id, journal_gp_name, sub_type_desc, cir_year, price_rate);

          set price_rate = 0;


        select subscription_rates.rate into price_rate 
          from 
          subscription_rates, subscriber_type 
          where  
          subscription_rates.`year` = cir_year AND subscription_rates.period = 2 
          AND subscription_rates.journalGroupId = journal_gp_id AND subscription_rates.subtypeId = subscriber_type.id 
          and subscriber_type.subtypedesc = sub_type_desc;

          update temp_sub_rate SET
            year2 = price_rate 
            where 
              journalGroupId = journal_gp_id AND journalGroupName = journal_gp_name 
              AND subTypeDesc = sub_type_desc and `year` = cir_year;


          set price_rate = 0;


        select subscription_rates.rate into price_rate           from 
          subscription_rates, subscriber_type 
          where  
          subscription_rates.`year` = cir_year AND subscription_rates.period = 3 
          AND subscription_rates.journalGroupId = journal_gp_id AND subscription_rates.subtypeId = subscriber_type.id 
          and subscriber_type.subtypedesc = sub_type_desc;   

          update temp_sub_rate SET
            year3 = price_rate 
            where 
              journalGroupId = journal_gp_id AND journalGroupName = journal_gp_name               AND subTypeDesc = sub_type_desc and `year` = cir_year;


          set price_rate = 0;


        select subscription_rates.rate into price_rate 
          from 
          subscription_rates, subscriber_type 
          where            subscription_rates.`year` = cir_year AND subscription_rates.period = 5 
          AND subscription_rates.journalGroupId = journal_gp_id AND subscription_rates.subtypeId = subscriber_type.id           and subscriber_type.subtypedesc = sub_type_desc; 


        update temp_sub_rate SET
            year4 = price_rate 
            where 
              journalGroupId = journal_gp_id AND journalGroupName = journal_gp_name 
              AND subTypeDesc = sub_type_desc and `year` = cir_year;


          set price_rate = 0;
      END LOOP;

      CLOSE cur1;  


   END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_reminder_type1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `create_reminder_type1`(IN remtype   int)
BEGIN

      DECLARE subid                int;

      DECLARE subscription_total   float;

      DECLARE payment_total        float;

      DECLARE balance              float;

      DECLARE done int default 0;

      DECLARE

         cur1 CURSOR FOR SELECT distinct subscription.id

                           FROM subscriber,

                                subscription,

                                subscriptiondetails,

                                subscriber_type

                          WHERE     subscriptiondetails.subscriptionID =

                                       subscription.id

                                AND subscription.subscriberID = subscriber.id

                                AND subscriptiondetails.endYear >=

                                       year(CURDATE())

                                AND subscriber.subtype = subscriber_type.id

                                AND subscriber_type.subtype = 'Paid'
                                AND subscription.active = '1';


      DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
      
      OPEN cur1;


     read_loop: LOOP

         FETCH cur1 INTO subid;
         
        IF done = 1 THEN

          LEAVE read_loop;

        END IF;
         
         SELECT (sum(subscription_rates.rate * subscriptiondetails.copies))

           INTO subscription_total

           FROM subscriptiondetails,

                journal_groups,

                subscription_rates,

                subscription,

                subscriber

          WHERE     subscriptiondetails.journalGroupID = journal_groups.id

                AND subscription_rates.journalGroupId = journal_groups.id

                AND subscription_rates.`year` = subscriptiondetails.startYear

                AND (  subscriptiondetails.endYear

                     - subscriptiondetails.startYear

                     + 1) = subscription_rates.period

                AND subscriptiondetails.subscriptionID = subscription.id

                AND subscription.subscriberID = subscriber.id

                AND subscriber.subtype = subscription_rates.subtypeId

                AND subscription.id = subid

         GROUP BY subscription.id;





         SELECT sum(inward.amount)

           INTO payment_total

           FROM payment,

                inward,

                subscription,

                inward_purpose

          WHERE     payment.inwardId = inward.id

                AND payment.subscriptionId = subscription.id

                AND (   inward_purpose.purpose = 'New Subscription'

                     OR inward_purpose.purpose = 'Renew Subscription'

                     OR inward_purpose.purpose = 'Payment'

                     OR inward_purpose.purpose = 'Request For Invoice')

                AND inward.inwardPurpose = inward_purpose.id

                AND subscription.id = subid

         GROUP BY subscription.id, inward.id;



         SET balance = subscription_total - payment_total;



         IF balance > 0

         THEN

            INSERT INTO reminders(subscriptionId,

                                  balance,

                                  reminderType,

                                  reminderDate)

            VALUES (subid,

                    balance,

                    remtype,

                    curdate());

         END IF;

      END LOOP;
      
      CLOSE cur1;

   END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_reminder_type2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `create_reminder_type2`(IN remtype   int)
BEGIN

      DECLARE subid                int;

      DECLARE subscription_total   float;

      DECLARE payment_total        float;

      DECLARE balance              float;

      DECLARE done int default 0;

      DECLARE

         cur1 CURSOR FOR SELECT distinct subscription.id

                           FROM subscriber,

                                subscription,

                                subscriptiondetails,

                                subscriber_type,

                                reminders

                          WHERE     subscriptiondetails.subscriptionID =

                                       subscription.id

                                AND subscription.subscriberID = subscriber.id

                                AND subscriptiondetails.endYear >=

                                       year(CURDATE())

                                AND subscriber.subtype = subscriber_type.id

                                AND subscriber_type.subtype = 'Paid'

                                 AND reminders.subscriptionId = subscription.id

                                and reminders.reminderType = '1'

                                and reminders.reminderType <> '2'

                                and reminders.reminderType <> '3';

      
      DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;



      OPEN cur1;



     read_loop: LOOP

         FETCH cur1 INTO subid;

          IF done = 1 THEN

            LEAVE read_loop;

          END IF;

         SELECT (sum(subscription_rates.rate * subscriptiondetails.copies))

           INTO subscription_total

           FROM subscriptiondetails,

                journal_groups,

                subscription_rates,

                subscription,

                subscriber

          WHERE     subscriptiondetails.journalGroupID = journal_groups.id

                AND subscription_rates.journalGroupId = journal_groups.id

                AND subscription_rates.`year` = subscriptiondetails.startYear

                AND (  subscriptiondetails.endYear

                     - subscriptiondetails.startYear

                     + 1) = subscription_rates.period

                AND subscriptiondetails.subscriptionID = subscription.id

                AND subscription.subscriberID = subscriber.id

                AND subscriber.subtype = subscription_rates.subtypeId

                AND subscription.id = subid

         GROUP BY subscription.id;





         SELECT sum(inward.amount)

           INTO payment_total

           FROM payment,

                inward,

                subscription,

                inward_purpose

          WHERE     payment.inwardId = inward.id

                AND payment.subscriptionId = subscription.id

                AND (   inward_purpose.purpose = 'New Subscription'

                     OR inward_purpose.purpose = 'Renew Subscription'

                     OR inward_purpose.purpose = 'Payment'

                     OR inward_purpose.purpose = 'Request For Invoice')

                AND inward.inwardPurpose = inward_purpose.id

                AND subscription.id = subid

         GROUP BY subscription.id, inward.id;



         SET balance = subscription_total - payment_total;



         IF balance > 0

         THEN

            INSERT INTO reminders(subscriptionId,

                                  balance,

                                  reminderType,

                                  reminderDate)

            VALUES (subid,

                    balance,

                    remtype,

                    curdate());

         END IF;

      END LOOP;
      
      CLOSE cur1;

   END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_reminder_type3` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `create_reminder_type3`(IN remtype   int)
BEGIN

      DECLARE subid                int;

      DECLARE subscription_total   float;

      DECLARE payment_total        float;

      DECLARE balance              float;

      DECLARE done int default 0;

      DECLARE

         cur1 CURSOR FOR SELECT distinct subscription.id

                           FROM subscriber,

                                subscription,

                                subscriptiondetails,

                                subscriber_type,

                                reminders

                          WHERE     subscriptiondetails.subscriptionID =

                                       subscription.id

                                AND subscription.subscriberID = subscriber.id

                                AND subscriptiondetails.endYear >=

                                       year(CURDATE())

                                AND subscriber.subtype = subscriber_type.id

                                AND subscriber_type.subtype = 'Paid'

                                 AND reminders.subscriptionId = subscription.id

                                and reminders.reminderType = '2'

                                and reminders.reminderType <> '3';


      DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;


      OPEN cur1;



     read_loop: LOOP

         FETCH cur1 INTO subid;
 
          IF done = 1 THEN

            LEAVE read_loop;

          END IF;        


         SELECT (sum(subscription_rates.rate * subscriptiondetails.copies))

           INTO subscription_total

           FROM subscriptiondetails,

                journal_groups,

                subscription_rates,

                subscription,

                subscriber

          WHERE     subscriptiondetails.journalGroupID = journal_groups.id

                AND subscription_rates.journalGroupId = journal_groups.id

                AND subscription_rates.`year` = subscriptiondetails.startYear

                AND (  subscriptiondetails.endYear

                     - subscriptiondetails.startYear

                     + 1) = subscription_rates.period

                AND subscriptiondetails.subscriptionID = subscription.id

                AND subscription.subscriberID = subscriber.id

                AND subscriber.subtype = subscription_rates.subtypeId

                AND subscription.id = subid

         GROUP BY subscription.id;





         SELECT sum(inward.amount)

           INTO payment_total

           FROM payment,

                inward,

                subscription,

                inward_purpose

          WHERE     payment.inwardId = inward.id

                AND payment.subscriptionId = subscription.id

                AND (   inward_purpose.purpose = 'New Subscription'

                     OR inward_purpose.purpose = 'Renew Subscription'

                     OR inward_purpose.purpose = 'Payment'

                     OR inward_purpose.purpose = 'Request For Invoice')

                AND inward.inwardPurpose = inward_purpose.id

                AND subscription.id = subid

         GROUP BY subscription.id, inward.id;



         SET balance = subscription_total - payment_total;



         IF balance > 0

         THEN

            INSERT INTO reminders(subscriptionId,

                                  balance,

                                  reminderType,

                                  reminderDate)

            VALUES (subid,

                    balance,

                    remtype,

                    curdate());

         END IF;

      END LOOP;

      CLOSE cur1;

   END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_back_issue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `update_back_issue`()
begin

  declare current_month int default MONTH(CURRENT_DATE());

  declare current_year int default YEAR(CURRENT_DATE());

  declare is_mailing_list_generated_for_month tinyint default 0;

  

  

  select generated into is_mailing_list_generated_for_month 

  from mailing_list_summary 

  where mailing_list_summary.month=current_month and mailing_list_summary.year=current_year;

  

  if is_mailing_list_generated_for_month = 0 then

    select is_mailing_list_generated_for_month;

  end if;

  

  

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-08-05 23:52:01
