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
public class RESOCOMP extends MigrationBase {

    private static final Logger logger = Logger.getLogger(RESOCOMP.class.getName());

    public RESOCOMP() throws SQLException, IOException, BiffException {
        this.dataFile = this.dataFolder + "\\RESOCOMP.xls";
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

            String name = datacolumns[0];
            String address = null;
            String institute = null;
            String department = null;
            int pin = this.getPinCode(datacolumns[6]);
            int stateid = 0;
            int countryid = this.getIndiaID(); //default to india
            int cityid = 0;
            String subscriberType = datacolumns[8];
            int subscriberTypeID = 0;
            String subscriberTypeCode = null;

            if (datacolumns[1].isEmpty() == false) {
                //address = address == null ? datacolumns[1] : address + "\n" + datacolumns[1];
                institute = datacolumns[1];
            }

            if (datacolumns[2].isEmpty() == false) {
                //address = address == null ? datacolumns[2] : address + "\n" + datacolumns[2];
                department = datacolumns[2];
            }

            if (datacolumns[3].isEmpty() == false) {
                address = address == null ? datacolumns[3] : address + "\n" + datacolumns[3];
            }

            if (datacolumns[4].isEmpty() == false) {
                address = address == null ? datacolumns[4] : address + "\n" + datacolumns[4];
            }
            if(address == null){
                address = "";
            }


            if (subscriberType.equalsIgnoreCase("I") || (subscriberType.isEmpty() && !subscriberType.equalsIgnoreCase("F"))) {
                subscriberTypeID = this.getSubTypeId("EI"); //code for indian institutes
                subscriberTypeCode = "EI";
            } else if (!subscriberType.isEmpty() && subscriberType.equalsIgnoreCase("F")) {
                subscriberTypeID = this.getSubTypeId("EF"); //code for foreign institutes
                subscriberTypeCode = "EF";
            } else {
                throw new Exception("Cannot determine subscriber type: " + subscriberType);
            }


            String cityPin = datacolumns[5];
            String country = datacolumns[7];

            // get the country id if its a foreign subscriber
            if (subscriberTypeCode.equals("EF")) {
                countryid = this.getCountryID(country);
                address += "\n" + cityPin; //append citypin to the address
                logger.debug("Country id is:" + countryid);
            } else {
                stateid = this.getStateID(datacolumns[7]);
                if (cityPin.matches(".*\\d+$")) {
                    String[] city = cityPin.split("\\d+", 2);
                    cityid = this.getCityID(city[0]);
                    logger.debug("city is:" + city[0]);
                    logger.debug("city id is:" + cityid);
                }
            }
            if (cityid == 0){
                logger.warn("Found City with Id 0 " + cityPin);
                address = address + " " + cityPin;
            }
            if (stateid == 0){
                logger.warn("Found State with Id 0 " + datacolumns[7]);
                address = address + " " + datacolumns[7];
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
                    "",
                    null,
                    null);

            if(subscriberid > 0){
                logger.info("Successfully inserted subsciber data for:" + name);
                int subscription_id = this.insertSubscription(subscriberid);
                if(subscription_id > 0){
                    boolean isSuccess = this.insertSubscriptionDetails(
                            subscription_id,
                            10, //jgroup id
                            1, //copies
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
