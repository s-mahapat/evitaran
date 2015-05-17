/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package JDSMigration;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Calendar;
import jxl.read.biff.BiffException;
import org.apache.log4j.Logger;

/**
 *
 * @author Shailendra
 */
public class RESOEB extends MigrationBase {

    private static final Logger logger = Logger.getLogger(RESOEB.class.getName());

    public RESOEB() throws SQLException, IOException, BiffException {
        this.dataFile = this.dataFolder + "\\RESOEB.xls";
        this.openExcel(this.dataFile);
    }

    @Override
    public void Migrate() throws SQLException, IOException, BiffException, ParseException,
            InvocationTargetException, IllegalAccessException, Exception {

        String[] datacolumns;
        int rownum = 1;
        //this.conn.setAutoCommit(false);
        int success = 0;
        //int commitCounter = 0;

        while (true) {
            datacolumns = this.getNextRow();
            if (datacolumns == null) {
                break;
            }
            rownum++;
            logger.info("Migrating row: " + rownum);

            String initial = datacolumns[0];
            String name = initial + " " + datacolumns[1];
            String address = null;
            String institute = null;
            String department = null;
            int pin = this.getPinCode(datacolumns[9]);
            String phone = datacolumns[10];
            String fax = datacolumns[11];
            int stateid = 0;
            int countryid = this.getIndiaID(); //default to india
            int cityid = 0;
            String subscriberType = datacolumns[15];
            int subscriberTypeID = 0;
            String subscriberTypeCode = null;
            int copies = Integer.parseInt(datacolumns[14]);

            if (datacolumns[3].isEmpty() == false) {
                //address = address == null ? datacolumns[1] : address + "\n" + datacolumns[1];
                institute = datacolumns[3];
            }

            if (datacolumns[2].isEmpty() == false) {
                //address = address == null ? datacolumns[2] : address + "\n" + datacolumns[2];
                department = datacolumns[2];
            }

            if (datacolumns[4].isEmpty() == false) {
                address = address == null ? datacolumns[4] : address + "\n" + datacolumns[4];
            }

            if (datacolumns[5].isEmpty() == false) {
                address = address == null ? datacolumns[5] : address + "\n" + datacolumns[5];
            }
            /*
            if (datacolumns[10].isEmpty() == false) {
                address = address == null ? datacolumns[10] : address + "\nTel: " + datacolumns[10];
            }
            if (datacolumns[11].isEmpty() == false) {
                address = address == null ? datacolumns[11] : address + "\nFAX: " + datacolumns[11];
            }
            */

            /*
            if ((subscriberType.equalsIgnoreCase("I") || subscriberType.isEmpty()) && !subscriberType.equalsIgnoreCase("F")) {
                subscriberTypeID = 8; //code for indian institutes
                subscriberTypeCode = "II";
            } else if (!subscriberType.isEmpty() && subscriberType.equalsIgnoreCase("F")) {
                subscriberTypeID = 13; //code for foreign institutes
                subscriberTypeCode = "FI";
            } else {
                throw new Exception("Cannot determine subscriber type");
            }
            */
            subscriberTypeCode = "EBALL";
            subscriberTypeID = this.getSubTypeId("EBALL");

            String cityPin = datacolumns[6];
            String country = datacolumns[8];

            if(datacolumns[15].equals("I")){
                stateid = this.getStateID(datacolumns[8]);
                countryid = this.getIndiaID();
            } else {
                countryid = this.getCountryID(datacolumns[8]);
            }

            //stateid = this.getStateID(datacolumns[7]);
            if (cityPin.matches(".*\\d+$")) {
                String[] city = cityPin.split("\\d+", 2);
                cityid = this.getCityID(city[0]);
                logger.debug("city is:" + city[0]);
                logger.debug("city id is:" + cityid);
            }

            if (cityid == 0){
                logger.warn("Found City with Id 0 " + cityPin);
                address = address + " " + cityPin;
            }
            if (stateid == 0){
                logger.warn("Found State with Id 0 " + datacolumns[7]);
                address = address + " " + datacolumns[7];
            }
            if (countryid == 0){
                logger.warn("Found Country with Id 0 " + datacolumns[8]);
                address = address + " " + datacolumns[8];
            }
            String email = datacolumns[12];
            if(!validateEmail(email)){
                email = "";
                logger.warn("Found email ID " + email +" that is not valid for subscriber name: " + name);
            }
            int subscriberid = this.insertSubscriber(
                    subscriberTypeCode,
                    name,
                    department,
                    institute,
                    address,
                    address,
                    cityid,
                    stateid,
                    pin,
                    countryid,
                    email,
                    phone,
                    fax);

            if(subscriberid > 0){
                logger.info("Successfully inserted subsciber data for:" + name);
                int subscription_id = this.insertSubscription(subscriberid);
                if(subscription_id > 0){
                    boolean isSuccess = this.insertSubscriptionDetails(
                            subscription_id,
                            10, //jgroup id
                            copies, //copies
                            Calendar.getInstance().get(Calendar.YEAR), //start year
                            1, //start month
                            2050, //end year
                            12, //end month
                            1); //price group id

                    if(isSuccess){
                        logger.info("Subscription inserted successfully for: " + name);
                        success++;
                    }
                }
            }else{
                logger.fatal("Failed to insert subscriber for: " + name);
            }

        }
        //this.conn.commit();
        //this.conn.setAutoCommit(true);
        logger.info("Total rows: " + (rownum - 1));
        logger.info("Success: " + success);
    }
}
