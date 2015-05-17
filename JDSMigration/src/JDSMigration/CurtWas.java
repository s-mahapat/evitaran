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
import jxl.read.biff.BiffException;
import org.apache.log4j.Logger;

/**
 *
 * @author Newton
 */
public class CurtWas extends MigrationBase{

    private static final Logger logger = Logger.getLogger(CurtWas.class.getName());
    private String insert_subscriber_sql;
    private String insert_subscription_sql;
    private String insert_subscription_detail_sql;

    /**
     *
     * @throws SQLException
     * @throws IOException
     * @throws BiffException
     */
    public CurtWas() throws SQLException, IOException, BiffException{
        this.dataFile = this.dataFolder + "\\CURTWAS.xls";
        this.openExcel(this.dataFile);
        insert_subscriber_sql = "insert into subscriber(subscriberNumber,subscriberCreationDate,subscriberName,"
                + "shippingaddress,invoiceAddress,country,subtype,department,institution)values(?,?,?,?,?,?,?,?,?)";

        insert_subscription_sql = "insert into subscription(subscriberID,inwardID,legacy) values "
                + "(?, ?, ?)";

        insert_subscription_detail_sql = "insert into subscriptiondetails(subscriptionID,journalGroupID,copies,startYear,startMonth,endMonth,endYear,journalPriceGroupID) "
                + "values (?, ?, ?, ?, ?, ?, ?, ?)";

    }

    @Override
    public void Migrate() throws SQLException, IOException, BiffException, ParseException,
                                    InvocationTargetException, IllegalAccessException, Exception {
        //this.conn.setAutoCommit(false);
        //int commitCounter = 0;
        String[] datacolumns;
        int rownum = 1;

        while (true) {
            datacolumns = this.getNextRow();
            if (datacolumns == null) {
                break;
            }
            rownum++;

            boolean select = datacolumns[0].equalsIgnoreCase("Y") ? true : false;
            // only select rows which have Y
            if(!select){
                continue;
            }
            String affil = datacolumns[1];
            String desig = datacolumns[2];
            String name = "";
            int countryid;

            if(!affil.isEmpty()){
                name += affil;
            }
            if(!desig.isEmpty()){
                name += " " + desig;
            }
            name += datacolumns[3];

            String department = datacolumns[4];
            String institution = datacolumns[5];

            String address =  datacolumns[6] + " " + datacolumns[7] + " " +
                            datacolumns[8] + " " + datacolumns[9];
            String country = datacolumns[10];
            countryid = this.getCountryID(country);
            if(countryid == 0){
                logger.warn("Failed to get country id for " + country);
                address = address + " " + datacolumns[10];
            }
            int paramindex = 0;
            PreparedStatement pst = conn.prepareStatement(insert_subscriber_sql, Statement.RETURN_GENERATED_KEYS);

            pst.setString(++paramindex, this.getNextSubscriberNumber());
            pst.setDate(++paramindex, util.dateStringToSqlDate(util.getDateString()));
            pst.setString(++paramindex, name);
            pst.setString(++paramindex, address);
            pst.setString(++paramindex, address);
            pst.setInt(++paramindex, countryid);
            //pst.setInt(++paramindex, 13);
            pst.setInt(++paramindex, this.getSubTypeId("FI"));
            pst.setString(++paramindex, department);
            pst.setString(++paramindex, institution);
            int upd_count = pst.executeUpdate();
            if(upd_count == 1){
                ResultSet rs = pst.getGeneratedKeys();
                rs.first();
                int subscriberId = rs.getInt(1);

                this.conn.setAutoCommit(false);

                int subscriptionID = this.insertSubscription(subscriberId, 0);
                //paramindex = 0;
                //PreparedStatement pst_sub = conn.prepareStatement(insert_subscription_sql, Statement.RETURN_GENERATED_KEYS);
                //pst_sub.setInt(++paramindex, subscriberId);
                //pst_sub.setInt(++paramindex, 0);
                //pst_sub.setBoolean(++paramindex, true);

                //upd_count = pst_sub.executeUpdate();
                if(subscriptionID > 0){
                    //ResultSet rs1 = pst_sub.getGeneratedKeys();
                    //rs1.first();

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
