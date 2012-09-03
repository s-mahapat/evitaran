/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package JDSMigration;

import com.mysql.jdbc.Statement;
import java.io.*;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Calendar;
import java.util.HashMap;
import jxl.read.biff.BiffException;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import sun.reflect.generics.reflectiveObjects.NotImplementedException;

/**
 *
 * @author Shailendra Mahapatra
 */
public class MigrationBase implements IMigrate {

    private FileReader fr = null;
    private BufferedReader br = null;
    private FileInputStream fis = null;
    public String dataFolder = "data";
    public Database db = null;
    public Connection conn = null;
    private static final Logger logger = Logger.getLogger(MigrationBase.class);
    public HashMap<String, String> stateMap = new HashMap<>();
    public HashMap<String, String> cityMap = new HashMap<>();
    public HashMap<String, String> countryMap = new HashMap<>();
    public String sql_city = "select id from cities where city = ?";
    public String sql_distrcit = "select id from districts where district = ?";
    public String sql_state = "select id from states where state = ?";
    public String sql_country = "select id from countries where country = ?";
    public String dataFile = null;
    private ExcelReader excelReader = null;
    public static final int COMMIT_SIZE = 1000;
    private PreparedStatement pst_pgid;
//--------------------------------------------------------------------------------------------
    //Select Statement for Inward Id
    public String sql_select_inward = "Select id from inward where inwardNumber = ?";
//--------------------------------------------------------------------------------------------
    //Select Statement for Subscriber Id
    public String sql_select_subscriber = "Select id from subscriber where subscriberNumber = ?";
//--------------------------------------------------------------------------------------------
    //Select Statement for Journal Group
    public String sql_select_journalGrp = "Select id from journal_groups where journalGroupName = ?";
//--------------------------------------------------------------------------------------------
    //Insert Statement for Subscription
    public String sql_insert_subscription = "insert into subscription(subscriberID,inwardID,legacy,legacy_amount,subscriptiondate,legacy_balance)"
            + "values(?,?,?,?,?,?)";
    public String sql_insert_subscription_free_subs = "insert into subscription(subscriberID,inwardID,legacy) values(?,?,?)";
//--------------------------------------------------------------------------------------------
    //Insert Statement for Subscription Details
    public String sql_insert_subscriptiondetails = "insert into subscriptiondetails(subscriptionID, "
            + "journalGroupID, copies, startYear, startMonth, endYear, endMonth, journalPriceGroupID)values(?,?,?,?,?,?,?,?)";
//--------------------------------------------------------------------------------------------
    public String sql_insert_subscriber = "insert IGNORE into subscriber(subtype, subscriberNumber"
            + ",subscriberName, department"
            + ",institution, shippingAddress, invoiceAddress"
            + ",city, state, pincode, country, deactive, email)values"
            + "((select id from subscriber_type where subtypecode = ?),?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    public String sql_getLastSubscriberId = "SELECT id from subscriber order by id desc LIMIT 1";
//--------------------------------------------------------------------------------------------
    private PreparedStatement pst_insert_subscription = null;
    private PreparedStatement pst_insert_subscription_dtls = null;

