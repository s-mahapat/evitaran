USE evitaran;
--
-- Dumping routines for database 'jds'
--
/*!50003 DROP PROCEDURE IF EXISTS `activateSubscription` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `activateSubscription`(IN subscriberID   INT,
                                            IN makeActive     INT)
   BEGIN
  DECLARE done              int DEFAULT 0;
  DECLARE subscription_detail_id int DEFAULT 0;
  DECLARE active int DEFAULT 0;
  DECLARE cur1 CURSOR FOR SELECT t2.id, t2.active FROM subscription t1, subscriptiondetails t2 WHERE t1.subscriberID = subscriberID AND t2.subscriptionID=t1.id;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
      OPEN cur1;
     read_loop:
      LOOP
         FETCH cur1
           INTO subscription_detail_id, active;
         IF done = 1
         THEN
            LEAVE read_loop;
         END IF;
         UPDATE subscriptiondetails t1
            SET t1.active = makeActive
          WHERE     t1.id = subscription_detail_id
                AND t1.endYear >= YEAR(CURDATE());
      END LOOP;
      CLOSE cur1;
   END;;
DELIMITER ;
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
CREATE PROCEDURE `addBackIssues`(IN _subscription_detail_id   int,
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
                                AND t3.year = _new_startYear
				AND t3.month >= _new_startMonth;
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
CREATE PROCEDURE `circulation_figures`(IN cir_year int)
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
CREATE PROCEDURE `cir_subscription_rates`(IN cir_year        int,
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
-- Dump completed on 2013-02-27  7:40:16
