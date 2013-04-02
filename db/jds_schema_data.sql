-- MySQL dump 10.13  Distrib 5.5.30, for Win64 (x86)
--
-- Host: localhost    Database: jds
-- ------------------------------------------------------
-- Server version	5.5.30

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
-- Table structure for table `banks`
--

DROP TABLE IF EXISTS `banks`;
CREATE TABLE `banks` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `bank_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`,`bank_name`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;

LOCK TABLES `banks` WRITE;
insert into `banks`(`id`,`bank_name`) values (1,'Allahabad Bank');
insert into `banks`(`id`,`bank_name`) values (2,'Andhra Bank');
insert into `banks`(`id`,`bank_name`) values (3,'Bank of Baroda');
insert into `banks`(`id`,`bank_name`) values (4,'Bank of India');
insert into `banks`(`id`,`bank_name`) values (5,'Bank of Maharashtra');
insert into `banks`(`id`,`bank_name`) values (6,'Canara Bank');
insert into `banks`(`id`,`bank_name`) values (7,'Central Bank of India');
insert into `banks`(`id`,`bank_name`) values (8,'Corporation Bank');
insert into `banks`(`id`,`bank_name`) values (9,'Dena Bank');
insert into `banks`(`id`,`bank_name`) values (10,'IDBI Bank');
insert into `banks`(`id`,`bank_name`) values (11,'Indian Bank');
insert into `banks`(`id`,`bank_name`) values (12,'Indian Overseas Bank');
insert into `banks`(`id`,`bank_name`) values (13,'Oriental Bank of Commerce');
insert into `banks`(`id`,`bank_name`) values (14,'Punjab National Bank');
insert into `banks`(`id`,`bank_name`) values (15,'Syndicate Bank');
insert into `banks`(`id`,`bank_name`) values (16,'Union Bank of India');
insert into `banks`(`id`,`bank_name`) values (17,'UCO Bank');
insert into `banks`(`id`,`bank_name`) values (18,'United Bank of India');
insert into `banks`(`id`,`bank_name`) values (19,'Vijaya Bank');
insert into `banks`(`id`,`bank_name`) values (20,'State Bank of India');
insert into `banks`(`id`,`bank_name`) values (21,'State Bank of Bikaner & Jaipur');
insert into `banks`(`id`,`bank_name`) values (22,'State Bank of Hyderabad');
insert into `banks`(`id`,`bank_name`) values (23,'State Bank of Mysore');
insert into `banks`(`id`,`bank_name`) values (24,'State Bank of Patiala');
insert into `banks`(`id`,`bank_name`) values (25,'State Bank of Travancore');
insert into `banks`(`id`,`bank_name`) values (26,'State Bank of Indore');
insert into `banks`(`id`,`bank_name`) values (27,'State Bank of Saurashtra');
insert into `banks`(`id`,`bank_name`) values (28,'Axis Bank');
insert into `banks`(`id`,`bank_name`) values (29,'HDFC Bank');
insert into `banks`(`id`,`bank_name`) values (30,'ICICI Bank');
insert into `banks`(`id`,`bank_name`) values (31,'Kotak Mahindra Bank');
insert into `banks`(`id`,`bank_name`) values (32,'Karnataka Bank');
insert into `banks`(`id`,`bank_name`) values (33,'Yes Bank');
insert into `banks`(`id`,`bank_name`) values (34,'IndusInd Bank');
insert into `banks`(`id`,`bank_name`) values (35,'ING Vysya Bank');
insert into `banks`(`id`,`bank_name`) values (36,'The Nainital Bank Ltd');
UNLOCK TABLES;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agents`
--

LOCK TABLES `agents` WRITE;
/*!40000 ALTER TABLE `agents` DISABLE KEYS */;
/*!40000 ALTER TABLE `agents` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `agent_invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agent_invoice` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `invoiceNumber` varchar(12) NOT NULL,
  `agentInwardId` int(11) NOT NULL,
  `invoiceCreationDate` date NOT NULL,
  `invoice_type_id` int(11) NOT NULL DEFAULT '1',
  `amount` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `invoice_idx1` (`invoice_type_id`),
  KEY `invoice_indx2` (`invoiceNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agent_invoice`
--

LOCK TABLES `agent_invoice` WRITE;
/*!40000 ALTER TABLE `agent_invoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `agent_invoice` ENABLE KEYS */;
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
  `volume_number` int(11) DEFAULT NULL,
  `issue_number` int(11) NOT NULL,
  `copies` int(11) NOT NULL,
  `sent_to_subscriber` tinyint(4) NOT NULL DEFAULT '0',
  `sent_on` date DEFAULT NULL,
  `added_on` date NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `back_issue_list_indx3` (`subscription_detail_id`,`month`,`year`,`volume_number`,`issue_number`),
  KEY `back_issue_list_indx1` (`subscription_detail_id`) USING BTREE,
  KEY `back_issue_list_indx2` (`sent_to_subscriber`,`active`)
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
-- Table structure for table `chq_return_details`
--

DROP TABLE IF EXISTS `chq_return_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chq_return_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inward_id` int(11) NOT NULL,
  `chq_no` int(6) NOT NULL,
  `chq_date` date NOT NULL,
  `amount` float NOT NULL DEFAULT '0',
  `return_reason_id` int(11) NOT NULL,
  `return_reason_other` varchar(64) DEFAULT NULL,
  `return_date` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_chq_indx` (`inward_id`,`chq_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chq_return_details`
--

LOCK TABLES `chq_return_details` WRITE;
/*!40000 ALTER TABLE `chq_return_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `chq_return_details` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `circulation_figure`
--

