-- MySQL dump 10.13  Distrib 5.5.24, for Win64 (x86)
--
-- Host: localhost    Database: jds
-- ------------------------------------------------------
-- Server version	5.5.24

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
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `circulation_figure`
--

LOCK TABLES `circulation_figure` WRITE;
/*!40000 ALTER TABLE `circulation_figure` DISABLE KEYS */;
INSERT INTO `circulation_figure` VALUES (146,'P','Pramana - Journal of Physics',0,0,0,0,0,0,0,7803,7803),(147,'JAA','Journal of Astrophysics and Astronomy',0,0,0,0,0,0,0,78002,78002),(148,'MS','Proceedings (Mathematical Sciences)',0,0,0,0,0,0,0,0,0),(149,'EPS','Journal of Earth System Science (formerly Proc. Earth Planet Sci.)',0,0,0,0,0,0,0,0,0),(150,'CS','Journal of Chemical Sciences (formerly Proc. Chemical Sci.)',0,0,0,0,0,0,0,0,0),(151,'BMS','Bulletin of Materials Science',0,0,0,0,0,0,0,0,0),(152,'S','Sadhana (Engineering Sciences)',0,0,0,0,0,0,0,0,0),(153,'JB','Journal of Biosciences',0,0,0,0,0,0,0,0,0),(154,'JG','Journal of Genetics',0,0,0,0,0,0,0,0,0),(155,'RES','Resonanace - Journal of Science Education',0,0,0,0,0,0,0,0,0),(156,'CURR','Current Science',0,0,0,0,0,0,0,0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (1,'Australia'),(2,'Belgium'),(3,'Brazil'),(4,'Canada'),(5,'Chile'),(6,'China'),(7,'Czech Republic'),(8,'Denmark'),(9,'Finland'),(10,'France'),(11,'Germany'),(12,'India'),(13,'Israel'),(14,'Italy'),(15,'Japan'),(16,'Macedonia'),(17,'Nepal'),(18,'Netherlands'),(19,'Norway'),(20,'Pakistan'),(21,'Poland'),(22,'Russia'),(23,'Saudi Arabia'),(24,'Singapore'),(25,'Spain'),(26,'Sri Lanka'),(27,'Switzerland'),(28,'Taiwan'),(29,'UK'),(30,'USA');
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
-- Table structure for table `ias_info`
--

DROP TABLE IF EXISTS `ias_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ias_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `address` text NOT NULL,
  `phone_1` varchar(20) NOT NULL,
  `phone_2` varchar(20) NOT NULL,
  `fax` varchar(20) NOT NULL,
  `email` varchar(64) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COMMENT='Stores data about IAS like address, phone number, email etc';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ias_info`
--

LOCK TABLES `ias_info` WRITE;
/*!40000 ALTER TABLE `ias_info` DISABLE KEYS */;
INSERT INTO `ias_info` VALUES (1,'Indian Academy Of Sciences\r\nP.B. No. 8005, C. V. Raman Avenue\r\nBangalore  560 080\r\nIndia','080','080','080','ias.com');
/*!40000 ALTER TABLE `ias_info` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inward`
--

LOCK TABLES `inward` WRITE;
/*!40000 ALTER TABLE `inward` DISABLE KEYS */;
INSERT INTO `inward` VALUES (1,'12H-00001','Shailendra',12,NULL,NULL,28,0,'','','','2012-08-04',1511,1,NULL,0,NULL,0,1,0,NULL,NULL,0,NULL,'                    \r\n                ','',NULL,0,1);
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
  PRIMARY KEY (`id`)
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
  PRIMARY KEY (`id`)
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
  `yearId` int(11) NOT NULL,
  `journalId` int(11) NOT NULL,
  `issueNo` int(11) NOT NULL,
  `printOrder` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `print_order`
--

LOCK TABLES `print_order` WRITE;
/*!40000 ALTER TABLE `print_order` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `states`
--

LOCK TABLES `states` WRITE;
/*!40000 ALTER TABLE `states` DISABLE KEYS */;
INSERT INTO `states` VALUES (1,'Andhra Pradesh'),(2,'Arunachal Pradesh'),(3,'Assam'),(4,'Bihar'),(31,'Chandigarh'),(5,'Chattisgarh'),(7,'Goa'),(8,'Gujarat'),(10,'Haryana'),(9,'Himachal Pradesh'),(12,'Jammu & Kashmir'),(11,'Jharkhand'),(13,'Karnataka'),(14,'Kerala'),(18,'Madhya Pradesh'),(17,'Maharashtra'),(15,'Manipur'),(16,'Meghalaya'),(19,'Mizoram'),(20,'Nagaland'),(6,'New Delhi'),(21,'Odisha'),(23,'Pondicherry'),(22,'Punjab'),(24,'Rajasthan'),(25,'Sikkim'),(26,'Tamil Nadu'),(27,'Tripura'),(28,'Uttar Pradesh'),(29,'Uttarakhand'),(30,'West Bengal');
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
  `shippingAddress` varchar(64) NOT NULL,
  `invoiceAddress` varchar(64) NOT NULL,
  `city` int(11) NOT NULL,
  `district` int(11) DEFAULT NULL,
  `state` int(11) NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=1512 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriber`
--

LOCK TABLES `subscriber` WRITE;
/*!40000 ALTER TABLE `subscriber` DISABLE KEYS */;
INSERT INTO `subscriber` VALUES (1,'1','0000-00-00','Prof. S S Abhyankar','Department of Mathematics','Purdue University',' West Lafayette, Indiana 47907','',0,NULL,0,30,'0','',1,NULL,0,NULL),(2,'2','0000-00-00','Prof. Y P Abrol','The Indian Nitrogen Group','Room No. F4, A Block','NASC Complex, DPS Marg PO Pusa','',156,NULL,6,0,'110012','',1,NULL,0,NULL),(3,'3','0000-00-00','Prof. S K Acharya','Department of Gastroenterology','All India Institute of Medical','Sciences Ansari Nagar','',156,NULL,6,0,'110029','',1,NULL,0,NULL),(4,'4','0000-00-00','Dr Samit Adhya','Scientist','Indian Inst. of Chemical Biology','4, Raja S.C. Mullick Road Jadavpur','',116,NULL,30,0,'700032','',1,NULL,0,NULL),(5,'5','0000-00-00','Prof. Adi Adimurthi','TIFR Centre for Appl. Mathematics','5th B Main','P.B. No. 6503 Sharada Nagar','',28,NULL,13,0,'560065','',1,NULL,0,NULL),(6,'6','0000-00-00','Prof. G S Agarwal','Nobel Foundation Chair & Professor','Department of Physics','Oklahoma State University Still Water, OK 74078','',0,NULL,0,30,'0','',1,NULL,0,NULL),(7,'7','0000-00-00','Prof. S S Agarwal','D-13, Vivekanandpuri','',' ','',127,NULL,28,0,'226007','',1,NULL,0,NULL),(8,'8','0000-00-00','Prof. Amita Aggarwal','Dept. of Immunology','Sanjay Gandhi PG Institute of','Medical Sciences ','',127,NULL,28,0,'226014','',1,NULL,0,NULL),(9,'9','0000-00-00','Dr Rakesh Aggarwal','Department of Gastroenterology','Sanjay Gandhi PG Institute','of Medical Sciences Raebarelli Road','',127,NULL,28,0,'226014','',1,NULL,0,NULL),(10,'10','0000-00-00','Prof. H O Agrawal','Sri Laxman Bhavan','20/2, Indira Nagar',' ','',127,NULL,28,0,'226016','',1,NULL,0,NULL),(11,'11','0000-00-00','Prof. Manindra Agrawal','Department of Computer Science','Indian Institute of Technology',' ','',107,NULL,28,0,'208016','',1,NULL,0,NULL),(12,'12','0000-00-00','Prof. P C Agrawal','405, Vigyan, Scientists CHS','Plot No. 23, Sector 17','Vashi  Mumbai 400 703','',0,NULL,17,0,'400005','',1,NULL,0,NULL),(13,'13','0000-00-00','Prof. J C Ahluwalia','186, SFS Apartments','Hauz Khas',' ','',156,NULL,6,0,'110016','',1,NULL,0,NULL),(14,'14','0000-00-00','Prof. Talat Ahmad','Vice Chancellor','University of Kashmir','Hazratbal ','',209,NULL,12,0,'190006','',1,NULL,0,NULL),(15,'15','0000-00-00','Dr A Ajayaghosh','Photosciences & Photonics Division','Natl. Inst. for Interdisciplinary','Science & Technology ','',217,NULL,14,0,'695019','',1,NULL,0,NULL),(16,'16','0000-00-00','Dr Sher Ali','Senior Staff Scientist & Chief','Molecular Genetics Laboratory','National Institute of Immunology Aruna Asaf Ali Marg','',156,NULL,6,0,'110067','',1,NULL,0,NULL),(17,'17','0000-00-00','Prof.  Amarjit Singh','12, Auburn Court','',' Vernon Hills, IL 60061','',0,NULL,0,30,'0','',1,NULL,0,NULL),(18,'18','0000-00-00','Prof. R E Amritkar','Theory Division','Physical Research Laboratory','Navrangpura ','',2,NULL,8,0,'380009','',1,NULL,0,NULL),(19,'19','0000-00-00','Prof. Anuranjan Anand','Molecular Biology & Genetics Unit','JN Centre for Advanced Scientific','Research Jakkur','',28,NULL,13,0,'560064','',1,NULL,0,NULL),(20,'20','0000-00-00','Prof. G V Anand','Visiting Professor','ECE Department','Indian Institute of Science ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(21,'21','0000-00-00','Dr Nitya Anand','B-62','Nirala Nagar',' ','',127,NULL,28,0,'226020','',1,NULL,0,NULL),(22,'22','0000-00-00','Prof. G Ananthakrishna','Materials Research Centre','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(23,'23','0000-00-00','Prof. S Ananthakrishnan','Adjunct Professor','Electronic Science Department','Pune University Ganeshkhind','',173,NULL,17,0,'411007','',1,NULL,0,NULL),(24,'24','0000-00-00','Prof. T N Ananthakrishnan','Flat 6, \'Dwaraka\'','22, Kamdar Nagar','Nungambakkam ','',50,NULL,26,0,'600034','',1,NULL,0,NULL),(25,'25','0000-00-00','Prof.  Anil Kumar','NASI Senior Scientist','Department of Physics','Indian Institute of Science ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(26,'26','0000-00-00','Dr  Anil Kumar','Physical Chemistry Division','National Chemical Laboratory',' ','',173,NULL,17,0,'411008','',1,NULL,0,NULL),(27,'27','0000-00-00','Dr  Anil Kumar','National Geophysical Research','Institute','Uppal Road ','',87,NULL,1,0,'500606','',1,NULL,0,NULL),(28,'28','0000-00-00','Prof. H M Antia','Astrophysics Group','Tata Inst. of Fundamental Research','Homi Bhabha Road ','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(29,'29','0000-00-00','Prof. N Appaji Rao','9, Sharada Colony','Basaveshwaranagar',' ','',28,NULL,13,0,'560079','',1,NULL,0,NULL),(30,'30','0000-00-00','Dr S K Apte','Associate Director','Biomedical Group','Bhatha Atomic Research Centre Trombay','',142,NULL,17,0,'400085','',1,NULL,0,NULL),(31,'31','0000-00-00','Prof. J H Arakeri','Dept. of Mechanical Engineering','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(32,'32','0000-00-00','Prof. V H Arakeri','Dept. of Mechanical Engineering','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(33,'33','0000-00-00','Dr Vidya A Arankalle','Senior Dy. Director','National Institute of Virology','Sus Road Pashan','',173,NULL,17,0,'411021','',1,NULL,0,NULL),(34,'34','0000-00-00','Dr B R Arora','36, Janakpuri','Engineers Enclave','Phase III, GMS Road ','',57,NULL,29,0,'248001','',1,NULL,0,NULL),(35,'35','0000-00-00','Dr V Arunachalam','Flat No. 1, Rams Bridgeview Apts.','3 (old 2), Central Avenue Road','Kodambakkam ','',50,NULL,26,0,'600024','',1,NULL,0,NULL),(36,'36','0000-00-00','Dr V S Arunachalam','547, 9th Cross','III Phase J.P. Nagar',' ','',28,NULL,13,0,'560078','',1,NULL,0,NULL),(37,'37','0000-00-00','Prof. E Arunan','IPC Department','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(38,'38','0000-00-00','Prof. U Aswathanarayana','Shanti Shikara Apts.','B-16, Raj Bhavan Road','Somajiguda ','',87,NULL,1,0,'500082','',1,NULL,0,NULL),(39,'39','0000-00-00','Prof. K B Athreya','Dept. of Mathematics & Statistics','Iowa State University',' Ames, Iowa 50011','',0,NULL,0,30,'0','',1,NULL,0,NULL),(40,'40','0000-00-00','Dr Shally Awasthi','Department of Paediatrics','CSM Medical University','Chowk ','',127,NULL,28,0,'226003','',1,NULL,0,NULL),(41,'41','0000-00-00','Prof. C R Babu','Professor Emeritus','CEMDE','School of Environmental Studies University of Delhi','',58,NULL,6,0,'110007','',1,NULL,0,NULL),(42,'42','0000-00-00','Dr. P Babu','No. 706, 7th Main','11th Cross','JP Nagar III Phase ','',28,NULL,13,0,'560078','',1,NULL,0,NULL),(43,'43','0000-00-00','Dr Anand K Bachhawat','Indian Inst. of Science Education','& Research','Knowledge City Manauli P.O.','',193,NULL,22,0,'140306','',1,NULL,0,NULL),(44,'44','0000-00-00','Dr A K Bag','Editor','Indian Journal of History of Science','Indian National Science Academy Bahadur Shah Zafar Marg','',156,NULL,6,0,'110002','',1,NULL,0,NULL),(45,'45','0000-00-00','Prof. Bhaskar Bagchi','Statistics & Mathematics Unit','Indian Statistical Institute','R.V. College P.O. ','',28,NULL,13,0,'560059','',1,NULL,0,NULL),(46,'46','0000-00-00','Prof. Biman Bagchi','S.S.C.U.','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(47,'47','0000-00-00','Prof. Sunil Bajpai','Department of Earth Sciences','Indian Institute of Technology',' ','',187,NULL,29,0,'247667','',1,NULL,0,NULL),(48,'48','0000-00-00','Prof. V Balaji','Chennai Mathematical Institute','H1, Sipcot IT Park','Padur Post, Siruseri ','',50,NULL,26,0,'603103','',1,NULL,0,NULL),(49,'49','0000-00-00','Prof. N Balakrishnan','S.E.R.C.','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(50,'50','0000-00-00','Prof. V Balakrishnan','Professor Emeritus','Department of Physics','Indian Inst. of Technology ','',50,NULL,26,0,'600036','',1,NULL,0,NULL),(51,'51','0000-00-00','Prof. Hemalatha Balaram','Molecular Biology & Genetics Unit','Jawaharlal Nehru Centre for Adv.','Scientific Research Jakkur','',28,NULL,13,0,'560064','',1,NULL,0,NULL),(52,'52','0000-00-00','Prof. P Balaram','Director','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(53,'53','0000-00-00','Dr A S Balasubramanian','16/7A, First New Street','Thirunagar',' ','',233,NULL,26,0,'632006','',1,NULL,0,NULL),(54,'54','0000-00-00','Dr D Balasubramanian','Director of Research','L V Prasad Eye Institute','LV Prasad Marg Banjara Hills','',87,NULL,1,0,'500034','',1,NULL,0,NULL),(55,'55','0000-00-00','Prof. K A Balasubramanian','49, Guruthoppu Phase 1, II Street','Satuvachari',' ','',233,NULL,26,0,'632009','',1,NULL,0,NULL),(56,'56','0000-00-00','Dr K K Balasubramanian','','','27, Vandaloor Kelambakkam Road, Keelekottaiyur','',50,NULL,26,0,'600048','',1,NULL,0,NULL),(57,'57','0000-00-00','Prof. R Balasubramanian','Director','Institute of Mathematical Sciences','CIT Campus, Taramani ','',50,NULL,26,0,'600113','',1,NULL,0,NULL),(58,'58','0000-00-00','Prof. S Balasubramanian','CPM Unit','JN Centre for Adv. Scientific','Research Jakkur','',28,NULL,13,0,'560064','',1,NULL,0,NULL),(59,'59','0000-00-00','Dr  Baldev Raj','President - Research','PSG Institutions','New Admn. Block Peelamedu Post','',52,NULL,26,0,'641004','',1,NULL,0,NULL),(60,'60','0000-00-00','Prof. R P Bambah','1275, Sector 19B','',' ','',48,NULL,31,0,'160019','',1,NULL,0,NULL),(61,'61','0000-00-00','Prof. D Banerjee','Dept. of Materials Engineering','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(62,'62','0000-00-00','Dr K Banerjee','A-1-A/5-6, Sopan Baug','Opp. Mantri Avenue','NCL Road, Pashan ','',173,NULL,17,0,'411008','',1,NULL,0,NULL),(63,'63','0000-00-00','Dr R K Banerjee','Nature\'s Nest','Flat No. 1G','140, P.G.H. Shah Road ','',116,NULL,30,0,'700032','',1,NULL,0,NULL),(64,'64','0000-00-00','Prof. Soumitro Banerjee','Dept. of Physical Sciences','Indian Inst. of Science Education','and Research Bidhan Chandra KV PO, Mohanpur','',146,NULL,30,0,'741252','',1,NULL,0,NULL),(65,'65','0000-00-00','Dr Srikumar Banerjee','DAE Homi Bhabha Chair Professor','Bhabha Atomic Research Centre','Central Complex, Trombay ','',142,NULL,17,0,'400085','',1,NULL,0,NULL),(66,'66','0000-00-00','Prof. Sunanda Banerjee','MS 234','HENPP Division','Saha Institute of Nuclear Physics 1/AF, Bidhan Nagar','',116,NULL,30,0,'700064','',1,NULL,0,NULL),(67,'67','0000-00-00','Prof. Manju Bansal','Molecular Biophysics Unit','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(68,'68','0000-00-00','Prof. R B Bapat','Statistics & Mathematics Unit','Indian Statistical Institute','7, SJS Sansanwal Marg ','',156,NULL,6,0,'110016','',1,NULL,0,NULL),(69,'69','0000-00-00','Prof. M Barma','Director','Tata Institute of Fundamental','Research Homi Bhabha Road','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(70,'70','0000-00-00','Prof. S R Barman','UGC-DAE Consortium for Scientific','Research','Khandwa Road ','',90,NULL,18,0,'452001','',1,NULL,0,NULL),(71,'71','0000-00-00','Prof. A K Barua','Honorary Emeritus Professor','Bengal Engg & Sci. University','Shibpur ','',85,NULL,30,0,'711103','',1,NULL,0,NULL),(72,'72','0000-00-00','Prof. Amit Basak','Department of Chemistry','Indian Inst. of Technology',' ','',112,NULL,30,0,'721302','',1,NULL,0,NULL),(73,'73','0000-00-00','Prof. D Basavaiah','School of Chemistry','University of Hyderabad',' ','',87,NULL,1,0,'500046','',1,NULL,0,NULL),(74,'74','0000-00-00','Prof. G Baskaran','Raja Ramanna Fellow','Inst. of Mathematical Sciences','CIT Campus, Taramani ','',50,NULL,26,0,'600113','',1,NULL,0,NULL),(75,'75','0000-00-00','Dr Joyoti Basu','Department of Chemistry','Bose Institute','93/1, APC Road ','',116,NULL,30,0,'700009','',1,NULL,0,NULL),(76,'76','0000-00-00','Dr M K Basu','Emeritus Scientist (CSIR)','Biomembrane Divison','Indian Inst. of Chemical Biology 4, Raja S.C. Mullick Road','',116,NULL,30,0,'700032','',1,NULL,0,NULL),(77,'77','0000-00-00','Dr S K Basu','JC Bose Chair Professor','NISCAIR','14, Satsang Vihar Marg ','',156,NULL,6,0,'110067','',1,NULL,0,NULL),(78,'78','0000-00-00','Dr J K Batra','Staff Scientist VI','National Institute of Immunology','Aruna Asaf Ali Road ','',156,NULL,6,0,'110067','',1,NULL,0,NULL),(79,'79','0000-00-00','Dr Gufran-Ullah Beig','Indian Institute of Tropical','Meteorology','Homi Bhabha Road Pashan','',173,NULL,17,0,'411008','',1,NULL,0,NULL),(80,'80','0000-00-00','Dr Sumit Bhaduri','562, Adenwala Road','Rustom Mansion',' ','',142,NULL,17,0,'400019','',1,NULL,0,NULL),(81,'81','0000-00-00','Dr D S Bhakuni','C-132, Nirala Nagar','',' ','',127,NULL,28,0,'226020','',1,NULL,0,NULL),(82,'82','0000-00-00','Dr Upinder S Bhalla','National Centre for','Biological Sciences','GKVK Campus ','',28,NULL,13,0,'560065','',1,NULL,0,NULL),(83,'83','0000-00-00','Prof. M K Bhan','Secretary','Department of Biotechnology','CGO Complex, Lodi Road ','',156,NULL,6,0,'110003','',1,NULL,0,NULL),(84,'84','0000-00-00','Prof. N Bhandari','2, Nilima Flats','Vijay Crossing','Navrangpura ','',2,NULL,8,0,'380009','',1,NULL,0,NULL),(85,'85','0000-00-00','Dr K Bhanu Sankara Rao','Dean, School of Engineering','Sciences & Technology','University of Hyderabad  Hyderabad 400 500 046','',0,NULL,1,0,'500046','',1,NULL,0,NULL),(86,'86','0000-00-00','Prof. P K Bharadwaj','Department of Chemistry','Indian Institute of Technology',' ','',107,NULL,28,0,'208016','',1,NULL,0,NULL),(87,'87','0000-00-00','Dr Anil Bhardwaj','Head, Planetary Sciences Branch','Space Physics Laboratory','Vikram Sarabhai Space Centre ','',217,NULL,14,0,'695022','',1,NULL,0,NULL),(88,'88','0000-00-00','Dr Purnima Bhargava','Scientist F','Centre for Cellular & Molecular','Biology Uppal Road','',87,NULL,1,0,'500007','',1,NULL,0,NULL),(89,'89','0000-00-00','Prof. B V Rajarama Bhat','Indian Statistical Institute','RV College P.O.',' ','',28,NULL,13,0,'560059','',1,NULL,0,NULL),(90,'90','0000-00-00','Prof. G S Bhat','Centre for Atmospheric & Oceanic','Sciences','Indian Institute of Science ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(91,'91','0000-00-00','Prof. S V Bhat','INSA Senior Scienstist','Dept. of Physics','Indian Institute of Science ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(92,'92','0000-00-00','Dr C R Bhatia','17, Rohini, Plot 29-30','Sector 9-A','Vashi ','',154,NULL,17,0,'400703','',1,NULL,0,NULL),(93,'93','0000-00-00','Prof. R Bhatia','Indian Statistical Institute','7 S J S Sansanwal Marg',' ','',156,NULL,6,0,'110016','',1,NULL,0,NULL),(94,'94','0000-00-00','Prof. S K Bhatia','Department of Chemical Engineering','University of Queensland','St. Lucia Brisbane, QLD 4072','',0,NULL,0,1,'0','',1,NULL,0,NULL),(95,'95','0000-00-00','Prof. Rakesh Bhatnagar','School of Biotechnology','Jawaharlal Nehru University',' ','',156,NULL,6,0,'110067','',1,NULL,0,NULL),(96,'96','0000-00-00','Prof. M V Bhatt','39, Siddeshwara Layout','Seedadahalli','Nagasandra Post ','',28,NULL,13,0,'560073','',1,NULL,0,NULL),(97,'97','0000-00-00','Prof. Subhash J Bhatt','Department of Mathematics','Sardar Patel University',' ','',230,NULL,8,0,'388120','',1,NULL,0,NULL),(98,'98','0000-00-00','Prof. J K Bhattacharjee','Distinguished Professor','S N Bose National Centre for Basic','Sciences JD Block, Salt Lake','',116,NULL,30,0,'700098','',1,NULL,0,NULL),(99,'99','0000-00-00','Prof. S M Bhattacharjee','Institute of Physics','Sachivalaya Marg',' ','',38,NULL,21,0,'751005','',1,NULL,0,NULL),(100,'100','0000-00-00','Prof. Dipankar Bhattacharya','Inter-University Centre for','Astronomy & Astrophysics','Ganeshkhind ','',173,NULL,17,0,'411007','',1,NULL,0,NULL),(101,'101','0000-00-00','Prof. S K Bhattacharya','Visiting Professor','Academia Sinica',' Taipei 11529','',0,NULL,0,28,'0','',1,NULL,0,NULL),(102,'102','0000-00-00','Prof. Samaresh Bhattacharya','Department of Chemistry','Jadavpur University',' ','',116,NULL,30,0,'700032','',1,NULL,0,NULL),(103,'103','0000-00-00','Prof. Samir Bhattacharya','Dept. of Zoology','School of Life Sciences','Visva Bharati University ','',192,NULL,30,0,'731235','',1,NULL,0,NULL),(104,'104','0000-00-00','Prof. Santanu Bhattacharya','Dept. of Organic Chemistry','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(105,'105','0000-00-00','Prof. Sudha Bhattacharya','School of Environmental Sciences','Jawaharlal Nehru University',' ','',156,NULL,6,0,'110067','',1,NULL,0,NULL),(106,'106','0000-00-00','Dr Archana Bhattacharyya','Professor Emeritus','Indian Institute of Geomagnetism','New Panvel ','',154,NULL,17,0,'410218','',1,NULL,0,NULL),(107,'107','0000-00-00','Prof. B Bhattacharyya','Department of Biochemistry','Bose Institute','P-1/12, CIT Scheme, VII M ','',116,NULL,30,0,'700054','',1,NULL,0,NULL),(108,'108','0000-00-00','Prof. K Bhattacharyya','Director','Indian Association for the','Cultivation of Science Jadavpur','',116,NULL,30,0,'700032','',1,NULL,0,NULL),(109,'109','0000-00-00','Prof. S C Bhattacharyya','49/7, Canal Road','Kishanpur',' ','',57,NULL,29,0,'248009','',1,NULL,0,NULL),(110,'110','0000-00-00','Prof. S P Bhattacharyya','Department of Physical Chemistry','Indian Association for the','Cultivation of Science Jadavpur','',116,NULL,30,0,'700032','',1,NULL,0,NULL),(111,'111','0000-00-00','Prof. S K Bhattacherjee','302B, Tribute','Rajkamal Studio Cmpd., Off SS Rao Road','Behind MG Memorial Hospital Parel','',142,NULL,17,0,'400012','',1,NULL,0,NULL),(112,'112','0000-00-00','Prof. S M Bhatwadekar','Bhaskaracharya Pratishthana','56/14, Erandavane','Damale Park Off Law College Road','',173,NULL,17,0,'411004','',1,NULL,0,NULL),(113,'113','0000-00-00','Dr D D Bhawalkar','26, Paramanu Nagar','',' ','',90,NULL,18,0,'452013','',1,NULL,0,NULL),(114,'114','0000-00-00','Dr Rajani A Bhisey','7, Yug Prabhat Co-op. Hsg. Soc.','Siataldevi Temple Road','Mahim ','',142,NULL,17,0,'400016','',1,NULL,0,NULL),(115,'115','0000-00-00','Prof. R V Bhonsle','B/1, Mahagaokar Complex','Rajaram Road',' ','',115,NULL,17,0,'416001','',1,NULL,0,NULL),(116,'116','0000-00-00','Prof. Ushadevi N Bhosle','School of Mathematics','Tata Inst. of Fundamental Research','Homi Bhabha Road ','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(117,'117','0000-00-00','Prof. B B Biswas','CG-155, Salt Lake City','',' ','',116,NULL,30,0,'700091','',1,NULL,0,NULL),(118,'118','0000-00-00','Dr Gautam Biswas','Director','Central Mechanical Engineering','Research Institute ','',66,NULL,30,0,'713209','',1,NULL,0,NULL),(119,'119','0000-00-00','Prof. Indranil Biswas','School of Mathematics','Tata Institute of Fundamental','Research Homi Bhabha Road','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(120,'120','0000-00-00','Prof. Renee M Borges','Centre for Ecological Sciences','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(121,'121','0000-00-00','Prof. V S Borkar','Dept. of Electrical Engineering','Indian Institute of Technology','Powai ','',142,NULL,17,0,'400076','',1,NULL,0,NULL),(122,'122','0000-00-00','Prof. Arup Bose','Stat. Math. Unit','Indian Statistical Institute','203, B.T. Road ','',116,NULL,30,0,'700108','',1,NULL,0,NULL),(123,'123','0000-00-00','Prof. D N Bose','7/2, Short Street','',' ','',116,NULL,30,0,'700017','',1,NULL,0,NULL),(124,'124','0000-00-00','Prof. Indrani Bose','Department of Physics','Bose Institute','93/1, APC Road ','',116,NULL,30,0,'700009','',1,NULL,0,NULL),(125,'125','0000-00-00','Prof. S K Bose','BE-188 Salt Lake City','',' ','',116,NULL,30,0,'700064','',1,NULL,0,NULL),(126,'126','0000-00-00','Prof. S K Brahmachari','Director General','Council of Scientific & Industrial','Research, Anusandhan Ghavan 2, Rafi Ahmad Kidwai Marg','',156,NULL,6,0,'110001','',1,NULL,0,NULL),(127,'127','0000-00-00','Dr R C Budhani','Director','National Physical Laboratory','Dr K.S. Krishnan Marg ','',156,NULL,6,0,'110012','',1,NULL,0,NULL),(128,'128','0000-00-00','Dr P Chaddah','Director','UGC-DAE Consortium for Scientific','Research, University Campus Khandwa Road','',90,NULL,18,0,'452017','',1,NULL,0,NULL),(129,'129','0000-00-00','Prof. B K Chakrabarti','Saha Institute of Nuclear Physics','1/AF Bidan Nagar',' ','',116,NULL,30,0,'700064','',1,NULL,0,NULL),(130,'130','0000-00-00','Prof. P P Chakrabarti','Dept. of Computer Science and','Engineering','Indian Inst of Technology ','',112,NULL,30,0,'721302','',1,NULL,0,NULL),(131,'131','0000-00-00','Prof. Pinakpani Chakrabarti','Dept. of Biochemistry and','Bioinformatics','Bose Institute P-1/12 C Bldg., CIT Scheme, VII M','',116,NULL,30,0,'700054','',1,NULL,0,NULL),(132,'132','0000-00-00','Dr Pradip K Chakraborti','Scientist G','Institute of Microbial Technology','Sector 39A ','',48,NULL,31,0,'160036','',1,NULL,0,NULL),(133,'133','0000-00-00','Dr Tushar K Chakraborty','Director','Central Drug Research Institute','Chattar Manzil Palace P.B. No. 173','',127,NULL,28,0,'226001','',1,NULL,0,NULL),(134,'134','0000-00-00','Prof. A R Chakravarty','IPC Department','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(135,'135','0000-00-00','Prof. Charusita Chakravarty','Department of Chemistry','Indian Institute of Technology',' ','',156,NULL,6,0,'110016','',1,NULL,0,NULL),(136,'136','0000-00-00','Prof. A Chakravorty','Emeritus Professor & Ramanna Fellow','Dept. of Inorganic Chemistry','Indian Assn. for the Cultivation of Science, Jadavpur Kolkata 70','',0,NULL,30,0,'700019','',1,NULL,0,NULL),(137,'137','0000-00-00','Prof. D Chakravorty','INSA Senior Scientist','Indian Association for the','Cultivation of Science Jadavpur','',116,NULL,30,0,'700032','',1,NULL,0,NULL),(138,'138','0000-00-00','Prof. Ramesh Chander','House No. 290','Sector 4','Mansa Devi Complex ','',163,NULL,10,0,'134109','',1,NULL,0,NULL),(139,'139','0000-00-00','Prof. Asha Chandola-Saklani','Apeejay Svran Inst. of Biosciences','& Clinical Research','Plot 26, Sector 32 ','',79,NULL,10,0,'122001','',1,NULL,0,NULL),(140,'140','0000-00-00','Prof. Amalendu Chandra','Department of Chemistry','Indian Institute of Technology',' ','',107,NULL,28,0,'208016','',1,NULL,0,NULL),(141,'141','0000-00-00','Prof. H Sharat Chandra','Centre for Human Genetics','Biotech Park','Phase I, Electronic City ','',28,NULL,13,0,'560100','',1,NULL,0,NULL),(142,'142','0000-00-00','Prof. N Chandrakumar','Department of Chemistry','Indian Institute of Technology',' ','',50,NULL,26,0,'600036','',1,NULL,0,NULL),(143,'143','0000-00-00','Prof. S Chandrasekaran','Honorary Professor','','Department of Organic Chemistry Indian Institute of Science','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(144,'144','0000-00-00','Prof. J Chandrasekhar','Gilead Connecticut','36, East Industrial Road',' Branford, CT 06405','',0,NULL,0,30,'0','',1,NULL,0,NULL),(145,'145','0000-00-00','Dr Srivari Chandrasekhar','Organic Chemistry Division','Indian Inst. of Chemical Technology','Uppal Road ','',87,NULL,1,0,'500607','',1,NULL,0,NULL),(146,'146','0000-00-00','Prof. V Chandrasekhar','Dept. of Chemistry','Indian Institute of Technology',' ','',107,NULL,28,0,'208016','',1,NULL,0,NULL),(147,'147','0000-00-00','Dr K Chandrasekharan','Professor Emeritus','Eldg. Technische Hochschule','Mathematik ETH Zentrum, Hut D158092 Zurich','',0,NULL,0,27,'0','',1,NULL,0,NULL),(148,'148','0000-00-00','Dr T K Chandrashekar','Director','National Institute fpr Science','Education and Research IoP Campus, Sashivalaya Marg','',38,NULL,21,0,'751005','',1,NULL,0,NULL),(149,'149','0000-00-00','Prof. Vijay Chandru','Chairman','Strand Life Sciences','5th Floor, Kirloskar Business Park Hebbal','',28,NULL,13,0,'560024','',1,NULL,0,NULL),(150,'150','0000-00-00','Dr Mammen Chandy','Director','Tata Medical Centre','Jyoti Basu Nagar Rajarhat','',116,NULL,30,0,'700156','',1,NULL,0,NULL),(151,'151','0000-00-00','Prof. P K Chattaraj','Department of Chemistry','Indian Inst. of Technology',' ','',112,NULL,30,0,'721302','',1,NULL,0,NULL),(152,'152','0000-00-00','Prof. D Chatterji','Molecular Biophysics Unit','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(153,'153','0000-00-00','Prof. Bharat B Chattoo','Dept. of Microbiology and','Biotechnology Centre','MS University of Baroda ','',229,NULL,8,0,'390002','',1,NULL,0,NULL),(154,'154','0000-00-00','Dr Amitabha Chattopadhyay','Scientist H','Centre for Cellular & Molecular','Biology Uppal Road','',87,NULL,1,0,'500007','',1,NULL,0,NULL),(155,'155','0000-00-00','Prof. Dhrubajyoti Chattopadhyay','Pro Vice Chancellor (Academics)','and Biotechnology','University of Calcutta 35, Ballaygunge Circular Road','',116,NULL,30,0,'700019','',1,NULL,0,NULL),(156,'156','0000-00-00','Dr Joydev Chattopadhyay','Agricultural Science Unit','Indian Statistical Institute','203, B.T. Road ','',116,NULL,30,0,'700108','',1,NULL,0,NULL),(157,'157','0000-00-00','Prof. K Chattopadhyay','Chairman','Department of Materials Engineering','Indian Institute of Science ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(158,'158','0000-00-00','Prof. Nitin Chattopadhyay','Department of Chemistry','Jadavpur University',' ','',116,NULL,30,0,'700032','',1,NULL,0,NULL),(159,'159','0000-00-00','Dr Samit Chattopadhyay','','National Centre for Cell Science','University Campus Ganehkhind','',173,NULL,17,0,'411007','',1,NULL,0,NULL),(160,'160','0000-00-00','Prof. Sudip Chattopadhyay','Department of Biotechnology','National Institute of Technology','Mahatma Gandhi Avenue ','',66,NULL,30,0,'713209','',1,NULL,0,NULL),(161,'161','0000-00-00','Prof. Subhash Chaturvedi','School of Physics','University of Hyderabad',' ','',87,NULL,1,0,'500046','',1,NULL,0,NULL),(162,'162','0000-00-00','Prof. U C Chaturvedi','201, Annapurna Apartments','No. 1, Bishop Rocky Street','Faizabad Road ','',127,NULL,28,0,'226007','',1,NULL,0,NULL),(163,'163','0000-00-00','Dr R V Chaudhari','Dept. of Chemical & Petroleum Engg.','CEBC, University of Kansas','Suite 110 1501 Wakarusa Dr ALawrence, KS 66047','',0,NULL,0,30,'0','',1,NULL,0,NULL),(164,'164','0000-00-00','Dr Arabinda Chaudhuri','Division of Lipid Science','& Technology','Indian Inst. of Chemical Technology Uppal Road','',87,NULL,1,0,'500607','',1,NULL,0,NULL),(165,'165','0000-00-00','Prof. M K Chaudhuri','Vice Chancellor','Tezpur University',' ','',215,NULL,3,0,'784028','',1,NULL,0,NULL),(166,'166','0000-00-00','Prof. Probal Chaudhuri','Theoretical Statistics &','Mathematics Unit','Indian Statistical Institute 203, B.T. Road','',116,NULL,30,0,'700108','',1,NULL,0,NULL),(167,'167','0000-00-00','Prof. Subhasis Chaudhuri','Dept. of Electrical Engineering','Indian Institute of Technology','Powai ','',142,NULL,17,0,'400076','',1,NULL,0,NULL),(168,'168','0000-00-00','Prof. V S Chauhan','Director','International Centre for Genetic','Engineering & Biotechnology Aruna Asaf Ali Marg','',156,NULL,6,0,'110067','',1,NULL,0,NULL),(169,'169','0000-00-00','Prof. J N Chengalur','','Natl. Centre for Radio Astrophysics','Ganeshkhind ','',173,NULL,17,0,'411007','',1,NULL,0,NULL),(170,'170','0000-00-00','Prof. Rajendra P Chhabra','Dept. of Chemical Engineering','Indian Institute of Technology',' ','',107,NULL,28,0,'208016','',1,NULL,0,NULL),(171,'171','0000-00-00','Dr R Chidambaram','Principal Scientific Adviser to','the Government of India','318, Vigyan Bhavan Annexe Maulana Azad Road','',156,NULL,6,0,'110001','',1,NULL,0,NULL),(172,'172','0000-00-00','Dr Chetan E Chitnis','International Centre for Genetic','Engineering & Biotechnology','Aruna Asaf Ali Marg ','',156,NULL,6,0,'110067','',1,NULL,0,NULL),(173,'173','0000-00-00','Prof. S M Chitre','201, Vigyan Shila','Near Seven Bungalows','Juhu-Versova New Link Road Versova, Andheri (West)','',142,NULL,17,0,'400061','',1,NULL,0,NULL),(174,'174','0000-00-00','Prof. Atul H Chokshi','Department of Meterials Engineering','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(175,'175','0000-00-00','Prof. K L Chopra','M-70 Kirti Nagar','',' ','',156,NULL,6,0,'110015','',1,NULL,0,NULL),(176,'176','0000-00-00','Prof. V L Chopra','A3-210A, Janakpuri','',' ','',156,NULL,6,0,'110058','',1,NULL,0,NULL),(177,'177','0000-00-00','Dr B M Choudary','Managing Director','Ogene Systems India Pvt. Ltd.','11-6-56, GSR Estates Balanagar','',87,NULL,1,0,'500037','',1,NULL,0,NULL),(178,'178','0000-00-00','Dr V R Choudhary','Emeritus Scientist','Chemical Engineering Division','National Chemical Laboratory ','',173,NULL,17,0,'411008','',1,NULL,0,NULL),(179,'179','0000-00-00','Prof. Debajyoti Choudhury','Dept. of Physics & Astrophysics','University of Delhi',' ','',58,NULL,6,0,'110007','',1,NULL,0,NULL),(180,'180','0000-00-00','Prof. Debashish Chowdhury','Department of Physics','Indian Institute of Technology',' ','',107,NULL,28,0,'208016','',1,NULL,0,NULL),(181,'181','0000-00-00','Prof. Mihir Chowdhury','50U, Garcha Road','',' ','',116,NULL,30,0,'700019','',1,NULL,0,NULL),(182,'182','0000-00-00','Prof. R Cowsik','Department of Physics','Washington University','Campus Box 1105 One Brookings DriveSt. Louis, MO 63130-4899','',0,NULL,0,30,'0','',1,NULL,0,NULL),(183,'183','0000-00-00','Prof. Atish Dabholkar','Dept. of Theoretical Physics','Tata Inst. of Fundamental Research','Homi Bhabha Road ','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(184,'184','0000-00-00','Prof. S G Dani','School of Mathematics','Tata Institute of Fundamental','Research Homi Bhabha Road','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(185,'185','0000-00-00','Dr E H Daruwalla','Mulund Darshan Hsg. Society','E Wing, Flat 1139, VII Floor','Mulund Colony Mulund(West)','',142,NULL,17,0,'400082','',1,NULL,0,NULL),(186,'186','0000-00-00','Prof. Amita Das','','Institute for Plasma Research','Bhat ','',72,NULL,8,0,'382428','',1,NULL,0,NULL),(187,'187','0000-00-00','Dr Amitava Das','Analytical Science Discipline','Central Salt & Marine Chemicals','Research Institute ','',33,NULL,8,0,'364002','',1,NULL,0,NULL),(188,'188','0000-00-00','Dr B C Das','Director','BR Ambedkar Centre for Biomed. Res.','University of Delhi North Campus ','',58,NULL,6,0,'110007','',1,NULL,0,NULL),(189,'189','0000-00-00','Dr Pijush K Das','Deputy Director','Indian Inst. of Chemical Biology','4, Raja S.C. Mullick Road Jadavpur','',116,NULL,30,0,'700032','',1,NULL,0,NULL),(190,'190','0000-00-00','Prof. Prosad K Das','A/59, Kailash Colony','',' ','',156,NULL,6,0,'110048','',1,NULL,0,NULL),(191,'191','0000-00-00','Prof. Puspendu K Das','IPC Department','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(192,'192','0000-00-00','Prof. S P Das','School of Physical Sciences','Jawaharlal Nehru University',' ','',156,NULL,6,0,'110067','',1,NULL,0,NULL),(193,'193','0000-00-00','Prof. S R Das','Department of Physics & Astronomy','University of Kentucky',' Lexington, KY 40506','',0,NULL,0,30,'0','',1,NULL,0,NULL),(194,'194','0000-00-00','Prof. Samar K Das','School of Chemistry','University of Hyderabad','  Hyderabad 500046','',0,NULL,1,0,'500046','',1,NULL,0,NULL),(195,'195','0000-00-00','Prof. Saumitra Das','MCB Department','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(196,'196','0000-00-00','Dr Suresh Das','Director','National Institute for Interdisci-','nary Sciences & Technology ','',217,NULL,14,0,'695019','',1,NULL,0,NULL),(197,'197','0000-00-00','Prof. C K Das Gupta','Dept. of Biological Sciences','Indian Inst. of Science Education','& Research Mohanpur','',146,NULL,30,0,'741252','',1,NULL,0,NULL),(198,'198','0000-00-00','Dr B A Dasannacharya','No. 4, Beach Resort CHS','Sector 10A, Plot 1','Vashi ','',154,NULL,17,0,'400703','',1,NULL,0,NULL),(199,'199','0000-00-00','Prof. C Dasgupta','Department of Physics','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(200,'200','0000-00-00','Prof. Indranil Dasgupta','Dept. of Plant Molecular Biology','University of Delhi South Campus','Benito Juarez Road ','',156,NULL,6,0,'110021','',1,NULL,0,NULL),(201,'201','0000-00-00','Prof. Somnath Dasgupta','Vice Chancellor','Assam University',' ','',200,NULL,3,0,'788001','',1,NULL,0,NULL),(202,'202','0000-00-00','Prof. A C Dash','14(P), 369','Gajapati Nagar','NISER, Bhubaneswar ','',38,NULL,21,0,'751005','',1,NULL,0,NULL),(203,'203','0000-00-00','Dr P R Dastidar','F-3 Rajkunj Co-op. Housing Society','Wadhavli','Chembur ','',142,NULL,17,0,'400074','',1,NULL,0,NULL),(204,'204','0000-00-00','Dr A K Datta','Deputy Director','Indian Inst. of Chemical Biology','4, Raja S.C. Mullick Road ','',116,NULL,30,0,'700032','',1,NULL,0,NULL),(205,'205','0000-00-00','Prof. Asis Datta','School of Life Sciences','Jawaharlal Nehru University',' ','',156,NULL,6,0,'110067','',1,NULL,0,NULL),(206,'206','0000-00-00','Prof. Basudeb Datta','Department of Mathematics','Indian Institujte of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(207,'207','0000-00-00','Prof. Kasturi Datta','DBT Distinguished Biotechnology','Professor, School of Environmental','Sciences Jawaharlal Nehru University','',156,NULL,6,0,'110067','',1,NULL,0,NULL),(208,'208','0000-00-00','Prof. S Dattagupta','Vice Chancellor','Visva Bharati University',' ','',192,NULL,30,0,'731235','',1,NULL,0,NULL),(209,'209','0000-00-00','Prof. B M Deb','Adjunct Professor','Indian Inst. of Science Education','and Research, Bidhan Chandra KV PO Mohanpur','',146,NULL,30,0,'741252','',1,NULL,0,NULL),(210,'210','0000-00-00','Prof. Kalyanmoy Deb','Dept. of Mechanical Engineering','Indian Institute of Technology',' ','',107,NULL,28,0,'208016','',1,NULL,0,NULL),(211,'211','0000-00-00','Prof. B L Deekshatulu','House 10-3-123/3','East Maredpally',' ','',195,NULL,1,0,'500026','',1,NULL,0,NULL),(212,'212','0000-00-00','Prof.  Deepak Kumar','School of Physical Sciences','Jawaharlal Nehru University',' ','',156,NULL,6,0,'110067','',1,NULL,0,NULL),(213,'213','0000-00-00','Prof. M G Deo','C-13, Kubera Gulshan Apartments','DP Road','Aundh ','',173,NULL,17,0,'411007','',1,NULL,0,NULL),(214,'214','0000-00-00','Prof. S M Deshpande','Engineering Mechanics Unit','Jawaharlal Nehru Centre for','Advanced Scientific Research Jakkur','',28,NULL,13,0,'560064','',1,NULL,0,NULL),(215,'215','0000-00-00','Prof. G R Desiraju','S.S.C.U.','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(216,'216','0000-00-00','Prof. B N Dev','Department of Materials Science','Indian Assn. for the Cultivation','of Science Jadavpur','',116,NULL,30,0,'700032','',1,NULL,0,NULL),(217,'217','0000-00-00','Dr Gautam Kumar Dey','Materials Science Division','Bhabha Atomic Research Centre',' ','',142,NULL,17,0,'400085','',1,NULL,0,NULL),(218,'218','0000-00-00','Prof. Subhasish Dey','Dept. of Civil Engineering','Indian Institute of Technology',' ','',112,NULL,30,0,'721302','',1,NULL,0,NULL),(219,'219','0000-00-00','Prof. Abhishek Dhar','Theoretical Physics Group','Raman Research Institute',' ','',28,NULL,13,0,'560080','',1,NULL,0,NULL),(220,'220','0000-00-00','Prof. D Dhar','Theoretical Physics Group','Tata Inst. of Fundamental Research','Homi Bhabha Road ','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(221,'221','0000-00-00','Prof. K Dharmalingam','School of Biotechnology','Madurai Kamaraj University',' ','',129,NULL,26,0,'625021','',1,NULL,0,NULL),(222,'222','0000-00-00','Prof. Dilip D Dhavale','Department of Chemistry','University of Pune',' ','',173,NULL,17,0,'411007','',1,NULL,0,NULL),(223,'223','0000-00-00','Prof. S V Dhurandhar','Inter-University Centre for','Astronomy & Astrophysics','Post Bag 4, Ganeshkhind ','',173,NULL,17,0,'411007','',1,NULL,0,NULL),(224,'224','0000-00-00','Dr Rajan Dighe','MRDG','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(225,'225','0000-00-00','Dr Madhu Dikshit','Head, Cardiovascular Pharmacology','Unit','Central Drug Research Institute P.B. No. 173','',127,NULL,28,0,'226001','',1,NULL,0,NULL),(226,'226','0000-00-00','Dr M Dileep Kumar','Chemical Oceanography Division','National Institute of Oceanography',' ','',64,NULL,7,0,'403004','',1,NULL,0,NULL),(227,'227','0000-00-00','Prof. Sushil Dua-Sharma','503, 6th A Main, 12th Cross','HIG Colony','RMV II Stage ','',28,NULL,13,0,'560094','',1,NULL,0,NULL),(228,'228','0000-00-00','Prof. M Durga Prasad','School of Chemistry','University of Hyderabad',' ','',87,NULL,1,0,'500046','',1,NULL,0,NULL),(229,'229','0000-00-00','Prof. Pradip Dutta','Dept. of Mechanical Engineering','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(230,'230','0000-00-00','Prof. Aparna Dutta Gupta','Dept. of Animal Sciences','School of Life Sciences','University of Hyderabad ','',87,NULL,1,0,'500046','',1,NULL,0,NULL),(231,'231','0000-00-00','Prof. S C Dutta Roy','164, SFS Apartments','Hauz Khas',' ','',156,NULL,6,0,'110016','',1,NULL,0,NULL),(232,'232','0000-00-00','Prof. K R K Easwaran','Emeritus Professor','Molecular Biophysics Unit','Indian Institute of Science ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(233,'233','0000-00-00','Prof. R Gadagkar','Centre for Ecological Sciences','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(234,'234','0000-00-00','Prof. Madhav Gadgil','Emeritus Professor','Biodiversity Department','Garware College Karve Road','',173,NULL,17,0,'411004','',1,NULL,0,NULL),(235,'235','0000-00-00','Prof. Sulochana Gadgil','A 18, Spring Flowers','Panchavati','Pashan ','',173,NULL,17,0,'411008','',1,NULL,0,NULL),(236,'236','0000-00-00','Prof. S R Gadre','Department of Chemistry','Indian Institute of Technology',' ','',107,NULL,28,0,'208016','',1,NULL,0,NULL),(237,'237','0000-00-00','Dr B B Gaitonde','Banda District','',' ','',202,NULL,17,0,'416511','',1,NULL,0,NULL),(238,'238','0000-00-00','Dr Sanjeev Galande','Indian Institute of Science Edn.','& Research','6th Floor, I Tower, Sai Trinity Sutarwadi, Pashan','',173,NULL,17,0,'411021','',1,NULL,0,NULL),(239,'239','0000-00-00','Prof. K S Gandhi','Honorary Professor','Dept. of Chemical Engineering','Indian Institute of Science ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(240,'240','0000-00-00','Prof. K N Ganesh','Director','Indian Inst. of Science Education','& Research, 900, NCL Innovation Dr Homi Bhabha Road','',173,NULL,17,0,'411008','',1,NULL,0,NULL),(241,'241','0000-00-00','Prof. K N Ganeshaiah','Principal Scientist, Pulses','Dept. of Genetics & Plant Breeding','University of Agricultural Sciences GKVK','',28,NULL,13,0,'560065','',1,NULL,0,NULL),(242,'242','0000-00-00','Dr S V Gangal','Lakshmi Niwas','Opp. Santoshi Mata Temple (B Cabin)','Sane Guruji Path Naupada','',216,NULL,17,0,'400602','',1,NULL,0,NULL),(243,'243','0000-00-00','Dr Sudha G Gangal','4, Mahavishnu Apartments','Dahanukar Colony A','Kothrud ','',173,NULL,17,0,'411029','',1,NULL,0,NULL),(244,'244','0000-00-00','Prof. Ashok K Ganguli','Department of Chemistry','Indian Institute of Technology','Hauz Khas ','',156,NULL,6,0,'110016','',1,NULL,0,NULL),(245,'245','0000-00-00','Prof. S N Ganguli','Flat No. 6, Aspiration Apartments','32, Francois Martin Street','Kuruchikuppam ','',172,NULL,23,0,'605012','',1,NULL,0,NULL),(246,'246','0000-00-00','Dr C Ganguly','President','Cameco India Office','402, Galaxy Tower 7/101/1, Scientist Colony,Habsiguda','',87,NULL,1,0,'500007','',1,NULL,0,NULL),(247,'247','0000-00-00','Dr N K Ganguly','Translational Health Science and','Technology Institute','c/o National Inst. of Immunology Aruna Asaf Ali Marg','',156,NULL,6,0,'110067','',1,NULL,0,NULL),(248,'248','0000-00-00','Dr P Ganguly','Flat 8B, Montvert I','140/1A, Pashan Sus','Pashan ','',173,NULL,17,0,'411021','',1,NULL,0,NULL),(249,'249','0000-00-00','Prof. V K Gaur','Distinguished Professor','Indian Institute of Astrophysics','Sarjapur Road ','',28,NULL,13,0,'560034','',1,NULL,0,NULL),(250,'250','0000-00-00','Prof. Rajiv V Gavai','Theoretical Physics Department','Tata Inst. of Fundamental Research','Homi Bhabha Road ','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(251,'251','0000-00-00','Prof. M V George','Honorary Professor','Photosciences & Photonics Division','National Inst. for Interdiscipter- disciplinary Science & Techno','',217,NULL,14,0,'695019','',1,NULL,0,NULL),(252,'252','0000-00-00','Dr K H Gharda','Chairman and Managing Director','Gharda Chemicals Limited','Jer Mansion, W.P. Warde Road Off Turner Road, Bandra','',142,NULL,17,0,'400050','',1,NULL,0,NULL),(253,'253','0000-00-00','Dr Amit Ghosh','Emeritus Scientist','National Institute of Cholrea and','Enteric Diseases, JICA Building CIT Scheme XM, Baliaghata','',116,NULL,30,0,'700010','',1,NULL,0,NULL),(254,'254','0000-00-00','Prof. Amitabha Ghosh','NASI Senior Scientist','Bengal Engineering and Science','University Shibpur, Botanic Garden P.O.','',85,NULL,30,0,'711103','',1,NULL,0,NULL),(255,'255','0000-00-00','Prof. Aswini Ghosh','Dept. of Solid State Physics','Indian Assn. for the Cultivation','of Science Jadavpur','',116,NULL,30,0,'700032','',1,NULL,0,NULL),(256,'256','0000-00-00','Dr Balaram Ghosh','Head, Genetics & Molecular Medicine','Institute of Genomics & Integrative','Biology Mall Road','',58,NULL,6,0,'110007','',1,NULL,0,NULL),(257,'257','0000-00-00','Dr J K Ghosh','Professor Emeritus','Indian Statistical Institute','203, B.T. Road ','',116,NULL,30,0,'700108','',1,NULL,0,NULL),(258,'258','0000-00-00','Prof. Mrinal K Ghosh','Department of Mathematics','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(259,'259','0000-00-00','Dr P K Ghosh','Director','Central Salt & Marine Chemicals','Research Institute ','',33,NULL,8,0,'364002','',1,NULL,0,NULL),(260,'260','0000-00-00','Prof. Subir K Ghosh','School of Computer Science','Tata Institute of Fundamental','Research Homi Bhabha Road','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(261,'261','0000-00-00','Prof. Subrata Ghosh','Dept. of Organic Chemistry','Indian Assn. for the Cultivation','of Science Jadavpur','',116,NULL,30,0,'700032','',1,NULL,0,NULL),(262,'262','0000-00-00','Dr Swapan K Ghosh','Head, Theoretical Chemistry Section','Chemistry Division','Bhabha Atomic Research Centre Trombay','',142,NULL,17,0,'400085','',1,NULL,0,NULL),(263,'263','0000-00-00','Prof. Swarna Kanti Ghosh','Centre Director','Natl. Centre for Radio Astrophysics','Ganeshkhind ','',173,NULL,17,0,'411007','',1,NULL,0,NULL),(264,'264','0000-00-00','Prof. Rohini M Godbole','Centre for High Energy Physics','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(265,'265','0000-00-00','Dr B K Godwal','28, Creekview Co-op. Housing Soc.','Plot No. 33, Sector 9A','Vashi ','',154,NULL,17,0,'400703','',1,NULL,0,NULL),(266,'266','0000-00-00','Dr P S Goel','Chairman','RAC (DRDO)','Lucknow Road Timarpur','',156,NULL,6,0,'110054','',1,NULL,0,NULL),(267,'267','0000-00-00','Dr Rajesh S Gokhale','Director','Institute of Genomics & Integrative','Biology University Campus, Mall Road','',58,NULL,6,0,'110007','',1,NULL,0,NULL),(268,'268','0000-00-00','Prof. R Gopakumar','Harish Chandra Research Institute','Chhatnag Road','Jhusi ','',8,NULL,28,0,'211019','',1,NULL,0,NULL),(269,'269','0000-00-00','Prof.  Gopal Krishna','Dean, National Centre for Radio','Astrophysics, TIFR','Pune University Campus P.B.No. 3, Ganeshkhind','',173,NULL,17,0,'411007','',1,NULL,0,NULL),(270,'270','0000-00-00','Prof. J Gopalakrishnan','S.S.C.U.','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(271,'271','0000-00-00','Dr C Gopalan','39, Landon\'s Road','Kilpauk',' ','',50,NULL,26,0,'600010','',1,NULL,0,NULL),(272,'272','0000-00-00','Dr K Gopalan','INSA Senior Scientist','National Geophysical Research','Institute Uppal Road','',87,NULL,1,0,'500606','',1,NULL,0,NULL),(273,'273','0000-00-00','Dr K R Gopidas','Photosciences & Photonics Division','NIIST',' ','',217,NULL,14,0,'695019','',1,NULL,0,NULL),(274,'274','0000-00-00','Dr C S Gopinath','Catalysis Division','National Chemical Laboratory',' ','',173,NULL,17,0,'411008','',1,NULL,0,NULL),(275,'275','0000-00-00','Prof. Gomathy Gopinath','Flat No. 001, Kanchanjunga Apts.','122/2, CV Raman Nagar','Nagavarapalya ','',28,NULL,13,0,'560093','',1,NULL,0,NULL),(276,'276','0000-00-00','Prof. K P Gopinathan','Abhiman','369, 11th Cross','II Block, RT Nagar ','',28,NULL,13,0,'560032','',1,NULL,0,NULL),(277,'277','0000-00-00','Prof. M S Gopinathan','Professor','Indian InST. of Science Education','& Research CET Campus','',217,NULL,14,0,'695016','',1,NULL,0,NULL),(278,'278','0000-00-00','Prof. Anil P Gore','Bakul','40, Empress Garden Society','Sopan Baug  Pune 411 001','',0,NULL,17,0,'411007','',1,NULL,0,NULL),(279,'279','0000-00-00','Prof. B N Goswami','Director','Indian Institute of Tropical','Meteorology Dr Homi Bhabha Road, Pashan','',173,NULL,17,0,'411008','',1,NULL,0,NULL),(280,'280','0000-00-00','Prof. J N Goswami','Director','Physical Research Laboratory','Navrangpura ','',2,NULL,8,0,'380009','',1,NULL,0,NULL),(281,'281','0000-00-00','Dr Ravinder Goswami','Department of Endocrinology','& Metabolism','All India Institute of Medical Sciences, Ansari Nagar','',156,NULL,6,0,'110029','',1,NULL,0,NULL),(282,'282','0000-00-00','Prof. Sreebrata Goswami','Department of Inorganic Chemistry','Indian Association for the','Cultivation of Science Jadavpur','',116,NULL,30,0,'700032','',1,NULL,0,NULL),(283,'283','0000-00-00','Prof. G Govil','302, Vigyan Shila','Juhu-Varsova Link Road','7 Bungalows ','',142,NULL,17,0,'400061','',1,NULL,0,NULL),(284,'284','0000-00-00','Prof. Rama Govindarajan','Engineering Mechanics Unit','Jawaharlal Nehru Centre for Adv.','Scientific Research Jakkur P.O.','',28,NULL,13,0,'560064','',1,NULL,0,NULL),(285,'285','0000-00-00','Dr V R Gowariker','Mukta Apartments','93, A/2-3, Flat No. 2','Senapati Bapat Road Shivajinagar','',173,NULL,17,0,'411016','',1,NULL,0,NULL),(286,'286','0000-00-00','Dr J Gowrishankar','Director','Centre for DNA Fingerprinting and','Diagnostics, Bldg. 7, Gruhakalpa 5-4-399/B, Nampalli Hyderabad 5','',0,NULL,1,0,'500076','',1,NULL,0,NULL),(287,'287','0000-00-00','Prof. Anil Grover','Dept. of Plant Molecular Biology','University of Delhi South Campus','Benito Juarez Road ','',156,NULL,6,0,'110021','',1,NULL,0,NULL),(288,'288','0000-00-00','Prof. Arun K Grover','Dept. of Condensed Matter Physics &','Materials Science','Tata Inst. of Fundamental Research Homi Bhabha Road','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(289,'289','0000-00-00','Prof. Alok K Gupta','Emeritus Professor','National Centre of Experimental','Mineralogy & Petrology University of Allahabad','',8,NULL,28,0,'211002','',1,NULL,0,NULL),(290,'290','0000-00-00','Dr Anil Kumar Gupta','Director','Wadia Inst. of Himalayan Geology','33, Gen. Mahadeo Singh Road ','',57,NULL,29,0,'248001','',1,NULL,0,NULL),(291,'291','0000-00-00','Dr C M Gupta','DBT Distinguished Botechnologist','Central Drug Research Institute','Post Box 173 Chattar Manzil','',127,NULL,28,0,'226001','',1,NULL,0,NULL),(292,'292','0000-00-00','Prof. L C Gupta','No. 403, Vigyanshila Co-op. Housing','Society','Juhu-Varsova Link Road Andheri (West)','',142,NULL,17,0,'400061','',1,NULL,0,NULL),(293,'293','0000-00-00','Prof. P K Gupta','Honorary Emeritus Professor','Dept. of Genetics & Plant Breeding','CCS University ','',137,NULL,28,0,'250005','',1,NULL,0,NULL),(294,'294','0000-00-00','Dr Pradeep K Gupta','Head, Biomedical Applications Sec.','Centre for Advanced Technology',' ','',90,NULL,18,0,'452013','',1,NULL,0,NULL),(295,'295','0000-00-00','Prof. Santosh K Gupta','Dept. of Chemical Engineering','Indian Institute of Technology',' ','',107,NULL,28,0,'208016','',1,NULL,0,NULL),(296,'296','0000-00-00','Dr Satish K Gupta','Staff Scientist VII and Chief','Reproductive Cell Biology Unit','National Institute of Immunology Aruna Asaf Ali Marg','',156,NULL,6,0,'110067','',1,NULL,0,NULL),(297,'297','0000-00-00','Prof. Sourendu Gupta','Dept. of Theoretical Physics','Tata Inst. of Fundamental Research','Homi Bhabha Road ','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(298,'298','0000-00-00','Dr Yashwant Gupta','National Centre for Radio','Astrophysics','Ganeshkhind ','',173,NULL,17,0,'411007','',1,NULL,0,NULL),(299,'299','0000-00-00','Mr D Guptasarma','203, Kakatiya Apartments','Street No. 2','Habshiguda ','',87,NULL,1,0,'500007','',1,NULL,0,NULL),(300,'300','0000-00-00','Dr M K Gurjar','Director, R&D','Emcure Pharmaceuticals Limited','ITBT Park Phase II Hinjwadi','',173,NULL,17,0,'411057','',1,NULL,0,NULL),(301,'301','0000-00-00','Prof. Atul Gurtu','Distinguished Professor','King Abdulaziz University',' Jeddah','',0,NULL,0,23,'0','',1,NULL,0,NULL),(302,'302','0000-00-00','Prof. T N Guru Row','S.S.C.U.','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(303,'303','0000-00-00','Dr S A Haider','Space & Atmospheric Science Divn.','Physical Research Laboratory','Navrangpura ','',2,NULL,8,0,'380009','',1,NULL,0,NULL),(304,'304','0000-00-00','Prof. R J Hans-Gill','NBHM Visiting Professor','Department of Mathematics','Panjab University ','',48,NULL,31,0,'160014','',1,NULL,0,NULL),(305,'305','0000-00-00','Dr P Hariharan','608, Baron Dekalb Road','',' Wayne, PA 19087','',0,NULL,0,30,'0','',1,NULL,0,NULL),(306,'306','0000-00-00','Prof. Jayant R Haritsa','SERC','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(307,'307','0000-00-00','Prof.  Harjit Singh','Professor Emeritus','Dept. of Chemistry','Guru Nanak Dev University ','',13,NULL,22,0,'143005','',1,NULL,0,NULL),(308,'308','0000-00-00','Dr Gaiti Hasan','National Centre for Biological','Sciences','GKVK Campuas ','',28,NULL,13,0,'560065','',1,NULL,0,NULL),(309,'309','0000-00-00','Dr S E Hasnain','','School of Biological Sciences','Indian Institute of Technology ','',156,NULL,6,0,'110016','',1,NULL,0,NULL),(310,'310','0000-00-00','Prof. M S Hegde','S.S.C.U.','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(311,'311','0000-00-00','Prof. R V Hosur','Department of Chemical Sciences','Tata Inst. of Fundamental Research','Homi Bhabha Road ','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(312,'312','0000-00-00','Prof. H Ila','Apt. 002, Block VIII','Heritage Estate','Doddaballapur Road, Yelahanka ','',28,NULL,13,0,'560064','',1,NULL,0,NULL),(313,'313','0000-00-00','Prof.  Indira Nath','707, Sarvapriya Apartments','Sarvapriya Vihar',' ','',156,NULL,6,0,'110016','',1,NULL,0,NULL),(314,'314','0000-00-00','Dr Abhaya Indrayan','A037, Telecom City','B 9/6, Sector 62',' ','',158,NULL,28,0,'201309','',1,NULL,0,NULL),(315,'315','0000-00-00','Prof. Javed Iqbal','Director','Institute of Life Sciences','University of Hyderabad Campus Gachibowli','',87,NULL,1,0,'500046','',1,NULL,0,NULL),(316,'316','0000-00-00','Dr J J Irani','Director','Tata Sons Limited','Bombay House, 24, Homi Modi Street Fort','',142,NULL,17,0,'400001','',1,NULL,0,NULL),(317,'317','0000-00-00','Prof. R N Iyengar','Centre for Advanced R & D','SEM Jain College of Engineering','Jain International Campus Kanakapura Road, Jakkasandra Post','',28,NULL,13,0,'562112','',1,NULL,0,NULL),(318,'318','0000-00-00','Prof. K T Jacob','Honorary Professor','Dept. of Materials Engineedring','Indian Institute of Science ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(319,'319','0000-00-00','Prof. T M Jacob','51, 10th Cross','West of Chord Road','II Stage ','',28,NULL,13,0,'560086','',1,NULL,0,NULL),(320,'320','0000-00-00','Dr T Jacob John','439, Civil Supplied Godown Lane','Kamalakshipuram',' ','',233,NULL,26,0,'632002','',1,NULL,0,NULL),(321,'321','0000-00-00','Dr N R Jagannathan','C-II-17, AIIMS Quarters','Ansari Nagar East',' ','',156,NULL,6,0,'110029','',1,NULL,0,NULL),(322,'322','0000-00-00','Dr V Jagannathan','F1, Kumar Classics','Aundh',' ','',173,NULL,17,0,'411007','',1,NULL,0,NULL),(323,'323','0000-00-00','Prof. D V S Jain','1529, Sector 49B','Pushpac Enclave',' ','',48,NULL,31,0,'160047','',1,NULL,0,NULL),(324,'324','0000-00-00','Dr H K Jain','40, Suryaniketan','I.P. Extension II',' ','',58,NULL,6,0,'110092','',1,NULL,0,NULL),(325,'325','0000-00-00','Prof. Sanjay Jain','Department of Physics','University of Delhi',' ','',58,NULL,6,0,'110007','',1,NULL,0,NULL),(326,'326','0000-00-00','Prof. M S Jairajpuri','INSA Senior Scientist','Department of Zoology','Aligarh Muslim University ','',7,NULL,28,0,'202002','',1,NULL,0,NULL),(327,'327','0000-00-00','Dr S Jameel','Virology Group','International Centre for Genetic','Engineering & Biotechnology Aruna Asaf Ali Marg','',156,NULL,6,0,'110067','',1,NULL,0,NULL),(328,'328','0000-00-00','Prof. A Jayakrishnan','Vice Chancellor','University of Kerala',' ','',217,NULL,14,0,'695034','',1,NULL,0,NULL),(329,'329','0000-00-00','Prof. A M Jayannavar','Director','Institute of Physics','Sachivalaya Marg ','',38,NULL,21,0,'751005','',1,NULL,0,NULL),(330,'330','0000-00-00','Prof. Vikram Jayaram','Dept. of Materials Engineering','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(331,'331','0000-00-00','Prof. A Jayaraman','No. 15906','Lahinch Circle',' Odessa, Florida - 33556','',0,NULL,0,30,'0','',1,NULL,0,NULL),(332,'332','0000-00-00','Prof. Achuthan Jayaraman','Director','National Atmospheric Research','Laboratory P. B. No.123','',221,NULL,1,0,'517502','',1,NULL,0,NULL),(333,'333','0000-00-00','Prof. N Jayaraman','Dept. of Organic Chemistry','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(334,'334','0000-00-00','Prof. R Jayaraman','R.H. 35','Palaami Enclave','Reserve Line New Natham Road','',129,NULL,26,0,'625014','',1,NULL,0,NULL),(335,'335','0000-00-00','Prof. E D Jemmis','Director','Indian Insti. of Science Education','and Research CET Campus','',217,NULL,14,0,'695016','',1,NULL,0,NULL),(336,'336','0000-00-00','Dr P K Jena','Chairman','Inst. of Advance Technology and','Environmental Studies 80A-81A, Lewis Road','',38,NULL,21,0,'751002','',1,NULL,0,NULL),(337,'337','0000-00-00','Prof. S S Jha','402, Vigyanshila','Juhu-Varsova Link Road','7 Bungalows Andheri (W)','',142,NULL,17,0,'400061','',1,NULL,0,NULL),(338,'338','0000-00-00','Prof. Ashok Jhunjhunwala','Dept. of Electrical Engineering','Indian Institute of Technology',' ','',50,NULL,26,0,'600036','',1,NULL,0,NULL),(339,'339','0000-00-00','Prof. Chanda J Jog','Department of Physics','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(340,'340','0000-00-00','Prof. P I John','Meghnad Saha Chair','Institute for Plasma Research','Bhat ','',72,NULL,8,0,'382428','',1,NULL,0,NULL),(341,'341','0000-00-00','Prof. M M Johri','Flat No. 32, New Cosmos','Juhu-Versova Link Road','Andheri (W) ','',142,NULL,17,0,'400053','',1,NULL,0,NULL),(342,'342','0000-00-00','Prof. George Joseph','12/D1, Sterling City','Bopal',' ','',2,NULL,8,0,'380058','',1,NULL,0,NULL),(343,'343','0000-00-00','Prof. K T Joseph','TIFR-CAM','Sharadanagar','PB No. 6503 ','',28,NULL,13,0,'560065','',1,NULL,0,NULL),(344,'344','0000-00-00','Dr Amitabh Joshi','Evolutionary & Organismal Biology','Unit, Jawaharlal Nehru Centre for','Advanced Scientific Research Jakkur P.O.','',28,NULL,13,0,'560064','',1,NULL,0,NULL),(345,'345','0000-00-00','Dr B S Joshi','1738, Kinsmon Cove','',' Marietta, GA 30062','',0,NULL,0,30,'0','',1,NULL,0,NULL),(346,'346','0000-00-00','Prof. J B Joshi','Homi Bhabha Chair Professor','Homi Bhabha National Institute','Anushakti Nagar ','',142,NULL,17,0,'400085','',1,NULL,0,NULL),(347,'347','0000-00-00','Prof. N V Joshi','Centre for Ecological Sciences','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(348,'348','0000-00-00','Prof. S K Joshi','Vikram Sarabhai Professor','National Physical Laboratory','Dr K.S. Krishnan Road ','',156,NULL,6,0,'110012','',1,NULL,0,NULL),(349,'349','0000-00-00','Prof. A S Joshipura','Theory Group','Physical Research Laboratory','Navrangpura ','',2,NULL,8,0,'380009','',1,NULL,0,NULL),(350,'350','0000-00-00','Prof. H Junjappa','Flat No. 002, Block 8','Heritage Estate','Doddaballapur Road Yelahanka','',28,NULL,13,0,'560064','',1,NULL,0,NULL),(351,'351','0000-00-00','Dr S Kailas','Director, Physics Group','Bhabha Atomic Research Centre','Trombay ','',142,NULL,17,0,'400085','',1,NULL,0,NULL),(352,'352','0000-00-00','Dr Anil Kakodkar','DAE Homi Bhabha Chair Professor','Bhabha Atomic Research Centre','7th Floor, Central Complex Trombay','',142,NULL,17,0,'400085','',1,NULL,0,NULL),(353,'353','0000-00-00','Dr A P J Abdul Kalam','10, Rajaji Marg','',' ','',156,NULL,6,0,'110011','',1,NULL,0,NULL),(354,'354','0000-00-00','Prof. S Kalyanaraman','2, Central Street','Kilpauk Garden Colony',' ','',50,NULL,26,0,'600010','',1,NULL,0,NULL),(355,'355','0000-00-00','Prof. A K Kamal','18, Crystal Circle','',' Burlington, MA 01803','',0,NULL,0,30,'0','',1,NULL,0,NULL),(356,'356','0000-00-00','Dr A K Kamra','INSA Senior Scientist','Indian Institute of Tropical','Meteorology Dr Homi Bhabha Road, Pashan','',173,NULL,17,0,'411008','',1,NULL,0,NULL),(357,'357','0000-00-00','Dr Gagandeep Kang','Dept. of Gastrointestinal Sciences','Christian Medical College',' ','',233,NULL,26,0,'632004','',1,NULL,0,NULL),(358,'358','0000-00-00','Prof. D G Kanhere','Department of Physics','Central University of Rajasthan','City Road ','',121,NULL,24,0,'305802','',1,NULL,0,NULL),(359,'359','0000-00-00','Dr K Kannan','F-206, Redwood','Raheja Residency','III Block, Koramangala ','',28,NULL,13,0,'560034','',1,NULL,0,NULL),(360,'360','0000-00-00','Prof. V Kannan','School of Mathematics and','Computer/Information Sciences','University of Hyderabad ','',87,NULL,1,0,'500046','',1,NULL,0,NULL),(361,'361','0000-00-00','Prof. Tarun Kant','Department of Civil Engineering','Indian Institute of Technology','Powai ','',142,NULL,17,0,'400076','',1,NULL,0,NULL),(362,'362','0000-00-00','Dr S S Kapoor','DAE Homi Bhabha Professor','6th Floor, C.C.','Bhabha Atomic Research Centre Trombay','',142,NULL,17,0,'400085','',1,NULL,0,NULL),(363,'363','0000-00-00','Prof. P C Kapur','R-485, Rajindernagar','',' ','',156,NULL,6,0,'110060','',1,NULL,0,NULL),(364,'364','0000-00-00','Dr R L Karandikar','Director, Chennai Math. Institute','Plot H1, Sipcot IT Park','Padur P.O., Siruseri ','',50,NULL,26,0,'603103','',1,NULL,0,NULL),(365,'365','0000-00-00','Dr Ullas K Karanth','Director','Centre for Wildlife Studies','403, Seebo Apartments 26-2, Aga Abbas Ali Road','',28,NULL,13,0,'560042','',1,NULL,0,NULL),(366,'366','0000-00-00','Dr C C Kartha','Professor of Eminence','Rajiv Gandhi Centre for y','Biotechnology, Jagathi ','',217,NULL,14,0,'695014','',1,NULL,0,NULL),(367,'367','0000-00-00','Dr V B Kartha','21, Udayagiri','Sion-Trombay Road','Deonar ','',142,NULL,17,0,'400088','',1,NULL,0,NULL),(368,'368','0000-00-00','Dr D P Kasbekar','Scientist','Centre for Cellular & Molecular','Biology Uppal Road','',87,NULL,1,0,'500007','',1,NULL,0,NULL),(369,'369','0000-00-00','Prof. T R Kasturi','No. 51, Sharada Colony','West ofChord Road, III Stage','IV Block, Basaveswaranagar ','',28,NULL,13,0,'560079','',1,NULL,0,NULL),(370,'370','0000-00-00','Dr K Kasturirangan','Member, Planning Commission','Room No. 119, Yojana Bhavan','Parliament Street ','',156,NULL,6,0,'110001','',1,NULL,0,NULL),(371,'371','0000-00-00','Dr V M Katoch','Secretary','Department of Health Research','Ramalingaswami Bhavan Ansari Nagar','',156,NULL,6,0,'110029','',1,NULL,0,NULL),(372,'372','0000-00-00','Prof. R K Kaul','Institute of Mathematical Sciences','CIT Campus, Taramani',' ','',50,NULL,26,0,'600113','',1,NULL,0,NULL),(373,'373','0000-00-00','Prof. S N Kaul','Dean, School of Physics','University of Hyderabad',' ','',87,NULL,1,0,'500046','',1,NULL,0,NULL),(374,'374','0000-00-00','Prof. P K Kaw','Director','Institute for Plasma Research','Bhat ','',72,NULL,8,0,'382428','',1,NULL,0,NULL),(375,'375','0000-00-00','Prof. A K Kembhavi','Director','IU Centre for Astronomy','A Astrophysics (IUCAA) Ganeshkhind','',173,NULL,17,0,'411007','',1,NULL,0,NULL),(376,'376','0000-00-00','Dr C Kempanna','82, II Main','III Cross','Ganganagar ','',28,NULL,13,0,'560032','',1,NULL,0,NULL),(377,'377','0000-00-00','Dr U W Kenkare','D/3 Deeplakshmi Coop. Hsg Soc. Ltd','Hatiskar Marg','Prabhadevi Sea Beach Prabhadevi','',142,NULL,17,0,'400025','',1,NULL,0,NULL),(378,'378','0000-00-00','Dr S Kesavan','Institute of Mathematical Sciences','CIT Campus, Taramani',' ','',50,NULL,26,0,'600113','',1,NULL,0,NULL),(379,'379','0000-00-00','Prof. S V Kessar','Department of Chemistry','Panjab University',' ','',48,NULL,31,0,'160014','',1,NULL,0,NULL),(380,'380','0000-00-00','Prof. D V Khakhar','Director','Indian Inst. of Technology Bombay','Powai ','',142,NULL,17,0,'400076','',1,NULL,0,NULL),(381,'381','0000-00-00','Prof. F A Khan','Professor and Head','Department of Chemistry','Indian Institute of Technology Ordnance Factory Estate','',238,NULL,1,0,'502205','',1,NULL,0,NULL),(382,'382','0000-00-00','Prof. Sudesh K Khanduja','Professor of Mathematics','IISER Mohali','Knowledge City, Sector 81 SAS Nagar','',132,NULL,31,0,'140306','',1,NULL,0,NULL),(383,'383','0000-00-00','Prof. A V Khare','DAE Raja Ramanna Fellow','Indian Inst. of Science Edn. &','Research (IISER) Garware Circle, Pashan','',173,NULL,17,0,'411021','',1,NULL,0,NULL),(384,'384','0000-00-00','Prof. Jitendra P Khurana','Dept. of Plant Molecular Biology','University of Delhi South Campus','Benito Juarez Road ','',156,NULL,6,0,'110021','',1,NULL,0,NULL),(385,'385','0000-00-00','Prof. Paramjit Khurana','Dept. of Plant Molecular Biology','University of Delhi South Campus','Benito Juarez Road ','',156,NULL,6,0,'110021','',1,NULL,0,NULL),(386,'386','0000-00-00','Dr G S Khush','39399, Blackhawk Place','',' Davis, CA 95616-7008','',0,NULL,0,30,'0','',1,NULL,0,NULL),(387,'387','0000-00-00','Dr N Kochupillai','Flat No. 401, Housing Building','International Tech Park Limited','Whitefield ','',28,NULL,13,0,'560068','',1,NULL,0,NULL),(388,'388','0000-00-00','Prof. R K Kohli','Chairman','Department of Botany','Panjab University ','',48,NULL,31,0,'160014','',1,NULL,0,NULL),(389,'389','0000-00-00','Prof. Sambasiva R Kotha','Department of Chemistry','Indian Institute of Technology','Powai ','',142,NULL,17,0,'400076','',1,NULL,0,NULL),(390,'390','0000-00-00','Dr K S Krishna','Geological Oceanography Division','National Institute of Oceanography',' ','',64,NULL,7,0,'403004','',1,NULL,0,NULL),(391,'391','0000-00-00','Prof. P Krishna','Krishnamurti Foundation India','Rajghat Fort',' ','',231,NULL,28,0,'221001','',1,NULL,0,NULL),(392,'392','0000-00-00','Prof. R Krishna','Van\'t Hoff Inst. of Mol. Science','University of Amsterdam','Science Park 904 1098 XH Amsterdam','',0,NULL,0,18,'0','',1,NULL,0,NULL),(393,'393','0000-00-00','Dr E Krishna Kumar','Dept. of Nuclear & Atomic Physics','Tata Inst. of Fundamental Research','Homi Bhabha Road ','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(394,'394','0000-00-00','Prof. A V Krishna Murty','No. 8, 5th Main','II Cross','NTI Layout, RMV II Stage Nagashettyhalli','',28,NULL,13,0,'560094','',1,NULL,0,NULL),(395,'395','0000-00-00','Prof. K S Krishna Swamy','204, Sigma Tower','Plot 32, Gorai Road','Borivali (W) ','',142,NULL,17,0,'400091','',1,NULL,0,NULL),(396,'396','0000-00-00','Dr K Krishnakumar','Indian Institute of Tropical','Meteorology','Dr Homi Bhabha Road ','',173,NULL,17,0,'411008','',1,NULL,0,NULL),(397,'397','0000-00-00','Prof. G Krishnamoorthy','Dean, Graduate Studies','Tata Inst. of Fundamental Research','Homi Bhabha Road ','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(398,'398','0000-00-00','Dr K Krishnamoorthy','Project Director, ARFI','Space Physics Laboratory','Vikram Sarabhai Space Centre ','',217,NULL,14,0,'695022','',1,NULL,0,NULL),(399,'399','0000-00-00','Prof. E V Krishnamurthy','CS Labs, Building 115','ANU College of Engineering &','Computer Science Canberra ACT 0200','',0,NULL,0,1,'0','',1,NULL,0,NULL),(400,'400','0000-00-00','Prof. H R Krishnamurthy','Department of Physics','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(401,'401','0000-00-00','Prof. S S Krishnamurthy','INSA Honorary Scientist','IPC Department','Indian Institute of Science ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(402,'402','0000-00-00','Dr R Krishnan','F-3, Parkside Manor','162, 5th Main','Defence Colony ','',28,NULL,13,0,'560038','',1,NULL,0,NULL),(403,'403','0000-00-00','Dr S Krishnan','49, II Cross','P&T Colony','R.T. Nagar ','',28,NULL,13,0,'560032','',1,NULL,0,NULL),(404,'404','0000-00-00','Prof. V Krishnan','Hindustan Lever Research Professor','Jawaharlal Nehru Centre for','Advanced Scientific Research Jakkur P.O.','',28,NULL,13,0,'560064','',1,NULL,0,NULL),(405,'405','0000-00-00','Prof. S Krishnaswami','INSA Senior Scientist','Physical Research Laboratory','Navrangpura ','',2,NULL,8,0,'380009','',1,NULL,0,NULL),(406,'406','0000-00-00','Prof. Kamala Krishnaswamy','House No. 1-2-98/2, Sriniketan','Kakatiyanagar Colony','Habsiguda ','',87,NULL,1,0,'500007','',1,NULL,0,NULL),(407,'407','0000-00-00','Prof. S B Krupanidhi','Materials Research Centre','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(408,'408','0000-00-00','Dr B D Kulkarni','Scientist','Chemical Engineering Division','National Chemical Laboratory ','',173,NULL,17,0,'411008','',1,NULL,0,NULL),(409,'409','0000-00-00','Dr M G Kulkarni','Chemical Engineering Division','National Chemical Laboratory',' ','',173,NULL,17,0,'411008','',1,NULL,0,NULL),(410,'410','0000-00-00','Prof. P V Kulkarni','c/o Dr Narendra P. Kulkarni','202, Sadguru Co-op. Hsg. Society','Sector 19, Flat 20 Kharghar','',154,NULL,17,0,'410210','',1,NULL,0,NULL),(411,'411','0000-00-00','Prof. Sulabha K Kulkarni','Indian Institute of Science Edn.','and Research','Sai Trinity Bujilding Garware Circle, Pashan','',173,NULL,17,0,'411021','',1,NULL,0,NULL),(412,'412','0000-00-00','Prof. Anurag Kumar','ECE Department','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(413,'413','0000-00-00','Prof. G Ravindra Kumar','Dept. of Nuclear & Atomic Physics','Tata Inst. of Fundamental Research','Homi Bhabha Road ','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(414,'414','0000-00-00','Prof. H D Kumar','Mrigtrishna','B.32/32 H.K. 214','Saketnagar Colony, Naria ','',231,NULL,28,0,'221005','',1,NULL,0,NULL),(415,'415','0000-00-00','Dr Lalit Kumar','Dept. of Medical Oncology','All India Inst. of Medical Sciences','Ansari Nagar ','',156,NULL,6,0,'110029','',1,NULL,0,NULL),(416,'416','0000-00-00','Prof. M Udaya Kumar','Dept. of Crop Physiology','University of Agricultural Sciences','GKVK ','',28,NULL,13,0,'560065','',1,NULL,0,NULL),(417,'417','0000-00-00','Prof. N Kumar','Emeritus Professor','Raman Research Institute',' ','',28,NULL,13,0,'560080','',1,NULL,0,NULL),(418,'418','0000-00-00','Prof. R Kumar','Honorary Professor','Department of Chemical Engineering','Indian Institute of Science ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(419,'419','0000-00-00','Prof. K C Kumara Swamy','School of Chemistry','University of Hyderabad',' ','',87,NULL,1,0,'500046','',1,NULL,0,NULL),(420,'420','0000-00-00','Prof. V Kumaran','Department of Chemical Engineering','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(421,'421','0000-00-00','Dr Tapas K Kundu','Molecular Biology and Genetics Unit','Jawaharlal Nehru Centre for Adv.','Scientific Research Jakkur P.O.','',28,NULL,13,0,'560064','',1,NULL,0,NULL),(422,'422','0000-00-00','Prof. Goutam K Lahiri','Department of Chemistry','Indian Institute of Technology','Powai ','',142,NULL,17,0,'400076','',1,NULL,0,NULL),(423,'423','0000-00-00','Prof. A N Lahiri Majumder','Dept. of Plant Molecular & Cellular','Genetics','Bose Institute, Centenary Building P-1/12, CIT Scheme, VII M','',116,NULL,30,0,'700054','',1,NULL,0,NULL),(424,'424','0000-00-00','Prof. S C Lakhotia','Department of Zoology','Banaras Hindu University',' ','',231,NULL,28,0,'221005','',1,NULL,0,NULL),(425,'425','0000-00-00','Prof. M Lakshmanan','Professor of Eminence','Department of Physics','Bharathidasan University ','',219,NULL,26,0,'620024','',1,NULL,0,NULL),(426,'426','0000-00-00','Prof. D Lal','Scripps Institution of Oceanography','Geosciences Research Divn., 0244',' La Jolla, CA 92093-0244','',0,NULL,0,30,'0','',1,NULL,0,NULL),(427,'427','0000-00-00','Prof. R K Lal','69, Nand Nagar','Karaundi','P.O. BHU ','',231,NULL,28,0,'221005','',1,NULL,0,NULL),(428,'428','0000-00-00','Prof. Shyam Lal','Planetary & Atmospheric Sci. Divn.','Physical Research Laboratory','Navrangpura ','',2,NULL,8,0,'380009','',1,NULL,0,NULL),(429,'429','0000-00-00','Dr Ashish K Lele','Polymer Science & Engineering Divn.','National Chemical Laboratory',' ','',173,NULL,17,0,'411008','',1,NULL,0,NULL),(430,'430','0000-00-00','Prof. S Lele','377, Mahatma Society','Kothrud',' ','',173,NULL,17,0,'411038','',1,NULL,0,NULL),(431,'431','0000-00-00','Dr Anuradha Lohia','Department of Biochemistry','Bose Institute','P-1/12, CIT Scheme, VIIM ','',116,NULL,30,0,'700054','',1,NULL,0,NULL),(432,'432','0000-00-00','Prof. Rentala Madhubala','School of Life Sciences','Jawaharlal Nehru University',' ','',156,NULL,6,0,'110067','',1,NULL,0,NULL),(433,'433','0000-00-00','Prof. N V Madhusudana','Liquid Crystals Laboratory','Raman Research Institute',' ','',28,NULL,13,0,'560080','',1,NULL,0,NULL),(434,'434','0000-00-00','Prof. K M Madyastha','162, \'Srikrishna\'','5th Main, 4th Cross','NGEF Layout Sanjay Nagar','',28,NULL,13,0,'560094','',1,NULL,0,NULL),(435,'435','0000-00-00','Prof. S Mahadevan','Dept. of Molecular Reproduction,','Development and Genetics','Indian Institute of Science ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(436,'436','0000-00-00','Dr K K Mahajan','C-1/121, Janak Puri','',' ','',156,NULL,6,0,'110058','',1,NULL,0,NULL),(437,'437','0000-00-00','Prof. Mj Mahan','School of Mathematical Sciences','Vivekananda University','Belur Math ','',85,NULL,30,0,'711202','',1,NULL,0,NULL),(438,'438','0000-00-00','Prof. J Maharana','Institute of Physics','Sachivalaya Marg',' ','',38,NULL,21,0,'751005','',1,NULL,0,NULL),(439,'439','0000-00-00','Prof. S C Maheshwari','Adviser, School of Life Sciences','Jaipur National University','Jagatpura ','',92,NULL,24,0,'302025','',1,NULL,0,NULL),(440,'440','0000-00-00','Prof. Kalobaran Maiti','Dept. of Condensed Matter Physics &','Materials Science','Tata Inst. of Fundamental Research Homi Bhabha Road','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(441,'441','0000-00-00','Prof. Uday Maitra','Department of Organic Chemistry','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(442,'442','0000-00-00','Dr H K Majumder','Scientist','Indian Inst. of Chemical Biology','4, Raja SC Mullick Road ','',116,NULL,30,0,'700032','',1,NULL,0,NULL),(443,'443','0000-00-00','Prof. Partha P Majumder','Director','National Institute of Biomedical','Genomics II Floor, Netaji Subhas Sanitorium','',105,NULL,30,0,'741251','',1,NULL,0,NULL),(444,'444','0000-00-00','Prof. K C Malhotra','385, Sector 29','',' ','',158,NULL,28,0,'201301','',1,NULL,0,NULL),(445,'445','0000-00-00','Prof. S K Malik','CIFMC-ICCMP','University of Brasilia','C.Postal 04513 70904-970 Brasilia DF','',0,NULL,0,3,'0','',1,NULL,0,NULL),(446,'446','0000-00-00','Prof. B N Mallick','School of Life Sciences','Jawaharlal Nehru University',' ','',156,NULL,6,0,'110067','',1,NULL,0,NULL),(447,'447','0000-00-00','Prof. A K Mallik','P-31, CIT Road','Scheme VIM(S)',' ','',116,NULL,30,0,'700054','',1,NULL,0,NULL),(448,'448','0000-00-00','Prof. R K Mallik','Dept. of Electrical Engineering','Indian Institute of Technology',' ','',156,NULL,6,0,'110016','',1,NULL,0,NULL),(449,'449','0000-00-00','Dr A B Mandal','Director','','Central Leather Research Institute Adyar','',50,NULL,26,0,'600020','',1,NULL,0,NULL),(450,'450','0000-00-00','Dr Chitra Mandal','Outstanding Scientist, IDI Division','Indian Inst. of Chemical Biology','4, Raja SC Mullick Road ','',116,NULL,30,0,'700032','',1,NULL,0,NULL),(451,'451','0000-00-00','Prof. N C Mandal','E-5, Digantika','AH Block, Sector II','Salt Lake ','',116,NULL,30,0,'700091','',1,NULL,0,NULL),(452,'452','0000-00-00','Prof. Nibir Mandal','Dept. of Geological Sciences','Jadavpur University',' ','',116,NULL,30,0,'700032','',1,NULL,0,NULL),(453,'453','0000-00-00','Prof. C Mande','S/29, Bharat Nagar','',' ','',148,NULL,17,0,'440001','',1,NULL,0,NULL),(454,'454','0000-00-00','Dr Shekhar C Mande','Director','National Centre for Cell Science','NCCS Complex, University Campus Ganeshkhind','',173,NULL,17,0,'411007','',1,NULL,0,NULL),(455,'455','0000-00-00','Prof. H S Mani','2, 4th Cross Street','Durga Colony','Sembakkam ','',50,NULL,26,0,'600073','',1,NULL,0,NULL),(456,'456','0000-00-00','Prof. Indranil Manna','Director','Central Glass & Ceramics Research','Institute 196, Raja SC Mullick Road','',116,NULL,30,0,'700032','',1,NULL,0,NULL),(457,'457','0000-00-00','Prof. P T Manoharan','INSA Senior Scientist','Department of Chemistry','Indian Inst. of Technology ','',50,NULL,26,0,'600036','',1,NULL,0,NULL),(458,'458','0000-00-00','Dr M V Mantravadi','21610, Villa Pacifica Circle','',' Carson, CA 90745','',0,NULL,0,30,'0','',1,NULL,0,NULL),(459,'459','0000-00-00','Prof. G Marimuthu','Head, Dept. of Animal Behaviour','and Physiology','School of Biological Sciences Madurai Kamaraj University','',129,NULL,26,0,'625021','',1,NULL,0,NULL),(460,'460','0000-00-00','Dr R A Mashelkar','CSIR Bhatnagar Fellow','National Chemical Laboratory',' ','',173,NULL,17,0,'411008','',1,NULL,0,NULL),(461,'461','0000-00-00','Dr C K Mathews','MANAS','52, Banjara Orchards','Horamavu Banaswadi P.O.','',28,NULL,13,0,'560043','',1,NULL,0,NULL),(462,'462','0000-00-00','Prof. P M Mathews','No. 22/20, Lady Madhvan Road','Nungambakkam',' ','',50,NULL,26,0,'600034','',1,NULL,0,NULL),(463,'463','0000-00-00','Dr Asha Mathur','Flat No. 103, Shalimr Estate','430-A, New Hyderabad',' ','',127,NULL,28,0,'226007','',1,NULL,0,NULL),(464,'464','0000-00-00','Prof. D Mathur','Atomic & Molecular Sciences','Tata Inst. of Fundamental Research',' Homi Bhabha Road','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(465,'465','0000-00-00','Prof. Pradeep Mathur','Director','Indian Institute of Technology','Khandwa Road ','',90,NULL,18,0,'452017','',1,NULL,0,NULL),(466,'466','0000-00-00','Dr Satyajit Mayor','Associate Professor','National Centre for Biological','Sciences GKVK Campus','',28,NULL,13,0,'560065','',1,NULL,0,NULL),(467,'467','0000-00-00','Prof. V M Meher-Homji','20 D, Sagar Sangget','58, Colaba Road',' ','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(468,'468','0000-00-00','Prof. C L Mehta','B-43, Gyandeep Apartments','Mayur Vihar, Phase 1',' ','',156,NULL,6,0,'110091','',1,NULL,0,NULL),(469,'469','0000-00-00','Prof. G Mehta','Lilly-Jubilant Chair Professor','School of Chemistry','University of Hyderabad ','',87,NULL,1,0,'500046','',1,NULL,0,NULL),(470,'470','0000-00-00','Dr V B Mehta','8th Floor, Flat No. 82','Panorama','203, Walkeshwar Road ','',142,NULL,17,0,'400006','',1,NULL,0,NULL),(471,'471','0000-00-00','Prof. M G K Menon','C-178, First Floor','Sarvodaya Enclave',' ','',156,NULL,6,0,'110017','',1,NULL,0,NULL),(472,'472','0000-00-00','Prof. T K Menon','No. 504-2350, West 39th Avenue','',' Vancouver, British Columbia V6M 1T9','',0,NULL,0,4,'0','',1,NULL,0,NULL),(473,'473','0000-00-00','Prof. S S Merh','Flat 5, Ash Down Court','5, Idmiston Road','Worcester Park Surrey KT4 7SE','',0,NULL,0,29,'0','',1,NULL,0,NULL),(474,'474','0000-00-00','Prof. Shiraz Minwalla','Dept. of Theoretical Physics','Tata Inst. of Fundamental Research','Homi Bhabha Road ','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(475,'475','0000-00-00','Dr A C Mishra','Director','National Institute ol Virology','20-A, Ambedkar Road ','',173,NULL,17,0,'411001','',1,NULL,0,NULL),(476,'476','0000-00-00','Dr G C Mishra','','Natinal Centre for Cell Science','University Campus, NCCS Complex Ganeshkhind','',173,NULL,17,0,'411007','',1,NULL,0,NULL),(477,'477','0000-00-00','Prof. Manoj K Mishra','Vice Chancellor','University of Lucknow',' ','',127,NULL,28,0,'226007','',1,NULL,0,NULL),(478,'478','0000-00-00','Dr R K Mishra','Group Leader','Centre for Cellular &','Molecular Biology Uppal Road','',87,NULL,1,0,'500007','',1,NULL,0,NULL),(479,'479','0000-00-00','Prof. S K Mishra','Flat 4, 163/24, Mausam Vihar','Park Avenue, Off DP Road','Nirminti Horizon, Aundh ','',173,NULL,17,0,'411007','',1,NULL,0,NULL),(480,'480','0000-00-00','Prof. Gadadhar Misra','Department of Mathematics','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(481,'481','0000-00-00','Prof. K B Misra','71, Vrindaban Vihar, Krishna Kutir','Ajmer Road, Mandir Marg',' ','',92,NULL,24,0,'302019','',1,NULL,0,NULL),(482,'482','0000-00-00','Dr U K Misra','Head, Neurology Department','Sanjay Gandhi PG Institute of','Medical Sciences Rae Bareli Road','',127,NULL,28,0,'226014','',1,NULL,0,NULL),(483,'483','0000-00-00','Dr K B Mistry','52, Sunshine','Dr Rajaballi Patel Lane',' ','',142,NULL,17,0,'400026','',1,NULL,0,NULL),(484,'484','0000-00-00','Prof. A N Mitra','244, Tagore Park','',' ','',58,NULL,6,0,'110009','',1,NULL,0,NULL),(485,'485','0000-00-00','Prof. S Mitra','INSA Senior Scientist','Indian Inst. of Chemical Biology','4, Raja SC Mullick Road ','',116,NULL,30,0,'700032','',1,NULL,0,NULL),(486,'486','0000-00-00','Dr J P Mittal','11-B, Rohini Co-op. Housing Society','Sector 9-A','Vashi ','',154,NULL,17,0,'400703','',1,NULL,0,NULL),(487,'487','0000-00-00','Prof. Sanjay Mittal','Dept. of Aerospace Engineering','Indian Institute of Technology',' ','',107,NULL,28,0,'208016','',1,NULL,0,NULL),(488,'488','0000-00-00','Prof. Indraneel Mittra','Professor Emeritus','Department of Surgical Oncology','Tata Memorial Hospital Dr Ernest Borges Road, Parel','',142,NULL,17,0,'400012','',1,NULL,0,NULL),(489,'489','0000-00-00','Prof. Anand Mohan','Registrar','Dayalbagh Educational Institute','Dayalbagh ','',1,NULL,28,0,'282110','',1,NULL,0,NULL),(490,'490','0000-00-00','Dr V Mohan','Director','Madras Diabetes Research Foundation','No. 4, Conran Smith Road Gopalapuram','',50,NULL,26,0,'600086','',1,NULL,0,NULL),(491,'491','0000-00-00','Prof. N Mohan Kumar','Department of Mathematics','Washington University at St. Louis',' St. Louis, MO 63130','',0,NULL,0,30,'0','',1,NULL,0,NULL),(492,'492','0000-00-00','Prof. H Y Mohan Ram','174, S F S DDA Flats','Mukherjee Nagar',' ','',58,NULL,6,0,'110009','',1,NULL,0,NULL),(493,'493','0000-00-00','Dr Ch. Mohan Rao','Director','Centre for Cellular & Molecular','Biology Uppal Road','',87,NULL,1,0,'500007','',1,NULL,0,NULL),(494,'494','0000-00-00','Dr Debasisa Mohanty','Staff Scientist V','National Institute of Immunology','Aruna Asaf Ali Marg ','',156,NULL,6,0,'110067','',1,NULL,0,NULL),(495,'495','0000-00-00','Prof. U C Mohanty','Centre for Atmospheric Sciences','Indian Institute of Technology','Hauz Khas ','',156,NULL,6,0,'110016','',1,NULL,0,NULL),(496,'496','0000-00-00','Prof. P Mohanty-Hejmadi','GM-8, V.S.S. Nagar','',' ','',38,NULL,21,0,'751007','',1,NULL,0,NULL),(497,'497','0000-00-00','Prof. N K Mondal','Dept. of High Energy Physics','Tata Inst. of Fundamental Research','Homi Bhabha Road ','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(498,'498','0000-00-00','Prof. J Narasimha Moorthy','Department of Chemistry','Indian Institute of Technology',' ','',107,NULL,28,0,'208016','',1,NULL,0,NULL),(499,'499','0000-00-00','Prof. G Mugesh','IPC Department','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(500,'500','0000-00-00','Prof. Rahul Mukerjee','Indian Institute of Management','Joka, Diamond Harbour Road',' ','',116,NULL,30,0,'700104','',1,NULL,0,NULL),(501,'501','0000-00-00','Prof. D Mukherjee','Chair Professor, RCAMOS','Indian Association for the','Cultivation of Science Jadavpur','',116,NULL,30,0,'700032','',1,NULL,0,NULL),(502,'502','0000-00-00','Prof. R N Mukherjee','Department of Chemistry','Indian Institute of Technology',' ','',107,NULL,28,0,'208016','',1,NULL,0,NULL),(503,'503','0000-00-00','Dr S K Mukherjee','Scientist','International Centre for Genetic','Engineering & Biotechnology Aruna Asaf Ali Marg','',156,NULL,6,0,'110067','',1,NULL,0,NULL),(504,'504','0000-00-00','Prof. Sunil Mukhi','Dept. of Theoretical Physics','Tata Inst. of Fundamental Research','Homi Bhabha Road ','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(505,'505','0000-00-00','Dr Amitabha Mukhopadhyay','Staff Scientist VI','Cell Biology Laboratory','National Institute of Immunology Aruna Asaf Ali Marg','',156,NULL,6,0,'110067','',1,NULL,0,NULL),(506,'506','0000-00-00','Prof. D Mukhopadhyay','G-7, MIG Housing Colony','25/3, Raja Manindra Road',' ','',116,NULL,30,0,'700037','',1,NULL,0,NULL),(507,'507','0000-00-00','Prof. H S Mukunda','Adviser, ABETS','CGP Laboratory','Indian Institute of Science ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(508,'508','0000-00-00','Prof. N Mukunda','Centre for High Energy Physics','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(509,'509','0000-00-00','Prof. K Muniyappa','Chairman','Department of Biochemistry','Indian Institute of Science ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(510,'510','0000-00-00','Prof. M L Munjal','Honorary Professor','Dept. of Mechanical Engineering','Indian Institute of Science ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(511,'511','0000-00-00','Prof. K Muralidhar','Department of Zoology','University of Delhi',' ','',58,NULL,6,0,'110007','',1,NULL,0,NULL),(512,'512','0000-00-00','Prof. M R N Murthy','Molecular Biophysics Unit','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(513,'513','0000-00-00','Prof. M V N Murthy','Institute of Mathematical Sciences','CIT Campus, Taramani',' ','',50,NULL,26,0,'600113','',1,NULL,0,NULL),(514,'514','0000-00-00','Prof. B S Murty','Department of Metallurgical and','Materials Engineering','Indian Institute of Technology ','',50,NULL,26,0,'600036','',1,NULL,0,NULL),(515,'515','0000-00-00','Prof. S V S Murty','Planetary and Geosciences Division','Physical Research Laboratory','Navrangpura ','',2,NULL,8,0,'380009','',1,NULL,0,NULL),(516,'516','0000-00-00','Dr T G K Murty','848, 8th B Main','17th Cross','ISRO Layout ','',28,NULL,13,0,'560078','',1,NULL,0,NULL),(517,'517','0000-00-00','Prof. R Murugavel','Department of Chemistry','Indian Institute of Technology','Powai ','',142,NULL,17,0,'400076','',1,NULL,0,NULL),(518,'518','0000-00-00','Prof. V Muthukkaruppan','Director - Research','Arvind Eye Hospital','No. 1, Anna Nagar ','',129,NULL,26,0,'625020','',1,NULL,0,NULL),(519,'519','0000-00-00','Prof. M G Nadkarni','INSA Senior Scientist','Dept. of Mathematics','University of Mumbai Vidyanagari, Kalina','',142,NULL,17,0,'400098','',1,NULL,0,NULL),(520,'520','0000-00-00','Dr V M Nadkarni','Managing Director','Techcellence Consultancy Services','Pvt. Ltd., 5, Pushkaraj, Pushpak Park, Aundh','',173,NULL,17,0,'411007','',1,NULL,0,NULL),(521,'521','0000-00-00','Prof. K Nag','INSA Senior Scientist','Department of Inorganic Chemistry','Indian Association for the Cultivation of Science','',116,NULL,30,0,'700032','',1,NULL,0,NULL),(522,'522','0000-00-00','Dr D S Nagaraj','Institute of Mathematical Sciences','CIT Campus','Taramani ','',50,NULL,26,0,'600113','',1,NULL,0,NULL),(523,'523','0000-00-00','Dr R Nagaraj','Centre for Cellular and Molecular','Biology','Uppal Road ','',87,NULL,1,0,'500007','',1,NULL,0,NULL),(524,'524','0000-00-00','Prof. V Nagaraja','MCB Department','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(525,'525','0000-00-00','Dr K Nagarajan','4A, Atishi, Plot No. 8&9','Rose Garden Road, 15th Main','V Phase, J.P. Nagar ','',28,NULL,13,0,'560078','',1,NULL,0,NULL),(526,'526','0000-00-00','Prof. R Nagarajan','303, Dnyaneshwar','D. Gaikwad Road','Mulund (W) ','',142,NULL,17,0,'400080','',1,NULL,0,NULL),(527,'527','0000-00-00','Dr J Nagaraju','Staff Scientist & Chief','Laboratory of Molecular Genetics','CDFD, Building 7, Gruhakalpa 5-4-399/B, Nampalli','',87,NULL,1,0,'500001','',1,NULL,0,NULL),(528,'528','0000-00-00','Dr G Nageswara Rao','Distinguished Chair of Eye Health','L V Prasad Eye Institute','LV Prasad Marg Banjara Hills','',87,NULL,1,0,'500034','',1,NULL,0,NULL),(529,'529','0000-00-00','Dr G Balakrish Nair','Executive Director','Translational Health Science & Tech.','Institute 496, Phase 3, Udyog Vihar','',79,NULL,10,0,'122016','',1,NULL,0,NULL),(530,'530','0000-00-00','Dr G Vijay Nair','Raja Ramanna Fellow','Natl. Inst. for Interdisciplinary','Science & Technology ','',217,NULL,14,0,'695019','',1,NULL,0,NULL),(531,'531','0000-00-00','Prof. B C Nakra','Distinguished Professor Emeritus','Mechanical Engineering Department','Inst. of Tech. & Management HUDA Palam Vihar, Sector 23A','',79,NULL,10,0,'124017','',1,NULL,0,NULL),(532,'532','0000-00-00','Prof. Arun Kumar Nandi','Polymer Science Unit','Indian Assn. for the Cultivation','of Science Jadavpur','',116,NULL,30,0,'700032','',1,NULL,0,NULL),(533,'533','0000-00-00','Prof. Aswini Nangia','School of Chemistry','University of Hyderabad',' ','',87,NULL,1,0,'500046','',1,NULL,0,NULL),(534,'534','0000-00-00','Prof. V Nanjundiah','D.B.G.L.','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(535,'535','0000-00-00','Dr S W A Naqvi','National Institute of Oceanography','',' ','',64,NULL,7,0,'403004','',1,NULL,0,NULL),(536,'536','0000-00-00','Prof. Y Narahari','CSA Department','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(537,'537','0000-00-00','Prof. Prem Narain','B-3/27A, Lawrence Road','Keshavapuram',' ','',156,NULL,6,0,'110035','',1,NULL,0,NULL),(538,'538','0000-00-00','Prof. R Narasimha','Honorary Professor','Engineering Mechanics Unit','Jawaharlal Nehru Centre for Adv. Scientific Research, Jakkur','',28,NULL,13,0,'560064','',1,NULL,0,NULL),(539,'539','0000-00-00','Prof. V S Narasimham','202, Vigyan','Sector 17, Plot 23','Vashi ','',154,NULL,17,0,'400703','',1,NULL,0,NULL),(540,'540','0000-00-00','Prof. M S Narasimhan','Distinguished Associate, IMI','Department of Mathematics','Indian Institute of Science ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(541,'541','0000-00-00','Prof. N S Narasimhan','22, Niyoshi Park II','D.P. Road','Aundh ','',173,NULL,17,0,'411007','',1,NULL,0,NULL),(542,'542','0000-00-00','Prof. P T Narasimhan','1013, Lupine Drive','',' Sunnyvale, CA 94086','',0,NULL,0,30,'0','',1,NULL,0,NULL),(543,'543','0000-00-00','Prof. R Narasimhan','Dept. of Mechanical Engineering','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(544,'544','0000-00-00','Prof. K S Narayan','CPM Unit','Jawaharlal Nehru Centre for Adv.','Scientific Research Jakkur','',28,NULL,13,0,'560064','',1,NULL,0,NULL),(545,'545','0000-00-00','Prof. V Narayanamurti','Professo of Engg. & Appl. Sciences','Harvard University','107D, Pierce Hall 29 Oxford StreetCambridge, MA 02138','',0,NULL,0,30,'0','',1,NULL,0,NULL),(546,'546','0000-00-00','Prof. T C Narendran','Co-ordinator, AICOPTAX','Zoological Survery of India','Jafferkhan Colony ','',120,NULL,14,0,'673006','',1,NULL,0,NULL),(547,'547','0000-00-00','Prof. A V Narlikar','INSA Senior Scietist','UGC-DAE Consortium for Scientific','Research, University Campus Khandwa Road','',90,NULL,18,0,'452017','',1,NULL,0,NULL),(548,'548','0000-00-00','Prof. J V Narlikar','Emeritus Professor','Inter-University Centre for','Astronomy and Astrophysics Ganeshkhind','',173,NULL,17,0,'411007','',1,NULL,0,NULL),(549,'549','0000-00-00','Prof. K A Natarajan','NASI Senior Scientist','Department of Materials Engineering','Indian Institute of Science ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(550,'550','0000-00-00','Prof. P Natarajan','Raja Ramanna Fellow','Natl. Centre for Ultrafast','Processes, University of Madras Taramani Campus','',50,NULL,26,0,'600113','',1,NULL,0,NULL),(551,'551','0000-00-00','Prof. S Natarajan','S.S.C.U.','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(552,'552','0000-00-00','Prof. G Nath','c/o Dr S.K. Sinha','Type IV/17, KNIT Campus','Kamala Nehru Institute of Technology','',212,NULL,28,0,'228118','',1,NULL,0,NULL),(553,'553','0000-00-00','Prof. R R Navalgund','Director','Space Applications Centre','Ambawadi P.O. ','',2,NULL,8,0,'380015','',1,NULL,0,NULL),(554,'554','0000-00-00','Prof. N C Nayak','Dept. of Histopathology','Sir Gangaram Hospital','Rajinder Nagar ','',156,NULL,6,0,'110060','',1,NULL,0,NULL),(555,'555','0000-00-00','Prof. B K Nayar','20/601, Panniyankara','Kallai P.O.',' ','',120,NULL,14,0,'673003','',1,NULL,0,NULL),(556,'556','0000-00-00','Prof. I A Niazi','D-II/2276, Vasant Kunj','',' ','',156,NULL,6,0,'110070','',1,NULL,0,NULL),(557,'557','0000-00-00','Prof. Nitin Nitsure','School of Mathematics','Tata Inst. of Fundamental Research','Homi Bhabha Road ','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(558,'558','0000-00-00','Prof. Soniya Nityanand','Dept. of Hematology','Sanjay Gandhi PG Inst/ of Medical','Sciences Rae Bareli Road','',127,NULL,28,0,'226014','',1,NULL,0,NULL),(559,'559','0000-00-00','Prof. R Nityananda','Senior Professor','National Centre for Radio','Astrophysics Ganeshkhind','',173,NULL,17,0,'411007','',1,NULL,0,NULL),(560,'560','0000-00-00','Prof. M V Nori','Department of Mathematics','University of Chicago','5734, South University Avenue Chicago, IL 60637','',0,NULL,0,30,'0','',1,NULL,0,NULL),(561,'561','0000-00-00','Prof. S B Ogale','Ramanujan Fellow','Physical & Mater. Chemistry Divn.','National Chemical Laboratory ','',173,NULL,17,0,'411008','',1,NULL,0,NULL),(562,'562','0000-00-00','Prof. J D Padayatty','Karukutty P.O.','',' ','',67,NULL,14,0,'683576','',1,NULL,0,NULL),(563,'563','0000-00-00','Prof. G Padmanaban','NASI-Platinum Jubilee Chair','Department of Biochemistry','Indian Institute of Science ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(564,'564','0000-00-00','Prof. K A Padmanabhan','School of Engg. Sciences and','Technology','University of Hyderabad ','',87,NULL,1,0,'500046','',1,NULL,0,NULL),(565,'565','0000-00-00','Prof. T Padmanabhan','Inter-University Centre for','Astronomy and Astrophysics','Post Bag No. 4, Ganeshkhind ','',173,NULL,17,0,'411007','',1,NULL,0,NULL),(566,'566','0000-00-00','Prof. M A Pai','Emeritus Professor, Dept. of','Electrical & Computer Engineering','University of Illinois 1406 West Green StreetUrbana, IL 61801','',0,NULL,0,30,'0','',1,NULL,0,NULL),(567,'567','0000-00-00','Prof. Amalan J Pal','Dept. of Solid State Physics','Indian Assn. for the Cultivation','of Science ','',116,NULL,30,0,'700032','',1,NULL,0,NULL),(568,'568','0000-00-00','Prof. Arup K Pal','','Indian Statistical Institute','7, SJS Sansanwal Marg ','',156,NULL,6,0,'110016','',1,NULL,0,NULL),(569,'569','0000-00-00','Dr G P Pal','Padmavathi Colony','Behind St. Pauls School',' ','',90,NULL,18,0,'452001','',1,NULL,0,NULL),(570,'570','0000-00-00','Prof. M K Pal','Apartment 1B','41, Lala Lajpat Rai Sarani',' ','',116,NULL,30,0,'700020','',1,NULL,0,NULL),(571,'571','0000-00-00','Prof. S K Pal','Distinguished Scientist','Indian Statistical Institute','203, B.T. Road ','',116,NULL,30,0,'700108','',1,NULL,0,NULL),(572,'572','0000-00-00','Dr Sourav Pal','Director','National Chemical Laboratory',' ','',173,NULL,17,0,'411008','',1,NULL,0,NULL),(573,'573','0000-00-00','Prof. Yash Pal','11B, Super Delux Flats','Sector 15A',' ','',158,NULL,28,0,'201301','',1,NULL,0,NULL),(574,'574','0000-00-00','Prof. M Palaniandavar','Centre for Metals in Biology &','Medicine','School of Chemistry Bharathidasan University','',219,NULL,26,0,'620024','',1,NULL,0,NULL),(575,'575','0000-00-00','Dr Dipak K Palit','Ultrafast & Discharge Chemistry','Division','Bhabha Atomic Research Centre Trombay','',142,NULL,17,0,'400085','',1,NULL,0,NULL),(576,'576','0000-00-00','Prof. N Panchapakesan','C-192, Second Floor','Sarvodaya Enclave',' ','',156,NULL,6,0,'110017','',1,NULL,0,NULL),(577,'577','0000-00-00','Prof. Dulal Panda','School of Biosciences &','Bioengineering','Indian Inst. of Technology Powai','',142,NULL,17,0,'400076','',1,NULL,0,NULL),(578,'578','0000-00-00','Dr S K Panda','Department of Pathology','All India Institute of Medical','Sciences Ansari Nagar','',156,NULL,6,0,'110029','',1,NULL,0,NULL),(579,'579','0000-00-00','Prof. Dhananjai Pandey','School of Materials Science and','Technology','Institute of Technology Banaras Hindu University','',231,NULL,28,0,'221005','',1,NULL,0,NULL),(580,'580','0000-00-00','Dr G P Pandey','Division of Organic Chemistry','(Synthesis)','National Chemical Laboratory ','',173,NULL,17,0,'411008','',1,NULL,0,NULL),(581,'581','0000-00-00','Dr P C Pandey','School of Earth, Ocean and','Climate Sciences','Indian Institute of Technology Samantapuri','',38,NULL,21,0,'751013','',1,NULL,0,NULL),(582,'582','0000-00-00','Prof. T J Pandian','No. 9, Old Natham Road','Opp. Balamandiram',' ','',129,NULL,26,0,'625014','',1,NULL,0,NULL),(583,'583','0000-00-00','Prof. A B Pandit','Institute of Chemical Technology','University of Bombay','Matunga ','',142,NULL,17,0,'400019','',1,NULL,0,NULL),(584,'584','0000-00-00','Prof. Rahul Pandit','Department of Physics','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(585,'585','0000-00-00','Prof. P N Pandita','Department of Physics','North-Eastern Hill University','Mawkynroh-Umshing ','',197,NULL,16,0,'793022','',1,NULL,0,NULL),(586,'586','0000-00-00','Prof. S P Pandya','26, Mithila Society','',' ','',2,NULL,8,0,'380015','',1,NULL,0,NULL),(587,'587','0000-00-00','Prof. A K Pani','Dept. of Mathematics','Indian Institute of Technology',' Powai','',142,NULL,17,0,'400076','',1,NULL,0,NULL),(588,'588','0000-00-00','Prof. A J Parameswaran','School of Mathematics','Tata Institute of Fundamental Research','Homi Bhabha Road ','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(589,'589','0000-00-00','Prof. K H Paranjape','IISER','Knowledge City, Sector 81','Manauli P.O. ','',193,NULL,22,0,'140306','',1,NULL,0,NULL),(590,'590','0000-00-00','Dr P A Paranjpe','`Bahaar\'','5, Hindustan Estate, Road No. 13','Kalyaninagar ','',173,NULL,17,0,'411006','',1,NULL,0,NULL),(591,'591','0000-00-00','Prof. R Parimala','Department of Mathematics','and Computer Science','Emory University 400 Dowman Drive W 401Atlanta, GA 30322','',0,NULL,0,30,'0','',1,NULL,0,NULL),(592,'592','0000-00-00','Dr Veena K Parnaik','Centre for Cellular and','Molecular Biology','Uppal Road ','',87,NULL,1,0,'500007','',1,NULL,0,NULL),(593,'593','0000-00-00','Prof. K R Parthasarathy','Emeritus Professor','Indian Statistical Institute','7, SJS Sansanwal Marg ','',156,NULL,6,0,'110016','',1,NULL,0,NULL),(594,'594','0000-00-00','Prof. R Parthasarathy','A4, KTVR Balaji Shelter','Dr Ambedkar Road','Velandipalayam ','',52,NULL,26,0,'641025','',1,NULL,0,NULL),(595,'595','0000-00-00','Prof. T Parthasarathy','INSA Senior Scientist','SQL/OR Unit','Indian Statistical Institute 110, Nelson Manikham Road','',50,NULL,26,0,'600029','',1,NULL,0,NULL),(596,'596','0000-00-00','Dr G B Parulkar','Consultant, Cardiovascular Surgery','Heart Institute','95, August Kranti Marg ','',142,NULL,17,0,'400036','',1,NULL,0,NULL),(597,'597','0000-00-00','Prof. I B S Passi','381, Sector 38-A','',' ','',48,NULL,31,0,'160014','',1,NULL,0,NULL),(598,'598','0000-00-00','Prof. J Pasupathy','3286, 12th Main Road','HAL II Stage',' ','',28,NULL,13,0,'560008','',1,NULL,0,NULL),(599,'599','0000-00-00','Prof. K N Pathak','382, Sector 38A','',' ','',48,NULL,31,0,'160014','',1,NULL,0,NULL),(600,'600','0000-00-00','Prof. Swapan K Pati','Theoretical Sciences Unit','Jawaharlal Nehru Centre for Adv.','Scientific Research Jakkur','',28,NULL,13,0,'560064','',1,NULL,0,NULL),(601,'601','0000-00-00','Prof. L M Patnaik','Honorary Professor','CEDT','Indian Institute of Science ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(602,'602','0000-00-00','Dr Amit Kumar Patra','Head, ISP Group','National Atmospheric Research Lab.','Gadanki Pakala Mandal','',51,NULL,1,0,'517112','',1,NULL,0,NULL),(603,'603','0000-00-00','Dr V S Patwardhan','3, Vibha Heights','Sane Wadi','Banner Road, Aundh ','',173,NULL,17,0,'411007','',1,NULL,0,NULL),(604,'604','0000-00-00','Prof. Deepak Pental','Director','Centre for Genetic Manipulation of','Crop Plants University of Delhi South Campus','',156,NULL,6,0,'110021','',1,NULL,0,NULL),(605,'605','0000-00-00','Prof. M Periasamy','School of Chemistry','University of Hyderabad',' ','',87,NULL,1,0,'500046','',1,NULL,0,NULL),(606,'606','0000-00-00','Prof. N Periasamy','Flat No. N-52, Diamond District','Old Airport Road','Kodihalli ','',28,NULL,13,0,'560008','',1,NULL,0,NULL),(607,'607','0000-00-00','Dr M Radhakrishna Pillai','Director','Rajiv Gandhi Centre for','Biotechnology, Jagathi ','',217,NULL,14,0,'695014','',1,NULL,0,NULL),(608,'608','0000-00-00','Prof. V N R Pillai','Executive Vice President','Kerala State Council for Science, Tech','& Environment Sasthra Bhavan, Pattom P.O. Thiruvananthapuram 695','',0,NULL,14,0,'694004','',1,NULL,0,NULL),(609,'609','0000-00-00','Prof. R M Pitchappan','Research Director','Chettinad Academy of Res. & Edn.','Chettinad Health City OMR Road, Kelampakkam','',50,NULL,26,0,'603103','',1,NULL,0,NULL),(610,'610','0000-00-00','Prof. M V Pitke','002 Buniyad','Yashodham A2-15','Goregaon (East) ','',142,NULL,17,0,'400063','',1,NULL,0,NULL),(611,'611','0000-00-00','Prof. K Porsezian','Dept. of Physics','Pondicherry University',' ','',172,NULL,23,0,'605014','',1,NULL,0,NULL),(612,'612','0000-00-00','Prof. T Pradeep','Department of Chemistry','Indian Institute of Technology',' ','',50,NULL,26,0,'600036','',1,NULL,0,NULL),(613,'613','0000-00-00','Dr T Pradhan','Emeritus Professor','Institute of Physics','Sachivalaya Marg ','',38,NULL,21,0,'751005','',1,NULL,0,NULL),(614,'614','0000-00-00','Prof. B L S Prakasa Rao','Homi Bhabha Chair Professor','Dept of Mathematics & Statistics','School of MCIS University of Hyderabad','',87,NULL,1,0,'500046','',1,NULL,0,NULL),(615,'615','0000-00-00','Dr V Prakash','Distinguished Scientist (CSIR)','JSS Centre for Management Studies','JSS TI Complex ','',145,NULL,13,0,'570006','',1,NULL,0,NULL),(616,'616','0000-00-00','Prof. Dipendra Prasad','School of Mathematics','Tata Inst. of Fundamental Research','Homi Bhabha Road ','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(617,'617','0000-00-00','Prof. G V R Prasad','Department of Geology','University of Delhi',' ','',58,NULL,6,0,'110007','',1,NULL,0,NULL),(618,'618','0000-00-00','Prof. Gopal Prasad','Raoul Bott Professor of Mathematics','The University of Michigan',' Ann Arbor, MI 48109-1109','',0,NULL,0,30,'0','',1,NULL,0,NULL),(619,'619','0000-00-00','Prof. Phoolan Prasad','Department of Mathematics','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(620,'620','0000-00-00','Prof. Rajendra Prasad','School of Life Sciences','Jawaharlal Nehru University',' ','',156,NULL,6,0,'110067','',1,NULL,0,NULL),(621,'621','0000-00-00','Prof. Surendra Prasad','Bharti School of Telecommunication','Technology & Management','Indian Institute of Technology ','',156,NULL,6,0,'110016','',1,NULL,0,NULL),(622,'622','0000-00-00','Prof. Y V R K Prasad','B/2, Hospital Extension','Vinayaka Nagar','Hebbal ','',28,NULL,13,0,'560024','',1,NULL,0,NULL),(623,'623','0000-00-00','Dr T S R Prasada Rao','SFS Flat No. 600, DDA/HIG Flats','Sector 13, Phase 2, Pocket B','Dwaraka ','',156,NULL,6,0,'110045','',1,NULL,0,NULL),(624,'624','0000-00-00','Prof. G Prathap','Director','NISCAIR','Dr K.S. Krishnan Road Pusa','',156,NULL,6,0,'110012','',1,NULL,0,NULL),(625,'625','0000-00-00','Prof. Sanjay Puri','School of Physical Sciences','Jawaharlal Nehru University',' ','',156,NULL,6,0,'110067','',1,NULL,0,NULL),(626,'626','0000-00-00','Dr V Purnachandra Rao','Scientist EII','Geological Oceanography Division','National Institute of Oceanography ','',64,NULL,7,0,'403004','',1,NULL,0,NULL),(627,'627','0000-00-00','Dr S Z Qasim','Chairman,','Centre for Ocean & Environmental','Studies A2, East of Kailash (Basement)','',156,NULL,6,0,'110065','',1,NULL,0,NULL),(628,'628','0000-00-00','Dr T Radhakrishna','Scientist E2','Centre for Earth Science Studies','Akkulam ','',217,NULL,14,0,'695031','',1,NULL,0,NULL),(629,'629','0000-00-00','Prof. J Radhakrishnan','School of Technology &','Computer Science','Tata Institute of Fundamental Research, Homi Bhabha Road','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(630,'630','0000-00-00','Prof. T P Radhakrishnan','School of Chemistry','University of Hyderabad',' ','',87,NULL,1,0,'500046','',1,NULL,0,NULL),(631,'631','0000-00-00','Dr G P S Raghava','Scientist EII','Institute of Microbial Technology','Sector 39A ','',48,NULL,31,0,'160036','',1,NULL,0,NULL),(632,'632','0000-00-00','Prof. K N Raghavan','The Institute of Mathematical','Sciences','CIT Campus, Taramani ','',50,NULL,26,0,'600113','',1,NULL,0,NULL),(633,'633','0000-00-00','Prof. S Raghavan','1A, Abhinaya Apartments','14 (old 41), Sastri Nagar','I Avenue, Adyar ','',50,NULL,26,0,'600020','',1,NULL,0,NULL),(634,'634','0000-00-00','Prof. A S Raghavendra','Dept. of Plant Sciences','School of Life Sciences','University of Hyderabad ','',87,NULL,1,0,'500046','',1,NULL,0,NULL),(635,'635','0000-00-00','Prof. M S Raghunathan','Distinguished Guest Professor','Department of Mathematics','Indian Institute of Technology Powai','',142,NULL,17,0,'400076','',1,NULL,0,NULL),(636,'636','0000-00-00','Prof. V A Raghunathan','Raman Research Institute','',' ','',28,NULL,13,0,'560080','',1,NULL,0,NULL),(637,'637','0000-00-00','Dr S S Rai','','National Geophysicsl Res. Institute','Uppal Road ','',87,NULL,1,0,'500606','',1,NULL,0,NULL),(638,'638','0000-00-00','Prof. Arnab Rai Choudhuri','Department of Physics','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(639,'639','0000-00-00','Prof. S Rai Choudhury','Indian Inst. of Science Education','& Research','Transit Campus: ITI (GR) Building Govindapura','',37,NULL,18,0,'462023','',1,NULL,0,NULL),(640,'640','0000-00-00','Prof. E S Raja Gopal','Emeritus Scientist','Department of Physics','Indian Institute of Science ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(641,'641','0000-00-00','Dr S R Rajagopalan','B4/1, Vijay Kiran Apartments','32, Victoria Road',' ','',28,NULL,13,0,'560047','',1,NULL,0,NULL),(642,'642','0000-00-00','Prof. V Rajamani','1209, Sector A, Pocket B','Vasant Kunj',' ','',156,NULL,6,0,'110070','',1,NULL,0,NULL),(643,'643','0000-00-00','Prof. C S Rajan','School of Mathematics','Tata Inst. of Fundamental Research','Homi Bhabha Road ','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(644,'644','0000-00-00','Dr S Rajappa','B-1, Melody Apartments','Plot No. 12, ICS Colony',' ','',173,NULL,17,0,'411007','',1,NULL,0,NULL),(645,'645','0000-00-00','Prof. R Rajaraman','School of Physical Sciences','Jawaharlal Nehru University',' ','',156,NULL,6,0,'110067','',1,NULL,0,NULL),(646,'646','0000-00-00','Prof. V Rajaraman','Honorary Professor','Supercomputer Education and','Research Centre Indian Institute of Science','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(647,'647','0000-00-00','Prof. G Rajasekaran','Emeritus Professor','The Institute of Math. Sciences','CIT Campus, Taramani ','',50,NULL,26,0,'600113','',1,NULL,0,NULL),(648,'648','0000-00-00','Prof. Ram Rajasekharan','Director','Central Institute of Medicinal &','Aromatic Plants CIMAP Post','',127,NULL,28,0,'226015','',1,NULL,0,NULL),(649,'649','0000-00-00','Dr M Rajeevan','Scietnist S','Ministry of Earth Sciences','Prithvi Bhavan,Mausam Bhavan Campus Opp India Habitat Centre, Lo','',156,NULL,6,0,'110003','',1,NULL,0,NULL),(650,'650','0000-00-00','Dr V Rajshekhar','Dept.  of Neurological Sciences','Christian Medical College',' ','',233,NULL,26,0,'632004','',1,NULL,0,NULL),(651,'651','0000-00-00','Prof. T R Raju','Head, Department of Neurophysiology','National Inst. of Mental Health &','Neuro Sciences P.B. No. 2900, Hosur Road','',28,NULL,13,0,'560029','',1,NULL,0,NULL),(652,'652','0000-00-00','Dr  Ram Sagar','Director','Aryabhatta Research Institute of','Observational Sciences (ARIES) Manora Peak','',150,NULL,29,0,'263129','',1,NULL,0,NULL),(653,'653','0000-00-00','Prof.  Rama','Y-4, Sector 9','CBD',' ','',154,NULL,17,0,'400614','',1,NULL,0,NULL),(654,'654','0000-00-00','Dr A V Rama Rao','Chairman & Managing Director','AVRA Laboratories Pvt. Ltd.','AVRA House, 7-102/54, Sai Enclave Habshiguda','',87,NULL,1,0,'500007','',1,NULL,0,NULL),(655,'655','0000-00-00','Prof. A Ramachandran','No. 3, Crescent Road','',' ','',28,NULL,13,0,'560001','',1,NULL,0,NULL),(656,'656','0000-00-00','Prof. J Ramachandran','President','Gangagen Biotechnologies P. Ltd.','No. 12, 5th Cross, Raghavendra Layout, Opp. MEI Ltd. Tumkur Road','',28,NULL,13,0,'560022','',1,NULL,0,NULL),(657,'657','0000-00-00','Prof. R Ramachandran','Flat 12, Khagol Society','Panchvati','Pashan ','',173,NULL,17,0,'411008','',1,NULL,0,NULL),(658,'658','0000-00-00','Dr S Ramachandran','\'Vidya Theertha Kripa\'','No. 1, Siva Sundar Avenue','Thiruvanmiyur ','',50,NULL,26,0,'600041','',1,NULL,0,NULL),(659,'659','0000-00-00','Prof. T R Ramadas','Mathematics Group','Abdus Salam Int. Centre for','Theoretical Physics Strada Costiera 1134100 Trieste','',0,NULL,0,14,'0','',1,NULL,0,NULL),(660,'660','0000-00-00','Dr D Ramaiah','Photoscience & Photonics Division','Natl. Inst. for Interdisciplinary','Science & Technology ','',217,NULL,14,0,'695019','',1,NULL,0,NULL),(661,'661','0000-00-00','Dr B S Ramakrishna','Dept. of Gastrointestinal Sciences','Christian Medical College Hospital',' ','',233,NULL,26,0,'632004','',1,NULL,0,NULL),(662,'662','0000-00-00','Prof. C Ramakrishnan','\'Kausthubam\'','212, 7th Cross, 6th Main','Tata Nagar, Kodigehalli ','',28,NULL,13,0,'560092','',1,NULL,0,NULL),(663,'663','0000-00-00','Dr M Ramakrishnan','29/8, Manipallavam','Balakrishnan Road','Valmiki Nagar Thiruvanmayur','',50,NULL,26,0,'600041','',1,NULL,0,NULL),(664,'664','0000-00-00','Prof. P S Ramakrishnan','INSA Senior Scientist','School of Environmental Sciences','Jawaharlal Nehru University ','',156,NULL,6,0,'110067','',1,NULL,0,NULL),(665,'665','0000-00-00','Prof. S Ramakrishnan','IPC Department','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(666,'666','0000-00-00','Prof. Srinivasan Ramakrishnan','Dept. of Condensed Matter and','Materials Science','Tata Institute of Fundamental Research, Homi Bhabha Road','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(667,'667','0000-00-00','Prof. T V Ramakrishnan','Emeritus Professor','Department of Physics','Banaras Hindu University ','',231,NULL,28,0,'221005','',1,NULL,0,NULL),(668,'668','0000-00-00','Prof. K Ramamritham','Dept. of Computer Science & Engg.','Indian Institute of Technology','Powai ','',142,NULL,17,0,'400076','',1,NULL,0,NULL),(669,'669','0000-00-00','Prof. V Ramamurthy','Department of Chemistry','University of Miami',' Coral Bables, FL 33124','',0,NULL,0,30,'0','',1,NULL,0,NULL),(670,'670','0000-00-00','Dr V S Ramamurthy','Director','National Inst. of Advanced Studies','IISc  Campus ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(671,'671','0000-00-00','Dr V Ramamurti','No. 2, IV Main','Kasturba Nagar',' ','',50,NULL,26,0,'600020','',1,NULL,0,NULL),(672,'672','0000-00-00','Prof. U Ramamurty','Dept. of Materials Engineering','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(673,'673','0000-00-00','Prof. R Raman','Department of Zoology','Banaras Hindu University',' ','',231,NULL,28,0,'221005','',1,NULL,0,NULL),(674,'674','0000-00-00','Prof. S Ramanan','Adjunct Professor','Chennai Mathematical Institute','SIPCOT IT Park Siruseri','',50,NULL,26,0,'603103','',1,NULL,0,NULL),(675,'675','0000-00-00','Prof. R Ramaraj','Director','Centre for Photoelectrochemistry','School of Chemistry Madurai Kamaraj University','',129,NULL,26,0,'625021','',1,NULL,0,NULL),(676,'676','0000-00-00','Dr T Ramasami','Secretary','Department of Science & Technology','Technology Bhavan New Mehrauli Road','',156,NULL,6,0,'110016','',1,NULL,0,NULL),(677,'677','0000-00-00','Prof. S Ramasesha','S.S.C.U.','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(678,'678','0000-00-00','Prof. S Ramasubramanian','Statistics & Mathematics Unit','Indian Statistical Institute','R.V. College P.O. ','',28,NULL,13,0,'560059','',1,NULL,0,NULL),(679,'679','0000-00-00','Prof. M K Ramaswamy','3446, Heathcliff Court','',' Westfield, IN 46074-5520','',0,NULL,0,30,'0','',1,NULL,0,NULL),(680,'680','0000-00-00','Prof. Mythily Ramaswamy','TIFR Centre for Appl. Mathemattics','P.B. No. 6503','Sharada Nagar ','',28,NULL,13,0,'560065','',1,NULL,0,NULL),(681,'681','0000-00-00','Prof. R Ramaswamy','Vice Chancellor','University of Hyderabad',' ','',87,NULL,1,0,'500046','',1,NULL,0,NULL),(682,'682','0000-00-00','Prof. Sriram R Ramaswamy','Department of Physics','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(683,'683','0000-00-00','Prof. A K Ramdas','Lark-Horovitz Distinguished','Professor','Department of Physics Purdue UniversityWest Lafayette, Indiana 4','',0,NULL,0,30,'0','',1,NULL,0,NULL),(684,'684','0000-00-00','Dr Sujatha Ramdorai','002, Jagriri','Varthur Road','Whitefield ','',28,NULL,13,0,'560066','',1,NULL,0,NULL),(685,'685','0000-00-00','Prof. R Ramesh','Geosciences Division','Physical Research Laboratory','Navgangpura ','',2,NULL,8,0,'380009','',1,NULL,0,NULL),(686,'686','0000-00-00','Dr V V Ranade','Chemical Engineering Division','National Chemical Laboratory',' ','',173,NULL,17,0,'411008','',1,NULL,0,NULL),(687,'687','0000-00-00','Prof. G S Ranganath','No. 422, Chitta','10th Cross, 8th Main','Padmanabhanagar ','',28,NULL,13,0,'560070','',1,NULL,0,NULL),(688,'688','0000-00-00','Prof. H A Ranganath','Director','National Assessment & Accreditation','Council P.B. No. 1075, Nagarbhavi','',28,NULL,13,0,'560072','',1,NULL,0,NULL),(689,'689','0000-00-00','Prof. Srinivasa Ranganathan','','Department of Materials Engineering','Indian Institute of Science ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(690,'690','0000-00-00','Prof. Subramania Ranganathan','Distinguished Scientist','Discovery Lab., Org. Chem. Div. III','Indian Inst. of Chemical Technology Uppal Road','',87,NULL,1,0,'500607','',1,NULL,0,NULL),(691,'691','0000-00-00','Prof. Govindan Rangarajan','Department of Mathematics','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(692,'692','0000-00-00','Prof. P N Rangarajan','Department of Biochemistry','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(693,'693','0000-00-00','Prof. N S Rangaswamy','KC-29B, Ashok Vihar','Phase I',' ','',58,NULL,6,0,'110052','',1,NULL,0,NULL),(694,'694','0000-00-00','Prof. B C Ranu','Dept. of Organic Chemistry','Indian Association for the','Cultivation of Science Jadavpur','',116,NULL,30,0,'700032','',1,NULL,0,NULL),(695,'695','0000-00-00','Prof. A J Rao','CSIR Emeritus Scientist','Department of Biochemistry','Indian Institute of Science ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(696,'696','0000-00-00','Prof. A Pramesh Rao','Flat 7, Khagol Housing Society','Panchavati','Pashan ','',173,NULL,17,0,'411008','',1,NULL,0,NULL),(697,'697','0000-00-00','Prof. A R Rao','Dept. of Astronomy & Astrophyswics','Tata Inst. of Fundamental Research','Homi Bhabha Road ','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(698,'698','0000-00-00','Prof. C N R Rao','Linus Pauling Research Professor','Jawaharlal Nehru Centre for','Advanced Scientific Research Indian Institute of Science Campus','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(699,'699','0000-00-00','Prof. C Pulla Rao','Dept.  of Chemistry','Indian Institute of Technology','Powai ','',142,NULL,17,0,'400076','',1,NULL,0,NULL),(700,'700','0000-00-00','Prof. C R Rao','Distingished Professor Emeritus','CR Rao Advanced Institute','University of Hyderabad Campus Prof. CR Rao Road Hyderabad 500 0','',0,NULL,1,0,'500016','',1,NULL,0,NULL),(701,'701','0000-00-00','Prof. D Narasimha Rao','Department of Biochemistry','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(702,'702','0000-00-00','Prof. K J Rao','Honorary Professor','S.S.C.U.','Indian Institute of Science ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(703,'703','0000-00-00','Prof. K K Rao','Department of Chemical Engineering','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(704,'704','0000-00-00','Dr K V S Rao','Head, Immunology Group','International Centre for Genetic','Engineering and Biotechnology Aruna Asaf Ali Marg','',156,NULL,6,0,'110067','',1,NULL,0,NULL),(705,'705','0000-00-00','Prof. M N Rao','16931 Tower Ridge','',' Friendswood, TX 77546','',0,NULL,0,30,'0','',1,NULL,0,NULL),(706,'706','0000-00-00','Prof. M R S Rao','President','Jawaharlal Nehru Centre for Adv.','Scientific Research Jakkur','',28,NULL,13,0,'560064','',1,NULL,0,NULL),(707,'707','0000-00-00','Prof. Madan Rao','Theoretical Physics Group','Raman Research Institute','CV Raman Avenue ','',28,NULL,13,0,'560080','',1,NULL,0,NULL),(708,'708','0000-00-00','Dr P B Rao','Visiting Professor (Hon.) ADCOS-DOS','National Remote Sensing Agency','PPEG, Building No. 10 Balanagar','',87,NULL,1,0,'500625','',1,NULL,0,NULL),(709,'709','0000-00-00','Prof. P Rama Rao','ISRO Dr Brahm Prakash Distinguished','Professor','ARCI for Powder Metallurgy & New Materials','',87,NULL,1,0,'500005','',1,NULL,0,NULL),(710,'710','0000-00-00','Prof. P V S Rao','Flat No. 601, Vigyan','Sector 17, Next to Garden','Vashi ','',154,NULL,17,0,'400703','',1,NULL,0,NULL),(711,'711','0000-00-00','Dr R Raghavendra Rao','328, B-4, Kendriya Vihar','Yelahanka',' ','',28,NULL,13,0,'560064','',1,NULL,0,NULL),(712,'712','0000-00-00','Prof. T S S R K Rao','Indian Statistical Institute','RV College P.O.',' ','',28,NULL,13,0,'560059','',1,NULL,0,NULL),(713,'713','0000-00-00','Prof. U R Rao','Chairman, PRL Council','Department of Space','Antariksh Bhavan New BEL Road','',28,NULL,13,0,'560231','',1,NULL,0,NULL),(714,'714','0000-00-00','Prof. V Ramagopal Rao','Dept.. of Electrical Engineering','Indian Institute of Technology','Powai ','',142,NULL,17,0,'400076','',1,NULL,0,NULL),(715,'715','0000-00-00','Prof. V S R Rao','No. 350, 1st A Cross','8th Main, III Stage','IV Block Basaveshwaranagar','',28,NULL,13,0,'560079','',1,NULL,0,NULL),(716,'716','0000-00-00','Prof. R G Rastogi','22B Lad Society','Sandesh Press Road','Bodakdev ','',2,NULL,8,0,'380054','',1,NULL,0,NULL),(717,'717','0000-00-00','Prof. R P Rastogi','295/281 KA','Asherfabad',' ','',127,NULL,28,0,'226003','',1,NULL,0,NULL),(718,'718','0000-00-00','Dr P Ratnasamy','4, Lalit Apartments','Gulmohar Park','ITI Road, Aundh ','',173,NULL,17,0,'411007','',1,NULL,0,NULL),(719,'719','0000-00-00','Dr V Ravi','Head, Dept. of Neurovirology','National Institute of Mental Health','& Neurosciences Hosur Road','',28,NULL,13,0,'560029','',1,NULL,0,NULL),(720,'720','0000-00-00','Prof. V Ravindran','Professor G','Harish Chandra Research Institute','Chhatnag Road Jhusi','',8,NULL,28,0,'211019','',1,NULL,0,NULL),(721,'721','0000-00-00','Dr Vijayalakshmi Ravindranath','Centre for Neuroscience','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(722,'722','0000-00-00','Prof. D S Ray','Dept. of Physical Chemistry','Indian Association for the','Cultivation of Science Jadavpur','',116,NULL,30,0,'700032','',1,NULL,0,NULL),(723,'723','0000-00-00','Prof. Amitava Raychaudhuri','Sir Tarak Nath Palit Professor','of Physics','University of Calcutta 92, APC Road','',116,NULL,30,0,'700009','',1,NULL,0,NULL),(724,'724','0000-00-00','Prof. Arup K Raychaudhuri','Director','SN Bose National Centre for Basic','Sciences JD Block, Sector 3, Salt Lake','',116,NULL,30,0,'700098','',1,NULL,0,NULL),(725,'725','0000-00-00','Prof. A Ramachandra Reddy','Vice Chancellor','Yogi Vemana University',' ','',101,NULL,1,0,'516003','',1,NULL,0,NULL),(726,'726','0000-00-00','Dr C R R M Reddy','404, Mount Kailash Apartments','Road No.4','Banjara Hills ','',87,NULL,1,0,'500034','',1,NULL,0,NULL),(727,'727','0000-00-00','Dr V U Reddy','Distinguished Professor (Emeritus)','CR Rao Adv. Inst. of Mathematics','University of Hyderabad Campus Prof. CR Rao Road','',87,NULL,1,0,'500046','',1,NULL,0,NULL),(728,'728','0000-00-00','Prof. S D Rindani','Theoretical Physics Division','Physical Research Laboratory','Navrangpura ','',2,NULL,8,0,'380009','',1,NULL,0,NULL),(729,'729','0000-00-00','Dr T H Rindani','2/52, Gulmohar','New MIG Colony','Kher Nagar Bandra East','',142,NULL,17,0,'400051','',1,NULL,0,NULL),(730,'730','0000-00-00','Prof. A B Roy','Flat III/2G, Niloy Apartment','46A, Ramnath Das Road','Dhakurja P.O. ','',116,NULL,30,0,'700031','',1,NULL,0,NULL),(731,'731','0000-00-00','Dr A P Roy','House No. E-1, RH-IV, Sector 9N','CBD','Belapur ','',154,NULL,17,0,'400614','',1,NULL,0,NULL),(732,'732','0000-00-00','Prof. D P Roy','DAE Raja Ramanna Fellow','Homi Bhabha Centre for Science','Education, TIFR VN Purav Marg, Mankhurd','',142,NULL,17,0,'400088','',1,NULL,0,NULL),(733,'733','0000-00-00','Prof. Probir Roy','DAE Raja Ramanna Fellow','Saha Institute of Nuclear Physics','Block AF, Sector 1 Bidhan Nagar','',116,NULL,30,0,'700064','',1,NULL,0,NULL),(734,'734','0000-00-00','Prof. Rahul Roy','','Indian Statistical Institute','7, SJS Sansanwal Marg ','',156,NULL,6,0,'110016','',1,NULL,0,NULL),(735,'735','0000-00-00','Dr Rajendra P Roy','Staff Scientist V','National Institute of Immunology','Aruna Asaf Ali Marg ','',156,NULL,6,0,'110067','',1,NULL,0,NULL),(736,'736','0000-00-00','Prof. S M Roy','DAE Raja Ramanna Fellow','Homi Bhabha Centre for Science Edn.','Near Anushakti Nagar Bus Depot VN Purav Marg, Mankhurd','',142,NULL,17,0,'400088','',1,NULL,0,NULL),(737,'737','0000-00-00','Dr Siddhartha Roy','Director','Indian Inst. of Chemical Biology','4, Raja SC Mullick Road ','',116,NULL,30,0,'700032','',1,NULL,0,NULL),(738,'738','0000-00-00','Dr Sujit Roy','Department of Chemistry','Indian Inst. of Technology','Samantapuri ','',38,NULL,21,0,'751013','',1,NULL,0,NULL),(739,'739','0000-00-00','Prof. Supriya Roy','99/5/10, Ballygunge Place','',' ','',116,NULL,30,0,'700019','',1,NULL,0,NULL),(740,'740','0000-00-00','Dr T K Roy','A-58, Gulmohur Park (G.F.)','',' ','',156,NULL,6,0,'110049','',1,NULL,0,NULL),(741,'741','0000-00-00','Mr S N Roy Chaudhury','No. 618','80 Feet Road','4th Block Koramangala','',28,NULL,13,0,'560034','',1,NULL,0,NULL),(742,'742','0000-00-00','Prof. N Rudraiah','UGC Emeritus Fellow','Department of Mathematics','Central College ','',28,NULL,13,0,'560001','',1,NULL,0,NULL),(743,'743','0000-00-00','Dr Bhaskar Saha','Scientist F','National Centre for Cell Science','Ganeshkhind ','',173,NULL,17,0,'411007','',1,NULL,0,NULL),(744,'744','0000-00-00','Dr Tanusri Saha-Dasgupta','SN Bose National Centre for Basic','Sciences','JD Block, Sector 3 Salt Lake','',116,NULL,30,0,'700098','',1,NULL,0,NULL),(745,'745','0000-00-00','Prof. Ashok Sahni','98, Mahatma Gandhi Marg','',' ','',127,NULL,28,0,'226001','',1,NULL,0,NULL),(746,'746','0000-00-00','Dr Girish Sahni','Director','Institute of Microbial Technology','Sector 39-A ','',48,NULL,31,0,'160036','',1,NULL,0,NULL),(747,'747','0000-00-00','Prof. Varun Sahni','Inter-University Centre for','Astronomy & Astrophysics','Post Bag 4, Ganeshkhind ','',173,NULL,17,0,'411007','',1,NULL,0,NULL),(748,'748','0000-00-00','Prof. S K Saidapur','Diamond Jubilee Professor','Department of Zoology','Karnatak University ','',62,NULL,13,0,'580003','',1,NULL,0,NULL),(749,'749','0000-00-00','Dr D M Salunke','Executive Director','Regional Centre for Biotechnology','180, Udyog Vihar, Phase 1 ','',79,NULL,10,0,'122016','',1,NULL,0,NULL),(750,'750','0000-00-00','Prof. Anunay Samanta','School of Chemistry','University of Hyderabad',' ','',87,NULL,1,0,'500046','',1,NULL,0,NULL),(751,'751','0000-00-00','Dr Mohammad Sami','Director','Centre for Theoretical Physics','Jamia Millia Islamia Jamia Nagar','',156,NULL,6,0,'110025','',1,NULL,0,NULL),(752,'752','0000-00-00','Prof. S Sampath','IPC Department','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(753,'753','0000-00-00','Prof. E V Sampathkumaran','Dept. of Condensed Matter Physics','and Materials Science','Tata Inst. of Fundamental Research Homi Bhabha Road','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(754,'754','0000-00-00','Dr P V Sane','C-739/B, Sector C','Mahanagar Extension',' ','',127,NULL,28,0,'226006','',1,NULL,0,NULL),(755,'755','0000-00-00','Prof. Sharad S Sane','Department of Mathematics','Indian Institute of Technology','Powai ','',142,NULL,17,0,'400076','',1,NULL,0,NULL),(756,'756','0000-00-00','Dr M Sanjappa','504, Block C-7, Kendriya Vihar','Bellary Road','Yelahanka ','',28,NULL,13,0,'560064','',1,NULL,0,NULL),(757,'757','0000-00-00','Prof. K Sankara Rao','Distinguished Fellow','Centre for Ecological Sciences','Indian Institute of Science ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(758,'758','0000-00-00','Prof. P Sankaran','Institute of Mathematical Sciences','CIT Campus, Taramani',' ','',50,NULL,26,0,'600113','',1,NULL,0,NULL),(759,'759','0000-00-00','Dr R Sankaranarayanan','','Centre for Cellular & Molecular','Biology Uppal Road','',87,NULL,1,0,'500007','',1,NULL,0,NULL),(760,'760','0000-00-00','Dr M Santappa','8 (old 73), Third Main Road','Kasturba Nagar','Adyar ','',50,NULL,26,0,'600020','',1,NULL,0,NULL),(761,'761','0000-00-00','Dr V Santhanam','`Shri Abhirami\'','107, Venkataswamy Road West','R S Puram P.O. ','',52,NULL,26,0,'641002','',1,NULL,0,NULL),(762,'762','0000-00-00','Prof. M K Sanyal','Director','Saha Institute of Nuclear Physics','1/AF, Bidhan Nagar ','',116,NULL,30,0,'700064','',1,NULL,0,NULL),(763,'763','0000-00-00','Prof. S C Sanyal','Udita 09-0303','Nabami','1050/1, Survey Park ','',116,NULL,30,0,'700075','',1,NULL,0,NULL),(764,'764','0000-00-00','Dr A Sarabhai','Director of Biocenter Laboratory','The Retreat','Shahibag ','',2,NULL,8,0,'380004','',1,NULL,0,NULL),(765,'765','0000-00-00','Dr Apurva Sarin','National Centre for Biological','Sciences','GKVK Campus ','',28,NULL,13,0,'560065','',1,NULL,0,NULL),(766,'766','0000-00-00','Prof. M M Sarin','Physical Research Laboratory','Navrangpura',' ','',2,NULL,8,0,'380009','',1,NULL,0,NULL),(767,'767','0000-00-00','Dr S K Sarin','Director','Inst. of Liver & Biliary Sciences','D1, Vasant Kunj ','',156,NULL,6,0,'110070','',1,NULL,0,NULL),(768,'768','0000-00-00','Prof. Anindya Sarkar','Dept. of Geology  & Geophysics','','Indian Institute of Technology ','',112,NULL,30,0,'721302','',1,NULL,0,NULL),(769,'769','0000-00-00','Prof. Chitra Sarkar','Department of Pathology','All India Inst. of Medical Sciences','Ansari Nagar ','',156,NULL,6,0,'110029','',1,NULL,0,NULL),(770,'770','0000-00-00','Prof. Debi Prasad Sarkar','Department of Biochemistry','University of Delhi South Campus','Benito Juarez Road ','',156,NULL,6,0,'110021','',1,NULL,0,NULL),(771,'771','0000-00-00','Dr P K Sarkar','INSA Sr. Scientist, Neurobiology Dn','Indian Inst. of Chemical Biology','4, Raja S.C. Mullick Road ','',116,NULL,30,0,'700032','',1,NULL,0,NULL),(772,'772','0000-00-00','Prof. S Sarkar','Department of Chemistry','Indian Institute of Technology',' ','',107,NULL,28,0,'208016','',1,NULL,0,NULL),(773,'773','0000-00-00','Dr Utpal Sarkar','Theoretical Physics Division','Physical Research Laboratory',' ','',2,NULL,8,0,'380009','',1,NULL,0,NULL),(774,'774','0000-00-00','Prof. D D Sarma','SSCU','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(775,'775','0000-00-00','Prof. V V S Sarma','2182, Siva','8th Main Road, E Block','Rajajinagar II Stage ','',28,NULL,13,0,'560010','',1,NULL,0,NULL),(776,'776','0000-00-00','Prof. V Sasisekharan','c/o Prof. Ram Sesisekharan','Dept. of Biological Sciences','Massachusetts Institute of TechnologyCambridge, MA 02139','',0,NULL,0,30,'0','',1,NULL,0,NULL),(777,'777','0000-00-00','Dr Murali Sastry','Chief Scientific Officer','Tata Chemicals Innovation Centre','Ghotavde Phata, Urawde Rd. G 1139/1 Pirangut Ind. Area, Mulshi','',173,NULL,17,0,'412108','',1,NULL,0,NULL),(778,'778','0000-00-00','Prof. Srikanth Sastry','Theoretical Sciences Unit','Jawaharlal Nehru Centre for Adv.','Scientific Research Jakkur','',28,NULL,13,0,'560064','',1,NULL,0,NULL),(779,'779','0000-00-00','Dr S K Satheesh','Centre for Atmospheric & Oceanic','Sciences','Indian Institute of Science ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(780,'780','0000-00-00','Prof. N Sathyamurthy','Director','Indian Inst. of Science Education','and Research MGSIPA Complex, Sector 26','',48,NULL,31,0,'160019','',1,NULL,0,NULL),(781,'781','0000-00-00','Prof.  Satya Prakash','395, Saraswathi Nagar','Near Azad Society',' ','',2,NULL,8,0,'380015','',1,NULL,0,NULL),(782,'782','0000-00-00','Prof. H S Savithri','Department of Biochemistry','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(783,'783','0000-00-00','Prof. R K Saxena','School of Life Sciences','Jawaharlal Nehru University',' ','',156,NULL,6,0,'110067','',1,NULL,0,NULL),(784,'784','0000-00-00','Prof. K L Sebastian','IPC Department','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(785,'785','0000-00-00','Prof. Abhijit Sen','Institute for Plasma Research','Bhat',' ','',72,NULL,8,0,'382428','',1,NULL,0,NULL),(786,'786','0000-00-00','Prof. Ashoke Sen','Harish Chandra Research Institute','Chhatnag Road, Jhusi',' ','',8,NULL,28,0,'211019','',1,NULL,0,NULL),(787,'787','0000-00-00','Prof. Diptiman Sen','Centre for High Energy Physics','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(788,'788','0000-00-00','Prof. K D Sen','School of Chemistry','University of Hyderabad',' ','',87,NULL,1,0,'500046','',1,NULL,0,NULL),(789,'789','0000-00-00','Prof. Sandeep Sen','Dept. of Computer Sci. & Engg.','Indian Institute of Technology',' ','',156,NULL,6,0,'110016','',1,NULL,0,NULL),(790,'790','0000-00-00','Prof. Krishnendu Sengupta','Dept. of Theoretical Physics','Indian Assn. for the Cultivation','of Science ','',116,NULL,30,0,'700032','',1,NULL,0,NULL),(791,'791','0000-00-00','Prof. Pulak Sengupta','Dept. of Geological Sciences','Jadavpur University','Jadavpur ','',116,NULL,30,0,'700032','',1,NULL,0,NULL),(792,'792','0000-00-00','Prof. Surajit Sengupta','Centre for Advanced Materials','Indian Association for Cultivation','of Science Jadavpur','',116,NULL,30,0,'700032','',1,NULL,0,NULL),(793,'793','0000-00-00','Prof. C S Seshadri','Director-Emeritus','Chennai Mathematical Institute','H1, Sipcot IT Park Padur Post, Siruseri','',50,NULL,26,0,'603103','',1,NULL,0,NULL),(794,'794','0000-00-00','Dr N Seshagiri','G-52, Narasimha Krupa','SBI Colony, 9th D Cross, 40th Main','J.P. Nagar I Phase ','',28,NULL,13,0,'560078','',1,NULL,0,NULL),(795,'795','0000-00-00','Dr N Sethunathan','Flat No. 103, Ushodaya Apartments','Sri Venkateswara Officers\' Colony','Ramakrishnapuram ','',195,NULL,1,0,'500056','',1,NULL,0,NULL),(796,'796','0000-00-00','Prof. Nimish A Shah','Department of Mathematics','Ohio State University',' Columbus, OH 43220','',0,NULL,0,30,'0','',1,NULL,0,NULL),(797,'797','0000-00-00','Dr Chandrima Shaha','Director','National Institute of Immunology','Aruna Asaf Ali Marg ','',156,NULL,6,0,'110067','',1,NULL,0,NULL),(798,'798','0000-00-00','Prof. M S Shaila','Professor Emeritus','MCB Department','Indian Institute of Science ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(799,'799','0000-00-00','Prof. Bhagyashri A Shanbhag','Department of Zoology','Karnatak University',' ','',62,NULL,13,0,'580003','',1,NULL,0,NULL),(800,'800','0000-00-00','Dr D Shankar','Physical Oceanography Division','National Institute of Oceanography',' ','',64,NULL,7,0,'403004','',1,NULL,0,NULL),(801,'801','0000-00-00','Dr P N Shankar','33/1, Kasturba Road Cross','',' ','',28,NULL,13,0,'560001','',1,NULL,0,NULL),(802,'802','0000-00-00','Dr G Shanmugam','3-118C, Kalvi Nagar','Near MKU',' ','',129,NULL,26,0,'625021','',1,NULL,0,NULL),(803,'803','0000-00-00','Prof. A K Sharma','Flat 2F2 Meghmallar','18/3, Gariahat Road',' ','',116,NULL,30,0,'700019','',1,NULL,0,NULL),(804,'804','0000-00-00','Dr Amit P Sharma','Group Leader & Staff Scientist','Int. Centre for Genetic Engg.','& Biotechnology Aruna Asaf Ali Marg','',156,NULL,0,0,'110067','',1,NULL,0,NULL),(805,'805','0000-00-00','Prof. Anurag Sharma','Department of Physics','Indian Institute of Technology',' ','',156,NULL,6,0,'110016','',1,NULL,0,NULL),(806,'806','0000-00-00','Prof. Ashutosh Sharma','Dept. of Chemical Engineering','Indian Institute of Technology',' ','',107,NULL,28,0,'208016','',1,NULL,0,NULL),(807,'807','0000-00-00','Prof. K N Sharma','503, 6th A Main, 12th Cross','HIG Colony, RMV II Stage',' ','',28,NULL,13,0,'560094','',1,NULL,0,NULL),(808,'808','0000-00-00','Prof. M M Sharma','2/3, Jaswant Baug','Behind Akbarallys','V.N. Purav Marg Chembur','',142,NULL,17,0,'400071','',1,NULL,0,NULL),(809,'809','0000-00-00','Dr R P Sharma','Scientist Emeritus','NRC on Plant Biotechnology','Indian Agricultural Research Institute','',156,NULL,6,0,'110012','',1,NULL,0,NULL),(810,'810','0000-00-00','Prof. R S Sharma','70/36 Pratapnagar, Sector 7','Sanganer (RHB)',' ','',92,NULL,24,0,'302033','',1,NULL,0,NULL),(811,'811','0000-00-00','Prof. Ram Prakash Sharma','E-45, DGS  Housing Society','Sector 22, Plot No. 6','Dwaraka ','',156,NULL,6,0,'110045','',1,NULL,0,NULL),(812,'812','0000-00-00','Prof. Shobhona Sharma','Department of Biological Sciences','Tata Inst. of Fundamental Research','Homi Bhabha Road ','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(813,'813','0000-00-00','Dr Surendra K Sharma','Department of Medicine','All India Inst. of Medical Sciences','Ansari Nagar ','',156,NULL,6,0,'110029','',1,NULL,0,NULL),(814,'814','0000-00-00','Dr Surinder Mohan Sharma','High Pressure & SRP Division','Bhabha Atomic Research Centre','Trombay ','',142,NULL,17,0,'400085','',1,NULL,0,NULL),(815,'815','0000-00-00','Dr V P Sharma','B9/6476 FF','Vasant Kunj',' ','',156,NULL,6,0,'110070','',1,NULL,0,NULL),(816,'816','0000-00-00','Prof. Vijay K Sharma','EOB Unit','JN Centre for Adv. Scientific','Research Jakkur P.O.','',28,NULL,13,0,'560064','',1,NULL,0,NULL),(817,'817','0000-00-00','Prof. Y D Sharma','Head, Dept. of Biotechnology','All India Inst. of Medical Sciences','Ansari Nagar ','',156,NULL,6,0,'110029','',1,NULL,0,NULL),(818,'818','0000-00-00','Dr Yogendra Sharma','Centre for Cellular & Molecular','Biology','Uppal Road ','',87,NULL,1,0,'500007','',1,NULL,0,NULL),(819,'819','0000-00-00','Prof. R Shashidhar','Senior Vice President','Polestar Technologies Inc','2121, Eisenhower Avenue Suite 225Alexandria, VA  22314','',0,NULL,0,30,'0','',1,NULL,0,NULL),(820,'820','0000-00-00','Prof. L S Shashidhara','Co-ordinator, Biology','Indian Inst of Science Education','& Research,900, NCL Innovation Park Dr Homi Bhaba Road','',173,NULL,17,0,'411008','',1,NULL,0,NULL),(821,'821','0000-00-00','Prof. B S Shastry','Department of Physics','University of California',' Santa Cruz, CA 95064','',0,NULL,0,30,'0','',1,NULL,0,NULL),(822,'822','0000-00-00','Dr S V S Shastry','\'Ashoka\'','202, Gautami Apartments','Barkatpura ','',87,NULL,1,0,'500027','',1,NULL,0,NULL),(823,'823','0000-00-00','Dr S S Chandra Shenoi','Director','Indian Natl. Centre for Information','Sciences, P.B. No. 21 Ocean Valley, Jeedimatla Post','',87,NULL,1,0,'500055','',1,NULL,0,NULL),(824,'824','0000-00-00','Prof. S R Shenoy','Visiting Professor','IISER','College of Engg. Campus Computer Science Building','',217,NULL,14,0,'695016','',1,NULL,0,NULL),(825,'825','0000-00-00','Prof. H Shekar Shetty','Dept. of Studies in Applied Botany','University of Mysore','Manasagangotri ','',145,NULL,13,0,'570006','',1,NULL,0,NULL),(826,'826','0000-00-00','Dr S R Shetye','Director','National Institute of Oceanography',' ','',64,NULL,7,0,'403004','',1,NULL,0,NULL),(827,'827','0000-00-00','Dr S Shivaji','','Centre for Cellular & Molecular','Biology Uppal Road','',87,NULL,1,0,'500007','',1,NULL,0,NULL),(828,'828','0000-00-00','Prof. K R Shivanna','Honorary Senior Fellow','Ashoka Trust for Res. in Ecology','& the Environment Royal Arcade, Sriramapura, Jakkur','',28,NULL,13,0,'560064','',1,NULL,0,NULL),(829,'829','0000-00-00','Dr G V Shivashankar','National Centre for Biolobical','Sciences','GKVK Campus ','',28,NULL,13,0,'560065','',1,NULL,0,NULL),(830,'830','0000-00-00','Prof. T N Shorey','Distinguished Professor','Department of Mathematics','Indian Institute of Technology Powai','',142,NULL,17,0,'400076','',1,NULL,0,NULL),(831,'831','0000-00-00','Prof. S S Shrikhande','7, Kautilya Marg','',' ','',0,NULL,0,0,'0','',1,NULL,0,NULL),(832,'832','0000-00-00','Prof. A K Shukla','SSCU','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(833,'833','0000-00-00','Prof.  Shyam Sundar','Professor of Medicine','Institute of Medical Sciences','Banaras Hindu University ','',231,NULL,28,0,'221005','',1,NULL,0,NULL),(834,'834','0000-00-00','Prof. R K Shyamasundar','Dean, Tech. & Computer Sci. Faculty','Tata Inst. of Fundamental Research','Homi Bhabha Road ','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(835,'835','0000-00-00','Dr Imran Siddiqi','Centre for Cellular & Molecular','Biology','Uppal Road ','',87,NULL,1,0,'500007','',1,NULL,0,NULL),(836,'836','0000-00-00','Prof. O Siddiqi','Emeritus Professor','National Centre for Biological','Sciences, GKVK Campus ','',28,NULL,13,0,'560065','',1,NULL,0,NULL),(837,'837','0000-00-00','Prof. S K Sikdar','MBU','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(838,'838','0000-00-00','Mr D R Sikka','40, Mausam Vihar','',' ','',58,NULL,6,0,'110051','',1,NULL,0,NULL),(839,'839','0000-00-00','Dr S K Sikka','DAE Homi Bhabha Chair Professor','Bhabha Atomic Research Centre','A6-27, Central Complex Trombay','',142,NULL,17,0,'400085','',1,NULL,0,NULL),(840,'840','0000-00-00','Prof. R Simon','Institute of Mathematical Sciences','CIT Campus, Taramani',' ','',50,NULL,26,0,'600113','',1,NULL,0,NULL),(841,'841','0000-00-00','Prof. Anil Kumar Singh','Vice Chancellor','University of Allahabad',' ','',8,NULL,28,0,'211002','',1,NULL,0,NULL),(842,'842','0000-00-00','Dr B B Singh','D-7 Fair Lawn','VN Purav Marg','Chembur ','',142,NULL,17,0,'400071','',1,NULL,0,NULL),(843,'843','0000-00-00','Prof. Balwant Singh','105, Vaigyanik Society','Plots 58-59, Sector 14','Vashi ','',154,NULL,17,0,'400703','',1,NULL,0,NULL),(844,'844','0000-00-00','Prof. D V Singh','Apartment 1002, Tower 2','Sunbreeze Apartments, Vaishali','Sector 5, Plot 3 ','',74,NULL,28,0,'201010','',1,NULL,0,NULL),(845,'845','0000-00-00','Prof. Harkesh B Singh','Department of Chemistry','Indian Institute of Technology','Powai ','',142,NULL,17,0,'400076','',1,NULL,0,NULL),(846,'846','0000-00-00','Prof. J S Singh','Professor Emeritus','Department of Botany','Banaras Hindu University ','',231,NULL,28,0,'221005','',1,NULL,0,NULL),(847,'847','0000-00-00','Prof. K P Singh','Dept. of Astronomy & Astrophysics','Tata Inst. of Fundamental Research','Homi Bhabha Road ','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(848,'848','0000-00-00','Dr Lalji Singh','Vice Chancellor','Banaras Hindu University',' ','',231,NULL,28,0,'221005','',1,NULL,0,NULL),(849,'849','0000-00-00','Prof. Mewa Singh','Department of Studies in Psychology','University of Mysore',' ','',145,NULL,13,0,'570006','',1,NULL,0,NULL),(850,'850','0000-00-00','Dr R N Singh','INSA Senior Scientist','National Geophysical Research','Institute Uppal Road','',87,NULL,1,0,'500606','',1,NULL,0,NULL),(851,'851','0000-00-00','Prof. Randhir Singh','Director','Seth Jai Prakash Mukand Lal Institute','of Engineering & Technology Yamuna Nagar','',175,NULL,10,0,'135133','',1,NULL,0,NULL),(852,'852','0000-00-00','Prof. Sarva Jit Singh','22A, Navyug Adarsh Apartments','F Block, Vikaspuri',' ','',156,NULL,6,0,'110018','',1,NULL,0,NULL),(853,'853','0000-00-00','Prof. T P Singh','Distinguished Biotech. Res. Prof.','Department of Biophysics','All India Institute of Medical Sciences, Ansari Nagar','',156,NULL,6,0,'110029','',1,NULL,0,NULL),(854,'854','0000-00-00','Prof. Vinod K Singh','Director','Indian Inst. of Science Education','& Research, Transit Campus ITI (Gas Rahat) Bldg., Govindpura','',37,NULL,18,0,'462023','',1,NULL,0,NULL),(855,'855','0000-00-00','Prof. Virendra Singh','51, New Cosmos','Juhu-Varsova Link Road','Andheri (West) ','',142,NULL,17,0,'400053','',1,NULL,0,NULL),(856,'856','0000-00-00','Prof. Y Singh','Professor Emeritus','Dept. of Physics','Banaras Hindu University ','',231,NULL,28,0,'221005','',1,NULL,0,NULL),(857,'857','0000-00-00','Dr Yogendra Singh','','Institute of Genomics & Integrative','Biology Mall Road','',58,NULL,6,0,'110007','',1,NULL,0,NULL),(858,'858','0000-00-00','Prof. N K M Singhi','School of Mathematics','Tata Inst. of Fundamental Research','Homi Bhabha Road ','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(859,'859','0000-00-00','Prof. A K Singhvi','Outstanding Scientist, PGS Division','Physical Research Laboratory','Navrangpura ','',2,NULL,8,0,'380009','',1,NULL,0,NULL),(860,'860','0000-00-00','Prof. A P B Sinha','1 Vrindavan Society','',' ','',173,NULL,17,0,'411008','',1,NULL,0,NULL),(861,'861','0000-00-00','Prof. B C Sinha','DAE Homi Bhabha Professor','Variable Energy Cyclotron Centre','1/AF, Bidhan Nagar ','',116,NULL,30,0,'700064','',1,NULL,0,NULL),(862,'862','0000-00-00','Prof. K B Sinha','Honorary Professor','JN Centre for Advanced','Scientific Research Jakkur','',28,NULL,13,0,'560064','',1,NULL,0,NULL),(863,'863','0000-00-00','Prof. K P Sinha','Sterling Residency','D-105, RMV II Stage','Dollars Colony ','',28,NULL,13,0,'560094','',1,NULL,0,NULL),(864,'864','0000-00-00','Prof. Pratima Sinha','Dept. of Biochemistry','Bose Institute','Centenary Building P-1/12, CIT Scheme VII M','',116,NULL,30,0,'700054','',1,NULL,0,NULL),(865,'865','0000-00-00','Dr Somdatta Sinha','Professor of Biology','IISER','Sector 81, Knowledge City P.O. Manauli','',193,NULL,22,0,'140306','',1,NULL,0,NULL),(866,'866','0000-00-00','Prof. Subrata Sinha','Director','National Brain Research Centre','Near NSG Campus Nainwal Mode, Manesar','',79,NULL,10,0,'122050','',1,NULL,0,NULL),(867,'867','0000-00-00','Prof. Sudeshna Sinha','Indian Inst. of Science Education','& Research, Transit Campus','Knowledge City, Sector 81 Manauli P.O.','',193,NULL,22,0,'140306','',1,NULL,0,NULL),(868,'868','0000-00-00','Prof. A Sitaram','Raja Ramanna Fellow','Department of Mathematics','Indian Institute of Science ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(869,'869','0000-00-00','Prof. V Sitaramam','Plot No. 18, S.No. 245','Anant Co-op.Hsg Soc.,','D.P. Road ','',173,NULL,17,0,'411007','',1,NULL,0,NULL),(870,'870','0000-00-00','Dr C SivaRaman','111, Anand Park','Aundh',' ','',173,NULL,17,0,'411007','',1,NULL,0,NULL),(871,'871','0000-00-00','Dr S Sivaram','CSIR Bhatnagar Fellow','National Chemical Laboratory',' ','',173,NULL,17,0,'411008','',1,NULL,0,NULL),(872,'872','0000-00-00','Dr S Sivasanker','Chair Professor','Natl. Centre for Catalysis Research','Indian Inst. of Technology ','',50,NULL,26,0,'600036','',1,NULL,0,NULL),(873,'873','0000-00-00','Prof. K Somasundaram','MCB Department','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(874,'874','0000-00-00','Prof. B L K Somayajulu','No. 3, New Aangan Members\' Assn.','Vastrapur',' ','',2,NULL,8,0,'380015','',1,NULL,0,NULL),(875,'875','0000-00-00','Dr Ramesh V Sonti','Scientist EII','Centre for Cellular & Molecular','Biology Uppal Road','',87,NULL,1,0,'500007','',1,NULL,0,NULL),(876,'876','0000-00-00','Prof. A K Sood','Department of Physics','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(877,'877','0000-00-00','Prof. S K Sopory','Vice Chancellor','Jawaharlal Nehru University',' ','',156,NULL,6,0,'110067','',1,NULL,0,NULL),(878,'878','0000-00-00','Dr R Sowdhamini','National Centre for Biological','Sciences','GKVK Campus ','',28,NULL,13,0,'560065','',1,NULL,0,NULL),(879,'879','0000-00-00','Prof. B V Sreekantan','(Hon) Visiting Professor','National Inst. of Advanced Studies','Indian Institute of Science Campus ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(880,'880','0000-00-00','Prof.  Sri Niwas','Department of Earth Sciences','Indian Institute of Technology',' ','',187,NULL,29,0,'247667','',1,NULL,0,NULL),(881,'881','0000-00-00','Dr R Srianand','Inter-University Centre for','Astronomy & Astrophysics','Ganeshkhind ','',173,NULL,17,0,'411007','',1,NULL,0,NULL),(882,'882','0000-00-00','Prof. A Sridharan','No. 40, West Park Road','Malleswaram',' ','',28,NULL,13,0,'560003','',1,NULL,0,NULL),(883,'883','0000-00-00','Prof. Rajagopal Sridharan','CSIR Emeritus Scientist','Physical Research Laboratory','Room 777 Navrangpura','',2,NULL,8,0,'380009','',1,NULL,0,NULL),(884,'884','0000-00-00','Prof. Ramaiyengar Sridharan','Chennai Mathematical Institute','H1, Sipcot IT Park','Padur Post Siruseri','',50,NULL,26,0,'603103','',1,NULL,0,NULL),(885,'885','0000-00-00','Prof. A Srikrishna','Department of Organic Chemistry','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(886,'886','0000-00-00','Prof. L S Srinath','H-401, ETA Star','No. 9, Magadi Road',' ','',28,NULL,13,0,'560023','',1,NULL,0,NULL),(887,'887','0000-00-00','Prof. V Srinivas','School of Mathematics','Tata Institute of Fundamental Res.','Homi Bhabha Road ','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(888,'888','0000-00-00','Prof. G Srinivasan','190, I Main Road','I Block, BEL Layout','Vidyaranyapura ','',28,NULL,13,0,'560097','',1,NULL,0,NULL),(889,'889','0000-00-00','Prof. J Srinivasan','','Centre for Atmospheric & Oceanonic','Sciences Indian Institute of Science','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(890,'890','0000-00-00','Prof. M S Srinivasan','42/4, HIG Flats','Kabir Nagar','Durgakund ','',231,NULL,28,0,'221005','',1,NULL,0,NULL),(891,'891','0000-00-00','Prof. N Srinivasan','Molecular Biophysics Unit','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(892,'892','0000-00-00','Prof. Ramaswami Srinivasan','143, V Cross','III Main Road','Vijayanagar I Stage ','',145,NULL,13,0,'570012','',1,NULL,0,NULL),(893,'893','0000-00-00','Dr Ramaswamiah Srinivasan','114, \'Kshithija\'','Ramanashree Nagar','SOS Post, Banneraghatta Road','',28,NULL,13,0,'560076','',1,NULL,0,NULL),(894,'894','0000-00-00','Prof. D C Srivastava','Department of Earth Sciences','Indian Institute of Technology',' ','',187,NULL,29,0,'247667','',1,NULL,0,NULL),(895,'895','0000-00-00','Prof. R K Srivastava','Department of Geology','Banaras Hindu University',' ','',231,NULL,28,0,'221005','',1,NULL,0,NULL),(896,'896','0000-00-00','Prof. B C Subba Rao','\'Sri Ganga\'','No. 8, Temple Road','Jayalakshmipuram ','',145,NULL,13,0,'570012','',1,NULL,0,NULL),(897,'897','0000-00-00','Dr B R Subba Rao','29, Osward Road','Balham',' London SW17 7SS','',0,NULL,0,29,'0','',1,NULL,0,NULL),(898,'898','0000-00-00','Prof. G S R Subba Rao','1A, Pradhan Apts','16/5, 18th Cross','Malleswaram ','',28,NULL,13,0,'560055','',1,NULL,0,NULL),(899,'899','0000-00-00','Prof. G V Subba Rao','Department of Physics','National University of Singapore','South Kent Ridge Singapore 119260','',0,NULL,0,24,'0','',1,NULL,0,NULL),(900,'900','0000-00-00','Prof. E C Subbarao','Chief Consulting Adivser','Tata Consultancy Services Limited','54B, Hadapsar Ind. Estate ','',173,NULL,17,0,'411013','',1,NULL,0,NULL),(901,'901','0000-00-00','Prof. K V Subbarao','Centre for Earth & Space Sciences','A-18, Faculty Quarters','University of Hyderabad ','',87,NULL,1,0,'500046','',1,NULL,0,NULL),(902,'902','0000-00-00','Prof. C R Subrahmanya','Emeritus Professor','Raman Research Institute',' ','',28,NULL,13,0,'560080','',1,NULL,0,NULL),(903,'903','0000-00-00','Prof. N C Subrahmanyam','Unit 3, 28 Boronia Grove','Doncaster East',' Victoria 3109','',0,NULL,0,1,'0','',1,NULL,0,NULL),(904,'904','0000-00-00','Prof. C V Subramanian','A-8, Damayanti Apartments','17, South Mada Street','Nungambakkam ','',50,NULL,26,0,'600034','',1,NULL,0,NULL),(905,'905','0000-00-00','Prof. D Subramanian','Flat 401, Plot 886-890','Defence Colony','Sainikpuri ','',195,NULL,1,0,'500094','',1,NULL,0,NULL),(906,'906','0000-00-00','Prof. K Subramanian','Inter-University Centre for','Astornomy & Astrophysics','Post Bag 4, Ganeshkhind ','',173,NULL,17,0,'411007','',1,NULL,0,NULL),(907,'907','0000-00-00','Prof. S Subramanian','Radiation Biology Branch','Building 10, Room B3-B69','National Institutes of Health Bethesda, MD 20892','',0,NULL,0,30,'0','',1,NULL,0,NULL),(908,'908','0000-00-00','Prof. S V Subramanyam','No. 1, 8th Main','Sharada Colony','Basaveswaranagar ','',28,NULL,13,0,'560079','',1,NULL,0,NULL),(909,'909','0000-00-00','Prof. E C G Sudarshan','Department of Physics','University of Texas',' Austin, TX 78712','',0,NULL,0,30,'0','',1,NULL,0,NULL),(910,'910','0000-00-00','Dr  Sukh Dev','\'Aasheerwaad\', 120-ISCON Mega City','',' ','',33,NULL,8,0,'364002','',1,NULL,0,NULL),(911,'911','0000-00-00','Prof. S P Sukhatme','2-A/8-C, Anjaneya Co-op. Hsg. Soc.','Orchard Avenue','Opp. Hiranandani Foundation School Powai','',142,NULL,17,0,'400076','',1,NULL,0,NULL),(912,'912','0000-00-00','Prof. R Sukumar','Centre for Ecological Sciences','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(913,'913','0000-00-00','Dr C S Sundar','Head, Materials Science Division','Indira Gandhi Centre for Atomic','Research ','',103,NULL,26,0,'603102','',1,NULL,0,NULL),(914,'914','0000-00-00','Mr S Sundaram','3B, Raghava Apartments','41C (New No. 66), Beach Road','Kalakshetra Colony ','',50,NULL,26,0,'600090','',1,NULL,0,NULL),(915,'915','0000-00-00','Dr G Sundararajan','Director','IARC for Powder Metallurgy &','New Materials(ARCI) Balapur P.O.','',87,NULL,1,0,'500005','',1,NULL,0,NULL),(916,'916','0000-00-00','Dr R Sunder','Technical Director','BISS Research','41A, 1st A Cross, AECS II Stage RMV Extension','',28,NULL,13,0,'560094','',1,NULL,0,NULL),(917,'917','0000-00-00','Prof. V S Sunder','Institute of Mathematical Sciences','CIT Campus, Taramani',' ','',50,NULL,26,0,'600113','',1,NULL,0,NULL),(918,'918','0000-00-00','Prof. V Suresh','Department of Mathematics and','Statistics','University of Hyderabad ','',87,NULL,1,0,'500046','',1,NULL,0,NULL),(919,'919','0000-00-00','Prof. A Surolia','MBU','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(920,'920','0000-00-00','Prof. Namita Surolia','Molecular Biology & Genetics Unit','Jawaharlal Nehru Centre for','Advanced Scientific Research Jakkur P.O.','',28,NULL,13,0,'560064','',1,NULL,0,NULL),(921,'921','0000-00-00','Prof. A K Susheela','Executive Director','Fluorosis Research & Rural','Development Foundation B-1, Saransh','',58,NULL,6,0,'110092','',1,NULL,0,NULL),(922,'922','0000-00-00','Prof.  Sushil Kumar','INSA Senior Scientist','National Institute for Plant Genome','Research JNU Campus','',156,NULL,6,0,'110067','',1,NULL,0,NULL),(923,'923','0000-00-00','Prof. M S Swaminathan','Chairman','MS Swaminathan Research Foundation','III Cross Street,Institutional Area Taramani','',50,NULL,26,0,'600113','',1,NULL,0,NULL),(924,'924','0000-00-00','Prof. S Swaminathan','No. 6, 12th Cross Street','Shastri Nagar',' ','',50,NULL,26,0,'600020','',1,NULL,0,NULL),(925,'925','0000-00-00','Prof. M J Swamy','School of Chemistry','University of Hyderabad',' ','',87,NULL,1,0,'500046','',1,NULL,0,NULL),(926,'926','0000-00-00','Dr Ghanshyam Swarup','Centre for Cellular and','Molecular Biology','Uppal Road ','',87,NULL,1,0,'500007','',1,NULL,0,NULL),(927,'927','0000-00-00','Prof. Govind Swarup','10, Cozy Retreat','Sindh Society, Road No. 3','Aundh ','',173,NULL,17,0,'411007','',1,NULL,0,NULL),(928,'928','0000-00-00','Dr Qudsia Tahseen','Department of Zoology','Aligarh Muslim University',' ','',7,NULL,28,0,'202002','',1,NULL,0,NULL),(929,'929','0000-00-00','Prof. G P Talwar','Talwar Research Foundation','E-6-8, Neb Valley','Neb Sarai Sainik Farma','',156,NULL,6,0,'110068','',1,NULL,0,NULL),(930,'930','0000-00-00','Prof. P N Tandon','No. 1, Jagriti Enclave','Vikas Marg Extension',' ','',58,NULL,6,0,'110092','',1,NULL,0,NULL),(931,'931','0000-00-00','Prof. S K Tandon','A-566C, Susahnt Lok','Phase 1',' ','',79,NULL,10,0,'122002','',1,NULL,0,NULL),(932,'932','0000-00-00','Prof. S N Tandon','Emeritus Professor','IU Centre for Astronomy','& Astrophysics, (IUCAA) Post Bag 4, Ganeshkhind','',173,NULL,17,0,'411007','',1,NULL,0,NULL),(933,'933','0000-00-00','Prof. M M Taqui Khan','17-3-479','Yakutpura',' ','',87,NULL,1,0,'500023','',1,NULL,0,NULL),(934,'934','0000-00-00','Prof. Utpal S Tatu','Dept. of Biochemistry','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(935,'935','0000-00-00','Dr V C Thakur','9/12 (Lane 9)','Ashirwad Enclave',' ','',57,NULL,29,0,'248001','',1,NULL,0,NULL),(936,'936','0000-00-00','Prof. S Thangavelu','Department of Mathematics','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(937,'937','0000-00-00','Prof. M A L Thathachar','23, 10th Cross Road','Swimming Pool Extension','Malleswaram ','',28,NULL,13,0,'560003','',1,NULL,0,NULL),(938,'938','0000-00-00','Prof. B K Thelma','Department of Genetics','University of Delhi South Campus','Benito Juarez Road ','',156,NULL,6,0,'110021','',1,NULL,0,NULL),(939,'939','0000-00-00','Prof. P S Thiagarajan','Department of Computer Science','National University of Singapore','13 Computing Drive Singapore 117 417','',0,NULL,0,24,'0','',1,NULL,0,NULL),(940,'940','0000-00-00','Dr George K Thomas','Indian Institute of Science','Education & Research','CET Campus ','',217,NULL,14,0,'695016','',1,NULL,0,NULL),(941,'941','0000-00-00','Dr Shubha Tole','Dept. of Biological Sciences','Tata Inst. of Fundamental Research','Homi Bhabha Road ','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(942,'942','0000-00-00','Prof. Sandip P Trivedi','Department of Theoretical Physics','Tata Inst. of Fundamental Research','Homi Bhabha Road ','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(943,'943','0000-00-00','Dr Rakesh Tuli','Executive Director','National Agrifood Biotechnology','Institute C127, Industrial Area, SAS Nagar','',140,NULL,22,0,'160071','',1,NULL,0,NULL),(944,'944','0000-00-00','Dr Narendra Tuteja','International Centre for Genetic','Engineering & Biotechnology','Aruna Asaf Ali Marg ','',156,NULL,6,0,'110067','',1,NULL,0,NULL),(945,'945','0000-00-00','Prof. Akhilesh K Tyagi','Director','National Inst. of Plant Genome','Research Aruna Asaf Ali Marg','',156,NULL,6,0,'110067','',1,NULL,0,NULL),(946,'946','0000-00-00','Prof. Anil K Tyagi','Department of Biochemistry','University of Delhi South Campus','Benito Juarez Road ','',156,NULL,6,0,'110021','',1,NULL,0,NULL),(947,'947','0000-00-00','Dr Jaya S Tyagi','Department of Biotechnology','All India Institute of Medical','Sciences Ansari Nagar','',156,NULL,6,0,'110029','',1,NULL,0,NULL),(948,'948','0000-00-00','Prof. B M Udgaonkar','705 Vidnyan, Scientists\' Co-opera-','tive Housing Scoiety','Plot No. 23, Sector 17 Vashi','',154,NULL,17,0,'400703','',1,NULL,0,NULL),(949,'949','0000-00-00','Dr Jayant B Udgaonkar','National Centre for Biological','Sciences','TIFR Centre GKVK Campus','',28,NULL,13,0,'560065','',1,NULL,0,NULL),(950,'950','0000-00-00','Prof. R Uma Shaanker','Department of Crop Physiology','University of Agricultural Sciences','G.K.V.K. ','',28,NULL,13,0,'560065','',1,NULL,0,NULL),(951,'951','0000-00-00','Prof. Siva Umapathy','IPC Department','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(952,'952','0000-00-00','Dr M Vairamani','Dean, School of Bioengineering','SRM University',' ','',111,NULL,26,0,'603203','',1,NULL,0,NULL),(953,'953','0000-00-00','Prof. K S Valdiya','INSA Golden Jubilee Res. Professor','Jawaharlal Nehru Centre for','Advanced Scientific Research Jakkur P.O.','',28,NULL,13,0,'560064','',1,NULL,0,NULL),(954,'954','0000-00-00','Prof. M S Valiathan','National Research Professor','Manipal University','Madhava Nagar ','',134,NULL,13,0,'576104','',1,NULL,0,NULL),(955,'955','0000-00-00','Dr S R Valluri','\'Prashanthi\'','659, 100 Feet Road','Indiranagar ','',28,NULL,13,0,'560038','',1,NULL,0,NULL),(956,'956','0000-00-00','Prof. Y D Vankar','Department of Chemistry','Indian Institute of Technology',' ','',107,NULL,28,0,'208016','',1,NULL,0,NULL),(957,'957','0000-00-00','Prof. M Vanninathan','TIFR-Centre for Appl. Mathematics','P.B. No. 6503','Sharada Nagar ','',28,NULL,13,0,'560065','',1,NULL,0,NULL),(958,'958','0000-00-00','Prof. R Varadarajan','Molecular Biophysics Unit','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(959,'959','0000-00-00','Dr S Varadarajan','4A, Girdhar Apartments','28, Feroz Shah Road',' ','',156,NULL,6,0,'110001','',1,NULL,0,NULL),(960,'960','0000-00-00','Prof. M S Vardya','502, Vigyanshila','Juhu-Varsova Link Road','Seven Bungalows ','',142,NULL,17,0,'400061','',1,NULL,0,NULL),(961,'961','0000-00-00','Prof. R K Varma','303, Saraswati Nagar','',' ','',2,NULL,8,0,'380015','',1,NULL,0,NULL),(962,'962','0000-00-00','Prof. R M Varma','No. 2, III Cross','Lakshmi Road','Shanti Nagar ','',28,NULL,13,0,'560027','',1,NULL,0,NULL),(963,'963','0000-00-00','Prof. Umesh Varshney','MCB Department','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(964,'964','0000-00-00','Prof. S Vasudevan','IPC Department','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(965,'965','0000-00-00','Prof. K Veluthambi','Head','Dept. of Plant Biotechnology','Madurai Kamaraj University ','',129,NULL,26,0,'625021','',1,NULL,0,NULL),(966,'966','0000-00-00','Prof. G Venkataraman','R1, A2 Mandir','',' ','',171,NULL,1,0,'515134','',1,NULL,0,NULL),(967,'967','0000-00-00','Prof. T N Venkataramana','School of Mathematics','Tata Inst. of Fundamental Research','Homi Bhabha Road ','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(968,'968','0000-00-00','Prof. K Venkatesan','Himagiri Apartments - D1','77, Fourth Main Road','Malleswaram ','',28,NULL,13,0,'560055','',1,NULL,0,NULL),(969,'969','0000-00-00','Prof. Y V Venkatesh','Department of ECE','National University of Singapore','10, Kent Ridge Crescent Singapore 117576','',0,NULL,0,24,'0','',1,NULL,0,NULL),(970,'970','0000-00-00','Dr G Venkateswara Rao','No. 502, Reliance Mariam Villa','Street No. 6, Plot No. 70','West Marredpally ','',195,NULL,1,0,'500026','',1,NULL,0,NULL),(971,'971','0000-00-00','Prof. Sandeep Verma','Department of Chemistry','Indian Institute of Technology',' ','',107,NULL,28,0,'208016','',1,NULL,0,NULL),(972,'972','0000-00-00','Dr M Vidyasagar','SEG Professor of System Biol. Sci.','University of Texas at Dallas','800 W. Campbeell Road, EC32 Richardson, TX 75080-3021','',0,NULL,0,30,'0','',1,NULL,0,NULL),(973,'973','0000-00-00','Prof. K VijayRaghavan','Director','National Centre for Biological','Sciences GKVK Campus','',28,NULL,13,0,'560065','',1,NULL,0,NULL),(974,'974','0000-00-00','Dr K Vijayamohanan','Director','Central Electrochemical Research Inst.',' ','',109,NULL,26,0,'630006','',1,NULL,0,NULL),(975,'975','0000-00-00','Prof. M Vijayan','DAE Homi Bhabha Professor','Molecular Biophysics Unit','Indian Institute of Science ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(976,'976','0000-00-00','Prof. R Vijayaraghavan','Flat 305, Vigyanik Co-op. Housing','Society','Plot 58, Sector 14 Vashi','',154,NULL,17,0,'400703','',1,NULL,0,NULL),(977,'977','0000-00-00','Prof. Usha Vijayraghavan','MCB Department','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(978,'978','0000-00-00','Prof. P N Vinayachandran','Centre for Atmospheric & Oceanic','Sciences','Indian Institute of Science ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(979,'979','0000-00-00','Prof. C V Vishveshwara','No. 92, I Main','I Block','RMV II Stage ','',28,NULL,13,0,'560094','',1,NULL,0,NULL),(980,'980','0000-00-00','Prof. Saraswathi Vishveshwara','Molecular Biophysics Unit','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(981,'981','0000-00-00','Prof. N Viswanadham','Professor & Executive Director','Centre for GLAMS','Indian School of Business Gachibowli','',87,NULL,1,0,'500032','',1,NULL,0,NULL),(982,'982','0000-00-00','Prof. Sandhya S Visweswariah','MRDG Department','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(983,'983','0000-00-00','Dr Sudhanshu Vrati','Dean, Translational Health Science','and Technology Institute','496,  Udyog Vihar, Phase III ','',79,NULL,10,0,'122016','',1,NULL,0,NULL),(984,'984','0000-00-00','Dr Shashi Wadhwa','Department of Anatomy','All India Institute of Medical','Sciences Ansari Nagar','',156,NULL,6,0,'110029','',1,NULL,0,NULL),(985,'985','0000-00-00','Dr N H Wadia','Director of Research','Jaslok Hospital and Research Centre','15, G Deshmukh Marg ','',142,NULL,17,0,'400026','',1,NULL,0,NULL),(986,'986','0000-00-00','Prof. S R Wadia','Director','Int. Centre for Theoretical Sciences','Tata Inst. of Fundamental Research Homi Bhabha Road','',142,NULL,17,0,'400005','',1,NULL,0,NULL),(987,'987','0000-00-00','Dr Umesh V Waghmare','Theoretical Science Unit','Jawaharlal Nehru Centre for Adv.','Scientific Research Jakkur P.O.','',28,NULL,13,0,'560064','',1,NULL,0,NULL),(988,'988','0000-00-00','Prof. C S Warke','203, Vigyanshila','Juhu-Varsova Link Road','Andheri (West) ','',142,NULL,17,0,'400061','',1,NULL,0,NULL),(989,'989','0000-00-00','Dr Milind G Watve','Professor, Biology','Indian Inst. of Science Education','& Research, Sai Trinity Building Garware Circle, Pashan','',173,NULL,17,0,'411021','',1,NULL,0,NULL),(990,'990','0000-00-00','Dr J S Yadav','Director','Indian Institute of Chemical','Technology Uppal Road','',87,NULL,1,0,'500607','',1,NULL,0,NULL),(991,'991','0000-00-00','Dr Ram Ratan Yadav','Scientist F','Birbal Sahni Inst. of Palaeobotany','53, University Road ','',127,NULL,28,0,'226007','',1,NULL,0,NULL),(992,'992','0000-00-00','Prof. Veejendra K Yadav','Department of Chemistry','Indian Institute of Technology',' ','',107,NULL,28,0,'208016','',1,NULL,0,NULL),(993,'993','0000-00-00','Prof. K S Yajnik','Apartment F2, Regal Manor','2/1 Bride Street','Langford Town ','',28,NULL,13,0,'560025','',1,NULL,0,NULL),(994,'994','0000-00-00','Prof. S Yashonath','S.S.C.U.','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',1,NULL,0,NULL),(995,'995','0000-00-00','Prof. N Yathindra','Director','Insti. of Bioinformatics & Appl.','Biotechnology, Biotech Park Electronic City, Phse 1 (Behind 3M)','',28,NULL,13,0,'560100','',1,NULL,0,NULL),(996,'996','0000-00-00','Prof. B Yegnanarayana','International Institute of','Information Technology','Gachi Bowli ','',87,NULL,1,0,'500032','',1,NULL,0,NULL),(997,'997','0000-00-00','Dr Mukesh Jain','Staff Scientist','National Institute for Plant Genome','Research Aruna Asaf Ali Marg NIPGR, New Delhi','',156,NULL,0,0,'110067','',2,NULL,0,NULL),(998,'998','0000-00-00','Dr R Parthasarathi','Theoretical Biology & Biophysics','Los Alamos National Laboratory','T-6, MS K710 Los Alamos NM 87545','',0,NULL,0,30,'0','',2,NULL,0,NULL),(999,'999','0000-00-00','Dr S Venugopal','Dept. of Chemical Engineering','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',2,NULL,0,NULL),(1000,'1000','0000-00-00','Dr L Sunil Chandran','CSA Department','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',2,NULL,0,NULL),(1001,'1001','0000-00-00','Dr Santanu Mahapatra','CEDT','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',2,NULL,0,NULL),(1002,'1002','0000-00-00','Dr P Thilagar','IPC Department','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',2,NULL,0,NULL),(1003,'1003','0000-00-00','Dr Satish A Patil','SSCU','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',2,NULL,0,NULL),(1004,'1004','0000-00-00','Dr K Manjunath','Dept. of Mathematics','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',2,NULL,0,NULL),(1005,'1005','0000-00-00','Dr S Viswanath','The Institute of Mathematical','Sciences','CIT Campus, Taramani ','',50,NULL,26,0,'600113','',2,NULL,0,NULL),(1006,'1006','0000-00-00','Dr K Biswas','Dept. of Mathematics','RK Mission Vivekananda University','Belur Math ','',85,NULL,30,0,'711202','',2,NULL,0,NULL),(1007,'1007','0000-00-00','Dr Hum Chand','ARIES','Manora Peak',' ','',150,NULL,29,0,'263129','',2,NULL,0,NULL),(1008,'1008','0000-00-00','Dr Rahul Banerjee','','Physical & Materials Chemsitry Divn','Natinal Chemical Laboratory ','',173,NULL,17,0,'411008','',2,NULL,0,NULL),(1009,'1009','0000-00-00','Dr N D Pradeep Singh','Dept. of Chemistry','Indian Institute of Technology',' ','',112,NULL,30,0,'721302','',2,NULL,0,NULL),(1010,'1010','0000-00-00','Dr Suhrit Ghosh','Polymer Science Unit','Indian Assn. for the Cultivation of','Science Jadavpur','',116,NULL,30,0,'700032','',2,NULL,0,NULL),(1011,'1011','0000-00-00','Dr Samrat Mukhopadhyay','Asst. Prof. of Biology & Chemistry','Indian Inst. of Science Education','& Research Knowledge City, Sector 81','',193,NULL,22,0,'140306','',2,NULL,0,NULL),(1012,'1012','0000-00-00','Dr S Nagendran','Dept. of Chemistry','Indian Institute of Technology',' ','',156,NULL,6,0,'110016','',2,NULL,0,NULL),(1013,'1013','0000-00-00','Dr Sudip Malik','Polymer Science Unit','Indian Assn. for the Cultivation','of Science Jadavpur','',116,NULL,30,0,'700032','',2,NULL,0,NULL),(1014,'1014','0000-00-00','Dr Parag R Gogate','Chemical Engineering Department','Institute of Chemical Technology','Matunga ','',142,NULL,17,0,'400019','',2,NULL,0,NULL),(1015,'1015','0000-00-00','Dr Sumantra Mandal','Scientific Officer, MT Division','Indira Gandhi Centre for Atomic','Research ','',103,NULL,26,0,'603102','',2,NULL,0,NULL),(1016,'1016','0000-00-00','Dr Onkar Dabeer','School of Technology & Computer','Science','Tata Inst. of Fundamental Research Homi Bhabha Road','',142,NULL,17,0,'400005','',2,NULL,0,NULL),(1017,'1017','0000-00-00','Dr Manoj Saxena','Dept. of Electronics','Deen Dayal Upadhyaya College','Shivaji Marg Karampura','',156,NULL,6,0,'110015','',2,NULL,0,NULL),(1018,'1018','0000-00-00','Dr Debdas Roy','Metallurgical & Mater. Engg. Dept.','National Inst. of Foundry & Forge','Technology Hatia','',183,NULL,11,0,'834003','',2,NULL,0,NULL),(1019,'1019','0000-00-00','Dr Pradipta Maji','Machine Intelligence Unit','Indian Statistical Institute','203, BT Road ','',116,NULL,30,0,'700108','',2,NULL,0,NULL),(1020,'1020','0000-00-00','Dr Pawan Dewangan','Scientist IV','National Institute of Oceanography',' ','',64,NULL,7,0,'403004','',2,NULL,0,NULL),(1021,'1021','0000-00-00','Dr Neel Sarovar Bhavesh','SCB Group','International Centre for Genetic','Engineering & Biotechnology Aruna Asaf Ali Marg','',156,NULL,6,0,'110067','',2,NULL,0,NULL),(1022,'1022','0000-00-00','Dr Sudarshan Ananth','Indian Institute of Science','Education & Research','Central Tower, Sai Trinity Bldg. Gharware Circle, Sutarwadi, Pas','',173,NULL,17,0,'411008','',2,NULL,0,NULL),(1023,'1023','0000-00-00','Dr Sanjay Singh','Indian Institute of Science','Education & Research','Knowledge City, Sector 81 Manauli P.O.','',193,NULL,22,0,'140306','',2,NULL,0,NULL),(1024,'1024','0000-00-00','Dr Binoy K Saha','Dept. of Chemistry','Pondicherry University',' ','',172,NULL,23,0,'605014','',2,NULL,0,NULL),(1025,'1025','0000-00-00','Dr Santosh Chauhan','Department of Cancer Biology','MD Anderson Cancer Center','University of Texas 1515, Holcombe Blvd.Houston, TX 77030','',0,NULL,0,30,'0','',2,NULL,0,NULL),(1026,'1026','0000-00-00','Dr Sanoli Gun','The Institute of Mathematical','Sciences','CIT Campus, Taramani ','',50,NULL,26,0,'600113','',2,NULL,0,NULL),(1027,'1027','0000-00-00','Dr Tanvi Jain','Dept. of Mathematics','University of Delhi',' ','',58,NULL,6,0,'110007','',2,NULL,0,NULL),(1028,'1028','0000-00-00','Dr S Shankaranarayanan','Indian Inst. of Science Education','& Research','CET Campus ','',217,NULL,14,0,'695016','',2,NULL,0,NULL),(1029,'1029','0000-00-00','Dr Rajesh Ganapathy','International Centre for Materials','Science','JNCASR Jakkur P.O.','',28,NULL,13,0,'560064','',2,NULL,0,NULL),(1030,'1030','0000-00-00','Dr Subroto Mukerjee','Dept. of Physics','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',2,NULL,0,NULL),(1031,'1031','0000-00-00','Prof. Abhishek Dey','Dept. of Inorganic Chemistry','Indian Association for the','Cultivation of Science Jadavpur','',116,NULL,30,0,'700032','',2,NULL,0,NULL),(1032,'1032','0000-00-00','Dr Ayan Datta','School of Chemistry','Indian Inst. of Science Education','& Research CET Campus','',217,NULL,14,0,'695016','',2,NULL,0,NULL),(1033,'1033','0000-00-00','Dr Samik Nanda','Dept. of Chemistry','Indian Institute of Technology',' ','',112,NULL,30,0,'721302','',2,NULL,0,NULL),(1034,'1034','0000-00-00','Dr Nitin T Patil','Organic Chemistry Divn. - II','Indian Institute of Chemical','Technology Uppal Road','',87,NULL,1,0,'500607','',2,NULL,0,NULL),(1035,'1035','0000-00-00','Dr Ranjan Datta','Int. Centre for Materials Science','JNCASR','Jakkur P.O. ','',28,NULL,13,0,'560064','',2,NULL,0,NULL),(1036,'1036','0000-00-00','Dr Santosh Ansumali','Engineering Mechanics Unit','JNCASR','Jakkur P.O. ','',28,NULL,13,0,'560064','',2,NULL,0,NULL),(1037,'1037','0000-00-00','Dr Vijay Natarajan','CSA Department','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',2,NULL,0,NULL),(1038,'1038','0000-00-00','Dr V S Nair','Space Physics Laboratory','Vikram Sarabhai Space Centre',' ','',217,NULL,14,0,'695022','',2,NULL,0,NULL),(1039,'1039','0000-00-00','Dr Arun P Sripati','Centre for Neuroscience','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',2,NULL,0,NULL),(1040,'1040','0000-00-00','Dr Partho Sarothi Ray','Indian Institute of Science Edn.','& Research','Haringhata Mohanpur Post','',146,NULL,30,0,'741246','',2,NULL,0,NULL),(1041,'1041','0000-00-00','Dr Gitanjali Yadav','Computational Biology Lab.','National Institute of Plant Genome','Research Arun Asaf Ali Marg','',156,NULL,6,0,'110067','',2,NULL,0,NULL),(1042,'1042','0000-00-00','Dr Suvendra Nath Bhattacharyya','Molecular & Human Genetics Division','Indian Inst. of Chemical Biology','4, Raja SC Mullick Road ','',116,NULL,30,0,'700032','',2,NULL,0,NULL),(1043,'1043','0000-00-00','Dr U Deva Priyakumar','CCNSB','Int. Inst. of Information','Technology Gachibowli','',87,NULL,1,0,'500032','',2,NULL,0,NULL),(1044,'1044','0000-00-00','Dr Zhumur Ghosh','COE in Bioinformatics','Bose Institute','P-1/12, CIT, Scheme VIIM ','',116,NULL,30,0,'700054','',2,NULL,0,NULL),(1045,'1045','0000-00-00','Dr Thomas J Pucadyil','IISER','6th Floor, I Tower','Sai Trinity Building Garware Circile, Pashan','',173,NULL,17,0,'411021','',2,NULL,0,NULL),(1046,'1046','0000-00-00','Dr Smitha V Thampi','SAS Division','Physical Research Laboratory','Navrangpura ','',2,NULL,8,0,'380009','',2,NULL,0,NULL),(1047,'1047','0000-00-00','Dr C Vineeth','Space Physics Laboratory','Vikram Sarabhai Space Centre',' ','',217,NULL,14,0,'695022','',2,NULL,0,NULL),(1048,'1048','0000-00-00','Dr Supriyo Mitra','Dept. of Earth Science','IISER','BCKV Mohanpur','',146,NULL,30,0,'741252','',2,NULL,0,NULL),(1049,'1049','0000-00-00','Dr Dipankar Saha','Dept. of Electrical Engineering','Indian Institute of Technology','Powai ','',142,NULL,17,0,'400076','',2,NULL,0,NULL),(1050,'1050','0000-00-00','Dr Amol A Kulkarni','Chemical Engineering Division','National Chemical Laboratory',' ','',173,NULL,17,0,'411008','',2,NULL,0,NULL),(1051,'1051','0000-00-00','Dr Debdeep Mukhopadhyay','Dept. of Computer Science & Engg.','Indian Institute of Technology',' ','',112,NULL,30,0,'721302','',2,NULL,0,NULL),(1052,'1052','0000-00-00','Dr Prahladh Harsha','School of Technology & Computer Sci','Tata Inst. of Fundamental Research','Homi Bhabha Road ','',142,NULL,17,0,'400005','',2,NULL,0,NULL),(1053,'1053','0000-00-00','Dr P Ramu Sridhar','School of Chemistry','University of Hyderabad',' ','',87,NULL,1,0,'500046','',2,NULL,0,NULL),(1054,'1054','0000-00-00','Dr D H Dethe','Dept. of Chemistry','Indian Institute of Technology',' ','',107,NULL,28,0,'208016','',2,NULL,0,NULL),(1055,'1055','0000-00-00','Dr Subi J George','Supramolecular Chemistry Lab.','JN Centre for Advanced Scientific','Research Jakkur','',28,NULL,13,0,'560064','',2,NULL,0,NULL),(1056,'1056','0000-00-00','Dr T Govindaraju','Bio-Organic Chemistry Lab.','JN Centre for Advanced Scientific','Research Jakkur','',28,NULL,13,0,'560064','',2,NULL,0,NULL),(1057,'1057','0000-00-00','Dr Ritesh K Singh','IISER','BCKV Campus',' Mohanpur','',146,NULL,30,0,'741252','',2,NULL,0,NULL),(1058,'1058','0000-00-00','Dr V K Chandrasekar','CNLD, School of Physics','Bharathidasan University',' ','',219,NULL,26,0,'620024','',2,NULL,0,NULL),(1059,'1059','0000-00-00','Dr G V Pavan Kumar','Divn. of Physics & Chemistry','IISER','Medleev Block Pashan','',173,NULL,17,0,'411008','',2,NULL,0,NULL),(1060,'1060','0000-00-00','Dr Thirupathi Gudi','Dept. of Mathematics','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',2,NULL,0,NULL),(1061,'1061','0000-00-00','Dr Anand K Bachhawat','Scientist','Institute of Microbial Technology','Sector 39A ','',48,NULL,31,0,'160036','',3,NULL,0,NULL),(1062,'1062','0000-00-00','Prof. Sudha Bhattacharya','School of Environmental Sciences','Jawaharlal Nehru University',' ','',156,NULL,6,0,'110067','',3,NULL,0,NULL),(1063,'1063','0000-00-00','Prof. K B Athreya','Professor','Departments of Mathematics &','Statistics Iowa State UniversityAmes, Iowa 50011','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1064,'1064','0000-00-00','Prof. G S Bhat','Centre for Atmospheric & Oceanic','Sciences','Indian Institute of Science ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1065,'1065','0000-00-00','Dr B V Rajarama Bhat','Indian Statistical Institute','RV College P.O.',' ','',28,NULL,13,0,'560059','',3,NULL,0,NULL),(1066,'1066','0000-00-00','Prof. V S Borkar','Dept. of Electrical Engineering','Indian Institute of Technology','Powai ','',142,NULL,17,0,'400076','',3,NULL,0,NULL),(1067,'1067','0000-00-00','Prof. S Chandrasekaran','Chairman','Division of Chemical Sciences, and','Department of Organic Chemistry Indian Institute of Science','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1068,'1068','0000-00-00','Prof. S R Gadre','Department of Chemistry','University of Pune',' ','',173,NULL,17,0,'411007','',3,NULL,0,NULL),(1069,'1069','0000-00-00','Prof. Subhash Chaturvedi','School of Physics','University of Hyderabad',' ','',87,NULL,1,0,'500046','',3,NULL,0,NULL),(1070,'1070','0000-00-00','Prof. Rajiv V Gavai','Theoretical Physics Department','Tata Institute of Fundamental Resea','Homi Bhabha Road ','',142,NULL,17,0,'400005','',3,NULL,0,NULL),(1071,'1071','0000-00-00','Prof. H Sharat Chandra','Centre for Human Genetics','Biotech Park, Phase I','Electronic City  Bangalore 560 100','',0,NULL,13,0,'560012','',3,NULL,0,NULL),(1072,'1072','0000-00-00','Dr Amitabha Chattopadhyay','Group Leader','Centre for Cellular and Molecular','Biology Uppal Road','',87,NULL,1,0,'500007','',3,NULL,0,NULL),(1073,'1073','0000-00-00','Prof. J Srinivasan','Chairman','Centre for Atmospheric and','Oceanic Sciences Indian Institute of Science','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1074,'1074','0000-00-00','Prof. S G Dani','School of Mathematics','Tata Institute of Fundamental','Research Homi Bhabha Road','',142,NULL,17,0,'400005','',3,NULL,0,NULL),(1075,'1075','0000-00-00','Prof. Rohini M Godbole','Centre for High Energy Physics','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1076,'1076','0000-00-00','Dr S E Hasnain','Vice Chancellor','University of Hyderabad',' ','',87,NULL,1,0,'500046','',3,NULL,0,NULL),(1077,'1077','0000-00-00','Prof. V K Gaur','Distinguished Professor','Indian Institute of Astrophysics','Sarjapur Road ','',28,NULL,13,0,'560034','',3,NULL,0,NULL),(1078,'1078','0000-00-00','Dr Anil Kakodkar','DAE Homi Bhabha Chair Professor','Bhabha Atomic Research Centre','7th Floor, Central Complex Trombay','',142,NULL,17,0,'400085','',3,NULL,0,NULL),(1079,'1079','0000-00-00','Prof. T N Guru Row','S.S.C.U.','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1080,'1080','0000-00-00','Dr P S Goel','Chairman','Recruitment & Assessment Centre','DRDO Lucknow Road, Timarpur New Delhi 110 054','',0,NULL,6,0,'110003','',3,NULL,0,NULL),(1081,'1081','0000-00-00','Dr K Gopalan','INSA Senior Scientist','National Geophysical Research','Institute Uppal Road','',87,NULL,1,0,'500606','',3,NULL,0,NULL),(1082,'1082','0000-00-00','Dr J Gowrishankar','Director','Centre for DNA Fingerprinting and','Diagnostics, 4-87/1, ECIL Road 5-4-399/B, Nampalli','',87,NULL,1,0,'500001','',3,NULL,0,NULL),(1083,'1083','0000-00-00','Prof. A M Jayannavar','Director','Institute of Physics','Sachivalaya Marg ','',38,NULL,21,0,'751005','',3,NULL,0,NULL),(1084,'1084','0000-00-00','Dr S Jameel','Virology Group','International Centre for Genetic','Engineering & Biotechnology NII Campus, Aruna Asaf Ali Marg','',156,NULL,6,0,'110067','',3,NULL,0,NULL),(1085,'1085','0000-00-00','Prof. R Jayaraman','R. H. 35','Palaami Enclave','Reserve Line New Natham Road','',129,NULL,26,0,'625014','',3,NULL,0,NULL),(1086,'1086','0000-00-00','Dr Amitabh Joshi','Evolutionary & Organismal Biology','Unit, Jawaharlal Nehru Centre for','Advanced Scientific Research Jakkur P.O.','',28,NULL,13,0,'560064','',3,NULL,0,NULL),(1087,'1087','0000-00-00','Prof. Jitendra P Khurana','Dept. of Plant Molecular Biology','University of Delhi South Campus','Benito Juarez Road ','',156,NULL,6,0,'110021','',3,NULL,0,NULL),(1088,'1088','0000-00-00','Prof. M M Johri','Flat No. 32, New Cosmos','Juhu-Versova Link Road','Andheri (W) ','',142,NULL,17,0,'400053','',3,NULL,0,NULL),(1089,'1089','0000-00-00','Dr D P Kasbekar','Scientist','Centre for Cellular & Molecular','Biology Uppal Road','',87,NULL,1,0,'500007','',3,NULL,0,NULL),(1090,'1090','0000-00-00','Prof. Uday Maitra','Department of Organic Chemistry','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1091,'1091','0000-00-00','Prof. S C Lakhotia','Department of Zoology','Banaras Hindu University',' ','',231,NULL,28,0,'221005','',3,NULL,0,NULL),(1092,'1092','0000-00-00','Dr K Krishnamoorthy','','','Roshni, TC 25/927 No. 202, ETRA, East Thampanoor','',217,NULL,14,0,'695014','',3,NULL,0,NULL),(1093,'1093','0000-00-00','Dr Anuradha Lohia','CEO','Wellcome Trust-DBT India Alliance','8-2-684/3/K/19, Road No. 12 Banjara Hills','',87,NULL,1,0,'500034','',3,NULL,0,NULL),(1094,'1094','0000-00-00','Dr G S Khush','39399, Blackhawk Place','',' Davis, CA 95616-7008','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1095,'1095','0000-00-00','Prof. S S Krishnamurthy','Honorary Professor','IPC Department','Indian Institute of Science ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1096,'1096','0000-00-00','Prof. V Krishnan','Hindustan Lever Research Professor','Jawaharlal Nehru Centre for','Advanced Scientific Research Jakkur P.O.','',28,NULL,13,0,'560064','',3,NULL,0,NULL),(1097,'1097','0000-00-00','Prof. S Krishnaswami','Physical Research Laboratory','Navrangpura',' ','',2,NULL,8,0,'380009','',3,NULL,0,NULL),(1098,'1098','0000-00-00','Prof. D Lal','Scripps Institution of Oceanography','Geosciences Research Divn., 0244',' La Jolla, CA 92093-0244','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1099,'1099','0000-00-00','Prof. Partha P Majumder','Director','NIBG','II Floor, NS Sanitorium ','',105,NULL,30,0,'741251','',3,NULL,0,NULL),(1100,'1100','0000-00-00','Prof. Indraneel Mittra','Professor Emeritus','Dept. of Surgical Oncology','ACTREC Dr Ernest Borges Road','',142,NULL,17,0,'400012','',3,NULL,0,NULL),(1101,'1101','0000-00-00','Dr M Dileep Kumar','Chemical Oceanography Division','National Institute of Oceanography',' ','',64,NULL,7,0,'403004','',3,NULL,0,NULL),(1102,'1102','0000-00-00','Prof. N Mukunda','Centre for High Energy Physics','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1103,'1103','0000-00-00','Prof. T R Ramadas','Mathematics Group','Abdus Salam International Centre fo','Theoretical Physics Strada Costiera 1134100 Trieste','',0,NULL,0,14,'0','',3,NULL,0,NULL),(1104,'1104','0000-00-00','Prof. R Ramesh','Physical Research Laboratory','Navrangpura',' ','',2,NULL,8,0,'380009','',3,NULL,0,NULL),(1105,'1105','0000-00-00','Prof. R Nityananda','Centre Director','National Centre for Radio','Astrophysics Ganeshkhind','',173,NULL,17,0,'411007','',3,NULL,0,NULL),(1106,'1106','0000-00-00','Prof. K H Paranjape','Visiting Faculty','Indian Inst. of Science Education','& Research, Transit Campus MGSIPA Complex, Sector 26','',48,NULL,31,0,'160019','',3,NULL,0,NULL),(1107,'1107','0000-00-00','Prof. R Ramaswamy','School of Physical Sciences','Jawaharlal Nehru University',' ','',156,NULL,6,0,'110067','',3,NULL,0,NULL),(1108,'1108','0000-00-00','Prof. Dipendra Prasad','School of Mathematics','Tata Institute of Fundamental','Research Homi Bhabha Road','',142,NULL,17,0,'400005','',3,NULL,0,NULL),(1109,'1109','0000-00-00','Prof. Phoolan Prasad','Department of Mathematics','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1110,'1110','0000-00-00','Prof. M S Raghunathan','Professor of Eminence','School of Mathematics','Tata Inst. of Fundamental Research Homi Bhabha Road','',142,NULL,17,0,'400005','',3,NULL,0,NULL),(1111,'1111','0000-00-00','Prof. V Rajaraman','Honorary Professor','Supercomputer Education and','Research Centre Indian Institute of Science','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1112,'1112','0000-00-00','Prof. C N R Rao','Linus Pauling Research Professor','Jawaharlal Nehru Centre for','Advanced Scientific Research Indian Institute of Science Campus','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1113,'1113','0000-00-00','Prof. K J Rao','Honorary Professor','S.S.C.U.','Indian Institute of Science ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1114,'1114','0000-00-00','Prof. Gadadhar Misra','Department of Mathematics','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1115,'1115','0000-00-00','Dr Abhijit Sen','Institute for Plasma Research','Bhat',' ','',72,NULL,8,0,'382428','',3,NULL,0,NULL),(1116,'1116','0000-00-00','Prof. S B Krupanidhi','Materials Research Centre','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1117,'1117','0000-00-00','Prof. C S Seshadri','Director','Chennai Mathematical Institute','H1, Sipcot IT Park Padur Post, Siruseri','',50,NULL,26,0,'603103','',3,NULL,0,NULL),(1118,'1118','0000-00-00','Prof. R K Saxena','School of Life Sciences','Jawaharlal Nehru University',' ','',156,NULL,6,0,'110067','',3,NULL,0,NULL),(1119,'1119','0000-00-00','Prof. L S Shashidhara','Co-ordinator, Biology','Indian Institute of Science Educati','and Research, 900, NCL Innovation Park,Dr Homi Bhaba Road','',173,NULL,17,0,'411008','',3,NULL,0,NULL),(1120,'1120','0000-00-00','Prof. R K Shyamasundar','Dean, Tech. & Computer Sci. Faculty','Tata Institute of Fundamental','Research Homi Bhabha Road','',142,NULL,17,0,'400005','',3,NULL,0,NULL),(1121,'1121','0000-00-00','Prof. S R Shenoy','School of Physics','University of Hyderabad',' ','',87,NULL,1,0,'500046','',3,NULL,0,NULL),(1122,'1122','0000-00-00','Dr Imran Siddiqi','Centre for Cellular','& Molecular Biology',' ','',87,NULL,1,0,'500007','',3,NULL,0,NULL),(1123,'1123','0000-00-00','Dr R N Singh','Director-grade-Scientist','National Geophysical Research','Institute Uppal Road','',87,NULL,1,0,'500007','',3,NULL,0,NULL),(1124,'1124','0000-00-00','Dr S R Shetye','Director','National Institute of Oceanography',' ','',64,NULL,7,0,'403004','',3,NULL,0,NULL),(1125,'1125','0000-00-00','Prof. O Siddiqi','Emeritus Professor','National Centre for Biological Sci.','GKVK Campus ','',28,NULL,13,0,'560065','',3,NULL,0,NULL),(1126,'1126','0000-00-00','Prof. K L Sebastian','IPC Department','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1127,'1127','0000-00-00','Prof. A Sitaram','Professor Emeritus','Dept. of Mathematics','Indian Institute of Science ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1128,'1128','0000-00-00','Prof. K B Sinha','Honorary Professor','Jawaharlal Nehru Centre for Advance','Scientific Research Jakkur','',28,NULL,13,0,'560064','',3,NULL,0,NULL),(1129,'1129','0000-00-00','Dr V Kumaran','Department of Chemical Engineering','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1130,'1130','0000-00-00','Prof. Ramaiyengar Sridharan','Chennai Mathematical Institute','H1, Sipcot IT Park','Padur Post Siruseri','',50,NULL,26,0,'603103','',3,NULL,0,NULL),(1131,'1131','0000-00-00','Prof. S S Abhyankar','Department of Mathematics','Purdue University',' West Lafayette, Indiana 47907','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1132,'1132','0000-00-00','Dr G Sundararajan','Director','IARC for Powder Metallurgy &','New Materials(ARCI) Balapur P.O.','',87,NULL,1,0,'500005','',3,NULL,0,NULL),(1133,'1133','0000-00-00','Prof. V S Sunder','The Institute of Mathematical','Sciences','CIT Campus, Taramani ','',50,NULL,26,0,'600113','',3,NULL,0,NULL),(1134,'1134','0000-00-00','Prof.  Sushil Kumar','INSA Senior Scientist','National Institute for Plant Genome','Research JNU Campus','',156,NULL,6,0,'110067','',3,NULL,0,NULL),(1135,'1135','0000-00-00','Dr G Prathap','Director','NISCAIR','Dr K.S. Krishnan Road Pusa','',156,NULL,6,0,'110012','',3,NULL,0,NULL),(1136,'1136','0000-00-00','Dr K Vijayamohanan','Physical & Materials','Chemistry Division','National Chemical Laboratory ','',173,NULL,17,0,'411008','',3,NULL,0,NULL),(1137,'1137','0000-00-00','Prof. K VijayRaghavan','Director','National Centre for Biological','Sciences TIFR, GKVK Campus','',28,NULL,13,0,'560065','',3,NULL,0,NULL),(1138,'1138','0000-00-00','Prof. Dipankar Bhattacharya','Inter-University Centre for','Astronomy & Astrophysics',' Ganeshkhind','',173,NULL,17,0,'411007','',3,NULL,0,NULL),(1139,'1139','0000-00-00','Prof. Bhaskar Bagchi','Statistics & Mathematics Division','Indian Statistical Institute','R.V. College P.O. ','',28,NULL,13,0,'560059','',3,NULL,0,NULL),(1140,'1140','0000-00-00','Prof. N Srinivasan','Molecular Biophysics Unit','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1141,'1141','0000-00-00','Prof. H L Bhat','Department of Physics','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1142,'1142','0000-00-00','Prof. Giridhar U Kulkarni','Chemistry & Physics of Mater. Unit','Jawaharlal Nehru Centre for Advance','Scientific Research ','',28,NULL,13,0,'560064','',3,NULL,0,NULL),(1143,'1143','0000-00-00','Dr A K Shukla','SSCU','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1144,'1144','0000-00-00','Prof. K B R Varma','Materials Research Centre','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1145,'1145','0000-00-00','\\Prof Roger Bilham','Co-operative Institute for Research','in Environmental Sciences (CIRES)','University of Colorado Boulder Colorado 80309-0216','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1146,'1146','0000-00-00','Prof. T N Krishnamurti','Florida State University','',' Tallahassee, FJ 32306','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1147,'1147','0000-00-00','Prof. T N Narasimhan','Department of Material Sciences','and Mineral Engineering','467 Evans Hall University of CaliforniaBerkeley, CA 94720 - 1760','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1148,'1148','0000-00-00','Dr R R Navalgund','Director','Space Applications Centre','  Gujrat','',2,NULL,0,0,'380015','',3,NULL,0,NULL),(1149,'1149','0000-00-00','Dr M Rajeevan','National Climate Centre','Office of ADGM (Research)','India Meteorological Department  Pune - 411 005','',0,NULL,17,0,'411005','',3,NULL,0,NULL),(1150,'1150','0000-00-00','Prof. V Smetacek','Alfred Wegener Institute','Am Handelshafen 12',' 27570 Bremerhaven','',0,NULL,0,11,'0','',3,NULL,0,NULL),(1151,'1151','0000-00-00','Prof. J Philippe Duvel','Laboratoire de Meteorologie','Dynamique','ENS - 24, Rue Lhomond 75231 - Paris Cedex 05','',0,NULL,0,10,'0','',3,NULL,0,NULL),(1152,'1152','0000-00-00','Dr Anne Mueller','Marine Geology & Palaeoclimatology','Isotope Laboratory','Department of Earth Sciences The University of QueenslandBrisban','',0,NULL,0,1,'0','',3,NULL,0,NULL),(1153,'1153','0000-00-00','Prof. V Ramaswamy','NOAA/Geophysical Fluid Dynamics','Laboratory','Princeton University P. O. Box 308Princeton, New Jersey 08542','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1154,'1154','0000-00-00','Dr John J Mahoney','Department of Geology','and Geophysics','SOEST, University of Hawaii 1680 East-West RoadHonolulu, HI 9682','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1155,'1155','0000-00-00','Dr D Shankar','National Institute of Oceanography','','  Goa 403 004','',0,NULL,7,0,'403004','',3,NULL,0,NULL),(1156,'1156','0000-00-00','Prof. N K Dadhich','Inter-University Centre for','Astronomy & Astrophysics','Ganeshkhind ','',173,NULL,17,0,'411007','',3,NULL,0,NULL),(1157,'1157','0000-00-00','Dr Amit Roy','Director','Inter-University Accelerator Centre','Aruna Asaf Ali Marg ','',156,NULL,6,0,'110067','',3,NULL,0,NULL),(1158,'1158','0000-00-00','Prof. K S Narayan','','Jawaharlal Nehru Centre for Advance','Scientific Research Jakkur P.O.','',28,NULL,13,0,'560064','',3,NULL,0,NULL),(1159,'1159','0000-00-00','Prof. N V Madhusudana','Liquid Crystals Laboratory','Raman Research Institute',' ','',28,NULL,13,0,'560080','',3,NULL,0,NULL),(1160,'1160','0000-00-00','Dr R Kidambi','CTFD Division','National Aerospace Laboratories','Airport Road ','',28,NULL,13,0,'560017','',3,NULL,0,NULL),(1161,'1161','0000-00-00','Prof. B V Rao','Chennai Mathematical Institute','H1, Sipcot IT Park','Padur Post, Siruseri ','',50,NULL,26,0,'603103','',3,NULL,0,NULL),(1162,'1162','0000-00-00','Prof. V S Varadarajan','Department of Mathematics','University of California',' Los Angeles, CA 90024','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1163,'1163','0000-00-00','Prof. S R S Varadhan','Department of Mathematics','Courant Institute','New York University 251, Mercer StreetNew York, NY 110 012','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1164,'1164','0000-00-00','Prof. E Arunan','IPC Department','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1165,'1165','0000-00-00','Prof. H Suryaprakash Rao','Department of Chemistry','Pondicherry University',' ','',172,NULL,23,0,'605014','',3,NULL,0,NULL),(1166,'1166','0000-00-00','Prof. T P Radhakrishnan','School of Chemistry','University of Hyderabad',' ','',87,NULL,1,0,'500046','',3,NULL,0,NULL),(1167,'1167','0000-00-00','Prof. J H Arakeri','Dept. of Mechanical Engineering','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1168,'1168','0000-00-00','Prof. Biman B Nath','Raman Research Institute','',' ','',28,NULL,13,0,'560080','',3,NULL,0,NULL),(1169,'1169','0000-00-00','Dr Utpal Nath','MCB Department','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1170,'1170','0000-00-00','Prof. Vasant Natarajan','Department of Physics','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1171,'1171','0000-00-00','Prof. C R Pranesachar','Department of Mathematics','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1172,'1172','0000-00-00','Dr Shailesh A Shirali','Sahyadri School (KFI)','Tiwai Hill, Rajaguru Nagar','  Pune 410 513','',0,NULL,17,0,'410413','',3,NULL,0,NULL),(1173,'1173','0000-00-00','Prof. G Nagendrappa','No. 13, Basappa Layout','Gavipuram',' ','',28,NULL,13,0,'560019','',3,NULL,0,NULL),(1174,'1174','0000-00-00','Prof. Y K Lin','Charles E. Schmidt Eminent','Scholar Chair in Engineering','777 Glades Road P.O. Box 3091Boca Raton, FL 33431-0991','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1175,'1175','0000-00-00','Prof. C V R Murthy','Department of Civil Engineering','Indian Institute of Technology',' ','',50,NULL,26,0,'600036','',3,NULL,0,NULL),(1176,'1176','0000-00-00','Prof. N K Gupta','Dept. of Applied Mechanics','Indian Institute of Technology',' ','',156,NULL,6,0,'110016','',3,NULL,0,NULL),(1177,'1177','0000-00-00','Prof. Rao Y Surampalli','US Environmental Protection Agency','PO Box 14354','Lenexa Kansas City, KS 66285','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1178,'1178','0000-00-00','Prof. S Nagarajaiah','213, Ryon Engineering Building','CEVE Dept, MEMS Dept.','MS 318 Rice University 6100 Main StreetHouston, TX 77005','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1179,'1179','0000-00-00','Dr B Bhattacharjee','National Disaster Management','Authority','Centaur Hotel Near IGI Airport','',156,NULL,6,0,'110037','',3,NULL,0,NULL),(1180,'1180','0000-00-00','Prof. Ashok Misra','68, Adarsh Vista','Basavanagar','Vibhuthipura ','',28,NULL,13,0,'560037','',3,NULL,0,NULL),(1181,'1181','0000-00-00','Prof. G K Ananthasuresh','Dept. of Mechanical Engineering','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1182,'1182','0000-00-00','Prof. K Sankara Rao','Distinguished Fellow','Centre for Ecological Sciences','Indian Institute of Science ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1183,'1183','0000-00-00','Dr Sadanand Nanjundiah','Department of Physics','Central Connecticut State Universit',' New Britain, CT 06050','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1184,'1184','0000-00-00','Dr Bikram Phookun','Department of Physics','St. Stephen\'s College','University Enclave ','',58,NULL,6,0,'110007','',3,NULL,0,NULL),(1185,'1185','0000-00-00','Dr Ashima Anand','DST Centre for Viseral Mechanisms','VP Chest Institute','University of Delhi ','',58,NULL,6,0,'110007','',3,NULL,0,NULL),(1186,'1186','0000-00-00','Prof. Rustom Antia','Department of Biology','O.Wayne Rollins Res. Centre','Emory University 1510 Cliffon Road NEAtlanta, GA 30322','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1187,'1187','0000-00-00','Dr Renee M Borges','Centre for Ecological Sciences','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1188,'1188','0000-00-00','Prof. Maria Luz Cardenas','Bioenergetique et Ingeniere','des Proteines','IBSM, CNRS 31, Chemin Joseph-Aiguier13402 Marseille Cedex 20','',0,NULL,0,10,'0','',3,NULL,0,NULL),(1189,'1189','0000-00-00','Dr R Geeta','Department of Botany','University of Delhi',' ','',58,NULL,6,0,'110007','',3,NULL,0,NULL),(1190,'1190','0000-00-00','Prof. Scott F Gilbert','Department of Biology','Swarthmore College','500, College Avenue Swarthmore, PA 19081-1397','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1191,'1191','0000-00-00','Prof. Albert Goldbeter','Faculte des Sciences','Universite Libre de Bruxelles','Campus Plaine, C.P. 231 Boulevard du TriompheD-1050, Brussels','',0,NULL,0,2,'0','',3,NULL,0,NULL),(1192,'1192','0000-00-00','Prof. Rasika M Harshey','Dept. of Molecular Genetics and','Microbiology','University of Texas at Austin Austin, TX 78712','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1193,'1193','0000-00-00','Prof. Dominique G Homberger','Dept. of Biological Sciences','Louisiana State University','202, Life Sciences Building Barton Rouge, LA 70803-1715','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1194,'1194','0000-00-00','Dr Neeraj Jain','National Brain Research Centre','Nainwal Mode','SCO 5, Sector 15 Manesar','',79,NULL,10,0,'122050','',3,NULL,0,NULL),(1195,'1195','0000-00-00','Prof. Shahid Khan','Depts, of Bioengineering/Microbiol.','& Immunology','University of Illinois III Chicago Technology ParkChicago, IL 60','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1196,'1196','0000-00-00','Prof. Maria Eliana Lanio','Centro de Estudios de Proteinas','Facultad de Biologia','Cuba Cuba','',0,NULL,0,0,'0','',3,NULL,0,NULL),(1197,'1197','0000-00-00','Dr Renu Khanna-Chopra','Water Technology Centre','Indian Agricultural Res. Institute',' ','',156,NULL,6,0,'110012','',3,NULL,0,NULL),(1198,'1198','0000-00-00','Dr Rita Mulherkar','ACTREC','Tata Mmeorial Centre','Kharghar ','',154,NULL,17,0,'410208','',3,NULL,0,NULL),(1199,'1199','0000-00-00','Prof. Stuart A Newman','Dept. of Cell Biology & Anatomy','Basic Science Building','New York Medical College Valhalla, NY 10595','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1200,'1200','0000-00-00','Prof. Raphael Pinaud','Dept. of Brain & Cognitive Sciences','University of Rochster','117, Melioa Hall - River Campus Rochster, NY 14627','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1201,'1201','0000-00-00','Prof. Prim B Singh','Divison of Molecular Immunology','Research Centre Borstel','Parkallee 22 D-23845 Borstel','',0,NULL,0,11,'0','',3,NULL,0,NULL),(1202,'1202','0000-00-00','Dr Vidita A Vaidya','Dept. of Biological Sciences','Tata Institute of Fundamental Resea','Homi Bhabha Road ','',142,NULL,17,0,'400005','',3,NULL,0,NULL),(1203,'1203','0000-00-00','Prof. A Veitia Reiner','INSERM U709 Genomique et','Epigenetique des','Pathologies Placentaires Hopital Cochin,123 Bd de Port Royal7501','',0,NULL,0,10,'0','',3,NULL,0,NULL),(1204,'1204','0000-00-00','Prof. Rasoul Sorkhabi','','Energy & Geoscience Institute','University of Utah 423 Wakara Way, Suite 300Salt Lake City, Utah','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1205,'1205','0000-00-00','Prof. Toshiro Saino','Hydrospheric Atmospheric Res.Centre','Nagoya University','Furo-Cho Chikusa-ku Nagoya 464 8601','',0,NULL,0,15,'0','',3,NULL,0,NULL),(1206,'1206','0000-00-00','Dr Kunal Ray','Molecular & Human Genetics Division','','Indian Insti. of Chemical Biology 4 Raja S C Mullick Road','',116,NULL,30,0,'700032','',3,NULL,0,NULL),(1207,'1207','0000-00-00','Prof. Daniel Hartl','Dept. of Organismal & Evolutionary','Biology','Harvard Univesity Cambridge, MA 02138 USA','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1208,'1208','0000-00-00','Prof. Luca L Cavalli-Sforza','Department of Genetics','Stanford University','US US','',0,NULL,0,0,'0','',3,NULL,0,NULL),(1209,'1209','0000-00-00','Prof. Robin Holliday','12, Roma Court','West Pennant Hills',' Sydney, NSW 2125','',0,NULL,0,1,'0','',3,NULL,0,NULL),(1210,'1210','0000-00-00','Prof. Mary F Lyon','MRC Mammelian Gnetics Unit','Harwell',' DidcotOxon OX11 0RD','',0,NULL,0,29,'0','',3,NULL,0,NULL),(1211,'1211','0000-00-00','Prof. Nicholas A Mitchinson','','Institute of Opthalmology UCL',' 11-43 Bath StLondon EC1V 9EL','',0,NULL,0,29,'0','',3,NULL,0,NULL),(1212,'1212','0000-00-00','Prof. Newton E Morton','Hon. Professor, School of Medicine','University of Southampton','Biomedical Sciences Building Bassett Crescent EastSouthamption H','',0,NULL,0,29,'0','',3,NULL,0,NULL),(1213,'1213','0000-00-00','Prof. Tomoko Ohta','National Institute of Genetics','','1 111 Yata Shizuoka-Ken 411Mishima City','',0,NULL,0,15,'0','',3,NULL,0,NULL),(1214,'1214','0000-00-00','Prof. Utpal Banerjee','Co-Director','Broadstem Cell Center','356, Boyer Hall University of CaliforniaLos Angeles, CA 90095','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1215,'1215','0000-00-00','Prof. Walter Bodmer','Cancer & Immunogeetics Laboratory','Weatherall Inst. of Molecular','Medicine, John Radcliffee Hospital Oxford, OX3 9DS','',0,NULL,0,29,'0','',3,NULL,0,NULL),(1216,'1216','0000-00-00','Prof. Ranajit Chakraborty','Director','Center for Computational Genomics','Univ. of North Texas HSC, 3500 Camp Bowie Blvd.Fort Worth, TX 76','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1217,'1217','0000-00-00','Prof. Adam K Chippindale','Department of Biology','Queen\'s University','Kingston Ontario K7L 3N6','',0,NULL,0,4,'0','',3,NULL,0,NULL),(1218,'1218','0000-00-00','Prof. Jaco M Greeff','Department of Genetics','University of Pretoria','S. Afarica S. Afarica','',0,NULL,0,0,'0','',3,NULL,0,NULL),(1219,'1219','0000-00-00','Prof. Patricia A Jacobs','Wessex Reginal Genetics Lab.','Salisbury District Hospital','Salisbury Wilts SP2 8BJ','',0,NULL,0,29,'0','',3,NULL,0,NULL),(1220,'1220','0000-00-00','Prof. Suresh C Jhanwar','Director, Cytogenetics Laboratory','Memorical Sloan-Kettering Cancer','Center 212-639-2000, 1275 York AvenueNew York, NY 10065','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1221,'1221','0000-00-00','Dr Chitra Kannabiran','Molecular Genetics Laboratory','LV Prasad Eye Institute','LV Prasad Marg Banjara Hills','',87,NULL,1,0,'500034','',3,NULL,0,NULL),(1222,'1222','0000-00-00','Dr Praveen K Karanth','Centre for Ecological Sciences','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1223,'1223','0000-00-00','Prof. Qingpo Liu','Department of Agronomy','College of Agr. & Food Sci.','Zhejiang A & F University Lin an 311300Hangzhou','',0,NULL,0,6,'0','',3,NULL,0,NULL),(1224,'1224','0000-00-00','Prof. Robert Lucas','Faculty of Life Sciences','University of Manchester',' Manchester M13 9PT','',0,NULL,0,29,'0','',3,NULL,0,NULL),(1225,'1225','0000-00-00','Prof. Margarida Matos','Centro de Biologia Ambiental','Universidad de Lisboa','Portugal Portugal','',0,NULL,0,0,'0','',3,NULL,0,NULL),(1226,'1226','0000-00-00','Prof. N G Prasad','Indian Insi. of Science Education','and Research','MGSIPA Complex Sector 26','',140,NULL,22,0,'160019','',3,NULL,0,NULL),(1227,'1227','0000-00-00','Dr Sudipto Roy','Inst. of Molecular & Cell Biology','Proteos','61, Biopolis Drive Singapore 138673','',0,NULL,0,24,'0','',3,NULL,0,NULL),(1228,'1228','0000-00-00','Prof. Mauro Santos','Departament de Genetica i de','Microbiologia','Universitat Autnoma de Barcelona Entrada Nord Edifici de Cincies','',0,NULL,0,25,'0','',3,NULL,0,NULL),(1229,'1229','0000-00-00','Dr Vijay K Sharma','EOB Unit','Jawaharlal Nehru Centre for Adv.','Scientific Research Jakkur','',28,NULL,13,0,'560064','',3,NULL,0,NULL),(1230,'1230','0000-00-00','Prof. Naoyuki Takahata','Graduate University for Advanced','Studies','Shonan Village HayamaKanagawa 240-01','',0,NULL,0,15,'0','',3,NULL,0,NULL),(1231,'1231','0000-00-00','Dr Shrish Tiwari','Centre for Cellular and Molecular','Biology','Uppal Road ','',87,NULL,1,0,'500007','',3,NULL,0,NULL),(1232,'1232','0000-00-00','Dr J Nagaraju','Head, Molecular Genetics Lab.','Centre for DNA Fingerprinting and','Diagnostics, Bldg 7, Gruhakalpa 5-4-399/B, Nampalli','',87,NULL,1,0,'500001','',3,NULL,0,NULL),(1233,'1233','0000-00-00','Prof. Laurence D Mueller','Dept. of Ecology & Evolutionary','Biology','University of California Irvine, CA 92697-2525','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1234,'1234','0000-00-00','Prof. Rama Govindarajan','Engineering Mechanics Unit','Jawaharlal Nehru Centre for','Advanced Scientific Research Jakkur','',28,NULL,13,0,'560064','',3,NULL,0,NULL),(1235,'1235','0000-00-00','Prof. R Raman','Dept. of Zoology','Banaras Hindu University',' ','',231,NULL,28,0,'221005','',3,NULL,0,NULL),(1236,'1236','0000-00-00','Dr T N C Vidya','Evolutionary & Organismal Biology','Unit','JNCASR Jakkur','',28,NULL,13,0,'560064','',3,NULL,0,NULL),(1237,'1237','0000-00-00','Prof. Talat hmad','Dept. of Geology','University of Delhi',' ','',58,NULL,6,0,'110007','',3,NULL,0,NULL),(1238,'1238','0000-00-00','Prof. Somnath Dasgupta','','IISER',' Nadia','',0,NULL,28,0,'0','',3,NULL,0,NULL),(1239,'1239','0000-00-00','Dr Ravi S Nanjundiah','CAOS','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1240,'1240','0000-00-00','Prof. V V Srinivas','Dept. of Civil Engineering','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1241,'1241','0000-00-00','Prof. Aravinda Chakravarti','Director, CCDG','McKusick-Nathans Inst. of Genetic','Medicine, JH Unv. School of Medicine, Broadway Res. BuildingBalt','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1242,'1242','0000-00-00','Dr G R Chandak','Genomics Research Group','Centre for Cellular & Molecualr','Biology Uppal Road','',87,NULL,1,0,'500007','',3,NULL,0,NULL),(1243,'1243','0000-00-00','Dr Archana Bhattacharyya','Emeritus Scientist','Indian Institute of Geomagnetism','Kalamboli, New Panvel ','',154,NULL,17,0,'410218','',3,NULL,0,NULL),(1244,'1244','0000-00-00','Prof. Deepak Dhar','Theoretical Physics Group','Tata Inst. of Fundamental Research','Homi Bhabha Road ','',142,NULL,17,0,'400005','',3,NULL,0,NULL),(1245,'1245','0000-00-00','Prof. S Duttagupta','School of Physics','University of Hyderabad',' ','',87,NULL,1,0,'500046','',3,NULL,0,NULL),(1246,'1246','0000-00-00','Prof. A S Joshipura','Theory Group','Physical Research Laboratory','Navrangpura ','',2,NULL,8,0,'380009','',3,NULL,0,NULL),(1247,'1247','0000-00-00','Prof. S N Kaul','School of Physics','University of Hyderabad',' ','',87,NULL,1,0,'500046','',3,NULL,0,NULL),(1248,'1248','0000-00-00','Prof. T Padmanabhan','Inter-University Centre for','Astronomy & Astrophysics','Ganeshkhind ','',173,NULL,17,0,'411007','',3,NULL,0,NULL),(1249,'1249','0000-00-00','Prof. D D Sarma','SSCU','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1250,'1250','0000-00-00','Dr S M Sharma','High Pressure Physics Division','Bhabha Atomic Research Centre','Trombay ','',142,NULL,17,0,'400085','',3,NULL,0,NULL),(1251,'1251','0000-00-00','Dr Pawan Dewangan','','National Institute of Oceanography',' ','',64,NULL,7,0,'403004','',3,NULL,0,NULL),(1252,'1252','0000-00-00','Prof. Luis M Corrochano','Dept. of Genetica','Facultad de Biologia','Universidad de Sevilla Sevilla E-41012','',0,NULL,0,25,'0','',3,NULL,0,NULL),(1253,'1253','0000-00-00','Prof. Robert M Greenberg','School of Veterinary Medicine','University of Pennsylvania','3800 Spruce Street Philadelphia, PA 19104','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1254,'1254','0000-00-00','Dr Manisha Inamdar','Molecular Biol. & Genetics Lab.','Jawaharlal Nehru Centre for Adv.','Scientific Research Jakkur','',28,NULL,13,0,'560064','',3,NULL,0,NULL),(1255,'1255','0000-00-00','Dr Satish Kumar','','Centre for Cellular & Molecular','Biology Uppal Road','',87,NULL,1,0,'500007','',3,NULL,0,NULL),(1256,'1256','0000-00-00','Dr Veena K Parnaik','','Centre for Cellular & Molecular','Biology Uppal Road','',87,NULL,1,0,'500007','',3,NULL,0,NULL),(1257,'1257','0000-00-00','Prof. B J Rao','Dept. of Biological Sciences','Tata Inst. of Fundamental Research','Homi Bhabha Road ','',142,NULL,17,0,'400005','',3,NULL,0,NULL),(1258,'1258','0000-00-00','Prof. Chanda J Jog','Dept. of Physics','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1259,'1259','0000-00-00','Dr Ashok K Ambastha','Udaipur Solar Observatory','PB No. 198','Bari Road Dewali','',225,NULL,24,0,'313001','',3,NULL,0,NULL),(1260,'1260','0000-00-00','Prof. Somnath Bharadwaj','Dept. of Physics & Meteorology','Indian Institute of Technology',' ','',112,NULL,30,0,'721302','',3,NULL,0,NULL),(1261,'1261','0000-00-00','Prof. Victor Debattista','Jeremiah Horrocks Institute','University of Central Lancashire',' Preston PR1 2HE','',0,NULL,0,29,'0','',3,NULL,0,NULL),(1262,'1262','0000-00-00','Prof. Swarna K Ghosh','Dept. of Astronomy & Astrophysics','Tata Inst. of Fundamental Research','Homi Bhahba Road ','',142,NULL,17,0,'400005','',3,NULL,0,NULL),(1263,'1263','0000-00-00','Dr Sunetra Giridhar','','Indian Institute of Astrophysics','Sarjapur Road ','',28,NULL,13,0,'560034','',3,NULL,0,NULL),(1264,'1264','0000-00-00','Dr Pushpa Khare','Inter-University Centre for','Astronomy & Astrophysics (IUCAA)','Ganeshkhind ','',173,NULL,17,0,'411007','',3,NULL,0,NULL),(1265,'1265','0000-00-00','Prof. Paul Wiita','Dept. of Physics & Astronomy','Georgia State University',' Atlanta, GA 30303-2924','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1266,'1266','0000-00-00','Dr Vivek Datar','Nuclear Physics Division','Bhabha Atomic Research Centre','Trombay ','',142,NULL,17,0,'400085','',3,NULL,0,NULL),(1267,'1267','0000-00-00','Dr B V R Tata','Materials Science Division','Indira Gandhi Centre for Atomic','Research ','',103,NULL,26,0,'603102','',3,NULL,0,NULL),(1268,'1268','0000-00-00','Prof. P M Ajayan','Dept. of Mechanical Engg. and','Materials Science','Rice University 6100 Main StreetHouston, TX 77005','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1269,'1269','0000-00-00','Prof. Vinayak P Dravid','Director, NUANCE Centre','North-Western University','2220 Campus Drive 1131, Cook HallEvanston, IL 60208-3108','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1270,'1270','0000-00-00','Prof. S R Elliott','Dept. of Chemistry','Cambridge University','Lansfield Road Cambridge CB2 1EW','',0,NULL,0,29,'0','',3,NULL,0,NULL),(1271,'1271','0000-00-00','Prof. J Lucas','Lab. Verres et Ceramiques','Universite de Rennes','Frnace Frnace','',0,NULL,0,0,'0','',3,NULL,0,NULL),(1272,'1272','0000-00-00','Prof. Carlo G Pantano','Dept. of Materials Science and','Engineering','The Pennsylvanis State University 198, MRI BuildingUniversity Pa','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1273,'1273','0000-00-00','Prof. Hiroshi Ishiwara','Frontier Collaborative Res. Centre','Tokyo Institute of Technology','4259, Nagatsuta MidorikuYokohama 226-8503','',0,NULL,0,15,'0','',3,NULL,0,NULL),(1274,'1274','0000-00-00','Prof. M Vallet-Regi','Dept. de Quimica Inorganica','Facultad de Farmacia','Universidad Complutense de Madrid y Bioinorganica28040 Madrid','',0,NULL,0,25,'0','',3,NULL,0,NULL),(1275,'1275','0000-00-00','Prof. P Vincenzini','World Academy of Ceramics','P.B. No. 165',' 48018 Faenza RA','',0,NULL,0,14,'0','',3,NULL,0,NULL),(1276,'1276','0000-00-00','Prof. George W Whitesides','Dept. of Chemistry & Chemical','Biology','Harvard University 12, Osford StreetCambridge, MA 02138','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1277,'1277','0000-00-00','Prof. A M Raichur','Dept. of Materials Engineering','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1278,'1278','0000-00-00','Dr S Srikanth','Director','National Metallurgical Laboratory',' ','',98,NULL,11,0,'831007','',3,NULL,0,NULL),(1279,'1279','0000-00-00','Prof. A K Ganguli','Dept. of Chemistry','Indian Institute of Technology',' ','',156,NULL,6,0,'110016','',3,NULL,0,NULL),(1280,'1280','0000-00-00','Prof. Vikram Jayaram','Dept. of Materials Engineering','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1281,'1281','0000-00-00','Prof. Indranil Manna','Director','CGCRI','196, Raja SC Mullick Road  Kolkdata 700 032','',0,NULL,30,0,'700032','',3,NULL,0,NULL),(1282,'1282','0000-00-00','Prof. S Ramasesha','SSCU','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1283,'1283','0000-00-00','Dr C S Sundar','Head, Materials Science Division','Indira Gandhi Centre for Atomic','Research ','',103,NULL,26,0,'603102','',3,NULL,0,NULL),(1284,'1284','0000-00-00','Dr George K Thomas','IISER','NET Campus',' ','',217,NULL,14,0,'695016','',3,NULL,0,NULL),(1285,'1285','0000-00-00','Dr  Baldev Raj','Director','IGCAR',' ','',103,NULL,26,0,'603102','',3,NULL,0,NULL),(1286,'1286','0000-00-00','Prof. J Gopalakrishnan','SSCU','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1287,'1287','0000-00-00','Prof. K T Jacob','Dept. of Materials Engineering','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1288,'1288','0000-00-00','Prof. P Rama Rao','ARCI','Balapur',' ','',87,NULL,1,0,'500005','',3,NULL,0,NULL),(1289,'1289','0000-00-00','Prof. S Mahadevan','DBGL','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1290,'1290','0000-00-00','Prof. M Narasimha Murthy','CSA Department','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1291,'1291','0000-00-00','Prof. Sarah Elsea','School of Medicine','Virginia Commonwealth University','1101 E Marshall Street Richmond, VA 23298-0441','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1292,'1292','0000-00-00','Prof. S Tripathi','Dept. of Civil Engineering','Indian Institute of Technology',' ','',107,NULL,28,0,'208016','',3,NULL,0,NULL),(1293,'1293','0000-00-00','Prof. V M Gadre','Dept. of Electrical Engineering','Indian Institute of Technology','Powai ','',142,NULL,17,0,'400076','',3,NULL,0,NULL),(1294,'1294','0000-00-00','Prof. P N Vinayachandran','CAOS','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1295,'1295','0000-00-00','Prof. R Srianand','Inter-University Centre for','Astronomy & Astrophysics','PB No. 4, Ganeshkhind ','',173,NULL,17,0,'411007','',3,NULL,0,NULL),(1296,'1296','0000-00-00','Prof. Utpal Sarkar','Theoretical Physics Divison','Physical Research Laboratory','Navrangpura ','',2,NULL,8,0,'380009','',3,NULL,0,NULL),(1297,'1297','0000-00-00','Prof. S Natarajan','SSCU','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1298,'1298','0000-00-00','Prof. Mj Mahan','School of Mathematical Sci.','RKM Vivekananda University','Belur Math P.O. ','',85,NULL,30,0,'711202','',3,NULL,0,NULL),(1299,'1299','0000-00-00','Prof. J K Bera','Dept. of Chemistry','Indian Institute of Technology',' ','',107,NULL,28,0,'208016','',3,NULL,0,NULL),(1300,'1300','0000-00-00','Prof. Tapas Chakraborty','Dept. of Physical Chemistry','Indian Assn. for the Cultivation','of Science Jadavpur','',116,NULL,30,0,'700032','',3,NULL,0,NULL),(1301,'1301','0000-00-00','Prof. Karthik Shanker','CES','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1302,'1302','0000-00-00','Dr T Raghunand','Centre for Cellular & Molecular','Biology','Uppal Road ','',87,NULL,1,0,'500007','',3,NULL,0,NULL),(1303,'1303','0000-00-00','Prof. Shobha Madan','Dept. of Mathematics','Indian Institute of Technology',' ','',107,NULL,28,0,'208016','',3,NULL,0,NULL),(1304,'1304','0000-00-00','Prof. Sunanda Banerjee','HENPP Division','Saha Institute of Nuclear Physics','1/AF, Bidhan Nagar ','',116,NULL,30,0,'700064','',3,NULL,0,NULL),(1305,'1305','0000-00-00','Prof. Indrani Bose','Dept. of Physics','Bose Institute','93/1, APC Road ','',116,NULL,30,0,'700009','',3,NULL,0,NULL),(1306,'1306','0000-00-00','Prof. Dhananjai Pandey','Dept. of Physics','Banaras Hindu University',' ','',231,NULL,28,0,'221005','',3,NULL,0,NULL),(1307,'1307','0000-00-00','Prof. G Ravindra Kumar','Dept. of Nuclear & Atomic Physics','Tata Inst. of Fundamental Research','Homi Bhabha Road ','',142,NULL,17,0,'400005','',3,NULL,0,NULL),(1308,'1308','0000-00-00','Prof. Anurag Sharma','Dept. of Physics','Indian Institute of Technology',' ','',156,NULL,6,0,'110016','',3,NULL,0,NULL),(1309,'1309','0000-00-00','Prof. U V Waghmare','Theoretical Sciences Unit','JNCASR','Jakkur P.O. ','',28,NULL,13,0,'560064','',3,NULL,0,NULL),(1310,'1310','0000-00-00','Prof. Nitin Chattopadhyay','Dept. of Chemistry','Jadavpur University',' ','',116,NULL,30,0,'700032','',3,NULL,0,NULL),(1311,'1311','0000-00-00','Prof. Dilip D Dhavale','Dept. of Chemistry','University of Pune',' ','',173,NULL,17,0,'411007','',3,NULL,0,NULL),(1312,'1312','0000-00-00','Prof. A K Ganguli','Dept. of Chemistry','Indian Institute of Technology',' ','',156,NULL,6,0,'110016','',3,NULL,0,NULL),(1313,'1313','0000-00-00','Dr C S Gopinath','Catalysis Division','National Chemical Laboratory',' ','',173,NULL,17,0,'411008','',3,NULL,0,NULL),(1314,'1314','0000-00-00','Dr M Lakshmi Kantam','Inorganic & Physical Chemistry','Indian Inst. of Chemical Technology','Uppal Road  Hyderabad 500 607','',0,NULL,1,0,'600607','',3,NULL,0,NULL),(1315,'1315','0000-00-00','Dr E J Padma Malar','Dept. of Chemistry','University of Madras','Taramani Campus ','',50,NULL,26,0,'600113','',3,NULL,0,NULL),(1316,'1316','0000-00-00','Prof. M Durga Prasad','School of Chemistry','University of Hyderabad',' ','',87,NULL,1,0,'500046','',3,NULL,0,NULL),(1317,'1317','0000-00-00','Prof. R Ramaraj','School of Chemistry','Madurai Kamaraj University',' ','',129,NULL,26,0,'625021','',3,NULL,0,NULL),(1318,'1318','0000-00-00','Prof. C Pulla Rao','Dept. of Chemistry','Indian Institute of Technology','Powai ','',142,NULL,17,0,'400076','',3,NULL,0,NULL),(1319,'1319','0000-00-00','Prof. S Sampath','IPC Department','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1320,'1320','0000-00-00','Prof. S Sankararaman','Dept. of Chemistry','Indian Institute of Technology',' ','',50,NULL,26,0,'600036','',3,NULL,0,NULL),(1321,'1321','0000-00-00','Dr George K Thomas','School of Chemistry','IISER','CET Campus ','',217,NULL,14,0,'695016','',3,NULL,0,NULL),(1322,'1322','0000-00-00','Prof. Sandeep Verma','Dept. of Chemistry','Indian Institute of Technology',' ','',107,NULL,28,0,'208016','',3,NULL,0,NULL),(1323,'1323','0000-00-00','Prof. S J Wategaonkar','Dept. of Chemical Sciences','Tata Inst. of Fundamental Research','Homi Bhabha Road ','',142,NULL,17,0,'400005','',3,NULL,0,NULL),(1324,'1324','0000-00-00','Prof. G Mugesh','IPC Department','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1325,'1325','0000-00-00','Prof. I N N Namboothiri','Dept. of Chemistry','Indian Institute of Technology','Powai ','',142,NULL,17,0,'400076','',3,NULL,0,NULL),(1326,'1326','0000-00-00','Prof. Y N Srikanth','CSA Department','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1327,'1327','0000-00-00','Prof. Giridhar Madras','Dept. of Chemical Engineering','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1328,'1328','0000-00-00','Prof. M Ghanashyam Krishna','School of Physics','University of Hyderabad',' ','',87,NULL,1,0,'500046','',3,NULL,0,NULL),(1329,'1329','0000-00-00','Dr U C Lavania','Central Inst. of Medicinal &','Aromatic Plants','CIMAP P.O. ','',127,NULL,28,0,'226015','',3,NULL,0,NULL),(1330,'1330','0000-00-00','Dr Trilochan Mohapatra','Director','Central Rice Research Institute',' ','',53,NULL,21,0,'753006','',3,NULL,0,NULL),(1331,'1331','0000-00-00','Dr Analabha Basu','National Inst. of Biomedical','Genomics','N S Sanatorium NSS P.O.','',105,NULL,30,0,'741251','',3,NULL,0,NULL),(1332,'1332','0000-00-00','Dr U Kodandaramaiah','Department of Zoology','University of Cambridge',' Cambridge CB2 3EJ','',0,NULL,0,29,'0','',3,NULL,0,NULL),(1333,'1333','0000-00-00','Prof. Nibir Mandal','Department of Geological Sciences','Jadavpur University',' ','',116,NULL,30,0,'700032','',3,NULL,0,NULL),(1334,'1334','0000-00-00','Dr Sorab N Dalal','ACTREC','Tata Memorial Centre','Kharghar Node ','',154,NULL,17,0,'410210','',3,NULL,0,NULL),(1335,'1335','0000-00-00','Prof. Indranil Dasgupta','Dept. of Plant Molecular Biology','University of Delhi South Campus','Benito Juarez Road ','',156,NULL,6,0,'110021','',3,NULL,0,NULL),(1336,'1336','0000-00-00','Dr Satyajit Rath','','National Institute of Immunology','Aruna Asaf Ali Marg ','',156,NULL,6,0,'110067','',3,NULL,0,NULL),(1337,'1337','0000-00-00','Dr A K Chaubey','Geological Oceanography Division','National Institute of Oceanography',' ','',64,NULL,7,0,'403004','',3,NULL,0,NULL),(1338,'1338','0000-00-00','Prof. P P Mujumdar','Dept. of Civil Engineering','Indian Institute of Science',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1339,'1339','0000-00-00','Prof. S M Deshpande','EM Unit','JNCASR',' ','',28,NULL,13,0,'560064','',3,NULL,0,NULL),(1340,'1340','0000-00-00','Prof. Anurag Kumar','ECE Dept.','IISc',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1341,'1341','0000-00-00','Prof. K A Natarajan','Materials Engg. Dept.','IISc',' ','',28,NULL,13,0,'560012','',3,NULL,0,NULL),(1342,'1342','0000-00-00','Dr V V Ranade','CEPD Division','NCL',' ','',173,NULL,17,0,'411008','',3,NULL,0,NULL),(1343,'1343','0000-00-00','Prof. Askey R A','Mathematics Department','University of Wisconsin-Madison','Van Vleck Hall, 480, Lincoln Drive Madison, Wisconsin 53706','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1344,'1344','0000-00-00','Prof. Bloembergen, NL N','Optical Sciences Centre','University of Arizona','1630E, University Blvd. Tucson, AZ 85721','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1345,'1345','0000-00-00','Prof. Goodenough John B','Cockrell Centennial Prof. of Engg.,','Texas Materials Institute','University of Texas at Austin ETC 9.102, 1 Univ. Station C2202Au','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1346,'1346','0000-00-00','Prof. Hagenmuller P','Honorary Director, ICME-CNRS','Bordeaux University','87 Avenue, Dr Albert Schweitzer 33608 Pessac Cedex','',0,NULL,0,10,'0','',3,NULL,0,NULL),(1347,'1347','0000-00-00','Prof. Staab H A','Schloss-Wolfsbrunnenweg 43','',' D-69118 Heidelberg','',0,NULL,0,11,'0','',3,NULL,0,NULL),(1348,'1348','0000-00-00','Prof. Thomas J M','Dept. of Materials Science &','Metallurgy','Cambridge University Pembroke StreetCambridge CB2 3QZ','',0,NULL,0,29,'0','',3,NULL,0,NULL),(1349,'1349','0000-00-00','Prof. Brenner Sydney','Distinguished Professor','The Salk Institute','10010, North Torry Pines RoadLa Jolla, CA 92037','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1350,'1350','0000-00-00','Prof. Berry Sir Michael Victor','H.H. Wills Physics Laboratory','University of Bristol','Royal Fort, Tyndall Avenue Bristol BS8 1TL','',0,NULL,0,29,'0','',3,NULL,0,NULL),(1351,'1351','0000-00-00','Prof. Lehn, NL Jean-Marie','ISIS - ULP, CNRS UMR 7006','','Universite Louis Pasteur 8, Alle Gaspard Monge, BP 70028F-67083 ','',0,NULL,0,10,'0','',3,NULL,0,NULL),(1352,'1352','0000-00-00','Prof. Markl Hubert S','Department of Biology','Universitat Konstanz','Postfach M612 D-78457 Konstanz','',0,NULL,0,11,'0','',3,NULL,0,NULL),(1353,'1353','0000-00-00','Prof. Rees Sir Martin','Prof. of Cosmology & Astrophysics','Institute of Astronomy','University of Cambridge Madingley RoadCambridge CB3 0HA','',0,NULL,0,29,'0','',3,NULL,0,NULL),(1354,'1354','0000-00-00','Prof. Bonner J T','Department of Ecology and','Evolutionary Biology','Princeton University Princeton, NJ 08544-1003','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1355,'1355','0000-00-00','Prof. Ratajczak Henryk','Vice President','Faculty of Chemistry','University of Wroclaw 14, Joliot-Curie Street50-883 Wroclaw','',0,NULL,0,21,'0','',3,NULL,0,NULL),(1356,'1356','0000-00-00','Prof. Raveau Bernard','Directeur du CNRT Matiriaux','ENSICAEN','6, Boulevard Marichal Juin 14050 Caen Cedex 4','',0,NULL,0,10,'0','',3,NULL,0,NULL),(1357,'1357','0000-00-00','Prof. Nagakura Saburo','','The Japan Academy','7-32, Ueno Park Taito-kuTokyo 110-0007','',0,NULL,0,15,'0','',3,NULL,0,NULL),(1358,'1358','0000-00-00','Prof. Day Peter','Fullerian Prof. of Chemistry','Royal Institution of Great Britain','21 Albemarle Street London W1S 4BS','',0,NULL,0,29,'0','',3,NULL,0,NULL),(1359,'1359','0000-00-00','Prof. Patel C K N','Chairman and CEO','Pranalytica Inc.','1101, Colorado Avenue Santa Monica, CA 90401','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1360,'1360','0000-00-00','Prof. Ashtekar Abhay','Director, Inst. for Gravitation','and the Cosmos','Pennsylvania State University 104 Davey LaboratoryUniversity Par','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1361,'1361','0000-00-00','Prof. Palis Jacob','Instituto de Matematica Pura e','Aplicada - IMPA','Estrada Dona Castorina 110-Jardim Botanico22460-320 Rio de Janei','',0,NULL,0,3,'0','',3,NULL,0,NULL),(1362,'1362','0000-00-00','Prof. Roshko Anatol','Theodre von Karman Professor of','Aeronautics, Grad. Aeronautical','Laboratories California Institute of TechnologyPasadena, CA 9112','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1363,'1363','0000-00-00','Prof. Anderson P W','Joseph Henry Lab., Dept. of Physics','Princeton University','Jadwin Hall, P.O. Box 70B Princeton, NJ 08544-0708','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1364,'1364','0000-00-00','Prof. Roesky H W','Director','Institut fuer Anorganic Chemie','der Universitat Goettingen Tammannstrasse 4D-37077 Goettingen','',0,NULL,0,11,'0','',3,NULL,0,NULL),(1365,'1365','0000-00-00','Prof. King David Anthony','Director','Smith School of Enterprise &','Environment 75, George StreetOxford OX1 2BQ','',0,NULL,0,29,'0','',3,NULL,0,NULL),(1366,'1366','0000-00-00','Prof. O\'nions Robert K','Director','Institute for Security Sci. & Tech.','Imperial College London SW7 2AZ','',0,NULL,0,29,'0','',3,NULL,0,NULL),(1367,'1367','0000-00-00','Prof. Cohen-Tannoudji Claude','College de France','Laboratoire Kastler Brossel','24, rue Lhomond Ecole Normale Suprieure75231 Paris Cedex 05','',0,NULL,0,10,'0','',3,NULL,0,NULL),(1368,'1368','0000-00-00','Prof. Sutherland Bill','Department of Physics','University of Utah','115 S 1400 E Rm 201 Salt Lake City, UT 84112-0830','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1369,'1369','0000-00-00','Prof. Cheetham Anthony K','Dept. of Materials Science &','Metallurgy','University of Cambridge Cambridge CB2 3QZ','',0,NULL,0,29,'0','',3,NULL,0,NULL),(1370,'1370','0000-00-00','Prof. Fisher, FRS Michael E','Distinguished University Professor','Institute of Physical Science and','Technology University of MarylandCollege Park, MD 20742-8510','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1371,'1371','0000-00-00','Prof. van den Heuvel E P J','Professor of Astrophysics','Astronomical Inst., Faculty of Sci.','University of Amsterdam PO Box 94249NL-1090 GE Amsterdam','',0,NULL,0,18,'0','',3,NULL,0,NULL),(1372,'1372','0000-00-00','Prof. Zewail Ahmed H','Linus Pauling Prof. of Chemistry','AAN Laboratory of Chemical Physics','California Institute of Technology 1200, East California Bouleva','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1373,'1373','0000-00-00','Prof. Dodson George Guy','Chemistry Department','University of York',' YSBLYork YO10 5VW','',0,NULL,0,29,'0','',3,NULL,0,NULL),(1374,'1374','0000-00-00','Prof. Sreenivasan K R','Professor of Physics','Provost\'s Office, Bobst Lib.','New  York University 1225, 70 Washington Square SouthNew York, N','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1375,'1375','0000-00-00','Prof. Griffiths Phillip A','Professor Emeritus of Mathematics','Institute for Advanced Study','Einstein Drive Princeton, NJ 08540','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1376,'1376','0000-00-00','Prof. Livage Jacques','Chimie de la Matiere Condensee','College de France','11, Place Marcelin Berthelot 75231 Paris','',0,NULL,0,10,'0','',3,NULL,0,NULL),(1377,'1377','0000-00-00','Prof. Varadhan S R S','Department of Mathematics','Courant Institute','New York University 251, Mercer StreetNew York, NY 10012','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1378,'1378','0000-00-00','Prof. Suresh Subra','Ford Professor of Engineering &','Dean of Engineering','Massachusetts Inst. of Technology Room 8-309, 77 Massachusetts A','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1379,'1379','0000-00-00','Prof. Chakraborty Ranajit','Director','Centre for Computational Genomics','University of North Texas HSC, 3500 Camp Bowie Blvd.Fort Worth, ','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1380,'1380','0000-00-00','Prof. Klein Michael L','Director','Inst. for Computational Mol. Sci.','Temple University Bio-Life Bldg. 113, 1900 N 12th St.Philadelphi','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1381,'1381','0000-00-00','Prof. Gross David J','Kavli Institute for Theoretical','Physics','University of California Kohn HallSanta Barbara, CA 93106-4030','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1382,'1382','0000-00-00','Prof. Imry Yoseph','Dept. of Condensed Matter Physics','The Weizmann Institute of Science',' Rehovot 76100','',0,NULL,0,13,'0','',3,NULL,0,NULL),(1383,'1383','0000-00-00','Prof. Nicolaou K C','Department of Chemistry','The Scripps Research Institute','University of California, San Diego La Jolla, CA 92093-0548','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1384,'1384','0000-00-00','Prof. Chakravarti Aravinda','McKusick-Nathans Inst. of Genetic','Medicine, Johns Hopkins University','School of Medicine Broadway Res. Bldg., 733 N BroadwayBaltimore,','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1385,'1385','0000-00-00','Prof. Jansen Martin','Director','Max-Planck-Institut fuer','Festkoerperforschung Heisenbergstr 1D-70569, Stuttgart','',0,NULL,0,11,'0','',3,NULL,0,NULL),(1386,'1386','0000-00-00','Prof. Bai Chunli','Executive Vice-President','Chinese Academy of Sceicnes','52, Sanlihe Road Beijing 100864','',0,NULL,0,6,'0','',3,NULL,0,NULL),(1387,'1387','0000-00-00','Prof. Zare Richard N','MBW Professor in Natural Science','Department of Chemistry','Stanford University Stanford CA 94305-5080','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1388,'1388','0000-00-00','Prof. Hartl Daniel L','Dept. of Organismic & Evolutionary','Biology, The Biological Lab.','Harvard University 16, Divinity AvenueCambridge, MA 02138','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1389,'1389','0000-00-00','Prof. Friend Sir Richard','Cavendish Laboratory','JJ Thomson Avenue',' Cambridge CB3 0HE','',0,NULL,0,29,'0','',3,NULL,0,NULL),(1390,'1390','0000-00-00','Prof. Marks Tobin J','Prof. of Materials Sci. & Engg.','Department of Chemistry','Northwestern University 2145, Sheridan RoadEvanston, IL 60708','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1391,'1391','0000-00-00','Prof. Khosla Pradeep K','Dean, College of Engineering','Carnegie Mellon University',' Pittsburgh, PA 15213','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1392,'1392','0000-00-00','Prof. Parkin S S P','Manager, Magnetoelectronics Group','IBM Almeden Research Centre','650, Harry Road San Jose, CA 95120-6099','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1393,'1393','0000-00-00','Prof. Kulkarni Srinivas R','Director','Caltech Optical Observatories','California Inst. of Technology Pasadena, CA 91125','',0,NULL,0,30,'0','',3,NULL,0,NULL),(1394,'1394','0000-00-00','The Librarian','ISRO Headquarters Library','Antariksh Bhavan','New BEL Road ','',28,NULL,13,0,'560094','',6,NULL,0,NULL),(1395,'1395','0000-00-00','The Librarian','Sree Chitra Tirunal Institute','for Medical Science & Technology',' ','',217,NULL,14,0,'695011','',6,NULL,0,NULL),(1396,'1396','0000-00-00','The Librarian','Osmania University','',' ','',87,NULL,1,0,'500007','',6,NULL,0,NULL),(1397,'1397','0000-00-00','The Librarian','Bangalore University','Main Library',' Jnana Bharathi','',28,NULL,13,0,'560056','',6,NULL,0,NULL),(1398,'1398','0000-00-00','The Libarian','Tata Institute of Fundamental','Research','Homi Bhabha Road Colaba','',142,NULL,17,0,'400005','',6,NULL,0,NULL),(1399,'1399','0000-00-00','The Librarian','Indian Institute of Science','(REF: Grant-in-Aid copy)','C.V. Raman Avenue ','',28,NULL,13,0,'560012','',6,NULL,0,NULL),(1400,'1400','0000-00-00','The Librarian','Physical Research Laboratory','(Attn: Grant-in-Aid Copy)','Navrangpura ','',2,NULL,8,0,'380009','',6,NULL,0,NULL),(1401,'1401','0000-00-00','The Librarian','Panjab University','A.C. Joshi Library',' ','',48,NULL,31,0,'160014','',6,NULL,0,NULL),(1402,'1402','0000-00-00','The Librarian','Berhampur University','Bhanja Bihar',' ','',29,NULL,21,0,'760007','',6,NULL,0,NULL),(1403,'1403','0000-00-00','University Librarian (Attn: Ms VJ Suseela)','Indira Gandhi Memorial Library','University of Hyderabad',' ','',87,NULL,1,0,'500046','',6,NULL,0,NULL),(1404,'1404','0000-00-00','Science Library','303 Mathematics Columbi/1ADB8949','2990 Broadway','New York NY 10027','',0,NULL,0,30,'0','',5,NULL,0,NULL),(1405,'1405','0000-00-00','Acquisitions','Chemical Abstracts Service','','P O Box 3012 ColumbusOhio 43210-0012','',0,NULL,0,30,'0','',5,NULL,0,NULL),(1406,'1406','0000-00-00','Biblioteca','Real Academia de Ciencias Artes','De Barcelons','Rambla Jels Estudis, NS 08002 Borcelona','',0,NULL,0,25,'0','',5,NULL,0,NULL),(1407,'1407','0000-00-00','Dr. Lise Premn','Det Kongelige Danake','Videnskabernes Selskab','Dantes Plads 5 Kobenbaur V','',0,NULL,0,8,'0','',5,NULL,0,NULL),(1408,'1408','0000-00-00','National Central Library','Bureau of International Exchange','of Publications','20, Chungshan S Road Taipai, Taiwan 10040','',0,NULL,0,6,'0','',5,NULL,0,NULL),(1409,'1409','0000-00-00','Ms.Hollis Seidner (Sub Rep)','THOMSON REUTERS','Publisher Relations','1500 Spring Garden Street 4th Floor, N.241Philadelphia, PA 19130','',0,NULL,0,30,'0','',5,NULL,0,NULL),(1410,'1410','0000-00-00','Czechentomological Society','','','Vinicna 7 og-InstitutCZ 12800 Praha 2','',0,NULL,0,7,'0','',5,NULL,0,NULL),(1411,'1411','0000-00-00','Acquisitions Manager','Environment Information Centre Inc.','48 West 38th Street',' New York, NY 10018','',0,NULL,0,30,'0','',5,NULL,0,NULL),(1412,'1412','0000-00-00','Library','Gifts and Exchanges','Field Museum of Natural History','Roosevelt Rd & Lake Shore Dr Chicago, IL 60605','',0,NULL,0,30,'0','',5,NULL,0,NULL),(1413,'1413','0000-00-00','Elsevier Science B.V.,','Secondary Publishing Division','Bibliographic Database','Attn: Source Management P.O. Box 22271000 CE Amsterdam','',0,NULL,0,18,'0','',5,NULL,0,NULL),(1414,'1414','0000-00-00','CIRAD (ECH-FLHOR)','TA 583/05','Avenue Agropolis',' 34398 Montpellier Cedex','',0,NULL,0,10,'0','',5,NULL,0,NULL),(1415,'1415','0000-00-00','Missouri Botanical Garden','Library','PO Box 299',' St. Louis, MO 63166-0299','',0,NULL,0,30,'0','',5,NULL,0,NULL),(1416,'1416','0000-00-00','Dr. Lu Chang Qin','Librarian','Shanghai Inst. of Organic Chemistry','Chinese Academy of Sciences 354 Lingling Lu,Shanghai 200 032','',0,NULL,0,6,'0','',5,NULL,0,NULL),(1417,'1417','0000-00-00','Accessions Unit','CABI Head Office','PO Box No. 100','Wallingford Oxon OX10 8DF','',0,NULL,0,29,'0','',5,NULL,0,NULL),(1418,'1418','0000-00-00','INSPEC','Acquisition SectionElectrical Enggs','Michael Faraday House','Six Hills Way,  Stevenage Herts SG1 2AY','',0,NULL,0,29,'0','',5,NULL,0,NULL),(1419,'1419','0000-00-00','The Library','RIKEN (The Inst Phys Chem Res)','Hirosawa 2-1, Wako-Shi',' Saitama 351-0198','',0,NULL,0,15,'0','',5,NULL,0,NULL),(1420,'1420','0000-00-00','Dr Hiroshi Sato','Institute of Flow Research','6-10-39-205','Akasaka, Minato-Ku Tokyo','',0,NULL,0,15,'0','',5,NULL,0,NULL),(1421,'1421','0000-00-00','Hiroshima University Library','Central Library','Exchange Section','2-2 Kagamiyama 1 Chome Higashi-Hiroshima 739-8512Hiroshima','',0,NULL,0,15,'0','',5,NULL,0,NULL),(1422,'1422','0000-00-00','Universitatsbibllothek Bern','Zentralbibliothek Exchange','',' Munstergasse 61, PostfachCH-3000 Bern 8','',0,NULL,0,27,'0','',5,NULL,0,NULL),(1423,'1423','0000-00-00','INIST-CNRS','DAPSI Thierry Morel','Primaires','2, Allee du Parc de Brabois CS 1031054519 Vandoeuvre Les Nancy C','',0,NULL,0,10,'0','',5,NULL,0,NULL),(1424,'1424','0000-00-00','Faculty of Natural Sciences and','Mathematics','Institute of Mathematics','Library P.O.Box 1621000 Skopje Macedonia','',0,NULL,0,16,'0','',5,NULL,0,NULL),(1425,'1425','0000-00-00','Stephen Dale','Cambridge University Library','Bene\'t Street','Cambridge Cambridge CB2 3PY','',0,NULL,0,29,'0','',5,NULL,0,NULL),(1426,'1426','0000-00-00','Eth-Bibliothek','Zeitschriftengruppe','Tauschstelle','Ramistrasse 101 CH-8092 Zurich','',0,NULL,0,27,'0','',5,NULL,0,NULL),(1427,'1427','0000-00-00','Frank Carothers','University of California','','132 Doe Library #6000 Barkeley, CA 94720 6000','',0,NULL,0,30,'0','',5,NULL,0,NULL),(1428,'1428','0000-00-00','Proquest Information & Learning','Periodicals Acquisitions','P.O.Box 1346','Ann Arbor MI 48106-1346','',0,NULL,0,30,'0','',5,NULL,0,NULL),(1429,'1429','0000-00-00','Acquisitions Section DLIS','Natural History Museum','',' Cromwel RoadLondon SW7 5BD','',0,NULL,0,29,'0','',5,NULL,0,NULL),(1430,'1430','0000-00-00','Mrs. Brigga-Sunhild Peglau','Journal Acquisitions Librarian','Zentralblatt MATH','Franklinstrasse 11 D - 10587 Berlin','',0,NULL,0,11,'0','',5,NULL,0,NULL),(1431,'1431','0000-00-00','Rapoport Mr M M','Head, International Exchange Dept','The Library for Natural Sciences','Russian Academy of Sciences ul Znamenka  11/11Moscow 119991, GSP','',0,NULL,0,22,'0','',5,NULL,0,NULL),(1432,'1432','0000-00-00','The Librarian','Raman Research Institute','',' ','',0,NULL,0,0,'0','',4,NULL,0,NULL),(1433,'1433','0000-00-00','The Library','Indian National Science Academy','',' Bahadur Shah Zafar Marg','',156,NULL,6,0,'110002','',4,NULL,0,NULL),(1434,'1434','0000-00-00','UNESCO','United Nations Educational,','Scientific & Cultural Organization','UNESCO House B-5/29, Safdarjung Enclave','',156,NULL,6,0,'110029','',4,NULL,0,NULL),(1435,'1435','0000-00-00','Office of the Registrar of','News Papers for India','Vandhana Building','11, Tolstoy Marg ','',156,NULL,6,0,'110001','',4,NULL,0,NULL),(1436,'1436','0000-00-00','The Library Officer','National Institute of Science','Communication (NISCOM)','Dr K S Krishnan Marg (Near Pusa Gate)','',156,NULL,6,0,'110012','',4,NULL,0,NULL),(1437,'1437','0000-00-00','The Librarian','National Library','Govt. of India','Alipore ','',116,NULL,30,0,'700027','',4,NULL,0,NULL),(1438,'1438','0000-00-00','The General Secretary','National Academy of Sciences India','5, Lajpatrai Road','New Katra ','',8,NULL,28,0,'211002','',4,NULL,0,NULL),(1439,'1439','0000-00-00','Shri P C Bose','Information Systems Officer','Agricultural Research Information','Centre, ICAR, Bhavan, 7th Floor Pusa','',156,NULL,6,0,'110012','',4,NULL,0,NULL),(1440,'1440','0000-00-00','Dr K S Jayaraman','Correspondent','NATURE','D-208, Jardine, Brigade Gardenia 7th Phase, J.P. Nagar','',28,NULL,13,0,'560078','',4,NULL,0,NULL),(1441,'1441','0000-00-00','INSDOC','National Science Library','14, Satsang Vihar Marg','P.Box No. 10513 ','',156,NULL,6,0,'110067','',4,NULL,0,NULL),(1442,'1442','0000-00-00','The Librarian','Connemara Public Library','',' ','',50,NULL,26,0,'600008','',4,NULL,0,NULL),(1443,'1443','0000-00-00','The District Magistrate','Bangalore District','',' ','',28,NULL,13,0,'560009','',4,NULL,0,NULL),(1444,'1444','0000-00-00','Director (EXCHANGE)','United States Library of Congress','American Center','24, Kasturba Gandhi Marg ','',156,NULL,6,0,'110001','',4,NULL,0,NULL),(1445,'1445','0000-00-00','The Principal Scientific Officer','Department of Science & Technology','Government of India','Technology Bhavan New Mehrauli Road','',156,NULL,6,0,'110016','',4,NULL,0,NULL),(1446,'1446','0000-00-00','The Senior Documentation Officer','Department of Science & Technology','Information & Documentation Div.','Technology Bhavan New Mehrauli Road','',156,NULL,6,0,'110016','',4,NULL,0,NULL),(1447,'1447','0000-00-00','The Librarian','Geology Department','Calcutta University','35, Ballygunge Circular Road ','',116,NULL,30,0,'700019','',4,NULL,0,NULL),(1448,'1448','0000-00-00','Librarian','Indian Association for the','Cultivation of Science','Jadavpur ','',116,NULL,30,0,'700032','',4,NULL,0,NULL),(1449,'1449','0000-00-00','Senior Superintendent of P.O.','Bangalore East Division','Museum Road',' ','',28,NULL,13,0,'560025','',4,NULL,0,NULL),(1450,'1450','0000-00-00','The Librarian','Kasturba Medical College','',' ','',134,NULL,13,0,'576119','',4,NULL,0,NULL),(1451,'1451','0000-00-00','Prof. S P Modak','Department of Zoology','University of Poona',' ','',173,NULL,17,0,'411007','',4,NULL,0,NULL),(1452,'1452','0000-00-00','Dr G P Kalle','Hindustan Lever Research Centre','Andheri',' ','',142,NULL,17,0,'400009','',4,NULL,0,NULL),(1453,'1453','0000-00-00','The Secretary','I. P. C. L.,','Indian Petrochemicals Corporation','Limited Petrochemicals P.O.','',229,NULL,8,0,'391346','',4,NULL,0,NULL),(1454,'1454','0000-00-00','Indian National Academy of','Engineering','Central Soil & Materials Research','Station Complex Olof Paime Marg','',156,NULL,6,0,'110016','',4,NULL,0,NULL),(1455,'1455','0000-00-00','Science Editor','The Press Trust of India Limited','4, Parliament Street',' ','',156,NULL,6,0,'110001','',4,NULL,0,NULL),(1456,'1456','0000-00-00','National Science Library','INSDOC (Ser. Div.)','J N University Campus Club Bldg.','New Mehrauli Road ','',156,NULL,6,0,'110067','',4,NULL,0,NULL),(1457,'1457','0000-00-00','Dr K Krishna Prasad','Department of Applied Physics','Technische Hogeschool','Postbus 513, Eindhoven','',0,NULL,0,18,'0','',5,NULL,0,NULL),(1458,'1458','0000-00-00','Dr K R Sreenivasan','Department of Mechanical Engg.','Yale University','P.O. Box No. 2159, Yale Station New Haven, CT 06520-2159','',0,NULL,0,30,'0','',5,NULL,0,NULL),(1459,'1459','0000-00-00','The Assistant Librarian','Acquisition Division','Government of India','National Library Alipore','',116,NULL,30,0,'700027','',4,NULL,0,NULL),(1460,'1460','0000-00-00','Shri Satyapraksh,  Editor','(Indian Science Index)','Indian Documentation Services',' ','',79,NULL,10,0,'122001','',4,NULL,0,NULL),(1461,'1461','0000-00-00','Mr M P Vaze   (CC India)','National Centre for Information','Shiveshwarkar House','32, Parekh Street ','',142,NULL,17,0,'400004','',4,NULL,0,NULL),(1462,'1462','0000-00-00','The Librarian','The Abdus Salam ICTP Library','',' Strada Costlera 1134151 Trieste,','',0,NULL,0,14,'0','',5,NULL,0,NULL),(1463,'1463','0000-00-00','The Librarian','Central Library','(Madhyavarti Granthalaya)','Town Hall ','',142,NULL,17,0,'400002','',4,NULL,0,NULL),(1464,'1464','0000-00-00','Office of the Registrar of','Newspapers for India','Press Villa',' ','',198,NULL,9,0,'171001','',4,NULL,0,NULL),(1465,'1465','0000-00-00','Calcutta Mathematical Society','AE-374, Sector-1','Salt Lake City',' ','',116,NULL,30,0,'700064','',4,NULL,0,NULL),(1466,'1466','0000-00-00','The Director','Defence Scientific Information','adn Documentation Centre','Ministry of Defence (R & D Org.) Metcalfe House','',58,NULL,6,0,'110054','',4,NULL,0,NULL),(1467,'1467','0000-00-00','Prof. Henryk Ratajczak','Faculty of Chemistry','University of Wroclaw','14 F Joliot-Curie St. 50-383 Wroclaw','',0,NULL,0,21,'0','',5,NULL,0,NULL),(1468,'1468','0000-00-00','Mr Craig Emerson','CSA','Meteorological & Geoastrophysical','Abstracts 7200 Wisconsin Ave, Suite 601Bethesda, MD 20814','',0,NULL,0,30,'0','',5,NULL,0,NULL),(1469,'1469','0000-00-00','Ms. Sandra Rajiva','Indian Institute of Astrophysics','Sarjapur Road',' ','',28,NULL,13,0,'560034','',4,NULL,0,NULL),(1470,'1470','0000-00-00','The Under Secretary to the','Govt. of India','Dept. of Science & Technology','Technology Bhavan New Mehrauli Road','',156,NULL,6,0,'110016','',4,NULL,0,NULL),(1471,'1471','0000-00-00','Acquisitions Editor','Environment Abstracts','CIS','4520 East-West Highway BethesdaMD 20814-3389','',0,NULL,0,30,'0','',5,NULL,0,NULL),(1472,'1472','0000-00-00','Indian Mathematical Society Library','The Ramanujan Institute for','Advanced Study in Mathematics','University of Madras ','',50,NULL,26,0,'600005','',4,NULL,0,NULL),(1473,'1473','0000-00-00','Engineering Information INC','P.O.Box 543','',' 1000 AM Amsterdam','',0,NULL,0,18,'0','',5,NULL,0,NULL),(1474,'1474','0000-00-00','Materials Information Department','Cambridge Scientific Abastacts','Commerce Park IV, Suite 805','23240 Chagrin Boulevard BeachwoodOhio 44122','',0,NULL,0,30,'0','',5,NULL,0,NULL),(1475,'1475','0000-00-00','The Registrar','Attn: Mr P.V. Unnikrishnan','Integrated Rural Technology Centre','Mundur ','',161,NULL,14,0,'678592','',4,NULL,0,NULL),(1476,'1476','0000-00-00','Royal Nepal Academy of Science &','Technology','New Baneswar','GPO Box 3323 Kathmandu','',0,NULL,0,17,'0','',5,NULL,0,NULL),(1477,'1477','0000-00-00','Delivery of Books Act Division','Delhi Public Library','Sarojini Nagar','Near Main Market ','',156,NULL,6,0,'110023','',4,NULL,0,NULL),(1478,'1478','0000-00-00','Institute of Mathematics','Polish Academy of Sciences','Library - Exchange','P.O. Box 21 Ul. Sniadeckich 8PL-00-956 Warszawa 10','',0,NULL,0,21,'0','',5,NULL,0,NULL),(1479,'1479','0000-00-00','BIOSIS','Information Authority Department','Two Commerce Square','2001 Market St. Suite 700Philadelphia, PA 19103-1399','',0,NULL,0,30,'0','',5,NULL,0,NULL),(1480,'1480','0000-00-00','Prof. P.R. Parthasarathy','Regional Editor (Statistical Theory','and Methods Abstract)','Department of Mathematics Indian Institute of Technology','',50,NULL,26,0,'600036','',4,NULL,0,NULL),(1481,'1481','0000-00-00','Embassy of India','Baghdad (Iraq)','CARE OF DB SECTION','Ministry of External Affairs South Block','',156,NULL,6,0,'110011','',4,NULL,0,NULL),(1482,'1482','0000-00-00','Dipartimento di Matematics','Pura ed Applicate \'G.Vitali\'','Universit di Modena',' Via G.Campi, 213/BI-41100 Modena','',0,NULL,0,14,'0','',5,NULL,0,NULL),(1483,'1483','0000-00-00','Madhavan, Mr G.','Executive Secretary','Indian Academy of Sciences','C.V.Raman Avenue P.B. No.8005','',28,NULL,13,0,'560080','',4,NULL,0,NULL),(1484,'1484','0000-00-00','Athreya Prof. K B','c/o Phatak Prof. K N','Vice-Chancellor','Tezpur University ','',215,NULL,3,0,'784001','',4,NULL,0,NULL),(1485,'1485','0000-00-00','Shenoy Prof. S R             F.A.Sc','c/o Pathak A P','School of Physics','University of Hyderabad ','',87,NULL,1,0,'500134','',4,NULL,0,NULL),(1486,'1486','0000-00-00','National Informatics Centre','\'A\' Block','Kendriya Karyalya Parisar','Lodi Road ','',156,NULL,6,0,'110003','',4,NULL,0,NULL),(1487,'1487','0000-00-00','Prof. N Kumar','c/o Dr G V Vijayagovindan','School of Pure & Applied Physics','Mahatma Gandhi University Priyadarshini Hills P.O. Kottayam 686 ','',0,NULL,14,0,'586560','',4,NULL,0,NULL),(1488,'1488','0000-00-00','Samarnath Mishra Dr','Bibliographic Informatics Division','National Informatics Centre','A-Blcok C.G.O Complex, Lodi Road','',156,NULL,6,0,'110003','',4,NULL,0,NULL),(1489,'1489','0000-00-00','Marie-Annick Guillemer','Bibliotheque  IRMAR','Universit de Rennes I','UMR CNRS 6625 Campus de Beaulieu35042 Rennes Cedex','',0,NULL,0,10,'0','',5,NULL,0,NULL),(1490,'1490','0000-00-00','Shri Chander Parkash, Scientist F','(Ref:Indo-Myanmar Bi-Lateral Prgm)','Department of Science and Technolgy','Technology Bhawan New Mehrauli Road','',156,NULL,6,0,'110016','',4,NULL,0,NULL),(1491,'1491','0000-00-00','Indexing Copy- Serial Records Sec.','National Library of Medicine','Building 38,  Room B1W10','8600 Rockville Pike Bethesda, MD 20894','',0,NULL,0,30,'0','',5,NULL,0,NULL),(1492,'1492','0000-00-00','CS Exchange','Univerity of Oslo','Chemistry Library','P.O.B. 1033 Blindern 0315 Oslo','',0,NULL,0,19,'0','',5,NULL,0,NULL),(1493,'1493','0000-00-00','Mr R. Narasimhan','Krishtel eMaging Solutions Pvt.Ltd.','No. B-1, Ansary','39 (new) Madley Road T. Nagar','',50,NULL,26,0,'600017','',4,NULL,0,NULL),(1494,'1494','0000-00-00','','President','International Energy Initiative','25/5, Bore Bank Road Benson Town','',28,NULL,13,0,'560046','',4,NULL,0,NULL),(1495,'1495','0000-00-00','Prof. S.D. Nigam      FASc','266, Kapaleeswar Nagar','Neelangarai',' ','',50,NULL,26,0,'600041','',4,NULL,0,NULL),(1496,'1496','0000-00-00','Firest Secretary (Science & Tech.)','Embassy of India, Beijing','c/o Diplomatic Bag Section','Ministry of External Affairs South Block','',156,NULL,6,0,'110011','',4,NULL,0,NULL),(1497,'1497','0000-00-00','Honorary Secretary General','Muhammad Bin Qassim Library','4-Main Road','Sujawal District ThattaSindh 73050','',0,NULL,0,20,'0','',5,NULL,0,NULL),(1498,'1498','0000-00-00','Ms. Kandi Withers','Acquisitions Assistant','Petroleum Abstracts','The University of Tulsa 600 S, College Ave,Tulsa OK 74104-3189','',0,NULL,0,30,'0','',5,NULL,0,NULL),(1499,'1499','0000-00-00','MNHN Bibliotheque Centrale','Biblioteheque Centrale du Museum','',' 38 rue Geofforoy St Hilaire75005 Paris','',0,NULL,0,10,'0','',5,NULL,0,NULL),(1500,'1500','0000-00-00','Acquisition (Journals)','Barr Smith Library','','University of Adelaide Adelaide, SA 5004','',0,NULL,0,1,'0','',5,NULL,0,NULL),(1501,'1501','0000-00-00','Albert-Ludwigs-Universitat','Abteilung:Defernat Periodika','Erwerbung','Rempartstr. 10-16 79098  Freiburg i.Br','',0,NULL,0,11,'0','',5,NULL,0,NULL),(1502,'1502','0000-00-00','Offentliche Bibliothek Der','Universitat Basel','Erwerbung Zeitschriften','Schonbeinstrasse 18-20 CH 4056 Basel','',0,NULL,0,27,'0','',5,NULL,0,NULL),(1503,'1503','0000-00-00','Senior Technical Library Asst','Bibliographic Services','Mathematical Reviews','416 Fourth St., POB 8604 Ann Arbor, MI 48107-8604','',0,NULL,0,30,'0','',5,NULL,0,NULL),(1504,'1504','0000-00-00','Societe Scientifique','De Bruxelles','asbl','Rue De Bruxelles 61 D-5000 Namur','',0,NULL,0,2,'0','',5,NULL,0,NULL),(1505,'1505','0000-00-00','Societe Scientieique','De Bruxelles','','asbl Rud de Bruxelles 81B-5000 Namur','',0,NULL,0,2,'0','',5,NULL,0,NULL),(1506,'1506','0000-00-00','Bibliotheque Georges De Rham','Section De Mathematiques','Universite De Geneve','2-4 Rue Du Lievre Case Postale 641211 Geneve 4','',0,NULL,0,27,'0','',5,NULL,0,NULL),(1507,'1507','0000-00-00','A Griaznova','International Exchange Section','Russian National Public Library','for Science & Technology 12 Kuznetski mostMoscow','',0,NULL,0,22,'0','',5,NULL,0,NULL),(1508,'1508','0000-00-00','Ing. Linette Salvo S. MSc.','Universidad Del Biobio','Departamento Ingenieria en Maderas','Casilla 5-C Collao 1202Concepcion','',0,NULL,0,5,'0','',5,NULL,0,NULL),(1509,'1509','0000-00-00','Edith Jimenez Quintana','Canje - Biblioteca','Universidad Del Bio-Bio','Arda. Collao 1202 Concepcion','',0,NULL,0,5,'0','',5,NULL,0,NULL),(1510,'1510','0000-00-00','Hannele Pakarinen (Mrs)','Information Specialist','Exchange Centre for Scientific','Literature Mariankatu 5FI-00170 Helsinki','',0,NULL,0,9,'0','',5,NULL,0,NULL),(1511,'12H-S-00001','2012-08-04','Shailendra','','','Amethyst','Amethyst',28,NULL,13,12,'0','',11,NULL,0,NULL);
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
  `remarks` text,
  `legacy` tinyint(4) NOT NULL DEFAULT '0',
  `legacy_amount` float NOT NULL DEFAULT '0',
  `legacy_balance` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `subscription_idx_1` (`subscriberID`) USING BTREE,
  KEY `subscription_idx_4` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=1511 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription`
--

LOCK TABLES `subscription` WRITE;
/*!40000 ALTER TABLE `subscription` DISABLE KEYS */;
INSERT INTO `subscription` VALUES (1,2,0,1,'0000-00-00',NULL,1,0,0),(2,3,0,1,'0000-00-00',NULL,1,0,0),(3,4,0,1,'0000-00-00',NULL,1,0,0),(4,5,0,1,'0000-00-00',NULL,1,0,0),(5,6,0,1,'0000-00-00',NULL,1,0,0),(6,7,0,1,'0000-00-00',NULL,1,0,0),(7,8,0,1,'0000-00-00',NULL,1,0,0),(8,9,0,1,'0000-00-00',NULL,1,0,0),(9,10,0,1,'0000-00-00',NULL,1,0,0),(10,11,0,1,'0000-00-00',NULL,1,0,0),(11,12,0,1,'0000-00-00',NULL,1,0,0),(12,13,0,1,'0000-00-00',NULL,1,0,0),(13,14,0,1,'0000-00-00',NULL,1,0,0),(14,15,0,1,'0000-00-00',NULL,1,0,0),(15,16,0,1,'0000-00-00',NULL,1,0,0),(16,17,0,1,'0000-00-00',NULL,1,0,0),(17,18,0,1,'0000-00-00',NULL,1,0,0),(18,19,0,1,'0000-00-00',NULL,1,0,0),(19,20,0,1,'0000-00-00',NULL,1,0,0),(20,21,0,1,'0000-00-00',NULL,1,0,0),(21,22,0,1,'0000-00-00',NULL,1,0,0),(22,23,0,1,'0000-00-00',NULL,1,0,0),(23,24,0,1,'0000-00-00',NULL,1,0,0),(24,25,0,1,'0000-00-00',NULL,1,0,0),(25,26,0,1,'0000-00-00',NULL,1,0,0),(26,27,0,1,'0000-00-00',NULL,1,0,0),(27,28,0,1,'0000-00-00',NULL,1,0,0),(28,29,0,1,'0000-00-00',NULL,1,0,0),(29,30,0,1,'0000-00-00',NULL,1,0,0),(30,31,0,1,'0000-00-00',NULL,1,0,0),(31,32,0,1,'0000-00-00',NULL,1,0,0),(32,33,0,1,'0000-00-00',NULL,1,0,0),(33,34,0,1,'0000-00-00',NULL,1,0,0),(34,35,0,1,'0000-00-00',NULL,1,0,0),(35,36,0,1,'0000-00-00',NULL,1,0,0),(36,37,0,1,'0000-00-00',NULL,1,0,0),(37,38,0,1,'0000-00-00',NULL,1,0,0),(38,39,0,1,'0000-00-00',NULL,1,0,0),(39,40,0,1,'0000-00-00',NULL,1,0,0),(40,41,0,1,'0000-00-00',NULL,1,0,0),(41,42,0,1,'0000-00-00',NULL,1,0,0),(42,43,0,1,'0000-00-00',NULL,1,0,0),(43,44,0,1,'0000-00-00',NULL,1,0,0),(44,45,0,1,'0000-00-00',NULL,1,0,0),(45,46,0,1,'0000-00-00',NULL,1,0,0),(46,47,0,1,'0000-00-00',NULL,1,0,0),(47,48,0,1,'0000-00-00',NULL,1,0,0),(48,49,0,1,'0000-00-00',NULL,1,0,0),(49,50,0,1,'0000-00-00',NULL,1,0,0),(50,51,0,1,'0000-00-00',NULL,1,0,0),(51,52,0,1,'0000-00-00',NULL,1,0,0),(52,53,0,1,'0000-00-00',NULL,1,0,0),(53,54,0,1,'0000-00-00',NULL,1,0,0),(54,55,0,1,'0000-00-00',NULL,1,0,0),(55,56,0,1,'0000-00-00',NULL,1,0,0),(56,57,0,1,'0000-00-00',NULL,1,0,0),(57,58,0,1,'0000-00-00',NULL,1,0,0),(58,59,0,1,'0000-00-00',NULL,1,0,0),(59,60,0,1,'0000-00-00',NULL,1,0,0),(60,61,0,1,'0000-00-00',NULL,1,0,0),(61,62,0,1,'0000-00-00',NULL,1,0,0),(62,63,0,1,'0000-00-00',NULL,1,0,0),(63,64,0,1,'0000-00-00',NULL,1,0,0),(64,65,0,1,'0000-00-00',NULL,1,0,0),(65,66,0,1,'0000-00-00',NULL,1,0,0),(66,67,0,1,'0000-00-00',NULL,1,0,0),(67,68,0,1,'0000-00-00',NULL,1,0,0),(68,69,0,1,'0000-00-00',NULL,1,0,0),(69,70,0,1,'0000-00-00',NULL,1,0,0),(70,71,0,1,'0000-00-00',NULL,1,0,0),(71,72,0,1,'0000-00-00',NULL,1,0,0),(72,73,0,1,'0000-00-00',NULL,1,0,0),(73,74,0,1,'0000-00-00',NULL,1,0,0),(74,75,0,1,'0000-00-00',NULL,1,0,0),(75,76,0,1,'0000-00-00',NULL,1,0,0),(76,77,0,1,'0000-00-00',NULL,1,0,0),(77,78,0,1,'0000-00-00',NULL,1,0,0),(78,79,0,1,'0000-00-00',NULL,1,0,0),(79,80,0,1,'0000-00-00',NULL,1,0,0),(80,81,0,1,'0000-00-00',NULL,1,0,0),(81,82,0,1,'0000-00-00',NULL,1,0,0),(82,83,0,1,'0000-00-00',NULL,1,0,0),(83,84,0,1,'0000-00-00',NULL,1,0,0),(84,85,0,1,'0000-00-00',NULL,1,0,0),(85,86,0,1,'0000-00-00',NULL,1,0,0),(86,87,0,1,'0000-00-00',NULL,1,0,0),(87,88,0,1,'0000-00-00',NULL,1,0,0),(88,89,0,1,'0000-00-00',NULL,1,0,0),(89,90,0,1,'0000-00-00',NULL,1,0,0),(90,91,0,1,'0000-00-00',NULL,1,0,0),(91,92,0,1,'0000-00-00',NULL,1,0,0),(92,93,0,1,'0000-00-00',NULL,1,0,0),(93,94,0,1,'0000-00-00',NULL,1,0,0),(94,95,0,1,'0000-00-00',NULL,1,0,0),(95,96,0,1,'0000-00-00',NULL,1,0,0),(96,97,0,1,'0000-00-00',NULL,1,0,0),(97,98,0,1,'0000-00-00',NULL,1,0,0),(98,99,0,1,'0000-00-00',NULL,1,0,0),(99,100,0,1,'0000-00-00',NULL,1,0,0),(100,101,0,1,'0000-00-00',NULL,1,0,0),(101,102,0,1,'0000-00-00',NULL,1,0,0),(102,103,0,1,'0000-00-00',NULL,1,0,0),(103,104,0,1,'0000-00-00',NULL,1,0,0),(104,105,0,1,'0000-00-00',NULL,1,0,0),(105,106,0,1,'0000-00-00',NULL,1,0,0),(106,107,0,1,'0000-00-00',NULL,1,0,0),(107,108,0,1,'0000-00-00',NULL,1,0,0),(108,109,0,1,'0000-00-00',NULL,1,0,0),(109,110,0,1,'0000-00-00',NULL,1,0,0),(110,111,0,1,'0000-00-00',NULL,1,0,0),(111,112,0,1,'0000-00-00',NULL,1,0,0),(112,113,0,1,'0000-00-00',NULL,1,0,0),(113,114,0,1,'0000-00-00',NULL,1,0,0),(114,115,0,1,'0000-00-00',NULL,1,0,0),(115,116,0,1,'0000-00-00',NULL,1,0,0),(116,117,0,1,'0000-00-00',NULL,1,0,0),(117,118,0,1,'0000-00-00',NULL,1,0,0),(118,119,0,1,'0000-00-00',NULL,1,0,0),(119,120,0,1,'0000-00-00',NULL,1,0,0),(120,121,0,1,'0000-00-00',NULL,1,0,0),(121,122,0,1,'0000-00-00',NULL,1,0,0),(122,123,0,1,'0000-00-00',NULL,1,0,0),(123,124,0,1,'0000-00-00',NULL,1,0,0),(124,125,0,1,'0000-00-00',NULL,1,0,0),(125,126,0,1,'0000-00-00',NULL,1,0,0),(126,127,0,1,'0000-00-00',NULL,1,0,0),(127,128,0,1,'0000-00-00',NULL,1,0,0),(128,129,0,1,'0000-00-00',NULL,1,0,0),(129,130,0,1,'0000-00-00',NULL,1,0,0),(130,131,0,1,'0000-00-00',NULL,1,0,0),(131,132,0,1,'0000-00-00',NULL,1,0,0),(132,133,0,1,'0000-00-00',NULL,1,0,0),(133,134,0,1,'0000-00-00',NULL,1,0,0),(134,135,0,1,'0000-00-00',NULL,1,0,0),(135,136,0,1,'0000-00-00',NULL,1,0,0),(136,137,0,1,'0000-00-00',NULL,1,0,0),(137,138,0,1,'0000-00-00',NULL,1,0,0),(138,139,0,1,'0000-00-00',NULL,1,0,0),(139,140,0,1,'0000-00-00',NULL,1,0,0),(140,141,0,1,'0000-00-00',NULL,1,0,0),(141,142,0,1,'0000-00-00',NULL,1,0,0),(142,143,0,1,'0000-00-00',NULL,1,0,0),(143,144,0,1,'0000-00-00',NULL,1,0,0),(144,145,0,1,'0000-00-00',NULL,1,0,0),(145,146,0,1,'0000-00-00',NULL,1,0,0),(146,147,0,1,'0000-00-00',NULL,1,0,0),(147,148,0,1,'0000-00-00',NULL,1,0,0),(148,149,0,1,'0000-00-00',NULL,1,0,0),(149,150,0,1,'0000-00-00',NULL,1,0,0),(150,151,0,1,'0000-00-00',NULL,1,0,0),(151,152,0,1,'0000-00-00',NULL,1,0,0),(152,153,0,1,'0000-00-00',NULL,1,0,0),(153,154,0,1,'0000-00-00',NULL,1,0,0),(154,155,0,1,'0000-00-00',NULL,1,0,0),(155,156,0,1,'0000-00-00',NULL,1,0,0),(156,157,0,1,'0000-00-00',NULL,1,0,0),(157,158,0,1,'0000-00-00',NULL,1,0,0),(158,159,0,1,'0000-00-00',NULL,1,0,0),(159,160,0,1,'0000-00-00',NULL,1,0,0),(160,161,0,1,'0000-00-00',NULL,1,0,0),(161,162,0,1,'0000-00-00',NULL,1,0,0),(162,163,0,1,'0000-00-00',NULL,1,0,0),(163,164,0,1,'0000-00-00',NULL,1,0,0),(164,165,0,1,'0000-00-00',NULL,1,0,0),(165,166,0,1,'0000-00-00',NULL,1,0,0),(166,167,0,1,'0000-00-00',NULL,1,0,0),(167,168,0,1,'0000-00-00',NULL,1,0,0),(168,169,0,1,'0000-00-00',NULL,1,0,0),(169,170,0,1,'0000-00-00',NULL,1,0,0),(170,171,0,1,'0000-00-00',NULL,1,0,0),(171,172,0,1,'0000-00-00',NULL,1,0,0),(172,173,0,1,'0000-00-00',NULL,1,0,0),(173,174,0,1,'0000-00-00',NULL,1,0,0),(174,175,0,1,'0000-00-00',NULL,1,0,0),(175,176,0,1,'0000-00-00',NULL,1,0,0),(176,177,0,1,'0000-00-00',NULL,1,0,0),(177,178,0,1,'0000-00-00',NULL,1,0,0),(178,179,0,1,'0000-00-00',NULL,1,0,0),(179,180,0,1,'0000-00-00',NULL,1,0,0),(180,181,0,1,'0000-00-00',NULL,1,0,0),(181,182,0,1,'0000-00-00',NULL,1,0,0),(182,183,0,1,'0000-00-00',NULL,1,0,0),(183,184,0,1,'0000-00-00',NULL,1,0,0),(184,185,0,1,'0000-00-00',NULL,1,0,0),(185,186,0,1,'0000-00-00',NULL,1,0,0),(186,187,0,1,'0000-00-00',NULL,1,0,0),(187,188,0,1,'0000-00-00',NULL,1,0,0),(188,189,0,1,'0000-00-00',NULL,1,0,0),(189,190,0,1,'0000-00-00',NULL,1,0,0),(190,191,0,1,'0000-00-00',NULL,1,0,0),(191,192,0,1,'0000-00-00',NULL,1,0,0),(192,193,0,1,'0000-00-00',NULL,1,0,0),(193,194,0,1,'0000-00-00',NULL,1,0,0),(194,195,0,1,'0000-00-00',NULL,1,0,0),(195,196,0,1,'0000-00-00',NULL,1,0,0),(196,197,0,1,'0000-00-00',NULL,1,0,0),(197,198,0,1,'0000-00-00',NULL,1,0,0),(198,199,0,1,'0000-00-00',NULL,1,0,0),(199,200,0,1,'0000-00-00',NULL,1,0,0),(200,201,0,1,'0000-00-00',NULL,1,0,0),(201,202,0,1,'0000-00-00',NULL,1,0,0),(202,203,0,1,'0000-00-00',NULL,1,0,0),(203,204,0,1,'0000-00-00',NULL,1,0,0),(204,205,0,1,'0000-00-00',NULL,1,0,0),(205,206,0,1,'0000-00-00',NULL,1,0,0),(206,207,0,1,'0000-00-00',NULL,1,0,0),(207,208,0,1,'0000-00-00',NULL,1,0,0),(208,209,0,1,'0000-00-00',NULL,1,0,0),(209,210,0,1,'0000-00-00',NULL,1,0,0),(210,211,0,1,'0000-00-00',NULL,1,0,0),(211,212,0,1,'0000-00-00',NULL,1,0,0),(212,213,0,1,'0000-00-00',NULL,1,0,0),(213,214,0,1,'0000-00-00',NULL,1,0,0),(214,215,0,1,'0000-00-00',NULL,1,0,0),(215,216,0,1,'0000-00-00',NULL,1,0,0),(216,217,0,1,'0000-00-00',NULL,1,0,0),(217,218,0,1,'0000-00-00',NULL,1,0,0),(218,219,0,1,'0000-00-00',NULL,1,0,0),(219,220,0,1,'0000-00-00',NULL,1,0,0),(220,221,0,1,'0000-00-00',NULL,1,0,0),(221,222,0,1,'0000-00-00',NULL,1,0,0),(222,223,0,1,'0000-00-00',NULL,1,0,0),(223,224,0,1,'0000-00-00',NULL,1,0,0),(224,225,0,1,'0000-00-00',NULL,1,0,0),(225,226,0,1,'0000-00-00',NULL,1,0,0),(226,227,0,1,'0000-00-00',NULL,1,0,0),(227,228,0,1,'0000-00-00',NULL,1,0,0),(228,229,0,1,'0000-00-00',NULL,1,0,0),(229,230,0,1,'0000-00-00',NULL,1,0,0),(230,231,0,1,'0000-00-00',NULL,1,0,0),(231,232,0,1,'0000-00-00',NULL,1,0,0),(232,233,0,1,'0000-00-00',NULL,1,0,0),(233,234,0,1,'0000-00-00',NULL,1,0,0),(234,235,0,1,'0000-00-00',NULL,1,0,0),(235,236,0,1,'0000-00-00',NULL,1,0,0),(236,237,0,1,'0000-00-00',NULL,1,0,0),(237,238,0,1,'0000-00-00',NULL,1,0,0),(238,239,0,1,'0000-00-00',NULL,1,0,0),(239,240,0,1,'0000-00-00',NULL,1,0,0),(240,241,0,1,'0000-00-00',NULL,1,0,0),(241,242,0,1,'0000-00-00',NULL,1,0,0),(242,243,0,1,'0000-00-00',NULL,1,0,0),(243,244,0,1,'0000-00-00',NULL,1,0,0),(244,245,0,1,'0000-00-00',NULL,1,0,0),(245,246,0,1,'0000-00-00',NULL,1,0,0),(246,247,0,1,'0000-00-00',NULL,1,0,0),(247,248,0,1,'0000-00-00',NULL,1,0,0),(248,249,0,1,'0000-00-00',NULL,1,0,0),(249,250,0,1,'0000-00-00',NULL,1,0,0),(250,251,0,1,'0000-00-00',NULL,1,0,0),(251,252,0,1,'0000-00-00',NULL,1,0,0),(252,253,0,1,'0000-00-00',NULL,1,0,0),(253,254,0,1,'0000-00-00',NULL,1,0,0),(254,255,0,1,'0000-00-00',NULL,1,0,0),(255,256,0,1,'0000-00-00',NULL,1,0,0),(256,257,0,1,'0000-00-00',NULL,1,0,0),(257,258,0,1,'0000-00-00',NULL,1,0,0),(258,259,0,1,'0000-00-00',NULL,1,0,0),(259,260,0,1,'0000-00-00',NULL,1,0,0),(260,261,0,1,'0000-00-00',NULL,1,0,0),(261,262,0,1,'0000-00-00',NULL,1,0,0),(262,263,0,1,'0000-00-00',NULL,1,0,0),(263,264,0,1,'0000-00-00',NULL,1,0,0),(264,265,0,1,'0000-00-00',NULL,1,0,0),(265,266,0,1,'0000-00-00',NULL,1,0,0),(266,267,0,1,'0000-00-00',NULL,1,0,0),(267,268,0,1,'0000-00-00',NULL,1,0,0),(268,269,0,1,'0000-00-00',NULL,1,0,0),(269,270,0,1,'0000-00-00',NULL,1,0,0),(270,271,0,1,'0000-00-00',NULL,1,0,0),(271,272,0,1,'0000-00-00',NULL,1,0,0),(272,273,0,1,'0000-00-00',NULL,1,0,0),(273,274,0,1,'0000-00-00',NULL,1,0,0),(274,275,0,1,'0000-00-00',NULL,1,0,0),(275,276,0,1,'0000-00-00',NULL,1,0,0),(276,277,0,1,'0000-00-00',NULL,1,0,0),(277,278,0,1,'0000-00-00',NULL,1,0,0),(278,279,0,1,'0000-00-00',NULL,1,0,0),(279,280,0,1,'0000-00-00',NULL,1,0,0),(280,281,0,1,'0000-00-00',NULL,1,0,0),(281,282,0,1,'0000-00-00',NULL,1,0,0),(282,283,0,1,'0000-00-00',NULL,1,0,0),(283,284,0,1,'0000-00-00',NULL,1,0,0),(284,285,0,1,'0000-00-00',NULL,1,0,0),(285,286,0,1,'0000-00-00',NULL,1,0,0),(286,287,0,1,'0000-00-00',NULL,1,0,0),(287,288,0,1,'0000-00-00',NULL,1,0,0),(288,289,0,1,'0000-00-00',NULL,1,0,0),(289,290,0,1,'0000-00-00',NULL,1,0,0),(290,291,0,1,'0000-00-00',NULL,1,0,0),(291,292,0,1,'0000-00-00',NULL,1,0,0),(292,293,0,1,'0000-00-00',NULL,1,0,0),(293,294,0,1,'0000-00-00',NULL,1,0,0),(294,295,0,1,'0000-00-00',NULL,1,0,0),(295,296,0,1,'0000-00-00',NULL,1,0,0),(296,297,0,1,'0000-00-00',NULL,1,0,0),(297,298,0,1,'0000-00-00',NULL,1,0,0),(298,299,0,1,'0000-00-00',NULL,1,0,0),(299,300,0,1,'0000-00-00',NULL,1,0,0),(300,301,0,1,'0000-00-00',NULL,1,0,0),(301,302,0,1,'0000-00-00',NULL,1,0,0),(302,303,0,1,'0000-00-00',NULL,1,0,0),(303,304,0,1,'0000-00-00',NULL,1,0,0),(304,305,0,1,'0000-00-00',NULL,1,0,0),(305,306,0,1,'0000-00-00',NULL,1,0,0),(306,307,0,1,'0000-00-00',NULL,1,0,0),(307,308,0,1,'0000-00-00',NULL,1,0,0),(308,309,0,1,'0000-00-00',NULL,1,0,0),(309,310,0,1,'0000-00-00',NULL,1,0,0),(310,311,0,1,'0000-00-00',NULL,1,0,0),(311,312,0,1,'0000-00-00',NULL,1,0,0),(312,313,0,1,'0000-00-00',NULL,1,0,0),(313,314,0,1,'0000-00-00',NULL,1,0,0),(314,315,0,1,'0000-00-00',NULL,1,0,0),(315,316,0,1,'0000-00-00',NULL,1,0,0),(316,317,0,1,'0000-00-00',NULL,1,0,0),(317,318,0,1,'0000-00-00',NULL,1,0,0),(318,319,0,1,'0000-00-00',NULL,1,0,0),(319,320,0,1,'0000-00-00',NULL,1,0,0),(320,321,0,1,'0000-00-00',NULL,1,0,0),(321,322,0,1,'0000-00-00',NULL,1,0,0),(322,323,0,1,'0000-00-00',NULL,1,0,0),(323,324,0,1,'0000-00-00',NULL,1,0,0),(324,325,0,1,'0000-00-00',NULL,1,0,0),(325,326,0,1,'0000-00-00',NULL,1,0,0),(326,327,0,1,'0000-00-00',NULL,1,0,0),(327,328,0,1,'0000-00-00',NULL,1,0,0),(328,329,0,1,'0000-00-00',NULL,1,0,0),(329,330,0,1,'0000-00-00',NULL,1,0,0),(330,331,0,1,'0000-00-00',NULL,1,0,0),(331,332,0,1,'0000-00-00',NULL,1,0,0),(332,333,0,1,'0000-00-00',NULL,1,0,0),(333,334,0,1,'0000-00-00',NULL,1,0,0),(334,335,0,1,'0000-00-00',NULL,1,0,0),(335,336,0,1,'0000-00-00',NULL,1,0,0),(336,337,0,1,'0000-00-00',NULL,1,0,0),(337,338,0,1,'0000-00-00',NULL,1,0,0),(338,339,0,1,'0000-00-00',NULL,1,0,0),(339,340,0,1,'0000-00-00',NULL,1,0,0),(340,341,0,1,'0000-00-00',NULL,1,0,0),(341,342,0,1,'0000-00-00',NULL,1,0,0),(342,343,0,1,'0000-00-00',NULL,1,0,0),(343,344,0,1,'0000-00-00',NULL,1,0,0),(344,345,0,1,'0000-00-00',NULL,1,0,0),(345,346,0,1,'0000-00-00',NULL,1,0,0),(346,347,0,1,'0000-00-00',NULL,1,0,0),(347,348,0,1,'0000-00-00',NULL,1,0,0),(348,349,0,1,'0000-00-00',NULL,1,0,0),(349,350,0,1,'0000-00-00',NULL,1,0,0),(350,351,0,1,'0000-00-00',NULL,1,0,0),(351,352,0,1,'0000-00-00',NULL,1,0,0),(352,353,0,1,'0000-00-00',NULL,1,0,0),(353,354,0,1,'0000-00-00',NULL,1,0,0),(354,355,0,1,'0000-00-00',NULL,1,0,0),(355,356,0,1,'0000-00-00',NULL,1,0,0),(356,357,0,1,'0000-00-00',NULL,1,0,0),(357,358,0,1,'0000-00-00',NULL,1,0,0),(358,359,0,1,'0000-00-00',NULL,1,0,0),(359,360,0,1,'0000-00-00',NULL,1,0,0),(360,361,0,1,'0000-00-00',NULL,1,0,0),(361,362,0,1,'0000-00-00',NULL,1,0,0),(362,363,0,1,'0000-00-00',NULL,1,0,0),(363,364,0,1,'0000-00-00',NULL,1,0,0),(364,365,0,1,'0000-00-00',NULL,1,0,0),(365,366,0,1,'0000-00-00',NULL,1,0,0),(366,367,0,1,'0000-00-00',NULL,1,0,0),(367,368,0,1,'0000-00-00',NULL,1,0,0),(368,369,0,1,'0000-00-00',NULL,1,0,0),(369,370,0,1,'0000-00-00',NULL,1,0,0),(370,371,0,1,'0000-00-00',NULL,1,0,0),(371,372,0,1,'0000-00-00',NULL,1,0,0),(372,373,0,1,'0000-00-00',NULL,1,0,0),(373,374,0,1,'0000-00-00',NULL,1,0,0),(374,375,0,1,'0000-00-00',NULL,1,0,0),(375,376,0,1,'0000-00-00',NULL,1,0,0),(376,377,0,1,'0000-00-00',NULL,1,0,0),(377,378,0,1,'0000-00-00',NULL,1,0,0),(378,379,0,1,'0000-00-00',NULL,1,0,0),(379,380,0,1,'0000-00-00',NULL,1,0,0),(380,381,0,1,'0000-00-00',NULL,1,0,0),(381,382,0,1,'0000-00-00',NULL,1,0,0),(382,383,0,1,'0000-00-00',NULL,1,0,0),(383,384,0,1,'0000-00-00',NULL,1,0,0),(384,385,0,1,'0000-00-00',NULL,1,0,0),(385,386,0,1,'0000-00-00',NULL,1,0,0),(386,387,0,1,'0000-00-00',NULL,1,0,0),(387,388,0,1,'0000-00-00',NULL,1,0,0),(388,389,0,1,'0000-00-00',NULL,1,0,0),(389,390,0,1,'0000-00-00',NULL,1,0,0),(390,391,0,1,'0000-00-00',NULL,1,0,0),(391,392,0,1,'0000-00-00',NULL,1,0,0),(392,393,0,1,'0000-00-00',NULL,1,0,0),(393,394,0,1,'0000-00-00',NULL,1,0,0),(394,395,0,1,'0000-00-00',NULL,1,0,0),(395,396,0,1,'0000-00-00',NULL,1,0,0),(396,397,0,1,'0000-00-00',NULL,1,0,0),(397,398,0,1,'0000-00-00',NULL,1,0,0),(398,399,0,1,'0000-00-00',NULL,1,0,0),(399,400,0,1,'0000-00-00',NULL,1,0,0),(400,401,0,1,'0000-00-00',NULL,1,0,0),(401,402,0,1,'0000-00-00',NULL,1,0,0),(402,403,0,1,'0000-00-00',NULL,1,0,0),(403,404,0,1,'0000-00-00',NULL,1,0,0),(404,405,0,1,'0000-00-00',NULL,1,0,0),(405,406,0,1,'0000-00-00',NULL,1,0,0),(406,407,0,1,'0000-00-00',NULL,1,0,0),(407,408,0,1,'0000-00-00',NULL,1,0,0),(408,409,0,1,'0000-00-00',NULL,1,0,0),(409,410,0,1,'0000-00-00',NULL,1,0,0),(410,411,0,1,'0000-00-00',NULL,1,0,0),(411,412,0,1,'0000-00-00',NULL,1,0,0),(412,413,0,1,'0000-00-00',NULL,1,0,0),(413,414,0,1,'0000-00-00',NULL,1,0,0),(414,415,0,1,'0000-00-00',NULL,1,0,0),(415,416,0,1,'0000-00-00',NULL,1,0,0),(416,417,0,1,'0000-00-00',NULL,1,0,0),(417,418,0,1,'0000-00-00',NULL,1,0,0),(418,419,0,1,'0000-00-00',NULL,1,0,0),(419,420,0,1,'0000-00-00',NULL,1,0,0),(420,421,0,1,'0000-00-00',NULL,1,0,0),(421,422,0,1,'0000-00-00',NULL,1,0,0),(422,423,0,1,'0000-00-00',NULL,1,0,0),(423,424,0,1,'0000-00-00',NULL,1,0,0),(424,425,0,1,'0000-00-00',NULL,1,0,0),(425,426,0,1,'0000-00-00',NULL,1,0,0),(426,427,0,1,'0000-00-00',NULL,1,0,0),(427,428,0,1,'0000-00-00',NULL,1,0,0),(428,429,0,1,'0000-00-00',NULL,1,0,0),(429,430,0,1,'0000-00-00',NULL,1,0,0),(430,431,0,1,'0000-00-00',NULL,1,0,0),(431,432,0,1,'0000-00-00',NULL,1,0,0),(432,433,0,1,'0000-00-00',NULL,1,0,0),(433,434,0,1,'0000-00-00',NULL,1,0,0),(434,435,0,1,'0000-00-00',NULL,1,0,0),(435,436,0,1,'0000-00-00',NULL,1,0,0),(436,437,0,1,'0000-00-00',NULL,1,0,0),(437,438,0,1,'0000-00-00',NULL,1,0,0),(438,439,0,1,'0000-00-00',NULL,1,0,0),(439,440,0,1,'0000-00-00',NULL,1,0,0),(440,441,0,1,'0000-00-00',NULL,1,0,0),(441,442,0,1,'0000-00-00',NULL,1,0,0),(442,443,0,1,'0000-00-00',NULL,1,0,0),(443,444,0,1,'0000-00-00',NULL,1,0,0),(444,445,0,1,'0000-00-00',NULL,1,0,0),(445,446,0,1,'0000-00-00',NULL,1,0,0),(446,447,0,1,'0000-00-00',NULL,1,0,0),(447,448,0,1,'0000-00-00',NULL,1,0,0),(448,449,0,1,'0000-00-00',NULL,1,0,0),(449,450,0,1,'0000-00-00',NULL,1,0,0),(450,451,0,1,'0000-00-00',NULL,1,0,0),(451,452,0,1,'0000-00-00',NULL,1,0,0),(452,453,0,1,'0000-00-00',NULL,1,0,0),(453,454,0,1,'0000-00-00',NULL,1,0,0),(454,455,0,1,'0000-00-00',NULL,1,0,0),(455,456,0,1,'0000-00-00',NULL,1,0,0),(456,457,0,1,'0000-00-00',NULL,1,0,0),(457,458,0,1,'0000-00-00',NULL,1,0,0),(458,459,0,1,'0000-00-00',NULL,1,0,0),(459,460,0,1,'0000-00-00',NULL,1,0,0),(460,461,0,1,'0000-00-00',NULL,1,0,0),(461,462,0,1,'0000-00-00',NULL,1,0,0),(462,463,0,1,'0000-00-00',NULL,1,0,0),(463,464,0,1,'0000-00-00',NULL,1,0,0),(464,465,0,1,'0000-00-00',NULL,1,0,0),(465,466,0,1,'0000-00-00',NULL,1,0,0),(466,467,0,1,'0000-00-00',NULL,1,0,0),(467,468,0,1,'0000-00-00',NULL,1,0,0),(468,469,0,1,'0000-00-00',NULL,1,0,0),(469,470,0,1,'0000-00-00',NULL,1,0,0),(470,471,0,1,'0000-00-00',NULL,1,0,0),(471,472,0,1,'0000-00-00',NULL,1,0,0),(472,473,0,1,'0000-00-00',NULL,1,0,0),(473,474,0,1,'0000-00-00',NULL,1,0,0),(474,475,0,1,'0000-00-00',NULL,1,0,0),(475,476,0,1,'0000-00-00',NULL,1,0,0),(476,477,0,1,'0000-00-00',NULL,1,0,0),(477,478,0,1,'0000-00-00',NULL,1,0,0),(478,479,0,1,'0000-00-00',NULL,1,0,0),(479,480,0,1,'0000-00-00',NULL,1,0,0),(480,481,0,1,'0000-00-00',NULL,1,0,0),(481,482,0,1,'0000-00-00',NULL,1,0,0),(482,483,0,1,'0000-00-00',NULL,1,0,0),(483,484,0,1,'0000-00-00',NULL,1,0,0),(484,485,0,1,'0000-00-00',NULL,1,0,0),(485,486,0,1,'0000-00-00',NULL,1,0,0),(486,487,0,1,'0000-00-00',NULL,1,0,0),(487,488,0,1,'0000-00-00',NULL,1,0,0),(488,489,0,1,'0000-00-00',NULL,1,0,0),(489,490,0,1,'0000-00-00',NULL,1,0,0),(490,491,0,1,'0000-00-00',NULL,1,0,0),(491,492,0,1,'0000-00-00',NULL,1,0,0),(492,493,0,1,'0000-00-00',NULL,1,0,0),(493,494,0,1,'0000-00-00',NULL,1,0,0),(494,495,0,1,'0000-00-00',NULL,1,0,0),(495,496,0,1,'0000-00-00',NULL,1,0,0),(496,497,0,1,'0000-00-00',NULL,1,0,0),(497,498,0,1,'0000-00-00',NULL,1,0,0),(498,499,0,1,'0000-00-00',NULL,1,0,0),(499,500,0,1,'0000-00-00',NULL,1,0,0),(500,501,0,1,'0000-00-00',NULL,1,0,0),(501,502,0,1,'0000-00-00',NULL,1,0,0),(502,503,0,1,'0000-00-00',NULL,1,0,0),(503,504,0,1,'0000-00-00',NULL,1,0,0),(504,505,0,1,'0000-00-00',NULL,1,0,0),(505,506,0,1,'0000-00-00',NULL,1,0,0),(506,507,0,1,'0000-00-00',NULL,1,0,0),(507,508,0,1,'0000-00-00',NULL,1,0,0),(508,509,0,1,'0000-00-00',NULL,1,0,0),(509,510,0,1,'0000-00-00',NULL,1,0,0),(510,511,0,1,'0000-00-00',NULL,1,0,0),(511,512,0,1,'0000-00-00',NULL,1,0,0),(512,513,0,1,'0000-00-00',NULL,1,0,0),(513,514,0,1,'0000-00-00',NULL,1,0,0),(514,515,0,1,'0000-00-00',NULL,1,0,0),(515,516,0,1,'0000-00-00',NULL,1,0,0),(516,517,0,1,'0000-00-00',NULL,1,0,0),(517,518,0,1,'0000-00-00',NULL,1,0,0),(518,519,0,1,'0000-00-00',NULL,1,0,0),(519,520,0,1,'0000-00-00',NULL,1,0,0),(520,521,0,1,'0000-00-00',NULL,1,0,0),(521,522,0,1,'0000-00-00',NULL,1,0,0),(522,523,0,1,'0000-00-00',NULL,1,0,0),(523,524,0,1,'0000-00-00',NULL,1,0,0),(524,525,0,1,'0000-00-00',NULL,1,0,0),(525,526,0,1,'0000-00-00',NULL,1,0,0),(526,527,0,1,'0000-00-00',NULL,1,0,0),(527,528,0,1,'0000-00-00',NULL,1,0,0),(528,529,0,1,'0000-00-00',NULL,1,0,0),(529,530,0,1,'0000-00-00',NULL,1,0,0),(530,531,0,1,'0000-00-00',NULL,1,0,0),(531,532,0,1,'0000-00-00',NULL,1,0,0),(532,533,0,1,'0000-00-00',NULL,1,0,0),(533,534,0,1,'0000-00-00',NULL,1,0,0),(534,535,0,1,'0000-00-00',NULL,1,0,0),(535,536,0,1,'0000-00-00',NULL,1,0,0),(536,537,0,1,'0000-00-00',NULL,1,0,0),(537,538,0,1,'0000-00-00',NULL,1,0,0),(538,539,0,1,'0000-00-00',NULL,1,0,0),(539,540,0,1,'0000-00-00',NULL,1,0,0),(540,541,0,1,'0000-00-00',NULL,1,0,0),(541,542,0,1,'0000-00-00',NULL,1,0,0),(542,543,0,1,'0000-00-00',NULL,1,0,0),(543,544,0,1,'0000-00-00',NULL,1,0,0),(544,545,0,1,'0000-00-00',NULL,1,0,0),(545,546,0,1,'0000-00-00',NULL,1,0,0),(546,547,0,1,'0000-00-00',NULL,1,0,0),(547,548,0,1,'0000-00-00',NULL,1,0,0),(548,549,0,1,'0000-00-00',NULL,1,0,0),(549,550,0,1,'0000-00-00',NULL,1,0,0),(550,551,0,1,'0000-00-00',NULL,1,0,0),(551,552,0,1,'0000-00-00',NULL,1,0,0),(552,553,0,1,'0000-00-00',NULL,1,0,0),(553,554,0,1,'0000-00-00',NULL,1,0,0),(554,555,0,1,'0000-00-00',NULL,1,0,0),(555,556,0,1,'0000-00-00',NULL,1,0,0),(556,557,0,1,'0000-00-00',NULL,1,0,0),(557,558,0,1,'0000-00-00',NULL,1,0,0),(558,559,0,1,'0000-00-00',NULL,1,0,0),(559,560,0,1,'0000-00-00',NULL,1,0,0),(560,561,0,1,'0000-00-00',NULL,1,0,0),(561,562,0,1,'0000-00-00',NULL,1,0,0),(562,563,0,1,'0000-00-00',NULL,1,0,0),(563,564,0,1,'0000-00-00',NULL,1,0,0),(564,565,0,1,'0000-00-00',NULL,1,0,0),(565,566,0,1,'0000-00-00',NULL,1,0,0),(566,567,0,1,'0000-00-00',NULL,1,0,0),(567,568,0,1,'0000-00-00',NULL,1,0,0),(568,569,0,1,'0000-00-00',NULL,1,0,0),(569,570,0,1,'0000-00-00',NULL,1,0,0),(570,571,0,1,'0000-00-00',NULL,1,0,0),(571,572,0,1,'0000-00-00',NULL,1,0,0),(572,573,0,1,'0000-00-00',NULL,1,0,0),(573,574,0,1,'0000-00-00',NULL,1,0,0),(574,575,0,1,'0000-00-00',NULL,1,0,0),(575,576,0,1,'0000-00-00',NULL,1,0,0),(576,577,0,1,'0000-00-00',NULL,1,0,0),(577,578,0,1,'0000-00-00',NULL,1,0,0),(578,579,0,1,'0000-00-00',NULL,1,0,0),(579,580,0,1,'0000-00-00',NULL,1,0,0),(580,581,0,1,'0000-00-00',NULL,1,0,0),(581,582,0,1,'0000-00-00',NULL,1,0,0),(582,583,0,1,'0000-00-00',NULL,1,0,0),(583,584,0,1,'0000-00-00',NULL,1,0,0),(584,585,0,1,'0000-00-00',NULL,1,0,0),(585,586,0,1,'0000-00-00',NULL,1,0,0),(586,587,0,1,'0000-00-00',NULL,1,0,0),(587,588,0,1,'0000-00-00',NULL,1,0,0),(588,589,0,1,'0000-00-00',NULL,1,0,0),(589,590,0,1,'0000-00-00',NULL,1,0,0),(590,591,0,1,'0000-00-00',NULL,1,0,0),(591,592,0,1,'0000-00-00',NULL,1,0,0),(592,593,0,1,'0000-00-00',NULL,1,0,0),(593,594,0,1,'0000-00-00',NULL,1,0,0),(594,595,0,1,'0000-00-00',NULL,1,0,0),(595,596,0,1,'0000-00-00',NULL,1,0,0),(596,597,0,1,'0000-00-00',NULL,1,0,0),(597,598,0,1,'0000-00-00',NULL,1,0,0),(598,599,0,1,'0000-00-00',NULL,1,0,0),(599,600,0,1,'0000-00-00',NULL,1,0,0),(600,601,0,1,'0000-00-00',NULL,1,0,0),(601,602,0,1,'0000-00-00',NULL,1,0,0),(602,603,0,1,'0000-00-00',NULL,1,0,0),(603,604,0,1,'0000-00-00',NULL,1,0,0),(604,605,0,1,'0000-00-00',NULL,1,0,0),(605,606,0,1,'0000-00-00',NULL,1,0,0),(606,607,0,1,'0000-00-00',NULL,1,0,0),(607,608,0,1,'0000-00-00',NULL,1,0,0),(608,609,0,1,'0000-00-00',NULL,1,0,0),(609,610,0,1,'0000-00-00',NULL,1,0,0),(610,611,0,1,'0000-00-00',NULL,1,0,0),(611,612,0,1,'0000-00-00',NULL,1,0,0),(612,613,0,1,'0000-00-00',NULL,1,0,0),(613,614,0,1,'0000-00-00',NULL,1,0,0),(614,615,0,1,'0000-00-00',NULL,1,0,0),(615,616,0,1,'0000-00-00',NULL,1,0,0),(616,617,0,1,'0000-00-00',NULL,1,0,0),(617,618,0,1,'0000-00-00',NULL,1,0,0),(618,619,0,1,'0000-00-00',NULL,1,0,0),(619,620,0,1,'0000-00-00',NULL,1,0,0),(620,621,0,1,'0000-00-00',NULL,1,0,0),(621,622,0,1,'0000-00-00',NULL,1,0,0),(622,623,0,1,'0000-00-00',NULL,1,0,0),(623,624,0,1,'0000-00-00',NULL,1,0,0),(624,625,0,1,'0000-00-00',NULL,1,0,0),(625,626,0,1,'0000-00-00',NULL,1,0,0),(626,627,0,1,'0000-00-00',NULL,1,0,0),(627,628,0,1,'0000-00-00',NULL,1,0,0),(628,629,0,1,'0000-00-00',NULL,1,0,0),(629,630,0,1,'0000-00-00',NULL,1,0,0),(630,631,0,1,'0000-00-00',NULL,1,0,0),(631,632,0,1,'0000-00-00',NULL,1,0,0),(632,633,0,1,'0000-00-00',NULL,1,0,0),(633,634,0,1,'0000-00-00',NULL,1,0,0),(634,635,0,1,'0000-00-00',NULL,1,0,0),(635,636,0,1,'0000-00-00',NULL,1,0,0),(636,637,0,1,'0000-00-00',NULL,1,0,0),(637,638,0,1,'0000-00-00',NULL,1,0,0),(638,639,0,1,'0000-00-00',NULL,1,0,0),(639,640,0,1,'0000-00-00',NULL,1,0,0),(640,641,0,1,'0000-00-00',NULL,1,0,0),(641,642,0,1,'0000-00-00',NULL,1,0,0),(642,643,0,1,'0000-00-00',NULL,1,0,0),(643,644,0,1,'0000-00-00',NULL,1,0,0),(644,645,0,1,'0000-00-00',NULL,1,0,0),(645,646,0,1,'0000-00-00',NULL,1,0,0),(646,647,0,1,'0000-00-00',NULL,1,0,0),(647,648,0,1,'0000-00-00',NULL,1,0,0),(648,649,0,1,'0000-00-00',NULL,1,0,0),(649,650,0,1,'0000-00-00',NULL,1,0,0),(650,651,0,1,'0000-00-00',NULL,1,0,0),(651,652,0,1,'0000-00-00',NULL,1,0,0),(652,653,0,1,'0000-00-00',NULL,1,0,0),(653,654,0,1,'0000-00-00',NULL,1,0,0),(654,655,0,1,'0000-00-00',NULL,1,0,0),(655,656,0,1,'0000-00-00',NULL,1,0,0),(656,657,0,1,'0000-00-00',NULL,1,0,0),(657,658,0,1,'0000-00-00',NULL,1,0,0),(658,659,0,1,'0000-00-00',NULL,1,0,0),(659,660,0,1,'0000-00-00',NULL,1,0,0),(660,661,0,1,'0000-00-00',NULL,1,0,0),(661,662,0,1,'0000-00-00',NULL,1,0,0),(662,663,0,1,'0000-00-00',NULL,1,0,0),(663,664,0,1,'0000-00-00',NULL,1,0,0),(664,665,0,1,'0000-00-00',NULL,1,0,0),(665,666,0,1,'0000-00-00',NULL,1,0,0),(666,667,0,1,'0000-00-00',NULL,1,0,0),(667,668,0,1,'0000-00-00',NULL,1,0,0),(668,669,0,1,'0000-00-00',NULL,1,0,0),(669,670,0,1,'0000-00-00',NULL,1,0,0),(670,671,0,1,'0000-00-00',NULL,1,0,0),(671,672,0,1,'0000-00-00',NULL,1,0,0),(672,673,0,1,'0000-00-00',NULL,1,0,0),(673,674,0,1,'0000-00-00',NULL,1,0,0),(674,675,0,1,'0000-00-00',NULL,1,0,0),(675,676,0,1,'0000-00-00',NULL,1,0,0),(676,677,0,1,'0000-00-00',NULL,1,0,0),(677,678,0,1,'0000-00-00',NULL,1,0,0),(678,679,0,1,'0000-00-00',NULL,1,0,0),(679,680,0,1,'0000-00-00',NULL,1,0,0),(680,681,0,1,'0000-00-00',NULL,1,0,0),(681,682,0,1,'0000-00-00',NULL,1,0,0),(682,683,0,1,'0000-00-00',NULL,1,0,0),(683,684,0,1,'0000-00-00',NULL,1,0,0),(684,685,0,1,'0000-00-00',NULL,1,0,0),(685,686,0,1,'0000-00-00',NULL,1,0,0),(686,687,0,1,'0000-00-00',NULL,1,0,0),(687,688,0,1,'0000-00-00',NULL,1,0,0),(688,689,0,1,'0000-00-00',NULL,1,0,0),(689,690,0,1,'0000-00-00',NULL,1,0,0),(690,691,0,1,'0000-00-00',NULL,1,0,0),(691,692,0,1,'0000-00-00',NULL,1,0,0),(692,693,0,1,'0000-00-00',NULL,1,0,0),(693,694,0,1,'0000-00-00',NULL,1,0,0),(694,695,0,1,'0000-00-00',NULL,1,0,0),(695,696,0,1,'0000-00-00',NULL,1,0,0),(696,697,0,1,'0000-00-00',NULL,1,0,0),(697,698,0,1,'0000-00-00',NULL,1,0,0),(698,699,0,1,'0000-00-00',NULL,1,0,0),(699,700,0,1,'0000-00-00',NULL,1,0,0),(700,701,0,1,'0000-00-00',NULL,1,0,0),(701,702,0,1,'0000-00-00',NULL,1,0,0),(702,703,0,1,'0000-00-00',NULL,1,0,0),(703,704,0,1,'0000-00-00',NULL,1,0,0),(704,705,0,1,'0000-00-00',NULL,1,0,0),(705,706,0,1,'0000-00-00',NULL,1,0,0),(706,707,0,1,'0000-00-00',NULL,1,0,0),(707,708,0,1,'0000-00-00',NULL,1,0,0),(708,709,0,1,'0000-00-00',NULL,1,0,0),(709,710,0,1,'0000-00-00',NULL,1,0,0),(710,711,0,1,'0000-00-00',NULL,1,0,0),(711,712,0,1,'0000-00-00',NULL,1,0,0),(712,713,0,1,'0000-00-00',NULL,1,0,0),(713,714,0,1,'0000-00-00',NULL,1,0,0),(714,715,0,1,'0000-00-00',NULL,1,0,0),(715,716,0,1,'0000-00-00',NULL,1,0,0),(716,717,0,1,'0000-00-00',NULL,1,0,0),(717,718,0,1,'0000-00-00',NULL,1,0,0),(718,719,0,1,'0000-00-00',NULL,1,0,0),(719,720,0,1,'0000-00-00',NULL,1,0,0),(720,721,0,1,'0000-00-00',NULL,1,0,0),(721,722,0,1,'0000-00-00',NULL,1,0,0),(722,723,0,1,'0000-00-00',NULL,1,0,0),(723,724,0,1,'0000-00-00',NULL,1,0,0),(724,725,0,1,'0000-00-00',NULL,1,0,0),(725,726,0,1,'0000-00-00',NULL,1,0,0),(726,727,0,1,'0000-00-00',NULL,1,0,0),(727,728,0,1,'0000-00-00',NULL,1,0,0),(728,729,0,1,'0000-00-00',NULL,1,0,0),(729,730,0,1,'0000-00-00',NULL,1,0,0),(730,731,0,1,'0000-00-00',NULL,1,0,0),(731,732,0,1,'0000-00-00',NULL,1,0,0),(732,733,0,1,'0000-00-00',NULL,1,0,0),(733,734,0,1,'0000-00-00',NULL,1,0,0),(734,735,0,1,'0000-00-00',NULL,1,0,0),(735,736,0,1,'0000-00-00',NULL,1,0,0),(736,737,0,1,'0000-00-00',NULL,1,0,0),(737,738,0,1,'0000-00-00',NULL,1,0,0),(738,739,0,1,'0000-00-00',NULL,1,0,0),(739,740,0,1,'0000-00-00',NULL,1,0,0),(740,741,0,1,'0000-00-00',NULL,1,0,0),(741,742,0,1,'0000-00-00',NULL,1,0,0),(742,743,0,1,'0000-00-00',NULL,1,0,0),(743,744,0,1,'0000-00-00',NULL,1,0,0),(744,745,0,1,'0000-00-00',NULL,1,0,0),(745,746,0,1,'0000-00-00',NULL,1,0,0),(746,747,0,1,'0000-00-00',NULL,1,0,0),(747,748,0,1,'0000-00-00',NULL,1,0,0),(748,749,0,1,'0000-00-00',NULL,1,0,0),(749,750,0,1,'0000-00-00',NULL,1,0,0),(750,751,0,1,'0000-00-00',NULL,1,0,0),(751,752,0,1,'0000-00-00',NULL,1,0,0),(752,753,0,1,'0000-00-00',NULL,1,0,0),(753,754,0,1,'0000-00-00',NULL,1,0,0),(754,755,0,1,'0000-00-00',NULL,1,0,0),(755,756,0,1,'0000-00-00',NULL,1,0,0),(756,757,0,1,'0000-00-00',NULL,1,0,0),(757,758,0,1,'0000-00-00',NULL,1,0,0),(758,759,0,1,'0000-00-00',NULL,1,0,0),(759,760,0,1,'0000-00-00',NULL,1,0,0),(760,761,0,1,'0000-00-00',NULL,1,0,0),(761,762,0,1,'0000-00-00',NULL,1,0,0),(762,763,0,1,'0000-00-00',NULL,1,0,0),(763,764,0,1,'0000-00-00',NULL,1,0,0),(764,765,0,1,'0000-00-00',NULL,1,0,0),(765,766,0,1,'0000-00-00',NULL,1,0,0),(766,767,0,1,'0000-00-00',NULL,1,0,0),(767,768,0,1,'0000-00-00',NULL,1,0,0),(768,769,0,1,'0000-00-00',NULL,1,0,0),(769,770,0,1,'0000-00-00',NULL,1,0,0),(770,771,0,1,'0000-00-00',NULL,1,0,0),(771,772,0,1,'0000-00-00',NULL,1,0,0),(772,773,0,1,'0000-00-00',NULL,1,0,0),(773,774,0,1,'0000-00-00',NULL,1,0,0),(774,775,0,1,'0000-00-00',NULL,1,0,0),(775,776,0,1,'0000-00-00',NULL,1,0,0),(776,777,0,1,'0000-00-00',NULL,1,0,0),(777,778,0,1,'0000-00-00',NULL,1,0,0),(778,779,0,1,'0000-00-00',NULL,1,0,0),(779,780,0,1,'0000-00-00',NULL,1,0,0),(780,781,0,1,'0000-00-00',NULL,1,0,0),(781,782,0,1,'0000-00-00',NULL,1,0,0),(782,783,0,1,'0000-00-00',NULL,1,0,0),(783,784,0,1,'0000-00-00',NULL,1,0,0),(784,785,0,1,'0000-00-00',NULL,1,0,0),(785,786,0,1,'0000-00-00',NULL,1,0,0),(786,787,0,1,'0000-00-00',NULL,1,0,0),(787,788,0,1,'0000-00-00',NULL,1,0,0),(788,789,0,1,'0000-00-00',NULL,1,0,0),(789,790,0,1,'0000-00-00',NULL,1,0,0),(790,791,0,1,'0000-00-00',NULL,1,0,0),(791,792,0,1,'0000-00-00',NULL,1,0,0),(792,793,0,1,'0000-00-00',NULL,1,0,0),(793,794,0,1,'0000-00-00',NULL,1,0,0),(794,795,0,1,'0000-00-00',NULL,1,0,0),(795,796,0,1,'0000-00-00',NULL,1,0,0),(796,797,0,1,'0000-00-00',NULL,1,0,0),(797,798,0,1,'0000-00-00',NULL,1,0,0),(798,799,0,1,'0000-00-00',NULL,1,0,0),(799,800,0,1,'0000-00-00',NULL,1,0,0),(800,801,0,1,'0000-00-00',NULL,1,0,0),(801,802,0,1,'0000-00-00',NULL,1,0,0),(802,803,0,1,'0000-00-00',NULL,1,0,0),(803,804,0,1,'0000-00-00',NULL,1,0,0),(804,805,0,1,'0000-00-00',NULL,1,0,0),(805,806,0,1,'0000-00-00',NULL,1,0,0),(806,807,0,1,'0000-00-00',NULL,1,0,0),(807,808,0,1,'0000-00-00',NULL,1,0,0),(808,809,0,1,'0000-00-00',NULL,1,0,0),(809,810,0,1,'0000-00-00',NULL,1,0,0),(810,811,0,1,'0000-00-00',NULL,1,0,0),(811,812,0,1,'0000-00-00',NULL,1,0,0),(812,813,0,1,'0000-00-00',NULL,1,0,0),(813,814,0,1,'0000-00-00',NULL,1,0,0),(814,815,0,1,'0000-00-00',NULL,1,0,0),(815,816,0,1,'0000-00-00',NULL,1,0,0),(816,817,0,1,'0000-00-00',NULL,1,0,0),(817,818,0,1,'0000-00-00',NULL,1,0,0),(818,819,0,1,'0000-00-00',NULL,1,0,0),(819,820,0,1,'0000-00-00',NULL,1,0,0),(820,821,0,1,'0000-00-00',NULL,1,0,0),(821,822,0,1,'0000-00-00',NULL,1,0,0),(822,823,0,1,'0000-00-00',NULL,1,0,0),(823,824,0,1,'0000-00-00',NULL,1,0,0),(824,825,0,1,'0000-00-00',NULL,1,0,0),(825,826,0,1,'0000-00-00',NULL,1,0,0),(826,827,0,1,'0000-00-00',NULL,1,0,0),(827,828,0,1,'0000-00-00',NULL,1,0,0),(828,829,0,1,'0000-00-00',NULL,1,0,0),(829,830,0,1,'0000-00-00',NULL,1,0,0),(830,831,0,1,'0000-00-00',NULL,1,0,0),(831,832,0,1,'0000-00-00',NULL,1,0,0),(832,833,0,1,'0000-00-00',NULL,1,0,0),(833,834,0,1,'0000-00-00',NULL,1,0,0),(834,835,0,1,'0000-00-00',NULL,1,0,0),(835,836,0,1,'0000-00-00',NULL,1,0,0),(836,837,0,1,'0000-00-00',NULL,1,0,0),(837,838,0,1,'0000-00-00',NULL,1,0,0),(838,839,0,1,'0000-00-00',NULL,1,0,0),(839,840,0,1,'0000-00-00',NULL,1,0,0),(840,841,0,1,'0000-00-00',NULL,1,0,0),(841,842,0,1,'0000-00-00',NULL,1,0,0),(842,843,0,1,'0000-00-00',NULL,1,0,0),(843,844,0,1,'0000-00-00',NULL,1,0,0),(844,845,0,1,'0000-00-00',NULL,1,0,0),(845,846,0,1,'0000-00-00',NULL,1,0,0),(846,847,0,1,'0000-00-00',NULL,1,0,0),(847,848,0,1,'0000-00-00',NULL,1,0,0),(848,849,0,1,'0000-00-00',NULL,1,0,0),(849,850,0,1,'0000-00-00',NULL,1,0,0),(850,851,0,1,'0000-00-00',NULL,1,0,0),(851,852,0,1,'0000-00-00',NULL,1,0,0),(852,853,0,1,'0000-00-00',NULL,1,0,0),(853,854,0,1,'0000-00-00',NULL,1,0,0),(854,855,0,1,'0000-00-00',NULL,1,0,0),(855,856,0,1,'0000-00-00',NULL,1,0,0),(856,857,0,1,'0000-00-00',NULL,1,0,0),(857,858,0,1,'0000-00-00',NULL,1,0,0),(858,859,0,1,'0000-00-00',NULL,1,0,0),(859,860,0,1,'0000-00-00',NULL,1,0,0),(860,861,0,1,'0000-00-00',NULL,1,0,0),(861,862,0,1,'0000-00-00',NULL,1,0,0),(862,863,0,1,'0000-00-00',NULL,1,0,0),(863,864,0,1,'0000-00-00',NULL,1,0,0),(864,865,0,1,'0000-00-00',NULL,1,0,0),(865,866,0,1,'0000-00-00',NULL,1,0,0),(866,867,0,1,'0000-00-00',NULL,1,0,0),(867,868,0,1,'0000-00-00',NULL,1,0,0),(868,869,0,1,'0000-00-00',NULL,1,0,0),(869,870,0,1,'0000-00-00',NULL,1,0,0),(870,871,0,1,'0000-00-00',NULL,1,0,0),(871,872,0,1,'0000-00-00',NULL,1,0,0),(872,873,0,1,'0000-00-00',NULL,1,0,0),(873,874,0,1,'0000-00-00',NULL,1,0,0),(874,875,0,1,'0000-00-00',NULL,1,0,0),(875,876,0,1,'0000-00-00',NULL,1,0,0),(876,877,0,1,'0000-00-00',NULL,1,0,0),(877,878,0,1,'0000-00-00',NULL,1,0,0),(878,879,0,1,'0000-00-00',NULL,1,0,0),(879,880,0,1,'0000-00-00',NULL,1,0,0),(880,881,0,1,'0000-00-00',NULL,1,0,0),(881,882,0,1,'0000-00-00',NULL,1,0,0),(882,883,0,1,'0000-00-00',NULL,1,0,0),(883,884,0,1,'0000-00-00',NULL,1,0,0),(884,885,0,1,'0000-00-00',NULL,1,0,0),(885,886,0,1,'0000-00-00',NULL,1,0,0),(886,887,0,1,'0000-00-00',NULL,1,0,0),(887,888,0,1,'0000-00-00',NULL,1,0,0),(888,889,0,1,'0000-00-00',NULL,1,0,0),(889,890,0,1,'0000-00-00',NULL,1,0,0),(890,891,0,1,'0000-00-00',NULL,1,0,0),(891,892,0,1,'0000-00-00',NULL,1,0,0),(892,893,0,1,'0000-00-00',NULL,1,0,0),(893,894,0,1,'0000-00-00',NULL,1,0,0),(894,895,0,1,'0000-00-00',NULL,1,0,0),(895,896,0,1,'0000-00-00',NULL,1,0,0),(896,897,0,1,'0000-00-00',NULL,1,0,0),(897,898,0,1,'0000-00-00',NULL,1,0,0),(898,899,0,1,'0000-00-00',NULL,1,0,0),(899,900,0,1,'0000-00-00',NULL,1,0,0),(900,901,0,1,'0000-00-00',NULL,1,0,0),(901,902,0,1,'0000-00-00',NULL,1,0,0),(902,903,0,1,'0000-00-00',NULL,1,0,0),(903,904,0,1,'0000-00-00',NULL,1,0,0),(904,905,0,1,'0000-00-00',NULL,1,0,0),(905,906,0,1,'0000-00-00',NULL,1,0,0),(906,907,0,1,'0000-00-00',NULL,1,0,0),(907,908,0,1,'0000-00-00',NULL,1,0,0),(908,909,0,1,'0000-00-00',NULL,1,0,0),(909,910,0,1,'0000-00-00',NULL,1,0,0),(910,911,0,1,'0000-00-00',NULL,1,0,0),(911,912,0,1,'0000-00-00',NULL,1,0,0),(912,913,0,1,'0000-00-00',NULL,1,0,0),(913,914,0,1,'0000-00-00',NULL,1,0,0),(914,915,0,1,'0000-00-00',NULL,1,0,0),(915,916,0,1,'0000-00-00',NULL,1,0,0),(916,917,0,1,'0000-00-00',NULL,1,0,0),(917,918,0,1,'0000-00-00',NULL,1,0,0),(918,919,0,1,'0000-00-00',NULL,1,0,0),(919,920,0,1,'0000-00-00',NULL,1,0,0),(920,921,0,1,'0000-00-00',NULL,1,0,0),(921,922,0,1,'0000-00-00',NULL,1,0,0),(922,923,0,1,'0000-00-00',NULL,1,0,0),(923,924,0,1,'0000-00-00',NULL,1,0,0),(924,925,0,1,'0000-00-00',NULL,1,0,0),(925,926,0,1,'0000-00-00',NULL,1,0,0),(926,927,0,1,'0000-00-00',NULL,1,0,0),(927,928,0,1,'0000-00-00',NULL,1,0,0),(928,929,0,1,'0000-00-00',NULL,1,0,0),(929,930,0,1,'0000-00-00',NULL,1,0,0),(930,931,0,1,'0000-00-00',NULL,1,0,0),(931,932,0,1,'0000-00-00',NULL,1,0,0),(932,933,0,1,'0000-00-00',NULL,1,0,0),(933,934,0,1,'0000-00-00',NULL,1,0,0),(934,935,0,1,'0000-00-00',NULL,1,0,0),(935,936,0,1,'0000-00-00',NULL,1,0,0),(936,937,0,1,'0000-00-00',NULL,1,0,0),(937,938,0,1,'0000-00-00',NULL,1,0,0),(938,939,0,1,'0000-00-00',NULL,1,0,0),(939,940,0,1,'0000-00-00',NULL,1,0,0),(940,941,0,1,'0000-00-00',NULL,1,0,0),(941,942,0,1,'0000-00-00',NULL,1,0,0),(942,943,0,1,'0000-00-00',NULL,1,0,0),(943,944,0,1,'0000-00-00',NULL,1,0,0),(944,945,0,1,'0000-00-00',NULL,1,0,0),(945,946,0,1,'0000-00-00',NULL,1,0,0),(946,947,0,1,'0000-00-00',NULL,1,0,0),(947,948,0,1,'0000-00-00',NULL,1,0,0),(948,949,0,1,'0000-00-00',NULL,1,0,0),(949,950,0,1,'0000-00-00',NULL,1,0,0),(950,951,0,1,'0000-00-00',NULL,1,0,0),(951,952,0,1,'0000-00-00',NULL,1,0,0),(952,953,0,1,'0000-00-00',NULL,1,0,0),(953,954,0,1,'0000-00-00',NULL,1,0,0),(954,955,0,1,'0000-00-00',NULL,1,0,0),(955,956,0,1,'0000-00-00',NULL,1,0,0),(956,957,0,1,'0000-00-00',NULL,1,0,0),(957,958,0,1,'0000-00-00',NULL,1,0,0),(958,959,0,1,'0000-00-00',NULL,1,0,0),(959,960,0,1,'0000-00-00',NULL,1,0,0),(960,961,0,1,'0000-00-00',NULL,1,0,0),(961,962,0,1,'0000-00-00',NULL,1,0,0),(962,963,0,1,'0000-00-00',NULL,1,0,0),(963,964,0,1,'0000-00-00',NULL,1,0,0),(964,965,0,1,'0000-00-00',NULL,1,0,0),(965,966,0,1,'0000-00-00',NULL,1,0,0),(966,967,0,1,'0000-00-00',NULL,1,0,0),(967,968,0,1,'0000-00-00',NULL,1,0,0),(968,969,0,1,'0000-00-00',NULL,1,0,0),(969,970,0,1,'0000-00-00',NULL,1,0,0),(970,971,0,1,'0000-00-00',NULL,1,0,0),(971,972,0,1,'0000-00-00',NULL,1,0,0),(972,973,0,1,'0000-00-00',NULL,1,0,0),(973,974,0,1,'0000-00-00',NULL,1,0,0),(974,975,0,1,'0000-00-00',NULL,1,0,0),(975,976,0,1,'0000-00-00',NULL,1,0,0),(976,977,0,1,'0000-00-00',NULL,1,0,0),(977,978,0,1,'0000-00-00',NULL,1,0,0),(978,979,0,1,'0000-00-00',NULL,1,0,0),(979,980,0,1,'0000-00-00',NULL,1,0,0),(980,981,0,1,'0000-00-00',NULL,1,0,0),(981,982,0,1,'0000-00-00',NULL,1,0,0),(982,983,0,1,'0000-00-00',NULL,1,0,0),(983,984,0,1,'0000-00-00',NULL,1,0,0),(984,985,0,1,'0000-00-00',NULL,1,0,0),(985,986,0,1,'0000-00-00',NULL,1,0,0),(986,987,0,1,'0000-00-00',NULL,1,0,0),(987,988,0,1,'0000-00-00',NULL,1,0,0),(988,989,0,1,'0000-00-00',NULL,1,0,0),(989,990,0,1,'0000-00-00',NULL,1,0,0),(990,991,0,1,'0000-00-00',NULL,1,0,0),(991,992,0,1,'0000-00-00',NULL,1,0,0),(992,993,0,1,'0000-00-00',NULL,1,0,0),(993,994,0,1,'0000-00-00',NULL,1,0,0),(994,995,0,1,'0000-00-00',NULL,1,0,0),(995,996,0,1,'0000-00-00',NULL,1,0,0),(996,997,0,1,'0000-00-00',NULL,1,0,0),(997,998,0,1,'0000-00-00',NULL,1,0,0),(998,999,0,1,'0000-00-00',NULL,1,0,0),(999,1000,0,1,'0000-00-00',NULL,1,0,0),(1000,1001,0,1,'0000-00-00',NULL,1,0,0),(1001,1002,0,1,'0000-00-00',NULL,1,0,0),(1002,1003,0,1,'0000-00-00',NULL,1,0,0),(1003,1004,0,1,'0000-00-00',NULL,1,0,0),(1004,1005,0,1,'0000-00-00',NULL,1,0,0),(1005,1006,0,1,'0000-00-00',NULL,1,0,0),(1006,1007,0,1,'0000-00-00',NULL,1,0,0),(1007,1008,0,1,'0000-00-00',NULL,1,0,0),(1008,1009,0,1,'0000-00-00',NULL,1,0,0),(1009,1010,0,1,'0000-00-00',NULL,1,0,0),(1010,1011,0,1,'0000-00-00',NULL,1,0,0),(1011,1012,0,1,'0000-00-00',NULL,1,0,0),(1012,1013,0,1,'0000-00-00',NULL,1,0,0),(1013,1014,0,1,'0000-00-00',NULL,1,0,0),(1014,1015,0,1,'0000-00-00',NULL,1,0,0),(1015,1016,0,1,'0000-00-00',NULL,1,0,0),(1016,1017,0,1,'0000-00-00',NULL,1,0,0),(1017,1018,0,1,'0000-00-00',NULL,1,0,0),(1018,1019,0,1,'0000-00-00',NULL,1,0,0),(1019,1020,0,1,'0000-00-00',NULL,1,0,0),(1020,1021,0,1,'0000-00-00',NULL,1,0,0),(1021,1022,0,1,'0000-00-00',NULL,1,0,0),(1022,1023,0,1,'0000-00-00',NULL,1,0,0),(1023,1024,0,1,'0000-00-00',NULL,1,0,0),(1024,1025,0,1,'0000-00-00',NULL,1,0,0),(1025,1026,0,1,'0000-00-00',NULL,1,0,0),(1026,1027,0,1,'0000-00-00',NULL,1,0,0),(1027,1028,0,1,'0000-00-00',NULL,1,0,0),(1028,1029,0,1,'0000-00-00',NULL,1,0,0),(1029,1030,0,1,'0000-00-00',NULL,1,0,0),(1030,1031,0,1,'0000-00-00',NULL,1,0,0),(1031,1032,0,1,'0000-00-00',NULL,1,0,0),(1032,1033,0,1,'0000-00-00',NULL,1,0,0),(1033,1034,0,1,'0000-00-00',NULL,1,0,0),(1034,1035,0,1,'0000-00-00',NULL,1,0,0),(1035,1036,0,1,'0000-00-00',NULL,1,0,0),(1036,1037,0,1,'0000-00-00',NULL,1,0,0),(1037,1038,0,1,'0000-00-00',NULL,1,0,0),(1038,1039,0,1,'0000-00-00',NULL,1,0,0),(1039,1040,0,1,'0000-00-00',NULL,1,0,0),(1040,1041,0,1,'0000-00-00',NULL,1,0,0),(1041,1042,0,1,'0000-00-00',NULL,1,0,0),(1042,1043,0,1,'0000-00-00',NULL,1,0,0),(1043,1044,0,1,'0000-00-00',NULL,1,0,0),(1044,1045,0,1,'0000-00-00',NULL,1,0,0),(1045,1046,0,1,'0000-00-00',NULL,1,0,0),(1046,1047,0,1,'0000-00-00',NULL,1,0,0),(1047,1048,0,1,'0000-00-00',NULL,1,0,0),(1048,1049,0,1,'0000-00-00',NULL,1,0,0),(1049,1050,0,1,'0000-00-00',NULL,1,0,0),(1050,1051,0,1,'0000-00-00',NULL,1,0,0),(1051,1052,0,1,'0000-00-00',NULL,1,0,0),(1052,1053,0,1,'0000-00-00',NULL,1,0,0),(1053,1054,0,1,'0000-00-00',NULL,1,0,0),(1054,1055,0,1,'0000-00-00',NULL,1,0,0),(1055,1056,0,1,'0000-00-00',NULL,1,0,0),(1056,1057,0,1,'0000-00-00',NULL,1,0,0),(1057,1058,0,1,'0000-00-00',NULL,1,0,0),(1058,1059,0,1,'0000-00-00',NULL,1,0,0),(1059,1060,0,1,'0000-00-00',NULL,1,0,0),(1060,1061,0,1,'0000-00-00',NULL,1,0,0),(1061,1062,0,1,'0000-00-00',NULL,1,0,0),(1062,1063,0,1,'0000-00-00',NULL,1,0,0),(1063,1064,0,1,'0000-00-00',NULL,1,0,0),(1064,1065,0,1,'0000-00-00',NULL,1,0,0),(1065,1066,0,1,'0000-00-00',NULL,1,0,0),(1066,1067,0,1,'0000-00-00',NULL,1,0,0),(1067,1068,0,1,'0000-00-00',NULL,1,0,0),(1068,1069,0,1,'0000-00-00',NULL,1,0,0),(1069,1070,0,1,'0000-00-00',NULL,1,0,0),(1070,1071,0,1,'0000-00-00',NULL,1,0,0),(1071,1072,0,1,'0000-00-00',NULL,1,0,0),(1072,1073,0,1,'0000-00-00',NULL,1,0,0),(1073,1074,0,1,'0000-00-00',NULL,1,0,0),(1074,1075,0,1,'0000-00-00',NULL,1,0,0),(1075,1076,0,1,'0000-00-00',NULL,1,0,0),(1076,1077,0,1,'0000-00-00',NULL,1,0,0),(1077,1078,0,1,'0000-00-00',NULL,1,0,0),(1078,1079,0,1,'0000-00-00',NULL,1,0,0),(1079,1080,0,1,'0000-00-00',NULL,1,0,0),(1080,1081,0,1,'0000-00-00',NULL,1,0,0),(1081,1082,0,1,'0000-00-00',NULL,1,0,0),(1082,1083,0,1,'0000-00-00',NULL,1,0,0),(1083,1084,0,1,'0000-00-00',NULL,1,0,0),(1084,1085,0,1,'0000-00-00',NULL,1,0,0),(1085,1086,0,1,'0000-00-00',NULL,1,0,0),(1086,1087,0,1,'0000-00-00',NULL,1,0,0),(1087,1088,0,1,'0000-00-00',NULL,1,0,0),(1088,1089,0,1,'0000-00-00',NULL,1,0,0),(1089,1090,0,1,'0000-00-00',NULL,1,0,0),(1090,1091,0,1,'0000-00-00',NULL,1,0,0),(1091,1092,0,1,'0000-00-00',NULL,1,0,0),(1092,1093,0,1,'0000-00-00',NULL,1,0,0),(1093,1094,0,1,'0000-00-00',NULL,1,0,0),(1094,1095,0,1,'0000-00-00',NULL,1,0,0),(1095,1096,0,1,'0000-00-00',NULL,1,0,0),(1096,1097,0,1,'0000-00-00',NULL,1,0,0),(1097,1098,0,1,'0000-00-00',NULL,1,0,0),(1098,1099,0,1,'0000-00-00',NULL,1,0,0),(1099,1100,0,1,'0000-00-00',NULL,1,0,0),(1100,1101,0,1,'0000-00-00',NULL,1,0,0),(1101,1102,0,1,'0000-00-00',NULL,1,0,0),(1102,1103,0,1,'0000-00-00',NULL,1,0,0),(1103,1104,0,1,'0000-00-00',NULL,1,0,0),(1104,1105,0,1,'0000-00-00',NULL,1,0,0),(1105,1106,0,1,'0000-00-00',NULL,1,0,0),(1106,1107,0,1,'0000-00-00',NULL,1,0,0),(1107,1108,0,1,'0000-00-00',NULL,1,0,0),(1108,1109,0,1,'0000-00-00',NULL,1,0,0),(1109,1110,0,1,'0000-00-00',NULL,1,0,0),(1110,1111,0,1,'0000-00-00',NULL,1,0,0),(1111,1112,0,1,'0000-00-00',NULL,1,0,0),(1112,1113,0,1,'0000-00-00',NULL,1,0,0),(1113,1114,0,1,'0000-00-00',NULL,1,0,0),(1114,1115,0,1,'0000-00-00',NULL,1,0,0),(1115,1116,0,1,'0000-00-00',NULL,1,0,0),(1116,1117,0,1,'0000-00-00',NULL,1,0,0),(1117,1118,0,1,'0000-00-00',NULL,1,0,0),(1118,1119,0,1,'0000-00-00',NULL,1,0,0),(1119,1120,0,1,'0000-00-00',NULL,1,0,0),(1120,1121,0,1,'0000-00-00',NULL,1,0,0),(1121,1122,0,1,'0000-00-00',NULL,1,0,0),(1122,1123,0,1,'0000-00-00',NULL,1,0,0),(1123,1124,0,1,'0000-00-00',NULL,1,0,0),(1124,1125,0,1,'0000-00-00',NULL,1,0,0),(1125,1126,0,1,'0000-00-00',NULL,1,0,0),(1126,1127,0,1,'0000-00-00',NULL,1,0,0),(1127,1128,0,1,'0000-00-00',NULL,1,0,0),(1128,1129,0,1,'0000-00-00',NULL,1,0,0),(1129,1130,0,1,'0000-00-00',NULL,1,0,0),(1130,1131,0,1,'0000-00-00',NULL,1,0,0),(1131,1132,0,1,'0000-00-00',NULL,1,0,0),(1132,1133,0,1,'0000-00-00',NULL,1,0,0),(1133,1134,0,1,'0000-00-00',NULL,1,0,0),(1134,1135,0,1,'0000-00-00',NULL,1,0,0),(1135,1136,0,1,'0000-00-00',NULL,1,0,0),(1136,1137,0,1,'0000-00-00',NULL,1,0,0),(1137,1138,0,1,'0000-00-00',NULL,1,0,0),(1138,1139,0,1,'0000-00-00',NULL,1,0,0),(1139,1140,0,1,'0000-00-00',NULL,1,0,0),(1140,1141,0,1,'0000-00-00',NULL,1,0,0),(1141,1142,0,1,'0000-00-00',NULL,1,0,0),(1142,1143,0,1,'0000-00-00',NULL,1,0,0),(1143,1144,0,1,'0000-00-00',NULL,1,0,0),(1144,1145,0,1,'0000-00-00',NULL,1,0,0),(1145,1146,0,1,'0000-00-00',NULL,1,0,0),(1146,1147,0,1,'0000-00-00',NULL,1,0,0),(1147,1148,0,1,'0000-00-00',NULL,1,0,0),(1148,1149,0,1,'0000-00-00',NULL,1,0,0),(1149,1150,0,1,'0000-00-00',NULL,1,0,0),(1150,1151,0,1,'0000-00-00',NULL,1,0,0),(1151,1152,0,1,'0000-00-00',NULL,1,0,0),(1152,1153,0,1,'0000-00-00',NULL,1,0,0),(1153,1154,0,1,'0000-00-00',NULL,1,0,0),(1154,1155,0,1,'0000-00-00',NULL,1,0,0),(1155,1156,0,1,'0000-00-00',NULL,1,0,0),(1156,1157,0,1,'0000-00-00',NULL,1,0,0),(1157,1158,0,1,'0000-00-00',NULL,1,0,0),(1158,1159,0,1,'0000-00-00',NULL,1,0,0),(1159,1160,0,1,'0000-00-00',NULL,1,0,0),(1160,1161,0,1,'0000-00-00',NULL,1,0,0),(1161,1162,0,1,'0000-00-00',NULL,1,0,0),(1162,1163,0,1,'0000-00-00',NULL,1,0,0),(1163,1164,0,1,'0000-00-00',NULL,1,0,0),(1164,1165,0,1,'0000-00-00',NULL,1,0,0),(1165,1166,0,1,'0000-00-00',NULL,1,0,0),(1166,1167,0,1,'0000-00-00',NULL,1,0,0),(1167,1168,0,1,'0000-00-00',NULL,1,0,0),(1168,1169,0,1,'0000-00-00',NULL,1,0,0),(1169,1170,0,1,'0000-00-00',NULL,1,0,0),(1170,1171,0,1,'0000-00-00',NULL,1,0,0),(1171,1172,0,1,'0000-00-00',NULL,1,0,0),(1172,1173,0,1,'0000-00-00',NULL,1,0,0),(1173,1174,0,1,'0000-00-00',NULL,1,0,0),(1174,1175,0,1,'0000-00-00',NULL,1,0,0),(1175,1176,0,1,'0000-00-00',NULL,1,0,0),(1176,1177,0,1,'0000-00-00',NULL,1,0,0),(1177,1178,0,1,'0000-00-00',NULL,1,0,0),(1178,1179,0,1,'0000-00-00',NULL,1,0,0),(1179,1180,0,1,'0000-00-00',NULL,1,0,0),(1180,1181,0,1,'0000-00-00',NULL,1,0,0),(1181,1182,0,1,'0000-00-00',NULL,1,0,0),(1182,1183,0,1,'0000-00-00',NULL,1,0,0),(1183,1184,0,1,'0000-00-00',NULL,1,0,0),(1184,1185,0,1,'0000-00-00',NULL,1,0,0),(1185,1186,0,1,'0000-00-00',NULL,1,0,0),(1186,1187,0,1,'0000-00-00',NULL,1,0,0),(1187,1188,0,1,'0000-00-00',NULL,1,0,0),(1188,1189,0,1,'0000-00-00',NULL,1,0,0),(1189,1190,0,1,'0000-00-00',NULL,1,0,0),(1190,1191,0,1,'0000-00-00',NULL,1,0,0),(1191,1192,0,1,'0000-00-00',NULL,1,0,0),(1192,1193,0,1,'0000-00-00',NULL,1,0,0),(1193,1194,0,1,'0000-00-00',NULL,1,0,0),(1194,1195,0,1,'0000-00-00',NULL,1,0,0),(1195,1196,0,1,'0000-00-00',NULL,1,0,0),(1196,1197,0,1,'0000-00-00',NULL,1,0,0),(1197,1198,0,1,'0000-00-00',NULL,1,0,0),(1198,1199,0,1,'0000-00-00',NULL,1,0,0),(1199,1200,0,1,'0000-00-00',NULL,1,0,0),(1200,1201,0,1,'0000-00-00',NULL,1,0,0),(1201,1202,0,1,'0000-00-00',NULL,1,0,0),(1202,1203,0,1,'0000-00-00',NULL,1,0,0),(1203,1204,0,1,'0000-00-00',NULL,1,0,0),(1204,1205,0,1,'0000-00-00',NULL,1,0,0),(1205,1206,0,1,'0000-00-00',NULL,1,0,0),(1206,1207,0,1,'0000-00-00',NULL,1,0,0),(1207,1208,0,1,'0000-00-00',NULL,1,0,0),(1208,1209,0,1,'0000-00-00',NULL,1,0,0),(1209,1210,0,1,'0000-00-00',NULL,1,0,0),(1210,1211,0,1,'0000-00-00',NULL,1,0,0),(1211,1212,0,1,'0000-00-00',NULL,1,0,0),(1212,1213,0,1,'0000-00-00',NULL,1,0,0),(1213,1214,0,1,'0000-00-00',NULL,1,0,0),(1214,1215,0,1,'0000-00-00',NULL,1,0,0),(1215,1216,0,1,'0000-00-00',NULL,1,0,0),(1216,1217,0,1,'0000-00-00',NULL,1,0,0),(1217,1218,0,1,'0000-00-00',NULL,1,0,0),(1218,1219,0,1,'0000-00-00',NULL,1,0,0),(1219,1220,0,1,'0000-00-00',NULL,1,0,0),(1220,1221,0,1,'0000-00-00',NULL,1,0,0),(1221,1222,0,1,'0000-00-00',NULL,1,0,0),(1222,1223,0,1,'0000-00-00',NULL,1,0,0),(1223,1224,0,1,'0000-00-00',NULL,1,0,0),(1224,1225,0,1,'0000-00-00',NULL,1,0,0),(1225,1226,0,1,'0000-00-00',NULL,1,0,0),(1226,1227,0,1,'0000-00-00',NULL,1,0,0),(1227,1228,0,1,'0000-00-00',NULL,1,0,0),(1228,1229,0,1,'0000-00-00',NULL,1,0,0),(1229,1230,0,1,'0000-00-00',NULL,1,0,0),(1230,1231,0,1,'0000-00-00',NULL,1,0,0),(1231,1232,0,1,'0000-00-00',NULL,1,0,0),(1232,1233,0,1,'0000-00-00',NULL,1,0,0),(1233,1234,0,1,'0000-00-00',NULL,1,0,0),(1234,1235,0,1,'0000-00-00',NULL,1,0,0),(1235,1236,0,1,'0000-00-00',NULL,1,0,0),(1236,1237,0,1,'0000-00-00',NULL,1,0,0),(1237,1238,0,1,'0000-00-00',NULL,1,0,0),(1238,1239,0,1,'0000-00-00',NULL,1,0,0),(1239,1240,0,1,'0000-00-00',NULL,1,0,0),(1240,1241,0,1,'0000-00-00',NULL,1,0,0),(1241,1242,0,1,'0000-00-00',NULL,1,0,0),(1242,1243,0,1,'0000-00-00',NULL,1,0,0),(1243,1244,0,1,'0000-00-00',NULL,1,0,0),(1244,1245,0,1,'0000-00-00',NULL,1,0,0),(1245,1246,0,1,'0000-00-00',NULL,1,0,0),(1246,1247,0,1,'0000-00-00',NULL,1,0,0),(1247,1248,0,1,'0000-00-00',NULL,1,0,0),(1248,1249,0,1,'0000-00-00',NULL,1,0,0),(1249,1250,0,1,'0000-00-00',NULL,1,0,0),(1250,1251,0,1,'0000-00-00',NULL,1,0,0),(1251,1252,0,1,'0000-00-00',NULL,1,0,0),(1252,1253,0,1,'0000-00-00',NULL,1,0,0),(1253,1254,0,1,'0000-00-00',NULL,1,0,0),(1254,1255,0,1,'0000-00-00',NULL,1,0,0),(1255,1256,0,1,'0000-00-00',NULL,1,0,0),(1256,1257,0,1,'0000-00-00',NULL,1,0,0),(1257,1258,0,1,'0000-00-00',NULL,1,0,0),(1258,1259,0,1,'0000-00-00',NULL,1,0,0),(1259,1260,0,1,'0000-00-00',NULL,1,0,0),(1260,1261,0,1,'0000-00-00',NULL,1,0,0),(1261,1262,0,1,'0000-00-00',NULL,1,0,0),(1262,1263,0,1,'0000-00-00',NULL,1,0,0),(1263,1264,0,1,'0000-00-00',NULL,1,0,0),(1264,1265,0,1,'0000-00-00',NULL,1,0,0),(1265,1266,0,1,'0000-00-00',NULL,1,0,0),(1266,1267,0,1,'0000-00-00',NULL,1,0,0),(1267,1268,0,1,'0000-00-00',NULL,1,0,0),(1268,1269,0,1,'0000-00-00',NULL,1,0,0),(1269,1270,0,1,'0000-00-00',NULL,1,0,0),(1270,1271,0,1,'0000-00-00',NULL,1,0,0),(1271,1272,0,1,'0000-00-00',NULL,1,0,0),(1272,1273,0,1,'0000-00-00',NULL,1,0,0),(1273,1274,0,1,'0000-00-00',NULL,1,0,0),(1274,1275,0,1,'0000-00-00',NULL,1,0,0),(1275,1276,0,1,'0000-00-00',NULL,1,0,0),(1276,1277,0,1,'0000-00-00',NULL,1,0,0),(1277,1278,0,1,'0000-00-00',NULL,1,0,0),(1278,1279,0,1,'0000-00-00',NULL,1,0,0),(1279,1280,0,1,'0000-00-00',NULL,1,0,0),(1280,1281,0,1,'0000-00-00',NULL,1,0,0),(1281,1282,0,1,'0000-00-00',NULL,1,0,0),(1282,1283,0,1,'0000-00-00',NULL,1,0,0),(1283,1284,0,1,'0000-00-00',NULL,1,0,0),(1284,1285,0,1,'0000-00-00',NULL,1,0,0),(1285,1286,0,1,'0000-00-00',NULL,1,0,0),(1286,1287,0,1,'0000-00-00',NULL,1,0,0),(1287,1288,0,1,'0000-00-00',NULL,1,0,0),(1288,1289,0,1,'0000-00-00',NULL,1,0,0),(1289,1290,0,1,'0000-00-00',NULL,1,0,0),(1290,1291,0,1,'0000-00-00',NULL,1,0,0),(1291,1292,0,1,'0000-00-00',NULL,1,0,0),(1292,1293,0,1,'0000-00-00',NULL,1,0,0),(1293,1294,0,1,'0000-00-00',NULL,1,0,0),(1294,1295,0,1,'0000-00-00',NULL,1,0,0),(1295,1296,0,1,'0000-00-00',NULL,1,0,0),(1296,1297,0,1,'0000-00-00',NULL,1,0,0),(1297,1298,0,1,'0000-00-00',NULL,1,0,0),(1298,1299,0,1,'0000-00-00',NULL,1,0,0),(1299,1300,0,1,'0000-00-00',NULL,1,0,0),(1300,1301,0,1,'0000-00-00',NULL,1,0,0),(1301,1302,0,1,'0000-00-00',NULL,1,0,0),(1302,1303,0,1,'0000-00-00',NULL,1,0,0),(1303,1304,0,1,'0000-00-00',NULL,1,0,0),(1304,1305,0,1,'0000-00-00',NULL,1,0,0),(1305,1306,0,1,'0000-00-00',NULL,1,0,0),(1306,1307,0,1,'0000-00-00',NULL,1,0,0),(1307,1308,0,1,'0000-00-00',NULL,1,0,0),(1308,1309,0,1,'0000-00-00',NULL,1,0,0),(1309,1310,0,1,'0000-00-00',NULL,1,0,0),(1310,1311,0,1,'0000-00-00',NULL,1,0,0),(1311,1312,0,1,'0000-00-00',NULL,1,0,0),(1312,1313,0,1,'0000-00-00',NULL,1,0,0),(1313,1314,0,1,'0000-00-00',NULL,1,0,0),(1314,1315,0,1,'0000-00-00',NULL,1,0,0),(1315,1316,0,1,'0000-00-00',NULL,1,0,0),(1316,1317,0,1,'0000-00-00',NULL,1,0,0),(1317,1318,0,1,'0000-00-00',NULL,1,0,0),(1318,1319,0,1,'0000-00-00',NULL,1,0,0),(1319,1320,0,1,'0000-00-00',NULL,1,0,0),(1320,1321,0,1,'0000-00-00',NULL,1,0,0),(1321,1322,0,1,'0000-00-00',NULL,1,0,0),(1322,1323,0,1,'0000-00-00',NULL,1,0,0),(1323,1324,0,1,'0000-00-00',NULL,1,0,0),(1324,1325,0,1,'0000-00-00',NULL,1,0,0),(1325,1326,0,1,'0000-00-00',NULL,1,0,0),(1326,1327,0,1,'0000-00-00',NULL,1,0,0),(1327,1328,0,1,'0000-00-00',NULL,1,0,0),(1328,1329,0,1,'0000-00-00',NULL,1,0,0),(1329,1330,0,1,'0000-00-00',NULL,1,0,0),(1330,1331,0,1,'0000-00-00',NULL,1,0,0),(1331,1332,0,1,'0000-00-00',NULL,1,0,0),(1332,1333,0,1,'0000-00-00',NULL,1,0,0),(1333,1334,0,1,'0000-00-00',NULL,1,0,0),(1334,1335,0,1,'0000-00-00',NULL,1,0,0),(1335,1336,0,1,'0000-00-00',NULL,1,0,0),(1336,1337,0,1,'0000-00-00',NULL,1,0,0),(1337,1338,0,1,'0000-00-00',NULL,1,0,0),(1338,1339,0,1,'0000-00-00',NULL,1,0,0),(1339,1340,0,1,'0000-00-00',NULL,1,0,0),(1340,1341,0,1,'0000-00-00',NULL,1,0,0),(1341,1342,0,1,'0000-00-00',NULL,1,0,0),(1342,1343,0,1,'0000-00-00',NULL,1,0,0),(1343,1344,0,1,'0000-00-00',NULL,1,0,0),(1344,1345,0,1,'0000-00-00',NULL,1,0,0),(1345,1346,0,1,'0000-00-00',NULL,1,0,0),(1346,1347,0,1,'0000-00-00',NULL,1,0,0),(1347,1348,0,1,'0000-00-00',NULL,1,0,0),(1348,1349,0,1,'0000-00-00',NULL,1,0,0),(1349,1350,0,1,'0000-00-00',NULL,1,0,0),(1350,1351,0,1,'0000-00-00',NULL,1,0,0),(1351,1352,0,1,'0000-00-00',NULL,1,0,0),(1352,1353,0,1,'0000-00-00',NULL,1,0,0),(1353,1354,0,1,'0000-00-00',NULL,1,0,0),(1354,1355,0,1,'0000-00-00',NULL,1,0,0),(1355,1356,0,1,'0000-00-00',NULL,1,0,0),(1356,1357,0,1,'0000-00-00',NULL,1,0,0),(1357,1358,0,1,'0000-00-00',NULL,1,0,0),(1358,1359,0,1,'0000-00-00',NULL,1,0,0),(1359,1360,0,1,'0000-00-00',NULL,1,0,0),(1360,1361,0,1,'0000-00-00',NULL,1,0,0),(1361,1362,0,1,'0000-00-00',NULL,1,0,0),(1362,1363,0,1,'0000-00-00',NULL,1,0,0),(1363,1364,0,1,'0000-00-00',NULL,1,0,0),(1364,1365,0,1,'0000-00-00',NULL,1,0,0),(1365,1366,0,1,'0000-00-00',NULL,1,0,0),(1366,1367,0,1,'0000-00-00',NULL,1,0,0),(1367,1368,0,1,'0000-00-00',NULL,1,0,0),(1368,1369,0,1,'0000-00-00',NULL,1,0,0),(1369,1370,0,1,'0000-00-00',NULL,1,0,0),(1370,1371,0,1,'0000-00-00',NULL,1,0,0),(1371,1372,0,1,'0000-00-00',NULL,1,0,0),(1372,1373,0,1,'0000-00-00',NULL,1,0,0),(1373,1374,0,1,'0000-00-00',NULL,1,0,0),(1374,1375,0,1,'0000-00-00',NULL,1,0,0),(1375,1376,0,1,'0000-00-00',NULL,1,0,0),(1376,1377,0,1,'0000-00-00',NULL,1,0,0),(1377,1378,0,1,'0000-00-00',NULL,1,0,0),(1378,1379,0,1,'0000-00-00',NULL,1,0,0),(1379,1380,0,1,'0000-00-00',NULL,1,0,0),(1380,1381,0,1,'0000-00-00',NULL,1,0,0),(1381,1382,0,1,'0000-00-00',NULL,1,0,0),(1382,1383,0,1,'0000-00-00',NULL,1,0,0),(1383,1384,0,1,'0000-00-00',NULL,1,0,0),(1384,1385,0,1,'0000-00-00',NULL,1,0,0),(1385,1386,0,1,'0000-00-00',NULL,1,0,0),(1386,1387,0,1,'0000-00-00',NULL,1,0,0),(1387,1388,0,1,'0000-00-00',NULL,1,0,0),(1388,1389,0,1,'0000-00-00',NULL,1,0,0),(1389,1390,0,1,'0000-00-00',NULL,1,0,0),(1390,1391,0,1,'0000-00-00',NULL,1,0,0),(1391,1392,0,1,'0000-00-00',NULL,1,0,0),(1392,1393,0,1,'0000-00-00',NULL,1,0,0),(1393,1394,0,1,'0000-00-00',NULL,1,0,0),(1394,1395,0,1,'0000-00-00',NULL,1,0,0),(1395,1396,0,1,'0000-00-00',NULL,1,0,0),(1396,1397,0,1,'0000-00-00',NULL,1,0,0),(1397,1398,0,1,'0000-00-00',NULL,1,0,0),(1398,1399,0,1,'0000-00-00',NULL,1,0,0),(1399,1400,0,1,'0000-00-00',NULL,1,0,0),(1400,1401,0,1,'0000-00-00',NULL,1,0,0),(1401,1402,0,1,'0000-00-00',NULL,1,0,0),(1402,1403,0,1,'0000-00-00',NULL,1,0,0),(1403,1404,0,1,'0000-00-00',NULL,1,0,0),(1404,1405,0,1,'0000-00-00',NULL,1,0,0),(1405,1406,0,1,'0000-00-00',NULL,1,0,0),(1406,1407,0,1,'0000-00-00',NULL,1,0,0),(1407,1408,0,1,'0000-00-00',NULL,1,0,0),(1408,1409,0,1,'0000-00-00',NULL,1,0,0),(1409,1410,0,1,'0000-00-00',NULL,1,0,0),(1410,1411,0,1,'0000-00-00',NULL,1,0,0),(1411,1412,0,1,'0000-00-00',NULL,1,0,0),(1412,1413,0,1,'0000-00-00',NULL,1,0,0),(1413,1414,0,1,'0000-00-00',NULL,1,0,0),(1414,1415,0,1,'0000-00-00',NULL,1,0,0),(1415,1416,0,1,'0000-00-00',NULL,1,0,0),(1416,1417,0,1,'0000-00-00',NULL,1,0,0),(1417,1418,0,1,'0000-00-00',NULL,1,0,0),(1418,1419,0,1,'0000-00-00',NULL,1,0,0),(1419,1420,0,1,'0000-00-00',NULL,1,0,0),(1420,1421,0,1,'0000-00-00',NULL,1,0,0),(1421,1422,0,1,'0000-00-00',NULL,1,0,0),(1422,1423,0,1,'0000-00-00',NULL,1,0,0),(1423,1424,0,1,'0000-00-00',NULL,1,0,0),(1424,1425,0,1,'0000-00-00',NULL,1,0,0),(1425,1426,0,1,'0000-00-00',NULL,1,0,0),(1426,1427,0,1,'0000-00-00',NULL,1,0,0),(1427,1428,0,1,'0000-00-00',NULL,1,0,0),(1428,1429,0,1,'0000-00-00',NULL,1,0,0),(1429,1430,0,1,'0000-00-00',NULL,1,0,0),(1430,1431,0,1,'0000-00-00',NULL,1,0,0),(1431,1432,0,1,'0000-00-00',NULL,1,0,0),(1432,1433,0,1,'0000-00-00',NULL,1,0,0),(1433,1434,0,1,'0000-00-00',NULL,1,0,0),(1434,1435,0,1,'0000-00-00',NULL,1,0,0),(1435,1436,0,1,'0000-00-00',NULL,1,0,0),(1436,1437,0,1,'0000-00-00',NULL,1,0,0),(1437,1438,0,1,'0000-00-00',NULL,1,0,0),(1438,1439,0,1,'0000-00-00',NULL,1,0,0),(1439,1440,0,1,'0000-00-00',NULL,1,0,0),(1440,1441,0,1,'0000-00-00',NULL,1,0,0),(1441,1442,0,1,'0000-00-00',NULL,1,0,0),(1442,1443,0,1,'0000-00-00',NULL,1,0,0),(1443,1444,0,1,'0000-00-00',NULL,1,0,0),(1444,1445,0,1,'0000-00-00',NULL,1,0,0),(1445,1446,0,1,'0000-00-00',NULL,1,0,0),(1446,1447,0,1,'0000-00-00',NULL,1,0,0),(1447,1448,0,1,'0000-00-00',NULL,1,0,0),(1448,1449,0,1,'0000-00-00',NULL,1,0,0),(1449,1450,0,1,'0000-00-00',NULL,1,0,0),(1450,1451,0,1,'0000-00-00',NULL,1,0,0),(1451,1452,0,1,'0000-00-00',NULL,1,0,0),(1452,1453,0,1,'0000-00-00',NULL,1,0,0),(1453,1454,0,1,'0000-00-00',NULL,1,0,0),(1454,1455,0,1,'0000-00-00',NULL,1,0,0),(1455,1456,0,1,'0000-00-00',NULL,1,0,0),(1456,1457,0,1,'0000-00-00',NULL,1,0,0),(1457,1458,0,1,'0000-00-00',NULL,1,0,0),(1458,1459,0,1,'0000-00-00',NULL,1,0,0),(1459,1460,0,1,'0000-00-00',NULL,1,0,0),(1460,1461,0,1,'0000-00-00',NULL,1,0,0),(1461,1462,0,1,'0000-00-00',NULL,1,0,0),(1462,1463,0,1,'0000-00-00',NULL,1,0,0),(1463,1464,0,1,'0000-00-00',NULL,1,0,0),(1464,1465,0,1,'0000-00-00',NULL,1,0,0),(1465,1466,0,1,'0000-00-00',NULL,1,0,0),(1466,1467,0,1,'0000-00-00',NULL,1,0,0),(1467,1468,0,1,'0000-00-00',NULL,1,0,0),(1468,1469,0,1,'0000-00-00',NULL,1,0,0),(1469,1470,0,1,'0000-00-00',NULL,1,0,0),(1470,1471,0,1,'0000-00-00',NULL,1,0,0),(1471,1472,0,1,'0000-00-00',NULL,1,0,0),(1472,1473,0,1,'0000-00-00',NULL,1,0,0),(1473,1474,0,1,'0000-00-00',NULL,1,0,0),(1474,1475,0,1,'0000-00-00',NULL,1,0,0),(1475,1476,0,1,'0000-00-00',NULL,1,0,0),(1476,1477,0,1,'0000-00-00',NULL,1,0,0),(1477,1478,0,1,'0000-00-00',NULL,1,0,0),(1478,1479,0,1,'0000-00-00',NULL,1,0,0),(1479,1480,0,1,'0000-00-00',NULL,1,0,0),(1480,1481,0,1,'0000-00-00',NULL,1,0,0),(1481,1482,0,1,'0000-00-00',NULL,1,0,0),(1482,1483,0,1,'0000-00-00',NULL,1,0,0),(1483,1484,0,1,'0000-00-00',NULL,1,0,0),(1484,1485,0,1,'0000-00-00',NULL,1,0,0),(1485,1486,0,1,'0000-00-00',NULL,1,0,0),(1486,1487,0,1,'0000-00-00',NULL,1,0,0),(1487,1488,0,1,'0000-00-00',NULL,1,0,0),(1488,1489,0,1,'0000-00-00',NULL,1,0,0),(1489,1490,0,1,'0000-00-00',NULL,1,0,0),(1490,1491,0,1,'0000-00-00',NULL,1,0,0),(1491,1492,0,1,'0000-00-00',NULL,1,0,0),(1492,1493,0,1,'0000-00-00',NULL,1,0,0),(1493,1494,0,1,'0000-00-00',NULL,1,0,0),(1494,1495,0,1,'0000-00-00',NULL,1,0,0),(1495,1496,0,1,'0000-00-00',NULL,1,0,0),(1496,1497,0,1,'0000-00-00',NULL,1,0,0),(1497,1498,0,1,'0000-00-00',NULL,1,0,0),(1498,1499,0,1,'0000-00-00',NULL,1,0,0),(1499,1500,0,1,'0000-00-00',NULL,1,0,0),(1500,1501,0,1,'0000-00-00',NULL,1,0,0),(1501,1502,0,1,'0000-00-00',NULL,1,0,0),(1502,1503,0,1,'0000-00-00',NULL,1,0,0),(1503,1504,0,1,'0000-00-00',NULL,1,0,0),(1504,1505,0,1,'0000-00-00',NULL,1,0,0),(1505,1506,0,1,'0000-00-00',NULL,1,0,0),(1506,1507,0,1,'0000-00-00',NULL,1,0,0),(1507,1508,0,1,'0000-00-00',NULL,1,0,0),(1508,1509,0,1,'0000-00-00',NULL,1,0,0),(1509,1510,0,1,'0000-00-00',NULL,1,0,0),(1510,1511,0,1,'0000-00-00',NULL,1,0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=551 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription_rates`
--

LOCK TABLES `subscription_rates` WRITE;
/*!40000 ALTER TABLE `subscription_rates` DISABLE KEYS */;
INSERT INTO `subscription_rates` VALUES (1,0,0,0,0,0),(2,11,10,2012,1,10000),(3,1,8,2012,1,750),(4,2,8,2012,1,300),(5,3,8,2012,1,300),(6,4,8,2012,1,400),(7,5,8,2012,1,400),(8,6,8,2012,1,400),(9,7,8,2012,1,400),(10,8,8,2012,1,400),(11,9,8,2012,1,300),(12,10,8,2012,1,500),(13,11,8,2012,1,4000),(14,12,8,2012,1,7000),(15,13,8,2012,1,3300),(16,10,8,2012,2,900),(17,10,8,2012,3,1300),(18,10,8,2012,5,2000),(19,11,8,2012,2,7500),(20,11,8,2012,3,10000),(21,11,8,2012,5,16000),(22,1,9,2012,1,750),(23,2,9,2012,1,300),(24,3,9,2012,1,300),(25,4,9,2012,1,400),(26,5,9,2012,1,400),(27,6,9,2012,1,400),(28,7,9,2012,1,400),(29,8,9,2012,1,400),(30,9,9,2012,1,300),(31,10,9,2012,1,500),(32,11,9,2012,1,1500),(33,12,9,2012,1,4800),(34,13,9,2012,1,3300),(35,10,9,2012,2,900),(36,10,9,2012,3,1300),(37,10,9,2012,5,2000),(38,11,9,2012,2,2250),(39,11,9,2012,3,3500),(40,11,9,2012,5,6000),(41,1,11,2012,2,700),(42,2,11,2012,2,400),(43,3,11,2012,2,400),(44,4,11,2012,2,500),(45,5,11,2012,2,500),(46,6,11,2012,2,500),(47,7,11,2012,2,500),(48,8,11,2012,2,500),(49,9,11,2012,2,400),(50,10,11,2012,2,400),(51,11,11,2012,2,1250),(52,10,11,2012,3,650),(53,10,11,2012,5,1010),(54,11,11,2012,3,1750),(55,11,11,2012,5,3000),(56,1,1,2012,1,0),(57,2,1,2012,1,0),(58,3,1,2012,1,0),(59,4,1,2012,1,0),(60,5,1,2012,1,0),(61,6,1,2012,1,0),(62,7,1,2012,1,0),(63,8,1,2012,1,0),(64,9,1,2012,1,0),(65,10,1,2012,1,0),(66,11,1,2012,1,0),(67,1,2,2012,1,0),(68,2,2,2012,1,0),(69,3,2,2012,1,0),(70,4,2,2012,1,0),(71,5,2,2012,1,0),(72,6,2,2012,1,0),(73,7,2,2012,1,0),(74,8,2,2012,1,0),(75,9,2,2012,1,0),(76,10,2,2012,1,0),(77,11,2,2012,1,0),(78,1,3,2012,1,0),(79,2,3,2012,1,0),(80,3,3,2012,1,0),(81,4,3,2012,1,0),(82,5,3,2012,1,0),(83,6,3,2012,1,0),(84,7,3,2012,1,0),(85,8,3,2012,1,0),(86,9,3,2012,1,0),(87,10,3,2012,1,0),(88,11,3,2012,1,0),(89,1,4,2012,1,0),(90,2,4,2012,1,0),(91,3,4,2012,1,0),(92,4,4,2012,1,0),(93,5,4,2012,1,0),(94,6,4,2012,1,0),(95,7,4,2012,1,0),(96,8,4,2012,1,0),(97,9,4,2012,1,0),(98,10,4,2012,1,0),(99,11,4,2012,1,0),(100,1,5,2012,1,0),(101,2,5,2012,1,0),(102,3,5,2012,1,0),(103,4,5,2012,1,0),(104,5,5,2012,1,0),(105,6,5,2012,1,0),(106,7,5,2012,1,0),(107,8,5,2012,1,0),(108,9,5,2012,1,0),(109,10,5,2012,1,0),(110,11,5,2012,1,0),(111,1,6,2012,1,0),(112,2,6,2012,1,0),(113,3,6,2012,1,0),(114,4,6,2012,1,0),(115,5,6,2012,1,0),(116,6,6,2012,1,0),(117,7,6,2012,1,0),(118,8,6,2012,1,0),(119,9,6,2012,1,0),(120,10,6,2012,1,0),(121,11,6,2012,1,0),(122,1,7,2012,1,0),(123,2,7,2012,1,0),(124,3,7,2012,1,0),(125,4,7,2012,1,0),(126,5,7,2012,1,0),(127,6,7,2012,1,0),(128,7,7,2012,1,0),(129,8,7,2012,1,0),(130,9,7,2012,1,0),(131,10,7,2012,1,0),(132,11,7,2012,1,0),(133,1,14,2012,1,0),(134,2,14,2012,1,0),(135,3,14,2012,1,0),(136,4,14,2012,1,0),(137,5,14,2012,1,0),(138,6,14,2012,1,0),(139,7,14,2012,1,0),(140,8,14,2012,1,0),(141,9,14,2012,1,0),(142,10,14,2012,1,0),(143,11,14,2012,1,0),(144,1,8,2011,1,750),(145,2,8,2011,1,300),(146,3,8,2011,1,300),(147,4,8,2011,1,400),(148,5,8,2011,1,400),(149,6,8,2011,1,400),(150,7,8,2011,1,400),(151,8,8,2011,1,400),(152,9,8,2011,1,300),(153,10,8,2011,1,500),(154,11,8,2011,1,4000),(155,12,8,2011,1,6000),(156,13,8,2011,1,3300),(157,10,8,2011,2,900),(158,10,8,2011,3,1300),(159,10,8,2011,5,2000),(160,11,8,2011,2,5400),(161,11,8,2011,3,8000),(162,11,8,2011,5,12000),(163,1,9,2011,1,750),(164,2,9,2011,1,300),(165,3,9,2011,1,300),(166,4,9,2011,1,400),(167,5,9,2011,1,400),(168,6,9,2011,1,400),(169,7,9,2011,1,400),(170,8,9,2011,1,400),(171,9,9,2011,1,300),(172,10,9,2011,1,500),(173,11,9,2011,1,1500),(174,12,9,2011,1,4200),(175,13,9,2011,1,3300),(176,10,9,2011,2,900),(177,10,9,2011,3,1300),(178,10,9,2011,5,2000),(179,11,9,2011,2,1750),(180,11,9,2011,3,2500),(181,11,9,2011,5,4500),(182,1,11,2011,2,700),(183,2,11,2011,2,400),(184,3,11,2011,2,400),(185,4,11,2011,2,500),(186,5,11,2011,2,500),(187,6,11,2011,2,500),(188,7,11,2011,2,500),(189,8,11,2011,2,500),(190,9,11,2011,2,400),(191,10,11,2011,2,400),(192,11,11,2011,2,1250),(193,10,11,2011,3,650),(194,10,11,2011,5,1010),(195,11,11,2011,3,1600),(196,11,11,2011,5,2700),(197,1,1,2011,1,0),(198,2,1,2011,1,0),(199,3,1,2011,1,0),(200,4,1,2011,1,0),(201,5,1,2011,1,0),(202,6,1,2011,1,0),(203,7,1,2011,1,0),(204,8,1,2011,1,0),(205,9,1,2011,1,0),(206,10,1,2011,1,0),(207,11,1,2011,1,0),(208,1,2,2011,1,0),(209,2,2,2011,1,0),(210,3,2,2011,1,0),(211,4,2,2011,1,0),(212,5,2,2011,1,0),(213,6,2,2011,1,0),(214,7,2,2011,1,0),(215,8,2,2011,1,0),(216,9,2,2011,1,0),(217,10,2,2011,1,0),(218,11,2,2011,1,0),(219,1,3,2011,1,0),(220,2,3,2011,1,0),(221,3,3,2011,1,0),(222,4,3,2011,1,0),(223,5,3,2011,1,0),(224,6,3,2011,1,0),(225,7,3,2011,1,0),(226,8,3,2011,1,0),(227,9,3,2011,1,0),(228,10,3,2011,1,0),(229,11,3,2011,1,0),(230,1,4,2011,1,0),(231,2,4,2011,1,0),(232,3,4,2011,1,0),(233,4,4,2011,1,0),(234,5,4,2011,1,0),(235,6,4,2011,1,0),(236,7,4,2011,1,0),(237,8,4,2011,1,0),(238,9,4,2011,1,0),(239,10,4,2011,1,0),(240,11,4,2011,1,0),(241,1,5,2011,1,0),(242,2,5,2011,1,0),(243,3,5,2011,1,0),(244,4,5,2011,1,0),(245,5,5,2011,1,0),(246,6,5,2011,1,0),(247,7,5,2011,1,0),(248,8,5,2011,1,0),(249,9,5,2011,1,0),(250,10,5,2011,1,0),(251,11,5,2011,1,0),(252,1,6,2011,1,0),(253,2,6,2011,1,0),(254,3,6,2011,1,0),(255,4,6,2011,1,0),(256,5,6,2011,1,0),(257,6,6,2011,1,0),(258,7,6,2011,1,0),(259,8,6,2011,1,0),(260,9,6,2011,1,0),(261,10,6,2011,1,0),(262,11,6,2011,1,0),(263,1,7,2011,1,0),(264,2,7,2011,1,0),(265,3,7,2011,1,0),(266,4,7,2011,1,0),(267,5,7,2011,1,0),(268,6,7,2011,1,0),(269,7,7,2011,1,0),(270,8,7,2011,1,0),(271,9,7,2011,1,0),(272,10,7,2011,1,0),(273,11,7,2011,1,0),(274,1,14,2011,1,0),(275,2,14,2011,1,0),(276,3,14,2011,1,0),(277,4,14,2011,1,0),(278,5,14,2011,1,0),(279,6,14,2011,1,0),(280,7,14,2011,1,0),(281,8,14,2011,1,0),(282,9,14,2011,1,0),(283,10,14,2011,1,0),(284,11,14,2011,1,0),(285,1,8,2010,1,750),(286,2,8,2010,1,300),(287,3,8,2010,1,300),(288,4,8,2010,1,400),(289,5,8,2010,1,400),(290,6,8,2010,1,400),(291,7,8,2010,1,400),(292,8,8,2010,1,400),(293,9,8,2010,1,300),(294,10,8,2010,1,500),(295,11,8,2010,1,4000),(296,12,8,2010,1,6000),(297,13,8,2010,1,3300),(298,10,8,2010,2,900),(299,10,8,2010,3,1300),(300,10,8,2010,5,2000),(301,11,8,2010,2,5400),(302,11,8,2010,3,8000),(303,11,8,2010,5,12000),(304,1,9,2010,1,750),(305,2,9,2010,1,300),(306,3,9,2010,1,300),(307,4,9,2010,1,400),(308,5,9,2010,1,400),(309,6,9,2010,1,400),(310,7,9,2010,1,400),(311,8,9,2010,1,400),(312,9,9,2010,1,300),(313,10,9,2010,1,500),(314,11,9,2010,1,1500),(315,12,9,2010,1,4200),(316,13,9,2010,1,3300),(317,10,9,2010,2,900),(318,10,9,2010,3,1300),(319,10,9,2010,5,2000),(320,11,9,2010,2,1750),(321,11,9,2010,3,2500),(322,11,9,2010,5,4500),(323,1,11,2010,2,700),(324,2,11,2010,2,400),(325,3,11,2010,2,400),(326,4,11,2010,2,500),(327,5,11,2010,2,500),(328,6,11,2010,2,500),(329,7,11,2010,2,500),(330,8,11,2010,2,500),(331,9,11,2010,2,400),(332,10,11,2010,2,400),(333,11,11,2010,2,1250),(334,10,11,2010,3,650),(335,10,11,2010,5,1010),(336,11,11,2010,3,1600),(337,11,11,2010,5,2700),(338,1,1,2010,1,0),(339,2,1,2010,1,0),(340,3,1,2010,1,0),(341,4,1,2010,1,0),(342,5,1,2010,1,0),(343,6,1,2010,1,0),(344,7,1,2010,1,0),(345,8,1,2010,1,0),(346,9,1,2010,1,0),(347,10,1,2010,1,0),(348,11,1,2010,1,0),(349,1,2,2010,1,0),(350,2,2,2010,1,0),(351,3,2,2010,1,0),(352,4,2,2010,1,0),(353,5,2,2010,1,0),(354,6,2,2010,1,0),(355,7,2,2010,1,0),(356,8,2,2010,1,0),(357,9,2,2010,1,0),(358,10,2,2010,1,0),(359,11,2,2010,1,0),(360,1,3,2010,1,0),(361,2,3,2010,1,0),(362,3,3,2010,1,0),(363,4,3,2010,1,0),(364,5,3,2010,1,0),(365,6,3,2010,1,0),(366,7,3,2010,1,0),(367,8,3,2010,1,0),(368,9,3,2010,1,0),(369,10,3,2010,1,0),(370,11,3,2010,1,0),(371,1,4,2010,1,0),(372,2,4,2010,1,0),(373,3,4,2010,1,0),(374,4,4,2010,1,0),(375,5,4,2010,1,0),(376,6,4,2010,1,0),(377,7,4,2010,1,0),(378,8,4,2010,1,0),(379,9,4,2010,1,0),(380,10,4,2010,1,0),(381,11,4,2010,1,0),(382,1,5,2010,1,0),(383,2,5,2010,1,0),(384,3,5,2010,1,0),(385,4,5,2010,1,0),(386,5,5,2010,1,0),(387,6,5,2010,1,0),(388,7,5,2010,1,0),(389,8,5,2010,1,0),(390,9,5,2010,1,0),(391,10,5,2010,1,0),(392,11,5,2010,1,0),(393,1,6,2010,1,0),(394,2,6,2010,1,0),(395,3,6,2010,1,0),(396,4,6,2010,1,0),(397,5,6,2010,1,0),(398,6,6,2010,1,0),(399,7,6,2010,1,0),(400,8,6,2010,1,0),(401,9,6,2010,1,0),(402,10,6,2010,1,0),(403,11,6,2010,1,0),(404,1,7,2010,1,0),(405,2,7,2010,1,0),(406,3,7,2010,1,0),(407,4,7,2010,1,0),(408,5,7,2010,1,0),(409,6,7,2010,1,0),(410,7,7,2010,1,0),(411,8,7,2010,1,0),(412,9,7,2010,1,0),(413,10,7,2010,1,0),(414,11,7,2010,1,0),(415,1,14,2010,1,0),(416,2,14,2010,1,0),(417,3,14,2010,1,0),(418,4,14,2010,1,0),(419,5,14,2010,1,0),(420,6,14,2010,1,0),(421,7,14,2010,1,0),(422,8,14,2010,1,0),(423,9,14,2010,1,0),(424,10,14,2010,1,0),(425,11,14,2010,1,0),(426,11,10,2009,1,4000),(427,1,11,2009,2,600),(428,2,11,2009,2,350),(429,3,11,2009,2,350),(430,4,11,2009,2,400),(431,5,11,2009,2,400),(432,6,11,2009,2,400),(433,7,11,2009,2,400),(434,8,11,2009,2,350),(435,9,11,2009,2,350),(436,10,11,2009,2,350),(437,11,11,2009,2,900),(438,1,8,2009,1,500),(439,2,8,2009,1,250),(440,3,8,2009,1,250),(441,4,8,2009,1,300),(442,5,8,2009,1,300),(443,6,8,2009,1,300),(444,7,8,2009,1,300),(445,8,8,2009,1,250),(446,9,8,2009,1,250),(447,10,8,2009,1,400),(448,11,8,2009,1,2000),(449,12,8,2009,1,4300),(450,1,9,2009,1,500),(451,2,9,2009,1,250),(452,3,9,2009,1,250),(453,4,9,2009,1,300),(454,5,9,2009,1,300),(455,6,9,2009,1,300),(456,7,9,2009,1,300),(457,8,9,2009,1,250),(458,9,9,2009,1,250),(459,10,9,2009,1,400),(460,11,9,2009,1,750),(461,12,9,2009,1,3200),(462,1,1,2009,1,0),(463,2,1,2009,1,0),(464,3,1,2009,1,0),(465,4,1,2009,1,0),(466,5,1,2009,1,0),(467,6,1,2009,1,0),(468,7,1,2009,1,0),(469,8,1,2009,1,0),(470,9,1,2009,1,0),(471,10,1,2009,1,0),(472,11,1,2009,1,0),(473,1,2,2009,1,0),(474,2,2,2009,1,0),(475,3,2,2009,1,0),(476,4,2,2009,1,0),(477,5,2,2009,1,0),(478,6,2,2009,1,0),(479,7,2,2009,1,0),(480,8,2,2009,1,0),(481,9,2,2009,1,0),(482,10,2,2009,1,0),(483,11,2,2009,1,0),(484,1,3,2009,1,0),(485,2,3,2009,1,0),(486,3,3,2009,1,0),(487,4,3,2009,1,0),(488,5,3,2009,1,0),(489,6,3,2009,1,0),(490,7,3,2009,1,0),(491,8,3,2009,1,0),(492,9,3,2009,1,0),(493,10,3,2009,1,0),(494,11,3,2009,1,0),(495,1,4,2009,1,0),(496,2,4,2009,1,0),(497,3,4,2009,1,0),(498,4,4,2009,1,0),(499,5,4,2009,1,0),(500,6,4,2009,1,0),(501,7,4,2009,1,0),(502,8,4,2009,1,0),(503,9,4,2009,1,0),(504,10,4,2009,1,0),(505,11,4,2009,1,0),(506,1,5,2009,1,0),(507,2,5,2009,1,0),(508,3,5,2009,1,0),(509,4,5,2009,1,0),(510,5,5,2009,1,0),(511,6,5,2009,1,0),(512,7,5,2009,1,0),(513,8,5,2009,1,0),(514,9,5,2009,1,0),(515,10,5,2009,1,0),(516,11,5,2009,1,0),(517,1,6,2009,1,0),(518,2,6,2009,1,0),(519,3,6,2009,1,0),(520,4,6,2009,1,0),(521,5,6,2009,1,0),(522,6,6,2009,1,0),(523,7,6,2009,1,0),(524,8,6,2009,1,0),(525,9,6,2009,1,0),(526,10,6,2009,1,0),(527,11,6,2009,1,0),(528,1,7,2009,1,0),(529,2,7,2009,1,0),(530,3,7,2009,1,0),(531,4,7,2009,1,0),(532,5,7,2009,1,0),(533,6,7,2009,1,0),(534,7,7,2009,1,0),(535,8,7,2009,1,0),(536,9,7,2009,1,0),(537,10,7,2009,1,0),(538,11,7,2009,1,0),(539,1,14,2009,1,0),(540,2,14,2009,1,0),(541,3,14,2009,1,0),(542,4,14,2009,1,0),(543,5,14,2009,1,0),(544,6,14,2009,1,0),(545,7,14,2009,1,0),(546,8,14,2009,1,0),(547,9,14,2009,1,0),(548,10,14,2009,1,0),(549,11,14,2009,1,0),(550,12,11,2012,1,1200);
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
) ENGINE=InnoDB AUTO_INCREMENT=1044 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriptiondetails`
--

LOCK TABLES `subscriptiondetails` WRITE;
/*!40000 ALTER TABLE `subscriptiondetails` DISABLE KEYS */;
INSERT INTO `subscriptiondetails` VALUES (1,1,3,1,2012,1,0,2050,1,1),(2,2,8,1,2012,1,0,2050,1,1),(3,7,8,1,2012,1,0,2050,1,1),(4,7,9,1,2012,1,0,2050,1,1),(5,9,8,1,2012,1,0,2050,1,1),(6,12,2,1,2012,1,0,2050,1,1),(7,21,8,1,2012,1,0,2050,1,1),(8,21,9,1,2012,1,0,2050,1,1),(9,30,8,1,2012,1,0,2050,1,1),(10,30,9,1,2012,1,0,2050,1,1),(11,31,7,1,2012,1,0,2050,1,1),(12,35,8,1,2012,1,0,2050,1,1),(13,35,9,1,2012,1,0,2050,1,1),(14,41,8,1,2012,1,0,2050,1,1),(15,41,9,1,2012,1,0,2050,1,1),(16,43,8,1,2012,1,0,2050,1,1),(17,57,3,1,2012,1,0,2050,1,1),(18,59,1,1,2012,1,0,2050,1,1),(19,59,5,1,2012,1,0,2050,1,1),(20,59,7,1,2012,1,0,2050,1,1),(21,66,1,1,2012,1,0,2050,1,1),(22,69,1,1,2012,1,0,2050,1,1),(23,78,8,1,2012,1,0,2050,1,1),(24,78,9,1,2012,1,0,2050,1,1),(25,79,4,1,2012,1,0,2050,1,1),(26,84,2,1,2012,1,0,2050,1,1),(27,84,4,1,2012,1,0,2050,1,1),(28,85,5,1,2012,1,0,2050,1,1),(29,85,7,1,2012,1,0,2050,1,1),(30,88,8,1,2012,1,0,2050,1,1),(31,90,4,1,2012,1,0,2050,1,1),(32,92,8,1,2012,1,0,2050,1,1),(33,92,9,1,2012,1,0,2050,1,1),(34,95,1,1,2012,1,0,2050,1,1),(35,96,6,1,2012,1,0,2050,1,1),(36,96,7,1,2012,1,0,2050,1,1),(37,97,3,1,2012,1,0,2050,1,1),(38,97,8,1,2012,1,0,2050,1,1),(39,102,6,1,2012,1,0,2050,1,1),(40,103,8,1,2012,1,0,2050,1,1),(41,104,6,1,2012,1,0,2050,1,1),(42,112,3,1,2012,1,0,2050,1,1),(43,114,8,1,2012,1,0,2050,1,1),(44,114,9,1,2012,1,0,2050,1,1),(45,115,2,1,2012,1,0,2050,1,1),(46,115,4,1,2012,1,0,2050,1,1),(47,117,8,1,2012,1,0,2050,1,1),(48,117,9,1,2012,1,0,2050,1,1),(49,123,5,1,2012,1,0,2050,1,1),(50,124,1,1,2012,1,0,2050,1,1),(51,126,8,1,2012,1,0,2050,1,1),(52,126,9,1,2012,1,0,2050,1,1),(53,131,8,1,2012,1,0,2050,1,1),(54,136,1,1,2012,1,0,2050,1,1),(55,136,6,1,2012,1,0,2050,1,1),(56,136,5,1,2012,1,0,2050,1,1),(57,138,4,1,2012,1,0,2050,1,1),(58,141,8,1,2012,1,0,2050,1,1),(59,141,9,1,2012,1,0,2050,1,1),(60,142,1,1,2012,1,0,2050,1,1),(61,142,6,1,2012,1,0,2050,1,1),(62,151,1,1,2012,1,0,2050,1,1),(63,151,6,1,2012,1,0,2050,1,1),(64,152,8,1,2012,1,0,2050,1,1),(65,152,9,1,2012,1,0,2050,1,1),(66,153,8,1,2012,1,0,2050,1,1),(67,153,9,1,2012,1,0,2050,1,1),(68,154,8,1,2012,1,0,2050,1,1),(69,154,9,1,2012,1,0,2050,1,1),(70,155,8,1,2012,1,0,2050,1,1),(71,155,9,1,2012,1,0,2050,1,1),(72,156,3,1,2012,1,0,2050,1,1),(73,156,8,1,2012,1,0,2050,1,1),(74,158,6,1,2012,1,0,2050,1,1),(75,158,5,1,2012,1,0,2050,1,1),(76,171,1,1,2012,1,0,2050,1,1),(77,175,5,1,2012,1,0,2050,1,1),(78,180,8,1,2012,1,0,2050,1,1),(79,182,1,1,2012,1,0,2050,1,1),(80,184,3,1,2012,1,0,2050,1,1),(81,192,1,1,2012,1,0,2050,1,1),(82,192,3,1,2012,1,0,2050,1,1),(83,198,1,1,2012,1,0,2050,1,1),(84,202,6,1,2012,1,0,2050,1,1),(85,205,8,1,2012,1,0,2050,1,1),(86,205,9,1,2012,1,0,2050,1,1),(87,206,1,1,2012,1,0,2050,1,1),(88,206,2,1,2012,1,0,2050,1,1),(89,209,1,1,2012,1,0,2050,1,1),(90,209,6,1,2012,1,0,2050,1,1),(91,211,4,1,2012,1,0,2050,1,1),(92,212,1,1,2012,1,0,2050,1,1),(93,213,8,1,2012,1,0,2050,1,1),(94,214,7,1,2012,1,0,2050,1,1),(95,216,1,1,2012,1,0,2050,1,1),(96,216,5,1,2012,1,0,2050,1,1),(97,218,4,1,2012,1,0,2050,1,1),(98,218,7,1,2012,1,0,2050,1,1),(99,222,6,1,2012,1,0,2050,1,1),(100,222,8,1,2012,1,0,2050,1,1),(101,223,1,1,2012,1,0,2050,1,1),(102,223,2,1,2012,1,0,2050,1,1),(103,228,6,1,2012,1,0,2050,1,1),(104,231,7,1,2012,1,0,2050,1,1),(105,236,1,1,2012,1,0,2050,1,1),(106,236,6,1,2012,1,0,2050,1,1),(107,238,8,1,2012,1,0,2050,1,1),(108,238,9,1,2012,1,0,2050,1,1),(109,241,8,1,2012,1,0,2050,1,1),(110,241,9,1,2012,1,0,2050,1,1),(111,242,8,1,2012,1,0,2050,1,1),(112,247,8,1,2012,1,0,2050,1,1),(113,247,9,1,2012,1,0,2050,1,1),(114,250,1,1,2012,1,0,2050,1,1),(115,253,8,1,2012,1,0,2050,1,1),(116,253,9,1,2012,1,0,2050,1,1),(117,264,1,1,2012,1,0,2050,1,1),(118,270,6,1,2012,1,0,2050,1,1),(119,270,5,1,2012,1,0,2050,1,1),(120,272,4,1,2012,1,0,2050,1,1),(121,272,7,1,2012,1,0,2050,1,1),(122,280,4,1,2012,1,0,2050,1,1),(123,281,9,1,2012,1,0,2050,1,1),(124,282,6,1,2012,1,0,2050,1,1),(125,282,5,1,2012,1,0,2050,1,1),(126,283,6,1,2012,1,0,2050,1,1),(127,286,8,1,2012,1,0,2050,1,1),(128,286,9,1,2012,1,0,2050,1,1),(129,290,4,1,2012,1,0,2050,1,1),(130,290,5,1,2012,1,0,2050,1,1),(131,291,8,1,2012,1,0,2050,1,1),(132,293,8,1,2012,1,0,2050,1,1),(133,293,9,1,2012,1,0,2050,1,1),(134,294,5,1,2012,1,0,2050,1,1),(135,294,8,1,2012,1,0,2050,1,1),(136,303,2,1,2012,1,0,2050,1,1),(137,304,3,1,2012,1,0,2050,1,1),(138,309,8,1,2012,1,0,2050,1,1),(139,309,9,1,2012,1,0,2050,1,1),(140,313,8,1,2012,1,0,2050,1,1),(141,313,9,1,2012,1,0,2050,1,1),(142,314,8,1,2012,1,0,2050,1,1),(143,317,4,1,2012,1,0,2050,1,1),(144,317,7,1,2012,1,0,2050,1,1),(145,318,5,1,2012,1,0,2050,1,1),(146,318,7,1,2012,1,0,2050,1,1),(147,323,6,1,2012,1,0,2050,1,1),(148,324,8,1,2012,1,0,2050,1,1),(149,324,9,1,2012,1,0,2050,1,1),(150,341,8,1,2012,1,0,2050,1,1),(151,344,9,1,2012,1,0,2050,1,1),(152,345,6,1,2012,1,0,2050,1,1),(153,356,4,1,2012,1,0,2050,1,1),(154,361,7,1,2012,1,0,2050,1,1),(155,362,1,1,2012,1,0,2050,1,1),(156,366,8,1,2012,1,0,2050,1,1),(157,367,1,1,2012,1,0,2050,1,1),(158,367,6,1,2012,1,0,2050,1,1),(159,369,6,1,2012,1,0,2050,1,1),(160,373,1,1,2012,1,0,2050,1,1),(161,373,5,1,2012,1,0,2050,1,1),(162,382,3,1,2012,1,0,2050,1,1),(163,388,8,1,2012,1,0,2050,1,1),(164,388,9,1,2012,1,0,2050,1,1),(165,397,6,1,2012,1,0,2050,1,1),(166,397,8,1,2012,1,0,2050,1,1),(167,405,4,1,2012,1,0,2050,1,1),(168,408,3,1,2012,1,0,2050,1,1),(169,408,7,1,2012,1,0,2050,1,1),(170,410,2,1,2012,1,0,2050,1,1),(171,412,7,1,2012,1,0,2050,1,1),(172,414,8,1,2012,1,0,2050,1,1),(173,415,6,1,2012,1,0,2050,1,1),(174,415,9,1,2012,1,0,2050,1,1),(175,419,6,1,2012,1,0,2050,1,1),(176,423,8,1,2012,1,0,2050,1,1),(177,423,9,1,2012,1,0,2050,1,1),(178,425,1,1,2012,1,0,2050,1,1),(179,425,3,1,2012,1,0,2050,1,1),(180,426,2,1,2012,1,0,2050,1,1),(181,426,4,1,2012,1,0,2050,1,1),(182,428,4,1,2012,1,0,2050,1,1),(183,436,1,1,2012,1,0,2050,1,1),(184,436,4,1,2012,1,0,2050,1,1),(185,441,6,1,2012,1,0,2050,1,1),(186,443,8,1,2012,1,0,2050,1,1),(187,443,9,1,2012,1,0,2050,1,1),(188,446,8,1,2012,1,0,2050,1,1),(189,449,6,1,2012,1,0,2050,1,1),(190,449,5,1,2012,1,0,2050,1,1),(191,451,8,1,2012,1,0,2050,1,1),(192,451,9,1,2012,1,0,2050,1,1),(193,452,4,1,2012,1,0,2050,1,1),(194,453,1,1,2012,1,0,2050,1,1),(195,453,5,1,2012,1,0,2050,1,1),(196,455,1,1,2012,1,0,2050,1,1),(197,457,1,1,2012,1,0,2050,1,1),(198,457,6,1,2012,1,0,2050,1,1),(199,462,1,1,2012,1,0,2050,1,1),(200,462,2,1,2012,1,0,2050,1,1),(201,463,8,1,2012,1,0,2050,1,1),(202,471,1,1,2012,1,0,2050,1,1),(203,471,2,1,2012,1,0,2050,1,1),(204,471,3,1,2012,1,0,2050,1,1),(205,471,4,1,2012,1,0,2050,1,1),(206,471,5,1,2012,1,0,2050,1,1),(207,471,7,1,2012,1,0,2050,1,1),(208,471,9,1,2012,1,0,2050,1,1),(209,478,8,1,2012,1,0,2050,1,1),(210,478,9,1,2012,1,0,2050,1,1),(211,479,4,1,2012,1,0,2050,1,1),(212,481,3,1,2012,1,0,2050,1,1),(213,481,7,1,2012,1,0,2050,1,1),(214,485,6,1,2012,1,0,2050,1,1),(215,485,8,1,2012,1,0,2050,1,1),(216,486,6,1,2012,1,0,2050,1,1),(217,486,5,1,2012,1,0,2050,1,1),(218,489,4,1,2012,1,0,2050,1,1),(219,489,5,1,2012,1,0,2050,1,1),(220,490,8,1,2012,1,0,2050,1,1),(221,490,9,1,2012,1,0,2050,1,1),(222,495,4,1,2012,1,0,2050,1,1),(223,498,6,1,2012,1,0,2050,1,1),(224,499,6,1,2012,1,0,2050,1,1),(225,506,4,1,2012,1,0,2050,1,1),(226,511,6,1,2012,1,0,2050,1,1),(227,511,8,1,2012,1,0,2050,1,1),(228,512,8,1,2012,1,0,2050,1,1),(229,516,1,1,2012,1,0,2050,1,1),(230,516,7,1,2012,1,0,2050,1,1),(231,521,6,1,2012,1,0,2050,1,1),(232,521,5,1,2012,1,0,2050,1,1),(233,525,6,1,2012,1,0,2050,1,1),(234,525,8,1,2012,1,0,2050,1,1),(235,534,8,1,2012,1,0,2050,1,1),(236,539,1,1,2012,1,0,2050,1,1),(237,540,3,1,2012,1,0,2050,1,1),(238,541,5,1,2012,1,0,2050,1,1),(239,541,8,1,2012,1,0,2050,1,1),(240,546,8,1,2012,1,0,2050,1,1),(241,547,1,1,2012,1,0,2050,1,1),(242,547,5,1,2012,1,0,2050,1,1),(243,551,5,1,2012,1,0,2050,1,1),(244,556,8,1,2012,1,0,2050,1,1),(245,569,8,1,2012,1,0,2050,1,1),(246,569,9,1,2012,1,0,2050,1,1),(247,575,6,1,2012,1,0,2050,1,1),(248,576,1,1,2012,1,0,2050,1,1),(249,576,2,1,2012,1,0,2050,1,1),(250,579,1,1,2012,1,0,2050,1,1),(251,581,4,1,2012,1,0,2050,1,1),(252,583,6,1,2012,1,0,2050,1,1),(253,583,7,1,2012,1,0,2050,1,1),(254,585,1,1,2012,1,0,2050,1,1),(255,592,8,1,2012,1,0,2050,1,1),(256,593,3,1,2012,1,0,2050,1,1),(257,595,1,1,2012,1,0,2050,1,1),(258,595,3,1,2012,1,0,2050,1,1),(259,597,3,1,2012,1,0,2050,1,1),(260,599,1,1,2012,1,0,2050,1,1),(261,602,4,1,2012,1,0,2050,1,1),(262,604,8,1,2012,1,0,2050,1,1),(263,604,9,1,2012,1,0,2050,1,1),(264,611,1,1,2012,1,0,2050,1,1),(265,612,6,1,2012,1,0,2050,1,1),(266,612,5,1,2012,1,0,2050,1,1),(267,615,6,1,2012,1,0,2050,1,1),(268,615,8,1,2012,1,0,2050,1,1),(269,623,6,1,2012,1,0,2050,1,1),(270,623,7,1,2012,1,0,2050,1,1),(271,625,1,1,2012,1,0,2050,1,1),(272,635,3,1,2012,1,0,2050,1,1),(273,638,1,1,2012,1,0,2050,1,1),(274,638,2,1,2012,1,0,2050,1,1),(275,640,1,1,2012,1,0,2050,1,1),(276,640,5,1,2012,1,0,2050,1,1),(277,642,4,1,2012,1,0,2050,1,1),(278,652,1,1,2012,1,0,2050,1,1),(279,652,2,1,2012,1,0,2050,1,1),(280,653,7,1,2012,1,0,2050,1,1),(281,671,7,1,2012,1,0,2050,1,1),(282,673,8,1,2012,1,0,2050,1,1),(283,673,9,1,2012,1,0,2050,1,1),(284,675,6,1,2012,1,0,2050,1,1),(285,675,5,1,2012,1,0,2050,1,1),(286,686,7,1,2012,1,0,2050,1,1),(287,695,8,1,2012,1,0,2050,1,1),(288,695,9,1,2012,1,0,2050,1,1),(289,699,6,1,2012,1,0,2050,1,1),(290,701,8,1,2012,1,0,2050,1,1),(291,701,9,1,2012,1,0,2050,1,1),(292,708,2,1,2012,1,0,2050,1,1),(293,708,4,1,2012,1,0,2050,1,1),(294,710,1,1,2012,1,0,2050,1,1),(295,710,7,1,2012,1,0,2050,1,1),(296,727,1,1,2012,1,0,2050,1,1),(297,727,7,1,2012,1,0,2050,1,1),(298,734,3,1,2012,1,0,2050,1,1),(299,738,6,1,2012,1,0,2050,1,1),(300,744,1,1,2012,1,0,2050,1,1),(301,744,5,1,2012,1,0,2050,1,1),(302,745,4,1,2012,1,0,2050,1,1),(303,745,8,1,2012,1,0,2050,1,1),(304,752,6,1,2012,1,0,2050,1,1),(305,784,1,1,2012,1,0,2050,1,1),(306,784,6,1,2012,1,0,2050,1,1),(307,800,4,1,2012,1,0,2050,1,1),(308,805,1,1,2012,1,0,2050,1,1),(309,810,4,1,2012,1,0,2050,1,1),(310,814,1,1,2012,1,0,2050,1,1),(311,816,8,1,2012,1,0,2050,1,1),(312,819,5,1,2012,1,0,2050,1,1),(313,819,8,1,2012,1,0,2050,1,1),(314,827,8,1,2012,1,0,2050,1,1),(315,827,9,1,2012,1,0,2050,1,1),(316,832,5,1,2012,1,0,2050,1,1),(317,836,8,1,2012,1,0,2050,1,1),(318,836,9,1,2012,1,0,2050,1,1),(319,837,8,1,2012,1,0,2050,1,1),(320,838,4,1,2012,1,0,2050,1,1),(321,844,7,1,2012,1,0,2050,1,1),(322,844,9,1,2012,1,0,2050,1,1),(323,846,8,1,2012,1,0,2050,1,1),(324,851,8,1,2012,1,0,2050,1,1),(325,851,9,1,2012,1,0,2050,1,1),(326,852,3,1,2012,1,0,2050,1,1),(327,852,4,1,2012,1,0,2050,1,1),(328,861,1,1,2012,1,0,2050,1,1),(329,861,2,1,2012,1,0,2050,1,1),(330,862,3,1,2012,1,0,2050,1,1),(331,864,8,1,2012,1,0,2050,1,1),(332,864,9,1,2012,1,0,2050,1,1),(333,865,8,1,2012,1,0,2050,1,1),(334,865,9,1,2012,1,0,2050,1,1),(335,871,6,1,2012,1,0,2050,1,1),(336,871,5,1,2012,1,0,2050,1,1),(337,876,1,1,2012,1,0,2050,1,1),(338,890,4,1,2012,1,0,2050,1,1),(339,893,4,1,2012,1,0,2050,1,1),(340,895,4,1,2012,1,0,2050,1,1),(341,903,8,1,2012,1,0,2050,1,1),(342,903,9,1,2012,1,0,2050,1,1),(343,904,8,1,2012,1,0,2050,1,1),(344,910,6,1,2012,1,0,2050,1,1),(345,910,8,1,2012,1,0,2050,1,1),(346,913,5,1,2012,1,0,2050,1,1),(347,922,8,1,2012,1,0,2050,1,1),(348,922,9,1,2012,1,0,2050,1,1),(349,923,9,1,2012,1,0,2050,1,1),(350,927,2,1,2012,1,0,2050,1,1),(351,929,8,1,2012,1,0,2050,1,1),(352,938,8,1,2012,1,0,2050,1,1),(353,938,9,1,2012,1,0,2050,1,1),(354,940,6,10,2012,1,0,2050,1,1),(355,950,8,1,2012,1,0,2050,1,1),(356,950,9,1,2012,1,0,2050,1,1),(357,952,6,1,2012,1,0,2050,1,1),(358,954,5,1,2012,1,0,2050,1,1),(359,954,8,1,2012,1,0,2050,1,1),(360,971,6,1,2012,1,0,2050,1,1),(361,975,8,1,2012,1,0,2050,1,1),(362,987,1,1,2012,1,0,2050,1,1),(363,987,6,1,2012,1,0,2050,1,1),(364,991,4,1,2012,1,0,2050,1,1),(365,991,8,1,2012,1,0,2050,1,1),(366,995,8,1,2012,1,0,2050,1,1),(367,1001,5,1,2012,1,0,2050,1,1),(368,1020,4,1,2012,1,0,2050,1,1),(369,1023,5,1,2012,1,0,2050,1,1),(370,1023,6,1,2012,1,0,2050,1,1),(371,1028,1,1,2012,1,0,2050,1,1),(372,1028,2,1,2012,1,0,2050,1,1),(373,1040,8,1,2012,1,0,2050,1,1),(374,1040,9,1,2012,1,0,2050,1,1),(375,1043,5,1,2012,1,0,2050,1,1),(376,1043,8,1,2012,1,0,2050,1,1),(377,1047,1,1,2012,1,0,2050,1,1),(378,1047,4,1,2012,1,0,2050,1,1),(379,1051,3,1,2012,1,0,2050,1,1),(380,1051,7,1,2012,1,0,2050,1,1),(381,1054,5,1,2012,1,0,2050,1,1),(382,1054,8,1,2012,1,0,2050,1,1),(383,1060,3,1,2012,1,0,2050,1,1),(384,1060,7,1,2012,1,0,2050,1,1),(385,1061,10,2,2012,1,0,2050,1,1),(386,1063,10,2,2012,1,0,2050,1,1),(387,1065,10,2,2012,1,0,2050,1,1),(388,1068,10,2,2012,1,0,2050,1,1),(389,1092,4,1,2012,1,0,2050,1,1),(390,1102,10,2,2012,1,0,2050,1,1),(391,1111,10,2,2012,1,0,2050,1,1),(392,1119,10,2,2012,1,0,2050,1,1),(393,1126,10,5,2012,1,0,2050,1,1),(394,1138,10,2,2012,1,0,2050,1,1),(395,1140,10,2,2012,1,0,2050,1,1),(396,1141,5,1,2012,1,0,2050,1,1),(397,1144,5,1,2012,1,0,2050,1,1),(398,1145,4,1,2012,1,0,2050,1,1),(399,1146,4,1,2012,1,0,2050,1,1),(400,1147,4,1,2012,1,0,2050,1,1),(401,1150,4,1,2012,1,0,2050,1,1),(402,1151,4,1,2012,1,0,2050,1,1),(403,1152,4,1,2012,1,0,2050,1,1),(404,1153,4,1,2012,1,0,2050,1,1),(405,1154,4,1,2012,1,0,2050,1,1),(406,1156,1,1,2012,1,0,2050,1,1),(407,1157,1,1,2012,1,0,2050,1,1),(408,1160,3,1,2012,1,0,2050,1,1),(409,1161,3,1,2012,1,0,2050,1,1),(410,1162,3,1,2012,1,0,2050,1,1),(411,1163,3,1,2012,1,0,2050,1,1),(412,1165,6,1,2012,1,0,2050,1,1),(413,1166,10,2,2012,1,0,2050,1,1),(414,1167,10,5,2012,1,0,2050,1,1),(415,1168,10,2,2012,1,0,2050,1,1),(416,1169,10,2,2012,1,0,2050,1,1),(417,1170,10,2,2012,1,0,2050,1,1),(418,1171,10,2,2012,1,0,2050,1,1),(419,1172,10,2,2012,1,0,2050,1,1),(420,1173,10,2,2012,1,0,2050,1,1),(421,1174,7,1,2012,1,0,2050,1,1),(422,1175,7,1,2012,1,0,2050,1,1),(423,1176,7,1,2012,1,0,2050,1,1),(424,1177,7,1,2012,1,0,2050,1,1),(425,1179,7,1,2012,1,0,2050,1,1),(426,1180,7,1,2012,1,0,2050,1,1),(427,1181,7,1,2012,1,0,2050,1,1),(428,1181,10,2,2012,1,0,2050,1,1),(429,1182,10,2,2012,1,0,2050,1,1),(430,1183,10,2,2012,1,0,2050,1,1),(431,1184,10,2,2012,1,0,2050,1,1),(432,1186,8,1,2012,1,0,2050,1,1),(433,1188,8,1,2012,1,0,2050,1,1),(434,1189,8,1,2012,1,0,2050,1,1),(435,1190,8,2,2012,1,0,2050,1,1),(436,1191,8,1,2012,1,0,2050,1,1),(437,1192,8,1,2012,1,0,2050,1,1),(438,1193,8,1,2012,1,0,2050,1,1),(439,1194,8,1,2012,1,0,2050,1,1),(440,1195,8,2,2012,1,0,2050,1,1),(441,1196,8,1,2012,1,0,2050,1,1),(442,1197,8,1,2012,1,0,2050,1,1),(443,1198,8,1,2012,1,0,2050,1,1),(444,1199,8,1,2012,1,0,2050,1,1),(445,1200,8,1,2012,1,0,2050,1,1),(446,1201,8,1,2012,1,0,2050,1,1),(447,1202,8,1,2012,1,0,2050,1,1),(448,1203,8,1,2012,1,0,2050,1,1),(449,1205,4,1,2012,1,0,2050,1,1),(450,1206,9,1,2012,1,0,2050,1,1),(451,1207,9,1,2012,1,0,2050,1,1),(452,1208,9,1,2012,1,0,2050,1,1),(453,1209,9,1,2012,1,0,2050,1,1),(454,1210,9,1,2012,1,0,2050,1,1),(455,1211,9,1,2012,1,0,2050,1,1),(456,1212,9,1,2012,1,0,2050,1,1),(457,1213,9,1,2012,1,0,2050,1,1),(458,1214,9,1,2012,1,0,2050,1,1),(459,1215,9,1,2012,1,0,2050,1,1),(460,1216,9,1,2012,1,0,2050,1,1),(461,1218,9,1,2012,1,0,2050,1,1),(462,1219,9,1,2012,1,0,2050,1,1),(463,1220,9,1,2012,1,0,2050,1,1),(464,1221,9,1,2012,1,0,2050,1,1),(465,1222,9,1,2012,1,0,2050,1,1),(466,1223,9,1,2012,1,0,2050,1,1),(467,1225,9,1,2012,1,0,2050,1,1),(468,1226,9,1,2012,1,0,2050,1,1),(469,1228,9,1,2012,1,0,2050,1,1),(470,1230,9,1,2012,1,0,2050,1,1),(471,1231,9,1,2012,1,0,2050,1,1),(472,1233,9,1,2012,1,0,2050,1,1),(473,1236,9,1,2012,1,0,2050,1,1),(474,1240,4,1,2012,1,0,2050,1,1),(475,1242,9,1,2012,1,0,2050,1,1),(476,1245,1,1,2012,1,0,2050,1,1),(477,1252,8,1,2012,1,0,2050,1,1),(478,1253,8,1,2012,1,0,2050,1,1),(479,1254,8,1,2012,1,0,2050,1,1),(480,1255,8,1,2012,1,0,2050,1,1),(481,1255,9,1,2012,1,0,2050,1,1),(482,1257,8,1,2012,1,0,2050,1,1),(483,1259,2,1,2012,1,0,2050,1,1),(484,1260,2,1,2012,1,0,2050,1,1),(485,1261,2,1,2012,1,0,2050,1,1),(486,1263,2,1,2012,1,0,2050,1,1),(487,1264,2,1,2012,1,0,2050,1,1),(488,1266,1,1,2012,1,0,2050,1,1),(489,1267,1,1,2012,1,0,2050,1,1),(490,1268,5,1,2012,1,0,2050,1,1),(491,1269,5,1,2012,1,0,2050,1,1),(492,1270,5,1,2012,1,0,2050,1,1),(493,1271,5,1,2012,1,0,2050,1,1),(494,1272,5,1,2012,1,0,2050,1,1),(495,1273,5,1,2012,1,0,2050,1,1),(496,1274,5,1,2012,1,0,2050,1,1),(497,1276,5,1,2012,1,0,2050,1,1),(498,1277,5,1,2012,1,0,2050,1,1),(499,1278,5,1,2012,1,0,2050,1,1),(500,1289,10,2,2012,1,0,2050,1,1),(501,1290,7,1,2012,1,0,2050,1,1),(502,1291,8,1,2012,1,0,2050,1,1),(503,1292,4,1,2012,1,0,2050,1,1),(504,1293,7,1,2012,1,0,2050,1,1),(505,1294,10,2,2012,1,0,2050,1,1),(506,1295,10,2,2012,1,0,2050,1,1),(507,1296,10,2,2012,1,0,2050,1,1),(508,1297,10,2,2012,1,0,2050,1,1),(509,1298,10,2,2012,1,0,2050,1,1),(510,1299,10,2,2012,1,0,2050,1,1),(511,1300,10,2,2012,1,0,2050,1,1),(512,1301,10,2,2012,1,0,2050,1,1),(513,1302,10,2,2012,1,0,2050,1,1),(514,1303,10,2,2012,1,0,2050,1,1),(515,1314,6,1,2012,1,0,2050,1,1),(516,1315,6,1,2012,1,0,2050,1,1),(517,1320,6,1,2012,1,0,2050,1,1),(518,1323,6,1,2012,1,0,2050,1,1),(519,1325,6,1,2012,1,0,2050,1,1),(520,1326,10,2,2012,1,0,2050,1,1),(521,1327,5,1,2012,1,0,2050,1,1),(522,1328,5,1,2012,1,0,2050,1,1),(523,1329,9,1,2012,1,0,2050,1,1),(524,1330,9,1,2012,1,0,2050,1,1),(525,1331,9,1,2012,1,0,2050,1,1),(526,1332,9,1,2012,1,0,2050,1,1),(527,1334,8,1,2012,1,0,2050,1,1),(528,1335,8,1,2012,1,0,2050,1,1),(529,1336,8,1,2012,1,0,2050,1,1),(530,1337,4,1,2012,1,0,2050,1,1),(531,1338,7,1,2012,1,0,2050,1,1),(532,1343,3,1,2012,1,0,2050,1,1),(533,1345,5,1,2012,1,0,2050,1,1),(534,1345,1,1,2012,1,0,2050,1,1),(535,1346,6,1,2012,1,0,2050,1,1),(536,1347,5,1,2012,1,0,2050,1,1),(537,1348,6,1,2012,1,0,2050,1,1),(538,1356,6,1,2012,1,0,2050,1,1),(539,1357,5,1,2012,1,0,2050,1,1),(540,1357,1,1,2012,1,0,2050,1,1),(541,1357,6,1,2012,1,0,2050,1,1),(542,1358,5,1,2012,1,0,2050,1,1),(543,1360,1,1,2012,1,0,2050,1,1),(544,1360,2,1,2012,1,0,2050,1,1),(545,1361,5,1,2012,1,0,2050,1,1),(546,1361,3,1,2012,1,0,2050,1,1),(547,1363,1,1,2012,1,0,2050,1,1),(548,1364,5,1,2012,1,0,2050,1,1),(549,1366,5,1,2012,1,0,2050,1,1),(550,1366,4,1,2012,1,0,2050,1,1),(551,1366,2,1,2012,1,0,2050,1,1),(552,1368,1,1,2012,1,0,2050,1,1),(553,1370,1,1,2012,1,0,2050,1,1),(554,1370,8,1,2012,1,0,2050,1,1),(555,1384,8,1,2012,1,0,2050,1,1),(556,1384,9,1,2012,1,0,2050,1,1),(557,1394,1,1,2012,1,0,2050,1,1),(558,1394,2,1,2012,1,0,2050,1,1),(559,1394,3,1,2012,1,0,2050,1,1),(560,1394,4,1,2012,1,0,2050,1,1),(561,1394,6,1,2012,1,0,2050,1,1),(562,1394,5,1,2012,1,0,2050,1,1),(563,1394,7,1,2012,1,0,2050,1,1),(564,1394,8,1,2012,1,0,2050,1,1),(565,1394,9,2,2012,1,0,2050,1,1),(566,1395,1,1,2012,1,0,2050,1,1),(567,1395,2,1,2012,1,0,2050,1,1),(568,1395,3,1,2012,1,0,2050,1,1),(569,1395,4,1,2012,1,0,2050,1,1),(570,1395,6,1,2012,1,0,2050,1,1),(571,1395,5,1,2012,1,0,2050,1,1),(572,1395,7,1,2012,1,0,2050,1,1),(573,1395,8,1,2012,1,0,2050,1,1),(574,1395,9,1,2012,1,0,2050,1,1),(575,1396,1,1,2012,1,0,2050,1,1),(576,1396,2,1,2012,1,0,2050,1,1),(577,1396,3,1,2012,1,0,2050,1,1),(578,1396,4,1,2012,1,0,2050,1,1),(579,1396,6,1,2012,1,0,2050,1,1),(580,1396,5,1,2012,1,0,2050,1,1),(581,1396,7,1,2012,1,0,2050,1,1),(582,1396,8,1,2012,1,0,2050,1,1),(583,1396,9,1,2012,1,0,2050,1,1),(584,1397,1,1,2012,1,0,2050,1,1),(585,1397,2,1,2012,1,0,2050,1,1),(586,1397,3,1,2012,1,0,2050,1,1),(587,1397,4,1,2012,1,0,2050,1,1),(588,1397,6,1,2012,1,0,2050,1,1),(589,1397,5,1,2012,1,0,2050,1,1),(590,1397,7,1,2012,1,0,2050,1,1),(591,1397,8,1,2012,1,0,2050,1,1),(592,1397,9,1,2012,1,0,2050,1,1),(593,1398,1,1,2012,1,0,2050,1,1),(594,1398,2,1,2012,1,0,2050,1,1),(595,1398,3,1,2012,1,0,2050,1,1),(596,1398,4,1,2012,1,0,2050,1,1),(597,1398,6,1,2012,1,0,2050,1,1),(598,1398,5,1,2012,1,0,2050,1,1),(599,1398,7,1,2012,1,0,2050,1,1),(600,1398,8,1,2012,1,0,2050,1,1),(601,1398,9,2,2012,1,0,2050,1,1),(602,1399,1,1,2012,1,0,2050,1,1),(603,1399,2,1,2012,1,0,2050,1,1),(604,1399,3,1,2012,1,0,2050,1,1),(605,1399,4,1,2012,1,0,2050,1,1),(606,1399,6,1,2012,1,0,2050,1,1),(607,1399,5,1,2012,1,0,2050,1,1),(608,1399,7,1,2012,1,0,2050,1,1),(609,1399,8,1,2012,1,0,2050,1,1),(610,1399,9,1,2012,1,0,2050,1,1),(611,1400,1,1,2012,1,0,2050,1,1),(612,1400,2,1,2012,1,0,2050,1,1),(613,1400,3,1,2012,1,0,2050,1,1),(614,1400,4,1,2012,1,0,2050,1,1),(615,1400,6,1,2012,1,0,2050,1,1),(616,1400,5,1,2012,1,0,2050,1,1),(617,1400,7,1,2012,1,0,2050,1,1),(618,1400,8,1,2012,1,0,2050,1,1),(619,1400,9,1,2012,1,0,2050,1,1),(620,1401,1,1,2012,1,0,2050,1,1),(621,1401,2,1,2012,1,0,2050,1,1),(622,1401,3,1,2012,1,0,2050,1,1),(623,1401,4,1,2012,1,0,2050,1,1),(624,1401,6,1,2012,1,0,2050,1,1),(625,1401,5,1,2012,1,0,2050,1,1),(626,1401,7,1,2012,1,0,2050,1,1),(627,1401,8,1,2012,1,0,2050,1,1),(628,1401,9,1,2012,1,0,2050,1,1),(629,1402,1,1,2012,1,0,2050,1,1),(630,1402,2,1,2012,1,0,2050,1,1),(631,1402,3,1,2012,1,0,2050,1,1),(632,1402,4,1,2012,1,0,2050,1,1),(633,1402,6,1,2012,1,0,2050,1,1),(634,1402,5,1,2012,1,0,2050,1,1),(635,1402,7,1,2012,1,0,2050,1,1),(636,1402,8,1,2012,1,0,2050,1,1),(637,1402,9,1,2012,1,0,2050,1,1),(638,1402,10,1,2012,1,0,2050,1,1),(639,1403,1,1,2012,1,0,2050,1,1),(640,1403,2,1,2012,1,0,2050,1,1),(641,1403,3,1,2012,1,0,2050,1,1),(642,1403,4,1,2012,1,0,2050,1,1),(643,1403,6,1,2012,1,0,2050,1,1),(644,1403,5,1,2012,1,0,2050,1,1),(645,1403,7,1,2012,1,0,2050,1,1),(646,1403,8,1,2012,1,0,2050,1,1),(647,1403,9,1,2012,1,0,2050,1,1),(648,1404,11,1,2012,1,0,2050,1,1),(649,1404,5,1,2012,1,0,2050,1,1),(650,1405,11,1,2012,1,0,2050,1,1),(651,1405,1,1,2012,1,0,2050,1,1),(652,1405,2,1,2012,1,0,2050,1,1),(653,1405,4,1,2012,1,0,2050,1,1),(654,1405,6,1,2012,1,0,2050,1,1),(655,1405,5,1,2012,1,0,2050,1,1),(656,1405,7,1,2012,1,0,2050,1,1),(657,1405,8,1,2012,1,0,2050,1,1),(658,1405,9,1,2012,1,0,2050,1,1),(659,1407,3,1,2012,1,0,2050,1,1),(660,1408,1,1,2012,1,0,2050,1,1),(661,1409,11,1,2012,1,0,2050,1,1),(662,1409,1,2,2012,1,0,2050,1,1),(663,1409,2,2,2012,1,0,2050,1,1),(664,1409,3,2,2012,1,0,2050,1,1),(665,1409,4,2,2012,1,0,2050,1,1),(666,1409,6,2,2012,1,0,2050,1,1),(667,1409,5,2,2012,1,0,2050,1,1),(668,1409,7,2,2012,1,0,2050,1,1),(669,1409,8,2,2012,1,0,2050,1,1),(670,1409,9,2,2012,1,0,2050,1,1),(671,1410,8,1,2012,1,0,2050,1,1),(672,1412,8,1,2012,1,0,2050,1,1),(673,1413,8,1,2012,1,0,2050,1,1),(674,1414,8,1,2012,1,0,2050,1,1),(675,1415,8,1,2012,1,0,2050,1,1),(676,1416,11,1,2012,1,0,2050,1,1),(677,1416,5,1,2012,1,0,2050,1,1),(678,1417,11,1,2012,1,0,2050,1,1),(679,1417,4,1,2012,1,0,2050,1,1),(680,1417,5,1,2012,1,0,2050,1,1),(681,1417,8,1,2012,1,0,2050,1,1),(682,1417,9,1,2012,1,0,2050,1,1),(683,1418,11,1,2012,1,0,2050,1,1),(684,1418,1,1,2012,1,0,2050,1,1),(685,1418,2,1,2012,1,0,2050,1,1),(686,1418,3,1,2012,1,0,2050,1,1),(687,1418,4,1,2012,1,0,2050,1,1),(688,1418,6,1,2012,1,0,2050,1,1),(689,1418,5,1,2012,1,0,2050,1,1),(690,1418,7,1,2012,1,0,2050,1,1),(691,1419,11,1,2012,1,0,2050,1,1),(692,1419,3,1,2012,1,0,2050,1,1),(693,1419,4,1,2012,1,0,2050,1,1),(694,1419,5,1,2012,1,0,2050,1,1),(695,1420,7,1,2012,1,0,2050,1,1),(696,1421,11,1,2012,1,0,2050,1,1),(697,1421,3,1,2012,1,0,2050,1,1),(698,1421,4,1,2012,1,0,2050,1,1),(699,1421,5,1,2012,1,0,2050,1,1),(700,1422,3,1,2012,1,0,2050,1,1),(701,1422,4,1,2012,1,0,2050,1,1),(702,1423,11,1,2012,1,0,2050,1,1),(703,1423,4,1,2012,1,0,2050,1,1),(704,1423,5,1,2012,1,0,2050,1,1),(705,1423,8,1,2012,1,0,2050,1,1),(706,1424,11,1,2012,1,0,2050,1,1),(707,1424,3,1,2012,1,0,2050,1,1),(708,1424,4,1,2012,1,0,2050,1,1),(709,1424,5,1,2012,1,0,2050,1,1),(710,1424,8,1,2012,1,0,2050,1,1),(711,1425,11,1,2012,1,0,2050,1,1),(712,1425,1,1,2012,1,0,2050,1,1),(713,1425,3,1,2012,1,0,2050,1,1),(714,1425,4,1,2012,1,0,2050,1,1),(715,1425,6,1,2012,1,0,2050,1,1),(716,1425,5,1,2012,1,0,2050,1,1),(717,1425,8,1,2012,1,0,2050,1,1),(718,1426,11,1,2012,1,0,2050,1,1),(719,1426,1,1,2012,1,0,2050,1,1),(720,1426,3,1,2012,1,0,2050,1,1),(721,1426,4,1,2012,1,0,2050,1,1),(722,1426,5,1,2012,1,0,2050,1,1),(723,1426,8,1,2012,1,0,2050,1,1),(724,1427,3,1,2012,1,0,2050,1,1),(725,1427,4,1,2012,1,0,2050,1,1),(726,1427,8,1,2012,1,0,2050,1,1),(727,1428,11,1,2012,1,0,2050,1,1),(728,1428,3,1,2012,1,0,2050,1,1),(729,1428,4,1,2012,1,0,2050,1,1),(730,1428,5,1,2012,1,0,2050,1,1),(731,1428,8,1,2012,1,0,2050,1,1),(732,1429,11,1,2012,1,0,2050,1,1),(733,1429,3,1,2012,1,0,2050,1,1),(734,1429,4,1,2012,1,0,2050,1,1),(735,1429,5,1,2012,1,0,2050,1,1),(736,1429,8,1,2012,1,0,2050,1,1),(737,1430,3,1,2012,1,0,2050,1,1),(738,1430,7,1,2012,1,0,2050,1,1),(739,1431,2,3,2012,1,0,2050,1,1),(740,1431,9,1,2012,1,0,2050,1,1),(741,1432,11,1,2012,1,0,2050,1,1),(742,1432,1,1,2012,1,0,2050,1,1),(743,1432,2,1,2012,1,0,2050,1,1),(744,1432,3,1,2012,1,0,2050,1,1),(745,1432,4,1,2012,1,0,2050,1,1),(746,1432,6,1,2012,1,0,2050,1,1),(747,1432,5,1,2012,1,0,2050,1,1),(748,1432,7,1,2012,1,0,2050,1,1),(749,1432,8,1,2012,1,0,2050,1,1),(750,1432,9,1,2012,1,0,2050,1,1),(751,1433,11,1,2012,1,0,2050,1,1),(752,1433,1,1,2012,1,0,2050,1,1),(753,1433,2,1,2012,1,0,2050,1,1),(754,1433,3,1,2012,1,0,2050,1,1),(755,1433,4,1,2012,1,0,2050,1,1),(756,1433,6,1,2012,1,0,2050,1,1),(757,1433,5,1,2012,1,0,2050,1,1),(758,1433,7,1,2012,1,0,2050,1,1),(759,1433,8,1,2012,1,0,2050,1,1),(760,1433,9,1,2012,1,0,2050,1,1),(761,1434,11,1,2012,1,0,2050,1,1),(762,1434,1,1,2012,1,0,2050,1,1),(763,1434,2,1,2012,1,0,2050,1,1),(764,1434,3,1,2012,1,0,2050,1,1),(765,1434,4,1,2012,1,0,2050,1,1),(766,1434,6,1,2012,1,0,2050,1,1),(767,1434,5,1,2012,1,0,2050,1,1),(768,1434,7,1,2012,1,0,2050,1,1),(769,1434,8,1,2012,1,0,2050,1,1),(770,1434,9,1,2012,1,0,2050,1,1),(771,1435,11,1,2012,1,0,2050,1,1),(772,1435,1,1,2012,1,0,2050,1,1),(773,1435,2,1,2012,1,0,2050,1,1),(774,1435,3,1,2012,1,0,2050,1,1),(775,1435,4,1,2012,1,0,2050,1,1),(776,1435,6,1,2012,1,0,2050,1,1),(777,1435,5,1,2012,1,0,2050,1,1),(778,1435,7,1,2012,1,0,2050,1,1),(779,1435,8,1,2012,1,0,2050,1,1),(780,1435,9,1,2012,1,0,2050,1,1),(781,1436,11,1,2012,1,0,2050,1,1),(782,1436,1,1,2012,1,0,2050,1,1),(783,1436,2,1,2012,1,0,2050,1,1),(784,1436,3,1,2012,1,0,2050,1,1),(785,1436,4,1,2012,1,0,2050,1,1),(786,1436,6,1,2012,1,0,2050,1,1),(787,1436,5,1,2012,1,0,2050,1,1),(788,1436,7,1,2012,1,0,2050,1,1),(789,1436,8,1,2012,1,0,2050,1,1),(790,1436,9,1,2012,1,0,2050,1,1),(791,1437,11,1,2012,1,0,2050,1,1),(792,1437,1,1,2012,1,0,2050,1,1),(793,1437,2,1,2012,1,0,2050,1,1),(794,1437,3,1,2012,1,0,2050,1,1),(795,1437,4,1,2012,1,0,2050,1,1),(796,1437,6,1,2012,1,0,2050,1,1),(797,1437,5,1,2012,1,0,2050,1,1),(798,1437,7,1,2012,1,0,2050,1,1),(799,1437,8,1,2012,1,0,2050,1,1),(800,1437,9,1,2012,1,0,2050,1,1),(801,1438,11,1,2012,1,0,2050,1,1),(802,1438,1,1,2012,1,0,2050,1,1),(803,1438,2,1,2012,1,0,2050,1,1),(804,1438,3,1,2012,1,0,2050,1,1),(805,1438,4,1,2012,1,0,2050,1,1),(806,1438,6,1,2012,1,0,2050,1,1),(807,1438,5,1,2012,1,0,2050,1,1),(808,1438,7,1,2012,1,0,2050,1,1),(809,1438,8,1,2012,1,0,2050,1,1),(810,1438,9,1,2012,1,0,2050,1,1),(811,1439,11,1,2012,1,0,2050,1,1),(812,1439,1,1,2012,1,0,2050,1,1),(813,1439,2,1,2012,1,0,2050,1,1),(814,1439,3,1,2012,1,0,2050,1,1),(815,1439,4,1,2012,1,0,2050,1,1),(816,1439,6,1,2012,1,0,2050,1,1),(817,1439,5,1,2012,1,0,2050,1,1),(818,1439,7,1,2012,1,0,2050,1,1),(819,1439,8,1,2012,1,0,2050,1,1),(820,1439,9,1,2012,1,0,2050,1,1),(821,1440,11,1,2012,1,0,2050,1,1),(822,1440,1,1,2012,1,0,2050,1,1),(823,1440,2,1,2012,1,0,2050,1,1),(824,1440,3,1,2012,1,0,2050,1,1),(825,1440,4,1,2012,1,0,2050,1,1),(826,1440,6,1,2012,1,0,2050,1,1),(827,1440,5,1,2012,1,0,2050,1,1),(828,1440,7,1,2012,1,0,2050,1,1),(829,1440,8,1,2012,1,0,2050,1,1),(830,1440,9,1,2012,1,0,2050,1,1),(831,1441,11,1,2012,1,0,2050,1,1),(832,1441,1,1,2012,1,0,2050,1,1),(833,1441,2,1,2012,1,0,2050,1,1),(834,1441,3,1,2012,1,0,2050,1,1),(835,1441,4,1,2012,1,0,2050,1,1),(836,1441,6,1,2012,1,0,2050,1,1),(837,1441,5,1,2012,1,0,2050,1,1),(838,1441,7,1,2012,1,0,2050,1,1),(839,1441,8,1,2012,1,0,2050,1,1),(840,1441,9,1,2012,1,0,2050,1,1),(841,1442,11,1,2012,1,0,2050,1,1),(842,1442,1,1,2012,1,0,2050,1,1),(843,1442,2,1,2012,1,0,2050,1,1),(844,1442,3,1,2012,1,0,2050,1,1),(845,1442,4,1,2012,1,0,2050,1,1),(846,1442,6,1,2012,1,0,2050,1,1),(847,1442,5,1,2012,1,0,2050,1,1),(848,1442,7,1,2012,1,0,2050,1,1),(849,1442,8,1,2012,1,0,2050,1,1),(850,1442,9,1,2012,1,0,2050,1,1),(851,1444,11,1,2012,1,0,2050,1,1),(852,1444,1,1,2012,1,0,2050,1,1),(853,1444,2,1,2012,1,0,2050,1,1),(854,1444,3,1,2012,1,0,2050,1,1),(855,1444,4,1,2012,1,0,2050,1,1),(856,1444,6,1,2012,1,0,2050,1,1),(857,1444,5,1,2012,1,0,2050,1,1),(858,1444,7,1,2012,1,0,2050,1,1),(859,1444,8,1,2012,1,0,2050,1,1),(860,1444,9,1,2012,1,0,2050,1,1),(861,1445,11,1,2012,1,0,2050,1,1),(862,1445,1,1,2012,1,0,2050,1,1),(863,1445,2,1,2012,1,0,2050,1,1),(864,1445,3,1,2012,1,0,2050,1,1),(865,1445,4,1,2012,1,0,2050,1,1),(866,1445,6,1,2012,1,0,2050,1,1),(867,1445,5,1,2012,1,0,2050,1,1),(868,1445,7,1,2012,1,0,2050,1,1),(869,1445,9,1,2012,1,0,2050,1,1),(870,1446,11,1,2012,1,0,2050,1,1),(871,1446,1,1,2012,1,0,2050,1,1),(872,1446,2,1,2012,1,0,2050,1,1),(873,1446,3,1,2012,1,0,2050,1,1),(874,1446,4,1,2012,1,0,2050,1,1),(875,1446,6,1,2012,1,0,2050,1,1),(876,1446,5,1,2012,1,0,2050,1,1),(877,1446,7,1,2012,1,0,2050,1,1),(878,1446,8,1,2012,1,0,2050,1,1),(879,1446,9,1,2012,1,0,2050,1,1),(880,1447,11,1,2012,1,0,2050,1,1),(881,1447,1,1,2012,1,0,2050,1,1),(882,1447,2,1,2012,1,0,2050,1,1),(883,1447,3,1,2012,1,0,2050,1,1),(884,1447,4,1,2012,1,0,2050,1,1),(885,1447,6,1,2012,1,0,2050,1,1),(886,1447,5,1,2012,1,0,2050,1,1),(887,1447,7,1,2012,1,0,2050,1,1),(888,1447,9,1,2012,1,0,2050,1,1),(889,1448,11,1,2012,1,0,2050,1,1),(890,1448,1,1,2012,1,0,2050,1,1),(891,1448,2,1,2012,1,0,2050,1,1),(892,1448,3,1,2012,1,0,2050,1,1),(893,1448,4,1,2012,1,0,2050,1,1),(894,1448,6,1,2012,1,0,2050,1,1),(895,1448,5,1,2012,1,0,2050,1,1),(896,1448,7,1,2012,1,0,2050,1,1),(897,1448,8,1,2012,1,0,2050,1,1),(898,1448,9,1,2012,1,0,2050,1,1),(899,1449,11,1,2012,1,0,2050,1,1),(900,1449,10,1,2012,1,0,2050,1,1),(901,1449,1,1,2012,1,0,2050,1,1),(902,1449,2,1,2012,1,0,2050,1,1),(903,1449,3,1,2012,1,0,2050,1,1),(904,1449,4,1,2012,1,0,2050,1,1),(905,1449,6,1,2012,1,0,2050,1,1),(906,1449,5,1,2012,1,0,2050,1,1),(907,1449,7,1,2012,1,0,2050,1,1),(908,1449,8,1,2012,1,0,2050,1,1),(909,1449,9,1,2012,1,0,2050,1,1),(910,1450,8,1,2012,1,0,2050,1,1),(911,1453,8,3,2012,1,0,2050,1,1),(912,1454,11,1,2012,1,0,2050,1,1),(913,1454,1,1,2012,1,0,2050,1,1),(914,1454,2,1,2012,1,0,2050,1,1),(915,1454,3,1,2012,1,0,2050,1,1),(916,1454,4,1,2012,1,0,2050,1,1),(917,1454,6,1,2012,1,0,2050,1,1),(918,1454,5,1,2012,1,0,2050,1,1),(919,1454,7,1,2012,1,0,2050,1,1),(920,1454,8,1,2012,1,0,2050,1,1),(921,1454,9,1,2012,1,0,2050,1,1),(922,1457,7,1,2012,1,0,2050,1,1),(923,1458,7,1,2012,1,0,2050,1,1),(924,1459,1,1,2012,1,0,2050,1,1),(925,1460,1,1,2012,1,0,2050,1,1),(926,1461,11,1,2012,1,0,2050,1,1),(927,1461,1,1,2012,1,0,2050,1,1),(928,1461,2,1,2012,1,0,2050,1,1),(929,1461,3,1,2012,1,0,2050,1,1),(930,1461,4,1,2012,1,0,2050,1,1),(931,1461,6,1,2012,1,0,2050,1,1),(932,1461,5,1,2012,1,0,2050,1,1),(933,1461,7,1,2012,1,0,2050,1,1),(934,1461,8,1,2012,1,0,2050,1,1),(935,1461,9,1,2012,1,0,2050,1,1),(936,1462,3,1,2012,1,0,2050,1,1),(937,1463,11,1,2012,1,0,2050,1,1),(938,1463,1,1,2012,1,0,2050,1,1),(939,1463,2,1,2012,1,0,2050,1,1),(940,1463,3,1,2012,1,0,2050,1,1),(941,1463,4,1,2012,1,0,2050,1,1),(942,1463,6,1,2012,1,0,2050,1,1),(943,1463,5,1,2012,1,0,2050,1,1),(944,1463,7,1,2012,1,0,2050,1,1),(945,1463,8,1,2012,1,0,2050,1,1),(946,1463,9,1,2012,1,0,2050,1,1),(947,1464,1,1,2012,1,0,2050,1,1),(948,1465,1,1,2012,1,0,2050,1,1),(949,1465,3,1,2012,1,0,2050,1,1),(950,1466,1,1,2012,1,0,2050,1,1),(951,1467,7,1,2012,1,0,2050,1,1),(952,1468,4,1,2012,1,0,2050,1,1),(953,1469,2,1,2012,1,0,2050,1,1),(954,1470,11,1,2012,1,0,2050,1,1),(955,1470,1,1,2012,1,0,2050,1,1),(956,1470,2,1,2012,1,0,2050,1,1),(957,1470,3,1,2012,1,0,2050,1,1),(958,1470,5,1,2012,1,0,2050,1,1),(959,1472,3,1,2012,1,0,2050,1,1),(960,1473,11,1,2012,1,0,2050,1,1),(961,1473,1,1,2012,1,0,2050,1,1),(962,1473,3,1,2012,1,0,2050,1,1),(963,1473,6,1,2012,1,0,2050,1,1),(964,1473,5,1,2012,1,0,2050,1,1),(965,1473,7,1,2012,1,0,2050,1,1),(966,1474,6,1,2012,1,0,2050,1,1),(967,1475,7,1,2012,1,0,2050,1,1),(968,1476,11,1,2012,1,0,2050,1,1),(969,1476,1,1,2012,1,0,2050,1,1),(970,1476,2,1,2012,1,0,2050,1,1),(971,1476,3,1,2012,1,0,2050,1,1),(972,1476,4,1,2012,1,0,2050,1,1),(973,1476,6,1,2012,1,0,2050,1,1),(974,1476,5,1,2012,1,0,2050,1,1),(975,1476,7,1,2012,1,0,2050,1,1),(976,1476,8,1,2012,1,0,2050,1,1),(977,1476,9,1,2012,1,0,2050,1,1),(978,1477,11,1,2012,1,0,2050,1,1),(979,1477,1,1,2012,1,0,2050,1,1),(980,1477,2,1,2012,1,0,2050,1,1),(981,1477,3,1,2012,1,0,2050,1,1),(982,1477,4,1,2012,1,0,2050,1,1),(983,1477,6,1,2012,1,0,2050,1,1),(984,1477,5,1,2012,1,0,2050,1,1),(985,1477,7,1,2012,1,0,2050,1,1),(986,1477,8,1,2012,1,0,2050,1,1),(987,1477,9,1,2012,1,0,2050,1,1),(988,1478,3,1,2012,1,0,2050,1,1),(989,1479,9,1,2012,1,0,2050,1,1),(990,1482,3,1,2012,1,0,2050,1,1),(991,1484,1,1,2012,1,0,2050,1,1),(992,1484,3,1,2012,1,0,2050,1,1),(993,1485,1,1,2012,1,0,2050,1,1),(994,1485,6,1,2012,1,0,2050,1,1),(995,1486,8,1,2012,1,0,2050,1,1),(996,1486,9,1,2012,1,0,2050,1,1),(997,1487,1,1,2012,1,0,2050,1,1),(998,1488,8,1,2012,1,0,2050,1,1),(999,1488,9,1,2012,1,0,2050,1,1),(1000,1489,3,1,2012,1,0,2050,1,1),(1001,1490,11,1,2012,1,0,2050,1,1),(1002,1490,1,1,2012,1,0,2050,1,1),(1003,1490,2,1,2012,1,0,2050,1,1),(1004,1490,3,1,2012,1,0,2050,1,1),(1005,1490,4,1,2012,1,0,2050,1,1),(1006,1490,6,1,2012,1,0,2050,1,1),(1007,1490,5,1,2012,1,0,2050,1,1),(1008,1490,7,1,2012,1,0,2050,1,1),(1009,1490,8,1,2012,1,0,2050,1,1),(1010,1490,9,1,2012,1,0,2050,1,1),(1011,1491,9,1,2012,1,0,2050,1,1),(1012,1492,11,1,2012,1,0,2050,1,1),(1013,1492,5,1,2012,1,0,2050,1,1),(1014,1493,3,1,2012,1,0,2050,1,1),(1015,1493,4,1,2012,1,0,2050,1,1),(1016,1493,7,1,2012,1,0,2050,1,1),(1017,1494,10,1,2012,1,0,2050,1,1),(1018,1495,10,1,2012,1,0,2050,1,1),(1019,1496,10,1,2012,1,0,2050,1,1),(1020,1497,10,1,2012,1,0,2050,1,1),(1021,1498,4,1,2012,1,0,2050,1,1),(1022,1499,4,1,2012,1,0,2050,1,1),(1023,1499,8,1,2012,1,0,2050,1,1),(1024,1500,11,1,2012,1,0,2050,1,1),(1025,1500,5,1,2012,1,0,2050,1,1),(1026,1500,8,1,2012,1,0,2050,1,1),(1027,1501,11,1,2012,1,0,2050,1,1),(1028,1501,3,1,2012,1,0,2050,1,1),(1029,1501,5,1,2012,1,0,2050,1,1),(1030,1501,8,1,2012,1,0,2050,1,1),(1031,1502,8,1,2012,1,0,2050,1,1),(1032,1503,3,1,2012,1,0,2050,1,1),(1033,1504,1,1,2012,1,0,2050,1,1),(1034,1506,6,1,2012,1,0,2050,1,1),(1035,1507,1,1,2012,1,0,2050,1,1),(1036,1508,8,1,2012,1,0,2050,1,1),(1037,1509,8,1,2012,1,0,2050,1,1),(1038,1510,1,1,2012,1,0,2050,1,1),(1039,1510,2,1,2012,1,0,2050,1,1),(1040,1510,3,1,2012,1,0,2050,1,1),(1041,1510,4,1,2012,1,0,2050,1,1),(1042,1510,6,1,2012,1,0,2050,1,1),(1043,1510,8,1,2012,1,0,2050,1,1);
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
INSERT INTO `temp_sub_rate` VALUES (1,'Pramana - Journal of Physics','Indian Personnel',2012,0,700,0,0),(2,'Journal of Astrophysics and Astronomy','Indian Personnel',2012,0,400,0,0),(3,'Proceedings (Mathematical Sciences)','Indian Personnel',2012,0,400,0,0),(4,'Journal of Earth System Science (formerly Proc. Earth Planet Sci.)','Indian Personnel',2012,0,500,0,0),(5,'Journal of Chemical Sciences (formerly Proc. Chemical Sci.)','Indian Personnel',2012,0,500,0,0),(6,'Bulletin of Materials Science','Indian Personnel',2012,0,500,0,0),(7,'Sadhana (Engineering Sciences)','Indian Personnel',2012,0,500,0,0),(8,'Journal of Biosciences','Indian Personnel',2012,0,500,0,0),(9,'Journal of Genetics','Indian Personnel',2012,0,400,0,0),(10,'Resonanace - Journal of Science Education','Indian Personnel',2012,0,400,650,1010),(11,'Current Science','Indian Personnel',2012,0,1250,1750,3000),(12,'1-11 All Journals','Indian Personnel',2012,0,0,0,0),(13,'1-10 Journals','Indian Personnel',2012,0,0,0,0);
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
      DECLARE print_order_found int default 0;
      
	    DECLARE cur1 CURSOR FOR 
        SELECT t1.id,t1.journalcode,t1.journalname
        from journals t1;
 
      DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
      
      delete from circulation_figure;
   
   OPEN cur1;
   
     read_loop: LOOP

          FETCH cur1 INTO journal_id, journal_code, journal_name;
          set print_order_value = 0;
          IF done = 1 THEN
            LEAVE read_loop;
          END IF;       
          
          SELECT COUNT(*) into print_order_found FROM print_order WHERE `year` = cir_year and journalId = journal_id;
          if print_order_found > 0 then
              select annualprintOrder into print_order_value from print_order where `year` = cir_year and journalId = journal_id;
          end if;
          
          select COALESCE(sum(mailing_list_detail.copies),0) into inst_i
          from mailing_list_detail,subscriber_type
          where mailing_list_detail.subtypecode = subscriber_type.subtypecode
          and subscriber_type.nationality = 'I' AND subscriber_type.institutional = 'I'
          and mailing_list_detail.`year` = cir_year and subscriber_type.subtype = 'PAID' 
          and mailing_list_detail.journalId = journal_id;
          
          select COALESCE(sum(mailing_list_detail.copies),0) into inst_f
          from mailing_list_detail,subscriber_type
          where mailing_list_detail.subtypecode = subscriber_type.subtypecode
          and subscriber_type.nationality = 'F' AND subscriber_type.institutional = 'I'
          and mailing_list_detail.`year` = cir_year and subscriber_type.subtype = 'PAID' 
          and mailing_list_detail.journalId = journal_id;
          
          select COALESCE(sum(mailing_list_detail.copies),0) into ind_i
          from mailing_list_detail,subscriber_type
          where mailing_list_detail.subtypecode = subscriber_type.subtypecode
          and subscriber_type.nationality = 'I' AND subscriber_type.institutional = 'P'
          and mailing_list_detail.`year` = cir_year and subscriber_type.subtype = 'PAID' 
          and mailing_list_detail.journalId = journal_id;
          
          select COALESCE(sum(mailing_list_detail.copies),0) into ind_f
          from mailing_list_detail,subscriber_type
          where mailing_list_detail.subtypecode = subscriber_type.subtypecode
          and subscriber_type.nationality = 'F' AND subscriber_type.institutional = 'P'
          and mailing_list_detail.`year` = cir_year and subscriber_type.subtype = 'PAID' 
          and mailing_list_detail.journalId = journal_id;
          
          select COALESCE(sum(mailing_list_detail.copies),0) into auth
          from mailing_list_detail,subscriber_type
          where mailing_list_detail.subtypecode = subscriber_type.subtypecode
          and subscriber_type.subtypecode = 'AUTH'
          and mailing_list_detail.`year` = cir_year
          and mailing_list_detail.journalId = journal_id;
          
          select COALESCE(sum(mailing_list_detail.copies),0) into comp
          from mailing_list_detail, subscriber_type
          where mailing_list_detail.subtypecode = subscriber_type.subtypecode
          and subscriber_type.subtype = 'FREE'
          and mailing_list_detail.`year` = cir_year
          and mailing_list_detail.journalId = journal_id;
          
          SET total_copies = inst_i + inst_f + ind_i + ind_f + auth + comp;
          
          insert into circulation_figure ( journalCode ,journalName, instIndia, instAbroad, 
                                           indiIndia, indiAbroad, comp, auth, 
                                           totalCopies, printOrder, balanceCopies) 
          VALUES (journal_code, journal_name, inst_i, inst_f,
                  ind_i, ind_f, comp, auth,
                  total_copies, print_order_value, (print_order_value - total_copies));
          select total_copies;
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
 DECLARE price_rate int DEFAULT 0;
 DECLARE rat_period int DEFAULT 0;
 DECLARE journal_gp_id int;
 DECLARE journal_gp_name varchar(128);
 DECLARE done int DEFAULT 0;
 DECLARE rowcount int DEFAULT 0;

DECLARE

     cur1 CURSOR FOR SELECT id, journalGroupName FROM journal_groups;

      DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

      DELETE FROM temp_sub_rate;

      OPEN cur1;

     read_loop:
      LOOP
         FETCH cur1
           INTO journal_gp_id, journal_gp_name;

         IF done = 1
         THEN
            LEAVE read_loop;
         END IF;

         SELECT journal_gp_id, journal_gp_name;

         SET rowcount = 0;
         SET price_rate = 0;

         -- get the count, ensure the row exists
         SELECT count(*)
           INTO rowcount
           FROM subscription_rates, subscriber_type
          WHERE     subscription_rates.`year` = cir_year
                AND subscription_rates.period = 1
                AND subscription_rates.journalGroupId = journal_gp_id
                AND subscription_rates.subtypeId = subscriber_type.id
                AND subscriber_type.subtypedesc = sub_type_desc;

         IF rowcount > 1
         THEN
            SELECT subscription_rates.rate
              INTO price_rate
              FROM subscription_rates, subscriber_type
             WHERE     subscription_rates.`year` = cir_year
                   AND subscription_rates.period = 1
                   AND subscription_rates.journalGroupId = journal_gp_id
                   AND subscription_rates.subtypeId = subscriber_type.id
                   AND subscriber_type.subtypedesc = sub_type_desc;
         END IF;

         INSERT INTO temp_sub_rate(journalGroupId,
                                   journalGroupName,
                                   subTypeDesc,
                                   `year`,
                                   year1)
         VALUES (journal_gp_id,
                 journal_gp_name,
                 sub_type_desc,
                 cir_year,
                 price_rate);

         SET price_rate = 0;
         SET rowcount = 0;

         SELECT count(*)
           INTO rowcount
           FROM subscription_rates, subscriber_type
          WHERE     subscription_rates.`year` = cir_year
                AND subscription_rates.period = 2
                AND subscription_rates.journalGroupId = journal_gp_id
                AND subscription_rates.subtypeId = subscriber_type.id
                AND subscriber_type.subtypedesc = sub_type_desc;

         IF rowcount > 0
         THEN
            SELECT subscription_rates.rate
              INTO price_rate
              FROM subscription_rates, subscriber_type
             WHERE     subscription_rates.`year` = cir_year
                   AND subscription_rates.period = 2
                   AND subscription_rates.journalGroupId = journal_gp_id
                   AND subscription_rates.subtypeId = subscriber_type.id
                   AND subscriber_type.subtypedesc = sub_type_desc;
         END IF;

         UPDATE temp_sub_rate
            SET year2 = price_rate
          WHERE     journalGroupId = journal_gp_id
                AND journalGroupName = journal_gp_name
                AND subTypeDesc = sub_type_desc
                AND `year` = cir_year;

         SET price_rate = 0;
         SET rowcount = 0;

         SELECT count(*)
           INTO rowcount
           FROM subscription_rates, subscriber_type
          WHERE     subscription_rates.`year` = cir_year
                AND subscription_rates.period = 3
                AND subscription_rates.journalGroupId = journal_gp_id
                AND subscription_rates.subtypeId = subscriber_type.id
                AND subscriber_type.subtypedesc = sub_type_desc;


         IF rowcount > 0
         THEN
            SELECT subscription_rates.rate
              INTO price_rate
              FROM subscription_rates, subscriber_type
             WHERE     subscription_rates.`year` = cir_year
                   AND subscription_rates.period = 3
                   AND subscription_rates.journalGroupId = journal_gp_id
                   AND subscription_rates.subtypeId = subscriber_type.id
                   AND subscriber_type.subtypedesc = sub_type_desc;
         END IF;

         UPDATE temp_sub_rate
            SET year3 = price_rate
          WHERE     journalGroupId = journal_gp_id
                AND journalGroupName = journal_gp_name
                AND subTypeDesc = sub_type_desc
                AND `year` = cir_year;

         SET price_rate = 0;
         SET rowcount = 0;

         SELECT count(*)
           INTO rowcount
           FROM subscription_rates, subscriber_type
          WHERE     subscription_rates.`year` = cir_year
                AND subscription_rates.period = 5
                AND subscription_rates.journalGroupId = journal_gp_id
                AND subscription_rates.subtypeId = subscriber_type.id
                AND subscriber_type.subtypedesc = sub_type_desc;

         IF rowcount > 0
         THEN
            SELECT subscription_rates.rate
              INTO price_rate
              FROM subscription_rates, subscriber_type
             WHERE     subscription_rates.`year` = cir_year
                   AND subscription_rates.period = 5
                   AND subscription_rates.journalGroupId = journal_gp_id
                   AND subscription_rates.subtypeId = subscriber_type.id
                   AND subscriber_type.subtypedesc = sub_type_desc;
         END IF;

         UPDATE temp_sub_rate
            SET year5 = price_rate
          WHERE     journalGroupId = journal_gp_id
                AND journalGroupName = journal_gp_name
                AND subTypeDesc = sub_type_desc
                AND `year` = cir_year;
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

-- Dump completed on 2012-08-04 16:38:13
