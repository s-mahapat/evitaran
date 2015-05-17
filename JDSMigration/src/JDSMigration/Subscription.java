/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package JDSMigration;

import com.mysql.jdbc.Statement;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import jxl.read.biff.BiffException;
import org.apache.log4j.Logger;

public class Subscription extends MigrationBase {

    private static final Logger logger = Logger.getLogger(Subscription.class.getName());
    int totalRows = 0;
    int excelRowNumber = 0;
    int insertedRows = 0;
    int insertedRowsSubDtls = 0;
    int subscriberID;
    String subscriberNumber;
    Map<String, String> invalidSubRates = new HashMap<>();
    //Prepared Statements
    PreparedStatement pst_insert_subscription = null;
    PreparedStatement pst_select_inward = null;
    PreparedStatement pst_select_subscriber = null;
    PreparedStatement pst_select_subscriber_agent = null;
    PreparedStatement pst_insert_subscription_dtls = null;
    HashMap<String, String> agentSubscriberMap;

//--------------------------------------------------------------------------------------------
    //Constructor
    public Subscription(HashMap<String, String> _agentSubscriberMap) throws SQLException {
        super();
        this.dataFile = this.dataFolder + "\\jnls.xls";
        this.conn = this.db.getConnection();
        agentSubscriberMap = _agentSubscriberMap;

    }

    public int getTotalNoOfCopies(String[] datacolumns) {
        int noCopies = 0;
        //int[] jrnlArr = {4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 27};
        int[] jrnlArr = {4, 6, 8, 10, 12, 14, 16, 18, 20};
        for (int j = 0; j < jrnlArr.length; j++) {
            if (!datacolumns[jrnlArr[j]].equalsIgnoreCase("0") && !datacolumns[jrnlArr[j]].isEmpty()) {
                noCopies = noCopies + Integer.parseInt(datacolumns[jrnlArr[j]]);
            }
        }
        return noCopies;
    }