    public MigrationBase() throws SQLException {

        try {
            PropertyConfigurator.configure("log4j.properties");
            this.db = new Database();
            this.conn = this.db.getConnection();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        stateMap.put("T.N.", "Tamil Nadu");
        stateMap.put("T.N", "Tamil Nadu");
        stateMap.put("A.P.", "Andhra Pradesh");
        stateMap.put("M.S.", "Maharashtra");
        stateMap.put("U.P.", "Uttar Pradesh");
        stateMap.put("M.P.", "Madhya Pradesh");
        stateMap.put("H.P.", "Himachal Pradesh");
        stateMap.put("W.B.", "West Bengal");
        stateMap.put("Orissa", "Odisha");
        stateMap.put("J&K", "Jammu & Kashmir");
        stateMap.put("A&N Islands", "Andaman & Nicobar");


        String sql = "select id from subscription_rates t1 "
                + "where journalGroupID=? and t1.subtypeid=? "
                + "and year=? and period=?";
        pst_pgid = this.conn.prepareStatement(sql);

        //Added for fellows data migration
        cityMap.put("Bangalore", "Bengaluru");
        cityMap.put("Dehra Dun", "Dehradun");
        cityMap.put("Baroda", "Vadodara");
        cityMap.put("Krishangarh", "Kishangarh");
        cityMap.put("Calicut", "Kozhikode (Calicut)");
        cityMap.put("Pudicherry", "Puducherry");
        cityMap.put("Bangalore ", "Bengaluru");
        cityMap.put("Karaikudi ", "Karaikkudi");
        cityMap.put("Bangalroe ", "Bengaluru");
        cityMap.put("Vellroe ", "Vellore");
        cityMap.put("Thirvananthapuram ", "Thiruvananthapuram");
        cityMap.put("Pondicherry", "Puducherry");
        cityMap.put("Dehra Dun ", "Dehradun");
        cityMap.put("Baroda ", "Vadodara");
        cityMap.put("Pondicherry ", "Puducherry");
        cityMap.put("Pudicherry ", "Puducherry");
        cityMap.put("Calicut ", "Kozhikode (Calicut)");
        cityMap.put("Trivandrum ", "Thiruvananthapuram");
        cityMap.put("Ahmedabad ,", "Ahmedabad");
        cityMap.put("Bengalooru ", "Bengaluru");
        cityMap.put("Palkkad ", "Palakkad");
        cityMap.put("Kolkdata ", "Kolkata");
        cityMap.put("Pune - ", "Pune");
        cityMap.put("Goa ", "Goa");

        stateMap.put("Delhi", "New Delhi");
        stateMap.put("UP", "Uttar Pradesh");
        stateMap.put("Kashmir", "Jammu & Kashmir");
        stateMap.put("Karnatakia", "Karnataka");
        stateMap.put("Karnatka", "Karnataka");
        stateMap.put("Panjab", "Punjab");
        stateMap.put("Puducherry", "Pondicherry");
        stateMap.put("Karnataaka", "Karnataka");
        stateMap.put("Karnataka ************************", "Karnataka");
        stateMap.put("Gujrat", "Gujarat");

        countryMap.put("U.S.A", "USA");
        countryMap.put("U.S.A.", "USA");
        countryMap.put("U.K.", "UK");
        countryMap.put("The Netherlands", "Netherlands");
        countryMap.put("Czechoslovakia", "Czech Republic");
        countryMap.put("Yugoslavia", "Macedonia");
        countryMap.put("Nepal*****************************", "Nepal");
        countryMap.put("Belgique", "Belgium");
        countryMap.put("THE NETHERLANDS", "Netherlands");
        countryMap.put("REPUBLIC OF MOLDAVA", "Moldava");
        countryMap.put("US", "USA");
        countryMap.put("S. Afarica", "USA");
        countryMap.put("Frnace", "France");

        pst_insert_subscription = this.conn.prepareStatement(sql_insert_subscription, Statement.RETURN_GENERATED_KEYS);
        pst_insert_subscription_dtls = this.conn.prepareStatement(sql_insert_subscriptiondetails);



    }

    @Override
    public void Migrate() throws Exception {
        throw new NotImplementedException();
    }

    public void openFile(String fileName) throws java.io.FileNotFoundException {

        this.fr = new FileReader(fileName);
        this.br = new BufferedReader(this.fr);

    }

    public void openExcel(String fileName) throws java.io.FileNotFoundException, IOException, BiffException {
        excelReader = new ExcelReader(fileName, 0);
    }

    public String[] getNextRow() throws IOException, EOFException, BiffException {
        return (this.excelReader.getNextRow());
    }

    public String getNextLine() throws java.io.IOException {

        String line = null;
        if (this.br.ready()) {

            line = this.br.readLine();
            if (line == null) {
                this.br.close();
            }

        } else {
            line = null;
        }

        return line;
    }

    public void CloseFile() throws java.io.IOException {
        this.br.close();
        this.fr.close();
    }

    public int getCityID(String cityName) throws SQLException {

        PreparedStatement pst = this.conn.prepareStatement(sql_city);
        pst.setString(1, cityName);
        ResultSet rs = db.executeQueryPreparedStatement(pst);
        if (rs.isBeforeFirst()) {
            rs.first();
            return rs.getInt(1);
        } else {
            return 0;
        }


    }

    public int getCountryID(String countryName) throws SQLException {
        if (this.countryMap.containsKey(countryName)) {
            countryName = this.countryMap.get(countryName);
        }
        PreparedStatement pst = this.conn.prepareStatement(sql_country);
        pst.setString(1, countryName);
        ResultSet rs = db.executeQueryPreparedStatement(pst);
        if (rs.isBeforeFirst()) {
            rs.first();
            return rs.getInt(1);
        } else {
            return 0;
        }


    }

    public int getStateID(String stateName) throws SQLException {

        if (this.stateMap.containsKey(stateName)) {
            stateName = this.stateMap.get(stateName);
        }
        PreparedStatement pst = this.conn.prepareStatement(sql_state);
        pst.setString(1, stateName);
        ResultSet rs = db.executeQueryPreparedStatement(pst);
        if (rs.isBeforeFirst()) {
            rs.first();
            return rs.getInt(1);
        } else {
            return 0;
        }


    }

    public int getLastSubscriberId() throws SQLException {

        PreparedStatement pst = this.conn.prepareStatement(sql_getLastSubscriberId);
        ResultSet rs = db.executeQueryPreparedStatement(pst);
        if (rs.isBeforeFirst()) {
            rs.first();
            return rs.getInt(1);
        } else {
            return 0;
        }
    }

    public void truncateTable(String table) throws SQLException {

        String sql = "delete from " + table;
        this.db.executeUpdate(sql);
    }

    public int getAgentID(String agentName) throws SQLException {
        String sql = "select id from agents where agentName=? LIMIT 1";
        int agentID;
        try {
            PreparedStatement pst = this.conn.prepareStatement(sql);
            pst.setString(1, agentName);
            ResultSet rs = pst.executeQuery();
            rs.first();
            agentID = rs.getInt(1);
        } catch (SQLException e) {
            agentID = 0;
        }

        return agentID;

    }

    public int getSubscriberID(int subscriberNumber) {
        int subID;
        String sql = "select id from subscriber where subscribernumber=?";

        try {
            PreparedStatement pst = this.conn.prepareStatement(sql);
            pst.setInt(1, subscriberNumber);
            ResultSet rs = pst.executeQuery();
            rs.first();
            subID = rs.getInt(1);
        } catch (SQLException e) {
            logger.fatal("Invalid subscriber id: " + subscriberNumber);
            subID = 0;
        }
        return subID;

    }

    public int getSubscriberTyeID(int subscriberID) {
        int subtypeID;
        String sql = "select subtype from subscriber where id=?";

        try {
            PreparedStatement pst = this.conn.prepareStatement(sql);
            pst.setInt(1, subscriberID);
            ResultSet rs = pst.executeQuery();
            rs.first();
            subtypeID = rs.getInt(1);
        } catch (SQLException e) {
            subtypeID = 0;
        }
        return subtypeID;

    }

    public int getJournalPriceGroupID(int journalGrpID, int subtypeID, int startYear, int endYear) throws SQLException {
        int priceGroupID;
        int period = endYear - startYear + 1;
        pst_pgid.setInt(1, journalGrpID);
        pst_pgid.setInt(2, subtypeID);
        pst_pgid.setInt(3, startYear);
        pst_pgid.setInt(4, period);
        try {
            ResultSet rs = pst_pgid.executeQuery();
            rs.first();
            priceGroupID = rs.getInt(1);
        } catch (SQLException e) {
            priceGroupID = 0;
        }
        return priceGroupID;

    }

    public int getPinCode(String _pinAsText) {
        int pincode = 0;
        if (_pinAsText.length() == 6) {
            try {
                pincode = Integer.parseInt(_pinAsText);
            } catch (NumberFormatException e) {
                logger.fatal("Invalid pincode: " + _pinAsText);
                pincode = 0;
            }
        }else{
            logger.fatal("Invalid pincode: " + _pinAsText);
        }
        return pincode;
    }

    public String getNextSubscriberNumber() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException {

        String nextSubscriber;
        // Identify the subscriber type i.e.Free or Paid
        String subtype = "S";
        //get the last subscriber number from subscriber table
        String lastSubscriberSql = "SELECT subscriberNumber FROM subscriber where YEAR(subscriberCreationDate)=YEAR(CURDATE()) ORDER BY id DESC LIMIT 1";
        ResultSet rs = db.executeQuery(lastSubscriberSql);
        //java.sql.ResultSetMetaData metaData = rs.getMetaData();
        Calendar calendar = Calendar.getInstance();
        String lastSubscriber;

        //if true there exists a previous subscriber for the year, so just increment the subscriber number.
        if (rs.first()) {

            lastSubscriber = rs.getString(1);

            // get the last subscriber number after the split
            int subscriber = Integer.parseInt(lastSubscriber.substring(6));
            //increment
            ++subscriber;
            //apend the year, month character and new subscriber number.
            nextSubscriber = lastSubscriber.substring(0, 2) + getMonthToCharacterMap(calendar.get(Calendar.MONTH)) + "-" + subtype + "-" + String.format("%05d", subscriber);
        } else {
            // there is no previous record for the year, so start the numbering afresh
            String year = String.valueOf(calendar.get(Calendar.YEAR)).substring(2);
            nextSubscriber = year + getMonthToCharacterMap(calendar.get(Calendar.MONTH)) + "-" + subtype + "-" + String.format("%05d", 1);
        }
        return nextSubscriber;
    }

    public String getMonthToCharacterMap(int _month) {
        char[] alphabet = "abcdefghijkl".toCharArray();
        // the calendar objects month starts from 0
        String monthChar = Character.toString(alphabet[_month]);
        return monthChar.toUpperCase();
    }

    public int getEndYear() {
        int endYear;
        String sql = "SELECT year FROM `year` ORDER BY yearId DESC LIMIT 1";

        try {
            PreparedStatement pst = this.conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            rs.first();
            endYear = rs.getInt(1);
        } catch (SQLException e) {
            endYear = 0;
        }
        return endYear;

    }

    public int insertSubscription(int subscriberId, int inwardId, float amount, Date subdate, float corr_balance) throws SQLException {
        int paramIndex = 0;
        pst_insert_subscription.setInt(++paramIndex, subscriberId);
        pst_insert_subscription.setInt(++paramIndex, inwardId);
        //pst_insert_subscription.setString(++paramIndex, remarks);
        pst_insert_subscription.setBoolean(++paramIndex, true);
        pst_insert_subscription.setFloat(++paramIndex, amount);
        pst_insert_subscription.setDate(++paramIndex, subdate);
        pst_insert_subscription.setFloat(++paramIndex, corr_balance);

        //Inserting the record in Subscription Table
        int ret = this.db.executeUpdatePreparedStatement(pst_insert_subscription);
        if (ret == 1) {
            //Getting back the subsciption Id
            ResultSet rs_sub = pst_insert_subscription.getGeneratedKeys();
            rs_sub.first();
            return rs_sub.getInt(1);  //return subscription id
        } else {
            throw (new SQLException("Failed to add subscription"));
        }


    }

    public boolean insertSubscriptionDetails(int subscriptionID, int jrnlGrpId, int noCopies,
            int startYr, int startMonth, int endYr, int endMonth, int priceGroupID) throws SQLException {
        int paramIndex = 0;
        pst_insert_subscription_dtls = this.conn.prepareStatement(sql_insert_subscriptiondetails);
        pst_insert_subscription_dtls.setInt(++paramIndex, subscriptionID);
        pst_insert_subscription_dtls.setInt(++paramIndex, jrnlGrpId);
        pst_insert_subscription_dtls.setInt(++paramIndex, noCopies);
        pst_insert_subscription_dtls.setInt(++paramIndex, startYr);
        pst_insert_subscription_dtls.setInt(++paramIndex, startMonth);
        pst_insert_subscription_dtls.setInt(++paramIndex, endYr);
        pst_insert_subscription_dtls.setInt(++paramIndex, endMonth);
        pst_insert_subscription_dtls.setInt(++paramIndex, priceGroupID);

        //Inserting the record in Subscription Table
        int retUpdStatus = this.db.executeUpdatePreparedStatement(pst_insert_subscription_dtls);

        //Logging the inserting row
        if (retUpdStatus == 1) {
            return true;
        }
        throw (new SQLException("Failed to add subscription details"));
    }

    public void executeMasterDataScripts() throws IOException, SQLException {
        String files[] = new String[11];
        files[0] = "data" + "\\masterdata\\1.journals.sql";
        files[1] = "data" + "\\masterdata\\2.journal_groups.sql";
        files[2] = "data" + "\\masterdata\\3.journal_group_contents.sql";
        files[3] = "data" + "\\masterdata\\4.subscriber_types.sql";
        files[4] = "data" + "\\masterdata\\5.subscription_rates.sql";
        files[5] = "data" + "\\masterdata\\6.cities.sql";
        files[6] = "data" + "\\masterdata\\7.countries.sql";
        files[7] = "data" + "\\masterdata\\8.states.sql";
        files[8] = "data" + "\\masterdata\\9.year.sql";
        files[9] = "data" + "\\masterdata\\10.districts.sql";
        files[10] = "data" + "\\masterdata\\truncate_transaction_data.sql";

        for (int j = 0; j < files.length; j++) {
            String s;
            StringBuilder sb = new StringBuilder();

            FileReader _fr = new FileReader(new File(files[j].toString()));
            BufferedReader _br = new BufferedReader(_fr);

            while ((s = _br.readLine()) != null) {
                sb.append(s);
            }
            _br.close();

            // here is our splitter ! We use ";" as a delimiter for each request
            // then we are sure to have well formed statements
            String[] inst = sb.toString().split(";");

            for (int i = 0; i < inst.length; i++) {
                // we ensure that there is no spaces before or after the request string
                // in order to not execute empty statements
                if (!inst[i].trim().equals("")) {
                    this.db.executeUpdate(inst[i]);
                    //System.out.println(">>"+inst[i]);
                }
            }
        }
    }
}