LOCK TABLES `circulation_figure` WRITE;
/*!40000 ALTER TABLE `circulation_figure` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=3125 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` VALUES (3116,'1000 CE Amsterdam'),(3108,'199034 St. Petersburg'),(311,'24 Parganas North'),(312,'24 Parganas South'),(3100,'2784-505 Oeiras'),(3110,'70910-900  Brasilia D.F.'),(2947,'Aadepalligudem'),(2972,'Aannd'),(2728,'Abmala'),(1062,'Abohar'),(1583,'Achanputhur'),(968,'Adambakkam'),(388,'Addanki'),(985,'Adilabad'),(1410,'Adimali'),(2558,'Adinathnagar'),(1435,'Adipur'),(2035,'Adirampattinam'),(1604,'Adoni'),(1248,'Adoor'),(794,'Adra'),(2275,'Aduthurai'),(685,'Agartala'),(2512,'Agasteeswaram'),(1,'Agra'),(1860,'Agra Cantt'),(2419,'Ahmadnagar'),(2,'Ahmedabad'),(3089,'Ahmedanad'),(3,'Ahmednagar'),(413,'Aiazawl'),(4,'Aizawl'),(1034,'Aizwal'),(428,'Ajara'),(2383,'Ajitmal'),(5,'Ajmer'),(1981,'Akalkot'),(2638,'Akhada Balapur'),(2857,'Akhnoor'),(3024,'Akluj'),(6,'Akola'),(1643,'Akot'),(2234,'Ala'),(2078,'Alagappanagar'),(2193,'Aland'),(2963,'Alappusha'),(8,'Alappuzha'),(1150,'Alapuzha'),(2265,'Alathur'),(2883,'Ale'),(1564,'Aleppey'),(3103,'Alexandria'),(281,'Alibag'),(7,'Aligarh'),(282,'Aligrah'),(9,'Allahabad'),(2720,'Allahabas'),(1567,'Allahabd'),(10,'Almora'),(3014,'Almorea'),(2533,'Along'),(1960,'Alore'),(846,'Aluva'),(11,'Alwar'),(1682,'Alwarkurichi'),(462,'Alwarkuruchi'),(2612,'Alwasa'),(902,'Alwaye'),(675,'Amalapuram'),(724,'Amalner'),(1949,'Amaravati'),(1536,'Amarvati'),(2021,'Ambad'),(2399,'Ambah'),(1880,'Ambajogai'),(283,'Ambala'),(3042,'Ambala Cant'),(793,'Ambala Cantt'),(2762,'Ambala Cantt.'),(826,'Ambala City'),(2023,'Ambalavayal'),(12,'Ambattur'),(2202,'Ambav'),(13,'Ambernath'),(606,'Amberpet'),(284,'Ambikapur'),(2168,'Ambilikka'),(2065,'Ambur'),(2622,'Amdedabad'),(2104,'Amethi'),(2688,'Amgaon'),(2557,'Amla'),(2602,'Amlagora'),(2059,'Ammandivillai'),(1760,'Amraavati'),(14,'Amravati'),(416,'Amreli'),(15,'Amritsar'),(3040,'Amroha'),(1962,'Amta'),(382,'Anakapalle'),(579,'Anakapalli'),(2169,'Anakkayam'),(934,'Ananatapur'),(285,'Anand'),(1871,'Anandapur'),(2273,'Anandpur Sahib'),(2553,'Anandwan'),(16,'Anantapur'),(1513,'Ananthapur'),(2851,'Ananthpur'),(286,'Anantnag'),(2969,'Anaparthi'),(595,'Anchal'),(2755,'Andal'),(3007,'Andaman'),(1173,'Anekal'),(1236,'Angadikadavu'),(770,'Angamally'),(2379,'Angamaly'),(333,'Angul'),(356,'Anguli'),(2556,'Ankaleshwar'),(869,'Ankleshwar'),(2243,'Ankola'),(629,'Annamalai'),(334,'Annamalai Nagar'),(314,'Annamalainagar'),(1451,'Annur'),(2060,'Anoopshahr'),(2656,'Anumala'),(2764,'Anupgarh'),(755,'Anupuram'),(1532,'Anvardhikanpet'),(2774,'Aonla'),(702,'Ara'),(2241,'Arabhavi'),(2221,'Arachalur'),(778,'Arakkonam'),(1664,'Arakkulam'),(948,'Arakkunnam'),(2278,'Arakulam'),(17,'Araleri'),(2905,'Aralvaymoli'),(2711,'Aralvoimozhi'),(18,'Arambagh'),(637,'Araria'),(2714,'Arasampatti'),(2391,'Arasikere'),(1586,'Aravayal'),(967,'Areacode'),(1562,'Ariyalur'),(699,'Ariyannur'),(2571,'Armoor'),(2127,'Armori'),(2076,'Arni'),(19,'Arrah'),(404,'Arsikere'),(1691,'Arumanai'),(1328,'Arunapuram'),(815,'Aruppukottai'),(2208,'Aruvankadu'),(653,'Aryapur'),(20,'Asansol'),(887,'Ashoknagar'),(560,'Astabad Itarsi'),(1913,'Aswaraopet'),(1461,'AT & P.O.Barh'),(1182,'Atarra'),(2930,'Athani'),(1830,'Athens'),(456,'Athgarh'),(2694,'Atkot'),(442,'Atpadi'),(2862,'Attabira'),(673,'Attingal'),(764,'Attoor'),(531,'Attur'),(681,'Atul'),(1964,'Aundipatti'),(978,'Auraiya'),(21,'Aurangabad'),(1421,'Auroville'),(22,'Avadi'),(2619,'Avidi'),(1867,'Avikanagar'),(1995,'Avinashi'),(2415,'Awantipora'),(1445,'Ayodhya'),(2013,'Ayur'),(1201,'Ayyanthole'),(995,'Azamgarh'),(2407,'Aziznagar'),(2615,'B.G. Nagar'),(1409,'Badagara'),(2403,'Badami'),(3038,'Badchiroli'),(2191,'Baddi'),(287,'Badlapur'),(2792,'Badmal'),(1533,'Badnera'),(441,'Badshahithaul'),(1366,'Badvel'),(619,'Bagalkot'),(1194,'Bagar'),(1089,'Bagdogra'),(802,'Bagepalli'),(1672,'Bagepally'),(3113,'Baghdad'),(1778,'Baghpat'),(1646,'Baghra'),(712,'Bagudi'),(2569,'Bahadurgarh'),(2372,'Bahal'),(2588,'Bahona'),(792,'Bahraich'),(358,'BaihataChariali'),(1185,'Baijnath'),(881,'Bailhongal'),(2010,'Bakewar'),(2884,'Bakhtiarpur'),(2079,'Bakrol'),(2435,'Baksa (BTAD)'),(2476,'Baladmari'),(288,'Balaghat'),(923,'Balangir'),(621,'Balasore'),(1220,'Balikuda'),(1209,'Balisahi'),(2486,'Ballabgarh'),(2046,'Ballarpur'),(1861,'Ballary'),(484,'Ballia'),(23,'Bally'),(2378,'Balod'),(342,'Balrampur'),(392,'Balurghat'),(1246,'Baluti'),(2670,'Bamkhed'),(1703,'Banaskantha'),(1425,'Banasthali'),(2706,'Banaswada'),(751,'Banda'),(1427,'Bandipora'),(1714,'Banga'),(1038,'Bangaaore'),(24,'Bangarpet'),(2051,'Banikhet'),(1407,'Banipur'),(2531,'Banka'),(504,'Bankalagi'),(2318,'Banki'),(1616,'Bankpara'),(341,'Bankura'),(1105,'Banswara'),(2741,'Bantalab'),(1122,'Bantiwal'),(889,'Bantwal'),(1331,'Bapatla'),(1790,'Barabanki'),(577,'Baramati'),(1263,'Baramulla'),(25,'Baranagar'),(3085,'Barapani'),(476,'Barasat'),(2793,'Barauni'),(674,'Baraut'),(2340,'Bardez'),(26,'Bardhaman'),(556,'Bardoli'),(27,'Bareilly'),(304,'Bareli'),(2393,'Barelly'),(1724,'Bargarh'),(2718,'Bargur'),(1520,'Barharwa'),(2540,'Baridh Colony'),(28,'Baripada'),(1252,'Barmer'),(803,'Barnala'),(399,'Barpeta'),(667,'Barrackpore'),(3082,'Barrackpore P.O.'),(651,'Barshi'),(2366,'Baru Sahib'),(3001,'Basanti'),(1771,'Basirhat'),(1441,'Basmath'),(1449,'Bastar'),(1091,'Basti'),(1645,'Basudevpur'),(1526,'Batala'),(29,'Bathinda'),(1455,'Baxi Bazar'),(1361,'Bazpur'),(2962,'Beawar'),(1143,'Beed'),(2505,'Beekar'),(2130,'Beerapalli'),(861,'Begusarai'),(2671,'Bela'),(1837,'Belagavi'),(2109,'Belati'),(3063,'Belavavi'),(2986,'Belda'),(30,'Belgaum'),(31,'Bellary'),(1731,'Belthangadi'),(1539,'Belthangady'),(2998,'Belur Math'),(1825,'Bemetara'),(32,'Bengaluru'),(2697,'Benjanapadavu'),(953,'Berhampore'),(33,'Berhampur'),(3107,'Bethesda, MD 20814'),(1358,'Bethuadahari'),(455,'Bettiah'),(1129,'Betul'),(368,'Bhabua'),(1146,'Bhadohi'),(2385,'Bhadrachalam'),(678,'Bhadrak'),(1297,'Bhadravathi'),(1388,'Bhadravati'),(2542,'Bhadsen'),(34,'Bhagalpur'),(3045,'Bhagur'),(1909,'Bhaila'),(2084,'Bhalki'),(588,'Bhandara'),(1635,'Bhanur'),(1392,'Bharathi Nagara'),(1577,'Bharathinagara'),(2207,'Bharathpur'),(35,'Bharatpur'),(2801,'Bharkatia'),(483,'Bharuch'),(1231,'Bhatapara'),(2794,'Bhathinda Cantt'),(1613,'Bhatkal'),(2268,'Bhatoli'),(36,'Bhatpara'),(1068,'Bhavanisagar'),(37,'Bhavnagar'),(812,'Bhawanipatna'),(2931,'Bhilad'),(38,'Bhilai'),(1050,'Bhilai Nagar'),(2145,'Bhilainagar'),(1579,'Bhillai'),(39,'Bhilwara'),(1095,'Bhimavaram'),(1942,'Bhimtal'),(2437,'Bhind'),(40,'Bhiwandi'),(847,'Bhiwani'),(2828,'Bhiwari'),(289,'Bhojpur'),(1087,'Bhongaon'),(1996,'Bhongir'),(2032,'Bhoom'),(41,'Bhopal'),(2255,'Bhor'),(3034,'Bhtakumarada'),(42,'Bhubaneswar'),(43,'Bhuj'),(2935,'Bhuj-Kachchh'),(2933,'Bhuj-Kutch'),(1555,'Bhunbaneswar'),(844,'Bhusawal'),(2991,'Bicholim'),(1919,'Bidadi'),(44,'Bidar'),(45,'Bidhan Nagar'),(502,'Bidri'),(46,'Bihar Sharif'),(47,'Bijapur'),(718,'Bijhari'),(775,'Bijnor'),(2795,'Bijpur'),(48,'Bikaner'),(3055,'Bilagi'),(2625,'Bilahongala'),(665,'Bilai'),(49,'Bilaspur'),(1689,'Bilimora'),(290,'Bina'),(2790,'Binnaguri'),(540,'Birbhum'),(1238,'Bishnupur'),(2160,'Bobbili'),(2555,'Bodinayakanur'),(989,'Boisar'),(50,'Bokaro'),(437,'Bokaro Thermal'),(799,'Bolangir'),(3069,'Bolangr'),(914,'Bolpur'),(2119,'Bomdila'),(2461,'Bonaigarh'),(707,'Bongaigaon'),(1665,'Borai'),(1142,'Bordez'),(2328,'Bordi'),(2147,'Boriavi'),(2949,'Boudh'),(880,'Boudh  Dist.'),(52,'Brahmapur'),(1911,'Brahmapuri'),(2604,'Brahmavar'),(2430,'Bssti'),(2629,'Bud Bud'),(818,'Budaun'),(357,'Buddhnagar'),(2672,'Budgam'),(1968,'Budhagaya'),(1695,'Bulandshahar'),(1357,'Bulandshahr'),(457,'Buldana'),(3030,'Buldhana'),(51,'Burdwan'),(1601,'Burhanpur'),(1688,'Burhar'),(739,'Burla'),(736,'Burnpur'),(2813,'Bylakuppe'),(3065,'Cachar'),(505,'Calcutta'),(3094,'California 94720'),(3102,'Cambridge CB2 3PY'),(920,'Canacona'),(421,'Canchipur'),(360,'Cannanore'),(1978,'Canning Town'),(2463,'Chaibasa'),(980,'Chaimpal'),(548,'Chaklashi'),(3027,'Chakradharpur'),(2235,'Chalakudy'),(689,'Chalala'),(1024,'Chalisgaon'),(1693,'Challakere'),(853,'Chamarajanagar'),(3041,'Chamarajanagara'),(2781,'Chamba'),(2282,'Chamoli'),(2683,'Champa'),(2249,'Champadanga'),(2675,'Champakulam'),(1697,'Champaran'),(3053,'Champawat'),(2875,'Champua'),(1477,'Chamurchi'),(2506,'Chanasma'),(671,'Chandannagar'),(761,'Chandausi'),(2427,'Chandel'),(2705,'Chandeshwar'),(53,'Chandigarh'),(1498,'Chandimandir'),(1639,'Chandpur'),(54,'Chandrapur'),(2499,'Chandrapura'),(1957,'Chandwad'),(2844,'Changa'),(828,'Changanacherry'),(1103,'Changanachery'),(383,'Changancherry'),(1011,'Changigarh'),(1279,'Channagiri'),(2860,'Channai'),(830,'Channapatna'),(365,'Channarayapatna'),(566,'Chapra'),(2758,'Charbatia'),(559,'Chariali'),(1898,'Charkhi Dadri'),(2520,'Charmapuri'),(2647,'Chavakkad'),(2360,'Chavara'),(2287,'Chemperi'),(2707,'Chemudugunta'),(439,'Chenbalam'),(2280,'Chengalpattu'),(424,'Chengalpet'),(1506,'Chengam'),(422,'Chengannur'),(327,'Chenglepet'),(2804,'Chengottoor'),(55,'Chennai'),(2502,'Chennaraopet'),(1710,'Chennimalai'),(2682,'Chernmahadevi'),(401,'Cherpu'),(1069,'Cherthala'),(1842,'Cheruthuruthy'),(1845,'Chettalli'),(2345,'Chettinad'),(2621,'Chevalla'),(1284,'Chevayur'),(1892,'Chevella'),(870,'Cheyyar'),(951,'Chhatarpur'),(291,'Chhindwara'),(2302,'Chhota Udepur'),(2748,'Chianki'),(1419,'Chicalim'),(1678,'Chickballapur'),(2600,'Chickkaballapur'),(3019,'Chickmagalore'),(805,'Chickmagalur'),(2907,'Chickmangore'),(56,'Chidambaram'),(2701,'Chikani'),(1488,'Chikballapur'),(2143,'Chikhaldara'),(2983,'Chikhali'),(1951,'Chikhli'),(1037,'Chikkaballapur'),(3062,'Chikkamagalur'),(2523,'Chikkanahalli'),(2527,'Chikmagalooru'),(292,'Chikmagalur'),(1003,'Chikodi'),(1948,'Chilakaluripet'),(2770,'Chilka'),(2919,'Chimakurthy'),(1877,'China Amiram'),(2376,'Chincholi'),(2184,'Chinna Salem'),(1746,'Chinnasalem'),(2566,'Chinoutapally'),(662,'Chinsurah'),(1137,'Chintamani'),(293,'Chiplun'),(790,'Chirala'),(2965,'Chirang'),(1950,'Chirawa'),(1788,'Chirmiri'),(2492,'Chitorgarh'),(2580,'Chitradurg'),(343,'Chitradurga'),(1403,'Chitrakoot'),(2684,'Chittivalasa'),(528,'Chittode'),(57,'Chittoor'),(641,'Chittor'),(1614,'Chittorgarh'),(2652,'Chiyyedu'),(2660,'Choondacherry'),(2779,'Chopan'),(785,'Chorvad'),(2141,'Chowdavaram'),(2206,'Chumukedima'),(397,'Chundambatta'),(2063,'Chunkankadai'),(2481,'Churachandpur'),(1045,'Churu'),(1765,'Coch in'),(412,'Cochin'),(58,'Coimbatore'),(2572,'Coimbatyore'),(2510,'Colaghat'),(3096,'Colombo  7'),(3119,'Columbus Ohio'),(1515,'Combum'),(561,'Contai'),(797,'Cooch Behar'),(2623,'Coochbehar'),(575,'Coonoor'),(1064,'Courtallam'),(3124,'CT'),(586,'Cuddalore'),(1463,'Cuddapah'),(361,'Cumbum'),(2992,'Curchorem'),(59,'Cuttack'),(1767,'Cuttak'),(1836,'Dabhoi'),(3018,'Dadri'),(2904,'Dahivel'),(2395,'Dahiwadi'),(1439,'Dahod'),(1576,'Daksin Dinajpur'),(2443,'Daldali'),(1055,'Dalhousie'),(3032,'Dallhousie'),(2517,'Dalli Rajhara'),(1711,'Dalmianagar'),(1431,'Daltonganj'),(700,'Daman'),(1735,'Daman and Diu'),(1850,'Damanjodi'),(1215,'Damoh'),(1602,'Dandeli'),(1595,'Dantewada'),(2953,'Dantiwada'),(1084,'Dapoli'),(60,'Darbhanga'),(432,'Darjeeling'),(1383,'Darrang'),(1086,'Darwha'),(1999,'Dasuya'),(865,'Datia'),(1230,'Dausa'),(61,'Davanagere'),(3044,'Davanagrer'),(62,'Davangere'),(2988,'Debari'),(1483,'Debinagar'),(1296,'Deepshikha'),(1224,'Deepsikha'),(2259,'Degloor'),(3013,'Deharadun'),(3050,'Dehardun'),(2803,'Dehra'),(63,'Dehradun'),(609,'Dehrudun'),(313,'Delhi'),(2536,'Deogarh'),(1145,'Deoghar'),(2381,'Deola'),(2968,'Deolali Camp'),(64,'Deoli'),(2264,'Deori'),(719,'Deoria'),(816,'Deralakatta'),(543,'Deralakatte'),(2086,'Dev Sangha'),(363,'Devakottai'),(2257,'Devanahalli'),(2131,'Devarakonda'),(2343,'Devgad'),(791,'Devlali'),(2055,'Devrukh'),(65,'Dewas'),(1418,'Dhakuakhana'),(1085,'Dhalavalpuram'),(1389,'Dhamangaon'),(1139,'Dhamisa'),(2985,'Dhamtar'),(1033,'Dhamtari'),(66,'Dhanbad'),(758,'Dhar'),(1832,'Dharampura'),(2891,'Dharampuram'),(835,'Dharamsala'),(2578,'Dharapuram'),(1621,'Dharbhanga'),(1440,'Dharmabad'),(332,'Dharmanagar'),(329,'Dharmapuri'),(1676,'Dharmasthala'),(1281,'Dharmavaram'),(754,'Dharmsala'),(67,'Dharwad'),(742,'Dharwar'),(1938,'Dhaulakuan'),(725,'Dhemaji'),(943,'Dhenkanal'),(1903,'Dhilwan'),(2198,'Dhing'),(499,'Dholka'),(1133,'Dholpur'),(1694,'Dhrol'),(2424,'Dhubri'),(68,'Dhule'),(2398,'Dhulipalla'),(2408,'Dhupguri'),(3064,'Dhuri (Sangrur)'),(2200,'Diamond Harbour'),(1072,'Dibiyapur'),(364,'Dibrugarh'),(2987,'Didhihat'),(551,'Didwana'),(1162,'Digapahandi'),(2599,'Digvijaygram'),(1006,'Dikrong'),(915,'Dimapur'),(2118,'Dimpapur'),(1147,'Dinajpur'),(2734,'Dinanagar'),(522,'Dindigal'),(513,'Dindigul'),(470,'Dindlod'),(2805,'Dindori'),(1587,'Dingigul'),(1783,'Diphu'),(2115,'Dirang'),(69,'Doddaballapur'),(2831,'Doddaballapura'),(563,'Doimukh'),(1097,'Dombivali'),(70,'Dombivili'),(737,'Dombiville East'),(766,'Dombivli'),(2289,'Dombivli (E)'),(1752,'Dombivli (W)'),(1119,'Dombivli East'),(71,'Dona Paula'),(2450,'Dongargarh'),(2768,'Donimalai'),(2716,'Doraha'),(3057,'Dousa'),(779,'Dudhondi'),(1113,'Dudhya'),(1379,'Dujana'),(1446,'Duliajan'),(2228,'Dumehar Bani'),(1075,'Dumka'),(2359,'Dumkal'),(1561,'Dumraon'),(2172,'Dundlod'),(1500,'Dungarpur'),(72,'Durg'),(73,'Durgapur'),(1570,'Durgpur'),(2110,'Dwarahat'),(1769,'Dwarka'),(2938,'E.G.Dist'),(891,'E.Godavari'),(603,'Eachome'),(1430,'Eambalam'),(1121,'East Godavari'),(1581,'East Siang'),(2457,'East Sikkim'),(2730,'East-Sikkim'),(1820,'Eastgodavari'),(1019,'Edat'),(74,'Edathala'),(2269,'Edathua'),(1879,'EG Dist'),(998,'Egra'),(2731,'Elagiri Hills'),(997,'Elamdesom'),(1191,'Elavunthitta'),(2033,'Elayampalayam'),(2229,'Elthuruth'),(1728,'Eluro'),(1288,'Eluru'),(2210,'Enathi'),(1433,'Erairimangalam'),(2045,'Erandol'),(905,'Erintalmanna'),(2460,'Ernakula'),(75,'Ernakulam'),(324,'Erode'),(516,'Eroor North'),(1234,'Errattupetta'),(2034,'Erumapatty'),(1422,'Erumeli'),(2886,'Esanthimangalam'),(1338,'Etah'),(76,'Etawah'),(386,'Ettumanoor'),(1340,'Ettuvaicode'),(339,'Faizabad'),(1976,'Faizpur'),(1894,'Farah'),(1540,'Faribabad'),(77,'Faridabad'),(1858,'Faridkot'),(1082,'Faridpur'),(78,'Farrukhabad'),(2984,'Fatehabad'),(1648,'Fatehgarh'),(2635,'Fatehgarh Sahib'),(1476,'Fatehpur'),(2729,'Ferozapur'),(495,'Ferozepur'),(2920,'Ferozpur'),(3093,'Firenze  50131'),(79,'Firozabad'),(2101,'FPO'),(2863,'G Vidyanagar'),(2413,'G.B. Palayam'),(750,'Gadag'),(1633,'Gadag Betageri'),(806,'Gadag Betgeri'),(3088,'Gadanki'),(2099,'Gadarwara'),(942,'Gadchiroli'),(2414,'Gadhinglaj'),(2170,'Gadohiroli'),(2628,'Gagra'),(2854,'Gagrigol'),(1725,'Gajapati'),(2690,'Ganapathipuram'),(1669,'Ganapavaram'),(1186,'Gandhigram'),(80,'Gandhinagar'),(1368,'Gandhinagarn'),(1270,'Gandhinglj'),(2061,'Ganeshguri'),(2037,'Gangakhed'),(2989,'Gangapur'),(2620,'Gangarampalayam'),(1111,'Gangtok'),(2967,'Ganguru'),(2468,'Ganj Basoda'),(1574,'Ganjam'),(859,'Ganjam Dist.'),(2543,'Ganjar'),(1764,'Gannavaram'),(1681,'Ganpat Ganj'),(3086,'Gantok'),(2890,'Garchiroli'),(1985,'Garhdiwala'),(2802,'Garhi'),(809,'Garhwal'),(481,'Gauhati'),(757,'Gauribidanur'),(558,'Gawahati'),(81,'Gaya'),(1211,'Gaziabad'),(2281,'Gevrai'),(3068,'Gharuan'),(999,'Ghatanji'),(2029,'Ghatkesar'),(82,'Ghaziabad'),(429,'Ghazipur'),(1925,'Ghedradi'),(1963,'Ghogaon'),(1545,'Gidderbaha'),(635,'Giridih'),(410,'Goa'),(1377,'Goalpara'),(1450,'Gobi'),(3077,'Gobindgarh'),(1847,'Godavarikhani'),(2256,'Godda'),(983,'Godhra'),(3058,'Gohana'),(2458,'Gohang'),(695,'Gohpur'),(2261,'Gokak'),(1315,'Gokarn'),(1590,'Gola Kheri'),(2791,'Golabandha'),(479,'Golaghat'),(1078,'Golghat'),(2551,'Gollalamamidada'),(782,'Gonda'),(1053,'Gondia'),(2418,'Goniana Mandi'),(2371,'Gonikoppal'),(2689,'Gooty'),(1644,'Gopalbazar'),(83,'Gopalpur'),(1947,'Gopalpur-on-Sea'),(839,'Gopalpuri'),(2673,'Gopeshwar'),(84,'Gorakhpur'),(2436,'Goregaon'),(468,'Gossaigaon'),(2837,'Gowribidanur'),(928,'Greater Noida'),(85,'Gubbi'),(3003,'Gudalur'),(1758,'Gudavalli'),(2833,'Gudibande'),(796,'Gudivada'),(1893,'Gudiyattam'),(2453,'Gudlavalleru'),(773,'Gudur'),(2955,'Gujapati'),(2048,'Gulabpura'),(2568,'Gulaothi'),(86,'Gulbarga'),(2098,'Guledagudda'),(2316,'Gulmarg'),(604,'Gummidi Poondi'),(553,'Guna'),(2470,'Gunjoti'),(1030,'Guntakal'),(87,'Guntur'),(1444,'Gunupur'),(644,'Guragon'),(1275,'Gurdaspur'),(88,'Gurgaon'),(2698,'Gurusar Sadar'),(2293,'Gurusar Sadhar'),(1330,'Guruvayur'),(1303,'Gusiahati'),(2735,'Guskara'),(89,'Guwahati'),(1807,'Guwajati'),(90,'Gwalior'),(1259,'Gyanpur'),(347,'H.S.Chandrapur'),(3031,'Habra'),(2607,'Hadgarh'),(2254,'Haflong'),(1401,'Hailakandi'),(856,'Hajipur'),(2617,'Haldi'),(1292,'Haldia'),(1792,'Haldwani'),(2725,'Haliyala'),(901,'Halkanangale'),(1975,'Halkarni'),(2187,'Halol'),(2773,'Halwara'),(2120,'Hamiprur'),(643,'Hamirpur'),(744,'Hanamkonda'),(1814,'Hansi'),(916,'Hanumanakonda'),(1308,'Hanumangarh'),(91,'Hapur'),(762,'Harapanahalli'),(1744,'Harbin'),(1803,'Harda'),(687,'Hardoi'),(786,'Hardwar'),(449,'Haridwar'),(1249,'Harihar'),(2149,'Harilakandi'),(1489,'Harinavi'),(1208,'Haripal'),(2776,'Harni Road'),(3097,'Harpenden Herts  A15 2JQ'),(3073,'Harur'),(598,'Haryana'),(1525,'Hasimara'),(92,'Hassan'),(1043,'Hathras'),(1619,'Hatiara'),(832,'Hatundi'),(2881,'Haveli'),(2519,'Haveli Ghanapur'),(1010,'Haveri'),(1462,'Hawal'),(2754,'Hayuliang'),(1612,'Hazarbag'),(377,'Hazaribag'),(523,'Hazratbal'),(3081,'Hebbagodi'),(3091,'Herts. SG1 2AY'),(1821,'Herwatta Kumta'),(1517,'Himantnagar'),(1237,'Himatnagar'),(2785,'Himmatnagar'),(1608,'Hindaun'),(419,'Hindupur'),(1470,'Hingoli'),(426,'Hiriadka'),(1755,'Hiriyur'),(2974,'Hiryur'),(93,'Hisar'),(749,'Hissar'),(1365,'Holanagadde'),(622,'Honnavar'),(349,'Hooghly'),(3000,'Hoogly'),(607,'Hosadurga'),(94,'Hosapete'),(512,'Hoshangabad'),(488,'Hoshiarpur'),(2838,'Hoskote'),(374,'Hospet'),(500,'Hosur'),(95,'Howrah'),(315,'Hridaypur'),(96,'Hubballi-Dharwad'),(487,'Hubli'),(1776,'Huderabad'),(2220,'Hulakoti'),(2667,'Humnabad'),(2585,'Hunagunda'),(2422,'Hungund'),(1844,'Hunsur'),(1396,'Hurda'),(1464,'Hutti P.O.'),(2749,'Huvinahadagali'),(2521,'Huzurabad'),(1932,'Hyderaad'),(97,'Hyderabad'),(1768,'Hyderanad'),(1763,'Hyderbad'),(1353,'Hyderqabad'),(1759,'Hydrabad'),(2232,'Ibrahimpatnam'),(98,'Ichalkaranji'),(626,'Ichlampady'),(2008,'Iduki'),(706,'Idukki'),(2310,'Ilakal'),(771,'Ilayangudi'),(646,'Ilhas'),(1554,'Ilhas Tiswani'),(1158,'Ilkal'),(99,'Imphal'),(506,'Imphal East'),(2449,'Indapur'),(2006,'Indirapuram'),(101,'Indore'),(2765,'Indunagar'),(1207,'Inodre'),(3123,'Iowa'),(732,'Irimpanam'),(587,'Irinjalakuda'),(2452,'Israna'),(574,'Isukkazhi'),(2190,'Itachuna'),(100,'Itanagar'),(2818,'Itarsi'),(1918,'Iyyengarkulam'),(2767,'Izat Nagar'),(541,'Izatnagar'),(102,'Jabalpur'),(1241,'Jadar'),(864,'Jadavpur'),(1509,'Jagadalpur'),(2444,'Jagadhri'),(2325,'Jagatballavpur'),(1548,'Jagatsinghpur'),(972,'Jagdalpur'),(2642,'Jagdishpur'),(2489,'Jagiroad'),(1856,'Jagraon'),(1155,'Jagtial'),(2995,'Jahanabad'),(2397,'Jaipru'),(103,'Jaipur'),(2654,'Jaipur Cantt'),(1762,'Jaisalmer'),(1307,'Jaitaran'),(1117,'Jajpur'),(2071,'Jakkasandra'),(104,'Jalandhar'),(2297,'Jalandhar Cantt'),(1757,'Jalaun'),(3011,'Jalesar'),(105,'Jalgaon'),(2951,'Jalgoan'),(106,'Jalna'),(650,'Jalpaiguri'),(936,'Jamalpur'),(2850,'Jamer'),(2975,'Jamkhani'),(2136,'Jamkhed'),(2116,'Jammikunta'),(107,'Jammu'),(1740,'Jammu & Kashmir'),(2799,'Jammu Cantt.'),(452,'Jammu Tawi'),(108,'Jamnagar'),(2173,'Jamner'),(1327,'Jamnipali'),(1233,'Jamnipalli'),(109,'Jamshedpur'),(760,'Jangaon'),(1882,'Janjgir'),(1881,'Janjgir-Champa'),(1127,'Jannur'),(1188,'Jaora'),(759,'Jarangdih Col'),(1314,'Jatharpeth'),(402,'Jaugaon'),(1797,'Jaumpur'),(520,'Jaunpur'),(730,'Jayant'),(1457,'Jayasingpur'),(2584,'Jaypore'),(2724,'Jaysingpur'),(634,'Jehanabad'),(1743,'Jerusalem'),(1255,'Jeypore'),(3020,'Jhabua'),(1009,'Jhajhar'),(1617,'Jhajjar'),(1541,'Jhalawar'),(1168,'Jhalgaon'),(110,'Jhansi'),(2456,'Jharia'),(1428,'Jharipani'),(420,'Jharkhand'),(1417,'Jharsugna'),(1008,'Jharsuguda'),(1649,'Jhinihak'),(2344,'Jhinkpani'),(309,'Jhunjhunu'),(1272,'Jind'),(2112,'Jintur'),(1313,'Jitpur'),(726,'Jobner'),(111,'Jodhpur'),(498,'Jogbani'),(1558,'Jogfalls'),(2746,'Jogindar Nagar'),(1228,'Jognbani'),(545,'Jorhat'),(2778,'Joshimath'),(1351,'Jowai'),(2469,'Joysagar'),(1907,'JP Nagar'),(661,'Junagadh'),(2333,'Junnar'),(591,'Jyotivihar'),(2547,'K Bandarapalli'),(2375,'K R Nagar'),(868,'K.G.F'),(837,'K.G.F.'),(2057,'K.M. Doddi'),(2466,'K.R. Nagar'),(2123,'K.R. Pet'),(1897,'Kada'),(2194,'Kadakkal'),(2351,'Kadakom'),(571,'Kadalundi'),(1257,'Kadamtala'),(112,'Kadapa'),(1733,'Kadara'),(1027,'Kadayanallur'),(2567,'Kadegaon'),(1311,'Kadiri'),(387,'Kadirur'),(1175,'Kadur'),(2513,'Kagithapuram'),(2276,'Kahalgaon'),(1870,'Kahn Pur Khui'),(713,'Kailashahar'),(2358,'Kaipattoor'),(659,'Kaithal'),(2847,'Kakanpur'),(2848,'Kakching'),(113,'Kakinada'),(2649,'Kakkad'),(128,'Kalady'),(2928,'Kalagampudi'),(945,'Kalahandi'),(2788,'Kalaikunda'),(1000,'Kalamassery'),(493,'Kalamb'),(1447,'Kalanour P.O'),(1081,'Kalapet'),(362,'Kalavai'),(2839,'Kalavakkam'),(2873,'Kalayarkoil'),(1886,'Kalburgi'),(918,'Kaliakavilai'),(2321,'Kalianpur'),(2052,'Kalimpong'),(2717,'Kalipatti'),(1939,'Kalippatti'),(2658,'Kaliyaganj'),(480,'Kaliyakavillai'),(2911,'Kalka'),(1501,'Kallachi'),(720,'Kalladka'),(1685,'Kallakurchi'),(2624,'Kallakurichi'),(2853,'Kallanthode'),(1394,'Kalliassery PO'),(1917,'Kallikkandy'),(1940,'Kallooppara'),(964,'Kallur'),(1652,'Kalmijore'),(2893,'Kalol'),(2937,'Kalol (NG)'),(114,'Kalpakkam'),(1779,'Kalpet'),(2646,'Kalpetta'),(833,'Kalugumalai'),(1482,'Kalui'),(1280,'Kalwa'),(2380,'Kalwan'),(647,'Kalyan'),(1754,'Kalyan (E)'),(1622,'Kalyan (W)'),(1059,'Kalyan (West)'),(1751,'Kalyan East'),(1547,'Kalyan Nagar'),(623,'Kalyan West'),(115,'Kalyan-Dombivali'),(116,'Kalyani'),(2334,'Kamakhyanagar'),(2872,'Kamalpur'),(117,'Kamarhati'),(658,'Kambhaladinne'),(1656,'Kampa'),(2161,'Kamptee'),(1198,'Kamrup'),(852,'Kanakapura'),(1258,'Kanale'),(2982,'Kanayakumari'),(1719,'Kancheepuram'),(1750,'Kanchi'),(2039,'Kanchikacherla'),(2626,'Kanchipadi'),(359,'Kanchipuram'),(819,'Kanchrapara'),(2040,'Kandaghat'),(1737,'Kandhamala'),(2054,'Kandhar'),(692,'Kandhla'),(1668,'Kandhwara'),(318,'Kandukur'),(2030,'Kangayam'),(1503,'Kangirapally'),(1021,'Kangra'),(458,'Kanhangad South'),(986,'Kanikapada'),(1593,'Kaniyakumari'),(1282,'Kaniyur'),(1057,'Kanjeepuram'),(497,'Kanjirapally'),(454,'Kanker'),(1607,'Kankipadu'),(1603,'Kankroli'),(2373,'Kannad'),(1726,'Kannauj'),(1376,'Kanniampuram'),(348,'Kannur'),(3036,'Kanour'),(118,'Kanpur'),(1344,'Kantore'),(1575,'Kanur'),(2939,'Kanuru'),(2895,'Kanya Kumari'),(3026,'Kanyakumar'),(119,'Kanyakumari'),(1588,'Kapurthala'),(1375,'Kapurthaza'),(697,'Karad'),(987,'Karadi'),(814,'Karaikal'),(120,'Karaikkudi'),(403,'Karaikudi'),(2878,'Karakambadi'),(2685,'Karakikudi'),(655,'Karamsad'),(1921,'Karanja'),(1997,'Karatadipalayam'),(1718,'Karauli'),(1060,'Karayamuttom'),(1747,'Karbi Anglog'),(981,'Karbi Anglong'),(1926,'Karepally'),(2465,'Kariapatti'),(873,'Kariavattom'),(2225,'Karigiri'),(2148,'Karikkad'),(2088,'Karimbam'),(384,'Karimganj'),(121,'Karimnagar'),(2496,'Karimpur'),(2363,'Karjat'),(2135,'Karkala'),(2352,'Karma'),(1325,'Karnal'),(1511,'Karnya'),(858,'Karopady'),(2497,'Karottukara'),(1780,'Karouli'),(1065,'Karukachal'),(895,'Karukutty'),(2019,'Karumathur'),(2320,'Karungal'),(2377,'Karunguzhi'),(371,'Karur'),(1167,'Karvenagar'),(1240,'Karwar'),(438,'Kasaragod'),(765,'Kasargod'),(451,'Kasargode'),(610,'Kasauli'),(2425,'Kasganj'),(581,'Kashipur'),(501,'Kashmir'),(1523,'Kasibugga'),(1474,'Kathgodam'),(2583,'Kathua'),(638,'Katihar'),(1912,'Katni'),(2011,'Katol'),(850,'Katpadi'),(1047,'Katra'),(1004,'Kattakada'),(394,'Kattakampal'),(1056,'Kattan Kulathur'),(122,'Kattankulathur'),(1242,'Kattappana'),(2528,'Kattor'),(596,'Katwa'),(1599,'Kaup'),(1674,'Kaushambi'),(326,'Kavali'),(2664,'Kavaraipettai'),(2742,'Kavaratti'),(3015,'Kavindapadi'),(2613,'Kawardha'),(2759,'Kayamkulam'),(1966,'Kayangulam'),(2014,'Kedgaon'),(1979,'Keeranur'),(2251,'Keesara'),(1320,'Keezhilam'),(2355,'Kelambakkam'),(1420,'Kendrapara'),(1218,'Keonjhar'),(405,'Kerala'),(1203,'KGF'),(2750,'Khagaria'),(123,'Khagrabari'),(2386,'Khairabad'),(836,'Khairaha'),(2782,'Khairi'),(2494,'Khajipalem'),(2412,'Khambhat'),(897,'Khamgaon'),(490,'Khammam'),(2918,'Khammam Dist'),(925,'Khamman'),(1598,'Khandwa'),(922,'Khanna'),(1563,'Khantura'),(124,'Kharagpur'),(1826,'Kharar'),(2537,'Khargaon'),(1934,'Khargone'),(813,'Kharia'),(2811,'Khariar'),(2478,'Khatav'),(2842,'Khatima'),(1478,'Kheda'),(1789,'Khedbrahma'),(570,'Khelmati'),(1196,'Kherange'),(2036,'Kherva'),(1189,'Khetari'),(472,'Khetri'),(2429,'Khopoli'),(1798,'Khordha'),(1597,'Khurda'),(3046,'Khurdha'),(2025,'Khuri Bari'),(2369,'Khurja'),(1784,'Kichha'),(2691,'Kidangoor'),(2467,'Kidaripatty'),(1219,'Kikkeri P.O.'),(1988,'Kilakarai'),(1154,'Kilimanoor'),(2096,'Kille Dharur'),(893,'Killimangalam'),(1054,'Killur'),(2258,'Kilpennathur'),(460,'Kim'),(2780,'Kinnaur'),(1287,'Kirandul'),(2948,'Kirathoor'),(2554,'Kirei'),(1923,'Kirikera'),(1195,'Kirloskarwadi'),(2882,'Kirtinagar'),(125,'Kishangarh'),(2798,'Kishtwar'),(682,'Kittur'),(1707,'KK Dist'),(2892,'Klawad'),(126,'Kochi'),(649,'Kochi 682'),(2573,'Kodad'),(527,'Kodagu'),(127,'Kodaikanal'),(2548,'Kodakara'),(1671,'Kodavalur'),(1542,'Kodavasal'),(810,'Koderma'),(2859,'Kodigehally'),(2247,'Kodikanal'),(1213,'Kodungallur'),(639,'Kodur'),(1120,'Koduuayoor'),(3105,'Koganeishi 184-8795'),(1373,'Kohima'),(3061,'Kokata'),(950,'Kokrajhar'),(1818,'Kolakata'),(1800,'Kolakta'),(491,'Kolar'),(1952,'Kolasib'),(1245,'Kolencherry'),(389,'Kolenchery'),(129,'Kolhapur'),(130,'Kolkata'),(131,'Kollam (Quilon)'),(323,'Komarapalayam'),(2901,'Komarapayayam'),(735,'Konch Jalan'),(2480,'Kondagaon'),(1889,'Kondair'),(2240,'Kondotty'),(2128,'Kondungallur'),(1371,'Konni'),(1360,'Koodalloor'),(2710,'Koothattukulam'),(1998,'Kopargaon'),(1294,'Koppa'),(686,'Koppal'),(2700,'Korangi'),(926,'Koraput'),(132,'Korba'),(2744,'Korea'),(378,'Koregaon'),(2737,'Korukonda'),(679,'Kostha'),(2349,'Kot-Ise-Khan'),(133,'Kota'),(2387,'Kotagiri'),(134,'Kotala'),(1364,'Kotdwar'),(660,'Kothad'),(1888,'Kothadudem'),(618,'Kothagudem'),(994,'Kothala'),(1904,'Kothamangalam'),(2246,'Kothapar'),(1578,'Kothapet'),(1144,'Kothapeta'),(1512,'Kothecheruvu'),(2866,'Kottakkal'),(2632,'Kottappady'),(2132,'Kottapuram'),(1135,'Kottarakara'),(325,'Kottayam'),(2539,'Kottekad'),(1136,'Kottur'),(1363,'Kovilpatti'),(1496,'Kovvur'),(642,'Kowdiar'),(2643,'Kozhancherry'),(1206,'Kozhencheery'),(1954,'Kozhencheri'),(821,'Kozhikkode'),(393,'Kozhikode'),(135,'Kozhikode (Calicut)'),(1002,'Kozhikodi'),(1713,'Kozhizode'),(1739,'Krimnagar'),(136,'Krishangarh'),(306,'Krishna'),(1267,'Krishna Dist'),(305,'Krishnagar'),(307,'Krishnagiri'),(2303,'Krishnagri'),(2049,'Krishnankoil'),(308,'Krishnapuram'),(1618,'Kudal'),(489,'Kudremukh'),(2587,'Kukas'),(1342,'Kukkundoor'),(2162,'Kulamavu'),(1650,'Kuldharan'),(1126,'Kulgam'),(1799,'Kulithalai'),(1699,'Kullu'),(137,'Kulti'),(1022,'Kumaracoil'),(874,'Kumarapatnam'),(1309,'Kumarhatti'),(1112,'Kumata'),(1100,'Kumbakoman'),(486,'Kumbakonam'),(1343,'Kumbhargaon'),(1432,'Kumbla P.O.'),(2845,'Kumhari'),(1872,'Kumily'),(508,'Kumta'),(2669,'Kundankulam'),(1585,'Kundapur'),(1936,'Kundapura'),(2996,'Kunigal'),(1502,'Kunnamangalam'),(1293,'Kunnamkulam'),(138,'Kuppam'),(2687,'Kupwad'),(2902,'Kupwars'),(811,'Kuravilangad'),(721,'Kurkunta'),(2575,'Kurnnol'),(139,'Kurnool'),(140,'Kurseong'),(142,'Kurukshetra'),(141,'Kushalnagar'),(1514,'Kushinagar'),(578,'Kusiapal'),(379,'Kustagi'),(789,'Kusumba'),(396,'Kutch'),(1341,'Kuthambalkkam'),(1347,'Kuttapatti'),(1319,'Kuttipuram'),(1333,'Kuttoor'),(1902,'Kuwaritol'),(2640,'Kuzhithurai'),(632,'Lachhmangarh'),(1738,'Ladakh'),(3029,'Ladnun'),(3104,'Laguna'),(2597,'Lahdoigarh'),(503,'Laheri Sarai'),(2389,'Lakhaoti'),(1429,'Lakhimpur'),(2354,'Lakhimpur-Kheri'),(2501,'Lakhtar'),(2681,'Lakkidi'),(909,'Lakshadweep'),(1813,'Lakshmangarh'),(473,'Lakurdi'),(640,'Lalganj'),(1716,'Lalitpur'),(1868,'Lamphelpat'),(2562,'Landran'),(143,'Larambha'),(2137,'Lasalgaon'),(2541,'Latehar'),(144,'Latur'),(2218,'Laulara'),(2855,'Laxmidevipally'),(2771,'Laxmiposi'),(1324,'Leh Ladakh'),(2777,'Leh-Ladakh'),(1569,'Lembucherra'),(2549,'Levengipuram'),(345,'Liluah'),(2215,'Limda'),(2026,'Linch'),(825,'Lludhiana'),(2197,'Lodhivali'),(2616,'Loha'),(2283,'Lohardaga'),(2504,'Lohit'),(2973,'Loktak'),(2331,'Lonand'),(145,'Lonavala'),(557,'Lonavla'),(3095,'London  W.C. 2'),(3099,'London W1J 0BA'),(2178,'Lonere'),(2346,'Longowal'),(146,'Loni'),(2017,'Lopan'),(147,'Lucknow'),(148,'Ludhiana'),(521,'Luknow'),(2423,'Lumding'),(2894,'Lunawada'),(2451,'Lunglei'),(3056,'Lushalnagar'),(2703,'Lutunia'),(2603,'M. Nidamalur'),(2105,'Machalipatnam'),(2525,'Macherla'),(526,'Machhra'),(965,'Machilipatnam'),(1264,'Madanapalle'),(1200,'Madanapalli'),(1093,'Madathukulam'),(1229,'Maddilapalam'),(2674,'Maddirala'),(898,'Madhappur'),(636,'Madhepura'),(903,'Madhubani'),(2417,'Madhubani PO'),(1801,'Madhupur'),(808,'Madhuranagar'),(149,'Madikeri'),(745,'Madras'),(1152,'Madura'),(150,'Madurai'),(1773,'Maduri'),(2829,'Magadi'),(1734,'Magpur'),(1518,'Mahaboob Nagar'),(1627,'Mahaboobnagar'),(741,'Mahabubnagar'),(2964,'Mahabumnagar'),(2338,'Mahanandi'),(1721,'Maharaganj'),(1805,'Maharajganj'),(2869,'Mahasamund'),(2909,'Mahbubnagar'),(414,'Mahe'),(2405,'Mahendergarh'),(1346,'Mahendragarh'),(2285,'Mahendragiri'),(3051,'Mahesana'),(151,'Maheshtala'),(152,'Mahishadal'),(1285,'Mahoba'),(153,'Mahuva'),(2509,'Mailam'),(990,'Maindargi'),(1481,'Mainpuri'),(2222,'Majalgaon'),(882,'Majikuchi'),(530,'Makkuva'),(1698,'Makronia Sagar'),(444,'Mala'),(2314,'Malagi'),(677,'Malakkara'),(370,'Malappuram'),(613,'Malapuram'),(2094,'Malayadi'),(319,'Malda'),(154,'Malegaon'),(2841,'Malerkotla'),(2192,'Maliankara'),(2815,'Malikipuram'),(2574,'Malkapur'),(2260,'Mallampudi'),(1589,'Mallapally'),(1490,'Mallappally'),(1559,'Mallappuram'),(1835,'Mallasamudram W'),(2514,'Mallavadi'),(1141,'Malout'),(2708,'Manakkappady'),(435,'Manali'),(774,'Mananthavady'),(1304,'Mananvilai'),(2712,'Manargudi'),(2180,'Manassery'),(155,'Manauli'),(2668,'Manbazar'),(2822,'Manchar'),(1074,'Mancherial'),(1316,'Mandapam Camp'),(1787,'Mandapeta'),(937,'Mandi'),(2271,'Mandi Dabwali'),(1118,'Mandla'),(2153,'Mandsaur'),(369,'Mandya'),(2508,'Manesar'),(573,'Mangalagangotri'),(1399,'Mangalbari'),(2756,'Mangaldai'),(3002,'Mangalloi'),(156,'Mangalore'),(824,'Mangalpadi'),(892,'Mangalpady'),(1269,'Manglagangotri'),(2002,'Mangrulpir'),(2609,'Mani Majra'),(157,'Manipal'),(400,'Manjeri'),(2740,'Manjoor'),(1955,'Manjri'),(2156,'Mankhal'),(615,'Mankipur'),(2636,'Manmad'),(477,'Mannachanallur'),(406,'Mannam'),(2326,'Mannampadal'),(1840,'Mannampandal'),(1125,'Mannanam'),(320,'Mannargudi'),(1348,'Mannuthy'),(1657,'Manpur'),(1250,'Mansa'),(876,'Mansi'),(1505,'Manthiyoor'),(3076,'Manvi'),(600,'Mapusa'),(2454,'Marampally'),(1098,'Marbisu'),(2182,'Marcela'),(1014,'Margao'),(2107,'Margherita'),(1928,'Mariahu'),(1356,'Marigaon'),(2686,'Markanda'),(2083,'Markapur'),(969,'Marsaghai'),(461,'Martandam'),(2133,'Maruthakulam'),(1052,'Masa Kali Patti'),(2134,'Masinagudi'),(1852,'Mastuana Sahib'),(158,'Mathura'),(2917,'Matlapalem'),(1066,'Mattannur'),(511,'Mattanur'),(2332,'Mattupatti'),(159,'Mau'),(2485,'Maunath Bhanjan'),(1302,'Mavelikara'),(1653,'Mayagonahalli'),(955,'Mayiladuthurai'),(1804,'Mayilladuthurai'),(1369,'Maylladuthuri'),(933,'Mayurbhang'),(1521,'Mayurbhanj'),(3004,'Maza Rahikpur'),(2085,'Maza Rahirpur'),(3120,'MD'),(3109,'MD 20814'),(1381,'Medak'),(2511,'Medchal'),(507,'Medinipur'),(1197,'Medziphema'),(1090,'Meenangadi'),(160,'Meerut'),(838,'Meerut Cantt'),(430,'Meeurt'),(2757,'Meghahatuburu'),(1460,'Meghalaya'),(787,'Mehabubnagar'),(2217,'Mehesana'),(367,'Mehkar'),(510,'Mehsana'),(788,'Mehsana Dist'),(1873,'Meignanapuram'),(2212,'Melaiyur'),(2879,'Melakodumalur'),(871,'Melappuram'),(1534,'Melattur'),(2357,'Mele Pattambi'),(2348,'Melmaruvathur'),(2488,'Melmuri'),(698,'Melvisharam'),(415,'Meppayur'),(1839,'Mesra'),(1335,'Metpally'),(1864,'Mettupalayan'),(1202,'Mettur'),(1663,'Mettur Dam'),(1983,'Mianpur'),(2876,'Midayikunnu'),(418,'Midnapore'),(680,'Midnapur'),(2301,'Minjur'),(161,'Mira-Bhayandar'),(1397,'Miraj'),(2368,'Miran Sahib'),(1626,'Mirijapur'),(2763,'Mirual'),(1223,'Miryalaguda'),(1321,'Mirza'),(162,'Mirzapur'),(1036,'Mizoram'),(947,'Modasa'),(3037,'Moddbidri'),(1222,'Modinagar'),(1370,'Modipara'),(2980,'Modusa'),(1268,'Moga'),(703,'Mogalikuduru'),(2322,'Mogra'),(2253,'Mohai'),(2945,'Mohail'),(163,'Mohali'),(433,'Mohanpur'),(2702,'Mohinder Garh'),(1834,'Mohindergarh'),(2806,'Mohitnagar'),(734,'Mokama'),(2784,'Mokamaghat'),(900,'Mokeri'),(2213,'Mokochung'),(927,'Mokokchung'),(1323,'Monippally'),(376,'Moodabidri'),(2916,'Moodbidiri'),(585,'Moodbidri'),(2819,'Moodlakatte'),(2870,'Moothakunnam'),(164,'Moradabad'),(2487,'Moranhat'),(2807,'Morena'),(552,'Morigaon'),(1179,'Morshi'),(165,'Motihari'),(2936,'Movva'),(2663,'MPR Dam'),(1785,'Muddebihal'),(2043,'Mudhol'),(550,'Mudigere'),(894,'Mukalmua'),(2594,'Mukandpur'),(2808,'Mukerian'),(1355,'Mukkam'),(2361,'Muktainagar'),(2277,'Muktsar'),(2111,'Mulabagal'),(2834,'Mulabagalu'),(1235,'Mulakalacheruvu'),(2053,'Mulkalla'),(597,'Mulki'),(2915,'Mullana'),(1276,'Mullanpur'),(1312,'Mullikolathur'),(2252,'Mulloorkara'),(166,'Mumbai'),(1891,'Mumbakonam'),(1630,'Mumbi'),(2564,'Mumbra'),(2733,'Munanjipatti'),(1332,'Munduparamba'),(2353,'Mundur'),(1791,'Mungeli'),(633,'Munger'),(2704,'Munipalli'),(336,'Munnar'),(1277,'Munnur'),(1866,'Mupusa'),(1413,'Murdeshwar'),(2388,'Murickassery'),(391,'Murshidabad'),(1690,'Murtizapur'),(1299,'Murum'),(2089,'Musiri'),(1662,'Mussoorie'),(1901,'Muthorai'),(2142,'Muthukur'),(3022,'Muthur'),(913,'Muvattupuzha'),(167,'Muzaffarnagar'),(168,'Muzaffarpur'),(1260,'Muzzafarnagar'),(1849,'Myladumpara'),(2732,'Mylavaram'),(1841,'Mysooru'),(169,'Mysore'),(2941,'N 24 Parganas'),(2102,'N.Pudhupatti'),(2515,'N.R. Palle'),(1452,'Nabha'),(1499,'Nacharam'),(170,'Nadia'),(549,'Nadiad'),(1151,'Nagai'),(352,'Nagaland'),(544,'Nagaon'),(466,'Nagapattinam'),(1243,'Nagarcoil'),(1116,'Nagarjuna Nagar'),(949,'Nagaur'),(171,'Nagercoil'),(172,'Nagpur'),(2416,'Nagrakata'),(2209,'Nagunur'),(958,'Nahan'),(1704,'Naida'),(173,'Naihati'),(174,'Nainital'),(2279,'Najibabad'),(1028,'Naka Dongri'),(2266,'Nalagnda'),(1131,'Nalagonda'),(708,'Nalanda'),(1134,'Nalbari'),(446,'Nalgonda'),(2590,'Nalgonds'),(2954,'Naliya'),(2337,'Nalkalikkal'),(322,'Namakkal'),(1345,'Nambol'),(2952,'Namti'),(175,'Nanded'),(1110,'Nandeuri'),(564,'Nandgaon'),(1761,'Nandigama'),(2027,'Nandikotkur'),(804,'Nandurbar'),(1025,'Nandyal'),(1984,'Nangal'),(2679,'Nangali'),(2186,'Nangiarkulangar'),(176,'Nangloi Jat'),(2651,'Nanjanagudu'),(1634,'Nanjangud'),(1696,'Napaam'),(1857,'Napur'),(1748,'Narasapur'),(1005,'Narasaraopet'),(1172,'Narasinganet'),(2003,'Narasipatnam'),(2402,'Narayanapura'),(2312,'Narayanpet'),(2317,'Naregal'),(2871,'Narendrapur'),(1531,'Narnaul'),(469,'Narsapur'),(1362,'Narsinghpur'),(330,'Narukara'),(2639,'Narwapahar'),(177,'Nashik'),(670,'Nasik'),(2126,'Nasrapur'),(2812,'Natepute'),(2665,'Nathdwara'),(2347,'Natipora'),(709,'Nattika'),(2997,'Naugachia'),(1853,'Nauni'),(2579,'Navagam'),(2250,'Navalur'),(2327,'Navapur'),(2659,'Navi Mumai'),(178,'Navi Mumbai'),(1781,'Navli'),(1149,'Navsari'),(1609,'Nawada'),(2167,'Nawagarh'),(1140,'Nawalgarh'),(1404,'Nawanshah Dt'),(924,'Nawanshahr'),(2350,'Nawanshehr'),(1641,'Nawarangpur'),(1174,'Nawargaon'),(2611,'Naya Bazar'),(1359,'Naya Nangal'),(1115,'Nayagarh'),(1073,'Nayarkuzhi'),(2825,'Nayudupet'),(2426,'Nazareth'),(656,'Nazira'),(1823,'NC'),(582,'Nedumangad'),(2464,'Nedumkandam'),(608,'Nedumkunnam'),(2942,'Neeleswaram'),(753,'Neemuch'),(1982,'Neemuch Cant.'),(1183,'Nelakondapally'),(2932,'Nelamangala'),(1032,'Nellimoodu'),(1070,'Nellippara'),(179,'Nellore'),(2676,'Neriamangalam'),(411,'Nerparsopant'),(780,'Nesari'),(2498,'Nettana'),(180,'New Delhi'),(2846,'New Kamptee'),(1305,'New Mahe'),(879,'New Mumbai'),(691,'New Panvel'),(2103,'New Panvel (W)'),(690,'New Tehri'),(1829,'New VV Nagar'),(3092,'New York  10024 - 5192'),(2138,'Newasa'),(1322,'Neyveli'),(1336,'Neyyoor'),(2608,'Nicobar'),(2284,'Nidadavole'),(542,'Nidasoshi'),(2662,'Nigahi'),(340,'Nilambur'),(2648,'Nilambur RS'),(715,'Nilanga'),(535,'Nileshwar'),(863,'Nilgiris'),(2274,'Nilgris'),(2961,'Nillikuppam'),(2097,'Nimpith Ashram'),(1390,'Nintanehati'),(2410,'Nipani'),(1859,'Niphad'),(2409,'Nippani'),(1148,'Nirakarpur'),(181,'Nirjuli'),(182,'Nirmal'),(1385,'Nirmalagiri'),(183,'Nischintakoili'),(1924,'Nitte'),(184,'Nizamabad'),(3121,'NJ'),(3114,'NJ 08055'),(185,'Noida'),(3006,'Nongpoh'),(2022,'Nongstoin'),(2865,'Nooranad'),(756,'North Dinajpur'),(186,'North Dumdum'),(328,'North Lakhimpur'),(2158,'North24Parganas'),(2885,'Nowgam'),(822,'Nowgong'),(2816,'Nuagam'),(1099,'Nuapada'),(2205,'Nuvem'),(2627,'Nuzvid'),(1777,'Oantnagar'),(2591,'Obedullaganj'),(2634,'Oddanchatram'),(3101,'Ohio 43210-0012'),(2753,'Ojhar'),(1831,'Okkur'),(1405,'Olakettiampalam'),(2009,'Old Goa'),(2921,'Olhapur'),(1959,'Omerga'),(1254,'Ongole'),(2835,'Ooragam'),(344,'Ootacamund'),(1584,'Ooty'),(1128,'Orai'),(2897,'Orathanad'),(1824,'Oregon IL'),(576,'Orissa'),(973,'Osmanabad'),(944,'Othera'),(1378,'Ottapalam'),(886,'Otur'),(3106,'Oxon  OX10 8DF'),(187,'Ozhukarai'),(2738,'P Medinipur'),(2339,'P Seeragapadi'),(1411,'P. Nilayam'),(1900,'P.Medinipore'),(904,'P.Nilayam'),(2150,'Pachal'),(2922,'Pacheri Bari'),(2163,'Pachmarhi'),(763,'Pachora'),(517,'Pacode'),(1266,'Padanakkad'),(1317,'Padannakkad'),(3087,'Padappai'),(2471,'Padhiana'),(1846,'Padnekat'),(2479,'Padra Tal'),(1247,'Padruna'),(738,'Padur'),(2483,'Paipad'),(2069,'Paiyanoor'),(2384,'Pakakkad'),(447,'Pakharpura'),(1884,'Pakur'),(3084,'Pakyong'),(2012,'Pakyoung'),(959,'Pala'),(338,'Palacode'),(1749,'Palai'),(1600,'Palakad'),(188,'Palakkad'),(843,'Palakol'),(2490,'Palamaner'),(3039,'Palamau'),(657,'Palampur'),(1132,'Palani'),(380,'Palanpur'),(783,'Palapur'),(831,'Palayad'),(409,'Palayamkottai'),(1677,'Palayampatti'),(1591,'Palayankottai'),(617,'Palem'),(1080,'Palemad'),(1395,'Palghar'),(3010,'Palghar (East)'),(919,'Palghat'),(189,'Pali'),(1906,'Pali Marwar'),(2877,'Paliabindha'),(1516,'Pallam'),(1181,'Pallatheri'),(2062,'Pallavur'),(668,'Palode'),(1077,'Paloncha'),(2797,'Palta'),(2421,'Palus'),(1262,'Palwal'),(1278,'Palyamkottai'),(2524,'Pampadumpara'),(2447,'Pampady'),(1092,'Pampady South'),(2050,'Pampore'),(710,'Panagal Post'),(321,'Panaji'),(1217,'Panayur'),(2745,'Panchgani'),(190,'Panchkula'),(2309,'Panchmahal'),(1550,'Panchukla'),(1013,'Pandalam'),(2319,'Pandaul'),(1647,'Pandharpur'),(1887,'Pangode'),(191,'Panihati'),(192,'Panipat'),(1442,'Panipet'),(1123,'Panjim'),(1454,'Panjuaur PO'),(1468,'Panna'),(1178,'Panpoli'),(354,'Panruti'),(1424,'Panrutin'),(337,'Pantnagar'),(193,'Panvel'),(2840,'Paprola'),(2633,'Paradip'),(888,'Parangipettai'),(616,'Parappanangadi'),(194,'Parasia'),(1492,'Parassinikadava'),(1448,'Parathode P.O.'),(767,'Parbatpur'),(195,'Parbhani'),(2066,'Parlakhemundi'),(2179,'Parli-Vaijnath'),(1961,'Parmathi'),(1638,'Parola'),(1106,'Parrathipuram'),(993,'Parunde'),(350,'Paruvakkudi'),(1937,'Parvatipuram'),(1088,'Parwanoo'),(1620,'Pashan'),(1571,'Pasighat'),(372,'Patan'),(1012,'Patana'),(197,'Patancheru'),(1508,'Patba'),(2900,'Patel Guda'),(1670,'Pathamthitta'),(645,'Pathanamthitta'),(1205,'Pathanapuram'),(752,'Pathankot'),(2605,'Pathanpuram'),(2404,'Pathardi'),(196,'Patiala'),(2827,'Patkura'),(198,'Patna'),(2653,'Patna Sahib'),(2001,'Patoda'),(2783,'Patratu'),(1475,'Pattambi'),(2726,'Pattamundai'),(2114,'Pattan'),(2307,'Patti'),(465,'Pattithara'),(1466,'Pauagada Taluk'),(2563,'Pauri'),(2324,'Pauri Garhwal'),(2709,'Pavanasam'),(1300,'Pavaratty'),(1915,'Pavitram'),(1989,'Pavoorchatram'),(2472,'Payakaraopeta'),(2858,'Payangadi'),(723,'Payyannur'),(436,'Payyanur'),(1896,'Payyoli'),(784,'Pedagantyada'),(3083,'Pedavegi'),(960,'Peddapuram'),(1883,'Peechi'),(1596,'Peermade'),(2957,'Pehowa'),(862,'Pen'),(2821,'Pendra'),(768,'Penugonda'),(199,'Perambalur'),(2695,'Peravurani'),(2238,'Peringamala'),(2211,'Peringammala'),(1094,'Periyakulam'),(200,'Pernem'),(1225,'Perumbavoor'),(612,'Perundurai'),(2140,'Peruvallur'),(1504,'Pervmbavoor'),(2552,'Pethappampatti'),(840,'Petlad'),(1023,'Peyad'),(1039,'Phagwara'),(1083,'Phaltan'),(3090,'Philadelphia, PA 19130'),(3098,'Philadelphia, PA. 19103'),(991,'Phillaur'),(911,'Pichalaguri'),(746,'Pilani'),(1408,'Pilathara'),(2044,'Pilerne Bardez'),(2589,'Pilibhit'),(970,'Pimpalgaon'),(1651,'Pimpalner'),(201,'Pimpri-Chinchwad'),(2966,'Piparia'),(3070,'Pipariya'),(2406,'Piravom'),(2007,'Piska Nagari'),(202,'Pithoragarh'),(992,'Poarayar'),(2503,'Podakkudi'),(722,'Podili'),(2761,'Pokharan'),(2809,'Pokharipur'),(532,'Pollachi'),(906,'Ponda'),(2262,'Ponkunnam'),(2157,'Ponnala'),(2117,'Ponnampet'),(2113,'Ponnampete'),(2214,'Ponnani South'),(1974,'Ponneri'),(2715,'Ponniakurssi'),(1412,'Ponpadi'),(2747,'Pooch'),(1102,'Poochakkal'),(1914,'Poondi'),(1745,'Poonjar'),(2122,'Poonjeri'),(445,'Poothotta'),(2927,'Poovanthi'),(463,'Porabandar'),(848,'Porayar'),(525,'Porbandar'),(1295,'Port Balir'),(533,'Port Blair'),(1438,'Portonovo'),(1434,'Poruvazhi P.O.'),(748,'Poruvazhy'),(2530,'Porvorim'),(2164,'Pottapalayam'),(1753,'Powai'),(518,'Prakasam'),(2978,'Prakasam Dist'),(1530,'Prakashsam'),(1443,'Prasanthinilayam'),(203,'Prasanti Nilayam'),(3048,'Pratapgarah'),(1199,'Pratapgarh'),(464,'Pritinagar'),(1380,'Proddatur'),(807,'Pudikkottai'),(1736,'Pudikottai'),(204,'Puducherry'),(1606,'Pudukkottai'),(664,'Pudukottai'),(1165,'Pulgaon'),(2577,'Puliangudi'),(982,'Pulivendla'),(1384,'Pulivendula'),(529,'Pullazhi'),(1486,'Pulwama'),(2041,'Pundibari'),(2864,'Pundri'),(205,'Pune'),(2914,'Punkunnan'),(2650,'Puranattukara'),(1772,'Purba'),(1931,'Purba Medinipur'),(3060,'Purba Midnapur'),(310,'Puri'),(2491,'Purna'),(3023,'Purnea'),(206,'Purnia'),(666,'Purulia'),(1667,'Pusa'),(316,'Pusad'),(1945,'Puthanampatti'),(1680,'Puthenchira'),(2428,'Puthenpalli'),(1416,'Puthenthurai'),(1730,'Puthukkottai'),(1809,'Puttaparthi'),(1580,'Puttarparthi'),(961,'Puttur'),(592,'Qadian'),(2356,'Quepem'),(443,'Quilon'),(1334,'Qummalur'),(1723,'R R Dist'),(2903,'R R Dist.'),(1795,'R R District'),(2411,'R.Chodavaram'),(2719,'R.R.Dist'),(1204,'Racnhi'),(207,'Radaur'),(1631,'Rae Bareli'),(1727,'Raebareli'),(2631,'Raggad'),(2614,'Raghogarh'),(3047,'Rahtak'),(1929,'Rahuri'),(208,'Raichur'),(630,'Raigad'),(1423,'Raigad Dist'),(569,'Raiganj'),(917,'Raigarh'),(1472,'Raigudh'),(209,'Raipur'),(2970,'Raisen'),(210,'Rajahmundry'),(2518,'Rajakkamangalam'),(652,'Rajam'),(2493,'Rajampet'),(1692,'Rajapalaiyam'),(845,'Rajapalayam'),(565,'Rajapuram'),(2245,'RajaRammohunpur'),(2015,'Rajborasambar'),(977,'Rajeshwar'),(2565,'Rajgangapur'),(1916,'Rajgangpur'),(1494,'Rajgir'),(2374,'Rajgurunagar'),(2817,'Rajkanika'),(211,'Rajkot'),(631,'Rajnagar'),(2431,'Rajnandgaon'),(1049,'Rajouri'),(688,'Rajpipla'),(212,'Rajpur Sonarpur'),(1910,'Rajpura'),(2092,'Rajsamand'),(2581,'Rajura'),(213,'Ramagundam'),(1683,'Ramanagara'),(1310,'Ramanagaram'),(1048,'Ramanathapuram'),(2736,'Ramapuram'),(459,'Ramchandrapuram'),(1876,'Ramdurg'),(1802,'Ramgarh'),(2800,'Ramgarh Cantt.'),(952,'Ramnad'),(2723,'Ramnagar'),(988,'Rampachodavaram'),(214,'Rampur'),(407,'Rampura'),(2593,'Rampurhat'),(2072,'Ramtek'),(1058,'Ranaghat'),(2722,'Ranchaidham'),(215,'Ranchi'),(2248,'Rang Reddy'),(1522,'Ranga Reddy'),(3012,'Ranga Reddy Dis'),(2081,'Ranga ReddyDist'),(2159,'Rangal Reddy'),(2934,'Rangareddy'),(2929,'Rangareddy Dist'),(2270,'RangareddyDist'),(866,'Rangia'),(2446,'Ranibennur'),(1977,'Ranichauri'),(2434,'Raniganj'),(728,'Ranipet'),(2290,'Ranny'),(2459,'Rapalle'),(954,'Rasipuram'),(1184,'Ratanpur'),(216,'Ratlam'),(217,'Ratnagiri'),(1210,'Rawathbhata'),(817,'Rayagada'),(1273,'Rayarangoth'),(2474,'Rayavaram'),(1406,'Rayya'),(1686,'Razole'),(538,'Reasi'),(2534,'Rehli'),(1453,'Renukoot'),(1157,'Repalle'),(218,'Rewa'),(849,'Rewari'),(2300,'Ri Bhoi Dist'),(1485,'Rishi Valley'),(625,'Rishikesh'),(2836,'Robertsonpet'),(974,'Roha'),(219,'Rohtak'),(1594,'Rohtas'),(1026,'Roopnagar'),(220,'Roorkee'),(798,'Ropar'),(1283,'Rorkela'),(1051,'Rothak'),(1770,'Rourkee'),(221,'Rourkela'),(1878,'RR Dist'),(2899,'RR District'),(3072,'Rrichy'),(3008,'Rudraprayag'),(3078,'Rudrapur'),(2843,'Rupai Siding'),(3021,'S 24 Parganas'),(1958,'S Kaghaznagar'),(317,'S S Nallur'),(1943,'S.A.S.Nagar'),(890,'S.Kanara'),(1993,'S.Krushinagar'),(1565,'Sabarkantha'),(1843,'Sabarkhnatha'),(2181,'Sadanandapuram'),(2195,'Sadra'),(1786,'Safidon'),(222,'Sagar'),(1096,'Sahaganj'),(223,'Saharanpur'),(1171,'Saharsa'),(593,'Sahibganj'),(2538,'Sai Vihar'),(1673,'Saidabad'),(2230,'Sailu'),(1970,'Sakaleshapura'),(2244,'Sakaleshpura'),(1339,'Sakali'),(2237,'Sakoli'),(2201,'Sakthinagar'),(2330,'Salcete'),(3066,'Salcette'),(3075,'Salekasa'),(224,'Salem'),(1675,'Saligao'),(2526,'Salipur'),(777,'Salur'),(2500,'Samana'),(331,'Samastipur'),(225,'Sambalpur'),(1274,'Sambhal'),(1874,'Sambhalkha'),(1104,'Sambra'),(434,'Samsi'),(841,'Sanagamner'),(1632,'Sanawad'),(772,'Sanawar'),(536,'Sanchi'),(594,'Sandur'),(2224,'Sangali'),(1374,'Sangamner'),(482,'Sangli'),(851,'Sangli Dist.'),(226,'Sangli-Miraj & Kupwad'),(2288,'Sangola'),(2095,'Sangole'),(1329,'Sangrur'),(2993,'Sanguem'),(1573,'Sankarankovil'),(2067,'Sankeshwar'),(514,'Sankhali'),(2308,'Sanosara'),(562,'Sanquelim'),(227,'Santiniketan'),(2760,'Santragachi'),(3112,'Sao Pavlo 01222-010'),(2165,'Saoner'),(1400,'Sarang'),(2940,'Sardarshahr'),(2959,'Sarguja'),(3052,'Sarhali'),(2641,'Sarood'),(1865,'Saroornagar'),(2177,'Sarsa'),(2775,'Sarsawa'),(1469,'Sarugani'),(228,'SAS Nagar'),(2004,'Sasthamcotta'),(1372,'Sasthamcottah'),(2082,'Sasthamkotta'),(2185,'Saswad'),(1387,'Satana'),(229,'Satara'),(2000,'Sathiyamangalam'),(2462,'Sathupalli'),(899,'Sathupally'),(1833,'Sathyamangalam'),(230,'Satna'),(976,'Satsang'),(1543,'Sattur'),(1459,'Savanur P.O.'),(2087,'Sawai Madhopur'),(2311,'Sawaimadapur'),(485,'Sawaimadhopur'),(2263,'Sawantwadi'),(2038,'Sawarde'),(827,'Sawyerpuram'),(2058,'SBS Nagar'),(2999,'SBS Nagar (NSR)'),(231,'Secunderabad'),(611,'Secundrabad'),(2475,'Sehore'),(747,'Seijusa'),(2236,'Selaqui'),(1782,'Sembakkam'),(1946,'Senapati'),(2223,'Seoni'),(2093,'Seoul 121'),(232,'Serampore'),(3033,'Serchhip'),(1920,'Sevagram'),(2242,'Sevalpatti'),(1493,'SGR Kashmir'),(2304,'Shabad'),(602,'Shahabad'),(2592,'Shahabad (M)'),(1166,'Shahada'),(1015,'Shahdol'),(233,'Shahjahanpur'),(2889,'Shajapur'),(1153,'Shaktinagar'),(935,'Shamli'),(2396,'Shaniwareeth'),(1160,'Shankaraghatta'),(1138,'Shardanagar'),(475,'Shegaon'),(1393,'Shencottah'),(1007,'Shendurjanaghat'),(2956,'Sheopur'),(2535,'Sheopur Kalan'),(1170,'Shevgaon'),(537,'Shikohabad'),(234,'Shillong'),(2824,'Shimirpet'),(235,'Shimla'),(2880,'Shimurali'),(2064,'Shingnapur'),(605,'Shirala'),(2056,'Shirgaon'),(1391,'Shirpur'),(2292,'Shirur'),(1869,'Shivamogga'),(236,'Shivamogga (Shimoga)'),(2960,'Shivapuri'),(1863,'Shivnagar'),(3049,'Shivpuri'),(1290,'Shmoga'),(2315,'Shmogar'),(842,'Sholinganallur'),(2874,'Sholinghur'),(834,'Shoranur'),(2047,'Shorapur'),(1337,'Shornur'),(1862,'Shreeramnagar'),(2814,'Shreewardhan'),(2139,'Shrigonda'),(875,'Shringere'),(1354,'Shrirampur'),(2598,'Shrivilliputhur'),(1930,'Shujalpur'),(1042,'Siddapur'),(829,'Siddhpur'),(1838,'Siddipet'),(1265,'Sidhi'),(2226,'Sidhrawali'),(2155,'Sidhwar Khurd'),(2696,'Sihora'),(669,'Sikar'),(2329,'Sikara'),(425,'Sikharpur'),(1484,'Sikkim'),(1629,'Sikkim (East)'),(237,'Silchar'),(238,'Siliguri'),(614,'Silliguri'),(2100,'Sillod'),(2826,'Silvassa'),(2151,'Simaluguri'),(627,'Simhachalam'),(2024,'Simulbari'),(1927,'Sindewahi'),(3117,'Sindh 73050'),(239,'Sindhudurg'),(769,'Sindhudurga'),(776,'Sindkheda'),(1306,'Singanallur'),(1741,'Singapore'),(2219,'Singarayakonda'),(654,'Singhbhum'),(1615,'Singhbhum (E)'),(1766,'Singhrauli'),(2601,'Singoor'),(240,'Singrauli'),(2484,'Sinnar'),(2420,'Siricilla'),(984,'Sirkali'),(2364,'Sirmour'),(940,'Sirmur'),(957,'Sirohi'),(1101,'Sironcha'),(599,'Sirsa'),(471,'Sirsi'),(663,'Siruseri'),(878,'Sitapur'),(1816,'Sitarganj'),(241,'Sivaganga'),(946,'Sivagiri'),(1715,'Sivakashi'),(242,'Sivakasi'),(385,'Sivapuri'),(963,'Sivasagar'),(1114,'Siwan'),(243,'Sodepur'),(3043,'Sohna'),(941,'Solan'),(244,'Solapur'),(2291,'Someshwarnagar'),(2042,'Sonai'),(1456,'Sonapur'),(2313,'Sonari'),(648,'Sonarpur'),(676,'Sonbhadra'),(2068,'Sonbhanra'),(1326,'Sonebhadra'),(601,'Sonepat'),(467,'Sonepur'),(245,'Sonipat'),(1624,'Sonipet'),(820,'Sonitpur'),(1271,'Sontipur'),(1890,'Sopore'),(1017,'Soro'),(3111,'South Africa'),(2570,'South Andaman'),(246,'South Dumdum'),(2031,'South Kodagu'),(2727,'South Tripura'),(2204,'Sreekandapuram'),(2661,'Sreenivasapuram'),(1640,'Sri Ganga Nagar'),(247,'Sri Ganganagar'),(740,'Sri Palli'),(1702,'Sriganganagar'),(1642,'Srihari Kota'),(1908,'Sriharikota'),(1524,'Srikakulam'),(2495,'Srikalahasthi'),(509,'Srikalahasti'),(1537,'Srikaulam'),(2906,'Srimushnam'),(248,'Srinagar'),(2216,'SrinagarGarhwal'),(714,'Sringeri'),(408,'Sriniketan'),(1510,'Srinivasanagar'),(2832,'Srinivasapura'),(743,'Srinivasnagar'),(440,'Srinivaspur'),(1700,'Sriperumbpudur'),(249,'Sriperumbudur'),(250,'Srirampur'),(2908,'Srisailam'),(979,'Srivaikuntam'),(1256,'Srivilliputtur'),(1465,'Srukandapuram'),(3071,'Subansiri'),(2171,'Subrahmanya'),(2091,'Sudumbre'),(1253,'Sullia'),(1159,'Sullurpet'),(1187,'Sullurpeta'),(939,'Sullurupeta'),(251,'Sultanpur'),(1885,'Sulthan Bathery'),(2680,'Sulur'),(3016,'Sunam'),(694,'Sundargarh'),(1659,'Sundaridia'),(2766,'Sunderbani'),(478,'Sunderchak'),(1553,'Sundergarh'),(1244,'Surajpur'),(1969,'Surampalem'),(252,'Surat'),(1176,'Surathakal'),(253,'Surathkal'),(1109,'Suratkal'),(2789,'Surda'),(2299,'Surendranagar'),(860,'Surguja'),(555,'Suri'),(884,'Suryamaninagar'),(731,'Suryapet'),(1251,'Sutrapada'),(1895,'Suttur'),(1018,'Swamimalai'),(2692,'Syamsundar'),(1708,'T V Malai'),(2152,'T. Kallikulam'),(2925,'T.Kallupatty'),(1855,'Tadapalligudem'),(2888,'Tadapatri'),(584,'Tadepalligudem'),(2294,'Tadikonda'),(2595,'Tadong'),(1161,'Tadpatri'),(1742,'Taegu'),(3118,'Taipei'),(2856,'Takhatpur'),(931,'Talab Tilloo'),(1774,'Talakonda'),(2295,'Talcher'),(1001,'Taleigao'),(3079,'Taleigao Plateau'),(1806,'TaleigaoPlateau'),(1079,'Taleigo'),(554,'Taliparamba'),(2203,'Talod'),(2438,'Taloda'),(474,'Talwara'),(351,'Tambaram'),(2233,'Tamenglong'),(1972,'Tamkuhiraj'),(1458,'Tamluk'),(2441,'Tangi'),(1572,'Tangore'),(2121,'Tanjavur'),(1177,'Tanjore'),(427,'Tanuku'),(971,'Tarikere'),(1828,'Tarikhet'),(2400,'Tarn Taran'),(1944,'Tasgaon'),(2976,'Tatnagiri'),(2606,'Tattamangalam'),(1848,'Tavanur'),(1812,'Teh-Merta'),(1436,'Tehri'),(1467,'Tehri Garhwal'),(1854,'Tehsil Rajpura'),(1212,'Tehsil Tibbi'),(800,'Tekkali'),(908,'Telam'),(1793,'Teleiago'),(589,'Tellicherry'),(1679,'Telliicherry'),(2298,'Tempe, AZ'),(684,'Tenali'),(1479,'Tenkara P.O.'),(1415,'Tenkasi'),(2390,'Terri Garhwal'),(3025,'Tetali'),(255,'Tezpur'),(2516,'Tezu'),(1568,'Thachanallur'),(2752,'Thadlaskein'),(2075,'Thalacode'),(450,'Thalassery'),(1987,'Thalavapalayam'),(1232,'Thana'),(2944,'Thance'),(2898,'Thandalam'),(256,'Thane'),(867,'Thane (W)'),(855,'Thane (West)'),(727,'Thane Dist.'),(3074,'Thane East'),(1507,'Thane West'),(2630,'Thane(W)'),(254,'Thanjavur'),(1810,'Thanjvur'),(2971,'Tharamangalam'),(1610,'Thasra'),(2362,'Thathanur'),(1192,'Thattamala'),(1527,'The Nilgiris'),(1291,'Theerthamalai'),(1491,'Thellar'),(1386,'Thellyoor'),(1156,'Thenhipalam'),(1426,'Thenhipalam PO'),(1538,'Theni'),(2610,'Thenzawl'),(2196,'Thetkuppalam'),(1298,'Thickurichy'),(1169,'Thimmasamudram'),(431,'Thiruchirapalli'),(2867,'Thirumansolai'),(1701,'Thirunelveli'),(2392,'Thiruninravur'),(2231,'Thirupachur'),(1193,'Thirupathur'),(1965,'Thiruppanadal'),(1623,'Thiruppathur'),(1796,'Thirupur'),(1560,'Thiruvaiyaru'),(1709,'Thiruvalam'),(1180,'Thiruvalla'),(1046,'Thiruvallur'),(257,'Thiruvananthapuram'),(1402,'Thiruvankulam'),(1040,'Thiruvannamalai'),(1130,'Thiruvarur'),(1687,'Thiruvattar'),(2693,'Thiruvilla'),(346,'Thodupuzha'),(996,'Thokkavadi'),(2910,'Tholayavattam'),(1967,'Tholudur'),(1107,'Thondi'),(1973,'Thoothoor'),(303,'Thoothukudi'),(2124,'Thoppur'),(568,'Thotakkara'),(2166,'Thottakkadu'),(2448,'Thoubal'),(2108,'Thovalai'),(2913,'Thrikkakara'),(2455,'Thrikkanapuram'),(258,'Thrissur'),(381,'Thrisur'),(1239,'Thrisuur'),(494,'Thriuchirapalli'),(2546,'Thruvannamalai'),(2323,'Thuckalay'),(2267,'Thuruthicad'),(2189,'Thuthukudi'),(1636,'Tihu'),(2618,'Tikamgarh'),(921,'Tilaiya Dam'),(2743,'Tilwasni'),(1684,'Tindivanam'),(1529,'Tinsukia'),(1035,'Tiptur'),(3067,'Tirap'),(1706,'Tirchengode'),(1808,'Tirchy'),(1922,'Tirtol'),(729,'Tiruchendur'),(1398,'Tiruchengode'),(1551,'Tiruchiraoalli'),(259,'Tiruchirapalli'),(2305,'Tiruchirapally'),(1214,'Tiruchirappali'),(395,'Tiruchirappalli'),(1061,'Tiruchy'),(335,'Tirukalukundram'),(1163,'Tirukovilour'),(2188,'Tirumangalam'),(896,'Tirunelvali'),(260,'Tirunelveli'),(1819,'Tirunelvelli'),(795,'Tiruninravur'),(355,'Tirupathi'),(261,'Tirupati'),(1497,'Tirupattur'),(2176,'Tiruppattur'),(1076,'Tiruppur'),(262,'Tirupur'),(2146,'Tirur'),(2439,'Tirurangadi'),(2946,'Tiruttani'),(1941,'Tiruvalam'),(711,'Tiruvalla'),(547,'Tiruvannamalai'),(2868,'Tiruvannmalai'),(1301,'Tiruvarur'),(1557,'Tiruvelveli'),(823,'Tiruvetipuram'),(263,'Tiruvottiyur'),(2852,'Tiruvuru'),(1811,'Tonk'),(1822,'Tonk Road'),(2365,'Toranagallu'),(1875,'Trichi'),(1544,'Trichirappalli'),(373,'Trichur'),(2796,'Trimbuk'),(1712,'Trippur'),(366,'Tripunithura'),(930,'Tripur'),(883,'Tripura'),(1658,'Tripura (N)'),(2990,'Tripura West'),(733,'Trissur'),(3080,'Trivandruam'),(801,'Trivandurm'),(1625,'Trvandrum'),(1991,'Tuljapur'),(2154,'Tumakooru'),(264,'Tumakuru (Tumkur)'),(390,'Tumkur'),(1628,'Tumukur'),(1992,'Tuni'),(701,'Tura'),(1605,'Turuppur'),(492,'Tuticorin'),(1286,'Tutucorin'),(3122,'TX'),(1815,'U.S. Nagar'),(2896,'UB Kanker'),(453,'Uchipulli'),(1519,'Udaipir'),(265,'Udaipur'),(2473,'Udala'),(1016,'Udalguri'),(1717,'Udam Singhnagar'),(2440,'Udamalpet'),(2433,'Udayagiri'),(1350,'Udayamperoor'),(1556,'Udayarpalayam'),(716,'Udgir'),(956,'Udhagamandalam'),(302,'Udhampur'),(705,'Udhna'),(1817,'Udipi'),(1020,'Udumalpet'),(301,'Udupi'),(1044,'Uduppi'),(3009,'Udupt'),(1655,'Udwada'),(375,'Ujire'),(266,'Ujjain'),(2721,'Ukhrul'),(1990,'Ulga'),(267,'Ulhasnagar'),(1473,'Ullhasnagar'),(268,'Uluberia'),(2550,'Umaim'),(2849,'Umakhed'),(300,'Umaria'),(1227,'Umarkhed'),(2199,'Umiam'),(2713,'Umrangso'),(2175,'Umred'),(2958,'Una'),(857,'Unnao'),(398,'Uppinangadi'),(3059,'Uppinangady'),(2394,'Uran'),(2786,'US Nagar'),(1495,'Usilampatti'),(2306,'Uthamapalayam'),(1031,'Uthangal'),(1216,'Uthangarai'),(2382,'Uthangudi'),(1756,'Uttar Dinajpur'),(717,'Uttarkashi'),(1124,'Uzhavoor'),(2861,'V. Kote'),(2678,'V. Singapuram'),(704,'V. Vidyanagar'),(353,'V.Vidyanagar'),(624,'Vadakara'),(423,'Vadakkevila'),(2090,'Vadlamudi'),(269,'Vadodara'),(2074,'Vaijapur'),(2477,'Vairag'),(2950,'Vaishali'),(448,'Valacodu'),(2926,'Valad'),(496,'Valancheri'),(2227,'Valanchery'),(2677,'Valapad'),(2073,'Valarpuram'),(628,'Valavannur'),(417,'Valavanour'),(270,'Vallabh Vidyanagar'),(1382,'Vallam'),(932,'Vallanad'),(2077,'Vallanadu'),(693,'Vallar'),(877,'Vallioor'),(2810,'Valmikipuram'),(2125,'Valod'),(929,'Valparai'),(2994,'Valpoi'),(299,'Valsad'),(1487,'Valvada'),(271,'Vamadapadavu'),(2342,'Vanagaram'),(1528,'Vanasthalipuram'),(1935,'Vandalur'),(1480,'Vandavasi'),(696,'Vaniyambadi'),(2559,'Vannarpettai'),(519,'Vapi'),(2401,'Vapi (West)'),(272,'Varanasi'),(1722,'Varansai'),(975,'Varkala'),(524,'Varnasi'),(2445,'Varvand'),(2080,'Vasad'),(1732,'Vasai'),(1971,'Vasai Road (W)'),(2823,'Vasai Road West'),(273,'Vasai-Virar'),(1956,'Vasco'),(1666,'Vasco da gama'),(1705,'Vasco-da-Gama'),(2507,'Vaslas'),(3035,'Vasudevanallur'),(966,'Vatakara'),(1720,'Vatanasi'),(3115,'Vavuniya'),(1661,'Vayala'),(1067,'Vayalar'),(2532,'Vayyuru'),(2645,'Vazhakulam'),(2239,'Vazhayoor East'),(2699,'Vazhithala'),(2561,'Vazhoor'),(2106,'Veerachipalayam'),(2296,'Veeravasaram'),(1637,'Velha'),(1071,'Veliyur'),(1546,'Vellalloor'),(1905,'Vellayani'),(2977,'Vellichanthai'),(2644,'Vellithiruthy'),(274,'Vellore'),(1352,'Velur'),(1289,'Vemom'),(1226,'Vemon'),(2666,'Vengola'),(2432,'Vengurla'),(2582,'Venjaramoodu'),(2637,'Venkatachalam'),(2144,'Venkatagirikote'),(2005,'Venpakkam'),(2887,'Veraval'),(2020,'Verem'),(2586,'Verna'),(1953,'Vetapalem'),(1261,'Vettavalam'),(1414,'Vetturnimadam'),(2335,'Vidavalur'),(1349,'Vididsha'),(672,'Vidisha'),(907,'Vidyanagar'),(572,'Vijaipur'),(1041,'Vijayamangalam'),(2830,'Vijayapura'),(2769,'Vijayavada'),(275,'Vijayawada'),(1566,'Vikarabad'),(3028,'Vikiravandi'),(1318,'Vilayancode'),(2482,'Villapakkam'),(2070,'Villianur'),(2576,'Villiapalli'),(2924,'Villpuram'),(1592,'Villukuri'),(2286,'Villukury'),(1611,'Villuppuram'),(1063,'Villupuram'),(1654,'Vinukonda'),(2174,'Virajapet'),(2981,'Virajpet'),(580,'Virar (West)'),(1552,'Virddhachalam'),(297,'Viridhunagar'),(515,'Viruddhachalam'),(1729,'Virudhu Nagar'),(2979,'Virudunagar'),(2018,'Visakahpatnam'),(2912,'Visakapatnam'),(276,'Visakhapatnam'),(2016,'Visakyhapatnam'),(298,'Vishakhapatnam'),(1660,'Vishnupur'),(1108,'Visnagar'),(2367,'Vita'),(620,'Vitalnagar'),(1899,'Vittal'),(2923,'Vixianagaram'),(910,'Vizag'),(590,'Vizianagaram'),(1775,'Vizianagram'),(962,'Vizninjam'),(2522,'Vllore'),(1535,'Voimedu'),(2820,'Vriddhachalam'),(885,'Vridhachalam'),(1164,'Vsgao'),(1851,'Vuyyuru'),(2943,'VV Nagar'),(938,'Vyara'),(1029,'Vyasagiri'),(2655,'W Garo Hills'),(1471,'W.Champaran'),(2336,'W.G Dist'),(912,'W.Godavari'),(2545,'Wadhwancity'),(1980,'Wagholi'),(1190,'Wai'),(1827,'Walajapet'),(583,'Waltair'),(2544,'Wandiwash'),(781,'Wani'),(2129,'Waranagar'),(277,'Warangal'),(294,'Wardha'),(1933,'Wargal'),(534,'Warora'),(2560,'Washim'),(296,'Wayanad'),(1549,'West Champaran'),(2183,'West Champuram'),(854,'West Garo Hills'),(567,'West Godavari'),(3005,'West KhasiHills'),(2657,'West Midnapore'),(2787,'West Siang'),(1437,'West Singhbhoom'),(3017,'West Singhbhum'),(2442,'WG Dist'),(3054,'WG District'),(2739,'Yadagiri'),(2529,'Yadgir'),(1221,'Yamuna Nagar'),(278,'Yamunanagar'),(1986,'Yanam'),(295,'Yavatmal'),(2370,'Yawatmal'),(279,'Yeddumailaram'),(280,'Yelburga'),(546,'Yellamanchili'),(539,'Yellandu'),(2751,'Yellapur'),(1994,'Yemmiganur'),(1367,'Yeotmal'),(872,'Yercaud'),(2272,'Yerraguntla'),(2596,'Yeshwantnagar'),(2341,'Yol Cantt.'),(2028,'YSR Dist'),(2772,'Zawar Mines'),(1794,'Zirakpur'),(1582,'Zuari Nagar'),(683,'Zuarinagar');
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
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (3,'Afghanistan'),(4,'Argentina'),(1,'Australia'),(2,'Austria'),(6,'Bahrain'),(5,'Bangladesh'),(7,'Belgium'),(8,'Bhutan'),(9,'Brazil'),(10,'Brunei'),(11,'Bulgaria'),(12,'Canada'),(13,'Chile'),(14,'China'),(15,'Colombia'),(16,'Congo'),(17,'Costa Rica'),(18,'Cote D\'Ivoire'),(19,'Cuba'),(20,'Czech Republic'),(21,'Denmark'),(24,'Egypt'),(22,'Eritrea'),(23,'Ethiopia'),(25,'Fiji'),(26,'Finland'),(27,'France'),(28,'Gabon'),(29,'Germany'),(30,'Greece'),(31,'Holland'),(32,'Honduras'),(40,'Hong Kong'),(41,'Hungary'),(33,'India'),(34,'Indonesia'),(36,'Iran'),(35,'Iraq'),(37,'Ireland'),(38,'Israel'),(39,'Italy'),(42,'Japan'),(43,'Jordan'),(44,'Kenya'),(45,'Kuwait'),(46,'Lesotho'),(47,'Macedonia'),(48,'Madagascar'),(49,'Malaysia'),(50,'Mauritius'),(51,'Mexico'),(52,'Moldava'),(53,'Mozambique'),(54,'Nepal'),(55,'Netherlands'),(56,'New Zealand'),(57,'Nigeria'),(58,'Norway'),(59,'Oman'),(60,'Pakistan'),(62,'Panama'),(61,'Papua New Guinea'),(63,'Peru'),(64,'Philippines'),(65,'Poland'),(66,'Portugal'),(67,'Puerto Rico'),(69,'Romania'),(68,'Russia'),(70,'Saudi Arabia'),(71,'Singapore'),(72,'South Africa'),(73,'South Korea'),(74,'Spain'),(75,'Sri Lanka'),(76,'Sudan'),(77,'Sweden'),(78,'Switzerland'),(79,'Taiwan'),(80,'Thailand'),(81,'Turkey'),(82,'Uganda'),(83,'UK'),(85,'United Arab Emirates'),(84,'USA'),(86,'Zimbabwe');
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
) ENGINE=InnoDB AUTO_INCREMENT=586 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `districts`
--

LOCK TABLES `districts` WRITE;
/*!40000 ALTER TABLE `districts` DISABLE KEYS */;
INSERT INTO `districts` VALUES (1,'24 Parganas North'),(2,'24 Parganas South'),(3,'Adilabad'),(4,'Agra'),(5,'Ahmedabad'),(6,'Ahmednagar'),(7,'Aizawl'),(8,'Ajmer'),(9,'Akola'),(10,'Alappuzha'),(11,'Aligarh'),(12,'Allahabad'),(13,'Almora'),(14,'Alwar'),(15,'Ambala'),(16,'Ambedkar Nagar'),(17,'Amravati'),(18,'Amreli'),(19,'Amritsar'),(20,'Anand'),(21,'Anantapur'),(22,'Anantnag'),(23,'Andaman Islands'),(24,'Angul'),(25,'Araria'),(26,'Ariyalur'),(27,'Auraiya'),(28,'Aurangabad'),(29,'Azamgarh'),(30,'Badaun'),(31,'Badgam'),(32,'Bagalkot'),(33,'Bageshwar'),(34,'Baghpat'),(35,'Bahraich'),(36,'Balaghat'),(37,'Baleshwar'),(38,'Ballia'),(39,'Balrampur'),(40,'Banas Kantha'),(41,'Banda'),(42,'Bangalore Rural'),(43,'Banka'),(44,'Bankura'),(45,'Banswara'),(46,'Barabanki'),(47,'Baragarh'),(48,'Baramula'),(49,'Baran'),(50,'Bardhaman'),(51,'Bareilly'),(52,'Barmer'),(53,'Barpeta'),(54,'Barwani'),(55,'Bastar'),(56,'Basti'),(57,'Bathinda'),(58,'Begusarai'),(59,'Belgaum'),(60,'Bellary'),(61,'Bengaluru'),(62,'Betul'),(63,'Bhadrak'),(64,'Bhagalpur'),(65,'Bhandara'),(66,'Bharatpur'),(67,'Bharuch'),(68,'Bhavnagar'),(69,'Bhilwara'),(70,'Bhind'),(71,'Bhiwani'),(72,'Bhojpur'),(73,'Bhopal'),(74,'Bid'),(75,'Bidar'),(76,'Bijapur'),(77,'Bijnor'),(78,'Bikaner'),(79,'Bilaspur'),(80,'Birbhum'),(81,'Bishnupur'),(82,'Bokaro'),(83,'Bolangir'),(84,'Bongaigaon'),(85,'Boudh'),(86,'Bulandshahr'),(87,'Buldhana'),(88,'Bundi'),(89,'Buxar'),(90,'Cachar'),(91,'Chamba'),(92,'Chamoli'),(93,'Champawat'),(94,'Champhai'),(95,'Chamrajnagar'),(96,'Chandauli'),(97,'Chandel'),(98,'Chandigarh'),(99,'Chandrapur'),(100,'Changlang'),(101,'Chatra'),(102,'Chennai'),(103,'Chhatarpur'),(104,'Chhindwara'),(105,'Chikmagalur'),(106,'Chitradurga'),(107,'Chitrakoot'),(108,'Chittoor'),(109,'Chittorgarh'),(110,'Churachandpur'),(111,'Churu'),(112,'Coimbatore'),(113,'Cuddalore'),(114,'Cuddapah'),(115,'Cuttack'),(116,'Dadra and Nagar Haveli'),(117,'Dahod'),(118,'Dakshin Dinajpur'),(119,'Dakshina Kannada'),(120,'Daman'),(121,'Damoh'),(122,'Dantewada'),(123,'Darbhanga'),(124,'Darjeeling'),(125,'Darrang'),(126,'Datia'),(127,'Dausa'),(128,'Davanagere'),(129,'Davangere'),(130,'Dehradun'),(131,'Delhi'),(132,'Deogarh'),(133,'Deoghar'),(134,'Deoria'),(135,'Dewas'),(136,'Dhalai'),(137,'Dhamtari'),(138,'Dhanbad'),(139,'Dhar'),(140,'Dharmapuri'),(141,'Dharwad'),(142,'Dhemaji'),(143,'Dhenkanal'),(144,'Dholpur'),(145,'Dhubri'),(146,'Dhule'),(147,'Dibang Valley'),(148,'Dibrugarh'),(149,'Dimapur'),(150,'Dindigul'),(151,'Dindori'),(152,'Diu'),(153,'Doda'),(154,'Dumka'),(155,'Dungarpur'),(156,'Durg'),(157,'East Garo Hills'),(158,'East Godavari'),(159,'East Imphal'),(160,'East Kameng'),(161,'East Khasi Hills'),(162,'East Nimar'),(163,'East Siang'),(164,'East Sikkim'),(165,'Ernakulam'),(166,'Erode'),(167,'Etah'),(168,'Etawah'),(169,'Faizabad'),(170,'Faridabad'),(171,'Faridkot'),(172,'Farrukhabad'),(173,'Fatehabad'),(174,'Fatehgarh Sahib'),(175,'Fatehpur'),(176,'Firozabad'),(177,'Firozpur'),(178,'Gadag'),(179,'Gadchiroli'),(180,'Gajapati'),(181,'Gandhinagar'),(182,'Ganganagar'),(183,'Ganjam'),(184,'Garhwa'),(185,'Garhwal'),(186,'Gautam Buddha Nagar'),(187,'Gaya'),(188,'Ghaziabad'),(189,'Ghazipur'),(190,'Giridih'),(191,'Goalpara'),(192,'Godda'),(193,'Golaghat'),(194,'Gonda'),(195,'Gondiya'),(196,'Gopalganj'),(197,'Gorakhpur'),(198,'Gulbarga'),(199,'Gumla'),(200,'Guna'),(201,'Guntur'),(202,'Gurdaspur'),(203,'Gurgaon'),(204,'Gwalior'),(205,'Hailakandi'),(206,'Hamirpur'),(207,'Hanumangarh'),(208,'Harda'),(209,'Hardoi'),(210,'Haridwar'),(211,'Hassan'),(212,'Hathras'),(213,'Haveri'),(214,'Hazaribagh'),(215,'Hingoli'),(216,'Hissar'),(217,'Hooghly'),(218,'Hoshangabad'),(219,'Hoshiarpur'),(220,'Howrah'),(221,'Hyderabad'),(222,'Idukki'),(223,'Indore'),(224,'Jabalpur'),(225,'Jagatsinghpur'),(226,'Jaintia Hills'),(227,'Jaipur'),(228,'Jaisalmer'),(229,'Jajpur'),(230,'Jalandhar'),(231,'Jalaun'),(232,'Jalgaon'),(233,'Jalna'),(234,'Jalore'),(235,'Jalpaiguri'),(236,'Jammu'),(237,'Jamnagar'),(238,'Jamui'),(239,'Janjgir-Champa'),(240,'Jashpur'),(241,'Jaunpur'),(242,'Jehanabad'),(243,'Jhabua'),(244,'Jhajjar'),(245,'Jhalawar'),(246,'Jhansi'),(247,'Jharsuguda'),(248,'Jhunjhunun'),(249,'Jind'),(250,'Jodhpur'),(251,'Jorhat'),(252,'Junagadh'),(253,'Jyotiba Phule Nagar'),(254,'Kachchh'),(255,'Kaimur'),(256,'Kaithal'),(257,'Kalahandi'),(258,'Kamrup'),(259,'Kancheepuram'),(260,'Kandhamal'),(261,'Kangra'),(262,'Kanker'),(263,'Kannauj'),(264,'Kannur'),(265,'Kanpur'),(266,'Kanpur Dehat'),(267,'Kanyakumari'),(268,'Kapurthala'),(269,'Karaikal'),(270,'Karauli'),(271,'Karbi Anglong'),(272,'Kargil'),(273,'Karimganj'),(274,'Karimnagar'),(275,'Karnal'),(276,'Karur'),(277,'Kasaragod'),(278,'Kasargod'),(279,'Kathua'),(280,'Katihar'),(281,'Katni'),(282,'Kaushambi'),(283,'Kawardha'),(284,'Kendrapara'),(285,'Keonjhar'),(286,'Khagaria'),(287,'Khammam'),(288,'Kheda'),(289,'Khordha'),(290,'Kinnaur'),(291,'Kishanganj'),(292,'Koch Bihar'),(293,'Kodagu'),(294,'Koderma'),(295,'Kohima'),(296,'Kokrajhar'),(297,'Kolar'),(298,'Kolasib'),(299,'Kolhapur'),(300,'Kolkata'),(301,'Kollam'),(302,'Koppal'),(303,'Koraput'),(304,'Korba'),(305,'Koriya'),(306,'Kota'),(307,'Kottayam'),(308,'Kozhikode'),(309,'Krishna'),(310,'Kulu'),(311,'Kupwara'),(312,'Kurnool'),(313,'Kurukshetra'),(314,'Kushinagar'),(315,'Lahaul and Spiti'),(316,'Lakhimpur'),(317,'Lakhimpur Kheri'),(318,'Lakhisarai'),(319,'Lakshadweep'),(320,'Lalitpur'),(321,'Latur'),(322,'Lawngtlai'),(323,'Leh'),(324,'Lohardaga'),(325,'Lohit'),(326,'Lower Subansiri'),(327,'Lucknow'),(328,'Ludhiana'),(329,'Lunglei'),(330,'Madhepura'),(331,'Madhubani'),(332,'Madurai'),(333,'Mahabubnagar'),(334,'Maharajganj'),(335,'Mahasamund'),(336,'Mahe'),(337,'Mahendragarh'),(338,'Mahesana'),(339,'Mahoba'),(340,'Mainpuri'),(341,'Malappuram'),(342,'Malda'),(343,'Malkangiri'),(344,'Mamit'),(345,'Mandi'),(346,'Mandla'),(347,'Mandsaur'),(348,'Mandya'),(349,'Mansa'),(350,'Marigaon'),(351,'Mathura'),(352,'Maunathbhanjan'),(353,'Mayurbhanj'),(354,'Medak'),(355,'Meerut'),(356,'Midnapore'),(357,'Mirzapur'),(358,'Moga'),(359,'Mokokchung'),(360,'Mon'),(361,'Moradabad'),(362,'Morena'),(363,'Muktsar'),(364,'Mumbai City'),(365,'Mumbai Suburban'),(366,'Munger'),(367,'Murshidabad'),(368,'Muzaffarnagar'),(369,'Muzaffarpur'),(370,'Mysore'),(371,'Nabarangpur'),(372,'Nadia'),(373,'Nagaon'),(374,'Nagapattinam'),(375,'Nagaur'),(376,'Nagpur'),(377,'Nainital'),(378,'Nalanda'),(379,'Nalbari'),(380,'Nalgonda'),(381,'Namakkal'),(382,'Nanded'),(383,'Nandurbar'),(384,'Narmada'),(385,'Narsinghpur'),(386,'Nashik'),(387,'Navsari'),(388,'Nawada'),(389,'Nawan Shehar'),(390,'Nayagarh'),(391,'Neemuch'),(392,'Nellore'),(393,'Nicobar Islands'),(394,'Nilgiris'),(395,'Nizamabad'),(396,'North Cachar Hills'),(397,'North Goa'),(398,'North Sikkim'),(399,'North Tripura'),(400,'Nuapada'),(401,'Osmanabad'),(402,'Pakur'),(403,'Palakkad'),(404,'Palamu'),(405,'Pali'),(406,'Panch Mahals'),(407,'Panchkula'),(408,'Panipat'),(409,'Panna'),(410,'Papum Pare'),(411,'Parbhani'),(412,'Pashchim Champaran'),(413,'Pashchim Singhbhum'),(414,'Patan'),(415,'Pathanamthitta'),(416,'Patiala'),(417,'Patna'),(418,'Pauri Garhwal'),(419,'Perambalur'),(420,'Phek'),(421,'Pilibhit'),(422,'Pithoragarh'),(423,'Poonch'),(424,'Porbandar'),(425,'Prakasam'),(426,'Pratapgarh'),(427,'Puducherry'),(428,'Pudukkottai'),(429,'Pulwama'),(430,'Pune'),(431,'Purba Champaran'),(432,'Purba Singhbhum'),(433,'Puri'),(434,'Purnia'),(435,'Purulia'),(436,'Rae Bareli'),(437,'Raichur'),(438,'Raigarh'),(439,'Raipur'),(440,'Raisen'),(441,'Rajauri'),(442,'Rajgarh'),(443,'Rajkot'),(444,'Rajnandgaon'),(445,'Rajsamand'),(446,'Ramanathapuram'),(447,'Rampur'),(448,'Ranchi'),(449,'Rangareddi'),(450,'Ratlam'),(451,'Ratnagiri'),(452,'Rayagada'),(453,'Rewa'),(454,'Rewari'),(455,'Ri-Bhoi'),(456,'Rohtak'),(457,'Rohtas'),(458,'Rudra Prayag'),(459,'Rupnagar'),(460,'Sabar Kantha'),(461,'Sagar'),(462,'Saharanpur'),(463,'Saharsa'),(464,'Sahibganj'),(465,'Saiha'),(466,'Salem'),(467,'Samastipur'),(468,'Sambalpur'),(469,'Sangli'),(470,'Sangrur'),(471,'Sant Kabir Nagar'),(472,'Sant Ravi Das Nagar'),(473,'Saran'),(474,'Satara'),(475,'Satna'),(476,'Sawai Madhopur'),(477,'Sehore'),(478,'Senapati'),(479,'Seoni'),(480,'Serchhip'),(481,'Shahdol'),(482,'Shahjahanpur'),(483,'Shajapur'),(484,'Sheikhpura'),(485,'Sheohar'),(486,'Sheopur'),(487,'Shimla'),(488,'Shimoga'),(489,'Shivpuri'),(490,'Shravasti'),(491,'Sibsagar'),(492,'Siddharth Nagar'),(493,'Sidhi'),(494,'Sikar'),(495,'Sindhudurg'),(496,'Sirmaur'),(497,'Sirohi'),(498,'Sirsa'),(499,'Sitamarhi'),(500,'Sitapur'),(501,'Sivaganga'),(502,'Siwan'),(503,'Solan'),(504,'Solapur'),(505,'Sonbhadra'),(506,'Sonepat'),(507,'Sonepur'),(508,'Sonitpur'),(509,'South Garo Hills'),(510,'South Goa'),(511,'South Sikkim'),(512,'South Tripura'),(513,'Srikakulam'),(514,'Srinagar'),(515,'Sultanpur'),(516,'Sundargarh'),(517,'Supaul'),(518,'Surat'),(519,'Surendranagar'),(520,'Surguja'),(521,'Tamenglong'),(522,'Tawang'),(523,'Tehri Garhwal'),(524,'Thane'),(525,'Thanjavur'),(526,'The Dangs'),(527,'Theni'),(528,'Thiruvallur'),(529,'Thiruvananthapuram'),(530,'Thiruvarur'),(531,'Thoothukudi'),(532,'Thoubal'),(533,'Thrissur'),(534,'Tikamgarh'),(535,'Tinsukia'),(536,'Tirap'),(537,'Tiruchirappalli'),(538,'Tirunelveli'),(539,'Tiruvannamalai'),(540,'Tonk'),(541,'Tuensang'),(542,'Tumkur'),(543,'Udaipur'),(544,'Udham Singh Nagar'),(545,'Udhampur'),(546,'Udupi'),(547,'Ujjain'),(548,'Ukhrul'),(549,'Umaria'),(550,'Una'),(551,'Unnao'),(552,'Upper Siang'),(553,'Upper Subansiri'),(554,'Uttar Dinajpur'),(555,'Uttara Kannada'),(556,'Uttarkashi'),(557,'Vadodara'),(558,'Vaishali'),(559,'Valsad'),(560,'Varanasi'),(561,'Vellore'),(562,'Vidisha'),(563,'Villupuram'),(564,'Virudhunagar'),(565,'Vishakhapatnam'),(566,'Vizianagaram'),(567,'Warangal'),(568,'Wardha'),(569,'Washim'),(570,'Wayanad'),(571,'West Garo Hills'),(572,'West Godavari'),(573,'West Imphal'),(574,'West Kameng'),(575,'West Khasi Hills'),(576,'West Nimar'),(577,'West Siang'),(578,'West Sikkim'),(579,'West Tripura'),(580,'Wokha'),(581,'Yamuna Nagar'),(582,'Yamunanagar'),(583,'Yanam'),(584,'Yavatmal'),(585,'Zunheboto');
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
  `invoiceNumber` varchar(11) NOT NULL,
  `subscriptionId` int(15) DEFAULT NULL,
  `invoiceCreationDate` date DEFAULT NULL,
  `invoice_type_id` int(11) NOT NULL DEFAULT '1',
  `amount` float unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `invoice_idx1` (`subscriptionId`,`invoice_type_id`),
  KEY `invoice_indx2` (`invoiceNumber`)
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
-- Table structure for table `invoice_types`
--