    //Migration
    @Override
    public void Migrate() throws FileNotFoundException, IOException, ParseException, SQLException, BiffException {
        Corr _corr = new Corr();
        this.conn.setAutoCommit(false);
        this.openExcel(dataFile);
        int commitCounter = 0;
        Map<String, Object> subscriberid_cache = new HashMap<>();
        //Map<String, Object> subscriber_balance = new HashMap<>();


        String[] datacolumns;
        String[] corrdatacolumns;

        pst_select_inward = this.conn.prepareStatement(sql_select_inward);
        pst_select_subscriber = this.conn.prepareStatement(sql_select_subscriber);
        pst_select_subscriber_agent = this.conn.prepareStatement(sql_select_subscriber_agent);
        pst_insert_subscription = this.conn.prepareStatement(sql_insert_subscription, Statement.RETURN_GENERATED_KEYS);


        // truncate the old data
        //this.truncateTable("subscription");
        //this.truncateTable("subscriptiondetails");

        int[] jrnlArr = {4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 27};
        int[] jrnlGrpIDArr = {1, 2, 3, 4, 6, 5, 7, 8, 9, 10, 11, 12, 13}; //Journal Group IDs

        while (true) {
            datacolumns = this.getNextRow();
            corrdatacolumns = _corr.getCorrNextRow();
            String corr_subscriber = null;
            String corr_sub_date = null;
            Float corr_balance;
            String inward_year = "";
            //boolean active = true;
            if (datacolumns == null) {
                break;
            }
            if (corrdatacolumns != null) {
                corr_subscriber = corrdatacolumns[3];
                /* The DATE_SUBSN does not have the correct subscription dates, we will consider the
                 * DATE_ACK, if this is null we'll take the DATE_REPLY field
                 */
                corr_sub_date = corrdatacolumns[7].length() > 0 ? corrdatacolumns[7] : corrdatacolumns[5];
                try {


                    SimpleDateFormat inward_date_format = new SimpleDateFormat("mm/dd/yyyy");
                    java.util.Date inward_date = inward_date_format.parse(corr_sub_date);
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(inward_date);
                    inward_year = String.valueOf(cal.get(Calendar.YEAR)).substring(2);
                }catch(java.text.ParseException ex){
                    logger.error(ex);
                }
            }


            totalRows++;
            excelRowNumber = totalRows + 1;

            // Check if subscriber exists
            logger.debug("Migrating subscription for subscriber Number: " + datacolumns[0]);
            if(datacolumns[0].equals("5640")){
                logger.debug("error");
            }
            this.subscriberNumber = datacolumns[0];

            if(this.subscriberNumber.equals("10589")){
                logger.debug("Skipping 10589");
                continue;
            }

            if (Subscription.subscriberIDsWithoutNames.containsKey(this.subscriberNumber)) {
                logger.error(String.format("Subscription for subscriber %s is skipped since subscriber does not have a name. Row No. %s", this.subscriberNumber, excelRowNumber));
                continue;
            }

            int subscriberId = 0;
            boolean has_subscription = false;

            for (int j = 0; j < jrnlArr.length; j++) {
                if (!datacolumns[jrnlArr[j]].equalsIgnoreCase("0") && !datacolumns[jrnlArr[j]].isEmpty()) {
                    has_subscription = true;
                    break;
                }
            }

            if (has_subscription) {
                if (subscriberid_cache.containsKey(this.subscriberNumber)) {
                    this.subscriberID = Integer.parseInt(subscriberid_cache.get(this.subscriberNumber).toString());
                } else {
                    pst_select_subscriber.setString(1, datacolumns[0]);
                    ResultSet rs_subscriber = this.db.executeQueryPreparedStatement(pst_select_subscriber);
                    try {
                        rs_subscriber.first();
                        subscriberId = rs_subscriber.getInt(1);
                        this.subscriberID = subscriberId;
                        subscriberid_cache.put(this.subscriberNumber.toString(), subscriberId);
                    } catch (SQLException e) {
                        logger.fatal("No Subscriber ID found for Subscriber Number " + datacolumns[0] + " in Subscriber DB Table. Row No: " + (excelRowNumber) + " Sub No mentioned exists in JNLS but does not exist in TEMP or INDTEMP");
                        continue;
                    }
                }
            } else {
                logger.debug("No subscription for Subscriber Number " + datacolumns[0] + " Row No: " + (excelRowNumber));
                continue;
            }

            if ("9492".equals(this.subscriberNumber)) {
                logger.debug(this.subscriberNumber);
            }
            // Get the inward number
            int inwardId = 0;
            String inwardNumber = corrdatacolumns[2];
            try {
                if (inwardNumber.length() > 0) {
                    String inward_letter_pattern = "(\\w).*";
                    String inward_number_pattern = "(\\d+)";
                    Pattern r = Pattern.compile(inward_letter_pattern);
                    Pattern r2 = Pattern.compile(inward_number_pattern);
                    Matcher m = r.matcher(inwardNumber);
                    Matcher m2 = r2.matcher(inwardNumber);
                    String inward_letter = "";
                    String inward_number = "";
                    if (m.find()) {
                        inward_letter = m.group(1);
                    }
                    if (m2.find()) {
                        inward_number = m2.group(1);
                    }

                    String final_inward_number = inward_year + inward_letter + "-" + String.format("%05d", Integer.parseInt(inward_number));
                    pst_select_inward.setString(1, final_inward_number);
                    ResultSet rs_inward = this.db.executeQueryPreparedStatement(pst_select_inward);
                    if (rs_inward.first()) {
                        inwardId = rs_inward.getInt(1);
                    }
                }
            } catch (NumberFormatException ex) {
                logger.error(ex);
            }

            // Get the agent Id if it exists
            int agentId = 0;
            if (this.agentSubscriberMap.containsKey(datacolumns[0])) {
                agentId = Integer.parseInt(agentSubscriberMap.get(datacolumns[0]));
            }
            logger.debug("Hashmap retrieval values-->" + subscriberNumber + "->" + Integer.toString(agentId));

//            pst_select_subscriber_agent.setString(1, datacolumns[0]);
//            ResultSet rs_agent = this.db.executeQueryPreparedStatement(pst_select_subscriber_agent);
//            if (rs_agent.first()) {
//                agentId = rs_agent.getInt(1);
//            }
            // Get the amount
            float amount = Float.parseFloat(datacolumns[29]);

            // Get the balance

            try {
                corr_balance = (float) 0;
                if (!corr_subscriber.isEmpty() && Integer.parseInt(corr_subscriber) == Integer.parseInt(this.subscriberNumber)) {
                    corr_balance = calculate_balance(corrdatacolumns);
                }
            } catch (NumberFormatException | NullPointerException e) {
                logger.fatal("cannot update balance: " + this.subscriberNumber + e.toString() + " subscriber in corr:" + corr_subscriber);
                corr_balance = (float) 0;
            }

            Date subdate = util.dateStringToSqlDate(null);
            try {
                subdate = util.dateStringToSqlDate(util.convertDateFormat(corr_sub_date, "MM/dd/yyyy", "dd/MM/yyyy"));
            } catch (NumberFormatException | ParseException | NullPointerException e) {
                logger.error("cannot update subscription date and balance for subscriber: " + this.subscriberNumber + " date: " + e.toString() + " subscriber in corr:" + corr_subscriber);
            }

            // Get the legacy_proforma_invoice_no
            String legacy_proforma_invoice_no = "";
            if (!(corrdatacolumns[10].isEmpty() || corrdatacolumns[10] == null)) {
                legacy_proforma_invoice_no = corrdatacolumns[10];
            }

            // Get the legacy_proforma_invoice_date
            //Date legacy_proforma_invoice_date = util.dateStringToSqlDate(null);
            Date legacy_proforma_invoice_date = null;
            try {
                legacy_proforma_invoice_date = util.dateStringToSqlDate(util.convertDateFormat(corrdatacolumns[5], "MM/dd/yyyy", "dd/MM/yyyy"));
            } catch (NumberFormatException | ParseException | NullPointerException e) {
                // Do nothing if there is an exception
            }

//------------------------------------------------------------------------------------------------------------------------------
            //Insert Subscription
//------------------------------------------------------------------------------------------------------------------------------
            // check if end year is < 2012, else do not migrate the records
            //int startYear = Integer.parseInt(datacolumns[31]);
            logger.debug("End year field has: " + datacolumns[32]);
            //int endYear = Integer.parseInt(datacolumns[32]) > 0 ? Integer.parseInt(datacolumns[32]) : startYear;

            // Used to show subscription but the details were empty
            if ("7123".equals(this.subscriberNumber)) {
                logger.debug(this.subscriberNumber);
            }
            // Has 2 subscriptions which have all 1-11 journals
            if ("2521".equals(this.subscriberNumber)) {
                logger.debug(this.subscriberNumber);
            }
            // Used to show subscription but the details were empty
            if ("2503".equals(this.subscriberNumber)) {
                logger.debug(this.subscriberNumber);
            }
            if ("2503".equals(this.subscriberNumber)) {
                logger.debug(this.subscriberNumber);
            }
            if ("9905".equals(this.subscriberNumber)) {
                logger.debug(this.subscriberNumber);
            }
            if ("5692".equals(this.subscriberNumber)) {
                logger.debug(this.subscriberNumber);
            }

            int subscriptionID = 0;

            try {
                //if ((endYear >= 2012 || checkIfValidSubscriptionCURR(datacolumns) || checkIfValidSubscriptionRES(datacolumns))
                //        && getTotalNoOfCopies(datacolumns) > 0)
                if ((getTotalNoOfCopies(datacolumns) > 0)
                        || (checkIfValidSubscriptionCURR(datacolumns) && getCopiesCURR(datacolumns) > 0)
                        || (checkIfValidSubscriptionRES(datacolumns) && getCopiesRES(datacolumns) > 0)) {

                    //Start year
                    // if datacoloumn[31] = 0
                    int startYr = Integer.parseInt(datacolumns[31]);
                    startYr = this.getCorrectedYear(startYr);

                    //End year
                    int endYr = Integer.parseInt(datacolumns[32]);

                    if (endYr == 0) { // in case of only one year subscription, only start year is filled
                        //_tempEndYr = startYr;
                        endYr = startYr;
                    } else {
                        endYr = getCorrectedYear(endYr);
                    }

                    //logger.debug("Start Year:" + startYr);
                    //logger.debug("End Year:" + endYr);

                    subscriptionID = this.insertSubscription(this.subscriberID, inwardId, amount, subdate, corr_balance, agentId, legacy_proforma_invoice_no, legacy_proforma_invoice_date);
                    logger.debug("Inserted Subscription with id: " + subscriptionID);
                    insertedRows++;
                    commitCounter++;
                    //------------------------------------------------------------------------------------------------------------------------------
                    //Insert Subscription Details
                    //------------------------------------------------------------------------------------------------------------------------------



                    /*
                     * else { if (_tempEndYr > 100) { // end year is rightly filled with
                     * 4 digit year if (_tempStrtYr > 100 && _tempStrtYr < 1000) {
                     * //Many records have 3 digit year logger.error("End year for
                     * subscription " + subscriptionID + " is 3 digit " +
                     * datacolumns[32] + " but it is updated in the table"); } endYr =
                     * _tempEndYr; } else { if (_tempEndYr > 50 && _tempEndYr < 100) {
                     * // end year is filled with 2 digit such as 79, which means it is
                     * 1979 endYr = 1900 + _tempEndYr; } else if (_tempEndYr <= 50 &&
                     * _tempEndYr > 0) { endYr = 2000 + _tempEndYr; } } }
                     */

                    //---------------------------------------------------------
                    //Journal Group IDs
                    //  0:  Pramanna - Column -> 4   GrpID -> 1
                    //  1:  JAA      - Column -> 6   GrpID -> 2
                    //  2:  MS       - Column -> 8   GrpID -> 3
                    //  3:  EPS      - Column -> 10  GrpID -> 4
                    //  4:  BMS      - Column -> 12  GrpID -> 6
                    //  5:  CS       - Column -> 14  GrpID -> 5
                    //  6:  S        - Column -> 16  GrpID -> 7
                    //  7:  JB       - Column -> 18  GrpID -> 8
                    //  8:  JG       - Column -> 20  GrpID -> 9
                    //  9:  RES      - Column -> 22  GrpID -> 10
                    //  10: CURR     - Column -> 27  GrpID -> 11
                    //  11: ALL      - Column -> No  GrpID -> 12
                    //  12: All Except CURR  ------  GrpID -> 13
                    //---------------------------------------------------------

                    //int[] jrnlArr = {4, 6, 8, 10, 12, 14, 16, 18, 20}; //Data Columns frm excel
                    //int[] jrnlArr = {4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 27};
                    //int[] jrnlGrpIDArr = {1, 2, 3, 4, 6, 5, 7, 8, 9, 10, 11, 12, 13}; //Journal Group IDs
                    int allGrpFlag = 0;
                    int noCopies = 0;
                    if (!datacolumns[4].isEmpty()) {
                        noCopies = Integer.parseInt(datacolumns[4]); //For ALL and ALL but CS - Journal Grp the no. of copies should be same for all the jrnls
                    } else {
                        noCopies = 0;
                    }

                    /*
                     * If all journals have the same copy count and is not null or empty
                     * then we consider that he has subscribed to all journals
                     */
                    for (int j = 0; j < jrnlArr.length; j++) {
                        if (!datacolumns[jrnlArr[j]].equalsIgnoreCase("0") && !datacolumns[jrnlArr[j]].isEmpty()) {
                            if (noCopies == Integer.parseInt(datacolumns[jrnlArr[j]])) {
                                allGrpFlag++;
                            }
                        }
                    }

                    // Check if the start year and end year for all the journals is the same

                    if (allGrpFlag == 11) {
                        int period = endYr - startYr;

                        int sYrCURR = getstartYearCURR(datacolumns);
                        int eYrCURR = getendYearCURR(datacolumns);
                        int eMonCURR = getendMonthCURR(datacolumns);
                        int sMonCURR = getstartMonthCURR(datacolumns);
                        int periodCURR;
                        if (eMonCURR != 12) {
                            periodCURR = eYrCURR - sYrCURR - 1;
                        } else {
                            periodCURR = eYrCURR - sYrCURR;
                        }

                        int sYrRESO = getstartYearRES(datacolumns);
                        int eYrRESO = getendYearRES(datacolumns);
                        int eMonRESO = getendMonthRES(datacolumns);
                        int sMonRESO = getstartMonthRES(datacolumns);
                        int periodRESO;
                        if (eMonRESO != 12) {
                            periodRESO = eYrRESO - sYrRESO - 1;
                        } else {
                            periodRESO = eYrRESO - sYrRESO;
                        }

                        if (period > 0 || periodCURR > 0 || periodRESO > 0) {
                            logger.debug("This is not a ALL GROUPS");
                            allGrpFlag = 0;
                        }
                    }

                    // Check if the start year and end year for all the journals is the same
                    if (allGrpFlag == 10) {
                        int period = endYr - startYr;
                        int sYrRESO = getstartYearRES(datacolumns);
                        int eYrRESO = getendYearRES(datacolumns);
                        int eMonRESO = getendMonthRES(datacolumns);
                        int sMonRESO = getstartMonthRES(datacolumns);
                        int periodRESO;
                        if (eMonRESO != 12) {
                            periodRESO = eYrRESO - sYrRESO - 1;
                        } else {
                            periodRESO = eYrRESO - sYrRESO;
                        }
                        if (period > 0 || periodRESO > 0) {
                            logger.debug("This is not a ALL GROUPS");
                            allGrpFlag = 0;
                        }
                    }


                    if (allGrpFlag == 11) {
                        // Journal Group for all the journals required by a subscriber
                        insertedRowsSubDtls = migrateSubDtls(subscriptionID, jrnlGrpIDArr[11], noCopies, 1, startYr, endYr);
                        commitCounter++;
                    } else {
                        if (allGrpFlag == 10 && (datacolumns[27].equalsIgnoreCase("0") || datacolumns[27].isEmpty())) {
                            //if (allGrpFlag == 11) {
                            // Journal Group for all the journals except current science
                            insertedRowsSubDtls = migrateSubDtls(subscriptionID, jrnlGrpIDArr[12], noCopies, 1, startYr, endYr);
                            commitCounter++;
                        } else {
                            int startMonth = 1;

                            for (int j = 0; j < jrnlArr.length; j++) {
                                // Handle RESO
                                if (j == 9) {
                                    try {
                                        if (checkIfValidSubscriptionRES(datacolumns) && getCopiesRES(datacolumns) > 0) {
                                            if (subscriptionID == 0) {
                                                subscriptionID = this.insertSubscription(this.subscriberID, inwardId, amount, subdate, corr_balance, agentId, legacy_proforma_invoice_no, legacy_proforma_invoice_date);
                                                logger.debug("Inserted Subscription with id: " + subscriptionID);
                                                commitCounter++;
                                            }
                                            insertSubscriptionDetailsForRES(this.subscriberID, subscriptionID, datacolumns);
                                        }
                                    } catch (ParseException e) {
                                        logger.fatal(e.toString());
                                        logger.fatal("Skipping record for subscriber " + datacolumns[0] + " : issue with parsing date. Row No: " + excelRowNumber);
                                    }

                                } // Handle CURR
                                else if (j == 10) {
                                    try {
                                        if (checkIfValidSubscriptionCURR(datacolumns) && getCopiesCURR(datacolumns) > 0) {
                                            if (subscriptionID == 0) {
                                                subscriptionID = this.insertSubscription(this.subscriberID, inwardId, amount, subdate, corr_balance, agentId, legacy_proforma_invoice_no, legacy_proforma_invoice_date);
                                                logger.debug("Inserted Subscription with id: " + subscriptionID);
                                                commitCounter++;
                                            }
                                            insertSubscriptionDetailsForCURR(this.subscriberID, subscriptionID, datacolumns);
                                            commitCounter++;
                                        }
                                    } catch (ParseException e) {
                                        logger.fatal(e.toString());
                                        logger.fatal("Skipping record for subscriber " + datacolumns[0] + " : issue with parsing date. Row No: " + excelRowNumber);
                                    }
                                } // Handle all other journals
                                else {
                                    // Journal Group for individual journals
                                    if (!datacolumns[jrnlArr[j]].equalsIgnoreCase("0") && !datacolumns[jrnlArr[j]].isEmpty()) {
                                        insertedRowsSubDtls = migrateSubDtls(subscriptionID, jrnlGrpIDArr[j], Integer.parseInt(datacolumns[jrnlArr[j]]), startMonth, startYr, endYr);
                                    }
                                }
                            }
                        }
                    }
                }
            } catch (ParseException e) {
                logger.fatal(e.toString());
                logger.fatal("Skipping record for subscriber " + datacolumns[0] + " : issue with parsing date. Row No: " + (excelRowNumber));
            }


            if (subscriptionID == 0) {
                String subscriptions = "";
                for (int j = 0; j < jrnlArr.length; j++) {
                    subscriptions = subscriptions + " " + (datacolumns[jrnlArr[j]]);
                }
                logger.fatal("no subscription inserted for subscriber " + datacolumns[0] + " Row No in JNLS: " + (excelRowNumber) + " Subscription: " + subscriptions);
            }

            // commit in bulk, its faster
            if (commitCounter == COMMIT_SIZE) {
                conn.commit();
                commitCounter = 0;
            }
        }
        conn.commit();
        conn.setAutoCommit(true);
        logger.debug("Rows Inserted in Subscription: " + insertedRows);
        logger.error("Invalid subscription rates");
        for (String key : invalidSubRates.keySet()) {
            String[] _keys = key.split(":");
            String _fs = "%s,%s,%s,%s";
            logger.error(String.format(_fs, _keys[0], _keys[1], _keys[2], _keys[3]));
//            logger.error("JouralGrpID=" + _keys[0]);
//            logger.error("SubtypeID=" + _keys[1]);
//            logger.error("year=" + _keys[2]);
//            logger.error("Period: " + _keys[3]);
//            logger.error("-------------------------------");
        }

        /*String insert_balance_sql = "insert into subscriber_balance_legacy (subscriber_id, balance) values (?, ?)";
         PreparedStatement pst_insert_balance_sql = conn.prepareStatement(insert_balance_sql);
         for (Map.Entry<String, Object> entry : subscriber_balance.entrySet()) {
         String key = entry.getKey();
         String value = entry.getValue().toString();
         float balance = Float.parseFloat(value);
         if (balance > 0) {
         pst_insert_balance_sql.setInt(1, Integer.parseInt(key));
         pst_insert_balance_sql.setFloat(2, balance);
         pst_insert_balance_sql.addBatch();
         }
         }
         pst_insert_balance_sql.executeBatch();
         conn.commit();
         conn.setAutoCommit(true);*/



        //logger.debug("Rows Inserted in SubscriptionDtls: " + insertedRowsSubDtls);


    }

