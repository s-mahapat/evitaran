/*
 * 20-Mar-2014: Alok Modak: All subscriptions for these subscribers are inactive
 * 
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
public class HON_MEM2 extends MigrationBase{

    private static final Logger logger = Logger.getLogger(HON_MEM2.class.getName());

    public HON_MEM2() throws SQLException, IOException, BiffException {
        this.dataFile = this.dataFolder + "\\HON_MEM2.xls";
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

            String name = datacolumns[3] + " " + datacolumns[2];
            String address = "";
            String institute = datacolumns[5];
            String invoiceaddress = "";
            String department = "";
            int pin = 0; //this.getPinCode(datacolumns[10]);
            int stateid = 0; //this.getStateID(datacolumns[11]);
            int countryid = 0; //this.getIndiaID(); //default to india
            int cityid = 0; //this.getCityID(datacolumns[9]);
            String cityPin = ""; //datacolumns[9];
            String email = ""; //datacolumns[13];


            address += datacolumns[4].length() > 0 ? "\n" + datacolumns[4] : "";
            address += datacolumns[6].length() > 0 ? "\n" + datacolumns[6] : "";
            address += datacolumns[7].length() > 0 ? "\n" + datacolumns[7] : "";
            address += datacolumns[8].length() > 0 ? "\n" + datacolumns[8] : "";

            invoiceaddress += institute.length() > 0 ? "\n" + institute.trim() : "";
            invoiceaddress += invoiceaddress.length() > 0 ? "\n" + address.trim() :  address;

            int copies = 1;

//            if (datacolumns[4].isEmpty() == false) {
//                address = address == null ? datacolumns[4] : address + "\n" + datacolumns[4];
//            }
//            if (datacolumns[5].isEmpty() == false) {
//                address = address == null ? datacolumns[5] : address + "\n" + datacolumns[5];
//            }

            if (cityPin.matches(".*\\d+$")) {
                String[] city = cityPin.split("\\d+", 2);
                cityid = this.getCityID(city[0]);
                logger.debug("city is:" + city[0]);
                logger.debug("city id is:" + cityid);
            }
            if (cityid == 0){
                //logger.warn("Found City with Id 0 " + cityPin);
                //address = address + " " + cityPin;
            }
            if (stateid == 0){
                //logger.warn("Found State with Id 0 " + datacolumns[11]);
                //address = address + " " + datacolumns[11];
            }
            int subscriberid = this.insertSubscriber(
                   "HONFEL",
                    name,
                    department,
                    institute,
                    address,
                    invoiceaddress,
                    cityid,
                    stateid,
                    pin,
                    countryid,
                    email,
                    null,
                    null);
            if(subscriberid > 0){
                logger.info("Successfully inserted subsciber data for:" + name);
                int subscription_id = this.insertSubscriptionInactive(subscriberid);
                if(subscription_id > 0){
                    boolean isSuccess = this.insertSubscriptionDetailsInactive(
                            subscription_id,
                            6, //jgroup id for BMS
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
