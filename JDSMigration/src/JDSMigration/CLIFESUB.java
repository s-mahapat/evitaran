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
public class CLIFESUB extends MigrationBase{

    private static final Logger logger = Logger.getLogger(CLIFESUB.class.getName());

    public CLIFESUB() throws SQLException, IOException, BiffException {
        this.dataFile = this.dataFolder + "\\CLIFESUB.xls";
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

            String name = datacolumns[1];
            String address = null;
            String institute = datacolumns[3];
            String department = datacolumns[2];
            int pin = this.getPinCode(datacolumns[7]);
            int stateid = this.getStateID(datacolumns[8]);
            int countryid = this.getIndiaID(); //default to india
            int cityid = 0;
            String cityPin = datacolumns[6];

            int copies = this.getInteger(datacolumns[10]);

            if(copies == 0){
                continue; // do not migrate if there is no subscription
            }

            if (datacolumns[4].isEmpty() == false) {
                address = address == null ? datacolumns[4] : address + "\n" + datacolumns[4];
            }
            if (datacolumns[5].isEmpty() == false) {
                address = address == null ? datacolumns[5] : address + "\n" + datacolumns[5];
            }

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
                logger.warn("Found State with Id 0 " + datacolumns[8]);
                address = address + " " + datacolumns[8];
            }

            int subscriberid = this.insertSubscriber(
                    "LSP",
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
            if(subscriberid > 0){
                logger.info("Successfully inserted subsciber data for:" + name);
                int subscription_id = this.insertSubscription(subscriberid);
                if(subscription_id > 0){
                    boolean isSuccess = this.insertSubscriptionDetails(
                            subscription_id,
                            11, //jgroup id
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
                }else{
                    logger.fatal("Failed to insert subscription for: " + name);
                }
            }else{
                logger.fatal("Failed to insert subscriber for: " + name);
            }

        }
        logger.info("Total rows: " + (rownum - 1));
        logger.info("Success: " + success);
    }
}