    private int migrateSubDtls(int subscriptionID, int jrnlGrpId, int noCopies,
            int startMonth, int startYr, int endYr)
            throws FileNotFoundException, IOException, ParseException, SQLException {
        endYr = endYr > 0 ? endYr : startYr;
        int paramIndex1 = 0;
        int endMonth;

        if (startMonth == 1) {
            endMonth = 12;
        } else {
            endMonth = startMonth - 1; // case where the subscription starts from July
            //endYr = endYr + 1;  // if the month does not start from 1 it means the
        }



        int subtypeID = this.getSubscriberTyeID(this.subscriberID);
        if (subtypeID == 0) {
            logger.fatal("Subscriber type id = " + subtypeID + " for subscriber : " + this.subscriberNumber);
        }
        logger.debug("Journal grp id is " + jrnlGrpId);
        if (this.subscriberNumber.equals("5464")) {
            logger.debug("subscriber number check");
        }
        int priceGroupID = this.getJournalPriceGroupID(jrnlGrpId, subtypeID, startYr, endYr);
        logger.debug("Price group id is: " + priceGroupID);
        if (priceGroupID == 0) {

            String key = String.valueOf(jrnlGrpId)
                    + ":" + String.valueOf(subtypeID)
                    + ":" + String.valueOf(startYr)
                    + ":" + String.valueOf((endYr - startYr + 1));
            if (!invalidSubRates.containsKey(key)) {
                invalidSubRates.put(key, "0");
            }
            logger.debug("JouralGrpID=" + jrnlGrpId);
            logger.debug("SubtypeID=" + subtypeID);
            logger.debug("year=" + startYr);
            logger.debug("Period: " + (endYr - startYr + 1));
            logger.debug("Price Group ID is 0 for subscriber Number " + this.subscriberNumber + " at row:" + (totalRows + 1));
            //System.exit(1);

            // set it to 1 to take the first row from subscription_rates table, which indicates its old data
            priceGroupID = 1;
        }


        //Cases where start year and end year is zero but no. of copies are not zero - LOG IT
        if (startYr == 0) {
            logger.fatal("No start year for subscription " + subscriptionID + " but subscription details are updated in the table. Row No: " + excelRowNumber);
        }
        pst_insert_subscription_dtls = this.conn.prepareStatement(sql_insert_subscriptiondetails);
        pst_insert_subscription_dtls.setInt(++paramIndex1, subscriptionID);
        pst_insert_subscription_dtls.setInt(++paramIndex1, jrnlGrpId);
        pst_insert_subscription_dtls.setInt(++paramIndex1, noCopies);
        pst_insert_subscription_dtls.setInt(++paramIndex1, startYr);
        pst_insert_subscription_dtls.setInt(++paramIndex1, startMonth);
        pst_insert_subscription_dtls.setInt(++paramIndex1, endYr);
        pst_insert_subscription_dtls.setInt(++paramIndex1, endMonth);
        pst_insert_subscription_dtls.setInt(++paramIndex1, priceGroupID);


        //Inserting the record in Subscription Table
        int retUpdStatus = this.db.executeUpdatePreparedStatement(pst_insert_subscription_dtls);

        //Logging the inserting row
        if (retUpdStatus == 1) {
            insertedRowsSubDtls++;
            logger.debug("Inserted " + insertedRowsSubDtls + " rows in sub_details table");
            //logger.debug("Rows Inserted for SubscriptionID: " + subscriptionID);
        }
        //conn.commit();
        return insertedRowsSubDtls;
    }

