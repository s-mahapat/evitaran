-- MySQL dump 10.13  Distrib 5.5.28, for Win64 (x86)
--
-- Host: localhost    Database: jds
-- ------------------------------------------------------
-- Server version	5.5.28

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agents`
--

LOCK TABLES `agents` WRITE;
/*!40000 ALTER TABLE `agents` DISABLE KEYS */;
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
  `volume_number` int(11) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=3160 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` VALUES (3151,'1000 CE Amsterdam'),(3143,'199034 St. Petersburg'),(311,'24 Parganas North'),(312,'24 Parganas South'),(3135,'2784-505 Oeiras'),(3145,'70910-900  Brasilia D.F.'),(2981,'Aadepalligudem'),(3005,'Aannd'),(2761,'Abmala'),(1067,'Abohar'),(1592,'Achanputhur'),(969,'Adambakkam'),(388,'Addanki'),(986,'Adilabad'),(1419,'Adimali'),(2590,'Adinathnagar'),(1444,'Adipur'),(2053,'Adirampattinam'),(1614,'Adoni'),(1258,'Adoor'),(796,'Adra'),(2304,'Aduthurai'),(687,'Agartala'),(2545,'Agasteeswaram'),(1,'Agra'),(1875,'Agra Cantt'),(2450,'Ahmadnagar'),(2,'Ahmedabad'),(3124,'Ahmedanad'),(3,'Ahmednagar'),(413,'Aiazawl'),(4,'Aizawl'),(1035,'Aizwal'),(428,'Ajara'),(2414,'Ajitmal'),(5,'Ajmer'),(1999,'Akalkot'),(2671,'Akhada Balapur'),(2892,'Akhnoor'),(3058,'Akluj'),(6,'Akola'),(1653,'Akot'),(2262,'Ala'),(2096,'Alagappanagar'),(2216,'Aland'),(2996,'Alappusha'),(8,'Alappuzha'),(1160,'Alapuzha'),(2294,'Alathur'),(2917,'Ale'),(1573,'Aleppey'),(3138,'Alexandria'),(281,'Alibag'),(7,'Aligarh'),(282,'Aligrah'),(9,'Allahabad'),(2754,'Allahabas'),(1576,'Allahabd'),(10,'Almora'),(3048,'Almorea'),(2565,'Along'),(1978,'Alore'),(847,'Aluva'),(11,'Alwar'),(1692,'Alwarkurichi'),(462,'Alwarkuruchi'),(2644,'Alwasa'),(903,'Alwaye'),(677,'Amalapuram'),(726,'Amalner'),(1967,'Amaravati'),(1545,'Amarvati'),(2039,'Ambad'),(2431,'Ambah'),(1897,'Ambajogai'),(283,'Ambala'),(3076,'Ambala Cant'),(795,'Ambala Cantt'),(2795,'Ambala Cantt.'),(828,'Ambala City'),(1131,'Ambalamugal'),(2041,'Ambalavayal'),(12,'Ambattur'),(2225,'Ambav'),(13,'Ambernath'),(608,'Amberpet'),(284,'Ambikapur'),(2188,'Ambilikka'),(2083,'Ambur'),(2654,'Amdedabad'),(2123,'Amethi'),(2722,'Amgaon'),(2589,'Amla'),(2634,'Amlagora'),(2077,'Ammandivillai'),(1772,'Amraavati'),(14,'Amravati'),(416,'Amreli'),(15,'Amritsar'),(3074,'Amroha'),(1980,'Amta'),(2311,'Anad'),(382,'Anakapalle'),(581,'Anakapalli'),(2189,'Anakkayam'),(935,'Ananatapur'),(285,'Anand'),(1886,'Anandapur'),(2302,'Anandpur Sahib'),(2585,'Anandwan'),(16,'Anantapur'),(1522,'Ananthapur'),(2885,'Ananthpur'),(286,'Anantnag'),(3002,'Anaparthi'),(597,'Anchal'),(2788,'Andal'),(3042,'Andaman'),(1183,'Anekal'),(1246,'Angadikadavu'),(772,'Angamally'),(2410,'Angamaly'),(333,'Angul'),(356,'Anguli'),(2588,'Ankaleshwar'),(870,'Ankleshwar'),(2271,'Ankola'),(631,'Annamalai'),(334,'Annamalai Nagar'),(314,'Annamalainagar'),(1460,'Annur'),(2078,'Anoopshahr'),(2689,'Anumala'),(2797,'Anupgarh'),(757,'Anupuram'),(1541,'Anvardhikanpet'),(2807,'Aonla'),(704,'Ara'),(2269,'Arabhavi'),(2247,'Arachalur'),(780,'Arakkonam'),(1674,'Arakkulam'),(949,'Arakkunnam'),(2308,'Arakulam'),(17,'Araleri'),(2939,'Aralvaymoli'),(2745,'Aralvoimozhi'),(18,'Arambagh'),(639,'Araria'),(2748,'Arasampatti'),(2423,'Arasikere'),(2173,'Arasur'),(1595,'Aravayal'),(968,'Areacode'),(1133,'Arimpur'),(1571,'Ariyalur'),(701,'Ariyannur'),(2603,'Armoor'),(2146,'Armori'),(2094,'Arni'),(19,'Arrah'),(404,'Arsikere'),(1701,'Arumanai'),(1337,'Arunapuram'),(817,'Aruppukottai'),(2232,'Aruvankadu'),(655,'Aryapur'),(20,'Asansol'),(888,'Ashoknagar'),(562,'Astabad Itarsi'),(1931,'Aswaraopet'),(1470,'AT & P.O.Barh'),(1192,'Atarra'),(2965,'Athani'),(1842,'Athens'),(456,'Athgarh'),(2728,'Atkot'),(442,'Atpadi'),(2897,'Attabira'),(675,'Attingal'),(766,'Attoor'),(533,'Attur'),(683,'Atul'),(1982,'Aundipatti'),(979,'Auraiya'),(21,'Aurangabad'),(1430,'Auroville'),(22,'Avadi'),(2651,'Avidi'),(1882,'Avikanagar'),(2013,'Avinashi'),(2446,'Awantipora'),(1454,'Ayodhya'),(2031,'Ayur'),(1211,'Ayyanthole'),(996,'Azamgarh'),(2439,'Aziznagar'),(2647,'B.G. Nagar'),(1418,'Badagara'),(2435,'Badami'),(3072,'Badchiroli'),(2213,'Baddi'),(287,'Badlapur'),(2826,'Badmal'),(1542,'Badnera'),(3052,'Badodara'),(441,'Badshahithaul'),(1375,'Badvel'),(621,'Bagalkot'),(1204,'Bagar'),(1094,'Bagdogra'),(804,'Bagepalli'),(1682,'Bagepally'),(3148,'Baghdad'),(1790,'Baghpat'),(1656,'Baghra'),(714,'Bagudi'),(2601,'Bahadurgarh'),(2403,'Bahal'),(2620,'Bahona'),(794,'Bahraich'),(358,'BaihataChariali'),(1195,'Baijnath'),(882,'Bailhongal'),(2027,'Bakewar'),(2918,'Bakhtiarpur'),(2097,'Bakrol'),(2508,'Baladmari'),(288,'Balaghat'),(924,'Balangir'),(623,'Balasore'),(1230,'Balikuda'),(1219,'Balisahi'),(2518,'Ballabgarh'),(2064,'Ballarpur'),(1876,'Ballary'),(484,'Ballia'),(23,'Bally'),(2409,'Balod'),(342,'Balrampur'),(392,'Balurghat'),(1256,'Baluti'),(2703,'Bamkhed'),(1713,'Banaskantha'),(1434,'Banasthali'),(2740,'Banaswada'),(753,'Banda'),(1436,'Bandipora'),(1725,'Banga'),(1040,'Bangaaore'),(24,'Bangarpet'),(2069,'Banikhet'),(1416,'Banipur'),(504,'Bankalagi'),(2349,'Banki'),(1626,'Bankpara'),(341,'Bankura'),(1110,'Banswara'),(2775,'Bantalab'),(1128,'Bantiwal'),(890,'Bantwal'),(1340,'Bapatla'),(1802,'Barabanki'),(579,'Baramati'),(1273,'Baramulla'),(25,'Baranagar'),(3120,'Barapani'),(476,'Barasat'),(2827,'Barauni'),(676,'Baraut'),(2371,'Bardez'),(26,'Bardhaman'),(558,'Bardoli'),(27,'Bareilly'),(304,'Bareli'),(2425,'Barelly'),(1735,'Bargarh'),(2752,'Bargur'),(1529,'Barharwa'),(2572,'Baridh Colony'),(28,'Baripada'),(1262,'Barmer'),(805,'Barnala'),(399,'Barpeta'),(669,'Barrackpore'),(3117,'Barrackpore P.O.'),(653,'Barshi'),(2397,'Baru Sahib'),(3035,'Basanti'),(1783,'Basirhat'),(1450,'Basmath'),(1458,'Bastar'),(1096,'Basti'),(1655,'Basudevpur'),(1535,'Batala'),(29,'Bathinda'),(1464,'Baxi Bazar'),(1370,'Bazpur'),(2995,'Beawar'),(1153,'Beed'),(2538,'Beekar'),(2149,'Beerapalli'),(862,'Begusarai'),(2704,'Bela'),(1852,'Belagavi'),(2128,'Belati'),(3098,'Belavavi'),(3020,'Belda'),(30,'Belgaum'),(31,'Bellary'),(1742,'Belthangadi'),(1548,'Belthangady'),(3032,'Belur Math'),(1836,'Bemetara'),(32,'Bengaluru'),(2731,'Benjanapadavu'),(954,'Berhampore'),(33,'Berhampur'),(3142,'Bethesda, MD 20814'),(1367,'Bethuadahari'),(455,'Bettiah'),(1139,'Betul'),(368,'Bhabua'),(1156,'Bhadohi'),(2416,'Bhadrachalam'),(680,'Bhadrak'),(1306,'Bhadravathi'),(1397,'Bhadravati'),(2574,'Bhadsen'),(34,'Bhagalpur'),(3079,'Bhagur'),(1926,'Bhaila'),(2102,'Bhalki'),(590,'Bhandara'),(1645,'Bhanur'),(1401,'Bharathi Nagara'),(1586,'Bharathinagara'),(2231,'Bharathpur'),(35,'Bharatpur'),(2835,'Bharkatia'),(483,'Bharuch'),(1241,'Bhatapara'),(2828,'Bhathinda Cantt'),(1623,'Bhatkal'),(2297,'Bhatoli'),(36,'Bhatpara'),(1073,'Bhavanisagar'),(37,'Bhavnagar'),(814,'Bhawanipatna'),(2966,'Bhilad'),(38,'Bhilai'),(2165,'Bhilainagar'),(1588,'Bhillai'),(39,'Bhilwara'),(1100,'Bhimavaram'),(1960,'Bhimtal'),(2467,'Bhind'),(40,'Bhiwandi'),(848,'Bhiwani'),(2862,'Bhiwari'),(289,'Bhojpur'),(1092,'Bhongaon'),(1930,'Bhongir'),(2050,'Bhoom'),(41,'Bhopal'),(2283,'Bhor'),(3068,'Bhtakumarada'),(42,'Bhubaneswar'),(43,'Bhuj'),(2970,'Bhuj-Kachchh'),(2968,'Bhuj-Kutch'),(1564,'Bhunbaneswar'),(845,'Bhusawal'),(2259,'Bhutta'),(3025,'Bicholim'),(1937,'Bidadi'),(44,'Bidar'),(45,'Bidhan Nagar'),(502,'Bidri'),(46,'Bihar Sharif'),(47,'Bijapur'),(720,'Bijhari'),(777,'Bijnor'),(2829,'Bijpur'),(48,'Bikaner'),(3090,'Bilagi'),(2657,'Bilahongala'),(667,'Bilai'),(49,'Bilaspur'),(1699,'Bilimora'),(290,'Bina'),(2824,'Binnaguri'),(542,'Birbhum'),(1248,'Bishnupur'),(2180,'Bobbili'),(2587,'Bodinayakanur'),(990,'Boisar'),(50,'Bokaro'),(437,'Bokaro Thermal'),(801,'Bolangir'),(3104,'Bolangr'),(915,'Bolpur'),(2138,'Bomdila'),(2493,'Bonaigarh'),(709,'Bongaigaon'),(1675,'Borai'),(1152,'Bordez'),(2359,'Bordi'),(2167,'Boriavi'),(2983,'Boudh'),(881,'Boudh  Dist.'),(52,'Brahmapur'),(1928,'Brahmapuri'),(2636,'Brahmavar'),(2461,'Bssti'),(2661,'Bud Bud'),(820,'Budaun'),(357,'Buddhnagar'),(2705,'Budgam'),(1986,'Budhagaya'),(1705,'Bulandshahar'),(1366,'Bulandshahr'),(457,'Buldana'),(3064,'Buldhana'),(51,'Burdwan'),(1611,'Burhanpur'),(1698,'Burhar'),(741,'Burla'),(738,'Burnpur'),(2847,'Bylakuppe'),(3100,'Cachar'),(505,'Calcutta'),(3129,'California 94720'),(3137,'Cambridge CB2 3PY'),(921,'Canacona'),(421,'Canchipur'),(360,'Cannanore'),(1996,'Canning Town'),(2495,'Chaibasa'),(981,'Chaimpal'),(550,'Chaklashi'),(3061,'Chakradharpur'),(2263,'Chalakudy'),(691,'Chalala'),(1025,'Chalisgaon'),(1703,'Challakere'),(854,'Chamarajanagar'),(3075,'Chamarajanagara'),(2815,'Chamba'),(2313,'Chamoli'),(2717,'Champa'),(2277,'Champadanga'),(2708,'Champakulam'),(1707,'Champaran'),(3087,'Champawat'),(2909,'Champua'),(1486,'Chamurchi'),(2539,'Chanasma'),(673,'Chandannagar'),(763,'Chandausi'),(2458,'Chandel'),(2739,'Chandeshwar'),(53,'Chandigarh'),(1507,'Chandimandir'),(1649,'Chandpur'),(54,'Chandrapur'),(2531,'Chandrapura'),(1975,'Chandwad'),(2878,'Changa'),(830,'Changanacherry'),(1108,'Changanachery'),(383,'Changancherry'),(1012,'Changigarh'),(1288,'Channagiri'),(2895,'Channai'),(832,'Channapatna'),(365,'Channarayapatna'),(568,'Chapra'),(2791,'Charbatia'),(561,'Chariali'),(1915,'Charkhi Dadri'),(2553,'Charmapuri'),(2680,'Chavakkad'),(2391,'Chavara'),(2318,'Chemperi'),(2741,'Chemudugunta'),(439,'Chenbalam'),(2310,'Chengalpattu'),(424,'Chengalpet'),(1515,'Chengam'),(422,'Chengannur'),(327,'Chenglepet'),(2838,'Chengottoor'),(55,'Chennai'),(2535,'Chennaraopet'),(1720,'Chennimalai'),(2716,'Chernmahadevi'),(401,'Cherpu'),(1074,'Cherthala'),(1857,'Cheruthuruthy'),(1860,'Chettalli'),(2376,'Chettinad'),(2653,'Chevalla'),(1293,'Chevayur'),(1909,'Chevella'),(871,'Cheyyar'),(952,'Chhatarpur'),(291,'Chhindwara'),(2333,'Chhota Udepur'),(2782,'Chianki'),(1428,'Chicalim'),(1688,'Chickballapur'),(2632,'Chickkaballapur'),(3053,'Chickmagalore'),(807,'Chickmagalur'),(2941,'Chickmangore'),(56,'Chidambaram'),(2735,'Chikani'),(1497,'Chikballapur'),(2163,'Chikhaldara'),(3017,'Chikhali'),(1850,'Chikhli'),(1038,'Chikkaballapur'),(3097,'Chikkamagalur'),(2556,'Chikkanahalli'),(2560,'Chikmagalooru'),(292,'Chikmagalur'),(1004,'Chikodi'),(1966,'Chilakaluripet'),(2803,'Chilka'),(2953,'Chimakurthy'),(1894,'China Amiram'),(2407,'Chincholi'),(2206,'Chinna Salem'),(1758,'Chinnasalem'),(2598,'Chinoutapally'),(664,'Chinsurah'),(1147,'Chintamani'),(293,'Chiplun'),(792,'Chirala'),(2998,'Chirang'),(1968,'Chirawa'),(1800,'Chirmiri'),(2524,'Chitorgarh'),(2612,'Chitradurg'),(343,'Chitradurga'),(1412,'Chitrakoot'),(2718,'Chittivalasa'),(528,'Chittode'),(57,'Chittoor'),(643,'Chittor'),(1624,'Chittorgarh'),(2685,'Chiyyedu'),(2693,'Choondacherry'),(2813,'Chopan'),(787,'Chorvad'),(2161,'Chowdavaram'),(2230,'Chumukedima'),(397,'Chundambatta'),(2081,'Chunkankadai'),(2513,'Churachandpur'),(1125,'Churu'),(1777,'Coch in'),(412,'Cochin'),(58,'Coimbatore'),(2604,'Coimbatyore'),(2543,'Colaghat'),(3131,'Colombo  7'),(3154,'Columbus Ohio'),(1524,'Combum'),(563,'Contai'),(799,'Cooch Behar'),(2655,'Coochbehar'),(577,'Coonoor'),(1069,'Courtallam'),(3159,'CT'),(588,'Cuddalore'),(1472,'Cuddapah'),(361,'Cumbum'),(3026,'Curchorem'),(59,'Cuttack'),(1779,'Cuttak'),(1851,'Dabhoi'),(2938,'Dahivel'),(2427,'Dahiwadi'),(1448,'Dahod'),(1585,'Daksin Dinajpur'),(2473,'Daldali'),(1060,'Dalhousie'),(3066,'Dallhousie'),(2550,'Dalli Rajhara'),(1722,'Dalmianagar'),(1440,'Daltonganj'),(702,'Daman'),(1746,'Daman and Diu'),(1865,'Damanjodi'),(1225,'Damoh'),(1612,'Dandeli'),(1605,'Dantewada'),(1049,'Dantiwada'),(1089,'Dapoli'),(60,'Darbhanga'),(432,'Darjeeling'),(1392,'Darrang'),(1091,'Darwha'),(2016,'Dasuya'),(866,'Datia'),(1240,'Dausa'),(61,'Davanagere'),(3078,'Davanagrer'),(62,'Davangere'),(3022,'Debari'),(1492,'Debinagar'),(1305,'Deepshikha'),(1234,'Deepsikha'),(2288,'Degloor'),(3047,'Deharadun'),(3084,'Dehardun'),(2837,'Dehra'),(63,'Dehradun'),(611,'Dehrudun'),(313,'Delhi'),(3114,'Delhi Cantt'),(2715,'Delhi Cantt.'),(2568,'Deogarh'),(1155,'Deoghar'),(2412,'Deola'),(3001,'Deolali Camp'),(64,'Deoli'),(2293,'Deori'),(721,'Deoria'),(818,'Deralakatta'),(545,'Deralakatte'),(2104,'Dev Sangha'),(363,'Devakottai'),(2286,'Devanahalli'),(2150,'Devarakonda'),(2374,'Devgad'),(793,'Devlali'),(2073,'Devrukh'),(65,'Dewas'),(1427,'Dhakuakhana'),(1090,'Dhalavalpuram'),(1398,'Dhamangaon'),(1149,'Dhamisa'),(3019,'Dhamtar'),(1034,'Dhamtari'),(66,'Dhanbad'),(760,'Dhar'),(1846,'Dharampura'),(2925,'Dharampuram'),(836,'Dharamsala'),(2610,'Dharapuram'),(1631,'Dharbhanga'),(1449,'Dharmabad'),(332,'Dharmanagar'),(329,'Dharmapuri'),(1686,'Dharmasthala'),(1290,'Dharmavaram'),(756,'Dharmsala'),(67,'Dharwad'),(744,'Dharwar'),(1956,'Dhaulakuan'),(727,'Dhemaji'),(944,'Dhenkanal'),(1920,'Dhilwan'),(2221,'Dhing'),(499,'Dholka'),(1143,'Dholpur'),(1704,'Dhrol'),(2455,'Dhubri'),(68,'Dhule'),(2430,'Dhulipalla'),(2440,'Dhupguri'),(3099,'Dhuri (Sangrur)'),(2223,'Diamond Harbour'),(1077,'Dibiyapur'),(364,'Dibrugarh'),(3021,'Didhihat'),(553,'Didwana'),(1172,'Digapahandi'),(2631,'Digvijaygram'),(1007,'Dikrong'),(916,'Dimapur'),(2137,'Dimpapur'),(1157,'Dinajpur'),(2768,'Dinanagar'),(522,'Dindigal'),(513,'Dindigul'),(470,'Dindlod'),(2839,'Dindori'),(1597,'Dingigul'),(1795,'Diphu'),(2134,'Dirang'),(69,'Doddaballapur'),(2865,'Doddaballapura'),(565,'Doimukh'),(1102,'Dombivali'),(70,'Dombivili'),(739,'Dombiville East'),(768,'Dombivli'),(2320,'Dombivli (E)'),(1764,'Dombivli (W)'),(1124,'Dombivli East'),(71,'Dona Paula'),(2481,'Dongargarh'),(2801,'Donimalai'),(2750,'Doraha'),(3092,'Dousa'),(781,'Dudhondi'),(1119,'Dudhya'),(1388,'Dujana'),(1455,'Duliajan'),(2254,'Dumehar Bani'),(1080,'Dumka'),(2390,'Dumkal'),(1570,'Dumraon'),(2192,'Dundlod'),(1509,'Dungarpur'),(72,'Durg'),(73,'Durgapur'),(1579,'Durgpur'),(2129,'Dwarahat'),(1781,'Dwarka'),(2973,'E.G.Dist'),(892,'E.Godavari'),(605,'Eachome'),(1439,'Eambalam'),(1127,'East Godavari'),(1590,'East Siang'),(2488,'East Sikkim'),(2763,'East-Sikkim'),(1831,'Eastgodavari'),(1020,'Edat'),(74,'Edathala'),(2298,'Edathua'),(1896,'EG Dist'),(999,'Egra'),(2764,'Elagiri Hills'),(998,'Elamdesom'),(1201,'Elavunthitta'),(2051,'Elayampalayam'),(2255,'Elthuruth'),(1739,'Eluro'),(1297,'Eluru'),(2234,'Enathi'),(1442,'Erairimangalam'),(2063,'Erandol'),(906,'Erintalmanna'),(2492,'Ernakula'),(75,'Ernakulam'),(324,'Erode'),(516,'Eroor North'),(1244,'Errattupetta'),(2052,'Erumapatty'),(1431,'Erumeli'),(2920,'Esanthimangalam'),(1347,'Etah'),(76,'Etawah'),(386,'Ettumanoor'),(1349,'Ettuvaicode'),(339,'Faizabad'),(1994,'Faizpur'),(1911,'Farah'),(1549,'Faribabad'),(77,'Faridabad'),(1873,'Faridkot'),(1087,'Faridpur'),(78,'Farrukhabad'),(3018,'Fatehabad'),(1658,'Fatehgarh'),(2667,'Fatehgarh Sahib'),(1485,'Fatehpur'),(2762,'Ferozapur'),(495,'Ferozepur'),(2954,'Ferozpur'),(3128,'Firenze  50131'),(79,'Firozabad'),(2120,'FPO'),(2444,'G.B. Palayam'),(1135,'Gachbowli'),(752,'Gadag'),(1643,'Gadag Betageri'),(808,'Gadag Betgeri'),(3123,'Gadanki'),(2118,'Gadarwara'),(943,'Gadchiroli'),(2445,'Gadhinglaj'),(2190,'Gadohiroli'),(2660,'Gagra'),(2889,'Gagrigol'),(1736,'Gajapati'),(2724,'Ganapathipuram'),(1679,'Ganapavaram'),(1196,'Gandhigram'),(80,'Gandhinagar'),(1377,'Gandhinagarn'),(1279,'Gandhinglj'),(2079,'Ganeshguri'),(2055,'Gangakhed'),(3023,'Gangapur'),(2652,'Gangarampalayam'),(1117,'Gangtok'),(3000,'Ganguru'),(2500,'Ganj Basoda'),(1583,'Ganjam'),(860,'Ganjam Dist.'),(2575,'Ganjar'),(1776,'Gannavaram'),(1691,'Ganpat Ganj'),(3121,'Gantok'),(2924,'Garchiroli'),(2003,'Garhdiwala'),(2836,'Garhi'),(811,'Garhwal'),(2306,'Garsa'),(481,'Gauhati'),(759,'Gauribidanur'),(560,'Gawahati'),(81,'Gaya'),(1221,'Gaziabad'),(2312,'Gevrai'),(3103,'Gharuan'),(1000,'Ghatanji'),(2046,'Ghatkesar'),(82,'Ghaziabad'),(429,'Ghazipur'),(1943,'Ghedradi'),(1981,'Ghogaon'),(1554,'Gidderbaha'),(637,'Giridih'),(410,'Goa'),(1386,'Goalpara'),(1459,'Gobi'),(3112,'Gobindgarh'),(1862,'Godavarikhani'),(2285,'Godda'),(984,'Godhra'),(3093,'Gohana'),(2489,'Gohang'),(697,'Gohpur'),(2290,'Gokak'),(1324,'Gokarn'),(1600,'Gola Kheri'),(2825,'Golabandha'),(479,'Golaghat'),(1083,'Golghat'),(2583,'Gollalamamidada'),(784,'Gonda'),(1058,'Gondia'),(2449,'Goniana Mandi'),(2402,'Gonikoppal'),(2723,'Gooty'),(1654,'Gopalbazar'),(83,'Gopalpur'),(1965,'Gopalpur-on-Sea'),(840,'Gopalpuri'),(2706,'Gopeshwar'),(84,'Gorakhpur'),(2466,'Goregaon'),(468,'Gossaigaon'),(2866,'Gowribidanur'),(929,'Greater Noida'),(85,'Gubbi'),(3037,'Gudalur'),(1770,'Gudavalli'),(2868,'Gudibande'),(798,'Gudivada'),(1910,'Gudiyattam'),(2484,'Gudlavalleru'),(775,'Gudur'),(2988,'Gujapati'),(2066,'Gulabpura'),(2600,'Gulaothi'),(86,'Gulbarga'),(2116,'Guledagudda'),(2347,'Gulmarg'),(606,'Gummidi Poondi'),(555,'Guna'),(2502,'Gunjoti'),(1031,'Guntakal'),(87,'Guntur'),(1453,'Gunupur'),(646,'Guragon'),(1284,'Gurdaspur'),(88,'Gurgaon'),(2732,'Gurusar Sadar'),(2325,'Gurusar Sadhar'),(1339,'Guruvayur'),(1312,'Gusiahati'),(2769,'Guskara'),(89,'Guwahati'),(1819,'Guwajati'),(90,'Gwalior'),(1269,'Gyanpur'),(347,'H.S.Chandrapur'),(3065,'Habra'),(2639,'Hadgarh'),(2282,'Haflong'),(1410,'Hailakandi'),(857,'Hajipur'),(2649,'Haldi'),(1301,'Haldia'),(1804,'Haldwani'),(2759,'Haliyala'),(902,'Halkanangale'),(1993,'Halkarni'),(2209,'Halol'),(2806,'Halwara'),(2139,'Hamiprur'),(645,'Hamirpur'),(746,'Hanamkonda'),(1825,'Hansi'),(917,'Hanumanakonda'),(1317,'Hanumangarh'),(91,'Hapur'),(764,'Harapanahalli'),(1756,'Harbin'),(1815,'Harda'),(689,'Hardoi'),(788,'Hardwar'),(449,'Haridwar'),(1259,'Harihar'),(2169,'Harilakandi'),(1498,'Harinavi'),(1218,'Haripal'),(2810,'Harni Road'),(3132,'Harpenden Herts  A15 2JQ'),(3108,'Harur'),(600,'Haryana'),(1534,'Hasimara'),(92,'Hassan'),(1045,'Hathras'),(1629,'Hatiara'),(834,'Hatundi'),(2915,'Haveli'),(2552,'Haveli Ghanapur'),(1011,'Haveri'),(1471,'Hawal'),(2787,'Hayuliang'),(1622,'Hazarbag'),(377,'Hazaribag'),(523,'Hazratbal'),(3116,'Hebbagodi'),(3126,'Herts. SG1 2AY'),(1832,'Herwatta Kumta'),(1526,'Himantnagar'),(1247,'Himatnagar'),(2819,'Himmatnagar'),(1618,'Hindaun'),(419,'Hindupur'),(1479,'Hingoli'),(426,'Hiriadka'),(1767,'Hiriyur'),(3008,'Hiryur'),(93,'Hisar'),(751,'Hissar'),(1374,'Holanagadde'),(624,'Honnavar'),(349,'Hooghly'),(3034,'Hoogly'),(609,'Hosadurga'),(94,'Hosapete'),(512,'Hoshangabad'),(488,'Hoshiarpur'),(2872,'Hoskote'),(374,'Hospet'),(500,'Hosur'),(95,'Howrah'),(315,'Hridaypur'),(2214,'Hubballi'),(96,'Hubballi-Dharwad'),(487,'Hubli'),(1788,'Huderabad'),(2246,'Hulakoti'),(2700,'Humnabad'),(2617,'Hunagunda'),(2453,'Hungund'),(1859,'Hunsur'),(1405,'Hurda'),(1473,'Hutti P.O.'),(2783,'Huvinahadagali'),(2554,'Huzurabad'),(2888,'Hyderaabad'),(1950,'Hyderaad'),(97,'Hyderabad'),(1780,'Hyderanad'),(1775,'Hyderbad'),(1362,'Hyderqabad'),(1771,'Hydrabad'),(2258,'Ibrahimpatnam'),(98,'Ichalkaranji'),(628,'Ichlampady'),(2025,'Iduki'),(708,'Idukki'),(2341,'Ilakal'),(773,'Ilayangudi'),(648,'Ilhas'),(1563,'Ilhas Tiswani'),(1168,'Ilkal'),(99,'Imphal'),(506,'Imphal East'),(2479,'Indapur'),(2023,'Indirapuram'),(101,'Indore'),(2798,'Indunagar'),(1217,'Inodre'),(3158,'Iowa'),(734,'Irimpanam'),(589,'Irinjalakuda'),(2483,'Israna'),(576,'Isukkazhi'),(2212,'Itachuna'),(100,'Itanagar'),(2852,'Itarsi'),(1936,'Iyyengarkulam'),(2800,'Izat Nagar'),(543,'Izatnagar'),(102,'Jabalpur'),(1251,'Jadar'),(865,'Jadavpur'),(1518,'Jagadalpur'),(2474,'Jagadhri'),(2356,'Jagatballavpur'),(1557,'Jagatsinghpur'),(973,'Jagdalpur'),(2675,'Jagdishpur'),(2521,'Jagiroad'),(1871,'Jagraon'),(1165,'Jagtial'),(3029,'Jahanabad'),(2429,'Jaipru'),(103,'Jaipur'),(2687,'Jaipur Cantt'),(1774,'Jaisalmer'),(1316,'Jaitaran'),(1123,'Jajpur'),(2089,'Jakkasandra'),(104,'Jalandhar'),(2329,'Jalandhar Cantt'),(1769,'Jalaun'),(3046,'Jalesar'),(105,'Jalgaon'),(2985,'Jalgoan'),(106,'Jalna'),(652,'Jalpaiguri'),(937,'Jamalpur'),(2884,'Jamer'),(3009,'Jamkhani'),(2155,'Jamkhed'),(2135,'Jammikunta'),(107,'Jammu'),(1752,'Jammu & Kashmir'),(2833,'Jammu Cantt.'),(452,'Jammu Tawi'),(108,'Jamnagar'),(2193,'Jamner'),(1336,'Jamnipali'),(1243,'Jamnipalli'),(109,'Jamshedpur'),(762,'Jangaon'),(1899,'Janjgir'),(1898,'Janjgir-Champa'),(1137,'Jannur'),(1198,'Jaora'),(761,'Jarangdih Col'),(1323,'Jatharpeth'),(402,'Jaugaon'),(1809,'Jaumpur'),(520,'Jaunpur'),(732,'Jayant'),(1466,'Jayasingpur'),(2616,'Jaypore'),(2758,'Jaysingpur'),(636,'Jehanabad'),(1755,'Jerusalem'),(1265,'Jeypore'),(3054,'Jhabua'),(1010,'Jhajhar'),(1627,'Jhajjar'),(1550,'Jhalawar'),(1178,'Jhalgaon'),(110,'Jhansi'),(2487,'Jharia'),(1437,'Jharipani'),(420,'Jharkhand'),(1426,'Jharsugna'),(1009,'Jharsuguda'),(1659,'Jhinihak'),(2375,'Jhinkpani'),(309,'Jhunjhunu'),(1281,'Jind'),(2131,'Jintur'),(1322,'Jitpur'),(728,'Jobner'),(111,'Jodhpur'),(498,'Jogbani'),(1567,'Jogfalls'),(2780,'Jogindar Nagar'),(1238,'Jognbani'),(547,'Jorhat'),(2812,'Joshimath'),(1360,'Jowai'),(2501,'Joysagar'),(1924,'JP Nagar'),(663,'Junagadh'),(2364,'Junnar'),(593,'Jyotivihar'),(2579,'K Bandarapalli'),(2406,'K R Nagar'),(869,'K.G.F'),(838,'K.G.F.'),(2075,'K.M. Doddi'),(2498,'K.R. Nagar'),(2142,'K.R. Pet'),(1914,'Kada'),(2217,'Kadakkal'),(2382,'Kadakom'),(573,'Kadalundi'),(1267,'Kadamtala'),(112,'Kadapa'),(1744,'Kadara'),(1028,'Kadayanallur'),(2599,'Kadegaon'),(1320,'Kadiri'),(387,'Kadirur'),(1185,'Kadur'),(2546,'Kagithapuram'),(2029,'Kagwad'),(2305,'Kahalgaon'),(1885,'Kahn Pur Khui'),(715,'Kailashahar'),(2389,'Kaipattoor'),(661,'Kaithal'),(2881,'Kakanpur'),(2882,'Kakching'),(113,'Kakinada'),(2682,'Kakkad'),(128,'Kalady'),(2962,'Kalagampudi'),(946,'Kalahandi'),(2822,'Kalaikunda'),(1001,'Kalamassery'),(493,'Kalamb'),(1456,'Kalanour P.O'),(1086,'Kalapet'),(362,'Kalavai'),(2873,'Kalavakkam'),(2907,'Kalayarkoil'),(1903,'Kalburgi'),(919,'Kaliakavilai'),(2352,'Kalianpur'),(2070,'Kalimpong'),(2751,'Kalipatti'),(1957,'Kalippatti'),(2691,'Kaliyaganj'),(480,'Kaliyakavillai'),(2945,'Kalka'),(1510,'Kallachi'),(722,'Kalladka'),(1695,'Kallakurchi'),(2656,'Kallakurichi'),(2887,'Kallanthode'),(1403,'Kalliassery PO'),(1935,'Kallikkandy'),(1958,'Kallooppara'),(965,'Kallur'),(1662,'Kalmijore'),(2927,'Kalol'),(2972,'Kalol (NG)'),(114,'Kalpakkam'),(1791,'Kalpet'),(2679,'Kalpetta'),(835,'Kalugumalai'),(1491,'Kalui'),(1289,'Kalwa'),(2411,'Kalwan'),(649,'Kalyan'),(1766,'Kalyan (E)'),(1632,'Kalyan (W)'),(1064,'Kalyan (West)'),(1763,'Kalyan East'),(1556,'Kalyan Nagar'),(625,'Kalyan West'),(115,'Kalyan-Dombivali'),(116,'Kalyani'),(2365,'Kamakhyanagar'),(2906,'Kamalpur'),(117,'Kamarhati'),(660,'Kambhaladinne'),(1666,'Kampa'),(2181,'Kamptee'),(1208,'Kamrup'),(853,'Kanakapura'),(1268,'Kanale'),(3016,'Kanayakumari'),(1730,'Kancheepuram'),(1762,'Kanchi'),(2057,'Kanchikacherla'),(2658,'Kanchipadi'),(359,'Kanchipuram'),(821,'Kanchrapara'),(2058,'Kandaghat'),(1749,'Kandhamala'),(2072,'Kandhar'),(694,'Kandhla'),(1678,'Kandhwara'),(318,'Kandukur'),(2047,'Kangayam'),(1512,'Kangirapally'),(1022,'Kangra'),(458,'Kanhangad South'),(987,'Kanikapada'),(1603,'Kaniyakumari'),(1291,'Kaniyur'),(1062,'Kanjeepuram'),(497,'Kanjirapally'),(454,'Kanker'),(1617,'Kankipadu'),(1613,'Kankroli'),(2404,'Kannad'),(1737,'Kannauj'),(1385,'Kanniampuram'),(348,'Kannur'),(3070,'Kanour'),(118,'Kanpur'),(1353,'Kantore'),(1584,'Kanur'),(2974,'Kanuru'),(2929,'Kanya Kumari'),(3060,'Kanyakumar'),(119,'Kanyakumari'),(1598,'Kapurthala'),(1384,'Kapurthaza'),(699,'Karad'),(988,'Karadi'),(816,'Karaikal'),(120,'Karaikkudi'),(403,'Karaikudi'),(2912,'Karakambadi'),(2719,'Karakikudi'),(657,'Karamsad'),(1939,'Karanja'),(2014,'Karatadipalayam'),(1729,'Karauli'),(1065,'Karayamuttom'),(1759,'Karbi Anglog'),(982,'Karbi Anglong'),(1944,'Karepally'),(2497,'Kariapatti'),(874,'Kariavattom'),(2251,'Karigiri'),(2168,'Karikkad'),(2106,'Karimbam'),(384,'Karimganj'),(121,'Karimnagar'),(2528,'Karimpur'),(2394,'Karjat'),(2154,'Karkala'),(2383,'Karma'),(1334,'Karnal'),(1520,'Karnya'),(859,'Karopady'),(2529,'Karottukara'),(1792,'Karouli'),(1070,'Karukachal'),(896,'Karukutty'),(2037,'Karumathur'),(2351,'Karungal'),(2408,'Karunguzhi'),(371,'Karur'),(1177,'Karvenagar'),(1250,'Karwar'),(438,'Kasaragod'),(767,'Kasargod'),(451,'Kasargode'),(612,'Kasauli'),(2456,'Kasganj'),(583,'Kashipur'),(501,'Kashmir'),(1532,'Kasibugga'),(1483,'Kathgodam'),(2615,'Kathua'),(640,'Katihar'),(1929,'Katni'),(2028,'Katol'),(851,'Katpadi'),(1721,'Katra'),(1005,'Kattakada'),(394,'Kattakampal'),(1061,'Kattan Kulathur'),(122,'Kattankulathur'),(1252,'Kattappana'),(2561,'Kattor'),(598,'Katwa'),(1609,'Kaup'),(1684,'Kaushambi'),(326,'Kavali'),(2697,'Kavaraipettai'),(2776,'Kavaratti'),(3049,'Kavindapadi'),(2645,'Kawardha'),(2792,'Kayamkulam'),(1984,'Kayangulam'),(2032,'Kedgaon'),(1997,'Keeranur'),(2279,'Keesara'),(1329,'Keezhilam'),(2386,'Kelambakkam'),(1429,'Kendrapara'),(1228,'Keonjhar'),(405,'Kerala'),(1213,'KGF'),(2784,'Khagaria'),(123,'Khagrabari'),(2417,'Khairabad'),(837,'Khairaha'),(2816,'Khairi'),(2526,'Khajipalem'),(1843,'Khambhat'),(898,'Khamgaon'),(490,'Khammam'),(2952,'Khammam Dist'),(926,'Khamman'),(1608,'Khandwa'),(923,'Khanna'),(1572,'Khantura'),(124,'Kharagpur'),(1837,'Kharar'),(2569,'Khargaon'),(1952,'Khargone'),(815,'Kharia'),(2845,'Khariar'),(2510,'Khatav'),(2876,'Khatima'),(1487,'Kheda'),(1801,'Khedbrahma'),(572,'Khelmati'),(1206,'Kherange'),(2054,'Kherva'),(1199,'Khetari'),(472,'Khetri'),(2460,'Khopoli'),(1810,'Khordha'),(1607,'Khurda'),(3080,'Khurdha'),(2043,'Khuri Bari'),(2400,'Khurja'),(1796,'Kichha'),(2725,'Kidangoor'),(2499,'Kidaripatty'),(1229,'Kikkeri P.O.'),(2006,'Kilakarai'),(1164,'Kilimanoor'),(2114,'Kille Dharur'),(894,'Killimangalam'),(1059,'Killur'),(2287,'Kilpennathur'),(460,'Kim'),(2814,'Kinnaur'),(1838,'Kinwat'),(1296,'Kirandul'),(2982,'Kirathoor'),(2586,'Kirei'),(1941,'Kirikera'),(1205,'Kirloskarwadi'),(2916,'Kirtinagar'),(2596,'Kirumampakkam'),(125,'Kishangarh'),(2832,'Kishtwar'),(684,'Kittur'),(1717,'KK Dist'),(2926,'Klawad'),(126,'Kochi'),(651,'Kochi 682'),(2605,'Kodad'),(527,'Kodagu'),(127,'Kodaikanal'),(2580,'Kodakara'),(1136,'Kodanchery'),(1681,'Kodavalur'),(1551,'Kodavasal'),(812,'Koderma'),(2894,'Kodigehally'),(2275,'Kodikanal'),(1223,'Kodungallur'),(641,'Kodur'),(1126,'Koduuayoor'),(3140,'Koganeishi 184-8795'),(1382,'Kohima'),(3096,'Kokata'),(951,'Kokrajhar'),(2245,'Kolaghat'),(1829,'Kolakata'),(1812,'Kolakta'),(491,'Kolar'),(1969,'Kolasib'),(1255,'Kolencherry'),(389,'Kolenchery'),(129,'Kolhapur'),(130,'Kolkata'),(131,'Kollam (Quilon)'),(323,'Komarapalayam'),(2935,'Komarapayayam'),(737,'Konch Jalan'),(2512,'Kondagaon'),(1906,'Kondair'),(2268,'Kondotty'),(2147,'Kondungallur'),(1380,'Konni'),(1369,'Koodalloor'),(2744,'Koothattukulam'),(2015,'Kopargaon'),(1303,'Koppa'),(688,'Koppal'),(2734,'Korangi'),(927,'Koraput'),(132,'Korba'),(2778,'Korea'),(378,'Koregaon'),(2771,'Korukonda'),(681,'Kostha'),(530,'Kot Kapura'),(2380,'Kot-Ise-Khan'),(133,'Kota'),(2418,'Kotagiri'),(134,'Kotala'),(1373,'Kotdwar'),(662,'Kothad'),(1905,'Kothadudem'),(620,'Kothagudem'),(995,'Kothala'),(1921,'Kothamangalam'),(2274,'Kothapar'),(1587,'Kothapet'),(1154,'Kothapeta'),(1521,'Kothecheruvu'),(2900,'Kottakkal'),(2664,'Kottappady'),(2151,'Kottapuram'),(1145,'Kottarakara'),(325,'Kottayam'),(2571,'Kottekad'),(1146,'Kottur'),(2160,'Kotturu'),(1372,'Kovilpatti'),(1505,'Kovvur'),(644,'Kowdiar'),(2676,'Kozhancherry'),(1216,'Kozhencheery'),(1971,'Kozhencheri'),(823,'Kozhikkode'),(393,'Kozhikode'),(135,'Kozhikode (Calicut)'),(1003,'Kozhikodi'),(1724,'Kozhizode'),(1751,'Krimnagar'),(136,'Krishangarh'),(306,'Krishna'),(1277,'Krishna Dist'),(305,'Krishnagar'),(307,'Krishnagiri'),(2334,'Krishnagri'),(2067,'Krishnankoil'),(308,'Krishnapuram'),(2490,'Krishnarajapete'),(1628,'Kudal'),(489,'Kudremukh'),(2619,'Kukas'),(1351,'Kukkundoor'),(2182,'Kulamavu'),(1053,'Kulanada'),(1660,'Kuldharan'),(1811,'Kulithalai'),(1709,'Kullu'),(137,'Kulti'),(1023,'Kumaracoil'),(875,'Kumarapatnam'),(1318,'Kumarhatti'),(1118,'Kumata'),(1105,'Kumbakoman'),(486,'Kumbakonam'),(1352,'Kumbhargaon'),(1441,'Kumbla P.O.'),(2879,'Kumhari'),(1888,'Kumily'),(508,'Kumta'),(2702,'Kundankulam'),(1594,'Kundapur'),(1954,'Kundapura'),(3030,'Kunigal'),(1511,'Kunnamangalam'),(1302,'Kunnamkulam'),(138,'Kuppam'),(2721,'Kupwad'),(2936,'Kupwars'),(813,'Kuravilangad'),(723,'Kurkunta'),(2607,'Kurnnol'),(139,'Kurnool'),(140,'Kurseong'),(2765,'Kurukkathi'),(142,'Kurukshetra'),(141,'Kushalnagar'),(1523,'Kushinagar'),(580,'Kusiapal'),(379,'Kustagi'),(791,'Kusumba'),(396,'Kutch'),(1350,'Kuthambalkkam'),(1356,'Kuttapatti'),(1328,'Kuttipuram'),(1342,'Kuttoor'),(1919,'Kuwaritol'),(2673,'Kuzhithurai'),(634,'Lachhmangarh'),(1750,'Ladakh'),(3063,'Ladnun'),(3139,'Laguna'),(2629,'Lahdoigarh'),(503,'Laheri Sarai'),(2421,'Lakhaoti'),(1438,'Lakhimpur'),(2385,'Lakhimpur-Kheri'),(2533,'Lakhtar'),(2714,'Lakkidi'),(910,'Lakshadweep'),(1824,'Lakshmangarh'),(473,'Lakurdi'),(642,'Lalganj'),(1727,'Lalitpur'),(1883,'Lamphelpat'),(2594,'Landran'),(143,'Larambha'),(2156,'Lasalgaon'),(2573,'Latehar'),(144,'Latur'),(2243,'Laulara'),(2890,'Laxmidevipally'),(2804,'Laxmiposi'),(1333,'Leh Ladakh'),(2811,'Leh-Ladakh'),(1578,'Lembucherra'),(2581,'Levengipuram'),(345,'Liluah'),(2240,'Limda'),(1845,'Linch'),(827,'Lludhiana'),(2220,'Lodhivali'),(2648,'Loha'),(2314,'Lohardaga'),(2537,'Lohit'),(3006,'Loktak'),(2362,'Lonand'),(145,'Lonavala'),(559,'Lonavla'),(3130,'London  W.C. 2'),(3134,'London W1J 0BA'),(2199,'Lonere'),(2377,'Longowal'),(146,'Loni'),(2035,'Lopan'),(147,'Lucknow'),(148,'Ludhiana'),(521,'Luknow'),(2454,'Lumding'),(2928,'Lunawada'),(2482,'Lunglei'),(3091,'Lushalnagar'),(2737,'Lutunia'),(2635,'M. Nidamalur'),(2124,'Machalipatnam'),(2558,'Macherla'),(526,'Machhra'),(966,'Machilipatnam'),(1274,'Madanapalle'),(1210,'Madanapalli'),(1098,'Madathukulam'),(1239,'Maddilapalam'),(2707,'Maddirala'),(899,'Madhappur'),(638,'Madhepura'),(904,'Madhubani'),(2448,'Madhubani PO'),(1813,'Madhupur'),(810,'Madhuranagar'),(149,'Madikeri'),(747,'Madras'),(1162,'Madura'),(150,'Madurai'),(1785,'Maduri'),(2863,'Magadi'),(1745,'Magpur'),(1527,'Mahaboob Nagar'),(1637,'Mahaboobnagar'),(743,'Mahabubnagar'),(2997,'Mahabumnagar'),(1052,'Mahad'),(2369,'Mahanandi'),(1732,'Maharaganj'),(1817,'Maharajganj'),(2903,'Mahasamund'),(2943,'Mahbubnagar'),(414,'Mahe'),(2437,'Mahendergarh'),(1355,'Mahendragarh'),(2316,'Mahendragiri'),(3085,'Mahesana'),(151,'Maheshtala'),(152,'Mahishadal'),(1294,'Mahoba'),(153,'Mahuva'),(2542,'Mailam'),(991,'Maindargi'),(1490,'Mainpuri'),(2248,'Majalgaon'),(883,'Majikuchi'),(532,'Makkuva'),(1708,'Makronia Sagar'),(444,'Mala'),(2345,'Malagi'),(679,'Malakkara'),(370,'Malappuram'),(615,'Malapuram'),(2112,'Malayadi'),(319,'Malda'),(154,'Malegaon'),(2875,'Malerkotla'),(2215,'Maliankara'),(2849,'Malikipuram'),(2606,'Malkapur'),(2289,'Mallampudi'),(1599,'Mallapally'),(1499,'Mallappally'),(1568,'Mallappuram'),(1849,'Mallasamudram W'),(2547,'Mallavadi'),(1151,'Malout'),(2204,'Mamallapuram'),(2742,'Manakkappady'),(435,'Manali'),(776,'Mananthavady'),(1313,'Mananvilai'),(2746,'Manargudi'),(2201,'Manassery'),(155,'Manauli'),(2821,'Manauri'),(2701,'Manbazar'),(2856,'Manchar'),(1079,'Mancherial'),(1325,'Mandapam Camp'),(1799,'Mandapeta'),(938,'Mandi'),(2300,'Mandi Dabwali'),(1046,'Mandla'),(2174,'Mandsaur'),(369,'Mandya'),(2541,'Manesar'),(575,'Mangalagangotri'),(1408,'Mangalbari'),(2789,'Mangaldai'),(3036,'Mangalloi'),(1887,'Mangalooru'),(156,'Mangalore'),(826,'Mangalpadi'),(893,'Mangalpady'),(1278,'Manglagangotri'),(2019,'Mangrulpir'),(2641,'Mani Majra'),(157,'Manipal'),(400,'Manjeri'),(2774,'Manjoor'),(1972,'Manjri'),(2176,'Mankhal'),(617,'Mankipur'),(2669,'Manmad'),(477,'Mannachanallur'),(406,'Mannam'),(2357,'Mannampadal'),(1855,'Mannampandal'),(1134,'Mannanam'),(320,'Mannargudi'),(1357,'Mannuthy'),(1667,'Manpur'),(1260,'Mansa'),(877,'Mansi'),(1514,'Manthiyoor'),(3111,'Manvi'),(602,'Mapusa'),(2485,'Marampally'),(1103,'Marbisu'),(2203,'Marcela'),(1015,'Margao'),(2126,'Margherita'),(1946,'Mariahu'),(1365,'Marigaon'),(2720,'Markanda'),(2101,'Markapur'),(970,'Marsaghai'),(461,'Martandam'),(2152,'Maruthakulam'),(1057,'Masa Kali Patti'),(2153,'Masinagudi'),(1867,'Mastuana Sahib'),(158,'Mathura'),(2951,'Matlapalem'),(1071,'Mattannur'),(511,'Mattanur'),(2363,'Mattupatti'),(159,'Mau'),(2517,'Maunath Bhanjan'),(1311,'Mavelikara'),(2668,'Mayabunder'),(1663,'Mayagonahalli'),(956,'Mayiladuthurai'),(1816,'Mayilladuthurai'),(1378,'Maylladuthuri'),(934,'Mayurbhang'),(1530,'Mayurbhanj'),(3038,'Maza Rahikpur'),(2103,'Maza Rahirpur'),(3155,'MD'),(3144,'MD 20814'),(1390,'Medak'),(2544,'Medchal'),(507,'Medinipur'),(1207,'Medziphema'),(1095,'Meenangadi'),(160,'Meerut'),(839,'Meerut Cantt'),(430,'Meeurt'),(2790,'Meghahatuburu'),(1469,'Meghalaya'),(789,'Mehabubnagar'),(2242,'Mehesana'),(367,'Mehkar'),(510,'Mehsana'),(790,'Mehsana Dist'),(1889,'Meignanapuram'),(2237,'Melaiyur'),(2913,'Melakodumalur'),(872,'Melappuram'),(1543,'Melattur'),(2388,'Mele Pattambi'),(2379,'Melmaruvathur'),(2520,'Melmuri'),(700,'Melvisharam'),(415,'Meppayur'),(1854,'Mesra'),(1344,'Metpally'),(1879,'Mettupalayan'),(1212,'Mettur'),(1673,'Mettur Dam'),(2001,'Mianpur'),(2910,'Midayikunnu'),(418,'Midnapore'),(682,'Midnapur'),(2332,'Minjur'),(161,'Mira-Bhayandar'),(1406,'Miraj'),(2399,'Miran Sahib'),(1636,'Mirijapur'),(2796,'Mirual'),(1233,'Miryalaguda'),(1330,'Mirza'),(162,'Mirzapur'),(1037,'Mizoram'),(948,'Modasa'),(3071,'Moddbidri'),(1232,'Modinagar'),(1379,'Modipara'),(3014,'Modusa'),(1051,'Moga'),(705,'Mogalikuduru'),(2353,'Mogra'),(2281,'Mohai'),(2979,'Mohail'),(163,'Mohali'),(433,'Mohanpur'),(2736,'Mohinder Garh'),(1848,'Mohindergarh'),(2840,'Mohitnagar'),(736,'Mokama'),(2818,'Mokamaghat'),(901,'Mokeri'),(2238,'Mokochung'),(928,'Mokokchung'),(1332,'Monippally'),(376,'Moodabidri'),(2950,'Moodbidiri'),(587,'Moodbidri'),(2853,'Moodlakatte'),(2904,'Moothakunnam'),(164,'Moradabad'),(2519,'Moranhat'),(2841,'Morena'),(554,'Morigaon'),(1189,'Morshi'),(165,'Motihari'),(2971,'Movva'),(2696,'MPR Dam'),(1797,'Muddebihal'),(2061,'Mudhol'),(552,'Mudigere'),(895,'Mukalmua'),(2626,'Mukandpur'),(2842,'Mukerian'),(1364,'Mukkam'),(2392,'Muktainagar'),(2307,'Muktsar'),(2130,'Mulabagal'),(2869,'Mulabagalu'),(1245,'Mulakalacheruvu'),(2071,'Mulkalla'),(599,'Mulki'),(2949,'Mullana'),(1285,'Mullanpur'),(1321,'Mullikolathur'),(2280,'Mulloorkara'),(166,'Mumbai'),(1908,'Mumbakonam'),(1640,'Mumbi'),(2595,'Mumbra'),(2767,'Munanjipatti'),(1048,'Mundalur'),(2964,'Mundargi'),(1341,'Munduparamba'),(2384,'Mundur'),(1803,'Mungeli'),(635,'Munger'),(2738,'Munipalli'),(336,'Munnar'),(1286,'Munnur'),(1881,'Mupusa'),(1422,'Murdeshwar'),(2420,'Murickassery'),(391,'Murshidabad'),(1700,'Murtizapur'),(1308,'Murum'),(2107,'Musiri'),(1672,'Mussoorie'),(1918,'Muthorai'),(2162,'Muthukur'),(3056,'Muthur'),(914,'Muvattupuzha'),(167,'Muzaffarnagar'),(168,'Muzaffarpur'),(1270,'Muzzafarnagar'),(1864,'Myladumpara'),(2766,'Mylavaram'),(1856,'Mysooru'),(169,'Mysore'),(2976,'N 24 Parganas'),(2121,'N.Pudhupatti'),(2548,'N.R. Palle'),(1461,'Nabha'),(1508,'Nacharam'),(170,'Nadia'),(551,'Nadiad'),(1161,'Nagai'),(352,'Nagaland'),(546,'Nagaon'),(466,'Nagapattinam'),(1253,'Nagarcoil'),(1122,'Nagarjuna Nagar'),(950,'Nagaur'),(171,'Nagercoil'),(3089,'Nagour'),(172,'Nagpur'),(2447,'Nagrakata'),(2233,'Nagunur'),(959,'Nahan'),(1714,'Naida'),(173,'Naihati'),(174,'Nainital'),(2309,'Najibabad'),(1029,'Naka Dongri'),(2295,'Nalagnda'),(1141,'Nalagonda'),(710,'Nalanda'),(1144,'Nalbari'),(446,'Nalgonda'),(2622,'Nalgonds'),(2987,'Naliya'),(2368,'Nalkalikkal'),(322,'Namakkal'),(1354,'Nambol'),(2986,'Namti'),(175,'Nanded'),(1116,'Nandeuri'),(566,'Nandgaon'),(1773,'Nandigama'),(2044,'Nandikotkur'),(806,'Nandurbar'),(1026,'Nandyal'),(2002,'Nangal'),(2712,'Nangali'),(2208,'Nangiarkulangar'),(176,'Nangloi Jat'),(2684,'Nanjanagudu'),(1644,'Nanjangud'),(1706,'Napaam'),(1872,'Napur'),(1760,'Narasapur'),(1006,'Narasaraopet'),(1182,'Narasinganet'),(2020,'Narasipatnam'),(2260,'Narasipuram'),(2434,'Narayanapura'),(2343,'Narayanpet'),(2348,'Naregal'),(2905,'Narendrapur'),(1540,'Narnaul'),(469,'Narsapur'),(1371,'Narsinghpur'),(330,'Narukara'),(2672,'Narwapahar'),(177,'Nashik'),(672,'Nasik'),(2145,'Nasrapur'),(2846,'Natepute'),(2698,'Nathdwara'),(2378,'Natipora'),(711,'Nattika'),(3031,'Naugachia'),(1868,'Nauni'),(1055,'Nausari'),(2611,'Navagam'),(2278,'Navalur'),(2358,'Navapur'),(2692,'Navi Mumai'),(178,'Navi Mumbai'),(1793,'Navli'),(1159,'Navsari'),(1619,'Nawada'),(2187,'Nawagarh'),(1150,'Nawalgarh'),(1413,'Nawanshah Dt'),(925,'Nawanshahr'),(2381,'Nawanshehr'),(1651,'Nawarangpur'),(1184,'Nawargaon'),(2643,'Naya Bazar'),(1368,'Naya Nangal'),(1121,'Nayagarh'),(1078,'Nayarkuzhi'),(2859,'Nayudupet'),(2457,'Nazareth'),(658,'Nazira'),(1834,'NC'),(584,'Nedumangad'),(2496,'Nedumkandam'),(610,'Nedumkunnam'),(2977,'Neeleswaram'),(755,'Neemuch'),(2000,'Neemuch Cant.'),(1193,'Nelakondapally'),(2967,'Nelamangala'),(1033,'Nellimoodu'),(1075,'Nellippara'),(179,'Nellore'),(2709,'Neriamangalam'),(411,'Nerparsopant'),(782,'Nesari'),(2530,'Nettana'),(180,'New Delhi'),(2880,'New Kamptee'),(1314,'New Mahe'),(880,'New Mumbai'),(693,'New Panvel'),(2122,'New Panvel (W)'),(692,'New Tehri'),(1841,'New VV Nagar'),(3127,'New York  10024 - 5192'),(2157,'Newasa'),(1331,'Neyveli'),(1345,'Neyyoor'),(2640,'Nicobar'),(2315,'Nidadavole'),(544,'Nidasoshi'),(2695,'Nigahi'),(340,'Nilambur'),(2681,'Nilambur RS'),(717,'Nilanga'),(537,'Nileshwar'),(864,'Nilgiris'),(2303,'Nilgris'),(2994,'Nillikuppam'),(2115,'Nimpith Ashram'),(1399,'Nintanehati'),(2442,'Nipani'),(1874,'Niphad'),(2441,'Nippani'),(1158,'Nirakarpur'),(181,'Nirjuli'),(182,'Nirmal'),(1394,'Nirmalagiri'),(183,'Nischintakoili'),(1942,'Nitte'),(184,'Nizamabad'),(3156,'NJ'),(3149,'NJ 08055'),(185,'Noida'),(3040,'Nongpoh'),(2040,'Nongstoin'),(2899,'Nooranad'),(758,'North Dinajpur'),(186,'North Dumdum'),(328,'North Lakhimpur'),(2178,'North24Parganas'),(2919,'Nowgam'),(824,'Nowgong'),(2850,'Nuagam'),(1104,'Nuapada'),(2229,'Nuvem'),(2659,'Nuzvid'),(1789,'Oantnagar'),(2623,'Obedullaganj'),(2666,'Oddanchatram'),(3136,'Ohio 43210-0012'),(2236,'Ojhar'),(1844,'Okkur'),(1414,'Olakettiampalam'),(2026,'Old Goa'),(2955,'Olhapur'),(1977,'Omerga'),(1264,'Ongole'),(2870,'Ooragam'),(344,'Ootacamund'),(1593,'Ooty'),(1138,'Orai'),(2931,'Orathanad'),(1835,'Oregon IL'),(578,'Orissa'),(974,'Osmanabad'),(945,'Othera'),(1387,'Ottapalam'),(887,'Otur'),(3141,'Oxon  OX10 8DF'),(187,'Ozhukarai'),(2772,'P Medinipur'),(2370,'P Seeragapadi'),(1420,'P. Nilayam'),(1917,'P.Medinipore'),(905,'P.Nilayam'),(2170,'Pachal'),(2956,'Pacheri Bari'),(2183,'Pachmarhi'),(765,'Pachora'),(517,'Pacode'),(1276,'Padanakkad'),(1326,'Padannakkad'),(2419,'Padannekkad'),(3122,'Padappai'),(2503,'Padhiana'),(1861,'Padnekat'),(2511,'Padra Tal'),(1257,'Padruna'),(740,'Padur'),(2515,'Paipad'),(2087,'Paiyanoor'),(2415,'Pakakkad'),(447,'Pakharpura'),(1901,'Pakur'),(3119,'Pakyong'),(2030,'Pakyoung'),(960,'Pala'),(338,'Palacode'),(1761,'Palai'),(1610,'Palakad'),(188,'Palakkad'),(844,'Palakol'),(2522,'Palamaner'),(3073,'Palamau'),(659,'Palampur'),(1142,'Palani'),(380,'Palanpur'),(785,'Palapur'),(833,'Palayad'),(409,'Palayamkottai'),(1687,'Palayampatti'),(1601,'Palayankottai'),(619,'Palem'),(1085,'Palemad'),(1404,'Palghar'),(3045,'Palghar (East)'),(920,'Palghat'),(189,'Pali'),(1923,'Pali Marwar'),(2911,'Paliabindha'),(1525,'Pallam'),(1191,'Pallatheri'),(2080,'Pallavur'),(670,'Palode'),(1082,'Paloncha'),(2831,'Palta'),(2452,'Palus'),(1272,'Palwal'),(1287,'Palyamkottai'),(2557,'Pampadumpara'),(2477,'Pampady'),(1097,'Pampady South'),(2068,'Pampore'),(712,'Panagal Post'),(321,'Panaji'),(1893,'Panangad'),(1227,'Panayur'),(2779,'Panchgani'),(190,'Panchkula'),(2340,'Panchmahal'),(1559,'Panchukla'),(1014,'Pandalam'),(2350,'Pandaul'),(1657,'Pandharpur'),(1904,'Pangode'),(191,'Panihati'),(192,'Panipat'),(1451,'Panipet'),(1129,'Panjim'),(1463,'Panjuaur PO'),(1477,'Panna'),(1188,'Panpoli'),(354,'Panruti'),(1433,'Panrutin'),(337,'Pantnagar'),(193,'Panvel'),(2874,'Paprola'),(2665,'Paradip'),(2808,'Paradip Port'),(889,'Parangipettai'),(618,'Parappanangadi'),(194,'Parasia'),(1501,'Parassinikadava'),(1457,'Parathode P.O.'),(769,'Parbatpur'),(195,'Parbhani'),(2084,'Parlakhemundi'),(2200,'Parli-Vaijnath'),(1979,'Parmathi'),(1648,'Parola'),(1111,'Parrathipuram'),(994,'Parunde'),(350,'Paruvakkudi'),(1955,'Parvatipuram'),(1093,'Parwanoo'),(1630,'Pashan'),(1580,'Pasighat'),(372,'Patan'),(1013,'Patana'),(197,'Patancheru'),(1517,'Patba'),(2934,'Patel Guda'),(1680,'Pathamthitta'),(647,'Pathanamthitta'),(1215,'Pathanapuram'),(754,'Pathankot'),(2637,'Pathanpuram'),(2436,'Pathardi'),(196,'Patiala'),(2861,'Patkura'),(198,'Patna'),(2686,'Patna Sahib'),(2018,'Patoda'),(2817,'Patratu'),(1484,'Pattambi'),(2760,'Pattamundai'),(2133,'Pattan'),(2338,'Patti'),(2284,'Pattikkad'),(465,'Pattithara'),(1475,'Pauagada Taluk'),(1054,'Pauri'),(2355,'Pauri Garhwal'),(2743,'Pavanasam'),(1309,'Pavaratty'),(1933,'Pavitram'),(2007,'Pavoorchatram'),(2504,'Payakaraopeta'),(2893,'Payangadi'),(725,'Payyannur'),(436,'Payyanur'),(1913,'Payyoli'),(786,'Pedagantyada'),(3118,'Pedavegi'),(961,'Peddapuram'),(1900,'Peechi'),(1606,'Peermade'),(2990,'Pehowa'),(863,'Pen'),(2855,'Pendra'),(770,'Penugonda'),(199,'Perambalur'),(2729,'Peravurani'),(2266,'Peringamala'),(2235,'Peringammala'),(1099,'Periyakulam'),(200,'Pernem'),(1235,'Perumbavoor'),(614,'Perundurai'),(2159,'Peruvallur'),(1513,'Pervmbavoor'),(2584,'Pethappampatti'),(841,'Petlad'),(1024,'Peyad'),(1041,'Phagwara'),(1088,'Phaltan'),(3125,'Philadelphia, PA 19130'),(3133,'Philadelphia, PA. 19103'),(992,'Phillaur'),(912,'Pichalaguri'),(748,'Pilani'),(1417,'Pilathara'),(2062,'Pilerne Bardez'),(2621,'Pilibhit'),(971,'Pimpalgaon'),(1661,'Pimpalner'),(201,'Pimpri-Chinchwad'),(2999,'Piparia'),(3105,'Pipariya'),(2438,'Piravom'),(2024,'Piska Nagari'),(202,'Pithoragarh'),(993,'Poarayar'),(2536,'Podakkudi'),(724,'Podili'),(2794,'Pokharan'),(2843,'Pokharipur'),(534,'Pollachi'),(907,'Ponda'),(2291,'Ponkunnam'),(2177,'Ponnala'),(2136,'Ponnampet'),(2132,'Ponnampete'),(2239,'Ponnani South'),(1992,'Ponneri'),(2749,'Ponniakurssi'),(1421,'Ponpadi'),(2781,'Pooch'),(1107,'Poochakkal'),(1932,'Poondi'),(1757,'Poonjar'),(2141,'Poonjeri'),(445,'Poothotta'),(2961,'Poovanthi'),(463,'Porabandar'),(849,'Porayar'),(525,'Porbandar'),(1304,'Port Balir'),(535,'Port Blair'),(1447,'Portonovo'),(1443,'Poruvazhi P.O.'),(750,'Poruvazhy'),(2563,'Porvorim'),(2184,'Pottapalayam'),(1765,'Powai'),(518,'Prakasam'),(3012,'Prakasam Dist'),(1539,'Prakashsam'),(1452,'Prasanthinilayam'),(203,'Prasanti Nilayam'),(3082,'Pratapgarah'),(1209,'Pratapgarh'),(464,'Pritinagar'),(1389,'Proddatur'),(809,'Pudikkottai'),(1747,'Pudikottai'),(204,'Puducherry'),(1616,'Pudukkottai'),(666,'Pudukottai'),(1175,'Pulgaon'),(2609,'Puliangudi'),(983,'Pulivendla'),(1393,'Pulivendula'),(529,'Pullazhi'),(1495,'Pulwama'),(2059,'Pundibari'),(2898,'Pundri'),(205,'Pune'),(2948,'Punkunnan'),(2683,'Puranattukara'),(1784,'Purba'),(1949,'Purba Medinipur'),(3095,'Purba Midnapur'),(310,'Puri'),(2523,'Purna'),(3057,'Purnea'),(206,'Purnia'),(668,'Purulia'),(1677,'Pusa'),(316,'Pusad'),(1963,'Puthanampatti'),(1690,'Puthenchira'),(2459,'Puthenpalli'),(1425,'Puthenthurai'),(1741,'Puthukkottai'),(1056,'Puttaparthi'),(1589,'Puttarparthi'),(962,'Puttur'),(594,'Qadian'),(2387,'Quepem'),(443,'Quilon'),(1343,'Qummalur'),(1734,'R R Dist'),(2937,'R R Dist.'),(1807,'R R District'),(2443,'R.Chodavaram'),(2753,'R.R.Dist'),(1214,'Racnhi'),(207,'Radaur'),(1641,'Rae Bareli'),(1738,'Raebareli'),(2663,'Raggad'),(2646,'Raghogarh'),(3081,'Rahtak'),(1947,'Rahuri'),(208,'Raichur'),(632,'Raigad'),(1432,'Raigad Dist'),(571,'Raiganj'),(918,'Raigarh'),(1481,'Raigudh'),(209,'Raipur'),(3003,'Raisen'),(210,'Rajahmundry'),(2551,'Rajakkamangalam'),(654,'Rajam'),(2525,'Rajampet'),(1702,'Rajapalaiyam'),(846,'Rajapalayam'),(567,'Rajapuram'),(2273,'RajaRammohunpur'),(2033,'Rajborasambar'),(978,'Rajeshwar'),(2597,'Rajgangapur'),(1934,'Rajgangpur'),(1503,'Rajgir'),(2405,'Rajgurunagar'),(2851,'Rajkanika'),(211,'Rajkot'),(633,'Rajnagar'),(2462,'Rajnandgaon'),(1748,'Rajouri'),(690,'Rajpipla'),(212,'Rajpur Sonarpur'),(1927,'Rajpura'),(2110,'Rajsamand'),(2613,'Rajura'),(213,'Ramagundam'),(1693,'Ramanagara'),(1319,'Ramanagaram'),(1113,'Ramanathapuram'),(2770,'Ramapuram'),(459,'Ramchandrapuram'),(1892,'Ramdurg'),(1814,'Ramgarh'),(2834,'Ramgarh Cantt.'),(953,'Ramnad'),(2757,'Ramnagar'),(989,'Rampachodavaram'),(214,'Rampur'),(407,'Rampura'),(2625,'Rampurhat'),(2090,'Ramtek'),(1063,'Ranaghat'),(2756,'Ranchaidham'),(215,'Ranchi'),(2276,'Rang Reddy'),(1531,'Ranga Reddy'),(1974,'Ranga Reddy Dis'),(2099,'Ranga ReddyDist'),(2179,'Rangal Reddy'),(2969,'Rangareddy'),(2963,'Rangareddy Dist'),(2299,'RangareddyDist'),(867,'Rangia'),(2476,'Ranibennur'),(1995,'Ranichauri'),(2465,'Raniganj'),(730,'Ranipet'),(2321,'Ranny'),(2491,'Rapalle'),(955,'Rasipuram'),(1194,'Ratanpur'),(216,'Ratlam'),(217,'Ratnagiri'),(2195,'Raver'),(1220,'Rawathbhata'),(819,'Rayagada'),(1282,'Rayarangoth'),(2506,'Rayavaram'),(1415,'Rayya'),(1696,'Razole'),(540,'Reasi'),(2566,'Rehli'),(1462,'Renukoot'),(1167,'Repalle'),(218,'Rewa'),(850,'Rewari'),(2331,'Ri Bhoi Dist'),(1494,'Rishi Valley'),(627,'Rishikesh'),(2871,'Robertsonpet'),(975,'Roha'),(219,'Rohtak'),(1604,'Rohtas'),(1027,'Roopnagar'),(220,'Roorkee'),(800,'Ropar'),(1292,'Rorkela'),(1782,'Rourkee'),(221,'Rourkela'),(1895,'RR Dist'),(2933,'RR District'),(3107,'Rrichy'),(3043,'Rudraprayag'),(3113,'Rudrapur'),(2877,'Rupai Siding'),(3055,'S 24 Parganas'),(1976,'S Kaghaznagar'),(317,'S S Nallur'),(1961,'S.A.S.Nagar'),(891,'S.Kanara'),(2011,'S.Krushinagar'),(1574,'Sabarkantha'),(1858,'Sabarkhnatha'),(2202,'Sadanandapuram'),(2218,'Sadra'),(1798,'Safidon'),(222,'Sagar'),(1101,'Sahaganj'),(223,'Saharanpur'),(1181,'Saharsa'),(595,'Sahibganj'),(2570,'Sai Vihar'),(1683,'Saidabad'),(2256,'Sailu'),(1988,'Sakaleshapura'),(2272,'Sakaleshpura'),(1348,'Sakali'),(2265,'Sakoli'),(2224,'Sakthinagar'),(2361,'Salcete'),(3101,'Salcette'),(2480,'Saldiha'),(3110,'Salekasa'),(224,'Salem'),(1685,'Saligao'),(2559,'Salipur'),(779,'Salur'),(2532,'Samana'),(331,'Samastipur'),(225,'Sambalpur'),(1283,'Sambhal'),(1890,'Sambhalkha'),(1109,'Sambra'),(434,'Samsi'),(842,'Sanagamner'),(1642,'Sanawad'),(774,'Sanawar'),(538,'Sanchi'),(596,'Sandur'),(2250,'Sangali'),(1383,'Sangamner'),(482,'Sangli'),(852,'Sangli Dist.'),(226,'Sangli-Miraj & Kupwad'),(2319,'Sangola'),(2113,'Sangole'),(1338,'Sangrur'),(3027,'Sanguem'),(1582,'Sankarankovil'),(2085,'Sankeshwar'),(514,'Sankhali'),(2339,'Sanosara'),(564,'Sanquelim'),(227,'Santiniketan'),(2793,'Santragachi'),(3147,'Sao Pavlo 01222-010'),(2185,'Saoner'),(1409,'Sarang'),(2975,'Sardarshahr'),(2992,'Sarguja'),(3086,'Sarhali'),(2227,'Sarkaghat'),(2674,'Sarood'),(1880,'Saroornagar'),(2198,'Sarsa'),(2809,'Sarsawa'),(1478,'Sarugani'),(228,'SAS Nagar'),(2021,'Sasthamcotta'),(1381,'Sasthamcottah'),(2100,'Sasthamkotta'),(2207,'Saswad'),(1396,'Satana'),(229,'Satara'),(2017,'Sathiyamangalam'),(2494,'Sathupalli'),(900,'Sathupally'),(1847,'Sathyamangalam'),(230,'Satna'),(977,'Satsang'),(1552,'Sattur'),(1468,'Savanur P.O.'),(2105,'Sawai Madhopur'),(2342,'Sawaimadapur'),(485,'Sawaimadhopur'),(2292,'Sawantwadi'),(2056,'Sawarde'),(829,'Sawyerpuram'),(2076,'SBS Nagar'),(3033,'SBS Nagar (NSR)'),(231,'Secunderabad'),(613,'Secundrabad'),(2507,'Sehore'),(749,'Seijusa'),(2264,'Selaqui'),(1794,'Sembakkam'),(1964,'Senapati'),(2249,'Seoni'),(2111,'Seoul 121'),(232,'Serampore'),(3067,'Serchhip'),(1938,'Sevagram'),(2270,'Sevalpatti'),(1502,'SGR Kashmir'),(2335,'Shabad'),(604,'Shahabad'),(2624,'Shahabad (M)'),(1176,'Shahada'),(1016,'Shahdol'),(233,'Shahjahanpur'),(2923,'Shajapur'),(1163,'Shaktinagar'),(936,'Shamli'),(2534,'Shamshabad'),(2428,'Shaniwareeth'),(1170,'Shankaraghatta'),(1148,'Shardanagar'),(475,'Shegaon'),(1402,'Shencottah'),(1008,'Shendurjanaghat'),(2989,'Sheopur'),(2567,'Sheopur Kalan'),(1180,'Shevgaon'),(539,'Shikohabad'),(234,'Shillong'),(2858,'Shimirpet'),(235,'Shimla'),(2914,'Shimurali'),(2082,'Shingnapur'),(607,'Shirala'),(2074,'Shirgaon'),(1400,'Shirpur'),(2323,'Shirur'),(1884,'Shivamogga'),(236,'Shivamogga (Shimoga)'),(2993,'Shivapuri'),(1878,'Shivnagar'),(3083,'Shivpuri'),(1299,'Shmoga'),(2346,'Shmogar'),(843,'Sholinganallur'),(2908,'Sholinghur'),(531,'Shoranur'),(2065,'Shorapur'),(1346,'Shornur'),(1877,'Shreeramnagar'),(2848,'Shreewardhan'),(2158,'Shrigonda'),(876,'Shringere'),(1363,'Shrirampur'),(2630,'Shrivilliputhur'),(1948,'Shujalpur'),(1044,'Siddapur'),(831,'Siddhpur'),(1853,'Siddipet'),(1275,'Sidhi'),(2252,'Sidhrawali'),(2175,'Sidhwar Khurd'),(2730,'Sihora'),(671,'Sikar'),(2360,'Sikara'),(425,'Sikharpur'),(1493,'Sikkim'),(1639,'Sikkim (East)'),(237,'Silchar'),(238,'Siliguri'),(616,'Silliguri'),(2119,'Sillod'),(2860,'Silvassa'),(2171,'Simaluguri'),(629,'Simhachalam'),(2042,'Simulbari'),(1945,'Sindewahi'),(3152,'Sindh 73050'),(239,'Sindhudurg'),(771,'Sindhudurga'),(778,'Sindkheda'),(1315,'Singanallur'),(1753,'Singapore'),(2244,'Singarayakonda'),(656,'Singhbhum'),(1625,'Singhbhum (E)'),(1778,'Singhrauli'),(2633,'Singoor'),(240,'Singrauli'),(2516,'Sinnar'),(2451,'Siricilla'),(985,'Sirkali'),(2395,'Sirmour'),(941,'Sirmur'),(958,'Sirohi'),(1106,'Sironcha'),(601,'Sirsa'),(471,'Sirsi'),(665,'Siruseri'),(879,'Sitapur'),(1827,'Sitarganj'),(241,'Sivaganga'),(947,'Sivagiri'),(1726,'Sivakashi'),(242,'Sivakasi'),(385,'Sivapuri'),(964,'Sivasagar'),(1120,'Siwan'),(243,'Sodepur'),(3077,'Sohna'),(942,'Solan'),(244,'Solapur'),(2322,'Someshwarnagar'),(2060,'Sonai'),(1465,'Sonapur'),(2344,'Sonari'),(650,'Sonarpur'),(678,'Sonbhadra'),(2086,'Sonbhanra'),(1335,'Sonebhadra'),(603,'Sonepat'),(467,'Sonepur'),(245,'Sonipat'),(1634,'Sonipet'),(822,'Sonitpur'),(1280,'Sontipur'),(1907,'Sopore'),(1018,'Soro'),(3146,'South Africa'),(2602,'South Andaman'),(246,'South Dumdum'),(2048,'South Kodagu'),(3041,'South Tripura'),(2228,'Sreekandapuram'),(2694,'Sreenivasapuram'),(1650,'Sri Ganga Nagar'),(247,'Sri Ganganagar'),(742,'Sri Palli'),(1712,'Sriganganagar'),(1652,'Srihari Kota'),(1925,'Sriharikota'),(1533,'Srikakulam'),(2527,'Srikalahasthi'),(509,'Srikalahasti'),(1546,'Srikaulam'),(2940,'Srimushnam'),(248,'Srinagar'),(2241,'SrinagarGarhwal'),(716,'Sringeri'),(408,'Sriniketan'),(1519,'Srinivasanagar'),(2867,'Srinivasapura'),(745,'Srinivasnagar'),(440,'Srinivaspur'),(1710,'Sriperumbpudur'),(249,'Sriperumbudur'),(250,'Srirampur'),(2942,'Srisailam'),(980,'Srivaikuntam'),(1266,'Srivilliputtur'),(1474,'Srukandapuram'),(3106,'Subansiri'),(2191,'Subrahmanya'),(2109,'Sudumbre'),(1263,'Sullia'),(1169,'Sullurpet'),(1197,'Sullurpeta'),(940,'Sullurupeta'),(251,'Sultanpur'),(1902,'Sulthan Bathery'),(2713,'Sulur'),(3050,'Sunam'),(696,'Sundargarh'),(1669,'Sundaridia'),(2799,'Sunderbani'),(478,'Sunderchak'),(1562,'Sundergarh'),(1050,'Supane'),(1254,'Surajpur'),(1987,'Surampalem'),(252,'Surat'),(1186,'Surathakal'),(253,'Surathkal'),(1115,'Suratkal'),(2823,'Surda'),(2330,'Surendranagar'),(861,'Surguja'),(557,'Suri'),(885,'Suryamaninagar'),(733,'Suryapet'),(1261,'Sutrapada'),(1912,'Suttur'),(1019,'Swamimalai'),(2726,'Syamsundar'),(1718,'T V Malai'),(2172,'T. Kallikulam'),(2959,'T.Kallupatty'),(1870,'Tadapalligudem'),(2922,'Tadapatri'),(586,'Tadepalligudem'),(2326,'Tadikonda'),(2627,'Tadong'),(1171,'Tadpatri'),(1754,'Taegu'),(3153,'Taipei'),(2891,'Takhatpur'),(932,'Talab Tilloo'),(1786,'Talakonda'),(2327,'Talcher'),(1002,'Taleigao'),(1818,'TaleigaoPlateau'),(1084,'Taleigo'),(556,'Taliparamba'),(2226,'Talod'),(2468,'Taloda'),(474,'Talwara'),(351,'Tambaram'),(2261,'Tamenglong'),(1990,'Tamkuhiraj'),(1467,'Tamluk'),(2471,'Tangi'),(1581,'Tangore'),(2140,'Tanjavur'),(1187,'Tanjore'),(427,'Tanuku'),(972,'Tarikere'),(1840,'Tarikhet'),(2432,'Tarn Taran'),(2324,'Tarsadi'),(1962,'Tasgaon'),(3010,'Tatnagiri'),(2638,'Tattamangalam'),(1863,'Tavanur'),(1823,'Teh-Merta'),(1445,'Tehri'),(1476,'Tehri Garhwal'),(1869,'Tehsil Rajpura'),(1222,'Tehsil Tibbi'),(802,'Tekkali'),(909,'Telam'),(1805,'Teleiago'),(591,'Tellicherry'),(1689,'Telliicherry'),(686,'Tenali'),(1488,'Tenkara P.O.'),(1424,'Tenkasi'),(2422,'Terri Garhwal'),(3059,'Tetali'),(255,'Tezpur'),(2549,'Tezu'),(1577,'Thachanallur'),(2786,'Thadlaskein'),(2093,'Thalacode'),(450,'Thalassery'),(2005,'Thalavapalayam'),(1242,'Thana'),(2978,'Thance'),(2932,'Thandalam'),(256,'Thane'),(868,'Thane (W)'),(856,'Thane (West)'),(729,'Thane Dist.'),(3109,'Thane East'),(1516,'Thane West'),(2662,'Thane(W)'),(254,'Thanjavur'),(1821,'Thanjvur'),(3004,'Tharamangalam'),(1620,'Thasra'),(2393,'Thathanur'),(1047,'Thatipparamba'),(1202,'Thattamala'),(1536,'The Nilgiris'),(1300,'Theerthamalai'),(1500,'Thellar'),(1395,'Thellyoor'),(1166,'Thenhipalam'),(1435,'Thenhipalam PO'),(1547,'Theni'),(2642,'Thenzawl'),(2219,'Thetkuppalam'),(1307,'Thickurichy'),(1179,'Thimmasamudram'),(431,'Thiruchirapalli'),(2901,'Thirumansolai'),(1711,'Thirunelveli'),(2424,'Thiruninravur'),(2257,'Thirupachur'),(1203,'Thirupathur'),(1983,'Thiruppanadal'),(1633,'Thiruppathur'),(1808,'Thirupur'),(1569,'Thiruvaiyaru'),(1719,'Thiruvalam'),(1190,'Thiruvalla'),(1596,'Thiruvallur'),(257,'Thiruvananthapuram'),(1411,'Thiruvankulam'),(1042,'Thiruvannamalai'),(1140,'Thiruvarur'),(1697,'Thiruvattar'),(2727,'Thiruvilla'),(346,'Thodupuzha'),(997,'Thokkavadi'),(2944,'Tholayavattam'),(1985,'Tholudur'),(1112,'Thondi'),(1991,'Thoothoor'),(303,'Thoothukudi'),(2143,'Thoppur'),(570,'Thotakkara'),(2186,'Thottakkadu'),(2478,'Thoubal'),(2127,'Thovalai'),(2947,'Thrikkakara'),(2486,'Thrikkanapuram'),(258,'Thrissur'),(381,'Thrisur'),(1249,'Thrisuur'),(494,'Thriuchirapalli'),(2578,'Thruvannamalai'),(2354,'Thuckalay'),(2296,'Thuruthicad'),(2211,'Thuthukudi'),(1646,'Tihu'),(2650,'Tikamgarh'),(922,'Tilaiya Dam'),(2777,'Tilwasni'),(1694,'Tindivanam'),(1538,'Tinsukia'),(1036,'Tiptur'),(3102,'Tirap'),(1716,'Tirchengode'),(1820,'Tirchy'),(1940,'Tirtol'),(731,'Tiruchendur'),(1407,'Tiruchengode'),(1560,'Tiruchiraoalli'),(259,'Tiruchirapalli'),(2336,'Tiruchirapally'),(1224,'Tiruchirappali'),(395,'Tiruchirappalli'),(1066,'Tiruchy'),(335,'Tirukalukundram'),(1173,'Tirukovilour'),(2210,'Tirumangalam'),(897,'Tirunelvali'),(260,'Tirunelveli'),(1830,'Tirunelvelli'),(797,'Tiruninravur'),(355,'Tirupathi'),(261,'Tirupati'),(1506,'Tirupattur'),(2197,'Tiruppattur'),(1081,'Tiruppur'),(262,'Tirupur'),(2166,'Tirur'),(2469,'Tirurangadi'),(2980,'Tiruttani'),(1959,'Tiruvalam'),(713,'Tiruvalla'),(549,'Tiruvannamalai'),(2902,'Tiruvannmalai'),(1310,'Tiruvarur'),(1566,'Tiruvelveli'),(825,'Tiruvetipuram'),(263,'Tiruvottiyur'),(2886,'Tiruvuru'),(1822,'Tonk'),(1833,'Tonk Road'),(2396,'Toranagallu'),(1891,'Trichi'),(1553,'Trichirappalli'),(373,'Trichur'),(2830,'Trimbuk'),(1723,'Trippur'),(366,'Tripunithura'),(931,'Tripur'),(884,'Tripura'),(1668,'Tripura (N)'),(3024,'Tripura West'),(735,'Trissur'),(3115,'Trivandruam'),(803,'Trivandurm'),(1635,'Trvandrum'),(2009,'Tuljapur'),(2117,'Tumakooru'),(264,'Tumakuru (Tumkur)'),(390,'Tumkur'),(1638,'Tumukur'),(2010,'Tuni'),(703,'Tura'),(1615,'Turuppur'),(492,'Tuticorin'),(1295,'Tutucorin'),(3157,'TX'),(1826,'U.S. Nagar'),(2930,'UB Kanker'),(453,'Uchipulli'),(1528,'Udaipir'),(265,'Udaipur'),(2505,'Udala'),(1017,'Udalguri'),(1728,'Udam Singhnagar'),(2470,'Udamalpet'),(2464,'Udayagiri'),(1359,'Udayamperoor'),(1565,'Udayarpalayam'),(718,'Udgir'),(957,'Udhagamandalam'),(302,'Udhampur'),(707,'Udhna'),(1828,'Udipi'),(1021,'Udumalpet'),(301,'Udupi'),(3044,'Udupt'),(1665,'Udwada'),(375,'Ujire'),(266,'Ujjain'),(2755,'Ukhrul'),(2008,'Ulga'),(267,'Ulhasnagar'),(1482,'Ullhasnagar'),(268,'Uluberia'),(2582,'Umaim'),(2883,'Umakhed'),(300,'Umaria'),(1237,'Umarkhed'),(2222,'Umiam'),(2747,'Umrangso'),(2196,'Umred'),(2991,'Una'),(858,'Unnao'),(398,'Uppinangadi'),(3094,'Uppinangady'),(2426,'Uran'),(2820,'US Nagar'),(1504,'Usilampatti'),(2337,'Uthamapalayam'),(1032,'Uthangal'),(1226,'Uthangarai'),(2413,'Uthangudi'),(1768,'Uttar Dinajpur'),(719,'Uttarkashi'),(1132,'Uzhavoor'),(2896,'V. Kote'),(2711,'V. Singapuram'),(706,'V. Vidyanagar'),(353,'V.Vidyanagar'),(626,'Vadakara'),(423,'Vadakkevila'),(3007,'Vadamavandal'),(2108,'Vadlamudi'),(269,'Vadodara'),(2092,'Vaijapur'),(2509,'Vairag'),(2984,'Vaishali'),(448,'Valacodu'),(2960,'Valad'),(496,'Valancheri'),(2253,'Valanchery'),(2710,'Valapad'),(2091,'Valarpuram'),(630,'Valavannur'),(417,'Valavanour'),(270,'Vallabh Vidyanagar'),(1391,'Vallam'),(933,'Vallanad'),(2095,'Vallanadu'),(695,'Vallar'),(878,'Vallioor'),(2844,'Valmikipuram'),(2144,'Valod'),(930,'Valparai'),(3028,'Valpoi'),(299,'Valsad'),(1496,'Valvada'),(271,'Vamadapadavu'),(2373,'Vanagaram'),(1537,'Vanasthalipuram'),(1953,'Vandalur'),(1489,'Vandavasi'),(698,'Vaniyambadi'),(2591,'Vannarpettai'),(519,'Vapi'),(2433,'Vapi (West)'),(272,'Varanasi'),(1733,'Varansai'),(976,'Varkala'),(524,'Varnasi'),(2475,'Varvand'),(2098,'Vasad'),(1743,'Vasai'),(1989,'Vasai Road (W)'),(2857,'Vasai Road West'),(273,'Vasai-Virar'),(1973,'Vasco'),(1676,'Vasco da gama'),(1715,'Vasco-da-Gama'),(2540,'Vaslas'),(3069,'Vasudevanallur'),(967,'Vatakara'),(1731,'Vatanasi'),(3150,'Vavuniya'),(1671,'Vayala'),(1072,'Vayalar'),(2564,'Vayyuru'),(2678,'Vazhakulam'),(2267,'Vazhayoor East'),(2733,'Vazhithala'),(2593,'Vazhoor'),(2125,'Veerachipalayam'),(2328,'Veeravasaram'),(1647,'Velha'),(1076,'Veliyur'),(1555,'Vellalloor'),(1922,'Vellayani'),(3011,'Vellichanthai'),(2677,'Vellithiruthy'),(274,'Vellore'),(1361,'Velur'),(1298,'Vemom'),(1236,'Vemon'),(2699,'Vengola'),(2463,'Vengurla'),(2614,'Venjaramoodu'),(2670,'Venkatachalam'),(2164,'Venkatagirikote'),(1130,'Vennikulam'),(2022,'Venpakkam'),(2921,'Veraval'),(2038,'Verem'),(2618,'Verna'),(1970,'Vetapalem'),(1271,'Vettavalam'),(1423,'Vetturnimadam'),(2366,'Vidavalur'),(1358,'Vididsha'),(674,'Vidisha'),(908,'Vidyanagar'),(574,'Vijaipur'),(1043,'Vijayamangalam'),(2864,'Vijayapura'),(2802,'Vijayavada'),(275,'Vijayawada'),(1575,'Vikarabad'),(3062,'Vikiravandi'),(1327,'Vilayancode'),(2514,'Villapakkam'),(2088,'Villianur'),(2608,'Villiapalli'),(2958,'Villpuram'),(1602,'Villukuri'),(2317,'Villukury'),(1621,'Villuppuram'),(1068,'Villupuram'),(1664,'Vinukonda'),(2194,'Virajapet'),(3015,'Virajpet'),(582,'Virar (West)'),(1561,'Virddhachalam'),(297,'Viridhunagar'),(515,'Viruddhachalam'),(1740,'Virudhu Nagar'),(3013,'Virudunagar'),(2946,'Visakapatnam'),(276,'Visakhapatnam'),(2036,'Visakhpatnam'),(2034,'Visakyhapatnam'),(298,'Vishakhapatnam'),(1670,'Vishnupur'),(1114,'Visnagar'),(2398,'Vita'),(622,'Vitalnagar'),(1916,'Vittal'),(2957,'Vixianagaram'),(911,'Vizag'),(592,'Vizianagaram'),(1787,'Vizianagram'),(963,'Vizninjam'),(2555,'Vllore'),(1544,'Voimedu'),(2854,'Vriddhachalam'),(886,'Vridhachalam'),(1174,'Vsgao'),(1866,'Vuyyuru'),(2049,'VV Nagar'),(939,'Vyara'),(1030,'Vyasagiri'),(2688,'W Garo Hills'),(1480,'W.Champaran'),(2367,'W.G Dist'),(913,'W.Godavari'),(2577,'Wadhwancity'),(1998,'Wagholi'),(1200,'Wai'),(1039,'Waknaghat'),(1839,'Walajapet'),(585,'Waltair'),(2576,'Wandiwash'),(783,'Wani'),(2148,'Waranagar'),(277,'Warangal'),(294,'Wardha'),(1951,'Wargal'),(536,'Warora'),(2592,'Washim'),(296,'Wayanad'),(1558,'West Champaran'),(2205,'West Champuram'),(855,'West Garo Hills'),(569,'West Godavari'),(3039,'West KhasiHills'),(2690,'West Midnapore'),(1446,'West Singhbhoom'),(3051,'West Singhbhum'),(2472,'WG Dist'),(3088,'WG District'),(2773,'Yadagiri'),(2562,'Yadgir'),(1231,'Yamuna Nagar'),(278,'Yamunanagar'),(2004,'Yanam'),(295,'Yavatmal'),(2401,'Yawatmal'),(279,'Yeddumailaram'),(280,'Yelburga'),(548,'Yellamanchili'),(541,'Yellandu'),(2785,'Yellapur'),(2012,'Yemmiganur'),(1376,'Yeotmal'),(873,'Yercaud'),(2301,'Yerraguntla'),(2628,'Yeshwantnagar'),(2372,'Yol Cantt.'),(2045,'YSR Dist'),(2805,'Zawar Mines'),(1806,'Zirakpur'),(1591,'Zuari Nagar'),(685,'Zuarinagar');
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
  `invoiceNumber` varchar(32) NOT NULL,
  `subscriptionId` int(15) DEFAULT NULL,
  `invoiceCreationDate` date DEFAULT NULL,
  `invoice_type_id` int(11) NOT NULL DEFAULT '1',
  `amount` float unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `invoice_idx1` (`subscriptionId`,`invoice_type_id`)
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
INSERT INTO `invoice_types` VALUES (2,'Outstanding Payment'),(1,'Request For Invoice'),(3,'Upcoming Year Invoice');
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
  KEY `inward_agent_details_idx1` (`inwardId`),
  KEY `inward_agent_details_idx2` (`agentId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
  `issue` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `missingCopies` int(11) NOT NULL,
  `action` char(1) DEFAULT NULL,
  `sentOn` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `mailinglistid` int(11) DEFAULT '0',
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
  `invoiceAddress` varchar(128) NOT NULL,
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
INSERT INTO `subscriber_type` VALUES (1,'FELJM','Fellows','Free','I','P',2,0.000),(2,'AS','Associate','Free','I','P',2,0.000),(3,'EBALL','Editorial Board Member','Free','I','P',1,0.000),(4,'EI','Indian Exchange','Free','I','I',0,0.000),(5,'EF','Foreign Exchange','Free','F','I',0,0.000),(6,'GRANT','Grant','Free','I','P',2,0.000),(7,'AUTH','AUTHOR','Free','I','P',1,0.000),(8,'II','Indian Universities and Institutions','Paid','I','I',0,0.000),(9,'IC','Indian Schools and Colleges','Paid','I','I',0,0.000),(10,'IN','Industry Corporates','Paid','I','I',0,0.000),(11,'IP','Indian Personal','Paid','I','P',0,0.000),(12,'FP','Foreign Personal','Paid','F','P',0,0.000),(13,'FI','Foreign Institutions','Paid','F','I',0,0.000),(14,'SF','Summer Fellows','Free','I','P',1,0.000),(15,'HONFEL','Honorary Fellow','Free','I','P',0,0.000),(16,'LSP','Life Subscriber Personal','Paid','I','P',0,0.000),(17,'LSI','Life Subscriber Institutions','Paid','I','I',0,0.000),(18,'MEMBER','Members','Free','I','P',0,0.000),(19,'WC','Working Committee','Free','I','P',0,0.000);
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
INSERT INTO `subscription_rates` VALUES (1,0,0,0,0,0),(2,11,10,2013,1,10000),(3,12,10,2013,1,13000),(4,13,10,2013,1,3300),(5,10,10,2013,2,900),(6,10,10,2013,3,1300),(7,10,10,2013,5,2000),(8,11,10,2013,2,18000),(9,11,10,2013,3,26000),(10,11,10,2013,5,44000),(11,1,8,2013,1,750),(12,2,8,2013,1,300),(13,3,8,2013,1,300),(14,4,8,2013,1,400),(15,5,8,2013,1,400),(16,6,8,2013,1,400),(17,7,8,2013,1,400),(18,8,8,2013,1,400),(19,9,8,2013,1,300),(20,10,8,2013,1,500),(21,11,8,2013,1,4000),(22,12,8,2013,1,7000),(23,13,8,2013,1,3300),(24,10,8,2013,2,900),(25,10,8,2013,3,1300),(26,10,8,2013,5,2000),(27,11,8,2013,2,7500),(28,11,8,2013,3,10000),(29,11,8,2013,5,16000),(30,1,9,2013,1,750),(31,2,9,2013,1,300),(32,3,9,2013,1,300),(33,4,9,2013,1,400),(34,5,9,2013,1,400),(35,6,9,2013,1,400),(36,7,9,2013,1,400),(37,8,9,2013,1,400),(38,9,9,2013,1,300),(39,10,9,2013,1,500),(40,11,9,2013,1,1500),(41,12,9,2013,1,4800),(42,13,9,2013,1,3300),(43,10,9,2013,2,900),(44,10,9,2013,3,1300),(45,10,9,2013,5,2000),(46,11,9,2013,2,2250),(47,11,9,2013,3,3500),(48,11,9,2013,5,6000),(49,1,11,2013,2,700),(50,2,11,2013,2,400),(51,3,11,2013,2,400),(52,4,11,2013,2,500),(53,5,11,2013,2,500),(54,6,11,2013,2,500),(55,7,11,2013,2,500),(56,8,11,2013,2,500),(57,9,11,2013,2,400),(58,10,11,2013,2,400),(59,11,11,2013,2,1250),(60,10,11,2013,3,650),(61,10,11,2013,5,1010),(62,11,11,2013,3,1750),(63,11,11,2013,5,3000),(64,11,10,2012,1,10000),(65,1,8,2012,1,750),(66,2,8,2012,1,300),(67,3,8,2012,1,300),(68,4,8,2012,1,400),(69,5,8,2012,1,400),(70,6,8,2012,1,400),(71,7,8,2012,1,400),(72,8,8,2012,1,400),(73,9,8,2012,1,300),(74,10,8,2012,1,500),(75,11,8,2012,1,4000),(76,12,8,2012,1,7000),(77,13,8,2012,1,3300),(78,10,8,2012,2,900),(79,10,8,2012,3,1300),(80,10,8,2012,5,2000),(81,11,8,2012,2,7500),(82,11,8,2012,3,10000),(83,11,8,2012,5,16000),(84,1,9,2012,1,750),(85,2,9,2012,1,300),(86,3,9,2012,1,300),(87,4,9,2012,1,400),(88,5,9,2012,1,400),(89,6,9,2012,1,400),(90,7,9,2012,1,400),(91,8,9,2012,1,400),(92,9,9,2012,1,300),(93,10,9,2012,1,500),(94,11,9,2012,1,1500),(95,12,9,2012,1,4800),(96,13,9,2012,1,3300),(97,10,9,2012,2,900),(98,10,9,2012,3,1300),(99,10,9,2012,5,2000),(100,11,9,2012,2,2250),(101,11,9,2012,3,3500),(102,11,9,2012,5,6000),(103,1,11,2012,2,700),(104,2,11,2012,2,400),(105,3,11,2012,2,400),(106,4,11,2012,2,500),(107,5,11,2012,2,500),(108,6,11,2012,2,500),(109,7,11,2012,2,500),(110,8,11,2012,2,500),(111,9,11,2012,2,400),(112,10,11,2012,2,400),(113,11,11,2012,2,1250),(114,10,11,2012,3,650),(115,10,11,2012,5,1010),(116,11,11,2012,3,1750),(117,11,11,2012,5,3000),(118,1,1,2012,1,0),(119,2,1,2012,1,0),(120,3,1,2012,1,0),(121,4,1,2012,1,0),(122,5,1,2012,1,0),(123,6,1,2012,1,0),(124,7,1,2012,1,0),(125,8,1,2012,1,0),(126,9,1,2012,1,0),(127,10,1,2012,1,0),(128,11,1,2012,1,0),(129,1,2,2012,1,0),(130,2,2,2012,1,0),(131,3,2,2012,1,0),(132,4,2,2012,1,0),(133,5,2,2012,1,0),(134,6,2,2012,1,0),(135,7,2,2012,1,0),(136,8,2,2012,1,0),(137,9,2,2012,1,0),(138,10,2,2012,1,0),(139,11,2,2012,1,0),(140,1,3,2012,1,0),(141,2,3,2012,1,0),(142,3,3,2012,1,0),(143,4,3,2012,1,0),(144,5,3,2012,1,0),(145,6,3,2012,1,0),(146,7,3,2012,1,0),(147,8,3,2012,1,0),(148,9,3,2012,1,0),(149,10,3,2012,1,0),(150,11,3,2012,1,0),(151,1,4,2012,1,0),(152,2,4,2012,1,0),(153,3,4,2012,1,0),(154,4,4,2012,1,0),(155,5,4,2012,1,0),(156,6,4,2012,1,0),(157,7,4,2012,1,0),(158,8,4,2012,1,0),(159,9,4,2012,1,0),(160,10,4,2012,1,0),(161,11,4,2012,1,0),(162,1,5,2012,1,0),(163,2,5,2012,1,0),(164,3,5,2012,1,0),(165,4,5,2012,1,0),(166,5,5,2012,1,0),(167,6,5,2012,1,0),(168,7,5,2012,1,0),(169,8,5,2012,1,0),(170,9,5,2012,1,0),(171,10,5,2012,1,0),(172,11,5,2012,1,0),(173,1,6,2012,1,0),(174,2,6,2012,1,0),(175,3,6,2012,1,0),(176,4,6,2012,1,0),(177,5,6,2012,1,0),(178,6,6,2012,1,0),(179,7,6,2012,1,0),(180,8,6,2012,1,0),(181,9,6,2012,1,0),(182,10,6,2012,1,0),(183,11,6,2012,1,0),(184,1,7,2012,1,0),(185,2,7,2012,1,0),(186,3,7,2012,1,0),(187,4,7,2012,1,0),(188,5,7,2012,1,0),(189,6,7,2012,1,0),(190,7,7,2012,1,0),(191,8,7,2012,1,0),(192,9,7,2012,1,0),(193,10,7,2012,1,0),(194,11,7,2012,1,0),(195,1,14,2012,1,0),(196,2,14,2012,1,0),(197,3,14,2012,1,0),(198,4,14,2012,1,0),(199,5,14,2012,1,0),(200,6,14,2012,1,0),(201,7,14,2012,1,0),(202,8,14,2012,1,0),(203,9,14,2012,1,0),(204,10,14,2012,1,0),(205,11,14,2012,1,0),(206,1,8,2011,1,750),(207,2,8,2011,1,300),(208,3,8,2011,1,300),(209,4,8,2011,1,400),(210,5,8,2011,1,400),(211,6,8,2011,1,400),(212,7,8,2011,1,400),(213,8,8,2011,1,400),(214,9,8,2011,1,300),(215,10,8,2011,1,500),(216,11,8,2011,1,4000),(217,12,8,2011,1,6000),(218,13,8,2011,1,3300),(219,10,8,2011,2,900),(220,10,8,2011,3,1300),(221,10,8,2011,5,2000),(222,11,8,2011,2,5400),(223,11,8,2011,3,8000),(224,11,8,2011,5,12000),(225,1,9,2011,1,750),(226,2,9,2011,1,300),(227,3,9,2011,1,300),(228,4,9,2011,1,400),(229,5,9,2011,1,400),(230,6,9,2011,1,400),(231,7,9,2011,1,400),(232,8,9,2011,1,400),(233,9,9,2011,1,300),(234,10,9,2011,1,500),(235,11,9,2011,1,1500),(236,12,9,2011,1,4200),(237,13,9,2011,1,3300),(238,10,9,2011,2,900),(239,10,9,2011,3,1300),(240,10,9,2011,5,2000),(241,11,9,2011,2,1750),(242,11,9,2011,3,2500),(243,11,9,2011,5,4500),(244,1,11,2011,2,700),(245,2,11,2011,2,400),(246,3,11,2011,2,400),(247,4,11,2011,2,500),(248,5,11,2011,2,500),(249,6,11,2011,2,500),(250,7,11,2011,2,500),(251,8,11,2011,2,500),(252,9,11,2011,2,400),(253,10,11,2011,2,400),(254,11,11,2011,2,1250),(255,10,11,2011,3,650),(256,10,11,2011,5,1010),(257,11,11,2011,3,1600),(258,11,11,2011,5,2700),(259,1,1,2011,1,0),(260,2,1,2011,1,0),(261,3,1,2011,1,0),(262,4,1,2011,1,0),(263,5,1,2011,1,0),(264,6,1,2011,1,0),(265,7,1,2011,1,0),(266,8,1,2011,1,0),(267,9,1,2011,1,0),(268,10,1,2011,1,0),(269,11,1,2011,1,0),(270,1,2,2011,1,0),(271,2,2,2011,1,0),(272,3,2,2011,1,0),(273,4,2,2011,1,0),(274,5,2,2011,1,0),(275,6,2,2011,1,0),(276,7,2,2011,1,0),(277,8,2,2011,1,0),(278,9,2,2011,1,0),(279,10,2,2011,1,0),(280,11,2,2011,1,0),(281,1,3,2011,1,0),(282,2,3,2011,1,0),(283,3,3,2011,1,0),(284,4,3,2011,1,0),(285,5,3,2011,1,0),(286,6,3,2011,1,0),(287,7,3,2011,1,0),(288,8,3,2011,1,0),(289,9,3,2011,1,0),(290,10,3,2011,1,0),(291,11,3,2011,1,0),(292,1,4,2011,1,0),(293,2,4,2011,1,0),(294,3,4,2011,1,0),(295,4,4,2011,1,0),(296,5,4,2011,1,0),(297,6,4,2011,1,0),(298,7,4,2011,1,0),(299,8,4,2011,1,0),(300,9,4,2011,1,0),(301,10,4,2011,1,0),(302,11,4,2011,1,0),(303,1,5,2011,1,0),(304,2,5,2011,1,0),(305,3,5,2011,1,0),(306,4,5,2011,1,0),(307,5,5,2011,1,0),(308,6,5,2011,1,0),(309,7,5,2011,1,0),(310,8,5,2011,1,0),(311,9,5,2011,1,0),(312,10,5,2011,1,0),(313,11,5,2011,1,0),(314,1,6,2011,1,0),(315,2,6,2011,1,0),(316,3,6,2011,1,0),(317,4,6,2011,1,0),(318,5,6,2011,1,0),(319,6,6,2011,1,0),(320,7,6,2011,1,0),(321,8,6,2011,1,0),(322,9,6,2011,1,0),(323,10,6,2011,1,0),(324,11,6,2011,1,0),(325,1,7,2011,1,0),(326,2,7,2011,1,0),(327,3,7,2011,1,0),(328,4,7,2011,1,0),(329,5,7,2011,1,0),(330,6,7,2011,1,0),(331,7,7,2011,1,0),(332,8,7,2011,1,0),(333,9,7,2011,1,0),(334,10,7,2011,1,0),(335,11,7,2011,1,0),(336,1,14,2011,1,0),(337,2,14,2011,1,0),(338,3,14,2011,1,0),(339,4,14,2011,1,0),(340,5,14,2011,1,0),(341,6,14,2011,1,0),(342,7,14,2011,1,0),(343,8,14,2011,1,0),(344,9,14,2011,1,0),(345,10,14,2011,1,0),(346,11,14,2011,1,0),(347,1,8,2010,1,750),(348,2,8,2010,1,300),(349,3,8,2010,1,300),(350,4,8,2010,1,400),(351,5,8,2010,1,400),(352,6,8,2010,1,400),(353,7,8,2010,1,400),(354,8,8,2010,1,400),(355,9,8,2010,1,300),(356,10,8,2010,1,500),(357,11,8,2010,1,4000),(358,12,8,2010,1,6000),(359,13,8,2010,1,3300),(360,10,8,2010,2,900),(361,10,8,2010,3,1300),(362,10,8,2010,5,2000),(363,11,8,2010,2,5400),(364,11,8,2010,3,8000),(365,11,8,2010,5,12000),(366,1,9,2010,1,750),(367,2,9,2010,1,300),(368,3,9,2010,1,300),(369,4,9,2010,1,400),(370,5,9,2010,1,400),(371,6,9,2010,1,400),(372,7,9,2010,1,400),(373,8,9,2010,1,400),(374,9,9,2010,1,300),(375,10,9,2010,1,500),(376,11,9,2010,1,1500),(377,12,9,2010,1,4200),(378,13,9,2010,1,3300),(379,10,9,2010,2,900),(380,10,9,2010,3,1300),(381,10,9,2010,5,2000),(382,11,9,2010,2,1750),(383,11,9,2010,3,2500),(384,11,9,2010,5,4500),(385,1,11,2010,2,700),(386,2,11,2010,2,400),(387,3,11,2010,2,400),(388,4,11,2010,2,500),(389,5,11,2010,2,500),(390,6,11,2010,2,500),(391,7,11,2010,2,500),(392,8,11,2010,2,500),(393,9,11,2010,2,400),(394,10,11,2010,2,400),(395,11,11,2010,2,1250),(396,10,11,2010,3,650),(397,10,11,2010,5,1010),(398,11,11,2010,3,1600),(399,11,11,2010,5,2700),(400,1,1,2010,1,0),(401,2,1,2010,1,0),(402,3,1,2010,1,0),(403,4,1,2010,1,0),(404,5,1,2010,1,0),(405,6,1,2010,1,0),(406,7,1,2010,1,0),(407,8,1,2010,1,0),(408,9,1,2010,1,0),(409,10,1,2010,1,0),(410,11,1,2010,1,0),(411,1,2,2010,1,0),(412,2,2,2010,1,0),(413,3,2,2010,1,0),(414,4,2,2010,1,0),(415,5,2,2010,1,0),(416,6,2,2010,1,0),(417,7,2,2010,1,0),(418,8,2,2010,1,0),(419,9,2,2010,1,0),(420,10,2,2010,1,0),(421,11,2,2010,1,0),(422,1,3,2010,1,0),(423,2,3,2010,1,0),(424,3,3,2010,1,0),(425,4,3,2010,1,0),(426,5,3,2010,1,0),(427,6,3,2010,1,0),(428,7,3,2010,1,0),(429,8,3,2010,1,0),(430,9,3,2010,1,0),(431,10,3,2010,1,0),(432,11,3,2010,1,0),(433,1,4,2010,1,0),(434,2,4,2010,1,0),(435,3,4,2010,1,0),(436,4,4,2010,1,0),(437,5,4,2010,1,0),(438,6,4,2010,1,0),(439,7,4,2010,1,0),(440,8,4,2010,1,0),(441,9,4,2010,1,0),(442,10,4,2010,1,0),(443,11,4,2010,1,0),(444,1,5,2010,1,0),(445,2,5,2010,1,0),(446,3,5,2010,1,0),(447,4,5,2010,1,0),(448,5,5,2010,1,0),(449,6,5,2010,1,0),(450,7,5,2010,1,0),(451,8,5,2010,1,0),(452,9,5,2010,1,0),(453,10,5,2010,1,0),(454,11,5,2010,1,0),(455,1,6,2010,1,0),(456,2,6,2010,1,0),(457,3,6,2010,1,0),(458,4,6,2010,1,0),(459,5,6,2010,1,0),(460,6,6,2010,1,0),(461,7,6,2010,1,0),(462,8,6,2010,1,0),(463,9,6,2010,1,0),(464,10,6,2010,1,0),(465,11,6,2010,1,0),(466,1,7,2010,1,0),(467,2,7,2010,1,0),(468,3,7,2010,1,0),(469,4,7,2010,1,0),(470,5,7,2010,1,0),(471,6,7,2010,1,0),(472,7,7,2010,1,0),(473,8,7,2010,1,0),(474,9,7,2010,1,0),(475,10,7,2010,1,0),(476,11,7,2010,1,0),(477,1,14,2010,1,0),(478,2,14,2010,1,0),(479,3,14,2010,1,0),(480,4,14,2010,1,0),(481,5,14,2010,1,0),(482,6,14,2010,1,0),(483,7,14,2010,1,0),(484,8,14,2010,1,0),(485,9,14,2010,1,0),(486,10,14,2010,1,0),(487,11,14,2010,1,0),(488,11,10,2009,1,4000),(489,1,11,2009,2,600),(490,2,11,2009,2,350),(491,3,11,2009,2,350),(492,4,11,2009,2,400),(493,5,11,2009,2,400),(494,6,11,2009,2,400),(495,7,11,2009,2,400),(496,8,11,2009,2,350),(497,9,11,2009,2,350),(498,10,11,2009,2,350),(499,11,11,2009,2,900),(500,1,8,2009,1,500),(501,2,8,2009,1,250),(502,3,8,2009,1,250),(503,4,8,2009,1,300),(504,5,8,2009,1,300),(505,6,8,2009,1,300),(506,7,8,2009,1,300),(507,8,8,2009,1,250),(508,9,8,2009,1,250),(509,10,8,2009,1,400),(510,11,8,2009,1,2000),(511,12,8,2009,1,4300),(512,1,9,2009,1,500),(513,2,9,2009,1,250),(514,3,9,2009,1,250),(515,4,9,2009,1,300),(516,5,9,2009,1,300),(517,6,9,2009,1,300),(518,7,9,2009,1,300),(519,8,9,2009,1,250),(520,9,9,2009,1,250),(521,10,9,2009,1,400),(522,11,9,2009,1,750),(523,12,9,2009,1,3200),(524,1,1,2009,1,0),(525,2,1,2009,1,0),(526,3,1,2009,1,0),(527,4,1,2009,1,0),(528,5,1,2009,1,0),(529,6,1,2009,1,0),(530,7,1,2009,1,0),(531,8,1,2009,1,0),(532,9,1,2009,1,0),(533,10,1,2009,1,0),(534,11,1,2009,1,0),(535,1,2,2009,1,0),(536,2,2,2009,1,0),(537,3,2,2009,1,0),(538,4,2,2009,1,0),(539,5,2,2009,1,0),(540,6,2,2009,1,0),(541,7,2,2009,1,0),(542,8,2,2009,1,0),(543,9,2,2009,1,0),(544,10,2,2009,1,0),(545,11,2,2009,1,0),(546,1,3,2009,1,0),(547,2,3,2009,1,0),(548,3,3,2009,1,0),(549,4,3,2009,1,0),(550,5,3,2009,1,0),(551,6,3,2009,1,0),(552,7,3,2009,1,0),(553,8,3,2009,1,0),(554,9,3,2009,1,0),(555,10,3,2009,1,0),(556,11,3,2009,1,0),(557,1,4,2009,1,0),(558,2,4,2009,1,0),(559,3,4,2009,1,0),(560,4,4,2009,1,0),(561,5,4,2009,1,0),(562,6,4,2009,1,0),(563,7,4,2009,1,0),(564,8,4,2009,1,0),(565,9,4,2009,1,0),(566,10,4,2009,1,0),(567,11,4,2009,1,0),(568,1,5,2009,1,0),(569,2,5,2009,1,0),(570,3,5,2009,1,0),(571,4,5,2009,1,0),(572,5,5,2009,1,0),(573,6,5,2009,1,0),(574,7,5,2009,1,0),(575,8,5,2009,1,0),(576,9,5,2009,1,0),(577,10,5,2009,1,0),(578,11,5,2009,1,0),(579,1,6,2009,1,0),(580,2,6,2009,1,0),(581,3,6,2009,1,0),(582,4,6,2009,1,0),(583,5,6,2009,1,0),(584,6,6,2009,1,0),(585,7,6,2009,1,0),(586,8,6,2009,1,0),(587,9,6,2009,1,0),(588,10,6,2009,1,0),(589,11,6,2009,1,0),(590,1,7,2009,1,0),(591,2,7,2009,1,0),(592,3,7,2009,1,0),(593,4,7,2009,1,0),(594,5,7,2009,1,0),(595,6,7,2009,1,0),(596,7,7,2009,1,0),(597,8,7,2009,1,0),(598,9,7,2009,1,0),(599,10,7,2009,1,0),(600,11,7,2009,1,0),(601,1,14,2009,1,0),(602,2,14,2009,1,0),(603,3,14,2009,1,0),(604,4,14,2009,1,0),(605,5,14,2009,1,0),(606,6,14,2009,1,0),(607,7,14,2009,1,0),(608,8,14,2009,1,0),(609,9,14,2009,1,0),(610,10,14,2009,1,0),(611,11,14,2009,1,0);
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `jds`.`edit_bil`
   BEFORE UPDATE
   ON jds.subscriptiondetails
   FOR EACH ROW
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


      -- if the modified start year > old start year and it is greater then the current year
      -- we just need to update the year in the table
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
         -- if the modified start year < old start year and it is the current year
         -- we just need to send the differential copies to the subscriber

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

      -- if the start month changes and > old month
      -- just update the month
      IF new.startMonth > old.startMonth
      THEN
         UPDATE back_issue_list
            SET active = FALSE
          WHERE     subscription_detail_id = old.id
                AND sent_to_subscriber = FALSE
                AND back_issue_list.month < new.startMonth;
      ELSEIF new.startMonth < old.startMonth
      /*if the new start month is less then old one, then we may need to send him some
        extra copies
      */
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
  
  declare volume_number int ;

  declare dummy int;

  declare done int default 0;



  DECLARE cur1 CURSOR FOR  SELECT t2.journalID,
       t3.month,
       t3.year,
       t3.issue,
       t5.volume_number
  FROM journal_group_contents t2,
       mailing_list t3,
       journal_details t4,
       journal_volume_details t5,
       months t6
 WHERE     t2.journalGroupID = _new_journalGroupID
       AND t2.journalID = t3.journalid
       AND t4.journals_id = t2.journalId
       AND t4.`year` = _new_startYear
       AND t5.journal_details_id = t4.id
       AND t5.start_month = t6.month
       AND t3.month >= _new_startMonth
       AND t3.year = _new_startYear
GROUP BY t2.journalID,
         t3.month,
         t3.year,
         t3.issue,
         t5.volume_number;


  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

  OPEN cur1;

  read_loop: LOOP

    FETCH cur1 into journal_id, _month, _year, issue_number, volume_number;

    IF done = 1 THEN

        LEAVE read_loop;

    END IF;



    insert into back_issue_list(subscription_detail_id,

                                journal_id,

                                back_issue_list.month,

                                back_issue_list.year,

                                copies,

                                issue_number,
                                
                                volume_number,

                                added_on)

                        values(_subscription_detail_id,

                                journal_id,

                                _month,

                                _year,

                                _new_copies,

                                issue_number,
                                
                                volume_number,

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
          group by                    
          mailing_list_detail.journalId, mailing_list_detail.`year`, subscriber_type.institutional, subscriber_type.nationality;






          select sum(mailing_list_detail.copies) into inst_f
          from mailing_list_detail left join subscriber_type on mailing_list_detail.subtypecode = subscriber_type.subtypecode
          where subscriber_type.nationality = 'F' AND subscriber_type.institutional = 'I'
          and mailing_list_detail.`year` = cir_year and subscriber_type.subtype = 'PAID' 
          and mailing_list_detail.journalId = journal_id
          group by                    
          mailing_list_detail.journalId, mailing_list_detail.`year`, subscriber_type.institutional, subscriber_type.nationality;



          select sum(mailing_list_detail.copies) into ind_i
          from mailing_list_detail left join subscriber_type on mailing_list_detail.subtypecode = subscriber_type.subtypecode
          where subscriber_type.nationality = 'I' AND subscriber_type.institutional = 'P'
          and mailing_list_detail.`year` = cir_year and subscriber_type.subtype = 'PAID' 
          and mailing_list_detail.journalId = journal_id
          group by                    
          mailing_list_detail.journalId, mailing_list_detail.`year`, subscriber_type.institutional, subscriber_type.nationality;






          select sum(mailing_list_detail.copies) into ind_f
          from mailing_list_detail left join subscriber_type on mailing_list_detail.subtypecode = subscriber_type.subtypecode
          where subscriber_type.nationality = 'F' AND subscriber_type.institutional = 'P'
          and mailing_list_detail.`year` = cir_year and subscriber_type.subtype = 'PAID' 
          and mailing_list_detail.journalId = journal_id
          group by                    
          mailing_list_detail.journalId, mailing_list_detail.`year`, subscriber_type.institutional, subscriber_type.nationality;



          select sum(mailing_list_detail.copies) into auth
          from mailing_list_detail left join subscriber_type on mailing_list_detail.subtypecode = subscriber_type.subtypecode
          where subscriber_type.subtypecode = 'AUTH'
          and mailing_list_detail.`year` = cir_year
          and mailing_list_detail.journalId = journal_id
          group by                    
          mailing_list_detail.journalId, mailing_list_detail.`year`;



          select sum(mailing_list_detail.copies) into comp
          from mailing_list_detail left join subscriber_type on mailing_list_detail.subtypecode = subscriber_type.subtypecode
          where subscriber_type.subtype = 'FREE'
          and mailing_list_detail.`year` = cir_year
          and mailing_list_detail.journalId = journal_id
          group by                    
          mailing_list_detail.journalId, mailing_list_detail.`year`;        
          
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
          (journalGroupId, journalGroupName, subTypeDesc, `year`, year1) 
          VALUES 
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



        select subscription_rates.rate into price_rate 
          from 
          subscription_rates, subscriber_type 
          where  
          subscription_rates.`year` = cir_year AND subscription_rates.period = 3 
          AND subscription_rates.journalGroupId = journal_gp_id AND subscription_rates.subtypeId = subscriber_type.id 
          and subscriber_type.subtypedesc = sub_type_desc;   


          update temp_sub_rate SET
            year3 = price_rate 
            where 
              journalGroupId = journal_gp_id AND journalGroupName = journal_gp_name 
              AND subTypeDesc = sub_type_desc and `year` = cir_year;



          set price_rate = 0;



        select subscription_rates.rate into price_rate 
          from 
          subscription_rates, subscriber_type 
          where  
          subscription_rates.`year` = cir_year AND subscription_rates.period = 5 
          AND subscription_rates.journalGroupId = journal_gp_id AND subscription_rates.subtypeId = subscriber_type.id 
          and subscriber_type.subtypedesc = sub_type_desc; 

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

-- Dump completed on 2013-01-14 13:46:09