DROP TABLE IF EXISTS `invoice_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_type` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uniq_invoice_types` (`invoice_type`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_types`
--

LOCK TABLES `invoice_types` WRITE;
/*!40000 ALTER TABLE `invoice_types` DISABLE KEYS */;
INSERT INTO `invoice_types` VALUES (2,'Outstanding Payment'),(3,'Please Refer Invoice'),(1,'Request For Invoice');
/*!40000 ALTER TABLE `invoice_types` ENABLE KEYS */;
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
  `chqddNumber` varchar(6) DEFAULT NULL,
  `paymentDate` date DEFAULT NULL,
  `amount` float DEFAULT '0',
  `currency` int(11) DEFAULT NULL,
  `chequeDDReturn` tinyint(1) NOT NULL DEFAULT '0',
  `chequeDDReturnReason` int(11) unsigned DEFAULT NULL,
  `chequeDDReturnReasonOther` varchar(64) DEFAULT NULL,
  `receiptNumber` int(11) DEFAULT NULL,
  `receiptDate` date DEFAULT NULL,
  `ackDate` date DEFAULT NULL,
  `remarks` text,
  `bankName` varchar(64) DEFAULT NULL,
  `returnDate` date DEFAULT NULL,
  `completed` tinyint(4) NOT NULL DEFAULT '0',
  `language` int(11) NOT NULL DEFAULT '1',
  `valid` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `inward_no_UNIQUE` (`inwardNumber`),
  KEY `city` (`city`),
  KEY `inwardCreationDate` (`inwardCreationDate`),
  KEY `inwardPurpose` (`inwardPurpose`),
  KEY `inward_completed_index` (`completed`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inward`
--

LOCK TABLES `inward` WRITE;
/*!40000 ALTER TABLE `inward` DISABLE KEYS */;
/*!40000 ALTER TABLE `inward` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `jds`.`complete_non_process_inward` BEFORE INSERT















    ON jds.inward FOR EACH ROW















BEGIN















    if new.inwardPurpose in (6,7,8,9) then















      set new.completed = true;















    end if;































END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `inward_agent_details`
--

DROP TABLE IF EXISTS `inward_agent_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inward_agent_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inwardId` int(11) NOT NULL,
  `agentId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `inward_agent_details_indx1` (`agentId`,`inwardId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inward_agent_details`
--

LOCK TABLES `inward_agent_details` WRITE;
/*!40000 ALTER TABLE `inward_agent_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `inward_agent_details` ENABLE KEYS */;
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
INSERT INTO `inward_purpose` VALUES (10,'Address Change'),(7,'Advertisement'),(8,'Manuscript'),(5,'Missing Issue'),(1,'New Subscription'),(9,'Others'),(3,'Payment'),(2,'Renew Subscription'),(6,'Reprint'),(4,'Request For Invoice');
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
-- Table structure for table `journal_details`
--

DROP TABLE IF EXISTS `journal_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journal_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `journals_id` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `pages` varchar(11) DEFAULT '0',
  `issues` int(11) NOT NULL,
  `page_size` varchar(11) DEFAULT 'A4',
  `no_of_volumes` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal_details`
--

LOCK TABLES `journal_details` WRITE;
/*!40000 ALTER TABLE `journal_details` DISABLE KEYS */;
INSERT INTO `journal_details` VALUES (1,1,2012,'1800',12,'A4',2),(2,2,2012,'400',4,'A4',1),(3,3,2012,'400',4,'A4',1),(4,4,2012,'600',6,'Other',1),(5,5,2012,'600',6,'Other',1),(6,6,2012,'600',6,'Other',1),(7,7,2012,'600',6,'A4',1),(8,8,2012,'500',4,'Other',1),(9,9,2012,'400',3,'Other',1),(10,10,2012,'1200',12,'A4',1),(11,11,2012,'3000',24,'Other',2),(12,1,2013,'1800',12,'A4',2),(13,2,2013,'400',4,'A4',1),(14,3,2013,'400',4,'A4',1),(15,4,2013,'600',6,'Other',1),(16,5,2013,'600',6,'Other',1),(17,6,2013,'600',6,'Other',1),(18,7,2013,'600',6,'A4',1),(19,8,2013,'500',4,'Other',1),(20,9,2013,'400',3,'Other',1),(21,10,2013,'1200',12,'A4',1),(22,11,2013,'3000',24,'Other',2);
/*!40000 ALTER TABLE `journal_details` ENABLE KEYS */;
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
  PRIMARY KEY (`id`),
  KEY `journal_group_contents_indx2` (`journalId`),
  KEY `journal_group_contents_indx3` (`journalGroupId`)
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
-- Table structure for table `journal_volume_details`
--

DROP TABLE IF EXISTS `journal_volume_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journal_volume_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `journal_details_id` int(11) NOT NULL,
  `volume_number` int(11) DEFAULT NULL,
  `start_month` varchar(11) DEFAULT 'January',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal_volume_details`
--

LOCK TABLES `journal_volume_details` WRITE;
/*!40000 ALTER TABLE `journal_volume_details` DISABLE KEYS */;
INSERT INTO `journal_volume_details` VALUES (1,1,78,'January'),(2,1,79,'July'),(3,2,33,'January'),(4,3,122,'January'),(5,4,121,'January'),(6,5,124,'January'),(7,6,35,'January'),(8,7,37,'January'),(9,8,37,'January'),(10,9,91,'January'),(11,10,17,'January'),(12,11,102,'January'),(13,11,103,'July'),(14,12,80,'January'),(15,12,81,'July'),(16,13,34,'January'),(17,14,123,'January'),(18,15,122,'January'),(19,16,125,'January'),(20,17,36,'January'),(21,18,38,'January'),(22,19,38,'January'),(23,20,92,'January'),(24,21,18,'January'),(25,22,104,'January'),(26,22,105,'July');
/*!40000 ALTER TABLE `journal_volume_details` ENABLE KEYS */;
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
  `startYear` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`,`journalName`,`journalCode`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journals`
--

LOCK TABLES `journals` WRITE;
/*!40000 ALTER TABLE `journals` DISABLE KEYS */;
INSERT INTO `journals` VALUES (1,'P','Pramana - Journal of Physics','0304-4289',1987),(2,'JAA','Journal of Astrophysics and Astronomy','0250-6335',1978),(3,'MS','Proceedings (Mathematical Sciences)','0253-4142',2010),(4,'EPS','Journal of Earth System Science (formerly Proc. Earth Planet Sci.)','0253-4126',1991),(5,'CS','Journal of Chemical Sciences (formerly Proc. Chemical Sci.)','0253-4134',2000),(6,'BMS','Bulletin of Materials Science','0250-4707',1995),(7,'S','Sadhana (Engineering Sciences)','0256-2499',1980),(8,'JB','Journal of Biosciences','0250-5991',2010),(9,'JG','Journal of Genetics','0022-1333',2011),(10,'RES','Resonanace - Journal of Science Education','0971-8044',2000),(11,'CURR','Current Science','0011-3891',2000);
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
  `year` int(11) NOT NULL,
  `volumeNumber` int(11) NOT NULL,
  `issue` int(11) NOT NULL,
  `month` int(11) NOT NULL,
  `mlDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `mailing_list_indx1` (`journalId`),
  KEY `mailing_list_indx2` (`journalId`,`volumeNumber`,`issue`,`year`)
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
  `subtypecode` char(6) NOT NULL,
  `subscriberNumber` varchar(20) NOT NULL,
  `subscriberName` varchar(64) NOT NULL,
  `department` varchar(64) DEFAULT NULL,
  `institution` varchar(64) DEFAULT NULL,
  `address` varchar(128) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `district` varchar(64) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL,
  `pincode` int(11) DEFAULT NULL,
  `copies` int(11) NOT NULL DEFAULT '0',
  `startYear` int(11) DEFAULT NULL,
  `startMonth` int(11) DEFAULT NULL,
  `endYear` int(11) DEFAULT NULL,
  `volumeNumber` int(11) NOT NULL,
  `issue` int(11) NOT NULL,
  `endMonth` int(11) DEFAULT NULL,
  `month` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `bilid` int(11) DEFAULT '0',
  `miId` int(11) DEFAULT '0',
  `bildate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mailing_list_detail_indx1` (`journalCode`),
  KEY `mailing_list_detail_indx2` (`subtypecode`),
  KEY `mailing_list_detail_indx3` (`volumeNumber`,`issue`,`year`),
  KEY `mailing_list_detail4` (`mailinglistId`)
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
  `issue` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `missingCopies` int(11) NOT NULL,
  `action` char(1) DEFAULT NULL,
  `sentOn` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `mailinglistid` int(11) DEFAULT '0',
  `volumeNo` int(11) NOT NULL,
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
  `invoice_id` int(10) unsigned NOT NULL,
  `amount` float unsigned NOT NULL DEFAULT '0',
  `remarks` varchar(20) DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_inward_id` (`inwardID`,`invoice_id`),
  KEY `payment_idx1` (`invoice_id`),
  KEY `payment_idx2` (`inwardID`)
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
  `volume_number` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `print_order`
--

LOCK TABLES `print_order` WRITE;
/*!40000 ALTER TABLE `print_order` DISABLE KEYS */;
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (15,2013,1,1,2450,80);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (16,2013,1,2,2450,80);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (17,2013,1,3,2450,80);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (18,2013,1,4,2450,80);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (19,2013,1,5,2450,80);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (20,2013,1,6,2450,80);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (21,2013,1,1,2450,81);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (22,2013,1,2,2450,81);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (23,2013,1,3,2450,81);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (24,2013,1,4,2450,81);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (25,2013,1,5,2450,81);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (26,2013,1,6,2450,81);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (27,2013,2,1,1450,34);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (28,2013,2,2,1450,34);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (29,2013,2,3,1450,34);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (30,2013,2,4,1450,34);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (31,2013,3,1,2100,123);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (32,2013,3,2,2100,123);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (33,2013,3,3,2100,123);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (34,2013,3,4,2100,123);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (35,2013,4,1,1500,122);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (36,2013,4,2,1500,122);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (37,2013,4,3,1500,122);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (38,2013,4,4,1500,122);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (39,2013,4,5,1500,122);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (40,2013,4,6,1500,122);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (41,2013,5,1,2150,125);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (42,2013,5,2,2150,125);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (43,2013,5,3,2150,125);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (44,2013,5,4,2150,125);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (45,2013,5,5,2150,125);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (46,2013,5,6,2150,125);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (47,2013,6,1,2650,36);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (48,2013,6,2,2650,36);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (49,2013,6,3,2650,36);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (50,2013,6,4,2650,36);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (51,2013,6,5,2650,36);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (52,2013,6,6,2650,36);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (53,2013,7,1,1900,38);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (54,2013,7,2,1900,38);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (55,2013,7,3,1900,38);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (56,2013,7,4,1900,38);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (57,2013,7,5,1900,38);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (58,2013,7,6,1900,38);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (59,2013,9,1,1950,92);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (60,2013,9,2,1950,92);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (61,2013,9,3,1950,92);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (62,2013,10,11,8000,18);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (63,2013,10,12,8000,18);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (64,2013,10,1,8000,18);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (65,2013,10,2,8000,18);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (66,2013,10,3,8000,18);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (67,2013,10,4,8000,18);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (68,2013,10,5,8000,18);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (69,2013,10,6,8000,18);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (70,2013,10,7,8000,18);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (71,2013,10,8,8000,18);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (72,2013,10,9,8000,18);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (73,2013,10,10,8000,18);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (74,2013,11,1,6000,104);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (75,2013,11,2,6000,104);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (76,2013,11,3,6000,104);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (77,2013,11,4,6000,104);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (78,2013,11,5,6000,104);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (79,2013,11,6,6000,104);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (80,2013,11,7,6000,104);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (81,2013,11,8,6000,104);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (82,2013,11,9,6000,104);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (83,2013,11,10,6000,104);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (84,2013,11,11,6000,104);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (85,2013,11,12,6000,104);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (86,2013,11,1,6000,105);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (87,2013,11,2,6000,105);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (88,2013,11,3,6000,105);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (89,2013,11,4,6000,105);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (90,2013,11,5,6000,105);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (91,2013,11,6,6000,105);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (92,2013,11,7,6000,105);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (93,2013,11,8,6000,105);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (94,2013,11,9,6000,105);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (95,2013,11,10,6000,105);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (96,2013,11,11,6000,105);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (97,2013,11,12,6000,105);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (98,2013,8,1,2400,38);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (99,2013,8,2,2400,38);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (100,2013,8,3,2400,38);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (101,2013,8,4,2400,38);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (102,2013,8,5,2400,38);
insert into `print_order`(`id`,`year`,`journalId`,`issueNo`,`printOrder`,`volume_number`) values (103,2013,8,6,2400,38);
/*!40000 ALTER TABLE `print_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prl`
--

DROP TABLE IF EXISTS `prl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `year` int(4) NOT NULL DEFAULT '0',
  `ctext` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `prl_indx_1` (`year`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prl`
--

LOCK TABLES `prl` WRITE;
/*!40000 ALTER TABLE `prl` DISABLE KEYS */;
/*!40000 ALTER TABLE `prl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prl_details`
--

DROP TABLE IF EXISTS `prl_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prl_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prl_id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `period` int(11) NOT NULL DEFAULT '0',
  `by_email` tinyint(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `prl_details_indx_1` (`prl_id`),
  KEY `prl_details_indx_2` (`invoice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prl_details`
--

LOCK TABLES `prl_details` WRITE;
/*!40000 ALTER TABLE `prl_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `prl_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reminder_details`
--

DROP TABLE IF EXISTS `reminder_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reminder_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reminderId` int(11) NOT NULL,
  `medium` char(1) NOT NULL,
  `language` int(11) NOT NULL,
  `sent_date` date NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `states`
--

LOCK TABLES `states` WRITE;
/*!40000 ALTER TABLE `states` DISABLE KEYS */;
INSERT INTO `states` VALUES (33,'Andaman & Nicobar'),(1,'Andhra Pradesh'),(2,'Arunachal Pradesh'),(3,'Assam'),(4,'Bihar'),(5,'Chandigarh'),(6,'Chhattisgarh'),(7,'Dadra and Nagar Haveli'),(34,'Daman & Diu'),(8,'Delhi'),(9,'Goa'),(10,'Gujarat'),(11,'Haryana'),(12,'Himachal Pradesh'),(13,'Jammu & Kashmir'),(14,'Jharkhand'),(15,'Karnataka'),(16,'Kerala'),(35,'Lakshadweep'),(17,'Madhya Pradesh'),(18,'Maharashtra'),(19,'Manipur'),(20,'Meghalaya'),(21,'Mizoram'),(22,'Nagaland'),(23,'Odisha'),(24,'Pondicherry'),(25,'Punjab'),(26,'Rajasthan'),(27,'Sikkim'),(28,'Tamil Nadu'),(29,'Tripura'),(30,'Uttar Pradesh'),(31,'Uttarakhand'),(32,'West Bengal');
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
  `invoiceAddress` varchar(512) NOT NULL,
  `city` int(11) NOT NULL DEFAULT '0',
  `district` int(11) DEFAULT NULL,
  `state` int(11) NOT NULL DEFAULT '0',
  `country` int(11) NOT NULL DEFAULT '0',
  `pincode` int(6) NOT NULL DEFAULT '0',
  `email` varchar(64) DEFAULT NULL,
  `subtype` int(11) unsigned NOT NULL DEFAULT '0',
  `agent` int(11) DEFAULT NULL,
  `deactive` tinyint(1) NOT NULL DEFAULT '0',
  `deactivationDate` date DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `fax` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subscriber_id_UNIQUE` (`subscriberNumber`) USING BTREE,
  KEY `subscriberName` (`subscriberName`),
  KEY `subscriberCity` (`city`),
  KEY `subscriberPincode` (`pincode`),
  KEY `department` (`department`,`institution`),
  KEY `subscriber_type_indx` (`subtype`),
  KEY `subscriber_email_indx` (`email`)
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriber_type`
--

LOCK TABLES `subscriber_type` WRITE;
/*!40000 ALTER TABLE `subscriber_type` DISABLE KEYS */;
INSERT INTO `subscriber_type` VALUES (1,'FELJM','Fellows','Free','I','P',2,0.000),(2,'AS','Associate','Free','I','P',2,0.000),(3,'EBALL','Editorial Board Member','Free','I','P',1,0.000),(4,'EI','Indian Exchange','Free','I','I',0,0.000),(5,'EF','Foreign Exchange','Free','F','I',0,0.000),(6,'GRANT','Grant','Free','I','P',2,0.000),(7,'AUTH','Author','Free','I','P',1,0.000),(8,'II','Indian Universities and Institutions','Paid','I','I',0,0.000),(9,'IC','Indian Schools and Colleges','Paid','I','I',0,0.000),(10,'IN','Industry Corporates','Paid','I','I',0,0.000),(11,'IP','Indian Personal','Paid','I','P',0,0.000),(12,'FP','Foreign Personal','Paid','F','P',0,0.000),(13,'FI','Foreign Institutions','Paid','F','I',0,0.000),(14,'SF','Summer Fellows','Free','I','P',1,0.000),(15,'HONFEL','Honorary Fellow','Free','I','P',0,0.000),(16,'LSP','Life Subscriber Personal','Paid','I','P',0,0.000),(17,'LSI','Life Subscriber Institutions','Paid','I','I',0,0.000),(18,'MEMBER','Members','Free','I','P',0,0.000),(19,'WC','Working Committee','Free','I','P',0,0.000);
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
  `agentID` int(11) DEFAULT '0',
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `subscriptionDate` date NOT NULL DEFAULT '0000-00-00',
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
-- Table structure for table `subscription_legacy`
--

DROP TABLE IF EXISTS `subscription_legacy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscription_legacy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subscription_id` int(11) NOT NULL,
  `legacy` tinyint(4) NOT NULL DEFAULT '1',
  `legacy_amount` float NOT NULL DEFAULT '0',
  `legacy_balance` float unsigned NOT NULL DEFAULT '0',
  `legacy_proforma_invoice_no` char(10) DEFAULT NULL,
  `legacy_proforma_invoice_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subscription_legacy_indx1` (`subscription_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription_legacy`
--

LOCK TABLES `subscription_legacy` WRITE;
/*!40000 ALTER TABLE `subscription_legacy` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscription_legacy` ENABLE KEYS */;
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
  PRIMARY KEY (`id`),
  KEY `subscription_rates_idx1` (`journalGroupId`),
  KEY `subscription_rates_idx2` (`subtypeId`),
  KEY `subscription_rates_idx3` (`year`),
  KEY `subscription_rates_idx4` (`period`)
) ENGINE=InnoDB AUTO_INCREMENT=612 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription_rates`
--

LOCK TABLES `subscription_rates` WRITE;
/*!40000 ALTER TABLE `subscription_rates` DISABLE KEYS */;
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (1,0,0,0,0,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (2,11,10,2013,1,10000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (3,12,10,2013,1,13000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (4,13,10,2013,1,3300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (5,10,10,2013,2,900);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (6,10,10,2013,3,1300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (7,10,10,2013,5,2000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (8,11,10,2013,2,18000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (9,11,10,2013,3,26000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (10,11,10,2013,5,44000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (11,1,8,2013,1,750);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (12,2,8,2013,1,300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (13,3,8,2013,1,300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (14,4,8,2013,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (15,5,8,2013,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (16,6,8,2013,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (17,7,8,2013,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (18,8,8,2013,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (19,9,8,2013,1,300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (20,10,8,2013,1,500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (21,11,8,2013,1,4000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (22,12,8,2013,1,7000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (23,13,8,2013,1,3300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (24,10,8,2013,2,900);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (25,10,8,2013,3,1300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (26,10,8,2013,5,2000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (27,11,8,2013,2,7500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (28,11,8,2013,3,10000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (29,11,8,2013,5,16000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (30,1,9,2013,1,750);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (31,2,9,2013,1,300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (32,3,9,2013,1,300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (33,4,9,2013,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (34,5,9,2013,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (35,6,9,2013,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (36,7,9,2013,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (37,8,9,2013,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (38,9,9,2013,1,300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (39,10,9,2013,1,500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (40,11,9,2013,1,1500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (41,12,9,2013,1,4800);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (42,13,9,2013,1,3300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (43,10,9,2013,2,900);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (44,10,9,2013,3,1300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (45,10,9,2013,5,2000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (46,11,9,2013,2,2250);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (47,11,9,2013,3,3500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (48,11,9,2013,5,6000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (49,1,11,2013,2,700);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (50,2,11,2013,2,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (51,3,11,2013,2,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (52,4,11,2013,2,500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (53,5,11,2013,2,500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (54,6,11,2013,2,500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (55,7,11,2013,2,500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (56,8,11,2013,2,500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (57,9,11,2013,2,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (58,10,11,2013,2,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (59,11,11,2013,2,1250);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (60,10,11,2013,3,650);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (61,10,11,2013,5,1010);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (62,11,11,2013,3,1750);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (63,11,11,2013,5,3000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (64,11,10,2012,1,10000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (65,1,8,2012,1,750);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (66,2,8,2012,1,300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (67,3,8,2012,1,300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (68,4,8,2012,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (69,5,8,2012,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (70,6,8,2012,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (71,7,8,2012,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (72,8,8,2012,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (73,9,8,2012,1,300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (74,10,8,2012,1,500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (75,11,8,2012,1,4000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (76,12,8,2012,1,7000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (77,13,8,2012,1,3300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (78,10,8,2012,2,900);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (79,10,8,2012,3,1300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (80,10,8,2012,5,2000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (81,11,8,2012,2,7500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (82,11,8,2012,3,10000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (83,11,8,2012,5,16000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (84,1,9,2012,1,750);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (85,2,9,2012,1,300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (86,3,9,2012,1,300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (87,4,9,2012,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (88,5,9,2012,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (89,6,9,2012,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (90,7,9,2012,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (91,8,9,2012,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (92,9,9,2012,1,300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (93,10,9,2012,1,500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (94,11,9,2012,1,1500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (95,12,9,2012,1,4800);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (96,13,9,2012,1,3300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (97,10,9,2012,2,900);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (98,10,9,2012,3,1300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (99,10,9,2012,5,2000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (100,11,9,2012,2,2250);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (101,11,9,2012,3,3500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (102,11,9,2012,5,6000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (103,1,11,2012,2,700);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (104,2,11,2012,2,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (105,3,11,2012,2,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (106,4,11,2012,2,500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (107,5,11,2012,2,500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (108,6,11,2012,2,500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (109,7,11,2012,2,500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (110,8,11,2012,2,500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (111,9,11,2012,2,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (112,10,11,2012,2,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (113,11,11,2012,2,1250);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (114,10,11,2012,3,650);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (115,10,11,2012,5,1010);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (116,11,11,2012,3,1750);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (117,11,11,2012,5,3000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (118,1,1,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (119,2,1,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (120,3,1,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (121,4,1,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (122,5,1,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (123,6,1,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (124,7,1,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (125,8,1,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (126,9,1,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (127,10,1,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (128,11,1,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (129,1,2,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (130,2,2,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (131,3,2,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (132,4,2,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (133,5,2,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (134,6,2,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (135,7,2,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (136,8,2,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (137,9,2,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (138,10,2,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (139,11,2,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (140,1,3,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (141,2,3,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (142,3,3,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (143,4,3,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (144,5,3,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (145,6,3,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (146,7,3,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (147,8,3,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (148,9,3,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (149,10,3,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (150,11,3,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (151,1,4,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (152,2,4,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (153,3,4,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (154,4,4,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (155,5,4,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (156,6,4,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (157,7,4,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (158,8,4,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (159,9,4,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (160,10,4,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (161,11,4,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (162,1,5,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (163,2,5,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (164,3,5,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (165,4,5,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (166,5,5,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (167,6,5,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (168,7,5,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (169,8,5,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (170,9,5,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (171,10,5,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (172,11,5,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (173,1,6,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (174,2,6,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (175,3,6,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (176,4,6,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (177,5,6,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (178,6,6,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (179,7,6,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (180,8,6,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (181,9,6,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (182,10,6,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (183,11,6,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (184,1,7,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (185,2,7,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (186,3,7,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (187,4,7,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (188,5,7,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (189,6,7,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (190,7,7,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (191,8,7,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (192,9,7,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (193,10,7,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (194,11,7,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (195,1,14,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (196,2,14,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (197,3,14,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (198,4,14,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (199,5,14,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (200,6,14,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (201,7,14,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (202,8,14,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (203,9,14,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (204,10,14,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (205,11,14,2012,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (206,1,8,2011,1,750);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (207,2,8,2011,1,300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (208,3,8,2011,1,300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (209,4,8,2011,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (210,5,8,2011,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (211,6,8,2011,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (212,7,8,2011,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (213,8,8,2011,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (214,9,8,2011,1,300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (215,10,8,2011,1,500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (216,11,8,2011,1,4000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (217,12,8,2011,1,6000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (218,13,8,2011,1,3300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (219,10,8,2011,2,900);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (220,10,8,2011,3,1300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (221,10,8,2011,5,2000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (222,11,8,2011,2,5400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (223,11,8,2011,3,8000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (224,11,8,2011,5,12000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (225,1,9,2011,1,750);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (226,2,9,2011,1,300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (227,3,9,2011,1,300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (228,4,9,2011,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (229,5,9,2011,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (230,6,9,2011,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (231,7,9,2011,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (232,8,9,2011,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (233,9,9,2011,1,300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (234,10,9,2011,1,500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (235,11,9,2011,1,1500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (236,12,9,2011,1,4200);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (237,13,9,2011,1,3300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (238,10,9,2011,2,900);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (239,10,9,2011,3,1300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (240,10,9,2011,5,2000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (241,11,9,2011,2,1750);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (242,11,9,2011,3,2500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (243,11,9,2011,5,4500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (244,1,11,2011,2,700);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (245,2,11,2011,2,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (246,3,11,2011,2,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (247,4,11,2011,2,500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (248,5,11,2011,2,500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (249,6,11,2011,2,500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (250,7,11,2011,2,500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (251,8,11,2011,2,500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (252,9,11,2011,2,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (253,10,11,2011,2,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (254,11,11,2011,2,1250);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (255,10,11,2011,3,650);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (256,10,11,2011,5,1010);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (257,11,11,2011,3,1600);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (258,11,11,2011,5,2700);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (259,1,1,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (260,2,1,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (261,3,1,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (262,4,1,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (263,5,1,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (264,6,1,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (265,7,1,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (266,8,1,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (267,9,1,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (268,10,1,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (269,11,1,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (270,1,2,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (271,2,2,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (272,3,2,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (273,4,2,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (274,5,2,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (275,6,2,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (276,7,2,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (277,8,2,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (278,9,2,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (279,10,2,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (280,11,2,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (281,1,3,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (282,2,3,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (283,3,3,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (284,4,3,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (285,5,3,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (286,6,3,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (287,7,3,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (288,8,3,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (289,9,3,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (290,10,3,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (291,11,3,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (292,1,4,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (293,2,4,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (294,3,4,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (295,4,4,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (296,5,4,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (297,6,4,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (298,7,4,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (299,8,4,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (300,9,4,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (301,10,4,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (302,11,4,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (303,1,5,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (304,2,5,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (305,3,5,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (306,4,5,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (307,5,5,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (308,6,5,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (309,7,5,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (310,8,5,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (311,9,5,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (312,10,5,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (313,11,5,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (314,1,6,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (315,2,6,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (316,3,6,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (317,4,6,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (318,5,6,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (319,6,6,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (320,7,6,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (321,8,6,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (322,9,6,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (323,10,6,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (324,11,6,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (325,1,7,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (326,2,7,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (327,3,7,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (328,4,7,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (329,5,7,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (330,6,7,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (331,7,7,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (332,8,7,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (333,9,7,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (334,10,7,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (335,11,7,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (336,1,14,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (337,2,14,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (338,3,14,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (339,4,14,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (340,5,14,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (341,6,14,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (342,7,14,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (343,8,14,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (344,9,14,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (345,10,14,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (346,11,14,2011,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (347,1,8,2010,1,750);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (348,2,8,2010,1,300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (349,3,8,2010,1,300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (350,4,8,2010,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (351,5,8,2010,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (352,6,8,2010,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (353,7,8,2010,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (354,8,8,2010,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (355,9,8,2010,1,300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (356,10,8,2010,1,500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (357,11,8,2010,1,4000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (358,12,8,2010,1,6000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (359,13,8,2010,1,3300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (360,10,8,2010,2,900);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (361,10,8,2010,3,1300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (362,10,8,2010,5,2000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (363,11,8,2010,2,5400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (364,11,8,2010,3,8000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (365,11,8,2010,5,12000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (366,1,9,2010,1,750);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (367,2,9,2010,1,300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (368,3,9,2010,1,300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (369,4,9,2010,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (370,5,9,2010,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (371,6,9,2010,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (372,7,9,2010,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (373,8,9,2010,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (374,9,9,2010,1,300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (375,10,9,2010,1,500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (376,11,9,2010,1,1500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (377,12,9,2010,1,4200);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (378,13,9,2010,1,3300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (379,10,9,2010,2,900);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (380,10,9,2010,3,1300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (381,10,9,2010,5,2000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (382,11,9,2010,2,1750);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (383,11,9,2010,3,2500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (384,11,9,2010,5,4500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (385,1,11,2010,2,700);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (386,2,11,2010,2,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (387,3,11,2010,2,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (388,4,11,2010,2,500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (389,5,11,2010,2,500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (390,6,11,2010,2,500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (391,7,11,2010,2,500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (392,8,11,2010,2,500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (393,9,11,2010,2,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (394,10,11,2010,2,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (395,11,11,2010,2,1250);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (396,10,11,2010,3,650);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (397,10,11,2010,5,1010);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (398,11,11,2010,3,1600);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (399,11,11,2010,5,2700);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (400,1,1,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (401,2,1,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (402,3,1,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (403,4,1,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (404,5,1,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (405,6,1,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (406,7,1,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (407,8,1,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (408,9,1,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (409,10,1,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (410,11,1,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (411,1,2,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (412,2,2,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (413,3,2,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (414,4,2,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (415,5,2,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (416,6,2,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (417,7,2,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (418,8,2,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (419,9,2,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (420,10,2,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (421,11,2,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (422,1,3,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (423,2,3,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (424,3,3,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (425,4,3,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (426,5,3,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (427,6,3,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (428,7,3,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (429,8,3,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (430,9,3,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (431,10,3,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (432,11,3,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (433,1,4,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (434,2,4,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (435,3,4,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (436,4,4,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (437,5,4,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (438,6,4,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (439,7,4,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (440,8,4,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (441,9,4,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (442,10,4,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (443,11,4,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (444,1,5,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (445,2,5,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (446,3,5,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (447,4,5,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (448,5,5,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (449,6,5,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (450,7,5,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (451,8,5,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (452,9,5,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (453,10,5,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (454,11,5,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (455,1,6,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (456,2,6,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (457,3,6,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (458,4,6,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (459,5,6,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (460,6,6,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (461,7,6,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (462,8,6,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (463,9,6,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (464,10,6,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (465,11,6,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (466,1,7,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (467,2,7,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (468,3,7,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (469,4,7,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (470,5,7,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (471,6,7,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (472,7,7,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (473,8,7,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (474,9,7,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (475,10,7,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (476,11,7,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (477,1,14,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (478,2,14,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (479,3,14,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (480,4,14,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (481,5,14,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (482,6,14,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (483,7,14,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (484,8,14,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (485,9,14,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (486,10,14,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (487,11,14,2010,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (488,11,10,2009,1,4000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (489,1,11,2009,2,600);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (490,2,11,2009,2,350);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (491,3,11,2009,2,350);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (492,4,11,2009,2,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (493,5,11,2009,2,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (494,6,11,2009,2,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (495,7,11,2009,2,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (496,8,11,2009,2,350);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (497,9,11,2009,2,350);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (498,10,11,2009,2,350);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (499,11,11,2009,2,900);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (500,1,8,2009,1,500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (501,2,8,2009,1,250);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (502,3,8,2009,1,250);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (503,4,8,2009,1,300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (504,5,8,2009,1,300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (505,6,8,2009,1,300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (506,7,8,2009,1,300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (507,8,8,2009,1,250);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (508,9,8,2009,1,250);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (509,10,8,2009,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (510,11,8,2009,1,2000);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (511,12,8,2009,1,4300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (512,1,9,2009,1,500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (513,2,9,2009,1,250);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (514,3,9,2009,1,250);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (515,4,9,2009,1,300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (516,5,9,2009,1,300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (517,6,9,2009,1,300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (518,7,9,2009,1,300);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (519,8,9,2009,1,250);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (520,9,9,2009,1,250);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (521,10,9,2009,1,400);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (522,11,9,2009,1,750);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (523,12,9,2009,1,3200);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (524,1,1,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (525,2,1,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (526,3,1,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (527,4,1,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (528,5,1,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (529,6,1,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (530,7,1,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (531,8,1,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (532,9,1,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (533,10,1,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (534,11,1,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (535,1,2,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (536,2,2,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (537,3,2,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (538,4,2,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (539,5,2,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (540,6,2,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (541,7,2,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (542,8,2,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (543,9,2,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (544,10,2,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (545,11,2,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (546,1,3,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (547,2,3,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (548,3,3,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (549,4,3,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (550,5,3,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (551,6,3,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (552,7,3,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (553,8,3,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (554,9,3,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (555,10,3,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (556,11,3,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (557,1,4,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (558,2,4,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (559,3,4,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (560,4,4,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (561,5,4,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (562,6,4,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (563,7,4,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (564,8,4,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (565,9,4,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (566,10,4,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (567,11,4,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (568,1,5,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (569,2,5,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (570,3,5,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (571,4,5,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (572,5,5,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (573,6,5,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (574,7,5,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (575,8,5,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (576,9,5,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (577,10,5,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (578,11,5,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (579,1,6,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (580,2,6,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (581,3,6,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (582,4,6,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (583,5,6,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (584,6,6,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (585,7,6,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (586,8,6,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (587,9,6,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (588,10,6,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (589,11,6,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (590,1,7,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (591,2,7,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (592,3,7,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (593,4,7,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (594,5,7,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (595,6,7,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (596,7,7,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (597,8,7,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (598,9,7,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (599,10,7,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (600,11,7,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (601,1,14,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (602,2,14,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (603,3,14,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (604,4,14,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (605,5,14,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (606,6,14,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (607,7,14,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (608,8,14,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (609,9,14,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (610,10,14,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (611,11,14,2009,1,0);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (612,1,9,2013,2,1500);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (613,1,9,2013,3,2250);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (614,2,9,2013,2,600);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (615,2,9,2013,3,900);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (616,3,9,2013,2,600);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (617,3,9,2013,3,900);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (618,4,9,2013,2,800);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (619,4,9,2013,3,1200);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (620,5,9,2013,2,800);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (621,5,9,2013,3,1200);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (622,6,9,2013,2,800);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (623,6,9,2013,3,1200);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (624,7,9,2013,2,800);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (625,7,9,2013,3,1200);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (626,8,9,2013,2,800);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (627,8,9,2013,3,1200);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (628,9,9,2013,2,600);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (629,9,9,2013,3,900);
insert into `subscription_rates`(`id`,`journalGroupId`,`subtypeId`,`year`,`period`,`rate`) values (630,11,17,2013,10,50000);
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
  KEY `journalPriceGroupID` (`journalPriceGroupID`),
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `jds`.`deactivate_subscription` BEFORE INSERT
    ON jds.subscriptiondetails FOR EACH ROW
BEGIN

   IF new.endyear < YEAR(CURRENT_TIMESTAMP) THEN



      SET new.active = FALSE;



   END IF;

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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `jds`.`add_back_issues` AFTER INSERT
    ON jds.subscriptiondetails FOR EACH ROW
BEGIN

   CALL addBackIssues(new.id,



                      new.startMonth,



                      new.startYear,



                      new.journalGroupID,



                      new.copies);



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
CREATE DEFINER=`root`@`localhost` TRIGGER edit_bil BEFORE UPDATE ON jds.subscriptiondetails FOR EACH ROW
BEGIN
  begin_level_1:
   BEGIN
    DECLARE is_sent_to_subscriber tinyint DEFAULT 0;
    DECLARE proceed_further tinyint DEFAULT TRUE;
    DECLARE done int DEFAULT 0;
    DECLARE _journal_id int;
    DECLARE _month int;
    DECLARE _year int;
    DECLARE _copies int;
    DECLARE _issue_number int;
    DECLARE _volume_number int;
    DECLARE _active tinyint DEFAULT 0;
    DECLARE diff int DEFAULT 0;
    DECLARE back_issue_list_id int;
    DECLARE updated_flag tinyint DEFAULT 0;
    DECLARE count_not_sent int DEFAULT 0;
    DECLARE count_sent int DEFAULT 0;
    DECLARE copies_already_sent_subscriber int DEFAULT 0;
    DECLARE cur1 CURSOR FOR SELECT t3.id,
                                   t3.journal_id,
                                   t3.month,
                                   t3.`year`,
                                   t3.copies,
                                   t3.issue_number,
                                   t3.volume_number,
                                   t3.sent_to_subscriber,
                                   t3.active
                            FROM  subscriptiondetails t1,
                                  journal_group_contents t2,
                                  back_issue_list t3
                            WHERE t1.journalGroupID=t2.journalGroupId
                            AND t3.journal_id=t2.journalId
                            AND t3.subscription_detail_id=old.id
                            AND t3.active=TRUE
                            AND t3.sent_to_subscriber=TRUE
                            GROUP BY t3.id,t3.journal_id,t3.month,t3.`year`,t3.issue_number,t3.volume_number,t3.sent_to_subscriber,t3.active;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
      IF     new.startYear > old.startYear
         AND new.startYear > year(CURRENT_DATE())
      THEN
         UPDATE back_issue_list
            SET active = FALSE
          WHERE     subscription_detail_id = old.id
                AND sent_to_subscriber = FALSE
                AND back_issue_list.year = old.startYear;
         LEAVE begin_level_1;
      ELSEIF     new.startYear < old.startYear
             AND new.startYear = year(CURRENT_DATE())
      THEN
         SELECT copies
           INTO copies_already_sent_subscriber
           FROM back_issue_list
          WHERE     subscription_detail_id = old.id
                AND sent_to_subscriber = TRUE
                AND active = TRUE
          LIMIT 1;
         SET diff := old.copies - copies_already_sent_subscriber;
         IF diff > 0
         THEN
            CALL addBackIssues(old.id,
                               new.startMonth,
                               new.startYear,
                               new.journalGroupID,
                               diff);
         END IF;
      END IF;
      IF new.startMonth > old.startMonth
      THEN
         UPDATE back_issue_list
            SET active = FALSE
          WHERE     subscription_detail_id = old.id
                AND sent_to_subscriber = FALSE
                AND back_issue_list.month < new.startMonth;
      ELSEIF new.startMonth < old.startMonth
      THEN
         UPDATE back_issue_list
            SET active = FALSE
          WHERE     subscription_detail_id = old.id
                AND sent_to_subscriber = FALSE
                AND back_issue_list.month >= new.startMonth;
         SET diff := getDeltaCopies(old.id);
         IF diff > 0
         THEN
            CALL addBackIssues(old.id,
                               new.startMonth,
                               new.startYear,
                               new.journalGroupID,
                               diff);
         ELSE
            CALL addBackIssues(old.id,
                               new.startMonth,
                               new.startYear,
                               new.journalGroupID,
                               new.copies);
         END IF;
      END IF;
      IF new.active = FALSE AND old.active = TRUE
      THEN
         UPDATE back_issue_list
            SET active = FALSE
          WHERE     subscription_detail_id = old.id
                AND sent_to_subscriber = FALSE;
         LEAVE begin_level_1;
      ELSEIF new.active = TRUE AND old.active = FALSE
      THEN
         UPDATE back_issue_list
            SET active = TRUE
          WHERE     subscription_detail_id = old.id
                AND sent_to_subscriber = FALSE;
         /*
         * add back issues, since there could be some journals that were sent
         * when the subscription was deactivated
         */
         CALL addBackIssues(old.id,
                               new.startMonth,
                               new.startYear,
                               new.journalGroupID,
                               new.copies);
      END IF;
      IF old.copies <> new.copies
      THEN
         SELECT count(*)
           INTO count_sent
           FROM back_issue_list
          WHERE     subscription_detail_id = old.id
                AND sent_to_subscriber = TRUE
                AND active = TRUE
          LIMIT 1;
         IF count_sent = 0
         THEN
            UPDATE back_issue_list
               SET copies = new.copies
             WHERE     subscription_detail_id = old.id
                   AND sent_to_subscriber = FALSE
                   AND active = TRUE;
         END IF;
         OPEN cur1;
        read_loop:
         LOOP
            FETCH cur1
              INTO back_issue_list_id,
                   _journal_id,
                   _month,
                   _year,
                   _copies,
                   _issue_number,
                   _volume_number,
                   is_sent_to_subscriber,
                   _active;
            IF done = 1
            THEN
               LEAVE read_loop;
            END IF;
            SET diff := new.copies - _copies;
            SELECT count(*)
              INTO count_not_sent
              FROM back_issue_list t1
             WHERE     t1.subscription_detail_id = old.id
                   AND t1.journal_id = _journal_id
                   AND t1.month = _month
                   AND t1.`year` = _year
                   AND t1.issue_number = _issue_number
                   AND t1.volume_number = _volume_number
                   AND sent_to_subscriber = 0
                   AND active = TRUE
             LIMIT 1;
            IF diff > 0
            THEN
               IF count_not_sent = 1
               THEN
                  UPDATE back_issue_list t1
                     SET t1.copies = diff
                   WHERE     t1.id <> back_issue_list_id
                         AND t1.journal_id = _journal_id
                         AND t1.month = _month
                         AND t1.`year` = _year
                         AND t1.issue_number = _issue_number
                         AND t1.volume_number = _volume_number
                         AND sent_to_subscriber = 0
                         AND active = TRUE;
               ELSE
                  INSERT INTO back_issue_list(subscription_detail_id,
                                              journal_id,
                                              `month`,
                                              `year`,
                                              issue_number,
                                              volume_number,
                                              copies,
                                              sent_to_subscriber,
                                              added_on,
                                              active)
                  VALUES (old.id,
                          _journal_id,
                          _month,
                          _year,
                          _issue_number,
                          volume_number,
                          diff,
                          FALSE,
                          CURRENT_DATE(),
                          TRUE);
               END IF;
            ELSE
               IF count_not_sent = 1
               THEN
                  UPDATE back_issue_list t1
                     SET t1.copies = new.copies
                   WHERE     t1.id <> back_issue_list_id
                         AND t1.journal_id = _journal_id
                         AND t1.month = _month
                         AND t1.`year` = _year
                         AND t1.issue_number = _issue_number
                         AND t1.volume_number = _volume_number
                         AND sent_to_subscriber = 0
                         AND active = TRUE;
               END IF;
            END IF;
         END LOOP;
         CLOSE cur1;
      END IF;
   END begin_level_1;
END;;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `jds`.`after_subscription_details_update` AFTER UPDATE ON subscriptiondetails FOR EACH ROW

BEGIN

  /*

  * set the active flag for subscription to false once all the details are

  * marked as false

  */

  DECLARE is_active int DEFAULT 0;

  SELECT count(*) INTO is_active FROM subscriptiondetails t1

  WHERE t1.active = TRUE AND t1.id=new.id;



  IF is_active = 0 THEN

    UPDATE subscription t1 SET t1.active=FALSE WHERE t1.id=new.subscriptionID;

  ELSE

    UPDATE subscription t1 SET t1.active=TRUE WHERE t1.id=new.subscriptionID;

  END IF;

  /* end of subscription deactivate */

END;;

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
  `year4` int(11) NOT NULL DEFAULT '0'
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
  `username` varchar(64) NOT NULL,
  `role` varchar(20) NOT NULL,
  PRIMARY KEY (`username`,`role`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES ('admin@ias.com','admin'),('jds@ias.com','user');
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `username` varchar(64) NOT NULL,
  `password` varchar(16) NOT NULL,
  `firstName` varchar(20) NOT NULL,
  `lastName` varchar(20) DEFAULT NULL,
  `isPasswordReset` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('admin@ias.com','admin','Admin','',0),('jds@ias.com','jds','JDS','',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `year`
--

LOCK TABLES `year` WRITE;
/*!40000 ALTER TABLE `year` DISABLE KEYS */;
INSERT INTO `year` VALUES (1,'2012'),(2,'2013'),(3,'2014'),(4,'2015'),(5,'2016'),(6,'2017'),(7,'2018'),(8,'2019'),(9,'2020'),(10,'2021'),(11,'2022'),(12,'2023'),(13,'2024'),(14,'2025'),(15,'2026'),(16,'2027'),(17,'2028'),(18,'2029'),(19,'2030'),(20,'2031'),(21,'2032'),(22,'2033'),(23,'2034'),(24,'2035'),(25,'2036'),(26,'2037'),(27,'2038'),(28,'2039'),(29,'2040'),(30,'2041'),(31,'2042'),(32,'2043'),(33,'2044'),(34,'2045'),(35,'2046'),(36,'2047'),(37,'2048'),(38,'2049'),(39,'2050');
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
CREATE PROCEDURE jds.`addBackIssues`(IN _subscription_detail_id   int,
                                     IN _new_startMonth           int,
                                     IN _new_startYear            int,
                                     IN _new_journalGroupID       int,
                                     IN _new_copies               int)
BEGIN
      DECLARE journal_id        int;
      DECLARE mailing_list_id   int;
      DECLARE _month            int;
      DECLARE _year             int;
      DECLARE issue_number      int;
      DECLARE volume_number     int;
      DECLARE dummy             int;
      DECLARE done              int DEFAULT 0;
      DECLARE rec_count         int DEFAULT 0;

      /*
      * Select all journals, issue number, volume that are in the mailing list
      * and not already sent to the subscriber. This can be verified by checking
      * the mailing list detail table. If an entry exists we should not add that
      * entry to the back issue
      */
      DECLARE
         cur1 CURSOR FOR SELECT t3.id,
                                t2.journalID,
                                t3.month,
                                t3.year,
                                t3.issue,
                                t3.volumenumber
                           FROM journal_group_contents t2, mailing_list t3
                          WHERE     t2.journalGroupID = _new_journalGroupID
                                AND t2.journalID = t3.journalid
                                AND t3.year = _new_startYear;

      DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

      OPEN cur1;

     read_loop:
      LOOP
         FETCH cur1
           INTO mailing_list_id,
                journal_id,
                _month,
                _year,
                issue_number,
                volume_number;

         IF done = 1
         THEN
            LEAVE read_loop;
         END IF;

         /* check if there are any records with the same mailing list id
         * we have to check record wise and cannot use a join because
         * the subscription details are not added to mailing list when the subscription
         * is inactive
         */
         SET rec_count = 0;

         SELECT count(*)
           INTO rec_count
           FROM mailing_list_detail t1
          WHERE     t1.mailinglistId = mailing_list_id
                AND t1.subscriptionDetailId = _subscription_detail_id;
                
          
          /*select mailing_list_id;
          select rec_count;
          */

         /*if the count is zero that means there is no previous entry
         * else we just exit the loop
         */
         IF rec_count > 0
         THEN
            LEAVE read_loop;
         END IF;


         INSERT IGNORE INTO back_issue_list(subscription_detail_id,
                                     journal_id,
                                     back_issue_list.month,
                                     back_issue_list.year,
                                     copies,
                                     issue_number,
                                     volume_number,
                                     added_on)
         VALUES (_subscription_detail_id,
                 journal_id,
                 _month,
                 _year,
                 _new_copies,
                 issue_number,
                 volume_number,
                 CURRENT_DATE());
      END LOOP;

      CLOSE cur1;
   END;;
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
CREATE PROCEDURE jds.`circulation_figures`(IN cir_year int)
   BEGIN
      DECLARE journal_id                 int;
      DECLARE journal_code               varchar(20);
      DECLARE journal_name               VARCHAR(128);
      DECLARE print_order_value               int DEFAULT 0;
      DECLARE inst_i                    int DEFAULT 0;
      DECLARE inst_f                    int DEFAULT 0;
      DECLARE ind_i                    int DEFAULT 0;
      DECLARE ind_f                    int DEFAULT 0;
      DECLARE auth                      int DEFAULT 0;
      DECLARE comp                      int DEFAULT 0;
      DECLARE total_copies               int DEFAULT 0;
      DECLARE balance_copies             int DEFAULT 0;
      DECLARE done int DEFAULT 0;
     DECLARE
        cur1 CURSOR FOR SELECT id, journalCode, journalName FROM journals;
      DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

      DELETE FROM circulation_figure;

      OPEN cur1;

     read_loop:
      LOOP
         FETCH cur1
           INTO journal_id, journal_code, journal_name;

         IF done = 1
         THEN
            LEAVE read_loop;
         END IF;

         SELECT printOrder
           INTO print_order_value
           FROM print_order
          WHERE `year` = cir_year AND journalId = journal_id;

         SELECT sum(mailing_list_detail.copies)
           INTO inst_i
           FROM    mailing_list_detail
                LEFT JOIN
                   subscriber_type
                ON mailing_list_detail.subtypecode =
                      subscriber_type.subtypecode
          WHERE     subscriber_type.nationality = 'I'
                AND subscriber_type.institutional = 'I'
                AND mailing_list_detail.`year` = cir_year
                AND subscriber_type.subtype = 'PAID'
                AND mailing_list_detail.journalId = journal_id
         GROUP BY mailing_list_detail.journalId,
                  mailing_list_detail.`year`,
                  subscriber_type.institutional,
                  subscriber_type.nationality;

         SELECT sum(mailing_list_detail.copies)
           INTO inst_f
           FROM    mailing_list_detail
                LEFT JOIN
                   subscriber_type
                ON mailing_list_detail.subtypecode =
                      subscriber_type.subtypecode
          WHERE     subscriber_type.nationality = 'F'
                AND subscriber_type.institutional = 'I'
                AND mailing_list_detail.`year` = cir_year
                AND subscriber_type.subtype = 'PAID'
                AND mailing_list_detail.journalId = journal_id
         GROUP BY mailing_list_detail.journalId,
                  mailing_list_detail.`year`,
                  subscriber_type.institutional,
                  subscriber_type.nationality;

         SELECT sum(mailing_list_detail.copies)
           INTO ind_i
           FROM    mailing_list_detail
                LEFT JOIN
                   subscriber_type
                ON mailing_list_detail.subtypecode =
                      subscriber_type.subtypecode
          WHERE     subscriber_type.nationality = 'I'
                AND subscriber_type.institutional = 'P'
                AND mailing_list_detail.`year` = cir_year
                AND subscriber_type.subtype = 'PAID'
                AND mailing_list_detail.journalId = journal_id
         GROUP BY mailing_list_detail.journalId,
                  mailing_list_detail.`year`,
                  subscriber_type.institutional,
                  subscriber_type.nationality;

         SELECT sum(mailing_list_detail.copies)
           INTO ind_f
           FROM    mailing_list_detail
                LEFT JOIN
                   subscriber_type
                ON mailing_list_detail.subtypecode =
                      subscriber_type.subtypecode
          WHERE     subscriber_type.nationality = 'F'
                AND subscriber_type.institutional = 'P'
                AND mailing_list_detail.`year` = cir_year
                AND subscriber_type.subtype = 'PAID'
                AND mailing_list_detail.journalId = journal_id
         GROUP BY mailing_list_detail.journalId,
                  mailing_list_detail.`year`,
                  subscriber_type.institutional,
                  subscriber_type.nationality;

         SELECT sum(mailing_list_detail.copies)
           INTO auth
           FROM    mailing_list_detail
                LEFT JOIN
                   subscriber_type
                ON mailing_list_detail.subtypecode =
                      subscriber_type.subtypecode
          WHERE     subscriber_type.subtypecode = 'AUTH'
                AND mailing_list_detail.`year` = cir_year
                AND mailing_list_detail.journalId = journal_id
         GROUP BY mailing_list_detail.journalId, mailing_list_detail.`year`;

         SELECT sum(mailing_list_detail.copies)
           INTO comp
           FROM    mailing_list_detail
                LEFT JOIN
                   subscriber_type
                ON mailing_list_detail.subtypecode =
                      subscriber_type.subtypecode
          WHERE     subscriber_type.subtype = 'FREE'
                AND mailing_list_detail.`year` = cir_year
                AND mailing_list_detail.journalId = journal_id
         GROUP BY mailing_list_detail.journalId, mailing_list_detail.`year`;

         SET total_copies = inst_i + inst_f + ind_i + ind_f + auth + comp;
         SET balance_copies = print_order_value - total_copies;

         INSERT INTO circulation_figure(journalCode,
                                        journalName,
                                        instIndia,
                                        instAbroad,
                                        indiIndia,
                                        indiAbroad,
                                        comp,
                                        auth,
                                        totalCopies,
                                        printOrder,
                                        balanceCopies)
         VALUES (journal_code,
                 journal_name,
                 inst_i,
                 inst_f,
                 ind_i,
                 ind_f,
                 comp,
                 auth,
                 total_copies,
                 print_order_value,
                 balance_copies);
      END LOOP;

      CLOSE cur1;
   END;;
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
CREATE PROCEDURE jds.`cir_subscription_rates`(IN cir_year        int,
                                              IN sub_type_desc   varchar(64))
   BEGIN
 DECLARE price_rate int DEFAULT 0;
 DECLARE rat_period int DEFAULT 0;
 DECLARE journal_gp_id int;
 DECLARE journal_gp_name varchar(128);
 DECLARE done int DEFAULT 0;
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

         SELECT subscription_rates.rate
           INTO price_rate
           FROM subscription_rates, subscriber_type
          WHERE     subscription_rates.`year` = cir_year
                AND subscription_rates.period = 1
                AND subscription_rates.journalGroupId = journal_gp_id
                AND subscription_rates.subtypeId = subscriber_type.id
                AND subscriber_type.subtypedesc = sub_type_desc;

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

         SELECT subscription_rates.rate
           INTO price_rate
           FROM subscription_rates, subscriber_type
          WHERE     subscription_rates.`year` = cir_year
                AND subscription_rates.period = 2
                AND subscription_rates.journalGroupId = journal_gp_id
                AND subscription_rates.subtypeId = subscriber_type.id
                AND subscriber_type.subtypedesc = sub_type_desc;

         UPDATE temp_sub_rate
            SET year2 = price_rate
          WHERE     journalGroupId = journal_gp_id
                AND journalGroupName = journal_gp_name
                AND subTypeDesc = sub_type_desc
                AND `year` = cir_year;

         SET price_rate = 0;

         SELECT subscription_rates.rate
           INTO price_rate
           FROM subscription_rates, subscriber_type
          WHERE     subscription_rates.`year` = cir_year
                AND subscription_rates.period = 3
                AND subscription_rates.journalGroupId = journal_gp_id
                AND subscription_rates.subtypeId = subscriber_type.id
                AND subscriber_type.subtypedesc = sub_type_desc;

         UPDATE temp_sub_rate
            SET year3 = price_rate
          WHERE     journalGroupId = journal_gp_id
                AND journalGroupName = journal_gp_name
                AND subTypeDesc = sub_type_desc
                AND `year` = cir_year;

         SET price_rate = 0;

         SELECT subscription_rates.rate
           INTO price_rate
           FROM subscription_rates, subscriber_type
          WHERE     subscription_rates.`year` = cir_year
                AND subscription_rates.period = 5
                AND subscription_rates.journalGroupId = journal_gp_id
                AND subscription_rates.subtypeId = subscriber_type.id
                AND subscriber_type.subtypedesc = sub_type_desc;

         UPDATE temp_sub_rate
            SET year4 = price_rate
          WHERE     journalGroupId = journal_gp_id
                AND journalGroupName = journal_gp_name
                AND subTypeDesc = sub_type_desc
                AND `year` = cir_year;

         SET price_rate = 0;
      END LOOP;

      CLOSE cur1;
   END;;
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_reminder_type1`(IN remtype   int)
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































   END ;;
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_reminder_type2`(IN remtype   int)
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































   END ;;
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_reminder_type3`(IN remtype   int)
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































   END ;;
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_back_issue`()
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































































































end ;;
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

-- Dump completed on 2013-02-27  7:40:16