    public boolean insertSubscriptionDetailsForCURR(int subscriberID, int subscription_id, String[] datacolumns) throws SQLException, ParseException {

        int journalGrpID = 11;
        int startYear = getstartYearCURR(datacolumns);
        int endYear = getendYearCURR(datacolumns);
        int subtypeID = getSubscriberTyeID(subscriberID);
        int priceGroupID = getJournalPriceGroupID(journalGrpID, subtypeID, startYear, endYear);

        boolean status = this.insertSubscriptionDetails(subscription_id,
                journalGrpID,
                getCopiesCURR(datacolumns),
                startYear,
                getstartMonthCURR(datacolumns),
                endYear,
                getendMonthCURR(datacolumns),
                priceGroupID);
        return status;
    }

    public int getstartYearCURR(String[] datacolumns) throws ParseException {
        Calendar cal = Calendar.getInstance();
        cal.setTime(getcsyCURR(datacolumns));
        int startMonth = cal.get(Calendar.MONTH) + 1;
        int startYear = cal.get(Calendar.YEAR);
        return startYear;
    }

    public int getstartMonthCURR(String[] datacolumns) throws ParseException {
        Calendar cal = Calendar.getInstance();
        cal.setTime(getcsyCURR(datacolumns));
        int startMonth = cal.get(Calendar.MONTH) + 1;
        int startYear = cal.get(Calendar.YEAR);
        return startMonth;
    }

