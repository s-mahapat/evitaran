/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package JDSMigration;

import com.mysql.jdbc.Statement;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Calendar;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import jxl.read.biff.BiffException;
import org.apache.log4j.Logger;
/**
 *
 * @author Newton
 */
public class CurrMem extends MigrationBase{

    private static final Logger logger = Logger.getLogger(CurrMem.class.getName());
    private String insert_subscriber_sql;
    private String insert_subscription_sql;
    private String insert_subscription_legacy_sql;
    private String insert_subscription_detail_sql;
    public CurrMem() throws SQLException, IOException, BiffException{
        this.dataFile = this.dataFolder + "\\CURRMEM.xls";
        this.openExcel(this.dataFile);
        insert_subscriber_sql = "insert into subscriber(subscriberNumber,subscriberCreationDate,subscriberName,"
                + "department,institution,shippingaddress,invoiceAddress,city,state,country,pincode,subtype)values("
                + "?,?,?,?,?,?,?,?,?,?,?,?)";

        insert_subscription_sql = "insert into subscription(subscriberID,inwardID) values "
                + "(?, ?)";

        insert_subscription_legacy_sql = "insert into subscription_legacy(subscription_id, amount) values (?, ?)";

        insert_subscription_detail_sql = "insert into subscriptiondetails(subscriptionID,journalGroupID,copies,startYear,startMonth,endMonth,endYear,journalPriceGroupID) "
                + "values (?, ?, ?, ?, ?, ?, ?, ?)";

    }

    @Override
    public void Migrate() throws SQLException, IOException, BiffException, ParseException,
                                    InvocationTargetException, IllegalAccessException, Exception {
        //this.conn.setAutoCommit(false);
        //int commitCounter = 0;
        String[] datacolumns;
        int rownum = 0;
        PreparedStatement pst = conn.prepareStatement(insert_subscriber_sql, Statement.RETURN_GENERATED_KEYS);
        //PreparedStatement pst_sub = conn.prepareStatement(insert_subscription_sql, Statement.RETURN_GENERATED_KEYS);
        //PreparedStatement pst_legacy = conn.prepareStatement(insert_subscription_legacy_sql);

        while (true) {
            datacolumns = this.getNextRow();
            if (datacolumns == null) {
                break;
            }
            rownum++;
            String state = datacolumns[8];
            //skip if state contains STOP
            if(state.contains("STOP")){
                logger.debug("STOP flag found at row num:" + rownum);
                continue;
            }

            String name = datacolumns[1];
            String department = datacolumns[2];
            String institute = datacolumns[3];
            String address = datacolumns[4] + " " + datacolumns[5];
            String cityAndPin = datacolumns[6];
            String pin = datacolumns[7].replaceAll(" ", "");
            pin = pin.isEmpty() ? "0" : pin;

            float  amount = 0;
            if(!(datacolumns[11].isEmpty() || datacolumns[11] == null || datacolumns[11].equalsIgnoreCase("null"))){
                String amountTemp = datacolumns[11].replaceAll("/-", "");
                amount = Float.parseFloat(amountTemp);
            }
            int cityid = 0;
            int stateid;

            // get the city name from city+pin columns
            Pattern p = Pattern.compile("^(.*?)\\s*(\\d+\\s*\\d+)$");
            Matcher m = p.matcher(cityAndPin);
            if (m.find()) {
                String city = m.group(1);
                cityid = this.getCityID(city);
            }

            // get the state id
            stateid = this.getStateID(state);
            if (cityid == 0){
                logger.warn("Found City with Id 0 " + cityAndPin);
                address = address + " " + cityAndPin;
            }
            if (stateid == 0){
                logger.warn("Found State with Id 0 " + datacolumns[8]);
                address = address + " " + datacolumns[8];
            }
            int paramindex = 0;


            pst.setString(++paramindex, this.getNextSubscriberNumber());
            pst.setDate(++paramindex, util.dateStringToSqlDate(util.getDateString()));
            pst.setString(++paramindex, name);
            pst.setString(++paramindex, department);
            pst.setString(++paramindex, institute);
            pst.setString(++paramindex, address);
            pst.setString(++paramindex, address);
            pst.setInt(++paramindex, cityid);
            pst.setInt(++paramindex, stateid);
            pst.setInt(++paramindex, this.getIndiaID());
            pst.setInt(++paramindex, Integer.parseInt(pin));
            //pst.setInt(++paramindex, 17);
            pst.setInt(++paramindex, this.getSubTypeId("MEMBER"));

            int upd_count = pst.executeUpdate();
            if(upd_count == 1){
                ResultSet rs = pst.getGeneratedKeys();
                rs.first();
                int subscriberId = rs.getInt(1);

                this.conn.setAutoCommit(false);
                //paramindex = 0;

                //pst_sub.setInt(++paramindex, subscriberId);
                //pst_sub.setInt(++paramindex, 0);
                //pst_sub.setBoolean(++paramindex, true);
                //pst_sub.setFloat(++paramindex, amount);

                int subscriptionID = this.insertSubscription(subscriberId, 0);

                //upd_count = pst_sub.executeUpdate();
                if(subscriptionID > 0){
                    //ResultSet rs1 = pst_sub.getGeneratedKeys();
                    //rs1.first();

                    //pst_legacy.setInt(1, subscriptionID);
                    //pst_legacy.setFloat(2, amount);
                    //pst_legacy.executeUpdate();
                    paramindex = 0;
                    PreparedStatement pst_sub_detail = conn.prepareStatement(insert_subscription_detail_sql);
                    pst_sub_detail.setInt(++paramindex, subscriptionID);
                    pst_sub_detail.setInt(++paramindex, 11);
                    pst_sub_detail.setInt(++paramindex, 1);
                    pst_sub_detail.setInt(++paramindex, Calendar.getInstance().get(Calendar.YEAR));
                    pst_sub_detail.setInt(++paramindex, 1);
                    pst_sub_detail.setInt(++paramindex, 12);
                    pst_sub_detail.setInt(++paramindex, 2050);
                    pst_sub_detail.setInt(++paramindex, 1);
                    pst_sub_detail.executeUpdate();
                    this.conn.commit();
                    logger.debug("subscriber migrated for row: " + rownum);
                }

            }

        }
    }
}
