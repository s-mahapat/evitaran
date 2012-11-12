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
) ENGINE=InnoDB AUTO_INCREMENT=3168 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` VALUES (3159,'1000 CE Amsterdam'),(3151,'199034 St. Petersburg'),(311,'24 Parganas North'),(312,'24 Parganas South'),(3143,'2784-505 Oeiras'),(3153,'70910-900  Brasilia D.F.'),(2991,'Aadepalligudem'),(3015,'Aannd'),(2766,'Abmala'),(1067,'Abohar'),(1592,'Achanputhur'),(969,'Adambakkam'),(388,'Addanki'),(986,'Adilabad'),(1419,'Adimali'),(2594,'Adinathnagar'),(1444,'Adipur'),(2056,'Adirampattinam'),(1614,'Adoni'),(1258,'Adoor'),(796,'Adra'),(2306,'Aduthurai'),(687,'Agartala'),(2549,'Agasteeswaram'),(1,'Agra'),(1876,'Agra Cantt'),(2453,'Ahmadnagar'),(2,'Ahmedabad'),(3132,'Ahmedanad'),(3,'Ahmednagar'),(413,'Aiazawl'),(4,'Aizawl'),(1035,'Aizwal'),(428,'Ajara'),(2416,'Ajitmal'),(5,'Ajmer'),(2000,'Akalkot'),(2675,'Akhada Balapur'),(2902,'Akhnoor'),(3067,'Akluj'),(6,'Akola'),(1653,'Akot'),(2264,'Ala'),(2099,'Alagappanagar'),(2219,'Aland'),(3006,'Alappusha'),(8,'Alappuzha'),(1160,'Alapuzha'),(2296,'Alathur'),(2927,'Ale'),(1573,'Aleppey'),(3146,'Alexandria'),(281,'Alibag'),(7,'Aligarh'),(282,'Aligrah'),(9,'Allahabad'),(2758,'Allahabas'),(1576,'Allahabd'),(10,'Almora'),(1836,'Almore'),(3058,'Almorea'),(2569,'Along'),(1979,'Alore'),(847,'Aluva'),(11,'Alwar'),(1692,'Alwarkurichi'),(462,'Alwarkuruchi'),(2648,'Alwasa'),(903,'Alwaye'),(677,'Amalapuram'),(726,'Amalner'),(1968,'Amaravati'),(1545,'Amarvati'),(2041,'Ambad'),(2433,'Ambah'),(1898,'Ambajogai'),(283,'Ambala'),(3085,'Ambala Cant'),(795,'Ambala Cantt'),(2802,'Ambala Cantt.'),(828,'Ambala City'),(1131,'Ambalamugal'),(2043,'Ambalavayal'),(12,'Ambattur'),(2228,'Ambav'),(13,'Ambernath'),(608,'Amberpet'),(284,'Ambikapur'),(2191,'Ambilikka'),(2086,'Ambur'),(2658,'Amdedabad'),(2126,'Amethi'),(2726,'Amgaon'),(2593,'Amla'),(2638,'Amlagora'),(2080,'Ammandivillai'),(1772,'Amraavati'),(14,'Amravati'),(416,'Amreli'),(15,'Amritsar'),(3083,'Amroha'),(1981,'Amta'),(2313,'Anad'),(382,'Anakapalle'),(581,'Anakapalli'),(2192,'Anakkayam'),(935,'Ananatapur'),(285,'Anand'),(1887,'Anandapur'),(2304,'Anandpur Sahib'),(2589,'Anandwan'),(16,'Anantapur'),(1522,'Ananthapur'),(2895,'Ananthpur'),(286,'Anantnag'),(3012,'Anaparthi'),(597,'Anchal'),(2795,'Andal'),(3052,'Andaman'),(1183,'Anekal'),(1246,'Angadikadavu'),(772,'Angamally'),(2412,'Angamaly'),(333,'Angul'),(356,'Anguli'),(2592,'Ankaleshwar'),(870,'Ankleshwar'),(2273,'Ankola'),(631,'Annamalai'),(334,'Annamalai Nagar'),(314,'Annamalainagar'),(1460,'Annur'),(2081,'Anoopshahr'),(2693,'Anumala'),(2804,'Anupgarh'),(757,'Anupuram'),(1541,'Anvardhikanpet'),(2814,'Aonla'),(704,'Ara'),(2271,'Arabhavi'),(2250,'Arachalur'),(780,'Arakkonam'),(1674,'Arakkulam'),(949,'Arakkunnam'),(2310,'Arakulam'),(17,'Araleri'),(2949,'Aralvaymoli'),(2749,'Aralvoimozhi'),(18,'Arambagh'),(639,'Araria'),(2752,'Arasampatti'),(2425,'Arasikere'),(2176,'Arasur'),(1595,'Aravayal'),(968,'Areacode'),(1133,'Arimpur'),(1571,'Ariyalur'),(701,'Ariyannur'),(2607,'Armoor'),(2149,'Armori'),(2097,'Arni'),(19,'Arrah'),(404,'Arsikere'),(1701,'Arumanai'),(1337,'Arunapuram'),(817,'Aruppukottai'),(2235,'Aruvankadu'),(655,'Aryapur'),(20,'Asansol'),(888,'Ashoknagar'),(562,'Astabad Itarsi'),(1932,'Aswaraopet'),(1470,'AT & P.O.Barh'),(1192,'Atarra'),(2975,'Athani'),(1843,'Athens'),(456,'Athgarh'),(2732,'Atkot'),(442,'Atpadi'),(2907,'Attabira'),(675,'Attingal'),(766,'Attoor'),(533,'Attur'),(683,'Atul'),(1983,'Aundipatti'),(979,'Auraiya'),(21,'Aurangabad'),(1430,'Auroville'),(22,'Avadi'),(2655,'Avidi'),(1883,'Avikanagar'),(2014,'Avinashi'),(2449,'Awantipora'),(1454,'Ayodhya'),(2032,'Ayur'),(1211,'Ayyanthole'),(996,'Azamgarh'),(2441,'Aziznagar'),(2651,'B.G. Nagar'),(1418,'Badagara'),(2437,'Badami'),(3081,'Badchiroli'),(2216,'Baddi'),(287,'Badlapur'),(2834,'Badmal'),(1542,'Badnera'),(3062,'Badodara'),(441,'Badshahithaul'),(1375,'Badvel'),(621,'Bagalkot'),(1204,'Bagar'),(1094,'Bagdogra'),(804,'Bagepalli'),(1682,'Bagepally'),(3156,'Baghdad'),(1790,'Baghpat'),(1656,'Baghra'),(714,'Bagudi'),(2605,'Bahadurgarh'),(2405,'Bahal'),(2624,'Bahona'),(794,'Bahraich'),(358,'BaihataChariali'),(1195,'Baijnath'),(882,'Bailhongal'),(2028,'Bakewar'),(2928,'Bakhtiarpur'),(2100,'Bakrol'),(2511,'Baladmari'),(288,'Balaghat'),(924,'Balangir'),(623,'Balasore'),(1230,'Balikuda'),(1219,'Balisahi'),(2521,'Ballabgarh'),(2067,'Ballarpur'),(1877,'Ballary'),(484,'Ballia'),(23,'Bally'),(2411,'Balod'),(342,'Balrampur'),(392,'Balurghat'),(1256,'Baluti'),(2707,'Bamkhed'),(1713,'Banaskantha'),(1434,'Banasthali'),(2744,'Banaswada'),(753,'Banda'),(1436,'Bandipora'),(1725,'Banga'),(1040,'Bangaaore'),(24,'Bangarpet'),(2072,'Banikhet'),(1416,'Banipur'),(504,'Bankalagi'),(2351,'Banki'),(1626,'Bankpara'),(341,'Bankura'),(1110,'Banswara'),(2781,'Bantalab'),(1128,'Bantiwal'),(890,'Bantwal'),(1340,'Bapatla'),(1802,'Barabanki'),(579,'Baramati'),(1273,'Baramulla'),(25,'Baranagar'),(3128,'Barapani'),(476,'Barasat'),(2835,'Barauni'),(676,'Baraut'),(2373,'Bardez'),(26,'Bardhaman'),(558,'Bardoli'),(27,'Bareilly'),(304,'Bareli'),(2427,'Barelly'),(1735,'Bargarh'),(2756,'Bargur'),(1529,'Barharwa'),(2576,'Baridh Colony'),(28,'Baripada'),(1262,'Barmer'),(805,'Barnala'),(399,'Barpeta'),(669,'Barrackpore'),(3125,'Barrackpore P.O.'),(653,'Barshi'),(2399,'Baru Sahib'),(3045,'Basanti'),(1783,'Basirhat'),(1450,'Basmath'),(1458,'Bastar'),(1096,'Basti'),(1655,'Basudevpur'),(1535,'Batala'),(29,'Bathinda'),(1464,'Baxi Bazar'),(1370,'Bazpur'),(3005,'Beawar'),(1153,'Beed'),(2541,'Beekar'),(2152,'Beerapalli'),(862,'Begusarai'),(2708,'Bela'),(1853,'Belagavi'),(2131,'Belati'),(3107,'Belavavi'),(3030,'Belda'),(30,'Belgaum'),(31,'Bellary'),(1742,'Belthangadi'),(1548,'Belthangady'),(3042,'Belur Math'),(1837,'Bemetara'),(32,'Bengaluru'),(2735,'Benjanapadavu'),(954,'Berhampore'),(33,'Berhampur'),(3150,'Bethesda, MD 20814'),(1367,'Bethuadahari'),(455,'Bettiah'),(1139,'Betul'),(368,'Bhabua'),(1156,'Bhadohi'),(2418,'Bhadrachalam'),(680,'Bhadrak'),(1306,'Bhadravathi'),(1397,'Bhadravati'),(2578,'Bhadsen'),(34,'Bhagalpur'),(3088,'Bhagur'),(1927,'Bhaila'),(2105,'Bhalki'),(590,'Bhandara'),(1645,'Bhanur'),(1401,'Bharathi Nagara'),(1586,'Bharathinagara'),(2234,'Bharathpur'),(35,'Bharatpur'),(2843,'Bharkatia'),(483,'Bharuch'),(1241,'Bhatapara'),(2836,'Bhathinda Cantt'),(1623,'Bhatkal'),(2299,'Bhatoli'),(36,'Bhatpara'),(1073,'Bhavanisagar'),(37,'Bhavnagar'),(814,'Bhawanipatna'),(2976,'Bhilad'),(38,'Bhilai'),(2168,'Bhilainagar'),(1588,'Bhillai'),(39,'Bhilwara'),(1100,'Bhimavaram'),(1961,'Bhimtal'),(2470,'Bhind'),(40,'Bhiwandi'),(848,'Bhiwani'),(2872,'Bhiwari'),(289,'Bhojpur'),(1092,'Bhongaon'),(1931,'Bhongir'),(2053,'Bhoom'),(41,'Bhopal'),(2285,'Bhor'),(3077,'Bhtakumarada'),(42,'Bhubaneswar'),(43,'Bhuj'),(2980,'Bhuj-Kachchh'),(2978,'Bhuj-Kutch'),(1564,'Bhunbaneswar'),(845,'Bhusawal'),(2261,'Bhutta'),(3035,'Bicholim'),(1938,'Bidadi'),(44,'Bidar'),(45,'Bidhan Nagar'),(502,'Bidri'),(46,'Bihar Sharif'),(47,'Bijapur'),(720,'Bijhari'),(777,'Bijnor'),(2837,'Bijpur'),(48,'Bikaner'),(3099,'Bilagi'),(2661,'Bilahongala'),(667,'Bilai'),(49,'Bilaspur'),(1699,'Bilimora'),(290,'Bina'),(2832,'Binnaguri'),(542,'Birbhum'),(1248,'Bishnupur'),(2183,'Bobbili'),(2591,'Bodinayakanur'),(990,'Boisar'),(50,'Bokaro'),(437,'Bokaro Thermal'),(801,'Bolangir'),(3113,'Bolangr'),(915,'Bolpur'),(2141,'Bomdila'),(2496,'Bonaigarh'),(709,'Bongaigaon'),(1675,'Borai'),(1152,'Bordez'),(2361,'Bordi'),(2170,'Boriavi'),(2993,'Boudh'),(881,'Boudh  Dist.'),(52,'Brahmapur'),(1929,'Brahmapuri'),(2640,'Brahmavar'),(2464,'Bssti'),(2665,'Bud Bud'),(820,'Budaun'),(357,'Buddhnagar'),(2709,'Budgam'),(1987,'Budhagaya'),(1705,'Bulandshahar'),(1366,'Bulandshahr'),(457,'Buldana'),(3073,'Buldhana'),(51,'Burdwan'),(1611,'Burhanpur'),(1698,'Burhar'),(741,'Burla'),(738,'Burnpur'),(2856,'Bylakuppe'),(3109,'Cachar'),(505,'Calcutta'),(3137,'California 94720'),(3145,'Cambridge CB2 3PY'),(921,'Canacona'),(421,'Canchipur'),(360,'Cannanore'),(1997,'Canning Town'),(2498,'Chaibasa'),(981,'Chaimpal'),(550,'Chaklashi'),(3070,'Chakradharpur'),(2265,'Chalakudy'),(691,'Chalala'),(1025,'Chalisgaon'),(1703,'Challakere'),(854,'Chamarajanagar'),(3084,'Chamarajanagara'),(2822,'Chamba'),(2315,'Chamoli'),(2721,'Champa'),(2279,'Champadanga'),(2712,'Champakulam'),(1707,'Champaran'),(3096,'Champawat'),(2854,'Champhai'),(2919,'Champua'),(1486,'Chamurchi'),(2542,'Chanasma'),(673,'Chandannagar'),(763,'Chandausi'),(2461,'Chandel'),(2743,'Chandeshwar'),(53,'Chandigarh'),(1507,'Chandimandir'),(1649,'Chandpur'),(54,'Chandrapur'),(2534,'Chandrapura'),(1976,'Chandwad'),(2888,'Changa'),(830,'Changanacherry'),(1108,'Changanachery'),(383,'Changancherry'),(1012,'Changigarh'),(1288,'Channagiri'),(2905,'Channai'),(832,'Channapatna'),(365,'Channarayapatna'),(568,'Chapra'),(2798,'Charbatia'),(561,'Chariali'),(1916,'Charkhi Dadri'),(2557,'Charmapuri'),(2684,'Chavakkad'),(2393,'Chavara'),(2320,'Chemperi'),(2745,'Chemudugunta'),(439,'Chenbalam'),(2312,'Chengalpattu'),(424,'Chengalpet'),(1515,'Chengam'),(422,'Chengannur'),(327,'Chenglepet'),(2846,'Chengottoor'),(55,'Chennai'),(2538,'Chennaraopet'),(1720,'Chennimalai'),(2720,'Chernmahadevi'),(401,'Cherpu'),(1074,'Cherthala'),(1858,'Cheruthuruthy'),(1861,'Chettalli'),(2378,'Chettinad'),(2657,'Chevalla'),(1293,'Chevayur'),(1910,'Chevella'),(871,'Cheyyar'),(952,'Chhatarpur'),(291,'Chhindwara'),(2335,'Chhota Udepur'),(2788,'Chianki'),(1428,'Chicalim'),(1688,'Chickballapur'),(2636,'Chickkaballapur'),(3063,'Chickmagalore'),(807,'Chickmagalur'),(2951,'Chickmangore'),(56,'Chidambaram'),(2739,'Chikani'),(1497,'Chikballapur'),(2166,'Chikhaldara'),(3027,'Chikhali'),(1851,'Chikhli'),(1038,'Chikkaballapur'),(3106,'Chikkamagalur'),(2560,'Chikkanahalli'),(2564,'Chikmagalooru'),(292,'Chikmagalur'),(1004,'Chikodi'),(1967,'Chilakaluripet'),(2810,'Chilka'),(2963,'Chimakurthy'),(1895,'China Amiram'),(2409,'Chincholi'),(2209,'Chinna Salem'),(1758,'Chinnasalem'),(2602,'Chinoutapally'),(664,'Chinsurah'),(1147,'Chintamani'),(293,'Chiplun'),(792,'Chirala'),(3008,'Chirang'),(1969,'Chirawa'),(1800,'Chirmiri'),(2527,'Chitorgarh'),(2616,'Chitradurg'),(343,'Chitradurga'),(1412,'Chitrakoot'),(2722,'Chittivalasa'),(528,'Chittode'),(57,'Chittoor'),(643,'Chittor'),(1624,'Chittorgarh'),(2689,'Chiyyedu'),(2697,'Choondacherry'),(2820,'Chopan'),(2036,'Chopda'),(787,'Chorvad'),(2164,'Chowdavaram'),(2233,'Chumukedima'),(397,'Chundambatta'),(2084,'Chunkankadai'),(2516,'Churachandpur'),(1125,'Churu'),(1777,'Coch in'),(412,'Cochin'),(58,'Coimbatore'),(2608,'Coimbatyore'),(2547,'Colaghat'),(3139,'Colombo  7'),(3162,'Columbus Ohio'),(1524,'Combum'),(563,'Contai'),(799,'Cooch Behar'),(2659,'Coochbehar'),(577,'Coonoor'),(1069,'Courtallam'),(3167,'CT'),(588,'Cuddalore'),(1472,'Cuddapah'),(361,'Cumbum'),(3036,'Curchorem'),(59,'Cuttack'),(1779,'Cuttak'),(1852,'Dabhoi'),(2948,'Dahivel'),(2429,'Dahiwadi'),(1448,'Dahod'),(1585,'Daksin Dinajpur'),(2476,'Daldali'),(1060,'Dalhousie'),(3075,'Dallhousie'),(2554,'Dalli Rajhara'),(1722,'Dalmianagar'),(1440,'Daltonganj'),(702,'Daman'),(1746,'Daman and Diu'),(1866,'Damanjodi'),(1225,'Damoh'),(1612,'Dandeli'),(1605,'Dantewada'),(1049,'Dantiwada'),(1089,'Dapoli'),(60,'Darbhanga'),(432,'Darjeeling'),(1392,'Darrang'),(1091,'Darwha'),(2017,'Dasuya'),(866,'Datia'),(1240,'Dausa'),(61,'Davanagere'),(3087,'Davanagrer'),(62,'Davangere'),(3032,'Debari'),(1492,'Debinagar'),(1305,'Deepshikha'),(1234,'Deepsikha'),(2290,'Degloor'),(3057,'Deharadun'),(3093,'Dehardun'),(2845,'Dehra'),(63,'Dehradun'),(611,'Dehrudun'),(313,'Delhi'),(2719,'Delhi Cantt.'),(2572,'Deogarh'),(1155,'Deoghar'),(2414,'Deola'),(3011,'Deolali Camp'),(64,'Deoli'),(2295,'Deori'),(721,'Deoria'),(818,'Deralakatta'),(545,'Deralakatte'),(2107,'Dev Sangha'),(363,'Devakottai'),(2288,'Devanahalli'),(2153,'Devarakonda'),(2376,'Devgad'),(793,'Devlali'),(2076,'Devrukh'),(65,'Dewas'),(1427,'Dhakuakhana'),(1090,'Dhalavalpuram'),(1398,'Dhamangaon'),(1149,'Dhamisa'),(3029,'Dhamtar'),(1034,'Dhamtari'),(66,'Dhanbad'),(760,'Dhar'),(1847,'Dharampura'),(2935,'Dharampuram'),(836,'Dharamsala'),(2614,'Dharapuram'),(1631,'Dharbhanga'),(1449,'Dharmabad'),(332,'Dharmanagar'),(329,'Dharmapuri'),(1686,'Dharmasthala'),(1290,'Dharmavaram'),(756,'Dharmsala'),(67,'Dharwad'),(744,'Dharwar'),(1957,'Dhaulakuan'),(727,'Dhemaji'),(944,'Dhenkanal'),(1921,'Dhilwan'),(2224,'Dhing'),(499,'Dholka'),(1143,'Dholpur'),(1704,'Dhrol'),(2458,'Dhubri'),(68,'Dhule'),(2432,'Dhulipalla'),(2442,'Dhupguri'),(3108,'Dhuri (Sangrur)'),(2226,'Diamond Harbour'),(1077,'Dibiyapur'),(364,'Dibrugarh'),(3031,'Didhihat'),(553,'Didwana'),(1172,'Digapahandi'),(2635,'Digvijaygram'),(1007,'Dikrong'),(916,'Dimapur'),(2140,'Dimpapur'),(1157,'Dinajpur'),(2774,'Dinanagar'),(522,'Dindigal'),(513,'Dindigul'),(470,'Dindlod'),(2847,'Dindori'),(1597,'Dingigul'),(1795,'Diphu'),(2137,'Dirang'),(69,'Doddaballapur'),(2875,'Doddaballapura'),(565,'Doimukh'),(1102,'Dombivali'),(70,'Dombivili'),(739,'Dombiville East'),(768,'Dombivli'),(2322,'Dombivli (E)'),(1764,'Dombivli (W)'),(1124,'Dombivli East'),(71,'Dona Paula'),(2484,'Dongargarh'),(2808,'Donimalai'),(2754,'Doraha'),(3101,'Dousa'),(781,'Dudhondi'),(1119,'Dudhya'),(1388,'Dujana'),(1455,'Duliajan'),(2256,'Dumehar Bani'),(1080,'Dumka'),(2392,'Dumkal'),(1570,'Dumraon'),(2195,'Dundlod'),(1509,'Dungarpur'),(72,'Durg'),(73,'Durgapur'),(1579,'Durgpur'),(2132,'Dwarahat'),(1781,'Dwarka'),(2983,'E.G.Dist'),(892,'E.Godavari'),(605,'Eachome'),(1439,'Eambalam'),(1127,'East Godavari'),(1590,'East Siang'),(2491,'East Sikkim'),(2769,'East-Sikkim'),(1831,'Eastgodavari'),(1020,'Edat'),(74,'Edathala'),(2300,'Edathua'),(1897,'EG Dist'),(999,'Egra'),(2770,'Elagiri Hills'),(998,'Elamdesom'),(1201,'Elavunthitta'),(2054,'Elayampalayam'),(2257,'Elthuruth'),(1739,'Eluro'),(1297,'Eluru'),(2237,'Enathi'),(1442,'Erairimangalam'),(2066,'Erandol'),(906,'Erintalmanna'),(2495,'Ernakula'),(75,'Ernakulam'),(324,'Erode'),(516,'Eroor North'),(1244,'Errattupetta'),(2055,'Erumapatty'),(1431,'Erumeli'),(2930,'Esanthimangalam'),(1347,'Etah'),(76,'Etawah'),(386,'Ettumanoor'),(1349,'Ettuvaicode'),(339,'Faizabad'),(1995,'Faizpur'),(1912,'Farah'),(1549,'Faribabad'),(77,'Faridabad'),(1874,'Faridkot'),(1087,'Faridpur'),(78,'Farrukhabad'),(3028,'Fatehabad'),(1658,'Fatehgarh'),(2671,'Fatehgarh Sahib'),(1485,'Fatehpur'),(2767,'Ferozapur'),(495,'Ferozepur'),(2964,'Ferozpur'),(3136,'Firenze  50131'),(79,'Firozabad'),(2123,'FPO'),(2447,'G.B. Palayam'),(1135,'Gachbowli'),(752,'Gadag'),(1643,'Gadag Betageri'),(808,'Gadag Betgeri'),(3131,'Gadanki'),(2121,'Gadarwara'),(943,'Gadchiroli'),(2448,'Gadhinglaj'),(2193,'Gadohiroli'),(2664,'Gagra'),(2899,'Gagrigol'),(1736,'Gajapati'),(2728,'Ganapathipuram'),(1679,'Ganapavaram'),(1196,'Gandhigram'),(80,'Gandhinagar'),(1377,'Gandhinagarn'),(1279,'Gandhinglj'),(2082,'Ganeshguri'),(2058,'Gangakhed'),(3033,'Gangapur'),(2656,'Gangarampalayam'),(1117,'Gangtok'),(3010,'Ganguru'),(2503,'Ganj Basoda'),(1583,'Ganjam'),(860,'Ganjam Dist.'),(2579,'Ganjar'),(1776,'Gannavaram'),(1691,'Ganpat Ganj'),(3129,'Gantok'),(2934,'Garchiroli'),(2004,'Garhdiwala'),(2844,'Garhi'),(811,'Garhwal'),(2308,'Garsa'),(481,'Gauhati'),(759,'Gauribidanur'),(560,'Gawahati'),(81,'Gaya'),(1221,'Gaziabad'),(2314,'Gevrai'),(3112,'Gharuan'),(1000,'Ghatanji'),(2048,'Ghatkesar'),(82,'Ghaziabad'),(429,'Ghazipur'),(1944,'Ghedradi'),(1982,'Ghogaon'),(1554,'Gidderbaha'),(637,'Giridih'),(410,'Goa'),(1386,'Goalpara'),(1459,'Gobi'),(3121,'Gobindgarh'),(1863,'Godavarikhani'),(2287,'Godda'),(984,'Godhra'),(3102,'Gohana'),(2492,'Gohang'),(697,'Gohpur'),(2292,'Gokak'),(1324,'Gokarn'),(1600,'Gola Kheri'),(2833,'Golabandha'),(479,'Golaghat'),(1083,'Golghat'),(2587,'Gollalamamidada'),(784,'Gonda'),(1058,'Gondia'),(2452,'Goniana Mandi'),(2404,'Gonikoppal'),(2727,'Gooty'),(1654,'Gopalbazar'),(83,'Gopalpur'),(1966,'Gopalpur-on-Sea'),(840,'Gopalpuri'),(2710,'Gopeshwar'),(84,'Gorakhpur'),(2469,'Goregaon'),(468,'Gossaigaon'),(2876,'Gowribidanur'),(929,'Greater Noida'),(85,'Gubbi'),(3047,'Gudalur'),(1770,'Gudavalli'),(2878,'Gudibande'),(798,'Gudivada'),(1911,'Gudiyattam'),(2487,'Gudlavalleru'),(775,'Gudur'),(2998,'Gujapati'),(2069,'Gulabpura'),(2604,'Gulaothi'),(86,'Gulbarga'),(2119,'Guledagudda'),(2349,'Gulmarg'),(606,'Gummidi Poondi'),(555,'Guna'),(2505,'Gunjoti'),(1031,'Guntakal'),(87,'Guntur'),(1453,'Gunupur'),(646,'Guragon'),(1284,'Gurdaspur'),(88,'Gurgaon'),(2736,'Gurusar Sadar'),(2327,'Gurusar Sadhar'),(1339,'Guruvayur'),(1312,'Gusiahati'),(2775,'Guskara'),(89,'Guwahati'),(1819,'Guwajati'),(90,'Gwalior'),(1269,'Gyanpur'),(347,'H.S.Chandrapur'),(3074,'Habra'),(2643,'Hadgarh'),(2284,'Haflong'),(1410,'Hailakandi'),(857,'Hajipur'),(2653,'Haldi'),(1301,'Haldia'),(1804,'Haldwani'),(2763,'Haliyala'),(902,'Halkanangale'),(1994,'Halkarni'),(2212,'Halol'),(2813,'Halwara'),(2142,'Hamiprur'),(645,'Hamirpur'),(746,'Hanamkonda'),(1825,'Hansi'),(917,'Hanumanakonda'),(1317,'Hanumangarh'),(91,'Hapur'),(764,'Harapanahalli'),(1756,'Harbin'),(1815,'Harda'),(689,'Hardoi'),(788,'Hardwar'),(449,'Haridwar'),(1259,'Harihar'),(2172,'Harilakandi'),(1498,'Harinavi'),(1218,'Haripal'),(2817,'Harni Road'),(3140,'Harpenden Herts  A15 2JQ'),(3117,'Harur'),(600,'Haryana'),(1534,'Hasimara'),(92,'Hassan'),(1045,'Hathras'),(1629,'Hatiara'),(834,'Hatundi'),(2925,'Haveli'),(2556,'Haveli Ghanapur'),(1011,'Haveri'),(1471,'Hawal'),(2794,'Hayuliang'),(1622,'Hazarbag'),(377,'Hazaribag'),(523,'Hazratbal'),(3124,'Hebbagodi'),(3134,'Herts. SG1 2AY'),(1832,'Herwatta Kumta'),(1526,'Himantnagar'),(1247,'Himatnagar'),(2826,'Himmatnagar'),(1618,'Hindaun'),(419,'Hindupur'),(1479,'Hingoli'),(426,'Hiriadka'),(1767,'Hiriyur'),(3018,'Hiryur'),(93,'Hisar'),(751,'Hissar'),(1374,'Holanagadde'),(624,'Honnavar'),(349,'Hooghly'),(3044,'Hoogly'),(609,'Hosadurga'),(94,'Hosapete'),(512,'Hoshangabad'),(488,'Hoshiarpur'),(2882,'Hoskote'),(374,'Hospet'),(500,'Hosur'),(95,'Howrah'),(315,'Hridaypur'),(2217,'Hubballi'),(96,'Hubballi-Dharwad'),(487,'Hubli'),(1788,'Huderabad'),(2249,'Hulakoti'),(2704,'Humnabad'),(2621,'Hunagunda'),(2456,'Hungund'),(1860,'Hunsur'),(1405,'Hurda'),(1473,'Hutti P.O.'),(2789,'Huvinahadagali'),(2558,'Huzurabad'),(2898,'Hyderaabad'),(1951,'Hyderaad'),(97,'Hyderabad'),(1780,'Hyderanad'),(1775,'Hyderbad'),(1362,'Hyderqabad'),(1771,'Hydrabad'),(2260,'Ibrahimpatnam'),(98,'Ichalkaranji'),(628,'Ichlampady'),(2026,'Iduki'),(708,'Idukki'),(2343,'Ilakal'),(773,'Ilayangudi'),(648,'Ilhas'),(1563,'Ilhas Tiswani'),(1168,'Ilkal'),(99,'Imphal'),(506,'Imphal East'),(2482,'Indapur'),(2024,'Indirapuram'),(101,'Indore'),(2805,'Indunagar'),(1217,'Inodre'),(3166,'Iowa'),(734,'Irimpanam'),(589,'Irinjalakuda'),(2486,'Israna'),(576,'Isukkazhi'),(2215,'Itachuna'),(100,'Itanagar'),(2861,'Itarsi'),(1937,'Iyyengarkulam'),(2807,'Izat Nagar'),(543,'Izatnagar'),(102,'Jabalpur'),(1251,'Jadar'),(865,'Jadavpur'),(1518,'Jagadalpur'),(2477,'Jagadhri'),(2358,'Jagatballavpur'),(1557,'Jagatsinghpur'),(973,'Jagdalpur'),(2679,'Jagdishpur'),(2524,'Jagiroad'),(1872,'Jagraon'),(1165,'Jagtial'),(3039,'Jahanabad'),(2431,'Jaipru'),(103,'Jaipur'),(2691,'Jaipur Cantt'),(1774,'Jaisalmer'),(1316,'Jaitaran'),(1123,'Jajpur'),(2092,'Jakkasandra'),(104,'Jalandhar'),(2331,'Jalandhar Cantt'),(1769,'Jalaun'),(3056,'Jalesar'),(105,'Jalgaon'),(2995,'Jalgoan'),(106,'Jalna'),(652,'Jalpaiguri'),(937,'Jamalpur'),(2894,'Jamer'),(3019,'Jamkhani'),(2158,'Jamkhed'),(2138,'Jammikunta'),(107,'Jammu'),(1752,'Jammu & Kashmir'),(2841,'Jammu Cantt.'),(452,'Jammu Tawi'),(108,'Jamnagar'),(2196,'Jamner'),(1336,'Jamnipali'),(1243,'Jamnipalli'),(109,'Jamshedpur'),(762,'Jangaon'),(1900,'Janjgir'),(1899,'Janjgir-Champa'),(1137,'Jannur'),(1198,'Jaora'),(761,'Jarangdih Col'),(1323,'Jatharpeth'),(402,'Jaugaon'),(1809,'Jaumpur'),(520,'Jaunpur'),(732,'Jayant'),(1466,'Jayasingpur'),(2620,'Jaypore'),(2762,'Jaysingpur'),(636,'Jehanabad'),(1755,'Jerusalem'),(1265,'Jeypore'),(2830,'Jhabua'),(1010,'Jhajhar'),(1627,'Jhajjar'),(1550,'Jhalawar'),(1178,'Jhalgaon'),(110,'Jhansi'),(2490,'Jharia'),(1437,'Jharipani'),(420,'Jharkhand'),(1426,'Jharsugna'),(1009,'Jharsuguda'),(1659,'Jhinihak'),(2377,'Jhinkpani'),(309,'Jhunjhunu'),(1281,'Jind'),(2134,'Jintur'),(1322,'Jitpur'),(728,'Jobner'),(111,'Jodhpur'),(498,'Jogbani'),(1567,'Jogfalls'),(2786,'Jogindar Nagar'),(1238,'Jognbani'),(547,'Jorhat'),(2819,'Joshimath'),(1360,'Jowai'),(2504,'Joysagar'),(1925,'JP Nagar'),(663,'Junagadh'),(2366,'Junnar'),(593,'Jyotivihar'),(2583,'K Bandarapalli'),(2408,'K R Nagar'),(869,'K.G.F'),(838,'K.G.F.'),(2078,'K.M. Doddi'),(2501,'K.R. Nagar'),(2145,'K.R. Pet'),(1915,'Kada'),(2220,'Kadakkal'),(2384,'Kadakom'),(573,'Kadalundi'),(1267,'Kadamtala'),(112,'Kadapa'),(1744,'Kadara'),(1028,'Kadayanallur'),(2603,'Kadegaon'),(1320,'Kadiri'),(387,'Kadirur'),(1185,'Kadur'),(2550,'Kagithapuram'),(2030,'Kagwad'),(2307,'Kahalgaon'),(1886,'Kahn Pur Khui'),(715,'Kailashahar'),(2391,'Kaipattoor'),(661,'Kaithal'),(2891,'Kakanpur'),(2892,'Kakching'),(113,'Kakinada'),(2686,'Kakkad'),(128,'Kalady'),(2972,'Kalagampudi'),(946,'Kalahandi'),(2829,'Kalaikunda'),(1001,'Kalamassery'),(493,'Kalamb'),(1456,'Kalanour P.O'),(1086,'Kalapet'),(362,'Kalavai'),(2883,'Kalavakkam'),(2917,'Kalayarkoil'),(1904,'Kalburgi'),(919,'Kaliakavilai'),(2354,'Kalianpur'),(2073,'Kalimpong'),(2755,'Kalipatti'),(1958,'Kalippatti'),(2695,'Kaliyaganj'),(480,'Kaliyakavillai'),(2955,'Kalka'),(1510,'Kallachi'),(722,'Kalladka'),(1695,'Kallakurchi'),(2660,'Kallakurichi'),(2897,'Kallanthode'),(1403,'Kalliassery PO'),(1936,'Kallikkandy'),(1959,'Kallooppara'),(965,'Kallur'),(1662,'Kalmijore'),(2937,'Kalol'),(2982,'Kalol (NG)'),(114,'Kalpakkam'),(1791,'Kalpet'),(2683,'Kalpetta'),(835,'Kalugumalai'),(1491,'Kalui'),(1289,'Kalwa'),(2413,'Kalwan'),(649,'Kalyan'),(1766,'Kalyan (E)'),(1632,'Kalyan (W)'),(1064,'Kalyan (West)'),(1763,'Kalyan East'),(1556,'Kalyan Nagar'),(625,'Kalyan West'),(115,'Kalyan-Dombivali'),(116,'Kalyani'),(2367,'Kamakhyanagar'),(2916,'Kamalpur'),(117,'Kamarhati'),(660,'Kambhaladinne'),(1666,'Kampa'),(2184,'Kamptee'),(1208,'Kamrup'),(853,'Kanakapura'),(1268,'Kanale'),(3026,'Kanayakumari'),(1730,'Kancheepuram'),(1762,'Kanchi'),(2060,'Kanchikacherla'),(2662,'Kanchipadi'),(359,'Kanchipuram'),(821,'Kanchrapara'),(2061,'Kandaghat'),(1749,'Kandhamala'),(2075,'Kandhar'),(694,'Kandhla'),(1678,'Kandhwara'),(318,'Kandukur'),(2049,'Kangayam'),(1512,'Kangirapally'),(1022,'Kangra'),(458,'Kanhangad South'),(987,'Kanikapada'),(1603,'Kaniyakumari'),(1291,'Kaniyur'),(1062,'Kanjeepuram'),(497,'Kanjirapally'),(454,'Kanker'),(1617,'Kankipadu'),(1613,'Kankroli'),(2406,'Kannad'),(1737,'Kannauj'),(1385,'Kanniampuram'),(348,'Kannur'),(3079,'Kanour'),(118,'Kanpur'),(1353,'Kantore'),(1584,'Kanur'),(2984,'Kanuru'),(2939,'Kanya Kumari'),(3069,'Kanyakumar'),(119,'Kanyakumari'),(1598,'Kapurthala'),(1384,'Kapurthaza'),(699,'Karad'),(988,'Karadi'),(816,'Karaikal'),(120,'Karaikkudi'),(403,'Karaikudi'),(2922,'Karakambadi'),(2723,'Karakikudi'),(657,'Karamsad'),(1940,'Karanja'),(2015,'Karatadipalayam'),(1729,'Karauli'),(1065,'Karayamuttom'),(1759,'Karbi Anglog'),(982,'Karbi Anglong'),(1945,'Karepally'),(2500,'Kariapatti'),(874,'Kariavattom'),(2253,'Karigiri'),(2171,'Karikkad'),(2109,'Karimbam'),(384,'Karimganj'),(121,'Karimnagar'),(2531,'Karimpur'),(2396,'Karjat'),(2157,'Karkala'),(2385,'Karma'),(1334,'Karnal'),(1520,'Karnya'),(859,'Karopady'),(2532,'Karottukara'),(1792,'Karouli'),(1070,'Karukachal'),(896,'Karukutty'),(2039,'Karumathur'),(2353,'Karungal'),(2410,'Karunguzhi'),(371,'Karur'),(1177,'Karvenagar'),(1250,'Karwar'),(438,'Kasaragod'),(767,'Kasargod'),(451,'Kasargode'),(612,'Kasauli'),(2459,'Kasganj'),(583,'Kashipur'),(501,'Kashmir'),(1532,'Kasibugga'),(1483,'Kathgodam'),(2619,'Kathua'),(640,'Katihar'),(1930,'Katni'),(2029,'Katol'),(851,'Katpadi'),(1721,'Katra'),(1005,'Kattakada'),(394,'Kattakampal'),(1061,'Kattan Kulathur'),(122,'Kattankulathur'),(1252,'Kattappana'),(2565,'Kattor'),(598,'Katwa'),(1609,'Kaup'),(1684,'Kaushambi'),(326,'Kavali'),(2701,'Kavaraipettai'),(2782,'Kavaratti'),(3059,'Kavindapadi'),(2649,'Kawardha'),(2799,'Kayamkulam'),(1985,'Kayangulam'),(2033,'Kedgaon'),(2768,'Keelapazhuvur'),(1998,'Keeranur'),(2281,'Keesara'),(1329,'Keezhilam'),(2388,'Kelambakkam'),(1429,'Kendrapara'),(1228,'Keonjhar'),(405,'Kerala'),(1213,'KGF'),(2791,'Khagaria'),(123,'Khagrabari'),(2419,'Khairabad'),(837,'Khairaha'),(2823,'Khairi'),(2529,'Khajipalem'),(1844,'Khambhat'),(898,'Khamgaon'),(490,'Khammam'),(2962,'Khammam Dist'),(926,'Khamman'),(1608,'Khandwa'),(923,'Khanna'),(1572,'Khantura'),(124,'Kharagpur'),(1838,'Kharar'),(2573,'Khargaon'),(1953,'Khargone'),(815,'Kharia'),(2853,'Khariar'),(2513,'Khatav'),(2886,'Khatima'),(1487,'Kheda'),(1801,'Khedbrahma'),(572,'Khelmati'),(1206,'Kherange'),(2057,'Kherva'),(1199,'Khetari'),(472,'Khetri'),(2463,'Khopoli'),(1810,'Khordha'),(1607,'Khurda'),(3089,'Khurdha'),(2045,'Khuri Bari'),(2402,'Khurja'),(1796,'Kichha'),(2729,'Kidangoor'),(2502,'Kidaripatty'),(1229,'Kikkeri P.O.'),(2007,'Kilakarai'),(1164,'Kilimanoor'),(2117,'Kille Dharur'),(894,'Killimangalam'),(1059,'Killur'),(2289,'Kilpennathur'),(460,'Kim'),(2821,'Kinnaur'),(1839,'Kinwat'),(1296,'Kirandul'),(2992,'Kirathoor'),(2590,'Kirei'),(1942,'Kirikera'),(1205,'Kirloskarwadi'),(2926,'Kirtinagar'),(2600,'Kirumampakkam'),(125,'Kishangarh'),(2840,'Kishtwar'),(684,'Kittur'),(1717,'KK Dist'),(2936,'Klawad'),(2790,'Klyan'),(126,'Kochi'),(651,'Kochi 682'),(2609,'Kodad'),(527,'Kodagu'),(127,'Kodaikanal'),(2584,'Kodakara'),(1136,'Kodanchery'),(1681,'Kodavalur'),(1551,'Kodavasal'),(812,'Koderma'),(2904,'Kodigehally'),(2277,'Kodikanal'),(1223,'Kodungallur'),(641,'Kodur'),(1126,'Koduuayoor'),(3148,'Koganeishi 184-8795'),(1382,'Kohima'),(3105,'Kokata'),(951,'Kokrajhar'),(2248,'Kolaghat'),(1829,'Kolakata'),(1812,'Kolakta'),(491,'Kolar'),(1970,'Kolasib'),(1255,'Kolencherry'),(389,'Kolenchery'),(129,'Kolhapur'),(130,'Kolkata'),(131,'Kollam (Quilon)'),(323,'Komarapalayam'),(2945,'Komarapayayam'),(737,'Konch Jalan'),(2515,'Kondagaon'),(1907,'Kondair'),(2270,'Kondotty'),(2150,'Kondungallur'),(1380,'Konni'),(1369,'Koodalloor'),(2748,'Koothattukulam'),(2016,'Kopargaon'),(1303,'Koppa'),(688,'Koppal'),(2738,'Korangi'),(927,'Koraput'),(132,'Korba'),(2784,'Korea'),(378,'Koregaon'),(2777,'Korukonda'),(681,'Kostha'),(530,'Kot Kapura'),(2382,'Kot-Ise-Khan'),(133,'Kota'),(2420,'Kotagiri'),(134,'Kotala'),(1373,'Kotdwar'),(662,'Kothad'),(1906,'Kothadudem'),(620,'Kothagudem'),(995,'Kothala'),(1922,'Kothamangalam'),(2276,'Kothapar'),(1587,'Kothapet'),(1154,'Kothapeta'),(1521,'Kothecheruvu'),(2910,'Kottakkal'),(2668,'Kottappady'),(2154,'Kottapuram'),(1145,'Kottarakara'),(325,'Kottayam'),(2575,'Kottekad'),(1146,'Kottur'),(2163,'Kotturu'),(1372,'Kovilpatti'),(1505,'Kovvur'),(644,'Kowdiar'),(2680,'Kozhancherry'),(1216,'Kozhencheery'),(1972,'Kozhencheri'),(823,'Kozhikkode'),(393,'Kozhikode'),(135,'Kozhikode (Calicut)'),(1003,'Kozhikodi'),(1724,'Kozhizode'),(1751,'Krimnagar'),(136,'Krishangarh'),(306,'Krishna'),(1277,'Krishna Dist'),(305,'Krishnagar'),(307,'Krishnagiri'),(2336,'Krishnagri'),(2070,'Krishnankoil'),(308,'Krishnapuram'),(2493,'Krishnarajapete'),(1628,'Kudal'),(489,'Kudremukh'),(2623,'Kukas'),(1351,'Kukkundoor'),(2185,'Kulamavu'),(1053,'Kulanada'),(1660,'Kuldharan'),(1811,'Kulithalai'),(1709,'Kullu'),(137,'Kulti'),(1023,'Kumaracoil'),(875,'Kumarapatnam'),(1318,'Kumarhatti'),(1118,'Kumata'),(1105,'Kumbakoman'),(486,'Kumbakonam'),(1352,'Kumbhargaon'),(1441,'Kumbla P.O.'),(2889,'Kumhari'),(1889,'Kumily'),(508,'Kumta'),(2706,'Kundankulam'),(1594,'Kundapur'),(1955,'Kundapura'),(3040,'Kunigal'),(1511,'Kunnamangalam'),(1302,'Kunnamkulam'),(138,'Kuppam'),(2725,'Kupwad'),(2946,'Kupwars'),(813,'Kuravilangad'),(723,'Kurkunta'),(2611,'Kurnnol'),(139,'Kurnool'),(140,'Kurseong'),(2771,'Kurukkathi'),(142,'Kurukshetra'),(141,'Kushalnagar'),(1523,'Kushinagar'),(580,'Kusiapal'),(379,'Kustagi'),(791,'Kusumba'),(396,'Kutch'),(1350,'Kuthambalkkam'),(1356,'Kuttapatti'),(1328,'Kuttipuram'),(1342,'Kuttoor'),(1920,'Kuwaritol'),(2677,'Kuzhithurai'),(634,'Lachhmangarh'),(1750,'Ladakh'),(3072,'Ladnun'),(3147,'Laguna'),(2633,'Lahdoigarh'),(503,'Laheri Sarai'),(2423,'Lakhaoti'),(1438,'Lakhimpur'),(2387,'Lakhimpur-Kheri'),(2536,'Lakhtar'),(2718,'Lakkidi'),(910,'Lakshadweep'),(1824,'Lakshmangarh'),(473,'Lakurdi'),(642,'Lalganj'),(1727,'Lalitpur'),(1884,'Lamphelpat'),(2598,'Landran'),(143,'Larambha'),(2159,'Lasalgaon'),(2577,'Latehar'),(144,'Latur'),(2246,'Laulara'),(2900,'Laxmidevipally'),(2811,'Laxmiposi'),(1333,'Leh Ladakh'),(2818,'Leh-Ladakh'),(1578,'Lembucherra'),(2585,'Levengipuram'),(345,'Liluah'),(2243,'Limda'),(1846,'Linch'),(827,'Lludhiana'),(2223,'Lodhivali'),(2652,'Loha'),(2316,'Lohardaga'),(2540,'Lohit'),(3016,'Loktak'),(2364,'Lonand'),(145,'Lonavala'),(559,'Lonavla'),(3138,'London  W.C. 2'),(3142,'London W1J 0BA'),(2202,'Lonere'),(2379,'Longowal'),(146,'Loni'),(2037,'Lopan'),(147,'Lucknow'),(148,'Ludhiana'),(521,'Luknow'),(2457,'Lumding'),(2938,'Lunawada'),(2485,'Lunglei'),(3100,'Lushalnagar'),(2741,'Lutunia'),(2639,'M. Nidamalur'),(2127,'Machalipatnam'),(2562,'Macherla'),(526,'Machhra'),(966,'Machilipatnam'),(1274,'Madanapalle'),(1210,'Madanapalli'),(1098,'Madathukulam'),(1239,'Maddilapalam'),(2711,'Maddirala'),(899,'Madhappur'),(638,'Madhepura'),(904,'Madhubani'),(2451,'Madhubani PO'),(1813,'Madhupur'),(810,'Madhuranagar'),(149,'Madikeri'),(747,'Madras'),(1162,'Madura'),(150,'Madurai'),(1785,'Maduri'),(2873,'Magadi'),(1745,'Magpur'),(1527,'Mahaboob Nagar'),(1637,'Mahaboobnagar'),(743,'Mahabubnagar'),(3007,'Mahabumnagar'),(1052,'Mahad'),(2371,'Mahanandi'),(1732,'Maharaganj'),(1817,'Maharajganj'),(2913,'Mahasamund'),(2953,'Mahbubnagar'),(414,'Mahe'),(2439,'Mahendergarh'),(1355,'Mahendragarh'),(2318,'Mahendragiri'),(3094,'Mahesana'),(151,'Maheshtala'),(152,'Mahishadal'),(1294,'Mahoba'),(153,'Mahuva'),(2546,'Mailam'),(991,'Maindargi'),(1490,'Mainpuri'),(2251,'Majalgaon'),(883,'Majikuchi'),(532,'Makkuva'),(1708,'Makronia Sagar'),(444,'Mala'),(2347,'Malagi'),(679,'Malakkara'),(370,'Malappuram'),(615,'Malapuram'),(2115,'Malayadi'),(319,'Malda'),(154,'Malegaon'),(2885,'Malerkotla'),(2218,'Maliankara'),(2858,'Malikipuram'),(2610,'Malkapur'),(2291,'Mallampudi'),(1599,'Mallapally'),(1499,'Mallappally'),(1568,'Mallappuram'),(1850,'Mallasamudram W'),(2551,'Mallavadi'),(1151,'Malout'),(2207,'Mamallapuram'),(2746,'Manakkappady'),(435,'Manali'),(776,'Mananthavady'),(1313,'Mananvilai'),(2750,'Manargudi'),(2204,'Manassery'),(155,'Manauli'),(2828,'Manauri'),(2705,'Manbazar'),(2866,'Manchar'),(1079,'Mancherial'),(1325,'Mandapam Camp'),(1799,'Mandapeta'),(938,'Mandi'),(2302,'Mandi Dabwali'),(1046,'Mandla'),(2177,'Mandsaur'),(369,'Mandya'),(2545,'Manesar'),(575,'Mangalagangotri'),(1408,'Mangalbari'),(2796,'Mangaldai'),(3046,'Mangalloi'),(1888,'Mangalooru'),(156,'Mangalore'),(826,'Mangalpadi'),(893,'Mangalpady'),(1278,'Manglagangotri'),(2020,'Mangrulpir'),(2645,'Mani Majra'),(157,'Manipal'),(400,'Manjeri'),(2780,'Manjoor'),(1973,'Manjri'),(2179,'Mankhal'),(617,'Mankipur'),(2673,'Manmad'),(477,'Mannachanallur'),(406,'Mannam'),(2359,'Mannampadal'),(1856,'Mannampandal'),(1134,'Mannanam'),(320,'Mannargudi'),(1357,'Mannuthy'),(1667,'Manpur'),(1260,'Mansa'),(877,'Mansi'),(1514,'Manthiyoor'),(3120,'Manvi'),(602,'Mapusa'),(2488,'Marampally'),(1103,'Marbisu'),(2206,'Marcela'),(1015,'Margao'),(2129,'Margherita'),(1947,'Mariahu'),(1365,'Marigaon'),(2724,'Markanda'),(2104,'Markapur'),(970,'Marsaghai'),(461,'Martandam'),(2155,'Maruthakulam'),(1057,'Masa Kali Patti'),(2156,'Masinagudi'),(1868,'Mastuana Sahib'),(158,'Mathura'),(2961,'Matlapalem'),(1071,'Mattannur'),(511,'Mattanur'),(2365,'Mattupatti'),(159,'Mau'),(2520,'Maunath Bhanjan'),(1311,'Mavelikara'),(2672,'Mayabunder'),(1663,'Mayagonahalli'),(956,'Mayiladuthurai'),(1816,'Mayilladuthurai'),(1378,'Maylladuthuri'),(934,'Mayurbhang'),(1530,'Mayurbhanj'),(3048,'Maza Rahikpur'),(2106,'Maza Rahirpur'),(3163,'MD'),(3152,'MD 20814'),(1390,'Medak'),(2548,'Medchal'),(507,'Medinipur'),(1207,'Medziphema'),(1095,'Meenangadi'),(160,'Meerut'),(839,'Meerut Cantt'),(430,'Meeurt'),(2797,'Meghahatuburu'),(1469,'Meghalaya'),(789,'Mehabubnagar'),(2245,'Mehesana'),(367,'Mehkar'),(510,'Mehsana'),(790,'Mehsana Dist'),(1890,'Meignanapuram'),(2240,'Melaiyur'),(2923,'Melakodumalur'),(872,'Melappuram'),(1543,'Melattur'),(2390,'Mele Pattambi'),(2381,'Melmaruvathur'),(2523,'Melmuri'),(700,'Melvisharam'),(415,'Meppayur'),(1855,'Mesra'),(1344,'Metpally'),(1880,'Mettupalayan'),(1212,'Mettur'),(1673,'Mettur Dam'),(2002,'Mianpur'),(2920,'Midayikunnu'),(418,'Midnapore'),(682,'Midnapur'),(2334,'Minjur'),(161,'Mira-Bhayandar'),(1406,'Miraj'),(2401,'Miran Sahib'),(1636,'Mirijapur'),(2803,'Mirual'),(1233,'Miryalaguda'),(1330,'Mirza'),(162,'Mirzapur'),(1037,'Mizoram'),(948,'Modasa'),(3080,'Moddbidri'),(1232,'Modinagar'),(1379,'Modipara'),(3024,'Modusa'),(1051,'Moga'),(705,'Mogalikuduru'),(2355,'Mogra'),(2283,'Mohai'),(2989,'Mohail'),(163,'Mohali'),(433,'Mohanpur'),(2740,'Mohinder Garh'),(1849,'Mohindergarh'),(2848,'Mohitnagar'),(736,'Mokama'),(2825,'Mokamaghat'),(901,'Mokeri'),(2241,'Mokochung'),(928,'Mokokchung'),(1332,'Monippally'),(376,'Moodabidri'),(2960,'Moodbidiri'),(587,'Moodbidri'),(2862,'Moodlakatte'),(2914,'Moothakunnam'),(164,'Moradabad'),(2522,'Moranhat'),(2849,'Morena'),(554,'Morigaon'),(1189,'Morshi'),(165,'Motihari'),(2981,'Movva'),(2700,'MPR Dam'),(1797,'Muddebihal'),(2064,'Mudhol'),(552,'Mudigere'),(895,'Mukalmua'),(2630,'Mukandpur'),(2850,'Mukerian'),(1364,'Mukkam'),(2394,'Muktainagar'),(2309,'Muktsar'),(2133,'Mulabagal'),(2879,'Mulabagalu'),(1245,'Mulakalacheruvu'),(2074,'Mulkalla'),(599,'Mulki'),(2959,'Mullana'),(1285,'Mullanpur'),(1321,'Mullikolathur'),(2282,'Mulloorkara'),(166,'Mumbai'),(1909,'Mumbakonam'),(1640,'Mumbi'),(2599,'Mumbra'),(2773,'Munanjipatti'),(1048,'Mundalur'),(2974,'Mundargi'),(1341,'Munduparamba'),(2386,'Mundur'),(1803,'Mungeli'),(635,'Munger'),(2742,'Munipalli'),(336,'Munnar'),(1286,'Munnur'),(1882,'Mupusa'),(1422,'Murdeshwar'),(2422,'Murickassery'),(391,'Murshidabad'),(1700,'Murtizapur'),(1308,'Murum'),(2110,'Musiri'),(1672,'Mussoorie'),(1919,'Muthorai'),(2165,'Muthukur'),(3065,'Muthur'),(914,'Muvattupuzha'),(167,'Muzaffarnagar'),(168,'Muzaffarpur'),(1270,'Muzzafarnagar'),(1865,'Myladumpara'),(2772,'Mylavaram'),(1857,'Mysooru'),(169,'Mysore'),(2986,'N 24 Parganas'),(2124,'N.Pudhupatti'),(2552,'N.R. Palle'),(1461,'Nabha'),(1508,'Nacharam'),(170,'Nadia'),(551,'Nadiad'),(1161,'Nagai'),(352,'Nagaland'),(546,'Nagaon'),(466,'Nagapattinam'),(1253,'Nagarcoil'),(1122,'Nagarjuna Nagar'),(950,'Nagaur'),(171,'Nagercoil'),(3098,'Nagour'),(172,'Nagpur'),(2450,'Nagrakata'),(2236,'Nagunur'),(959,'Nahan'),(1714,'Naida'),(173,'Naihati'),(174,'Nainital'),(2311,'Najibabad'),(1029,'Naka Dongri'),(2297,'Nalagnda'),(1141,'Nalagonda'),(710,'Nalanda'),(1144,'Nalbari'),(446,'Nalgonda'),(2626,'Nalgonds'),(2997,'Naliya'),(2370,'Nalkalikkal'),(322,'Namakkal'),(1354,'Nambol'),(2996,'Namti'),(175,'Nanded'),(1116,'Nandeuri'),(566,'Nandgaon'),(1773,'Nandigama'),(2046,'Nandikotkur'),(806,'Nandurbar'),(1026,'Nandyal'),(2003,'Nangal'),(2716,'Nangali'),(2211,'Nangiarkulangar'),(176,'Nangloi Jat'),(2688,'Nanjanagudu'),(1644,'Nanjangud'),(1706,'Napaam'),(1873,'Napur'),(1760,'Narasapur'),(1006,'Narasaraopet'),(1182,'Narasinganet'),(2021,'Narasipatnam'),(2262,'Narasipuram'),(2436,'Narayanapura'),(2345,'Narayanpet'),(2350,'Naregal'),(2915,'Narendrapur'),(1540,'Narnaul'),(469,'Narsapur'),(1371,'Narsinghpur'),(330,'Narukara'),(2676,'Narwapahar'),(177,'Nashik'),(672,'Nasik'),(2148,'Nasrapur'),(2855,'Natepute'),(2702,'Nathdwara'),(2380,'Natipora'),(711,'Nattika'),(3041,'Naugachia'),(1869,'Nauni'),(1055,'Nausari'),(2615,'Navagam'),(2280,'Navalur'),(2360,'Navapur'),(2696,'Navi Mumai'),(178,'Navi Mumbai'),(1793,'Navli'),(1159,'Navsari'),(1619,'Nawada'),(2190,'Nawagarh'),(1150,'Nawalgarh'),(1413,'Nawanshah Dt'),(925,'Nawanshahr'),(2383,'Nawanshehr'),(1651,'Nawarangpur'),(1184,'Nawargaon'),(2647,'Naya Bazar'),(1368,'Naya Nangal'),(1121,'Nayagarh'),(1078,'Nayarkuzhi'),(2869,'Nayudupet'),(2460,'Nazareth'),(658,'Nazira'),(1834,'NC'),(584,'Nedumangad'),(2499,'Nedumkandam'),(610,'Nedumkunnam'),(2987,'Neeleswaram'),(755,'Neemuch'),(2001,'Neemuch Cant.'),(1193,'Nelakondapally'),(2977,'Nelamangala'),(1033,'Nellimoodu'),(1075,'Nellippara'),(179,'Nellore'),(2713,'Neriamangalam'),(411,'Nerparsopant'),(782,'Nesari'),(2533,'Nettana'),(180,'New Delhi'),(2890,'New Kamptee'),(1314,'New Mahe'),(880,'New Mumbai'),(693,'New Panvel'),(2125,'New Panvel (W)'),(692,'New Tehri'),(1842,'New VV Nagar'),(3135,'New York  10024 - 5192'),(2160,'Newasa'),(1331,'Neyveli'),(1345,'Neyyoor'),(2644,'Nicobar'),(2317,'Nidadavole'),(544,'Nidasoshi'),(2699,'Nigahi'),(340,'Nilambur'),(2685,'Nilambur RS'),(717,'Nilanga'),(537,'Nileshwar'),(864,'Nilgiris'),(2305,'Nilgris'),(3004,'Nillikuppam'),(2118,'Nimpith Ashram'),(1399,'Nintanehati'),(2444,'Nipani'),(1875,'Niphad'),(2443,'Nippani'),(1158,'Nirakarpur'),(181,'Nirjuli'),(182,'Nirmal'),(1394,'Nirmalagiri'),(183,'Nischintakoili'),(1943,'Nitte'),(184,'Nizamabad'),(3164,'NJ'),(3157,'NJ 08055'),(185,'Noida'),(3050,'Nongpoh'),(2042,'Nongstoin'),(2909,'Nooranad'),(758,'North Dinajpur'),(186,'North Dumdum'),(328,'North Lakhimpur'),(2181,'North24Parganas'),(2929,'Nowgam'),(824,'Nowgong'),(2859,'Nuagam'),(1104,'Nuapada'),(2232,'Nuvem'),(2663,'Nuzvid'),(1789,'Oantnagar'),(2627,'Obedullaganj'),(2670,'Oddanchatram'),(3144,'Ohio 43210-0012'),(2239,'Ojhar'),(1845,'Okkur'),(1414,'Olakettiampalam'),(2027,'Old Goa'),(2965,'Olhapur'),(1978,'Omerga'),(1264,'Ongole'),(2880,'Ooragam'),(344,'Ootacamund'),(1593,'Ooty'),(1138,'Orai'),(2941,'Orathanad'),(1835,'Oregon IL'),(578,'Orissa'),(974,'Osmanabad'),(945,'Othera'),(1387,'Ottapalam'),(887,'Otur'),(3149,'Oxon  OX10 8DF'),(187,'Ozhukarai'),(2778,'P Medinipur'),(2372,'P Seeragapadi'),(1420,'P. Nilayam'),(1918,'P.Medinipore'),(905,'P.Nilayam'),(2173,'Pachal'),(2966,'Pacheri Bari'),(2186,'Pachmarhi'),(765,'Pachora'),(517,'Pacode'),(1276,'Padanakkad'),(1326,'Padannakkad'),(2421,'Padannekkad'),(3130,'Padappai'),(2506,'Padhiana'),(1862,'Padnekat'),(2514,'Padra Tal'),(1257,'Padruna'),(740,'Padur'),(2518,'Paipad'),(2090,'Paiyanoor'),(2417,'Pakakkad'),(447,'Pakharpura'),(1902,'Pakur'),(3127,'Pakyong'),(2031,'Pakyoung'),(960,'Pala'),(338,'Palacode'),(1761,'Palai'),(1610,'Palakad'),(188,'Palakkad'),(844,'Palakol'),(2525,'Palamaner'),(3082,'Palamau'),(659,'Palampur'),(1142,'Palani'),(380,'Palanpur'),(785,'Palapur'),(833,'Palayad'),(2543,'Palayakottai'),(409,'Palayamkottai'),(1687,'Palayampatti'),(1601,'Palayankottai'),(619,'Palem'),(1085,'Palemad'),(1404,'Palghar'),(3055,'Palghar (East)'),(920,'Palghat'),(189,'Pali'),(1924,'Pali Marwar'),(2921,'Paliabindha'),(1525,'Pallam'),(1191,'Pallatheri'),(2083,'Pallavur'),(670,'Palode'),(1082,'Paloncha'),(2839,'Palta'),(2455,'Palus'),(1272,'Palwal'),(1287,'Palyamkottai'),(2561,'Pampadumpara'),(2480,'Pampady'),(1097,'Pampady South'),(2071,'Pampore'),(712,'Panagal Post'),(321,'Panaji'),(1894,'Panangad'),(1227,'Panayur'),(2785,'Panchgani'),(190,'Panchkula'),(2342,'Panchmahal'),(1559,'Panchukla'),(1014,'Pandalam'),(2352,'Pandaul'),(1657,'Pandharpur'),(1905,'Pangode'),(191,'Panihati'),(192,'Panipat'),(1451,'Panipet'),(1129,'Panjim'),(1463,'Panjuaur PO'),(1477,'Panna'),(1188,'Panpoli'),(354,'Panruti'),(1433,'Panrutin'),(337,'Pantnagar'),(193,'Panvel'),(2884,'Paprola'),(2669,'Paradip'),(2815,'Paradip Port'),(889,'Parangipettai'),(618,'Parappanangadi'),(194,'Parasia'),(1501,'Parassinikadava'),(1457,'Parathode P.O.'),(769,'Parbatpur'),(195,'Parbhani'),(2087,'Parlakhemundi'),(2203,'Parli-Vaijnath'),(1980,'Parmathi'),(1648,'Parola'),(1111,'Parrathipuram'),(994,'Parunde'),(350,'Paruvakkudi'),(1956,'Parvatipuram'),(1093,'Parwanoo'),(1630,'Pashan'),(1580,'Pasighat'),(372,'Patan'),(1013,'Patana'),(197,'Patancheru'),(1517,'Patba'),(2944,'Patel Guda'),(1680,'Pathamthitta'),(647,'Pathanamthitta'),(1215,'Pathanapuram'),(754,'Pathankot'),(2641,'Pathanpuram'),(2438,'Pathardi'),(196,'Patiala'),(2871,'Patkura'),(198,'Patna'),(2690,'Patna Sahib'),(2019,'Patoda'),(2824,'Patratu'),(1484,'Pattambi'),(2764,'Pattamundai'),(2136,'Pattan'),(2340,'Patti'),(2286,'Pattikkad'),(465,'Pattithara'),(1475,'Pauagada Taluk'),(1054,'Pauri'),(2357,'Pauri Garhwal'),(2747,'Pavanasam'),(1309,'Pavaratty'),(1934,'Pavitram'),(2008,'Pavoorchatram'),(2507,'Payakaraopeta'),(2903,'Payangadi'),(725,'Payyannur'),(436,'Payyanur'),(1914,'Payyoli'),(786,'Pedagantyada'),(3126,'Pedavegi'),(961,'Peddapuram'),(1901,'Peechi'),(1606,'Peermade'),(3000,'Pehowa'),(863,'Pen'),(2865,'Pendra'),(770,'Penugonda'),(199,'Perambalur'),(2733,'Peravurani'),(2268,'Peringamala'),(2238,'Peringammala'),(1099,'Periyakulam'),(200,'Pernem'),(1235,'Perumbavoor'),(614,'Perundurai'),(2162,'Peruvallur'),(1513,'Pervmbavoor'),(2588,'Pethappampatti'),(841,'Petlad'),(1024,'Peyad'),(1041,'Phagwara'),(1088,'Phaltan'),(3133,'Philadelphia, PA 19130'),(3141,'Philadelphia, PA. 19103'),(992,'Phillaur'),(912,'Pichalaguri'),(748,'Pilani'),(1417,'Pilathara'),(2065,'Pilerne Bardez'),(2625,'Pilibhit'),(971,'Pimpalgaon'),(1661,'Pimpalner'),(201,'Pimpri-Chinchwad'),(3009,'Piparia'),(3114,'Pipariya'),(2440,'Piravom'),(2025,'Piska Nagari'),(202,'Pithoragarh'),(993,'Poarayar'),(2539,'Podakkudi'),(724,'Podili'),(2801,'Pokharan'),(2851,'Pokharipur'),(534,'Pollachi'),(907,'Ponda'),(2293,'Ponkunnam'),(2180,'Ponnala'),(2139,'Ponnampet'),(2135,'Ponnampete'),(2242,'Ponnani South'),(1993,'Ponneri'),(2753,'Ponniakurssi'),(1421,'Ponpadi'),(2787,'Pooch'),(1107,'Poochakkal'),(1933,'Poondi'),(1757,'Poonjar'),(2144,'Poonjeri'),(445,'Poothotta'),(2971,'Poovanthi'),(463,'Porabandar'),(849,'Porayar'),(525,'Porbandar'),(1304,'Port Balir'),(535,'Port Blair'),(1447,'Portonovo'),(1443,'Poruvazhi P.O.'),(750,'Poruvazhy'),(2567,'Porvorim'),(2187,'Pottapalayam'),(1765,'Powai'),(518,'Prakasam'),(3022,'Prakasam Dist'),(1539,'Prakashsam'),(1452,'Prasanthinilayam'),(203,'Prasanti Nilayam'),(3091,'Pratapgarah'),(1209,'Pratapgarh'),(464,'Pritinagar'),(1389,'Proddatur'),(809,'Pudikkottai'),(1747,'Pudikottai'),(204,'Puducherry'),(1616,'Pudukkottai'),(666,'Pudukottai'),(1175,'Pulgaon'),(2613,'Puliangudi'),(983,'Pulivendla'),(1393,'Pulivendula'),(529,'Pullazhi'),(1495,'Pulwama'),(2062,'Pundibari'),(2908,'Pundri'),(205,'Pune'),(2958,'Punkunnan'),(2687,'Puranattukara'),(1784,'Purba'),(1950,'Purba Medinipur'),(3104,'Purba Midnapur'),(310,'Puri'),(2526,'Purna'),(3066,'Purnea'),(206,'Purnia'),(668,'Purulia'),(1677,'Pusa'),(316,'Pusad'),(1964,'Puthanampatti'),(1690,'Puthenchira'),(2462,'Puthenpalli'),(1425,'Puthenthurai'),(1741,'Puthukkottai'),(1056,'Puttaparthi'),(1589,'Puttarparthi'),(962,'Puttur'),(594,'Qadian'),(2389,'Quepem'),(443,'Quilon'),(1343,'Qummalur'),(1734,'R R Dist'),(2947,'R R Dist.'),(1807,'R R District'),(2445,'R.Chodavaram'),(2757,'R.R.Dist'),(1214,'Racnhi'),(207,'Radaur'),(1641,'Rae Bareli'),(1738,'Raebareli'),(2667,'Raggad'),(2650,'Raghogarh'),(3090,'Rahtak'),(1948,'Rahuri'),(208,'Raichur'),(632,'Raigad'),(1432,'Raigad Dist'),(571,'Raiganj'),(918,'Raigarh'),(1481,'Raigudh'),(209,'Raipur'),(3013,'Raisen'),(210,'Rajahmundry'),(2555,'Rajakkamangalam'),(654,'Rajam'),(2528,'Rajampet'),(1702,'Rajapalaiyam'),(846,'Rajapalayam'),(567,'Rajapuram'),(2275,'RajaRammohunpur'),(2034,'Rajborasambar'),(978,'Rajeshwar'),(2601,'Rajgangapur'),(1935,'Rajgangpur'),(1503,'Rajgir'),(2407,'Rajgurunagar'),(2860,'Rajkanika'),(211,'Rajkot'),(633,'Rajnagar'),(2465,'Rajnandgaon'),(1748,'Rajouri'),(690,'Rajpipla'),(212,'Rajpur Sonarpur'),(1928,'Rajpura'),(2113,'Rajsamand'),(2617,'Rajura'),(213,'Ramagundam'),(1693,'Ramanagara'),(1319,'Ramanagaram'),(1113,'Ramanathapuram'),(2776,'Ramapuram'),(459,'Ramchandrapuram'),(1893,'Ramdurg'),(1814,'Ramgarh'),(2842,'Ramgarh Cantt.'),(953,'Ramnad'),(2761,'Ramnagar'),(989,'Rampachodavaram'),(214,'Rampur'),(407,'Rampura'),(2629,'Rampurhat'),(2093,'Ramtek'),(1063,'Ranaghat'),(2760,'Ranchaidham'),(215,'Ranchi'),(2278,'Rang Reddy'),(1531,'Ranga Reddy'),(1975,'Ranga Reddy Dis'),(2102,'Ranga ReddyDist'),(2182,'Rangal Reddy'),(2979,'Rangareddy'),(2973,'Rangareddy Dist'),(2301,'RangareddyDist'),(867,'Rangia'),(2479,'Ranibennur'),(1996,'Ranichauri'),(2468,'Raniganj'),(730,'Ranipet'),(2323,'Ranny'),(2494,'Rapalle'),(955,'Rasipuram'),(1194,'Ratanpur'),(216,'Ratlam'),(217,'Ratnagiri'),(2198,'Raver'),(1220,'Rawathbhata'),(819,'Rayagada'),(1282,'Rayarangoth'),(2509,'Rayavaram'),(1415,'Rayya'),(1696,'Razole'),(540,'Reasi'),(2570,'Rehli'),(1462,'Renukoot'),(1167,'Repalle'),(218,'Rewa'),(850,'Rewari'),(2333,'Ri Bhoi Dist'),(1494,'Rishi Valley'),(627,'Rishikesh'),(2881,'Robertsonpet'),(975,'Roha'),(219,'Rohtak'),(1604,'Rohtas'),(1027,'Roopnagar'),(220,'Roorkee'),(800,'Ropar'),(1292,'Rorkela'),(1782,'Rourkee'),(221,'Rourkela'),(2765,'Royakottah'),(1896,'RR Dist'),(2943,'RR District'),(3116,'Rrichy'),(3053,'Rudraprayag'),(3122,'Rudrapur'),(2887,'Rupai Siding'),(3064,'S 24 Parganas'),(1977,'S Kaghaznagar'),(317,'S S Nallur'),(1962,'S.A.S.Nagar'),(891,'S.Kanara'),(2012,'S.Krushinagar'),(1574,'Sabarkantha'),(1859,'Sabarkhnatha'),(2205,'Sadanandapuram'),(2221,'Sadra'),(1798,'Safidon'),(222,'Sagar'),(1101,'Sahaganj'),(223,'Saharanpur'),(1181,'Saharsa'),(595,'Sahibganj'),(2574,'Sai Vihar'),(1683,'Saidabad'),(2258,'Sailu'),(1989,'Sakaleshapura'),(2274,'Sakaleshpura'),(1348,'Sakali'),(2267,'Sakoli'),(2227,'Sakthinagar'),(2363,'Salcete'),(3110,'Salcette'),(2483,'Saldiha'),(3119,'Salekasa'),(224,'Salem'),(1685,'Saligao'),(2563,'Salipur'),(779,'Salur'),(2535,'Samana'),(331,'Samastipur'),(225,'Sambalpur'),(1283,'Sambhal'),(1891,'Sambhalkha'),(1109,'Sambra'),(434,'Samsi'),(842,'Sanagamner'),(1642,'Sanawad'),(774,'Sanawar'),(538,'Sanchi'),(596,'Sandur'),(1383,'Sangamner'),(482,'Sangli'),(852,'Sangli Dist.'),(226,'Sangli-Miraj & Kupwad'),(2321,'Sangola'),(2116,'Sangole'),(1338,'Sangrur'),(3037,'Sanguem'),(1582,'Sankarankovil'),(2088,'Sankeshwar'),(514,'Sankhali'),(2341,'Sanosara'),(564,'Sanquelim'),(227,'Santiniketan'),(2800,'Santragachi'),(3155,'Sao Pavlo 01222-010'),(2188,'Saoner'),(1409,'Sarang'),(2985,'Sardarshahr'),(3002,'Sarguja'),(3095,'Sarhali'),(2230,'Sarkaghat'),(2678,'Sarood'),(1881,'Saroornagar'),(2201,'Sarsa'),(2816,'Sarsawa'),(1478,'Sarugani'),(228,'SAS Nagar'),(2022,'Sasthamcotta'),(1381,'Sasthamcottah'),(2103,'Sasthamkotta'),(2210,'Saswad'),(1396,'Satana'),(229,'Satara'),(2018,'Sathiyamangalam'),(2497,'Sathupalli'),(900,'Sathupally'),(1848,'Sathyamangalam'),(230,'Satna'),(977,'Satsang'),(1552,'Sattur'),(1468,'Savanur P.O.'),(2108,'Sawai Madhopur'),(2344,'Sawaimadapur'),(485,'Sawaimadhopur'),(2294,'Sawantwadi'),(2059,'Sawarde'),(829,'Sawyerpuram'),(2079,'SBS Nagar'),(3043,'SBS Nagar (NSR)'),(231,'Secunderabad'),(613,'Secundrabad'),(2510,'Sehore'),(749,'Seijusa'),(2266,'Selaqui'),(1794,'Sembakkam'),(1965,'Senapati'),(2252,'Seoni'),(2114,'Seoul 121'),(232,'Serampore'),(3076,'Serchhip'),(1939,'Sevagram'),(2272,'Sevalpatti'),(1502,'SGR Kashmir'),(2337,'Shabad'),(604,'Shahabad'),(2628,'Shahabad (M)'),(1176,'Shahada'),(1016,'Shahdol'),(233,'Shahjahanpur'),(2933,'Shajapur'),(1163,'Shaktinagar'),(936,'Shamli'),(2537,'Shamshabad'),(2430,'Shaniwareeth'),(1170,'Shankaraghatta'),(1148,'Shardanagar'),(475,'Shegaon'),(1402,'Shencottah'),(1008,'Shendurjanaghat'),(2050,'Shendurni'),(2999,'Sheopur'),(2571,'Sheopur Kalan'),(1180,'Shevgaon'),(539,'Shikohabad'),(234,'Shillong'),(2868,'Shimirpet'),(235,'Shimla'),(2924,'Shimurali'),(2085,'Shingnapur'),(607,'Shirala'),(2077,'Shirgaon'),(1400,'Shirpur'),(2325,'Shirur'),(1885,'Shivamogga'),(236,'Shivamogga (Shimoga)'),(3003,'Shivapuri'),(1879,'Shivnagar'),(3092,'Shivpuri'),(1299,'Shmoga'),(2348,'Shmogar'),(843,'Sholinganallur'),(2918,'Sholinghur'),(531,'Shoranur'),(2068,'Shorapur'),(1346,'Shornur'),(1878,'Shreeramnagar'),(2857,'Shreewardhan'),(2161,'Shrigonda'),(876,'Shringere'),(1363,'Shrirampur'),(2634,'Shrivilliputhur'),(1949,'Shujalpur'),(1044,'Siddapur'),(831,'Siddhpur'),(1854,'Siddipet'),(1275,'Sidhi'),(2254,'Sidhrawali'),(2178,'Sidhwar Khurd'),(2734,'Sihora'),(671,'Sikar'),(2362,'Sikara'),(425,'Sikharpur'),(1493,'Sikkim'),(1639,'Sikkim (East)'),(237,'Silchar'),(238,'Siliguri'),(616,'Silliguri'),(2122,'Sillod'),(2870,'Silvassa'),(2174,'Simaluguri'),(629,'Simhachalam'),(2044,'Simulbari'),(1946,'Sindewahi'),(3160,'Sindh 73050'),(239,'Sindhudurg'),(771,'Sindhudurga'),(778,'Sindkheda'),(1315,'Singanallur'),(1753,'Singapore'),(2247,'Singarayakonda'),(656,'Singhbhum'),(1625,'Singhbhum (E)'),(1778,'Singhrauli'),(2637,'Singoor'),(240,'Singrauli'),(2519,'Sinnar'),(2454,'Siricilla'),(985,'Sirkali'),(2397,'Sirmour'),(941,'Sirmur'),(958,'Sirohi'),(1106,'Sironcha'),(601,'Sirsa'),(471,'Sirsi'),(665,'Siruseri'),(879,'Sitapur'),(1827,'Sitarganj'),(241,'Sivaganga'),(947,'Sivagiri'),(1726,'Sivakashi'),(242,'Sivakasi'),(385,'Sivapuri'),(964,'Sivasagar'),(1120,'Siwan'),(243,'Sodepur'),(3086,'Sohna'),(942,'Solan'),(244,'Solapur'),(2324,'Someshwarnagar'),(2063,'Sonai'),(1465,'Sonapur'),(2346,'Sonari'),(650,'Sonarpur'),(678,'Sonbhadra'),(2089,'Sonbhanra'),(1335,'Sonebhadra'),(603,'Sonepat'),(467,'Sonepur'),(245,'Sonipat'),(1634,'Sonipet'),(822,'Sonitpur'),(1280,'Sontipur'),(1908,'Sopore'),(1018,'Soro'),(3154,'South Africa'),(2606,'South Andaman'),(246,'South Dumdum'),(2051,'South Kodagu'),(3051,'South Tripura'),(2231,'Sreekandapuram'),(2698,'Sreenivasapuram'),(1650,'Sri Ganga Nagar'),(247,'Sri Ganganagar'),(742,'Sri Palli'),(1712,'Sriganganagar'),(1652,'Srihari Kota'),(1926,'Sriharikota'),(1533,'Srikakulam'),(2530,'Srikalahasthi'),(509,'Srikalahasti'),(1546,'Srikaulam'),(2950,'Srimushnam'),(248,'Srinagar'),(2244,'SrinagarGarhwal'),(716,'Sringeri'),(408,'Sriniketan'),(1519,'Srinivasanagar'),(2877,'Srinivasapura'),(745,'Srinivasnagar'),(440,'Srinivaspur'),(1710,'Sriperumbpudur'),(249,'Sriperumbudur'),(250,'Srirampur'),(2952,'Srisailam'),(980,'Srivaikuntam'),(1266,'Srivilliputtur'),(1474,'Srukandapuram'),(3115,'Subansiri'),(2194,'Subrahmanya'),(2112,'Sudumbre'),(1263,'Sullia'),(1169,'Sullurpet'),(1197,'Sullurpeta'),(940,'Sullurupeta'),(251,'Sultanpur'),(1903,'Sulthan Bathery'),(2717,'Sulur'),(3060,'Sunam'),(696,'Sundargarh'),(1669,'Sundaridia'),(2806,'Sunderbani'),(478,'Sunderchak'),(1562,'Sundergarh'),(1050,'Supane'),(1254,'Surajpur'),(1988,'Surampalem'),(252,'Surat'),(1186,'Surathakal'),(253,'Surathkal'),(1115,'Suratkal'),(2831,'Surda'),(2332,'Surendranagar'),(861,'Surguja'),(557,'Suri'),(885,'Suryamaninagar'),(733,'Suryapet'),(1261,'Sutrapada'),(1913,'Suttur'),(1019,'Swamimalai'),(2730,'Syamsundar'),(1718,'T V Malai'),(2175,'T. Kallikulam'),(2969,'T.Kallupatty'),(1871,'Tadapalligudem'),(2932,'Tadapatri'),(586,'Tadepalligudem'),(2328,'Tadikonda'),(2631,'Tadong'),(1171,'Tadpatri'),(1754,'Taegu'),(3161,'Taipei'),(2901,'Takhatpur'),(932,'Talab Tilloo'),(1786,'Talakonda'),(2329,'Talcher'),(1002,'Taleigao'),(1818,'TaleigaoPlateau'),(1084,'Taleigo'),(556,'Taliparamba'),(2229,'Talod'),(2471,'Taloda'),(474,'Talwara'),(351,'Tambaram'),(2263,'Tamenglong'),(1991,'Tamkuhiraj'),(1467,'Tamluk'),(2474,'Tangi'),(1581,'Tangore'),(2143,'Tanjavur'),(1187,'Tanjore'),(427,'Tanuku'),(972,'Tarikere'),(1841,'Tarikhet'),(2434,'Tarn Taran'),(2326,'Tarsadi'),(1963,'Tasgaon'),(3020,'Tatnagiri'),(2642,'Tattamangalam'),(1864,'Tavanur'),(1823,'Teh-Merta'),(1445,'Tehri'),(1476,'Tehri Garhwal'),(1870,'Tehsil Rajpura'),(1222,'Tehsil Tibbi'),(802,'Tekkali'),(909,'Telam'),(1805,'Teleiago'),(591,'Tellicherry'),(1689,'Telliicherry'),(686,'Tenali'),(1488,'Tenkara P.O.'),(1424,'Tenkasi'),(2424,'Terri Garhwal'),(3068,'Tetali'),(255,'Tezpur'),(2553,'Tezu'),(1577,'Thachanallur'),(2793,'Thadlaskein'),(2096,'Thalacode'),(450,'Thalassery'),(2006,'Thalavapalayam'),(1242,'Thana'),(2988,'Thance'),(2942,'Thandalam'),(256,'Thane'),(868,'Thane (W)'),(856,'Thane (West)'),(729,'Thane Dist.'),(3118,'Thane East'),(1516,'Thane West'),(2666,'Thane(W)'),(254,'Thanjavur'),(1821,'Thanjvur'),(3014,'Tharamangalam'),(1620,'Thasra'),(2395,'Thathanur'),(1047,'Thatipparamba'),(1202,'Thattamala'),(1536,'The Nilgiris'),(1300,'Theerthamalai'),(1500,'Thellar'),(1395,'Thellyoor'),(1166,'Thenhipalam'),(1435,'Thenhipalam PO'),(1547,'Theni'),(2646,'Thenzawl'),(2222,'Thetkuppalam'),(1307,'Thickurichy'),(1179,'Thimmasamudram'),(431,'Thiruchirapalli'),(2911,'Thirumansolai'),(1711,'Thirunelveli'),(2426,'Thiruninravur'),(2259,'Thirupachur'),(1203,'Thirupathur'),(1984,'Thiruppanadal'),(1633,'Thiruppathur'),(1808,'Thirupur'),(1569,'Thiruvaiyaru'),(1719,'Thiruvalam'),(1190,'Thiruvalla'),(1596,'Thiruvallur'),(257,'Thiruvananthapuram'),(1411,'Thiruvankulam'),(1042,'Thiruvannamalai'),(1140,'Thiruvarur'),(1697,'Thiruvattar'),(2731,'Thiruvilla'),(346,'Thodupuzha'),(997,'Thokkavadi'),(2954,'Tholayavattam'),(1986,'Tholudur'),(1112,'Thondi'),(1992,'Thoothoor'),(303,'Thoothukudi'),(2146,'Thoppur'),(570,'Thotakkara'),(2189,'Thottakkadu'),(2481,'Thoubal'),(2130,'Thovalai'),(2957,'Thrikkakara'),(2489,'Thrikkanapuram'),(258,'Thrissur'),(381,'Thrisur'),(1249,'Thrisuur'),(494,'Thriuchirapalli'),(2582,'Thruvannamalai'),(2356,'Thuckalay'),(2298,'Thuruthicad'),(2214,'Thuthukudi'),(1646,'Tihu'),(2654,'Tikamgarh'),(922,'Tilaiya Dam'),(2783,'Tilwasni'),(1694,'Tindivanam'),(1538,'Tinsukia'),(1036,'Tiptur'),(3111,'Tirap'),(1716,'Tirchengode'),(1820,'Tirchy'),(1941,'Tirtol'),(731,'Tiruchendur'),(1407,'Tiruchengode'),(1560,'Tiruchiraoalli'),(259,'Tiruchirapalli'),(2338,'Tiruchirapally'),(1224,'Tiruchirappali'),(395,'Tiruchirappalli'),(1066,'Tiruchy'),(335,'Tirukalukundram'),(1173,'Tirukovilour'),(2213,'Tirumangalam'),(897,'Tirunelvali'),(260,'Tirunelveli'),(1830,'Tirunelvelli'),(797,'Tiruninravur'),(355,'Tirupathi'),(261,'Tirupati'),(1506,'Tirupattur'),(2200,'Tiruppattur'),(1081,'Tiruppur'),(262,'Tirupur'),(2169,'Tirur'),(2472,'Tirurangadi'),(2990,'Tiruttani'),(1960,'Tiruvalam'),(713,'Tiruvalla'),(549,'Tiruvannamalai'),(2912,'Tiruvannmalai'),(1310,'Tiruvarur'),(1566,'Tiruvelveli'),(825,'Tiruvetipuram'),(263,'Tiruvottiyur'),(2896,'Tiruvuru'),(1822,'Tonk'),(1833,'Tonk Road'),(2398,'Toranagallu'),(1892,'Trichi'),(1553,'Trichirappalli'),(373,'Trichur'),(2838,'Trimbuk'),(1723,'Trippur'),(366,'Tripunithura'),(931,'Tripur'),(884,'Tripura'),(1668,'Tripura (N)'),(3034,'Tripura West'),(735,'Trissur'),(3123,'Trivandruam'),(803,'Trivandurm'),(1635,'Trvandrum'),(2010,'Tuljapur'),(2120,'Tumakooru'),(264,'Tumakuru (Tumkur)'),(390,'Tumkur'),(1638,'Tumukur'),(2011,'Tuni'),(703,'Tura'),(1615,'Turuppur'),(492,'Tuticorin'),(1295,'Tutucorin'),(3165,'TX'),(1826,'U.S. Nagar'),(2940,'UB Kanker'),(453,'Uchipulli'),(1528,'Udaipir'),(265,'Udaipur'),(2508,'Udala'),(1017,'Udalguri'),(1728,'Udam Singhnagar'),(2473,'Udamalpet'),(2467,'Udayagiri'),(1359,'Udayamperoor'),(1565,'Udayarpalayam'),(718,'Udgir'),(957,'Udhagamandalam'),(302,'Udhampur'),(707,'Udhna'),(1828,'Udipi'),(1021,'Udumalpet'),(301,'Udupi'),(3054,'Udupt'),(1665,'Udwada'),(375,'Ujire'),(266,'Ujjain'),(2759,'Ukhrul'),(2009,'Ulga'),(267,'Ulhasnagar'),(1482,'Ullhasnagar'),(268,'Uluberia'),(2586,'Umaim'),(2893,'Umakhed'),(300,'Umaria'),(1237,'Umarkhed'),(2225,'Umiam'),(2751,'Umrangso'),(2199,'Umred'),(3001,'Una'),(858,'Unnao'),(398,'Uppinangadi'),(3103,'Uppinangady'),(2428,'Uran'),(2827,'US Nagar'),(1504,'Usilampatti'),(2339,'Uthamapalayam'),(1032,'Uthangal'),(1226,'Uthangarai'),(2415,'Uthangudi'),(1768,'Uttar Dinajpur'),(719,'Uttarkashi'),(1132,'Uzhavoor'),(2906,'V. Kote'),(2715,'V. Singapuram'),(706,'V. Vidyanagar'),(353,'V.Vidyanagar'),(626,'Vadakara'),(423,'Vadakkevila'),(3017,'Vadamavandal'),(2111,'Vadlamudi'),(269,'Vadodara'),(2095,'Vaijapur'),(2512,'Vairag'),(2994,'Vaishali'),(448,'Valacodu'),(2970,'Valad'),(496,'Valancheri'),(2255,'Valanchery'),(2714,'Valapad'),(2094,'Valarpuram'),(630,'Valavannur'),(417,'Valavanour'),(2446,'Valia'),(270,'Vallabh Vidyanagar'),(1391,'Vallam'),(933,'Vallanad'),(2098,'Vallanadu'),(695,'Vallar'),(878,'Vallioor'),(2852,'Valmikipuram'),(2147,'Valod'),(930,'Valparai'),(3038,'Valpoi'),(299,'Valsad'),(1496,'Valvada'),(271,'Vamadapadavu'),(2375,'Vanagaram'),(1537,'Vanasthalipuram'),(1954,'Vandalur'),(1489,'Vandavasi'),(698,'Vaniyambadi'),(2595,'Vannarpettai'),(519,'Vapi'),(2435,'Vapi (West)'),(272,'Varanasi'),(1733,'Varansai'),(976,'Varkala'),(524,'Varnasi'),(2478,'Varvand'),(2101,'Vasad'),(1743,'Vasai'),(1990,'Vasai Road (W)'),(2867,'Vasai Road West'),(273,'Vasai-Virar'),(1974,'Vasco'),(1676,'Vasco da gama'),(1715,'Vasco-da-Gama'),(2544,'Vaslas'),(3078,'Vasudevanallur'),(967,'Vatakara'),(1731,'Vatanasi'),(3158,'Vavuniya'),(1671,'Vayala'),(1072,'Vayalar'),(2568,'Vayyuru'),(2682,'Vazhakulam'),(2269,'Vazhayoor East'),(2737,'Vazhithala'),(2597,'Vazhoor'),(2128,'Veerachipalayam'),(2330,'Veeravasaram'),(1647,'Velha'),(1076,'Veliyur'),(1555,'Vellalloor'),(2864,'Vellanikkara'),(1923,'Vellayani'),(3021,'Vellichanthai'),(2681,'Vellithiruthy'),(274,'Vellore'),(1361,'Velur'),(1298,'Vemom'),(1236,'Vemon'),(2703,'Vengola'),(2466,'Vengurla'),(2618,'Venjaramoodu'),(2674,'Venkatachalam'),(2167,'Venkatagirikote'),(1130,'Vennikulam'),(2023,'Venpakkam'),(2931,'Veraval'),(2040,'Verem'),(2622,'Verna'),(1971,'Vetapalem'),(1271,'Vettavalam'),(1423,'Vetturnimadam'),(2368,'Vidavalur'),(1358,'Vididsha'),(674,'Vidisha'),(908,'Vidyanagar'),(574,'Vijaipur'),(1043,'Vijayamangalam'),(2874,'Vijayapura'),(2809,'Vijayavada'),(275,'Vijayawada'),(1575,'Vikarabad'),(3071,'Vikiravandi'),(1327,'Vilayancode'),(2517,'Villapakkam'),(2091,'Villianur'),(2612,'Villiapalli'),(2968,'Villpuram'),(1602,'Villukuri'),(2319,'Villukury'),(1621,'Villuppuram'),(1068,'Villupuram'),(1664,'Vinukonda'),(2197,'Virajapet'),(3025,'Virajpet'),(582,'Virar (West)'),(1561,'Virddhachalam'),(297,'Viridhunagar'),(515,'Viruddhachalam'),(1740,'Virudhu Nagar'),(3023,'Virudunagar'),(2956,'Visakapatnam'),(276,'Visakhapatnam'),(2038,'Visakhpatnam'),(2035,'Visakyhapatnam'),(298,'Vishakhapatnam'),(1670,'Vishnupur'),(1114,'Visnagar'),(2400,'Vita'),(622,'Vitalnagar'),(1917,'Vittal'),(2967,'Vixianagaram'),(911,'Vizag'),(592,'Vizianagaram'),(1787,'Vizianagram'),(963,'Vizninjam'),(2559,'Vllore'),(1544,'Voimedu'),(2863,'Vriddhachalam'),(886,'Vridhachalam'),(1174,'Vsgao'),(1867,'Vuyyuru'),(2052,'VV Nagar'),(939,'Vyara'),(1030,'Vyasagiri'),(2692,'W Garo Hills'),(1480,'W.Champaran'),(2369,'W.G Dist'),(913,'W.Godavari'),(2581,'Wadhwancity'),(1999,'Wagholi'),(1200,'Wai'),(1039,'Waknaghat'),(1840,'Walajapet'),(585,'Waltair'),(2580,'Wandiwash'),(783,'Wani'),(2151,'Waranagar'),(277,'Warangal'),(294,'Wardha'),(1952,'Wargal'),(536,'Warora'),(2596,'Washim'),(296,'Wayanad'),(1558,'West Champaran'),(2208,'West Champuram'),(855,'West Garo Hills'),(569,'West Godavari'),(3049,'West KhasiHills'),(2694,'West Midnapore'),(1446,'West Singhbhoom'),(3061,'West Singhbhum'),(2475,'WG Dist'),(3097,'WG District'),(2779,'Yadagiri'),(2566,'Yadgir'),(1231,'Yamuna Nagar'),(278,'Yamunanagar'),(2005,'Yanam'),(295,'Yavatmal'),(2403,'Yawatmal'),(279,'Yeddumailaram'),(280,'Yelburga'),(548,'Yellamanchili'),(541,'Yellandu'),(2792,'Yellapur'),(2013,'Yemmiganur'),(1376,'Yeotmal'),(873,'Yercaud'),(2303,'Yerraguntla'),(2632,'Yeshwantnagar'),(2374,'Yol Cantt.'),(2047,'YSR Dist'),(2812,'Zawar Mines'),(1806,'Zirakpur'),(1591,'Zuari Nagar'),(685,'Zuarinagar');
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
    if new.inwardPurpose in (6,7,8,9,10) then
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
  PRIMARY KEY (`id`)
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
  `status` int(11) NOT NULL DEFAULT '0',
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
  `sent_date` datetime NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriber_type`
