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
) ENGINE=InnoDB AUTO_INCREMENT=3111 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` VALUES (3102,'1000 CE Amsterdam'),(3094,'199034 St. Petersburg'),(311,'24 Parganas North'),(312,'24 Parganas South'),(3086,'2784-505 Oeiras'),(3096,'70910-900  Brasilia D.F.'),(2934,'Aadepalligudem'),(2959,'Aannd'),(2715,'Abmala'),(1062,'Abohar'),(1581,'Achanputhur'),(969,'Adambakkam'),(388,'Addanki'),(986,'Adilabad'),(1409,'Adimali'),(2545,'Adinathnagar'),(1434,'Adipur'),(2027,'Adirampattinam'),(1602,'Adoni'),(1247,'Adoor'),(793,'Adra'),(2263,'Aduthurai'),(685,'Agartala'),(2499,'Agasteeswaram'),(1,'Agra'),(1853,'Agra Cantt'),(2,'Ahmedabad'),(3075,'Ahmedanad'),(3,'Ahmednagar'),(413,'Aiazawl'),(4,'Aizawl'),(1034,'Aizwal'),(428,'Ajara'),(2371,'Ajitmal'),(5,'Ajmer'),(1973,'Akalkot'),(2625,'Akhada Balapur'),(2843,'Akhnoor'),(3010,'Akluj'),(6,'Akola'),(1640,'Akot'),(2222,'Ala'),(2069,'Alagappanagar'),(2183,'Aland'),(2950,'Alappusha'),(8,'Alappuzha'),(1150,'Alapuzha'),(2253,'Alathur'),(2870,'Ale'),(1563,'Aleppey'),(3089,'Alexandria'),(281,'Alibag'),(7,'Aligarh'),(282,'Aligrah'),(9,'Allahabad'),(2707,'Allahabas'),(1566,'Allahabd'),(10,'Almora'),(3000,'Almorea'),(2520,'Along'),(1952,'Alore'),(845,'Aluva'),(11,'Alwar'),(1678,'Alwarkurichi'),(462,'Alwarkuruchi'),(2599,'Alwasa'),(900,'Alwaye'),(675,'Amalapuram'),(724,'Amalner'),(1941,'Amaravati'),(1534,'Amarvati'),(2013,'Ambad'),(2387,'Ambah'),(1873,'Ambajogai'),(283,'Ambala'),(3028,'Ambala Cant'),(792,'Ambala Cantt'),(2749,'Ambala Cantt.'),(825,'Ambala City'),(2015,'Ambalavayal'),(12,'Ambattur'),(2192,'Ambav'),(13,'Ambernath'),(606,'Amberpet'),(284,'Ambikapur'),(2158,'Ambilikka'),(2057,'Ambur'),(2609,'Amdedabad'),(2095,'Amethi'),(2675,'Amgaon'),(2544,'Amla'),(2589,'Amlagora'),(2051,'Ammandivillai'),(1755,'Amraavati'),(14,'Amravati'),(416,'Amreli'),(15,'Amritsar'),(3026,'Amroha'),(1954,'Amta'),(382,'Anakapalle'),(579,'Anakapalli'),(2159,'Anakkayam'),(935,'Ananatapur'),(285,'Anand'),(1864,'Anandapur'),(2261,'Anandpur Sahib'),(2540,'Anandwan'),(16,'Anantapur'),(1511,'Ananthapur'),(2837,'Ananthpur'),(286,'Anantnag'),(2956,'Anaparthi'),(595,'Anchal'),(2742,'Andal'),(2994,'Andaman'),(1172,'Anekal'),(1235,'Angadikadavu'),(769,'Angamally'),(2367,'Angamaly'),(333,'Angul'),(356,'Anguli'),(2543,'Ankaleshwar'),(868,'Ankleshwar'),(2231,'Ankola'),(629,'Annamalai'),(334,'Annamalai Nagar'),(314,'Annamalainagar'),(1450,'Annur'),(2052,'Anoopshahr'),(2643,'Anumala'),(2751,'Anupgarh'),(754,'Anupuram'),(1530,'Anvardhikanpet'),(2761,'Aonla'),(702,'Ara'),(2229,'Arabhavi'),(2209,'Arachalur'),(777,'Arakkonam'),(1661,'Arakkulam'),(949,'Arakkunnam'),(2266,'Arakulam'),(17,'Araleri'),(2892,'Aralvaymoli'),(2698,'Aralvoimozhi'),(18,'Arambagh'),(637,'Araria'),(2701,'Arasampatti'),(2379,'Arasikere'),(1584,'Aravayal'),(968,'Areacode'),(1561,'Ariyalur'),(699,'Ariyannur'),(2558,'Armoor'),(2118,'Armori'),(19,'Arrah'),(404,'Arsikere'),(1687,'Arumanai'),(1327,'Arunapuram'),(814,'Aruppukottai'),(2198,'Aruvankadu'),(653,'Aryapur'),(20,'Asansol'),(886,'Ashoknagar'),(560,'Astabad Itarsi'),(1906,'Aswaraopet'),(1460,'AT & P.O.Barh'),(1181,'Atarra'),(2917,'Athani'),(1823,'Athens'),(456,'Athgarh'),(2681,'Atkot'),(442,'Atpadi'),(2849,'Attabira'),(673,'Attingal'),(763,'Attoor'),(531,'Attur'),(681,'Atul'),(1956,'Aundipatti'),(979,'Auraiya'),(21,'Aurangabad'),(1420,'Auroville'),(22,'Avadi'),(2606,'Avidi'),(1860,'Avikanagar'),(1987,'Avinashi'),(2403,'Awantipora'),(1444,'Ayodhya'),(2005,'Ayur'),(1200,'Ayyanthole'),(996,'Azamgarh'),(2395,'Aziznagar'),(2602,'B.G. Nagar'),(1408,'Badagara'),(2391,'Badami'),(3024,'Badchiroli'),(2181,'Baddi'),(287,'Badlapur'),(2779,'Badmal'),(1531,'Badnera'),(441,'Badshahithaul'),(1365,'Badvel'),(619,'Bagalkot'),(1193,'Bagar'),(1089,'Bagdogra'),(801,'Bagepalli'),(1669,'Bagepally'),(3099,'Baghdad'),(1773,'Baghpat'),(1643,'Baghra'),(712,'Bagudi'),(2556,'Bahadurgarh'),(2360,'Bahal'),(2575,'Bahona'),(791,'Bahraich'),(358,'BaihataChariali'),(1184,'Baijnath'),(880,'Bailhongal'),(2002,'Bakewar'),(2871,'Bakhtiarpur'),(2070,'Bakrol'),(2422,'Baksa (BTAD)'),(2463,'Baladmari'),(288,'Balaghat'),(924,'Balangir'),(621,'Balasore'),(1220,'Balikuda'),(1208,'Balisahi'),(2473,'Ballabgarh'),(2038,'Ballarpur'),(1854,'Ballary'),(484,'Ballia'),(23,'Bally'),(2366,'Balod'),(342,'Balrampur'),(392,'Balurghat'),(1245,'Baluti'),(2657,'Bamkhed'),(1700,'Banaskantha'),(1424,'Banasthali'),(2693,'Banaswada'),(750,'Banda'),(1426,'Bandipora'),(1711,'Banga'),(1038,'Bangaaore'),(24,'Bangarpet'),(2043,'Banikhet'),(1406,'Banipur'),(2518,'Banka'),(504,'Bankalagi'),(2306,'Banki'),(1613,'Bankpara'),(341,'Bankura'),(1105,'Banswara'),(2728,'Bantalab'),(1122,'Bantiwal'),(888,'Bantwal'),(1330,'Bapatla'),(1785,'Barabanki'),(577,'Baramati'),(1262,'Baramulla'),(25,'Baranagar'),(3071,'Barapani'),(476,'Barasat'),(2780,'Barauni'),(674,'Baraut'),(2328,'Bardez'),(26,'Bardhaman'),(556,'Bardoli'),(27,'Bareilly'),(304,'Bareli'),(2381,'Barelly'),(1719,'Bargarh'),(2705,'Bargur'),(1518,'Barharwa'),(2527,'Baridh Colony'),(28,'Baripada'),(1251,'Barmer'),(802,'Barnala'),(399,'Barpeta'),(667,'Barrackpore'),(3068,'Barrackpore P.O.'),(651,'Barshi'),(2354,'Baru Sahib'),(2988,'Basanti'),(1766,'Basirhat'),(1440,'Basmath'),(1448,'Bastar'),(1091,'Basti'),(1642,'Basudevpur'),(1524,'Batala'),(29,'Bathinda'),(1454,'Baxi Bazar'),(1360,'Bazpur'),(2949,'Beawar'),(1143,'Beed'),(2492,'Beekar'),(2121,'Beerapalli'),(860,'Begusarai'),(2658,'Bela'),(1830,'Belagavi'),(2100,'Belati'),(3048,'Belavavi'),(2973,'Belda'),(30,'Belgaum'),(31,'Bellary'),(1726,'Belthangadi'),(1537,'Belthangady'),(2985,'Belur Math'),(1819,'Bemetara'),(32,'Bengaluru'),(2684,'Benjanapadavu'),(954,'Berhampore'),(33,'Berhampur'),(3093,'Bethesda, MD 20814'),(1357,'Bethuadahari'),(455,'Bettiah'),(1129,'Betul'),(368,'Bhabua'),(1146,'Bhadohi'),(2373,'Bhadrachalam'),(678,'Bhadrak'),(1296,'Bhadravathi'),(1387,'Bhadravati'),(2529,'Bhadsen'),(34,'Bhagalpur'),(3031,'Bhagur'),(1902,'Bhaila'),(2075,'Bhalki'),(588,'Bhandara'),(1632,'Bhanur'),(1391,'Bharathi Nagara'),(1575,'Bharathinagara'),(2197,'Bharathpur'),(35,'Bharatpur'),(2788,'Bharkatia'),(483,'Bharuch'),(1231,'Bhatapara'),(2781,'Bhathinda Cantt'),(1611,'Bhatkal'),(2256,'Bhatoli'),(36,'Bhatpara'),(1068,'Bhavanisagar'),(37,'Bhavnagar'),(811,'Bhawanipatna'),(2918,'Bhilad'),(38,'Bhilai'),(1050,'Bhilai Nagar'),(2135,'Bhilainagar'),(1577,'Bhillai'),(39,'Bhilwara'),(1095,'Bhimavaram'),(1934,'Bhimtal'),(2424,'Bhind'),(40,'Bhiwandi'),(846,'Bhiwani'),(2814,'Bhiwari'),(289,'Bhojpur'),(1087,'Bhongaon'),(1988,'Bhongir'),(2024,'Bhoom'),(41,'Bhopal'),(2243,'Bhor'),(3020,'Bhtakumarada'),(42,'Bhubaneswar'),(43,'Bhuj'),(2922,'Bhuj-Kachchh'),(2920,'Bhuj-Kutch'),(1554,'Bhunbaneswar'),(843,'Bhusawal'),(2978,'Bicholim'),(1912,'Bidadi'),(44,'Bidar'),(45,'Bidhan Nagar'),(502,'Bidri'),(46,'Bihar Sharif'),(47,'Bijapur'),(718,'Bijhari'),(774,'Bijnor'),(2782,'Bijpur'),(48,'Bikaner'),(3041,'Bilagi'),(2612,'Bilahongala'),(665,'Bilai'),(49,'Bilaspur'),(1685,'Bilimora'),(290,'Bina'),(2777,'Binnaguri'),(540,'Birbhum'),(1237,'Bishnupur'),(2150,'Bobbili'),(2542,'Bodinayakanur'),(990,'Boisar'),(50,'Bokaro'),(437,'Bokaro Thermal'),(798,'Bolangir'),(3054,'Bolangr'),(912,'Bolpur'),(2110,'Bomdila'),(2448,'Bonaigarh'),(707,'Bongaigaon'),(1662,'Borai'),(1142,'Bordez'),(2316,'Bordi'),(2137,'Boriavi'),(2936,'Boudh'),(879,'Boudh  Dist.'),(52,'Brahmapur'),(1904,'Brahmapuri'),(2591,'Brahmavar'),(2417,'Bssti'),(2616,'Bud Bud'),(817,'Budaun'),(357,'Buddhnagar'),(2659,'Budgam'),(1960,'Budhagaya'),(1692,'Bulandshahar'),(1356,'Bulandshahr'),(457,'Buldana'),(3016,'Buldhana'),(51,'Burdwan'),(1599,'Burhanpur'),(1684,'Burhar'),(738,'Burla'),(735,'Burnpur'),(2799,'Bylakuppe'),(3050,'Cachar'),(505,'Calcutta'),(3080,'California 94720'),(3088,'Cambridge CB2 3PY'),(1690,'Canacona'),(421,'Canchipur'),(360,'Cannanore'),(1970,'Canning Town'),(2450,'Chaibasa'),(981,'Chaimpal'),(548,'Chaklashi'),(3013,'Chakradharpur'),(2223,'Chalakudy'),(689,'Chalala'),(1024,'Chalisgaon'),(1689,'Challakere'),(852,'Chamarajanagar'),(3027,'Chamarajanagara'),(2768,'Chamba'),(2270,'Chamoli'),(2670,'Champa'),(2237,'Champadanga'),(2662,'Champakulam'),(1694,'Champaran'),(3039,'Champawat'),(2862,'Champua'),(1475,'Chamurchi'),(2493,'Chanasma'),(671,'Chandannagar'),(760,'Chandausi'),(2414,'Chandel'),(2692,'Chandeshwar'),(53,'Chandigarh'),(1496,'Chandimandir'),(1636,'Chandpur'),(54,'Chandrapur'),(2486,'Chandrapura'),(1949,'Chandwad'),(2830,'Changa'),(827,'Changanacherry'),(1103,'Changanachery'),(383,'Changancherry'),(1012,'Changigarh'),(1278,'Channagiri'),(2847,'Channai'),(829,'Channapatna'),(365,'Channarayapatna'),(566,'Chapra'),(2745,'Charbatia'),(559,'Chariali'),(1891,'Charkhi Dadri'),(2507,'Charmapuri'),(2634,'Chavakkad'),(2348,'Chavara'),(2275,'Chemperi'),(2694,'Chemudugunta'),(439,'Chenbalam'),(2268,'Chengalpattu'),(424,'Chengalpet'),(1504,'Chengam'),(422,'Chengannur'),(327,'Chenglepet'),(2790,'Chengottoor'),(55,'Chennai'),(2489,'Chennaraopet'),(1707,'Chennimalai'),(2669,'Chernmahadevi'),(401,'Cherpu'),(1069,'Cherthala'),(1835,'Cheruthuruthy'),(1838,'Chettalli'),(2333,'Chettinad'),(2608,'Chevalla'),(1283,'Chevayur'),(1885,'Chevella'),(869,'Cheyyar'),(952,'Chhatarpur'),(291,'Chhindwara'),(2290,'Chhota Udepur'),(2735,'Chianki'),(1418,'Chicalim'),(1674,'Chickballapur'),(2587,'Chickkaballapur'),(3005,'Chickmagalore'),(804,'Chickmagalur'),(2894,'Chickmangore'),(56,'Chidambaram'),(2688,'Chikani'),(1486,'Chikballapur'),(2133,'Chikhaldara'),(2970,'Chikhali'),(1943,'Chikhli'),(1037,'Chikkaballapur'),(3047,'Chikkamagalur'),(2510,'Chikkanahalli'),(2514,'Chikmagalooru'),(292,'Chikmagalur'),(1004,'Chikodi'),(1940,'Chilakaluripet'),(2757,'Chilka'),(2906,'Chimakurthy'),(1870,'China Amiram'),(2364,'Chincholi'),(2174,'Chinna Salem'),(1741,'Chinnasalem'),(2553,'Chinoutapally'),(662,'Chinsurah'),(1137,'Chintamani'),(293,'Chiplun'),(789,'Chirala'),(2952,'Chirang'),(1942,'Chirawa'),(1783,'Chirmiri'),(2479,'Chitorgarh'),(2567,'Chitradurg'),(343,'Chitradurga'),(1402,'Chitrakoot'),(2671,'Chittivalasa'),(528,'Chittode'),(57,'Chittoor'),(641,'Chittor'),(917,'Chittorgarh'),(2639,'Chiyyedu'),(2647,'Choondacherry'),(2766,'Chopan'),(784,'Chorvad'),(2131,'Chowdavaram'),(2196,'Chumukedima'),(397,'Chundambatta'),(2055,'Chunkankadai'),(2468,'Churachandpur'),(1045,'Churu'),(1760,'Coch in'),(412,'Cochin'),(58,'Coimbatore'),(2559,'Coimbatyore'),(2497,'Colaghat'),(3082,'Colombo  7'),(3105,'Columbus Ohio'),(1513,'Combum'),(561,'Contai'),(796,'Cooch Behar'),(2610,'Coochbehar'),(575,'Coonoor'),(1064,'Courtallam'),(3110,'CT'),(586,'Cuddalore'),(1462,'Cuddapah'),(361,'Cumbum'),(2979,'Curchorem'),(59,'Cuttack'),(1762,'Cuttak'),(1829,'Dabhoi'),(3004,'Dadri'),(2891,'Dahivel'),(2383,'Dahiwadi'),(1438,'Dahod'),(1574,'Daksin Dinajpur'),(2430,'Daldali'),(1055,'Dalhousie'),(3018,'Dallhousie'),(2504,'Dalli Rajhara'),(1708,'Dalmianagar'),(1430,'Daltonganj'),(700,'Daman'),(1730,'Daman and Diu'),(1843,'Damanjodi'),(1215,'Damoh'),(1600,'Dandeli'),(1593,'Dantewada'),(2940,'Dantiwada'),(1084,'Dapoli'),(60,'Darbhanga'),(432,'Darjeeling'),(1382,'Darrang'),(1086,'Darwha'),(1991,'Dasuya'),(864,'Datia'),(1230,'Dausa'),(61,'Davanagere'),(3030,'Davanagrer'),(62,'Davangere'),(2975,'Debari'),(1481,'Debinagar'),(1295,'Deepshikha'),(1224,'Deepsikha'),(2247,'Degloor'),(3036,'Dehardun'),(63,'Dehradun'),(609,'Dehrudun'),(313,'Delhi'),(2523,'Deogarh'),(1145,'Deoghar'),(2369,'Deola'),(2955,'Deolali Camp'),(64,'Deoli'),(2252,'Deori'),(719,'Deoria'),(815,'Deralakatta'),(543,'Deralakatte'),(2077,'Dev Sangha'),(363,'Devakottai'),(2245,'Devanahalli'),(2122,'Devarakonda'),(2331,'Devgad'),(790,'Devlali'),(2047,'Devrukh'),(65,'Dewas'),(1417,'Dhakuakhana'),(1085,'Dhalavalpuram'),(1388,'Dhamangaon'),(1139,'Dhamisa'),(2972,'Dhamtar'),(1033,'Dhamtari'),(66,'Dhanbad'),(757,'Dhar'),(1825,'Dharampura'),(2878,'Dharampuram'),(834,'Dharamsala'),(2565,'Dharapuram'),(1618,'Dharbhanga'),(1439,'Dharmabad'),(332,'Dharmanagar'),(329,'Dharmapuri'),(1672,'Dharmasthala'),(1280,'Dharmavaram'),(753,'Dharmsala'),(67,'Dharwad'),(741,'Dharwar'),(1930,'Dhaulakuan'),(725,'Dhemaji'),(944,'Dhenkanal'),(1896,'Dhilwan'),(2188,'Dhing'),(499,'Dholka'),(1133,'Dholpur'),(1691,'Dhrol'),(2411,'Dhubri'),(68,'Dhule'),(2386,'Dhulipalla'),(2396,'Dhupguri'),(3049,'Dhuri (Sangrur)'),(2190,'Diamond Harbour'),(1072,'Dibiyapur'),(364,'Dibrugarh'),(2974,'Didhihat'),(551,'Didwana'),(1161,'Digapahandi'),(2586,'Digvijaygram'),(1007,'Dikrong'),(913,'Dimapur'),(2109,'Dimpapur'),(1147,'Dinajpur'),(2721,'Dinanagar'),(522,'Dindigal'),(513,'Dindigul'),(470,'Dindlod'),(2791,'Dindori'),(1585,'Dingigul'),(1778,'Diphu'),(2106,'Dirang'),(69,'Doddaballapur'),(2817,'Doddaballapura'),(563,'Doimukh'),(1097,'Dombivali'),(70,'Dombivili'),(736,'Dombiville East'),(765,'Dombivli'),(2277,'Dombivli (E)'),(1747,'Dombivli (W)'),(1119,'Dombivli East'),(71,'Dona Paula'),(2437,'Dongargarh'),(2755,'Donimalai'),(2703,'Doraha'),(3042,'Dousa'),(778,'Dudhondi'),(1113,'Dudhya'),(1378,'Dujana'),(1445,'Duliajan'),(2216,'Dumehar Bani'),(1075,'Dumka'),(2347,'Dumkal'),(1560,'Dumraon'),(2162,'Dundlod'),(1498,'Dungarpur'),(72,'Durg'),(73,'Durgapur'),(1569,'Durgpur'),(2101,'Dwarahat'),(1764,'Dwarka'),(2925,'E.G.Dist'),(890,'E.Godavari'),(603,'Eachome'),(1429,'Eambalam'),(1121,'East Godavari'),(1579,'East Siang'),(2444,'East Sikkim'),(2717,'East-Sikkim'),(1814,'Eastgodavari'),(1019,'Edat'),(74,'Edathala'),(2257,'Edathua'),(1872,'EG Dist'),(999,'Egra'),(2718,'Elagiri Hills'),(998,'Elamdesom'),(1190,'Elavunthitta'),(2025,'Elayampalayam'),(2217,'Elthuruth'),(1723,'Eluro'),(1287,'Eluru'),(2200,'Enathi'),(1432,'Erairimangalam'),(2037,'Erandol'),(903,'Erintalmanna'),(2447,'Ernakula'),(75,'Ernakulam'),(324,'Erode'),(516,'Eroor North'),(1233,'Errattupetta'),(2026,'Erumapatty'),(1421,'Erumeli'),(2873,'Esanthimangalam'),(1337,'Etah'),(76,'Etawah'),(386,'Ettumanoor'),(1339,'Ettuvaicode'),(339,'Faizabad'),(1968,'Faizpur'),(1887,'Farah'),(1538,'Faribabad'),(77,'Faridabad'),(1851,'Faridkot'),(1082,'Faridpur'),(78,'Farrukhabad'),(2971,'Fatehabad'),(1645,'Fatehgarh'),(2622,'Fatehgarh Sahib'),(1212,'Fatehpur'),(2716,'Ferozapur'),(495,'Ferozepur'),(2907,'Ferozpur'),(3079,'Firenze  50131'),(79,'Firozabad'),(2092,'FPO'),(2850,'G Vidyanagar'),(2401,'G.B. Palayam'),(749,'Gadag'),(1630,'Gadag Betageri'),(805,'Gadag Betgeri'),(3074,'Gadanki'),(2090,'Gadarwara'),(943,'Gadchiroli'),(2402,'Gadhinglaj'),(2160,'Gadohiroli'),(2615,'Gagra'),(2840,'Gagrigol'),(1720,'Gajapati'),(2677,'Ganapathipuram'),(1666,'Ganapavaram'),(1185,'Gandhigram'),(80,'Gandhinagar'),(1367,'Gandhinagarn'),(1269,'Gandhinglj'),(2053,'Ganeshguri'),(2029,'Gangakhed'),(2976,'Gangapur'),(2607,'Gangarampalayam'),(1111,'Gangtok'),(2954,'Ganguru'),(2455,'Ganj Basoda'),(1573,'Ganjam'),(858,'Ganjam Dist.'),(2530,'Ganjar'),(1759,'Gannavaram'),(1677,'Ganpat Ganj'),(3072,'Gantok'),(2877,'Garchiroli'),(1977,'Garhdiwala'),(2789,'Garhi'),(808,'Garhwal'),(481,'Gauhati'),(756,'Gauribidanur'),(558,'Gawahati'),(81,'Gaya'),(2269,'Gevrai'),(3053,'Gharuan'),(1000,'Ghatanji'),(2021,'Ghatkesar'),(82,'Ghaziabad'),(429,'Ghazipur'),(1918,'Ghedradi'),(1955,'Ghogaon'),(1544,'Gidderbaha'),(635,'Giridih'),(410,'Goa'),(1376,'Goalpara'),(1449,'Gobi'),(3062,'Gobindgarh'),(1840,'Godavarikhani'),(2244,'Godda'),(984,'Godhra'),(3043,'Gohana'),(2445,'Gohang'),(695,'Gohpur'),(2249,'Gokak'),(1314,'Gokarn'),(1588,'Gola Kheri'),(2778,'Golabandha'),(479,'Golaghat'),(1078,'Golghat'),(2538,'Gollalamamidada'),(781,'Gonda'),(1053,'Gondia'),(2406,'Goniana Mandi'),(2359,'Gonikoppal'),(2676,'Gooty'),(1641,'Gopalbazar'),(83,'Gopalpur'),(1939,'Gopalpur-on-Sea'),(838,'Gopalpuri'),(2660,'Gopeshwar'),(84,'Gorakhpur'),(2423,'Goregaon'),(468,'Gossaigaon'),(2823,'Gowribidanur'),(929,'Greater Noida'),(85,'Gubbi'),(2990,'Gudalur'),(1753,'Gudavalli'),(2819,'Gudibande'),(795,'Gudivada'),(1886,'Gudiyattam'),(2440,'Gudlavalleru'),(772,'Gudur'),(2942,'Gujapati'),(2040,'Gulabpura'),(2555,'Gulaothi'),(86,'Gulbarga'),(2089,'Guledagudda'),(2304,'Gulmarg'),(604,'Gummidi Poondi'),(553,'Guna'),(2457,'Gunjoti'),(1030,'Guntakal'),(87,'Guntur'),(1443,'Gunupur'),(644,'Guragon'),(1274,'Gurdaspur'),(88,'Gurgaon'),(2685,'Gurusar Sadar'),(2281,'Gurusar Sadhar'),(1329,'Guruvayur'),(1302,'Gusiahati'),(2722,'Guskara'),(89,'Guwahati'),(1802,'Guwajati'),(90,'Gwalior'),(1258,'Gyanpur'),(347,'H.S.Chandrapur'),(3017,'Habra'),(2594,'Hadgarh'),(2242,'Haflong'),(1400,'Hailakandi'),(855,'Hajipur'),(2604,'Haldi'),(1291,'Haldia'),(1787,'Haldwani'),(2712,'Haliyala'),(899,'Halkanangale'),(1967,'Halkarni'),(2177,'Halol'),(2760,'Halwara'),(2111,'Hamiprur'),(643,'Hamirpur'),(743,'Hanamkonda'),(1809,'Hansi'),(914,'Hanumanakonda'),(1307,'Hanumangarh'),(91,'Hapur'),(761,'Harapanahalli'),(1739,'Harbin'),(1798,'Harda'),(687,'Hardoi'),(785,'Hardwar'),(449,'Haridwar'),(1248,'Harihar'),(2139,'Harilakandi'),(1487,'Harinavi'),(1207,'Haripal'),(2763,'Harni Road'),(3083,'Harpenden Herts  A15 2JQ'),(3058,'Harur'),(598,'Haryana'),(1523,'Hasimara'),(92,'Hassan'),(1043,'Hathras'),(1616,'Hatiara'),(831,'Hatundi'),(2868,'Haveli'),(2506,'Haveli Ghanapur'),(1011,'Haveri'),(1461,'Hawal'),(2741,'Hayuliang'),(1610,'Hazarbag'),(377,'Hazaribag'),(523,'Hazratbal'),(3067,'Hebbagodi'),(3077,'Herts. SG1 2AY'),(1815,'Herwatta Kumta'),(1515,'Himantnagar'),(1236,'Himatnagar'),(2772,'Himmatnagar'),(1606,'Hindaun'),(419,'Hindupur'),(1469,'Hingoli'),(426,'Hiriadka'),(1750,'Hiriyur'),(2961,'Hiryur'),(93,'Hisar'),(748,'Hissar'),(1364,'Holanagadde'),(622,'Honnavar'),(349,'Hooghly'),(2987,'Hoogly'),(607,'Hosadurga'),(94,'Hosapete'),(512,'Hoshangabad'),(488,'Hoshiarpur'),(2824,'Hoskote'),(374,'Hospet'),(500,'Hosur'),(95,'Howrah'),(315,'Hridaypur'),(96,'Hubballi-Dharwad'),(487,'Hubli'),(1771,'Huderabad'),(2208,'Hulakoti'),(2654,'Humnabad'),(2572,'Hunagunda'),(2409,'Hungund'),(1837,'Hunsur'),(1395,'Hurda'),(1463,'Hutti P.O.'),(2736,'Huvinahadagali'),(2508,'Huzurabad'),(97,'Hyderabad'),(3065,'Hyderabad 500 075'),(1763,'Hyderanad'),(1758,'Hyderbad'),(1352,'Hyderqabad'),(1754,'Hydrabad'),(2220,'Ibrahimpatnam'),(98,'Ichalkaranji'),(626,'Ichlampady'),(2000,'Iduki'),(706,'Idukki'),(2298,'Ilakal'),(770,'Ilayangudi'),(646,'Ilhas'),(1553,'Ilhas Tiswani'),(1158,'Ilkal'),(99,'Imphal'),(506,'Imphal East'),(2436,'Indapur'),(1998,'Indirapuram'),(101,'Indore'),(2752,'Indunagar'),(1206,'Inodre'),(3109,'Iowa'),(731,'Irimpanam'),(587,'Irinjalakuda'),(2439,'Israna'),(574,'Isukkazhi'),(2180,'Itachuna'),(100,'Itanagar'),(2804,'Itarsi'),(1911,'Iyyengarkulam'),(2754,'Izat Nagar'),(541,'Izatnagar'),(102,'Jabalpur'),(1240,'Jadar'),(863,'Jadavpur'),(1507,'Jagadalpur'),(2431,'Jagadhri'),(2313,'Jagatballavpur'),(1547,'Jagatsinghpur'),(973,'Jagdalpur'),(2629,'Jagdishpur'),(2476,'Jagiroad'),(1849,'Jagraon'),(1155,'Jagtial'),(2982,'Jahanabad'),(2385,'Jaipru'),(103,'Jaipur'),(2641,'Jaipur Cantt'),(1757,'Jaisalmer'),(1306,'Jaitaran'),(1117,'Jajpur'),(2063,'Jakkasandra'),(104,'Jalandhar'),(2285,'Jalandhar Cantt'),(1752,'Jalaun'),(2998,'Jalesar'),(105,'Jalgaon'),(2938,'Jalgoan'),(106,'Jalna'),(650,'Jalpaiguri'),(937,'Jamalpur'),(2836,'Jamer'),(2962,'Jamkhani'),(2127,'Jamkhed'),(2107,'Jammikunta'),(107,'Jammu'),(1735,'Jammu & Kashmir'),(2786,'Jammu Cantt.'),(452,'Jammu Tawi'),(108,'Jamnagar'),(2163,'Jamner'),(1326,'Jamnipali'),(1232,'Jamnipalli'),(109,'Jamshedpur'),(759,'Jangaon'),(1875,'Janjgir'),(1874,'Janjgir-Champa'),(1127,'Jannur'),(1187,'Jaora'),(758,'Jarangdih Col'),(1313,'Jatharpeth'),(402,'Jaugaon'),(1792,'Jaumpur'),(520,'Jaunpur'),(729,'Jayant'),(1456,'Jayasingpur'),(2571,'Jaypore'),(2711,'Jaysingpur'),(634,'Jehanabad'),(1738,'Jerusalem'),(1254,'Jeypore'),(3006,'Jhabua'),(1010,'Jhajhar'),(1614,'Jhajjar'),(1539,'Jhalawar'),(1167,'Jhalgaon'),(110,'Jhansi'),(2443,'Jharia'),(1427,'Jharipani'),(420,'Jharkhand'),(1416,'Jharsugna'),(1009,'Jharsuguda'),(1646,'Jhinihak'),(2332,'Jhinkpani'),(309,'Jhunjhunu'),(1271,'Jind'),(2103,'Jintur'),(1312,'Jitpur'),(726,'Jobner'),(111,'Jodhpur'),(498,'Jogbani'),(1557,'Jogfalls'),(2733,'Jogindar Nagar'),(1228,'Jognbani'),(545,'Jorhat'),(2765,'Joshimath'),(1350,'Jowai'),(2456,'Joysagar'),(1900,'JP Nagar'),(661,'Junagadh'),(2321,'Junnar'),(591,'Jyotivihar'),(2534,'K Bandarapalli'),(2363,'K R Nagar'),(867,'K.G.F'),(836,'K.G.F.'),(2049,'K.M. Doddi'),(2453,'K.R. Nagar'),(2114,'K.R. Pet'),(1890,'Kada'),(2184,'Kadakkal'),(2339,'Kadakom'),(571,'Kadalundi'),(1256,'Kadamtala'),(112,'Kadapa'),(1728,'Kadara'),(1027,'Kadayanallur'),(2554,'Kadegaon'),(1310,'Kadiri'),(387,'Kadirur'),(1174,'Kadur'),(2500,'Kagithapuram'),(2264,'Kahalgaon'),(1863,'Kahn Pur Khui'),(713,'Kailashahar'),(2346,'Kaipattoor'),(659,'Kaithal'),(2833,'Kakanpur'),(2834,'Kakching'),(113,'Kakinada'),(2636,'Kakkad'),(128,'Kalady'),(2915,'Kalagampudi'),(946,'Kalahandi'),(2775,'Kalaikunda'),(1001,'Kalamassery'),(493,'Kalamb'),(1446,'Kalanour P.O'),(1081,'Kalapet'),(362,'Kalavai'),(2825,'Kalavakkam'),(2860,'Kalayarkoil'),(1879,'Kalburgi'),(916,'Kaliakavilai'),(2309,'Kalianpur'),(2044,'Kalimpong'),(2704,'Kalipatti'),(1931,'Kalippatti'),(2645,'Kaliyaganj'),(480,'Kaliyakavillai'),(2898,'Kalka'),(1499,'Kallachi'),(720,'Kalladka'),(1681,'Kallakurchi'),(2611,'Kallakurichi'),(2839,'Kallanthode'),(1393,'Kalliassery PO'),(1910,'Kallikkandy'),(1932,'Kallooppara'),(965,'Kallur'),(1649,'Kalmijore'),(2880,'Kalol'),(2924,'Kalol (NG)'),(114,'Kalpakkam'),(1774,'Kalpet'),(2633,'Kalpetta'),(832,'Kalugumalai'),(1480,'Kalui'),(1279,'Kalwa'),(2368,'Kalwan'),(647,'Kalyan'),(1749,'Kalyan (E)'),(1619,'Kalyan (W)'),(1059,'Kalyan (West)'),(1746,'Kalyan East'),(1546,'Kalyan Nagar'),(623,'Kalyan West'),(115,'Kalyan-Dombivali'),(116,'Kalyani'),(2322,'Kamakhyanagar'),(2859,'Kamalpur'),(117,'Kamarhati'),(658,'Kambhaladinne'),(1653,'Kampa'),(2151,'Kamptee'),(1197,'Kamrup'),(851,'Kanakapura'),(1257,'Kanale'),(2969,'Kanayakumari'),(1715,'Kancheepuram'),(1745,'Kanchi'),(2031,'Kanchikacherla'),(2613,'Kanchipadi'),(359,'Kanchipuram'),(818,'Kanchrapara'),(2032,'Kandaghat'),(1732,'Kandhamala'),(2046,'Kandhar'),(692,'Kandhla'),(1665,'Kandhwara'),(318,'Kandukur'),(2022,'Kangayam'),(1501,'Kangirapally'),(1021,'Kangra'),(458,'Kanhangad South'),(987,'Kanikapada'),(1591,'Kaniyakumari'),(1281,'Kaniyur'),(1057,'Kanjeepuram'),(497,'Kanjirapally'),(454,'Kanker'),(1605,'Kankipadu'),(1601,'Kankroli'),(2361,'Kannad'),(1721,'Kannauj'),(1375,'Kanniampuram'),(348,'Kannur'),(3022,'Kanour'),(118,'Kanpur'),(1343,'Kantore'),(2926,'Kanuru'),(2882,'Kanya Kumari'),(3012,'Kanyakumar'),(119,'Kanyakumari'),(1586,'Kapurthala'),(1374,'Kapurthaza'),(697,'Karad'),(988,'Karadi'),(813,'Karaikal'),(120,'Karaikkudi'),(403,'Karaikudi'),(2865,'Karakambadi'),(2672,'Karakikudi'),(655,'Karamsad'),(1914,'Karanja'),(1989,'Karatadipalayam'),(1714,'Karauli'),(1060,'Karayamuttom'),(1742,'Karbi Anglog'),(982,'Karbi Anglong'),(1919,'Karepally'),(2452,'Kariapatti'),(872,'Kariavattom'),(2213,'Karigiri'),(2138,'Karikkad'),(2079,'Karimbam'),(384,'Karimganj'),(121,'Karimnagar'),(2483,'Karimpur'),(2351,'Karjat'),(2126,'Karkala'),(2340,'Karma'),(1324,'Karnal'),(1509,'Karnya'),(857,'Karopady'),(2484,'Karottukara'),(1775,'Karouli'),(1065,'Karukachal'),(894,'Karukutty'),(2011,'Karumathur'),(2308,'Karungal'),(2365,'Karunguzhi'),(371,'Karur'),(1166,'Karvenagar'),(1239,'Karwar'),(438,'Kasaragod'),(764,'Kasargod'),(451,'Kasargode'),(610,'Kasauli'),(2412,'Kasganj'),(581,'Kashipur'),(501,'Kashmir'),(1521,'Kasibugga'),(1473,'Kathgodam'),(2570,'Kathua'),(638,'Katihar'),(1905,'Katni'),(2003,'Katol'),(849,'Katpadi'),(1047,'Katra'),(1005,'Kattakada'),(394,'Kattakampal'),(1056,'Kattan Kulathur'),(122,'Kattankulathur'),(1241,'Kattappana'),(2515,'Kattor'),(596,'Katwa'),(1597,'Kaup'),(1211,'Kaushambi'),(326,'Kavali'),(2651,'Kavaraipettai'),(2729,'Kavaratti'),(3001,'Kavindapadi'),(2600,'Kawardha'),(2746,'Kayamkulam'),(1958,'Kayangulam'),(2006,'Kedgaon'),(1971,'Keeranur'),(2239,'Keesara'),(1319,'Keezhilam'),(2343,'Kelambakkam'),(1419,'Kendrapara'),(1218,'Keonjhar'),(405,'Kerala'),(1202,'KGF'),(2737,'Khagaria'),(123,'Khagrabari'),(2374,'Khairabad'),(835,'Khairaha'),(2769,'Khairi'),(2481,'Khajipalem'),(2400,'Khambhat'),(895,'Khamgaon'),(490,'Khammam'),(2905,'Khammam Dist'),(926,'Khamman'),(1596,'Khandwa'),(923,'Khanna'),(1562,'Khantura'),(124,'Kharagpur'),(1820,'Kharar'),(2524,'Khargaon'),(1926,'Khargone'),(812,'Kharia'),(2797,'Khariar'),(2465,'Khatav'),(2828,'Khatima'),(1476,'Kheda'),(1784,'Khedbrahma'),(570,'Khelmati'),(1195,'Kherange'),(2028,'Kherva'),(1188,'Khetari'),(472,'Khetri'),(2416,'Khopoli'),(1793,'Khordha'),(1595,'Khurda'),(3032,'Khurdha'),(2017,'Khuri Bari'),(2357,'Khurja'),(1779,'Kichha'),(2678,'Kidangoor'),(2454,'Kidaripatty'),(1219,'Kikkeri P.O.'),(1980,'Kilakarai'),(1154,'Kilimanoor'),(2087,'Kille Dharur'),(892,'Killimangalam'),(1054,'Killur'),(2246,'Kilpennathur'),(460,'Kim'),(2767,'Kinnaur'),(1286,'Kirandul'),(2935,'Kirathoor'),(2541,'Kirei'),(1916,'Kirikera'),(1194,'Kirloskarwadi'),(2869,'Kirtinagar'),(125,'Kishangarh'),(2785,'Kishtwar'),(682,'Kittur'),(1704,'KK Dist'),(2879,'Klawad'),(126,'Kochi'),(649,'Kochi 682'),(2560,'Kodad'),(527,'Kodagu'),(127,'Kodaikanal'),(2535,'Kodakara'),(1668,'Kodavalur'),(1540,'Kodavasal'),(809,'Koderma'),(2846,'Kodigehally'),(2235,'Kodikanal'),(1213,'Kodungallur'),(639,'Kodur'),(1120,'Koduuayoor'),(3091,'Koganeishi 184-8795'),(1372,'Kohima'),(3046,'Kokata'),(951,'Kokrajhar'),(1813,'Kolakata'),(1795,'Kolakta'),(491,'Kolar'),(1944,'Kolasib'),(1244,'Kolencherry'),(389,'Kolenchery'),(129,'Kolhapur'),(130,'Kolkata'),(131,'Kollam (Quilon)'),(323,'Komarapalayam'),(2888,'Komarapayayam'),(734,'Konch Jalan'),(2467,'Kondagaon'),(1882,'Kondair'),(2228,'Kondotty'),(2119,'Kondungallur'),(1370,'Konni'),(1359,'Koodalloor'),(2697,'Koothattukulam'),(1990,'Kopargaon'),(1293,'Koppa'),(686,'Koppal'),(2687,'Korangi'),(927,'Koraput'),(132,'Korba'),(2731,'Korea'),(378,'Koregaon'),(2724,'Korukonda'),(679,'Kostha'),(2337,'Kot-Ise-Khan'),(133,'Kota'),(2375,'Kotagiri'),(134,'Kotala'),(1363,'Kotdwar'),(660,'Kothad'),(1881,'Kothadudem'),(618,'Kothagudem'),(995,'Kothala'),(1897,'Kothamangalam'),(2234,'Kothapar'),(1576,'Kothapet'),(1144,'Kothapeta'),(1510,'Kothecheruvu'),(2853,'Kottakkal'),(2619,'Kottappady'),(2123,'Kottapuram'),(1135,'Kottarakara'),(325,'Kottayam'),(2526,'Kottekad'),(1136,'Kottur'),(1362,'Kovilpatti'),(1494,'Kovvur'),(642,'Kowdiar'),(2630,'Kozhancherry'),(1205,'Kozhencheery'),(1946,'Kozhencheri'),(820,'Kozhikkode'),(393,'Kozhikode'),(135,'Kozhikode (Calicut)'),(1003,'Kozhikodi'),(1710,'Kozhizode'),(1734,'Krimnagar'),(136,'Krishangarh'),(306,'Krishna'),(1266,'Krishna Dist'),(305,'Krishnagar'),(307,'Krishnagiri'),(2291,'Krishnagri'),(2041,'Krishnankoil'),(308,'Krishnapuram'),(1615,'Kudal'),(489,'Kudremukh'),(2574,'Kukas'),(1341,'Kukkundoor'),(2152,'Kulamavu'),(1647,'Kuldharan'),(1126,'Kulgam'),(1794,'Kulithalai'),(1696,'Kullu'),(137,'Kulti'),(1022,'Kumaracoil'),(873,'Kumarapatnam'),(1308,'Kumarhatti'),(1112,'Kumata'),(1100,'Kumbakoman'),(486,'Kumbakonam'),(1342,'Kumbhargaon'),(1431,'Kumbla P.O.'),(2831,'Kumhari'),(1865,'Kumily'),(508,'Kumta'),(2656,'Kundankulam'),(1583,'Kundapur'),(1928,'Kundapura'),(2983,'Kunigal'),(1500,'Kunnamangalam'),(1292,'Kunnamkulam'),(138,'Kuppam'),(2674,'Kupwad'),(2889,'Kupwars'),(810,'Kuravilangad'),(721,'Kurkunta'),(2562,'Kurnnol'),(139,'Kurnool'),(140,'Kurseong'),(142,'Kurukshetra'),(141,'Kushalnagar'),(1512,'Kushinagar'),(578,'Kusiapal'),(379,'Kustagi'),(788,'Kusumba'),(396,'Kutch'),(1340,'Kuthambalkkam'),(1346,'Kuttapatti'),(1318,'Kuttipuram'),(1332,'Kuttoor'),(1895,'Kuwaritol'),(2627,'Kuzhithurai'),(632,'Lachhmangarh'),(1733,'Ladakh'),(3015,'Ladnun'),(3090,'Laguna'),(2584,'Lahdoigarh'),(503,'Laheri Sarai'),(2377,'Lakhaoti'),(1428,'Lakhimpur'),(2342,'Lakhimpur-Kheri'),(2488,'Lakhtar'),(2668,'Lakkidi'),(907,'Lakshadweep'),(1808,'Lakshmangarh'),(473,'Lakurdi'),(640,'Lalganj'),(1210,'Lalitpur'),(1861,'Lamphelpat'),(2549,'Landran'),(143,'Larambha'),(2128,'Lasalgaon'),(2528,'Latehar'),(144,'Latur'),(2206,'Laulara'),(2841,'Laxmidevipally'),(2758,'Laxmiposi'),(1323,'Leh Ladakh'),(2764,'Leh-Ladakh'),(1568,'Lembucherra'),(2536,'Levengipuram'),(345,'Liluah'),(2018,'Linch'),(824,'Lludhiana'),(2187,'Lodhivali'),(2603,'Loha'),(2271,'Lohardaga'),(2491,'Lohit'),(2960,'Loktak'),(2319,'Lonand'),(145,'Lonavala'),(557,'Lonavla'),(3081,'London  W.C. 2'),(3085,'London W1J 0BA'),(2168,'Lonere'),(2334,'Longowal'),(146,'Loni'),(2009,'Lopan'),(147,'Lucknow'),(148,'Ludhiana'),(521,'Luknow'),(2410,'Lumding'),(2881,'Lunawada'),(2438,'Lunglei'),(2690,'Lutunia'),(2590,'M. Nidamalur'),(2096,'Machalipatnam'),(2512,'Macherla'),(526,'Machhra'),(966,'Machilipatnam'),(1263,'Madanapalle'),(1199,'Madanapalli'),(1093,'Madathukulam'),(1229,'Maddilapalam'),(2661,'Maddirala'),(896,'Madhappur'),(636,'Madhepura'),(901,'Madhubani'),(2405,'Madhubani PO'),(1796,'Madhupur'),(807,'Madhuranagar'),(149,'Madikeri'),(744,'Madras'),(1152,'Madura'),(150,'Madurai'),(1768,'Maduri'),(2815,'Magadi'),(1729,'Magpur'),(1516,'Mahaboob Nagar'),(1624,'Mahaboobnagar'),(740,'Mahabubnagar'),(2951,'Mahabumnagar'),(2326,'Mahanandi'),(1716,'Maharaganj'),(1800,'Maharajganj'),(2856,'Mahasamund'),(2896,'Mahbubnagar'),(414,'Mahe'),(2393,'Mahendergarh'),(1345,'Mahendragarh'),(2273,'Mahendragiri'),(3037,'Mahesana'),(151,'Maheshtala'),(152,'Mahishadal'),(1284,'Mahoba'),(153,'Mahuva'),(2496,'Mailam'),(991,'Maindargi'),(1479,'Mainpuri'),(2210,'Majalgaon'),(881,'Majikuchi'),(530,'Makkuva'),(1695,'Makronia Sagar'),(444,'Mala'),(2302,'Malagi'),(677,'Malakkara'),(370,'Malappuram'),(613,'Malapuram'),(2085,'Malayadi'),(319,'Malda'),(154,'Malegaon'),(2827,'Malerkotla'),(2182,'Maliankara'),(2801,'Malikipuram'),(2561,'Malkapur'),(2248,'Mallampudi'),(1587,'Mallapally'),(1488,'Mallappally'),(1558,'Mallappuram'),(1828,'Mallasamudram W'),(2501,'Mallavadi'),(1141,'Malout'),(2695,'Manakkappady'),(435,'Manali'),(773,'Mananthavady'),(1303,'Mananvilai'),(2699,'Manargudi'),(2170,'Manassery'),(155,'Manauli'),(2655,'Manbazar'),(2808,'Manchar'),(1074,'Mancherial'),(1315,'Mandapam Camp'),(1782,'Mandapeta'),(938,'Mandi'),(2259,'Mandi Dabwali'),(1118,'Mandla'),(2143,'Mandsaur'),(369,'Mandya'),(2495,'Manesar'),(573,'Mangalagangotri'),(1398,'Mangalbari'),(2743,'Mangaldai'),(2989,'Mangalloi'),(156,'Mangalore'),(823,'Mangalpadi'),(891,'Mangalpady'),(1268,'Manglagangotri'),(1994,'Mangrulpir'),(2596,'Mani Majra'),(157,'Manipal'),(400,'Manjeri'),(2727,'Manjoor'),(1947,'Manjri'),(2146,'Mankhal'),(615,'Mankipur'),(2623,'Manmad'),(477,'Mannachanallur'),(406,'Mannam'),(2314,'Mannampadal'),(1833,'Mannampandal'),(1125,'Mannanam'),(320,'Mannargudi'),(1347,'Mannuthy'),(1654,'Manpur'),(1249,'Mansa'),(875,'Mansi'),(1503,'Manthiyoor'),(3061,'Manvi'),(600,'Mapusa'),(2441,'Marampally'),(1098,'Marbisu'),(2172,'Marcela'),(920,'Margao'),(2098,'Margherita'),(1921,'Mariahu'),(1355,'Marigaon'),(2673,'Markanda'),(2074,'Markapur'),(970,'Marsaghai'),(461,'Martandam'),(2124,'Maruthakulam'),(1052,'Masa Kali Patti'),(2125,'Masinagudi'),(1845,'Mastuana Sahib'),(158,'Mathura'),(2904,'Matlapalem'),(1066,'Mattannur'),(511,'Mattanur'),(2320,'Mattupatti'),(159,'Mau'),(2472,'Maunath Bhanjan'),(1301,'Mavelikara'),(1650,'Mayagonahalli'),(956,'Mayiladuthurai'),(1799,'Mayilladuthurai'),(1368,'Maylladuthuri'),(934,'Mayurbhang'),(1519,'Mayurbhanj'),(2991,'Maza Rahikpur'),(2076,'Maza Rahirpur'),(3106,'MD'),(3095,'MD 20814'),(1380,'Medak'),(2498,'Medchal'),(507,'Medinipur'),(1196,'Medziphema'),(1090,'Meenangadi'),(160,'Meerut'),(837,'Meerut Cantt'),(430,'Meeurt'),(2744,'Meghahatuburu'),(1459,'Meghalaya'),(786,'Mehabubnagar'),(2205,'Mehesana'),(367,'Mehkar'),(510,'Mehsana'),(787,'Mehsana Dist'),(1866,'Meignanapuram'),(2202,'Melaiyur'),(2866,'Melakodumalur'),(870,'Melappuram'),(1532,'Melattur'),(2345,'Mele Pattambi'),(2336,'Melmaruvathur'),(2475,'Melmuri'),(698,'Melvisharam'),(415,'Meppayur'),(1832,'Mesra'),(1334,'Metpally'),(1857,'Mettupalayan'),(1201,'Mettur'),(1660,'Mettur Dam'),(1975,'Mianpur'),(2863,'Midayikunnu'),(418,'Midnapore'),(680,'Midnapur'),(2289,'Minjur'),(161,'Mira-Bhayandar'),(1396,'Miraj'),(2356,'Miran Sahib'),(1623,'Mirijapur'),(2750,'Mirual'),(1223,'Miryalaguda'),(1320,'Mirza'),(162,'Mirzapur'),(1036,'Mizoram'),(948,'Modasa'),(3023,'Moddbidri'),(1222,'Modinagar'),(1369,'Modipara'),(2967,'Modusa'),(1267,'Moga'),(703,'Mogalikuduru'),(2310,'Mogra'),(2241,'Mohai'),(2932,'Mohail'),(163,'Mohali'),(433,'Mohanpur'),(2689,'Mohinder Garh'),(1827,'Mohindergarh'),(2792,'Mohitnagar'),(733,'Mokama'),(2771,'Mokamaghat'),(898,'Mokeri'),(928,'Mokokchung'),(1322,'Monippally'),(376,'Moodabidri'),(2903,'Moodbidiri'),(585,'Moodbidri'),(2805,'Moodlakatte'),(2857,'Moothakunnam'),(164,'Moradabad'),(2474,'Moranhat'),(2793,'Morena'),(552,'Morigaon'),(1178,'Morshi'),(165,'Motihari'),(2923,'Movva'),(2650,'MPR Dam'),(1780,'Muddebihal'),(2035,'Mudhol'),(550,'Mudigere'),(893,'Mukalmua'),(2581,'Mukandpur'),(2794,'Mukerian'),(1354,'Mukkam'),(2349,'Muktainagar'),(2265,'Muktsar'),(2102,'Mulabagal'),(2820,'Mulabagalu'),(1234,'Mulakalacheruvu'),(2045,'Mulkalla'),(597,'Mulki'),(2902,'Mullana'),(1275,'Mullanpur'),(1311,'Mullikolathur'),(2240,'Mulloorkara'),(166,'Mumbai'),(1884,'Mumbakonam'),(1627,'Mumbi'),(2551,'Mumbra'),(2720,'Munanjipatti'),(1331,'Munduparamba'),(2341,'Mundur'),(1786,'Mungeli'),(633,'Munger'),(2691,'Munipalli'),(336,'Munnar'),(1276,'Munnur'),(1859,'Mupusa'),(1412,'Murdeshwar'),(2376,'Murickassery'),(391,'Murshidabad'),(1686,'Murtizapur'),(1298,'Murum'),(2080,'Musiri'),(1659,'Mussoorie'),(1894,'Muthorai'),(2132,'Muthukur'),(3008,'Muthur'),(911,'Muvattupuzha'),(167,'Muzaffarnagar'),(168,'Muzaffarpur'),(1259,'Muzzafarnagar'),(1842,'Myladumpara'),(2719,'Mylavaram'),(1834,'Mysooru'),(169,'Mysore'),(2928,'N 24 Parganas'),(2093,'N.Pudhupatti'),(2502,'N.R. Palle'),(1451,'Nabha'),(1497,'Nacharam'),(170,'Nadia'),(549,'Nadiad'),(1151,'Nagai'),(352,'Nagaland'),(544,'Nagaon'),(466,'Nagapattinam'),(1242,'Nagarcoil'),(1116,'Nagarjuna Nagar'),(950,'Nagaur'),(171,'Nagercoil'),(172,'Nagpur'),(2404,'Nagrakata'),(2199,'Nagunur'),(959,'Nahan'),(1701,'Naida'),(173,'Naihati'),(174,'Nainital'),(2267,'Najibabad'),(1028,'Naka Dongri'),(2254,'Nalagnda'),(1131,'Nalagonda'),(708,'Nalanda'),(1134,'Nalbari'),(446,'Nalgonda'),(2577,'Nalgonds'),(2941,'Naliya'),(2325,'Nalkalikkal'),(322,'Namakkal'),(1344,'Nambol'),(2939,'Namti'),(175,'Nanded'),(1110,'Nandeuri'),(564,'Nandgaon'),(1756,'Nandigama'),(2019,'Nandikotkur'),(803,'Nandurbar'),(1025,'Nandyal'),(1976,'Nangal'),(2666,'Nangali'),(2176,'Nangiarkulangar'),(176,'Nangloi Jat'),(2638,'Nanjanagudu'),(1631,'Nanjangud'),(1693,'Napaam'),(1850,'Napur'),(1743,'Narasapur'),(1006,'Narasaraopet'),(1171,'Narasinganet'),(1995,'Narasipatnam'),(2390,'Narayanapura'),(2300,'Narayanpet'),(2305,'Naregal'),(2858,'Narendrapur'),(1529,'Narnaul'),(469,'Narsapur'),(1361,'Narsinghpur'),(330,'Narukara'),(2626,'Narwapahar'),(177,'Nashik'),(670,'Nasik'),(2117,'Nasrapur'),(2798,'Natepute'),(2652,'Nathdwara'),(2335,'Natipora'),(709,'Nattika'),(2984,'Naugachia'),(1846,'Nauni'),(2566,'Navagam'),(2238,'Navalur'),(2315,'Navapur'),(2646,'Navi Mumai'),(178,'Navi Mumbai'),(1776,'Navli'),(1149,'Navsari'),(1607,'Nawada'),(2157,'Nawagarh'),(1140,'Nawalgarh'),(1403,'Nawanshah Dt'),(925,'Nawanshahr'),(2338,'Nawanshehr'),(1638,'Nawarangpur'),(1173,'Nawargaon'),(2598,'Naya Bazar'),(1358,'Naya Nangal'),(1115,'Nayagarh'),(1073,'Nayarkuzhi'),(2811,'Nayudupet'),(2413,'Nazareth'),(656,'Nazira'),(1817,'NC'),(582,'Nedumangad'),(2451,'Nedumkandam'),(608,'Nedumkunnam'),(2929,'Neeleswaram'),(752,'Neemuch'),(1974,'Neemuch Cant.'),(1182,'Nelakondapally'),(2919,'Nelamangala'),(1032,'Nellimoodu'),(1070,'Nellippara'),(179,'Nellore'),(2663,'Neriamangalam'),(411,'Nerparsopant'),(779,'Nesari'),(2485,'Nettana'),(180,'New Delhi'),(2845,'New Delhi1'),(2832,'New Kamptee'),(1304,'New Mahe'),(878,'New Mumbai'),(691,'New Panvel'),(2094,'New Panvel (W)'),(690,'New Tehri'),(1822,'New VV Nagar'),(3078,'New York  10024 - 5192'),(1321,'Neyveli'),(1335,'Neyyoor'),(2595,'Nicobar'),(2272,'Nidadavole'),(542,'Nidasoshi'),(2649,'Nigahi'),(340,'Nilambur'),(2635,'Nilambur RS'),(715,'Nilanga'),(535,'Nileshwar'),(862,'Nilgiris'),(2262,'Nilgris'),(2948,'Nillikuppam'),(2088,'Nimpith Ashram'),(1389,'Nintanehati'),(2398,'Nipani'),(1852,'Niphad'),(2397,'Nippani'),(1148,'Nirakarpur'),(181,'Nirjuli'),(182,'Nirmal'),(1384,'Nirmalagiri'),(183,'Nischintakoili'),(1917,'Nitte'),(184,'Nizamabad'),(3107,'NJ'),(3100,'NJ 08055'),(185,'Noida'),(2993,'Nongpoh'),(2014,'Nongstoin'),(2852,'Nooranad'),(755,'North Dinajpur'),(186,'North Dumdum'),(328,'North Lakhimpur'),(2148,'North24Parganas'),(2872,'Nowgam'),(821,'Nowgong'),(2802,'Nuagam'),(1099,'Nuapada'),(2195,'Nuvem'),(919,'Nuzividu'),(2614,'Nuzvid'),(1772,'Oantnagar'),(2578,'Obedullaganj'),(2621,'Oddanchatram'),(3087,'Ohio 43210-0012'),(2740,'Ojhar'),(1824,'Okkur'),(1404,'Olakettiampalam'),(2001,'Old Goa'),(2908,'Olhapur'),(1951,'Omerga'),(1253,'Ongole'),(2821,'Ooragam'),(344,'Ootacamund'),(1582,'Ooty'),(1128,'Orai'),(2884,'Orathanad'),(1818,'Oregon IL'),(576,'Orissa'),(974,'Osmanabad'),(945,'Othera'),(1377,'Ottapalam'),(885,'Otur'),(3092,'Oxon  OX10 8DF'),(187,'Ozhukarai'),(2725,'P Medinipur'),(2327,'P Seeragapadi'),(1410,'P. Nilayam'),(1893,'P.Medinipore'),(902,'P.Nilayam'),(2140,'Pachal'),(2909,'Pacheri Bari'),(2153,'Pachmarhi'),(762,'Pachora'),(517,'Pacode'),(1265,'Padanakkad'),(1316,'Padannakkad'),(3073,'Padappai'),(2458,'Padhiana'),(1839,'Padnekat'),(2466,'Padra Tal'),(1246,'Padruna'),(737,'Padur'),(2470,'Paipad'),(2061,'Paiyanoor'),(2372,'Pakakkad'),(447,'Pakharpura'),(1877,'Pakur'),(3070,'Pakyong'),(2004,'Pakyoung'),(960,'Pala'),(338,'Palacode'),(1744,'Palai'),(1598,'Palakad'),(188,'Palakkad'),(842,'Palakol'),(2477,'Palamaner'),(3025,'Palamau'),(657,'Palampur'),(1132,'Palani'),(380,'Palanpur'),(782,'Palapur'),(830,'Palayad'),(409,'Palayamkottai'),(1673,'Palayampatti'),(1589,'Palayankottai'),(617,'Palem'),(1080,'Palemad'),(1394,'Palghar'),(2997,'Palghar (East)'),(1542,'Palghat'),(189,'Pali'),(1899,'Pali Marwar'),(2864,'Paliabindha'),(1514,'Pallam'),(1180,'Pallatheri'),(2054,'Pallavur'),(668,'Palode'),(1077,'Paloncha'),(2784,'Palta'),(2408,'Palus'),(1261,'Palwal'),(1277,'Palyamkottai'),(2511,'Pampadumpara'),(2434,'Pampady'),(1092,'Pampady South'),(2042,'Pampore'),(710,'Panagal Post'),(321,'Panaji'),(1217,'Panayur'),(2732,'Panchgani'),(190,'Panchkula'),(2297,'Panchmahal'),(1549,'Panchukla'),(1014,'Pandalam'),(2307,'Pandaul'),(1644,'Pandharpur'),(1880,'Pangode'),(191,'Panihati'),(192,'Panipat'),(1441,'Panipet'),(1123,'Panjim'),(1453,'Panjuaur PO'),(1467,'Panna'),(1177,'Panpoli'),(354,'Panruti'),(1423,'Panrutin'),(337,'Pantnagar'),(193,'Panvel'),(2826,'Paprola'),(2620,'Paradip'),(887,'Parangipettai'),(616,'Parappanangadi'),(194,'Parasia'),(1490,'Parassinikadava'),(1447,'Parathode P.O.'),(766,'Parbatpur'),(195,'Parbhani'),(2058,'Parlakhemundi'),(2169,'Parli-Vaijnath'),(1953,'Parmathi'),(1635,'Parola'),(1106,'Parrathipuram'),(994,'Parunde'),(350,'Paruvakkudi'),(1929,'Parvatipuram'),(1088,'Parwanoo'),(1617,'Pashan'),(1570,'Pasighat'),(372,'Patan'),(1013,'Patana'),(197,'Patancheru'),(1506,'Patba'),(2887,'Patel Guda'),(1667,'Pathamthitta'),(645,'Pathanamthitta'),(1204,'Pathanapuram'),(751,'Pathankot'),(2592,'Pathanpuram'),(2392,'Pathardi'),(196,'Patiala'),(2813,'Patkura'),(198,'Patna'),(2640,'Patna Sahib'),(1993,'Patoda'),(2770,'Patratu'),(1474,'Pattambi'),(2713,'Pattamundai'),(2105,'Pattan'),(2295,'Patti'),(465,'Pattithara'),(1465,'Pauagada Taluk'),(2550,'Pauri'),(2312,'Pauri Garhwal'),(2696,'Pavanasam'),(1299,'Pavaratty'),(1908,'Pavitram'),(1981,'Pavoorchatram'),(2459,'Payakaraopeta'),(2844,'Payangadi'),(723,'Payyannur'),(436,'Payyanur'),(1889,'Payyoli'),(783,'Pedagantyada'),(3069,'Pedavegi'),(961,'Peddapuram'),(1876,'Peechi'),(1594,'Peermade'),(2944,'Pehowa'),(861,'Pen'),(2807,'Pendra'),(767,'Penugonda'),(199,'Perambalur'),(2682,'Peravurani'),(2226,'Peringamala'),(2201,'Peringammala'),(1094,'Periyakulam'),(200,'Pernem'),(1225,'Perumbavoor'),(612,'Perundurai'),(2130,'Peruvallur'),(1502,'Pervmbavoor'),(2539,'Pethappampatti'),(839,'Petlad'),(1023,'Peyad'),(1039,'Phagwara'),(1083,'Phaltan'),(3076,'Philadelphia, PA 19130'),(3084,'Philadelphia, PA. 19103'),(992,'Phillaur'),(909,'Pichalaguri'),(745,'Pilani'),(1407,'Pilathara'),(2036,'Pilerne Bardez'),(2576,'Pilibhit'),(971,'Pimpalgaon'),(1648,'Pimpalner'),(201,'Pimpri-Chinchwad'),(2953,'Piparia'),(3055,'Pipariya'),(2394,'Piravom'),(1999,'Piska Nagari'),(202,'Pithoragarh'),(993,'Poarayar'),(2490,'Podakkudi'),(722,'Podili'),(2748,'Pokharan'),(2795,'Pokharipur'),(532,'Pollachi'),(904,'Ponda'),(2250,'Ponkunnam'),(2147,'Ponnala'),(2108,'Ponnampet'),(2104,'Ponnampete'),(2203,'Ponnani South'),(1966,'Ponneri'),(2702,'Ponniakurssi'),(1411,'Ponpadi'),(2734,'Pooch'),(1102,'Poochakkal'),(1907,'Poondi'),(1740,'Poonjar'),(2113,'Poonjeri'),(445,'Poothotta'),(2914,'Poovanthi'),(463,'Porabandar'),(847,'Porayar'),(525,'Porbandar'),(1294,'Port Balir'),(533,'Port Blair'),(1437,'Portonovo'),(1433,'Poruvazhi P.O.'),(747,'Poruvazhy'),(2517,'Porvorim'),(2154,'Pottapalayam'),(1748,'Powai'),(518,'Prakasam'),(2965,'Prakasam Dist'),(1528,'Prakashsam'),(1442,'Prasanthinilayam'),(203,'Prasanti Nilayam'),(3034,'Pratapgarah'),(1198,'Pratapgarh'),(464,'Pritinagar'),(1379,'Proddatur'),(806,'Pudikkottai'),(1731,'Pudikottai'),(204,'Puducherry'),(1604,'Pudukkottai'),(664,'Pudukottai'),(1164,'Pulgaon'),(2564,'Puliangudi'),(983,'Pulivendla'),(1383,'Pulivendula'),(529,'Pullazhi'),(1484,'Pulwama'),(2033,'Pundibari'),(2851,'Pundri'),(205,'Pune'),(2901,'Punkunnan'),(2637,'Puranattukara'),(1767,'Purba'),(1924,'Purba Medinipur'),(3045,'Purba Midnapur'),(310,'Puri'),(2478,'Purna'),(3009,'Purnea'),(206,'Purnia'),(666,'Purulia'),(1664,'Pusa'),(316,'Pusad'),(1937,'Puthanampatti'),(1676,'Puthenchira'),(2415,'Puthenpalli'),(1415,'Puthenthurai'),(1725,'Puthukkottai'),(1804,'Puttaparthi'),(1578,'Puttarparthi'),(962,'Puttur'),(592,'Qadian'),(2344,'Quepem'),(443,'Quilon'),(1333,'Qummalur'),(1718,'R R Dist'),(2890,'R R Dist.'),(1790,'R R District'),(2399,'R.Chodavaram'),(2706,'R.R.Dist'),(1203,'Racnhi'),(207,'Radaur'),(1628,'Rae Bareli'),(1722,'Raebareli'),(2618,'Raggad'),(2601,'Raghogarh'),(3033,'Rahtak'),(1922,'Rahuri'),(208,'Raichur'),(630,'Raigad'),(1422,'Raigad Dist'),(569,'Raiganj'),(915,'Raigarh'),(1471,'Raigudh'),(209,'Raipur'),(2957,'Raisen'),(210,'Rajahmundry'),(2505,'Rajakkamangalam'),(652,'Rajam'),(2480,'Rajampet'),(1688,'Rajapalaiyam'),(844,'Rajapalayam'),(565,'Rajapuram'),(2233,'RajaRammohunpur'),(2007,'Rajborasambar'),(978,'Rajeshwar'),(2552,'Rajgangapur'),(1909,'Rajgangpur'),(1492,'Rajgir'),(2362,'Rajgurunagar'),(2803,'Rajkanika'),(211,'Rajkot'),(631,'Rajnagar'),(2418,'Rajnandgaon'),(1049,'Rajouri'),(688,'Rajpipla'),(212,'Rajpur Sonarpur'),(1903,'Rajpura'),(2083,'Rajsamand'),(2568,'Rajura'),(213,'Ramagundam'),(1679,'Ramanagara'),(1309,'Ramanagaram'),(1048,'Ramanathapuram'),(2723,'Ramapuram'),(459,'Ramchandrapuram'),(1869,'Ramdurg'),(1797,'Ramgarh'),(2787,'Ramgarh Cantt.'),(953,'Ramnad'),(2710,'Ramnagar'),(989,'Rampachodavaram'),(214,'Rampur'),(407,'Rampura'),(2580,'Rampurhat'),(2064,'Ramtek'),(1058,'Ranaghat'),(2709,'Ranchaidham'),(215,'Ranchi'),(2236,'Rang Reddy'),(1520,'Ranga Reddy'),(2999,'Ranga Reddy Dis'),(2072,'Ranga ReddyDist'),(2149,'Rangal Reddy'),(2921,'Rangareddy'),(2916,'Rangareddy Dist'),(2258,'RangareddyDist'),(865,'Rangia'),(2433,'Ranibennur'),(1969,'Ranichauri'),(2421,'Raniganj'),(727,'Ranipet'),(2278,'Ranny'),(2446,'Rapalle'),(955,'Rasipuram'),(1183,'Ratanpur'),(216,'Ratlam'),(217,'Ratnagiri'),(1209,'Rawathbhata'),(816,'Rayagada'),(1272,'Rayarangoth'),(2461,'Rayavaram'),(1405,'Rayya'),(1682,'Razole'),(538,'Reasi'),(2521,'Rehli'),(1452,'Renukoot'),(1157,'Repalle'),(218,'Rewa'),(848,'Rewari'),(2288,'Ri Bhoi Dist'),(1483,'Rishi Valley'),(625,'Rishikesh'),(918,'Rishra'),(2822,'Robertsonpet'),(975,'Roha'),(219,'Rohtak'),(1592,'Rohtas'),(1026,'Roopnagar'),(220,'Roorkee'),(797,'Ropar'),(1282,'Rorkela'),(1051,'Rothak'),(1765,'Rourkee'),(221,'Rourkela'),(1871,'RR Dist'),(2886,'RR District'),(3057,'Rrichy'),(2995,'Rudraprayag'),(3063,'Rudrapur'),(2829,'Rupai Siding'),(3007,'S 24 Parganas'),(1950,'S Kaghaznagar'),(317,'S S Nallur'),(1935,'S.A.S.Nagar'),(889,'S.Kanara'),(1985,'S.Krushinagar'),(1564,'Sabarkantha'),(1836,'Sabarkhnatha'),(2171,'Sadanandapuram'),(2185,'Sadra'),(1781,'Safidon'),(222,'Sagar'),(1096,'Sahaganj'),(223,'Saharanpur'),(1170,'Saharsa'),(593,'Sahibganj'),(2525,'Sai Vihar'),(1670,'Saidabad'),(2218,'Sailu'),(1962,'Sakaleshapura'),(2232,'Sakaleshpura'),(1338,'Sakali'),(2225,'Sakoli'),(2191,'Sakthinagar'),(2318,'Salcete'),(3051,'Salcette'),(3060,'Salekasa'),(224,'Salem'),(1671,'Saligao'),(2513,'Salipur'),(776,'Salur'),(2487,'Samana'),(331,'Samastipur'),(225,'Sambalpur'),(1273,'Sambhal'),(1867,'Sambhalkha'),(1104,'Sambra'),(434,'Samsi'),(840,'Sanagamner'),(1629,'Sanawad'),(771,'Sanawar'),(536,'Sanchi'),(594,'Sandur'),(2212,'Sangali'),(1373,'Sangamner'),(482,'Sangli'),(850,'Sangli Dist.'),(226,'Sangli-Miraj & Kupwad'),(2276,'Sangola'),(2086,'Sangole'),(1328,'Sangrur'),(2980,'Sanguem'),(1572,'Sankarankovil'),(2059,'Sankeshwar'),(514,'Sankhali'),(2296,'Sanosara'),(562,'Sanquelim'),(227,'Santiniketan'),(2747,'Santragachi'),(3098,'Sao Pavlo 01222-010'),(2155,'Saoner'),(1399,'Sarang'),(2927,'Sardarshahr'),(2946,'Sarguja'),(3038,'Sarhali'),(2628,'Sarood'),(1858,'Saroornagar'),(2167,'Sarsa'),(2762,'Sarsawa'),(1468,'Sarugani'),(228,'SAS Nagar'),(1996,'Sasthamcotta'),(1371,'Sasthamcottah'),(2073,'Sasthamkotta'),(2175,'Saswad'),(1386,'Satana'),(229,'Satara'),(1992,'Sathiyamangalam'),(2449,'Sathupalli'),(897,'Sathupally'),(1826,'Sathyamangalam'),(230,'Satna'),(977,'Satsang'),(1541,'Sattur'),(1458,'Savanur P.O.'),(2078,'Sawai Madhopur'),(2299,'Sawaimadapur'),(485,'Sawaimadhopur'),(2251,'Sawantwadi'),(2030,'Sawarde'),(826,'Sawyerpuram'),(2050,'SBS Nagar'),(2986,'SBS Nagar (NSR)'),(231,'Secunderabad'),(611,'Secundrabad'),(2462,'Sehore'),(746,'Seijusa'),(2224,'Selaqui'),(1777,'Sembakkam'),(1938,'Senapati'),(2211,'Seoni'),(2084,'Seoul 121'),(232,'Serampore'),(3019,'Serchhip'),(1913,'Sevagram'),(2230,'Sevalpatti'),(1491,'SGR Kashmir'),(2292,'Shabad'),(602,'Shahabad'),(2579,'Shahabad (M)'),(1165,'Shahada'),(1015,'Shahdol'),(233,'Shahjahanpur'),(2876,'Shajapur'),(1153,'Shaktinagar'),(936,'Shamli'),(2384,'Shaniwareeth'),(1159,'Shankaraghatta'),(1138,'Shardanagar'),(475,'Shegaon'),(1392,'Shencottah'),(1008,'Shendurjanaghat'),(2943,'Sheopur'),(2522,'Sheopur Kalan'),(1169,'Shevgaon'),(537,'Shikohabad'),(234,'Shillong'),(2810,'Shimirpet'),(235,'Shimla'),(2867,'Shimurali'),(2056,'Shingnapur'),(605,'Shirala'),(2048,'Shirgaon'),(1390,'Shirpur'),(2280,'Shirur'),(1862,'Shivamogga'),(236,'Shivamogga (Shimoga)'),(2947,'Shivapuri'),(1856,'Shivnagar'),(3035,'Shivpuri'),(1289,'Shmoga'),(2303,'Shmogar'),(841,'Sholinganallur'),(2861,'Sholinghur'),(833,'Shoranur'),(2039,'Shorapur'),(1336,'Shornur'),(1855,'Shreeramnagar'),(2800,'Shreewardhan'),(2129,'Shrigonda'),(874,'Shringere'),(1353,'Shrirampur'),(2585,'Shrivilliputhur'),(1923,'Shujalpur'),(1042,'Siddapur'),(828,'Siddhpur'),(1831,'Siddipet'),(1264,'Sidhi'),(2214,'Sidhrawali'),(2145,'Sidhwar Khurd'),(2683,'Sihora'),(669,'Sikar'),(2317,'Sikara'),(425,'Sikharpur'),(1482,'Sikkim'),(1626,'Sikkim (East)'),(237,'Silchar'),(238,'Siliguri'),(614,'Silliguri'),(2091,'Sillod'),(2812,'Silvassa'),(2141,'Simaluguri'),(627,'Simhachalam'),(2016,'Simulbari'),(1920,'Sindewahi'),(3103,'Sindh 73050'),(239,'Sindhudurg'),(768,'Sindhudurga'),(775,'Sindkheda'),(1305,'Singanallur'),(1736,'Singapore'),(2207,'Singarayakonda'),(654,'Singhbhum'),(1612,'Singhbhum (E)'),(1761,'Singhrauli'),(2588,'Singoor'),(240,'Singrauli'),(2471,'Sinnar'),(2407,'Siricilla'),(985,'Sirkali'),(2352,'Sirmour'),(941,'Sirmur'),(958,'Sirohi'),(1101,'Sironcha'),(599,'Sirsa'),(471,'Sirsi'),(663,'Siruseri'),(877,'Sitapur'),(1811,'Sitarganj'),(241,'Sivaganga'),(947,'Sivagiri'),(1712,'Sivakashi'),(242,'Sivakasi'),(385,'Sivapuri'),(964,'Sivasagar'),(1114,'Siwan'),(243,'Sodepur'),(3029,'Sohna'),(942,'Solan'),(244,'Solapur'),(2279,'Someshwarnagar'),(2034,'Sonai'),(1455,'Sonapur'),(2301,'Sonari'),(648,'Sonarpur'),(676,'Sonbhadra'),(2060,'Sonbhanra'),(1325,'Sonebhadra'),(601,'Sonepat'),(467,'Sonepur'),(245,'Sonipat'),(1621,'Sonipet'),(819,'Sonitpur'),(1270,'Sontipur'),(1883,'Sopore'),(1017,'Soro'),(3097,'South Africa'),(2557,'South Andaman'),(246,'South Dumdum'),(2023,'South Kodagu'),(2714,'South Tripura'),(2194,'Sreekandapuram'),(2648,'Sreenivasapuram'),(1637,'Sri Ganga Nagar'),(247,'Sri Ganganagar'),(739,'Sri Palli'),(1699,'Sriganganagar'),(1639,'Srihari Kota'),(1901,'Sriharikota'),(1522,'Srikakulam'),(2482,'Srikalahasthi'),(509,'Srikalahasti'),(1535,'Srikaulam'),(2893,'Srimushnam'),(248,'Srinagar'),(2204,'SrinagarGarhwal'),(714,'Sringeri'),(408,'Sriniketan'),(1508,'Srinivasanagar'),(2818,'Srinivasapura'),(742,'Srinivasnagar'),(440,'Srinivaspur'),(1697,'Sriperumbpudur'),(249,'Sriperumbudur'),(250,'Srirampur'),(2895,'Srisailam'),(980,'Srivaikuntam'),(1255,'Srivilliputtur'),(1464,'Srukandapuram'),(3056,'Subansiri'),(2161,'Subrahmanya'),(2082,'Sudumbre'),(1252,'Sullia'),(922,'Sullurpet'),(1186,'Sullurpeta'),(940,'Sullurupeta'),(251,'Sultanpur'),(1878,'Sulthan Bathery'),(2667,'Sulur'),(3002,'Sunam'),(694,'Sundargarh'),(1656,'Sundaridia'),(2753,'Sunderbani'),(478,'Sunderchak'),(1552,'Sundergarh'),(1243,'Surajpur'),(1961,'Surampalem'),(252,'Surat'),(1175,'Surathakal'),(253,'Surathkal'),(1109,'Suratkal'),(2776,'Surda'),(2287,'Surendranagar'),(859,'Surguja'),(555,'Suri'),(883,'Suryamaninagar'),(730,'Suryapet'),(1250,'Sutrapada'),(1888,'Suttur'),(1018,'Swamimalai'),(2679,'Syamsundar'),(1705,'T V Malai'),(2142,'T. Kallikulam'),(2912,'T.Kallupatty'),(1848,'Tadapalligudem'),(2875,'Tadapatri'),(584,'Tadepalligudem'),(2282,'Tadikonda'),(2582,'Tadong'),(1160,'Tadpatri'),(1737,'Taegu'),(3104,'Taipei'),(2842,'Takhatpur'),(932,'Talab Tilloo'),(1769,'Talakonda'),(2283,'Talcher'),(1002,'Taleigao'),(3064,'Taleigao Plateau'),(1801,'TaleigaoPlateau'),(1079,'Taleigo'),(554,'Taliparamba'),(2193,'Talod'),(2425,'Taloda'),(474,'Talwara'),(351,'Tambaram'),(2221,'Tamenglong'),(1964,'Tamkuhiraj'),(1457,'Tamluk'),(2428,'Tangi'),(1571,'Tangore'),(2112,'Tanjavur'),(1176,'Tanjore'),(427,'Tanuku'),(972,'Tarikere'),(1821,'Tarikhet'),(2388,'Tarn Taran'),(1936,'Tasgaon'),(2963,'Tatnagiri'),(2593,'Tattamangalam'),(1841,'Tavanur'),(1807,'Teh-Merta'),(1435,'Tehri'),(1466,'Tehri Garhwal'),(1847,'Tehsil Rajpura'),(799,'Tekkali'),(906,'Telam'),(1788,'Teleiago'),(589,'Tellicherry'),(1675,'Telliicherry'),(2286,'Tempe, AZ'),(684,'Tenali'),(1477,'Tenkara P.O.'),(1414,'Tenkasi'),(2378,'Terri Garhwal'),(3011,'Tetali'),(255,'Tezpur'),(2503,'Tezu'),(1567,'Thachanallur'),(2739,'Thadlaskein'),(2067,'Thalacode'),(450,'Thalassery'),(1979,'Thalavapalayam'),(2931,'Thance'),(2885,'Thandalam'),(256,'Thane'),(866,'Thane (W)'),(854,'Thane (West)'),(3059,'Thane East'),(1505,'Thane West'),(2617,'Thane(W)'),(254,'Thanjavur'),(1805,'Thanjvur'),(2958,'Tharamangalam'),(1608,'Thasra'),(2350,'Thathanur'),(1191,'Thattamala'),(1525,'The Nilgiris'),(1290,'Theerthamalai'),(1489,'Thellar'),(1385,'Thellyoor'),(1156,'Thenhipalam'),(1425,'Thenhipalam PO'),(1536,'Theni'),(2597,'Thenzawl'),(2186,'Thetkuppalam'),(1297,'Thickurichy'),(1168,'Thimmasamudram'),(431,'Thiruchirapalli'),(2854,'Thirumansolai'),(1698,'Thirunelveli'),(2380,'Thiruninravur'),(2219,'Thirupachur'),(1192,'Thirupathur'),(1957,'Thiruppanadal'),(1620,'Thiruppathur'),(1791,'Thirupur'),(1559,'Thiruvaiyaru'),(1706,'Thiruvalam'),(1179,'Thiruvalla'),(1046,'Thiruvallur'),(257,'Thiruvananthapuram'),(1401,'Thiruvankulam'),(1040,'Thiruvannamalai'),(1130,'Thiruvarur'),(1683,'Thiruvattar'),(2680,'Thiruvilla'),(346,'Thodupuzha'),(997,'Thokkavadi'),(2897,'Tholayavattam'),(1959,'Tholudur'),(1107,'Thondi'),(1965,'Thoothoor'),(303,'Thoothukudi'),(2115,'Thoppur'),(568,'Thotakkara'),(2156,'Thottakkadu'),(2435,'Thoubal'),(2099,'Thovalai'),(2900,'Thrikkakara'),(2442,'Thrikkanapuram'),(258,'Thrissur'),(381,'Thrisur'),(1238,'Thrisuur'),(494,'Thriuchirapalli'),(2533,'Thruvannamalai'),(2311,'Thuckalay'),(2255,'Thuruthicad'),(2179,'Thuthukudi'),(1633,'Tihu'),(2605,'Tikamgarh'),(921,'Tilaiya Dam'),(2730,'Tilwasni'),(1680,'Tindivanam'),(1527,'Tinsukia'),(1035,'Tiptur'),(3052,'Tirap'),(1703,'Tirchengode'),(1803,'Tirchy'),(1915,'Tirtol'),(728,'Tiruchendur'),(1397,'Tiruchengode'),(1550,'Tiruchiraoalli'),(259,'Tiruchirapalli'),(2293,'Tiruchirapally'),(1214,'Tiruchirappali'),(395,'Tiruchirappalli'),(1061,'Tiruchy'),(335,'Tirukalukundram'),(1162,'Tirukovilour'),(2178,'Tirumangalam'),(260,'Tirunelveli'),(794,'Tiruninravur'),(355,'Tirupathi'),(261,'Tirupati'),(1495,'Tirupattur'),(2166,'Tiruppattur'),(1076,'Tiruppur'),(262,'Tirupur'),(2136,'Tirur'),(2426,'Tirurangadi'),(2933,'Tiruttani'),(1933,'Tiruvalam'),(711,'Tiruvalla'),(547,'Tiruvannamalai'),(2855,'Tiruvannmalai'),(1300,'Tiruvarur'),(1556,'Tiruvelveli'),(822,'Tiruvetipuram'),(263,'Tiruvottiyur'),(2838,'Tiruvuru'),(1806,'Tonk'),(1816,'Tonk Road'),(2353,'Toranagallu'),(1868,'Trichi'),(1543,'Trichirappalli'),(373,'Trichur'),(2783,'Trimbuk'),(1709,'Trippur'),(366,'Tripunithura'),(931,'Tripur'),(882,'Tripura'),(1655,'Tripura (N)'),(2977,'Tripura West'),(732,'Trissur'),(3066,'Trivandruam'),(800,'Trivandurm'),(1622,'Trvandrum'),(1983,'Tuljapur'),(2144,'Tumakooru'),(264,'Tumakuru (Tumkur)'),(390,'Tumkur'),(1625,'Tumukur'),(1984,'Tuni'),(701,'Tura'),(1603,'Turuppur'),(492,'Tuticorin'),(1285,'Tutucorin'),(3108,'TX'),(1810,'U.S. Nagar'),(2883,'UB Kanker'),(453,'Uchipulli'),(1517,'Udaipir'),(265,'Udaipur'),(2460,'Udala'),(1016,'Udalguri'),(1713,'Udam Singhnagar'),(2427,'Udamalpet'),(2420,'Udayagiri'),(1349,'Udayamperoor'),(1555,'Udayarpalayam'),(716,'Udgir'),(957,'Udhagamandalam'),(302,'Udhampur'),(705,'Udhna'),(1812,'Udipi'),(1020,'Udumalpet'),(301,'Udupi'),(1044,'Uduppi'),(2996,'Udupt'),(1652,'Udwada'),(375,'Ujire'),(266,'Ujjain'),(2708,'Ukhrul'),(1982,'Ulga'),(267,'Ulhasnagar'),(1472,'Ullhasnagar'),(268,'Uluberia'),(2537,'Umaim'),(2835,'Umakhed'),(300,'Umaria'),(1227,'Umarkhed'),(2189,'Umiam'),(2700,'Umrangso'),(2165,'Umred'),(2945,'Una'),(856,'Unnao'),(398,'Uppinangadi'),(3044,'Uppinangady'),(2382,'Uran'),(2773,'US Nagar'),(1493,'Usilampatti'),(2294,'Uthamapalayam'),(1031,'Uthangal'),(1216,'Uthangarai'),(2370,'Uthangudi'),(1751,'Uttar Dinajpur'),(717,'Uttarkashi'),(1124,'Uzhavoor'),(2848,'V. Kote'),(2665,'V. Singapuram'),(704,'V. Vidyanagar'),(353,'V.Vidyanagar'),(624,'Vadakara'),(423,'Vadakkevila'),(2081,'Vadlamudi'),(269,'Vadodara'),(2066,'Vaijapur'),(2464,'Vairag'),(2937,'Vaishali'),(448,'Valacodu'),(2913,'Valad'),(496,'Valancheri'),(2215,'Valanchery'),(2664,'Valapad'),(2065,'Valarpuram'),(628,'Valavannur'),(417,'Valavanour'),(270,'Vallabh Vidyanagar'),(1381,'Vallam'),(933,'Vallanad'),(2068,'Vallanadu'),(693,'Vallar'),(876,'Vallioor'),(2796,'Valmikipuram'),(2116,'Valod'),(930,'Valparai'),(2981,'Valpoi'),(299,'Valsad'),(1485,'Valvada'),(271,'Vamadapadavu'),(2330,'Vanagaram'),(1526,'Vanasthalipuram'),(1927,'Vandalur'),(1478,'Vandavasi'),(696,'Vaniyambadi'),(2546,'Vannarpettai'),(519,'Vapi'),(2389,'Vapi (West)'),(272,'Varanasi'),(1717,'Varansai'),(976,'Varkala'),(524,'Varnasi'),(2432,'Varvand'),(2071,'Vasad'),(1727,'Vasai'),(1963,'Vasai Road (W)'),(2809,'Vasai Road West'),(273,'Vasai-Virar'),(1948,'Vasco'),(1663,'Vasco da gama'),(1702,'Vasco-da-Gama'),(2494,'Vaslas'),(3021,'Vasudevanallur'),(967,'Vatakara'),(3101,'Vavuniya'),(1658,'Vayala'),(1067,'Vayalar'),(2519,'Vayyuru'),(2632,'Vazhakulam'),(2227,'Vazhayoor East'),(2686,'Vazhithala'),(2548,'Vazhoor'),(2097,'Veerachipalayam'),(2284,'Veeravasaram'),(1634,'Velha'),(1071,'Veliyur'),(1545,'Vellalloor'),(1898,'Vellayani'),(2964,'Vellichanthai'),(2631,'Vellithiruthy'),(274,'Vellore'),(1351,'Velur'),(1288,'Vemom'),(1226,'Vemon'),(2653,'Vengola'),(2419,'Vengurla'),(2569,'Venjaramoodu'),(2624,'Venkatachalam'),(2134,'Venkatagirikote'),(1997,'Venpakkam'),(2874,'Veraval'),(2012,'Verem'),(2573,'Verna'),(1945,'Vetapalem'),(1260,'Vettavalam'),(1413,'Vetturnimadam'),(2323,'Vidavalur'),(1348,'Vididsha'),(672,'Vidisha'),(905,'Vidyanagar'),(572,'Vijaipur'),(1041,'Vijayamangalam'),(2816,'Vijayapura'),(2756,'Vijayavada'),(275,'Vijayawada'),(1565,'Vikarabad'),(3014,'Vikiravandi'),(1317,'Vilayancode'),(2469,'Villapakkam'),(2062,'Villianur'),(2563,'Villiapalli'),(2911,'Villpuram'),(1590,'Villukuri'),(2274,'Villukury'),(1609,'Villuppuram'),(1063,'Villupuram'),(1651,'Vinukonda'),(2164,'Virajapet'),(2968,'Virajpet'),(580,'Virar (West)'),(1551,'Virddhachalam'),(297,'Viridhunagar'),(515,'Viruddhachalam'),(1724,'Virudhu Nagar'),(2966,'Virudunagar'),(2010,'Visakahpatnam'),(2899,'Visakapatnam'),(276,'Visakhapatnam'),(2008,'Visakyhapatnam'),(298,'Vishakhapatnam'),(1657,'Vishnupur'),(1108,'Visnagar'),(2355,'Vita'),(620,'Vitalnagar'),(1892,'Vittal'),(2910,'Vixianagaram'),(908,'Vizag'),(590,'Vizianagaram'),(1770,'Vizianagram'),(963,'Vizninjam'),(2509,'Vllore'),(1533,'Voimedu'),(2806,'Vriddhachalam'),(884,'Vridhachalam'),(1163,'Vsgao'),(1844,'Vuyyuru'),(2930,'VV Nagar'),(939,'Vyara'),(1029,'Vyasagiri'),(2642,'W Garo Hills'),(1470,'W.Champaran'),(2324,'W.G Dist'),(910,'W.Godavari'),(2532,'Wadhwancity'),(1972,'Wagholi'),(1189,'Wai'),(583,'Waltair'),(2531,'Wandiwash'),(780,'Wani'),(2120,'Waranagar'),(277,'Warangal'),(294,'Wardha'),(1925,'Wargal'),(534,'Warora'),(2547,'Washim'),(296,'Wayanad'),(1548,'West Champaran'),(2173,'West Champuram'),(853,'West Garo Hills'),(567,'West Godavari'),(2992,'West KhasiHills'),(2644,'West Midnapore'),(2774,'West Siang'),(1436,'West Singhbhoom'),(3003,'West Singhbhum'),(2429,'WG Dist'),(3040,'WG District'),(2726,'Yadagiri'),(2516,'Yadgir'),(1221,'Yamuna Nagar'),(278,'Yamunanagar'),(1978,'Yanam'),(295,'Yavatmal'),(2358,'Yawatmal'),(279,'Yeddumailaram'),(280,'Yelburga'),(546,'Yellamanchili'),(539,'Yellandu'),(2738,'Yellapur'),(1986,'Yemmiganur'),(1366,'Yeotmal'),(871,'Yercaud'),(2260,'Yerraguntla'),(2583,'Yeshwantnagar'),(2329,'Yol Cantt.'),(2020,'YSR Dist'),(2759,'Zawar Mines'),(1789,'Zirakpur'),(1580,'Zuari Nagar'),(683,'Zuarinagar');
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
  `chqddNumber` int(11) DEFAULT NULL,
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
  PRIMARY KEY (`id`),
  KEY `journal_group_contents_indx2` (`journalId`)
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
  `bilid` int(11) DEFAULT '0',
  `miId` int(11) DEFAULT '0',
  `bildate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mailing_list_detail_indx1` (`journalId`),
  KEY `mailing_list_detail_indx2` (`subtypecode`),
  KEY `mailing_list_detail_indx3` (`volumeNumber`,`year`,`issue`)
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `jds`.`add_back_issues`
   BEFORE INSERT   ON jds.subscriptiondetails
   FOR EACH ROWBEGIN
   
   IF new.endyear < YEAR(CURRENT_TIMESTAMP)   THEN
      SET new.active = FALSE;   END IF;

   CALL addBackIssues(new.id,
                      new.startMonth,                      new.startYear,
                      new.journalGroupID,                      new.copies);
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
INSERT INTO `user_role` VALUES ('admin@ias.com','admin'),('jds@ias.com','user'),('mc@ias.com','monochrome');
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
INSERT INTO `users` VALUES ('admin@ias.com','admin','Admin','',0),('jds@ias.com','jds','JDS','',0),('mc@ias.com','mc','Monochrome',NULL,0);
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `addBackIssues`(IN _subscription_detail_id   int,

                                     IN _new_startMonth           int,

                                     IN _new_startYear            int,

                                     IN _new_journalGroupID       int,

                                     IN _new_copies               int)
BEGIN

  DECLARE journal_id int;















  DECLARE _month int;















  DECLARE _year int;















  DECLARE issue_number int;















  DECLARE volume_number int;







  DECLARE dummy int;







  DECLARE done int DEFAULT 0;















  DECLARE cur1 CURSOR FOR  SELECT t2.journalID,

       t3.month,

       t3.year,

       t3.issue,

       t3.volumenumber

  FROM journal_group_contents t2,

       mailing_list t3

 WHERE     t2.journalGroupID = _new_journalGroupID

       AND t2.journalID = t3.journalid


       


       AND t3.year = _new_startYear;











  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;







      OPEN cur1;







     read_loop:

      LOOP

         FETCH cur1

           INTO journal_id, _month, _year, issue_number, volume_number;







         IF done = 1

         THEN

            LEAVE read_loop;

         END IF;







         INSERT INTO back_issue_list(subscription_detail_id,

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

   END ;;
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `circulation_figures`(IN cir_year int)
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







    







    







END ;;
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `cir_subscription_rates`(IN cir_year        int,







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























   END ;;
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

-- Dump completed on 2013-02-23 21:14:57