    public int getendYearCURR(String[] datacolumns) throws ParseException {
        Calendar cal = Calendar.getInstance();
        cal.setTime(getceyCURR(datacolumns));
        int endMonth = cal.get(Calendar.MONTH) + 1;
        int endYear = cal.get(Calendar.YEAR);

        return endYear;
    }

    public int getendMonthCURR(String[] datacolumns) throws ParseException {
        Calendar cal = Calendar.getInstance();
        cal.setTime(getceyCURR(datacolumns));
        int endMonth = cal.get(Calendar.MONTH) + 1;
        //int endYear = cal.get(Calendar.YEAR);

        return endMonth;
    }

    public int getCopiesCURR(String[] datacolumns) {
        return datacolumns[27].isEmpty() ? 0 : Integer.parseInt(datacolumns[27]);
    }

    public boolean checkIfValidSubscriptionCURR(String[] datacolumns) throws ParseException {
        java.util.Date cey = getceyCURR(datacolumns);
        SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        if (cey.compareTo(dateFormat.parse("01/01/1900")) > 0) {
            return true;
        } else {
            return false;
        }
    }

    public String getCSYCURR(String[] datacolumns) throws ParseException {
        String CURRYR = datacolumns[26];
        String DATE_CURR = datacolumns[28];
        String CSY = "0";

        // This is a stray case in which CURRYR is not empty but DATE_CURR is empty. In such cases use the start year
        // CURRYR defines the period for which the subscription is valid
        // DATE_CURR defines the start year of subscription
        if ((DATE_CURR.isEmpty() || DATE_CURR == null)
                && !(CURRYR.isEmpty() || CURRYR.equals("0"))) {
            int startYr = Integer.parseInt(datacolumns[31]);
            DATE_CURR = Integer.toString(this.getCorrectedYear(startYr));
            DATE_CURR = "01/01/" + DATE_CURR;
            return (DATE_CURR);
        } else {
            SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
            java.util.Date csy = dateFormat.parse("01/01/1900");
            if (!(CURRYR.isEmpty() || CURRYR.equals("0") || DATE_CURR.isEmpty())) {
                CSY = DATE_CURR;
                csy = dateFormat.parse(CSY);
            }
        }
        return CSY;
    }

