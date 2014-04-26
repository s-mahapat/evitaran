USE evitaran;
/*!50003 DROP TRIGGER IF EXISTS `complete_non_process_inward` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `complete_non_process_inward` BEFORE INSERT
    ON inward FOR EACH ROW
BEGIN
    if new.inwardPurpose in (6,7,8,9) then
      set new.completed = true;
    end if;
END */;;
DELIMITER ;

/*!50003 DROP TRIGGER IF EXISTS `setDeactivationDate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` TRIGGER `setDeactivationDate` BEFORE UPDATE ON subscriber FOR EACH ROW
BEGIN
    IF new.deactive = TRUE THEN
      SET new.deactivationDate = CURRENT_DATE;
      CALL activateSubscription(new.id, 0);
    ELSE
      SET new.deactivationDate = NULL;
      CALL activateSubscription(new.id, 1);
    END IF;
END;;
DELIMITER ;

/*!50003 DROP TRIGGER IF EXISTS `deactivate_subscription` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `deactivate_subscription` BEFORE INSERT
    ON subscriptiondetails FOR EACH ROW
BEGIN
   IF new.endyear < YEAR(CURRENT_TIMESTAMP) THEN
      SET new.active = FALSE;
   END IF;
END */;;
DELIMITER ;

/*!50003 DROP TRIGGER IF EXISTS `add_back_issues` */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `add_back_issues` AFTER INSERT
    ON subscriptiondetails FOR EACH ROW
BEGIN
   DECLARE subscription_date varchar(20);
   SET subscription_date = CONCAT(new.startYear, '-', new.startMonth, '-', 1);
   /* only add back issue if subscription date is less than today */
   IF DATE_FORMAT(subscription_date, '%Y-%m-%d') < current_date() THEN
     CALL addBackIssues(new.id,
                        new.startMonth,
                        new.startYear,
                        new.journalGroupID,
                        new.copies);
   END IF;
END */;;
DELIMITER ;


/*!50003 DROP TRIGGER IF EXISTS `edit_bil` */;
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
CREATE DEFINER=`root`@`localhost` TRIGGER edit_bil BEFORE UPDATE ON subscriptiondetails FOR EACH ROW
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
         SET diff := new.copies - old.copies;
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


/*!50003 DROP TRIGGER IF EXISTS `after_subscription_details_update` */;
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
CREATE TRIGGER `after_subscription_details_update` AFTER UPDATE ON subscriptiondetails FOR EACH ROW
BEGIN
   /*
   * set the active flag for subscription to false once all the details are
   * marked as false
   */
   DECLARE is_active             int DEFAULT 0;
   DECLARE journal_group_price   float DEFAULT 0;
   DECLARE inward_amount   float DEFAULT 0;
   DECLARE new_amount   float DEFAULT 0;
   DECLARE existing_invoice_id int DEFAULT 0;
   DECLARE PRL_INVOICE_TYPE int DEFAULT 3; /* for Please refer list, we should not update this type of invoice when subscription is edited*/

   SELECT count(*)
     INTO is_active
     FROM subscriptiondetails t1
    WHERE t1.active = TRUE AND t1.subscriptionID=new.subscriptionID;

   IF is_active = 0
   THEN
      UPDATE subscription t1
         SET t1.active = FALSE
       WHERE t1.id = new.subscriptionID;
   ELSE
      UPDATE subscription t1
         SET t1.active = TRUE
       WHERE t1.id = new.subscriptionID;
   END IF;

   /*
    Get the sum of all the subscription detail entries
    then find the inward amount, subtract them to get the
    new invoice amount when a subscription is edited.
   */
   SELECT COALESCE(sum(t1.copies * t2.rate), 0) INTO new_amount
    FROM subscriptiondetails t1, subscription_rates t2
      WHERE     t1.journalPriceGroupID = t2.id
       AND t1.active = TRUE
       AND t1.subscriptionID = new.subscriptionID;

   SELECT COALESCE(t2.amount, 0)
    INTO inward_amount
    FROM subscription t1
         LEFT JOIN inward t2
            ON t1.inwardid = t2.id WHERE t1.id = new.subscriptionID
   LIMIT 1;

   UPDATE invoice SET amount = (new_amount - inward_amount) WHERE subscriptionid=new.subscriptionID AND invoice_type_id <> PRL_INVOICE_TYPE;


/* end of subscription deactivate */
END;;
DELIMITER ;
