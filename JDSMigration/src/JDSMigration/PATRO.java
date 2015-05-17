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
public class PATRO extends MigrationBase{

    private static final Logger logger = Logger.getLogger(PATRO.class.getName());

    public PATRO() throws SQLException, IOException, BiffException {
        this.dataFile = this.dataFolder + "\\PATRO.xls";
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

            String name = datacolumns[3];
            String address = "";
            String institute = datacolumns[4] + " " + datacolumns[5];
            String invoiceaddress = "";
            String department = "";
            int pin = this.getPinCode(datacolumns[9]);
            int stateid = 0; //this.getStateID(datacolumns[11]);
            int countryid = 0; //this.getIndiaID(); //default to india
            String cityname = datacolumns[8];
            int cityid = this.getCityID(cityname);
            String cityPin = ""; //datacolumns[9];
            String email = ""; //datacolumns[13];


            address += datacolumns[6].length() > 0 ? "\n" + datacolumns[6].trim() : "";
            address += datacolumns[7].length() > 0 ? "\n" + datacolumns[7].trim() : "";

            int copies = 1;

            if (cityPin.matches(".*\\d+$")) {
                String[] city = cityPin.split("\\d+", 2);
                cityid = this.getCityID(city[0]);
                logger.debug("city is:" + city[0]);
                logger.debug("city id is:" + cityid);
            }
            if (cityid == 0){
                //logger.warn("Found City with Id 0 " + cityPin);
                address += address.length() > 0 ? "\n" + cityname : cityname;
            }
            //if (stateid == 0){
                //logger.warn("Found State with Id 0 " + datacolumns[11]);
                //address = address + " " + datacolumns[11];
            //}

            invoiceaddress += institute.length() > 0 ? "\n" + institute.trim() : "";
            invoiceaddress += invoiceaddress.length() > 0 ? "\n" + address.trim() :  address;

            int subscriberid = this.insertSubscriber(
                   "LSP",
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
                int subscription_id = this.insertSubscription(subscriberid);
                if(subscription_id > 0){
                    boolean isSuccess = this.insertSubscriptionDetails(
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