    public java.util.Date getcsyCURR(String[] datacolumns) throws ParseException {
        String CSY = getCSYCURR(datacolumns);
        SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        java.util.Date csy; //dateFormat.parse("01/01/1900");
        csy = dateFormat.parse(CSY);
        return csy;
    }

    public String getCEYCURR(String[] datacolumns) throws ParseException {
        String CURRYR = datacolumns[26];
        String DATE_CURR = datacolumns[28];
        SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        String CEY = "0";
        java.util.Date cey = getceyCURR(datacolumns);
        CEY = dateFormat.format(cey);

        return CEY;
    }

    public java.util.Date getceyCURR(String[] datacolumns) throws ParseException {
        String CURRYR = datacolumns[26];
        String DATE_CURR = datacolumns[28];
        String CEY = "0";
        SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        java.util.Date cey = dateFormat.parse("01/01/1900");
        if (!(getCSYCURR(datacolumns).equals("0"))) {
            Calendar temp = Calendar.getInstance();

            temp.setTime(dateFormat.parse(getCSYCURR(datacolumns)));
            if (!(CURRYR.isEmpty() || CURRYR.equals("0"))) {
                temp.add(Calendar.DAY_OF_YEAR, Integer.parseInt(CURRYR) * 364);
            }
            cey = temp.getTime();
            CEY = dateFormat.format(cey);
        }
        return cey;
    }

