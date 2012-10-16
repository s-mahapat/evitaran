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
) ENGINE=InnoDB AUTO_INCREMENT=27635 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=5553 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=32191 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=26350 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=31769 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
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
-- Table structure for table `year`
--

DROP TABLE IF EXISTS `year`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `year` (
  `yearId` int(11) NOT NULL AUTO_INCREMENT,
  `year` text NOT NULL,
  PRIMARY KEY (`yearId`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-10-16 23:50:10