--

LOCK TABLES `subscriber_type` WRITE;
/*!40000 ALTER TABLE `subscriber_type` DISABLE KEYS */;
INSERT INTO `subscriber_type` VALUES (1,'FELJM','Fellows','Free','I','P',2,0.000),(2,'AS','Associate','Free','I','P',2,0.000),(3,'EBALL','Editorial Board Member','Free','I','P',1,0.000),(4,'EI','Indian Exchange','Free','I','I',0,0.000),(5,'EF','Foreign Exchange','Free','F','I',0,0.000),(6,'GRANT','Grant','Free','I','P',2,0.000),(7,'AUTH','AUTHOR','Free','I','P',1,0.000),(8,'II','Indian Universities and Institutions','Paid','I','I',0,0.000),(9,'IC','Indian Schools and Colleges','Paid','I','I',0,0.000),(10,'IN','Industry Corporates','Paid','I','I',0,0.000),(11,'IP','Indian Personnel','Paid','I','P',0,0.000),(12,'FP','Foreign Personnel','Paid','F','P',0,0.000),(13,'FI','Foreign Institutions','Paid','F','I',0,0.000),(14,'SF','Summer Fellows','Free','I','P',1,0.000),(15,'HONFEL','Honorary Fellow','Free','I','P',0,0.000),(16,'LSP','Life Subscriber Personal','Paid','I','P',0,0.000),(17,'LSI','Life Subscriber Institutions','Paid','I','I',0,0.000),(18,'MEMBER','Members','Free','I','P',0,0.000),(19,'WC','Working Committee','Free','I','P',0,0.000);
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

-- Dump completed on 2012-11-12 20:59:46
