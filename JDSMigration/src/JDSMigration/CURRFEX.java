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
public class CURRFEX extends MigrationBase{

    private static final Logger logger = Logger.getLogger(CURRFEX.class.getName());

    public CURRFEX() throws SQLException, IOException, BiffException {
        this.dataFile = this.dataFolder + "\\CURRFEX.xls";
        this.openExcel(this.dataFile);
    }

    @Override
    public void Migrate() throws SQLException, IOException, BiffException, ParseException,
            InvocationTargetException, IllegalAccessException, Exception {

        String[] datacolumns;
        int rownum = 1;
        int success = 0;

        while (true) {
            datacolumns = this.getNextRow();
            if (datacolumns == null) {
                break;
            }
            rownum++;
            logger.info("Migrating row: " + rownum);

            if(datacolumns[0].equalsIgnoreCase("Y") == false){
                continue; // next record if the record is not marked for selection with Y flag
            }
            String name = datacolumns[3];
            String address = null;
            String institute = datacolumns[5];
            String department = datacolumns[4];
            int pin = 0;
            int stateid = 0;
            int countryid = this.getCountryID(datacolumns[9]);
            int cityid = this.getCityID(datacolumns[8]);
            //String cityPin = datacolumns[6];

            int copies = this.getInteger(datacolumns[10]);

            if (copies == 0) {
                continue; // do not migrate if there is no subscription
            }

            if (datacolumns[6].isEmpty() == false) {
                address = address == null ? datacolumns[6] : address + "\n" + datacolumns[6];
            }
            if (datacolumns[7].isEmpty() == false) {
                address = address == null ? datacolumns[7] : address + "\n" + datacolumns[7];
            }

            if (cityid == 0){
                logger.warn("Found City with Id 0 " + datacolumns[8]);
                address = address + " " + datacolumns[8];
            }
            if (countryid == 0){
                logger.warn("Found Country with Id 0 " + datacolumns[9]);
                address = address + " " + datacolumns[9];
            }
            int subscriberid = this.insertSubscriber(
                    "EF",
                    name,
                    department,
                    institute,
                    address,
                    address,
                    cityid,
                    stateid,
                    pin,
                    countryid,
                    null,
                    null,
                    null);
            if (subscriberid > 0) {
                logger.info("Successfully inserted subsciber data for:" + name);
                int subscription_id = this.insertSubscription(subscriberid);
                if (subscription_id > 0) {
                    boolean isSuccess = this.insertSubscriptionDetails(
                            subscription_id,
                            11, //jgroup id
                            copies, //copies
                            Calendar.getInstance().get(Calendar.YEAR), //start year
                            1, //start month
                            2050, //end year
                            12, //end month
                            1); //price group id

                    if (isSuccess) {
                        logger.info("Subscription inserted successfully for: " + name);
                        success++;
                    }
                } else {
                    logger.fatal("Failed to insert subscription for: " + name);
                }
            } else {
                logger.fatal("Failed to insert subscriber for: " + name);
            }
        }
        logger.info("Total rows: " + (rownum - 1));
        logger.info("Success: " + success);
    }
}