    public boolean insertSubscriptionDetailsForRES(int subscriberID, int subscription_id, String[] datacolumns) throws SQLException, ParseException {

        int journalGrpID = 10;
        int startYear = getstartYearRES(datacolumns);
        int endYear = getendYearRES(datacolumns);
        int subtypeID = getSubscriberTyeID(subscriberID);
        int priceGroupID = getJournalPriceGroupID(journalGrpID, subtypeID, startYear, endYear);

        boolean status = this.insertSubscriptionDetails(subscription_id,
                journalGrpID,
                getCopiesRES(datacolumns),
                startYear,
                getstartMonthRES(datacolumns),
                endYear,
                getendMonthRES(datacolumns),
                priceGroupID);
        return status;
    }

    public int getstartYearRES(String[] datacolumns) throws ParseException {
        Calendar cal = Calendar.getInstance();
        cal.setTime(getcsyRES(datacolumns));
        int startMonth = cal.get(Calendar.MONTH) + 1;
        int startYear = cal.get(Calendar.YEAR);
        return startYear;
    }

    public int getstartMonthRES(String[] datacolumns) throws ParseException {
        Calendar cal = Calendar.getInstance();
        cal.setTime(getcsyRES(datacolumns));
        int startMonth = cal.get(Calendar.MONTH) + 1;
        int startYear = cal.get(Calendar.YEAR);
        return startMonth;
    }

