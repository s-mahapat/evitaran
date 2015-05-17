/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package JDSMigration;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jxl.read.biff.BiffException;
import org.apache.log4j.Logger;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.ListIterator;

/**
 *
 * @author aloko
 */
public class migrateHONFEL extends MigrationBase{

    private static final Logger logger = Logger.getLogger(migrateHONFEL.class.getName());

        Connection conn = null;
        private int COMMIT_BATCH_SIZE = 1000;

        // Fellows do not have a subscriber no, hence we take the last subscriber ID and start from there
        //int subscriberNumberStart;

        public migrateHONFEL() throws SQLException {
        this.dataFile = this.dataFolder + "\\HONFEL.xls";
        this.conn = this.db.getConnection();
        conn.setAutoCommit(false);
        //subscriberNumberStart = getLastSubscriberId() + 1;
    }

    @Override
    public void Migrate() throws FileNotFoundException, IOException, BiffException, SQLException, ParseException, InvocationTargetException, IllegalAccessException, Exception {

        this.openExcel(dataFile);
        logger.debug("able to open file" + dataFile.toString());

        String[] datacolumns = null;
        int totalRows = 0;
        int insertedSubscribers = 0;
        int insertedSubscriptions = 0;
        int[] jrnlNoOfCopies = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
        int recordCounter = 0;

        PreparedStatement pst_insert_subscriber = null,
                pst_insert_subscription = null,
                pst_insert_subscription_dtls = null;
        pst_insert_subscriber = this.conn.prepareStatement(sql_insert_subscriber_dt, com.mysql.jdbc.Statement.RETURN_GENERATED_KEYS);
        pst_insert_subscription = this.conn.prepareStatement(sql_insert_subscription_free_subs, Statement.RETURN_GENERATED_KEYS);
        pst_insert_subscription_dtls = this.conn.prepareStatement(sql_insert_subscriptiondetails);

        //int subscriberNumber = subscriberNumberStart;

        while (true) {
            datacolumns = this.getNextRow();
            if (datacolumns == null) {
                break;
            }
            totalRows++;

            // This is the first row, which has all the column names
            if(totalRows == 0) {
                continue;
            }

            /*----------------------------------------------------------------*/
            /*---Insert Subscriber ---*/
            /*----------------------------------------------------------------*/
            // Extract data
            String agentCode    = "0";
            String subtype      = "HONFEL";
            String subscriberName   = datacolumns[1] + " " + datacolumns[2] + " " + datacolumns[3];
            String department       = datacolumns[4];
            String institution      = datacolumns[5];
            String shippingAddress      = datacolumns[6] + " " + datacolumns[7];
            String cityAndPin   = datacolumns[8];
            String pincode      = "";
            String state        = "";
            String country      = datacolumns[9];
            String email        = datacolumns[10];
            if(!validateEmail(email)){
                email = "";
                logger.warn("Found email ID " + email +" that is not valid for subscriber name: " + subscriberName);
            }

            //subscriberName, department, institution and address have "" quotes, remove them
            subscriberName = subscriberName.replaceAll("\"", "");
            department = department.replaceAll("\"", "");
            institution = institution.replaceAll("\"", "");
            shippingAddress = shippingAddress.replaceAll("\"", "");

            // City has to be extracted from "cityAndpin" field. Do this only for those cityAndpin for which the pincode exists in a separate field
            // For cityAndpin for which the pincode does not exist, means this is a foreign country
            int cityID=0;
            if(!pincode.isEmpty())
            {
                String city = null;
                try{
                    city = cityAndPin.replaceAll(pincode, "");

                    if (this.cityMap.containsKey(city)) {
                        city = this.cityMap.get(city);
                    }

                    cityID = this.getCityID(city);

                    if(cityID == 0)
                    {
                        logger.warn("Found city " + city + " which does not have a entry in the database");
                        shippingAddress = shippingAddress + " " + cityAndPin;
                    }
                }catch(NumberFormatException e){
                    logger.warn("Exception: " + e.getMessage() + " for cityAndPin " + cityAndPin);
                }
            }
            else
            {
                shippingAddress = shippingAddress + " " + cityAndPin;
            }

            // Now get the stateID
            int stateID = 0;
            if(!state.isEmpty())
            {
                if (this.stateMap.containsKey(state)) {
                    state = this.stateMap.get(state);
                }
                stateID = this.getStateID(state);
                if(stateID == 0)
                {
                    logger.warn("Found state " + state + " which does not have a entry in the database");
                    shippingAddress = shippingAddress + " " + state;
                }
            }

            // Now get the countryID
            int countryID = 0;
            if(!country.isEmpty())
            {
                if (this.countryMap.containsKey(country)) {
                    country = this.countryMap.get(country);
                }
                countryID = this.getCountryID(country);
                if(countryID == 0)
                {
                    logger.warn("Found country " + country + " which does not have a entry in the database");
                    shippingAddress = country + " " + country;
                }
            }

            // Replace the space in the pincode and convert to integer
            int pin = 0;
            if(!pincode.isEmpty())
            {
                try{
                    pin = this.getPinCode(pincode.replaceAll(" ", ""));
                }catch(NumberFormatException e){
                    logger.warn("Exception: " + e.getMessage() + " for pincode " + pincode);
                    pin = 0;
                    shippingAddress = shippingAddress + " " + pincode;
                }
            }

            String subscriberNumber = this.getNextSubscriberNumber();

            // Insert into the database
            int paramIndex = 0;
            pst_insert_subscriber.setString(++paramIndex, subtype);
            pst_insert_subscriber.setString(++paramIndex, subscriberNumber);
            pst_insert_subscriber.setString(++paramIndex, subscriberName);
            pst_insert_subscriber.setString(++paramIndex, department);
            pst_insert_subscriber.setString(++paramIndex, institution);
            pst_insert_subscriber.setString(++paramIndex, shippingAddress);
            pst_insert_subscriber.setString(++paramIndex, shippingAddress);
            pst_insert_subscriber.setInt(++paramIndex, cityID);
            pst_insert_subscriber.setInt(++paramIndex, stateID);
            pst_insert_subscriber.setInt(++paramIndex, pin);
            pst_insert_subscriber.setInt(++paramIndex, countryID);
            pst_insert_subscriber.setInt(++paramIndex, 0);
            pst_insert_subscriber.setString(++paramIndex, email);
            pst_insert_subscriber.setDate(++paramIndex, util.dateStringToSqlDate(util.getDateString()));
            pst_insert_subscriber.setString(++paramIndex, null); // for phone
            pst_insert_subscriber.setString(++paramIndex, null); // for fax
            pst_insert_subscriber.addBatch();

            int subscriberid = 0;
            if (pst_insert_subscriber.executeUpdate() == 1) {
                try (ResultSet rs = pst_insert_subscriber.getGeneratedKeys();) {
                    if (rs.first()) {
                        subscriberid = rs.getInt(1);
                    }
                }
            }
            recordCounter++;
            insertedSubscribers++;

            /*
            int ret = this.db.executeUpdatePreparedStatement(pst_insert_subscriber);
            if (ret == 0) {
                logger.fatal("Failed to insert subscriber: " + subscriberNumber + " Name: " + subscriberName);
                break;
            } else {
                recordCounter++;
                insertedSubscribers++;
            }
            */
            if(getTotalNoOfCopiesHONFEL(datacolumns)>0){

                /*----------------------------------------------------------------*/
                /*---Insert Subscription ---*/
                /*----------------------------------------------------------------*/
                int inwardId = 0;
                int ret;
                /*paramIndex = 0;
                pst_insert_subscription.setInt(++paramIndex, subscriberid);
                pst_insert_subscription.setInt(++paramIndex, inwardId);*/
                //pst_insert_subscription.setBoolean(++paramIndex, true);

                //Inserting the record in Subscription Table
                //int ret = this.db.executeUpdatePreparedStatement(pst_insert_subscription);

                int subscriptionID = this.insertSubscription(subscriberid, inwardId);

                //Logging the inserting row
                if (subscriptionID > 0) {
                    recordCounter++;
                    insertedSubscriptions++;
                } else {
                    logger.fatal("Failed to insert subscription for: " + subscriberNumber + " Name: " + subscriberName);
                    break;
                }

                //Getting back the subsciption Id
                //ResultSet rs_sub = pst_insert_subscription.getGeneratedKeys();
                //rs_sub.first();


                /*----------------------------------------------------------------*/
                /*---Insert Subscription details---*/
                /*----------------------------------------------------------------*/
                int[] jrnlArr = {22, 23, 24, 25, 26, 27, 28, 29, 31};   //Data Columns frm excel
                int[] jrnlGrpIDArr = {5, 3, 4, 1, 7, 8, 6, 9, 2};       //Journal Group IDs

                for (int j = 0; j < jrnlArr.length; j++) {
                    if (!datacolumns[jrnlArr[j]].equalsIgnoreCase("0") && !datacolumns[jrnlArr[j]].isEmpty()) {
                        paramIndex = 0;
                        int noCopies = Integer.parseInt(datacolumns[jrnlArr[j]]);
                        int startMonth = 1;
                        int endMonth = 12;
                        int startYr = 2012;
                        int endYr = 2050;
                        int priceGroupID = 1;
                        pst_insert_subscription_dtls.setInt(++paramIndex, subscriptionID);
                        pst_insert_subscription_dtls.setInt(++paramIndex, jrnlGrpIDArr[j]);
                        pst_insert_subscription_dtls.setInt(++paramIndex, noCopies);
                        pst_insert_subscription_dtls.setInt(++paramIndex, startYr);
                        pst_insert_subscription_dtls.setInt(++paramIndex, startMonth);
                        pst_insert_subscription_dtls.setInt(++paramIndex, endYr);
                        pst_insert_subscription_dtls.setInt(++paramIndex, endMonth);
                        pst_insert_subscription_dtls.setInt(++paramIndex, priceGroupID);

                        //Inserting the record in Subscription Table
                        ret = this.db.executeUpdatePreparedStatement(pst_insert_subscription_dtls);
                        //Logging the inserting row
                        if (ret == 1) {
                            recordCounter++;
                            jrnlNoOfCopies[jrnlGrpIDArr[j]-1] = jrnlNoOfCopies[jrnlGrpIDArr[j]-1] + noCopies;
                        } else {
                            logger.fatal("Failed to insert subscription deatils for: " + subscriberNumber + " Name: " + subscriberName);
                            break;
                        }
                    }
                }
            }
            /*----------------------------------------------------------------*/
            if(recordCounter >= COMMIT_BATCH_SIZE){
                logger.debug("Commiting database after " + String.valueOf(insertedSubscribers) + " rows");
                conn.commit();
                recordCounter = 0;
            }
            //subscriberNumber++;
        }
        conn.commit();
        logger.debug("Total Rows: " + totalRows);
        logger.debug("Subscribers Inserted: " + insertedSubscribers);
        for (int j = 0; j < jrnlNoOfCopies.length; j++) {
            logger.debug("Journal " + j + " no of copies " + jrnlNoOfCopies[j]);
        }

        //this.CloseFile();
    }

    public int getTotalNoOfCopiesHONFEL(String[] datacolumns) {
        int noCopies = 0;
        int[] jrnlArr = {22, 23, 24, 25, 26, 27, 28, 29, 31};   //Data Columns frm excel
        for (int j = 0; j < jrnlArr.length; j++) {
            if (!datacolumns[jrnlArr[j]].equalsIgnoreCase("0") && !datacolumns[jrnlArr[j]].isEmpty()) {
                noCopies = noCopies + Integer.parseInt(datacolumns[jrnlArr[j]]);
            }
        }
        return noCopies;
    }

}