    public int getendYearRES(String[] datacolumns) throws ParseException {
        Calendar cal = Calendar.getInstance();
        cal.setTime(getceyRES(datacolumns));
        int endMonth = cal.get(Calendar.MONTH) + 1;
        int endYear = cal.get(Calendar.YEAR);

        return endYear;
    }

    public int getendMonthRES(String[] datacolumns) throws ParseException {
        Calendar cal = Calendar.getInstance();
        cal.setTime(getceyRES(datacolumns));
        int endMonth = cal.get(Calendar.MONTH) + 1;
        int endYear = cal.get(Calendar.YEAR);

        return endMonth;
    }

    public int getCopiesRES(String[] datacolumns) {
        return datacolumns[22].isEmpty() ? 0 : Integer.parseInt(datacolumns[22]);
    }

    public boolean checkIfValidSubscriptionRES(String[] datacolumns) throws ParseException {
        java.util.Date cey = getceyRES(datacolumns);
        SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        if (cey.compareTo(dateFormat.parse("01/01/1900")) > 0) {
            return true;
        } else {
            return false;
        }
    }

    public String getCSYRES(String[] datacolumns) throws ParseException {

        String CURRYR = datacolumns[21];
        String DATE_CURR = datacolumns[23];
        String CSY = "0";
        // This is a stray case in which RESYR is not empty but DATE_RES is empty. In such cases use the start year
        // RESYR defines the period for which the subscription is valid
        // DATE_RES defines the start year of subscription
        if ((DATE_CURR.isEmpty() || DATE_CURR == null)
                && !(CURRYR.isEmpty() || CURRYR.equals("0"))) {
            int startYr = Integer.parseInt(datacolumns[31]);
            DATE_CURR = Integer.toString(this.getCorrectedYear(startYr));
            DATE_CURR = "01/01/" + DATE_CURR;
            return (DATE_CURR);
        } else {
            SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
            java.util.Date csy = dateFormat.parse("01/01/1900");
            if (!(CURRYR.isEmpty() || CURRYR.equals("0") || DATE_CURR.isEmpty())) {
                CSY = DATE_CURR;
                csy = dateFormat.parse(CSY);
            }
        }
        return CSY;
    }

    public java.util.Date getcsyRES(String[] datacolumns) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        String CURRYR = datacolumns[21];
        String DATE_CURR = datacolumns[23];
        String CSY = "0";
        java.util.Date csy = dateFormat.parse("01/01/1900");
        if (!(CURRYR.isEmpty() || CURRYR.equals("0") || DATE_CURR.isEmpty())) {
            CSY = DATE_CURR;
            csy = dateFormat.parse(CSY);
        }
        return csy;
    }

    /*
     public String getCEYRES(String[] datacolumns) throws ParseException {
     SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
     String CURRYR = datacolumns[21];
     String CEY = "0";
     java.util.Date cey = dateFormat.parse("01/01/1900");
     if (!(getCSYRES(datacolumns).equals("0"))) {
     Calendar temp = Calendar.getInstance();

     temp.setTime(dateFormat.parse(getCSYRES(datacolumns)));
     if (!(CURRYR.isEmpty() || CURRYR.equals("0"))) {
     temp.add(Calendar.DAY_OF_YEAR, Integer.parseInt(CURRYR) * 364);
     }
     cey = temp.getTime();
     CEY = dateFormat.format(cey);
     }
     return CEY;
     }
     */
    public java.util.Date getceyRES(String[] datacolumns) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        String CURRYR = datacolumns[21];
        String CEY = "0";
        java.util.Date cey = dateFormat.parse("01/01/1900");
        if (!(getCSYRES(datacolumns).equals("0"))) {
            Calendar temp = Calendar.getInstance();

            temp.setTime(dateFormat.parse(getCSYRES(datacolumns)));
            if (!(CURRYR.isEmpty() || CURRYR.equals("0"))) {
                temp.add(Calendar.DAY_OF_YEAR, Integer.parseInt(CURRYR) * 364);
            }
            cey = temp.getTime();
            CEY = dateFormat.format(cey);
        }
        return cey;
    }

    private float calculate_balance(String[] _datacolumns) {
        float balance = 0;
        String chk_no = _datacolumns[18].trim();
        String bal_amt = _datacolumns[15].trim();
        String receipt_no = _datacolumns[16].trim();
        String receipt_dt = _datacolumns[17].trim();
        String dt_subsn = _datacolumns[14].trim();
        String amount = _datacolumns[13].trim();

        // chk_no should be blank
        if (chk_no.isEmpty()
                && bal_amt.isEmpty()
                && receipt_no.isEmpty()
                && receipt_dt.isEmpty()
                && dt_subsn.isEmpty()) {
            balance = Float.parseFloat(amount);
        }
        return balance;
    }
}
