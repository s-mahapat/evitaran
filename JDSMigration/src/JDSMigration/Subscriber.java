/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package JDSMigration;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.ListIterator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.apache.log4j.Logger;

/**
 *
 * @author Shailendra Mahapatra
 */
public class Subscriber extends MigrationBase {

    private String dataFile = null;
    private int COMMIT_BATCH_SIZE = 1000;
    private static final Logger logger = Logger.getLogger(Subscriber.class.getName());
    int totalRows = 0;
    int insertedRows = 0;
    int duplicateRows = 0;
    Connection conn = null;

    PreparedStatement pst_insert = null;

    public Subscriber() throws SQLException{
        //super(); // call the base class constructor
        //this.dataFile = this.dataFolder + "\\subscriber\\temp.txt";
        this.dataFile = this.dataFolder + "\\subscriber\\indtemp.txt";
        this.conn = this.db.getConnection();
        conn.setAutoCommit(false);

    }

    @Override
    public void Migrate() throws FileNotFoundException, IOException, ParseException, SQLException {

        this.openFile(dataFile);
        String _line = null;
        int lineNum = 0;
        int numOfCols = 57;
        int recordCounter = 0;
        List DuplicateList = new ArrayList();

        String[] datacolumns = new String[numOfCols];
        pst_insert = this.conn.prepareStatement(sql_insert_subscriber);

        //conn.setAutoCommit(false);

        // truncate the old data
        //this.truncateTable("Subscriber");

        while (true) {
            _line = this.getNextLine();
            lineNum++;
            if(lineNum == 1){
                continue;
            }
            String[] columns = new String[numOfCols];
            if (_line == null) {
                break;
            }
            for (int i = 0; i < numOfCols; i++) {
                columns[i] = "";
                datacolumns[i] = "";
            }
            totalRows++;
            columns = _line.split(Pattern.quote("\t"));
            System.arraycopy(columns, 0, datacolumns, 0, columns.length);

            String agentCode = datacolumns[0];
            String subscribercode = datacolumns[1];
            String subscriberNumber = datacolumns[2];
            String subscriberName = datacolumns[7];
            String department = datacolumns[8];
            String institute = datacolumns[9];
            String address = datacolumns[10];
            //String address2 = datacolumns[6];
            String cityAndPin = datacolumns[11];
            String country = datacolumns[13];
            String email = datacolumns[55];
            if(!validateEmail(email)){
                email = "";
                logger.warn("Found email ID " + email +" that is not valid for subscriber name: " + subscriberName);
            }

            //skip foreign suscribers
            if(subscribercode.equalsIgnoreCase("FP") || subscribercode.equalsIgnoreCase("FI")){
                logger.error("Skipping foreign subscriber:" + subscriberNumber);
                continue;
            }

            if(subscriberNumber.isEmpty() || Integer.parseInt(subscriberNumber) == 0){
                logger.error("No Subscriber Number found for:" + subscriberName + " at line number:" + lineNum);
                continue;
            }

            int pin = 0;
            try{
                pin = Integer.parseInt(datacolumns[14].replaceAll(" ", ""));
            }catch(NumberFormatException e){
                logger.debug("Exception: " + e.getMessage() + " for pincode " + datacolumns[14]);
                pin = 0;
            }
            String remarks = "";//datacolumns[10];
            String city = "";

            //country field has ****, remove them
            country = country.replaceAll("\\*", "");

            //subscriberName,department, institution and address have "" quotes, remove them
            subscriberName = subscriberName.replaceAll("\"", "");
            department = department.replaceAll("\"", "");
            institute = institute.replaceAll("\"", "");
            address = address.replaceAll("\"", "");
            //address2 = address2.replaceAll("\"", "");

            //remove the spaces from city and then separate the pincode from the city
            Pattern p = Pattern.compile("^(.*?)\\s+(\\d+\\s+\\d+)$");
            Matcher m = p.matcher(cityAndPin);
            if (m.find()) {
                city = m.group(1);
                // remove spaces between the pin code e.g. 123 456
                //pin = Integer.parseInt(m.group(2).replaceAll(" ", ""));
            }

            logger.debug("Inserting subscriber: " + subscriberNumber);

            // get the city id
            int cityID = this.getCityID(city);
            logger.debug("city " + city + " has the id : " + cityID);
            address = (cityID == 0) ? address : address + "\n" + city;

            // get the country id, check the hash map first
            if (this.stateMap.containsKey(country)) {
                country = this.stateMap.get(country);
            }
            int countryID = this.getCountryID(country);
            int stateID = 0;
            if (countryID == 0) {
                stateID = this.getStateID(country);
                logger.debug("State " + country + " has the id : " + stateID);
                address = (stateID > 0) ? address : address + "\n" + country;
            }

            logger.debug("pin Code is : " + pin);

            int paramIndex = 0;
            pst_insert.setString(++paramIndex, subscribercode);
            pst_insert.setString(++paramIndex, subscriberNumber);
            //pst_insert.setDate(++paramIndex, util.dateStringToSqlDate("00/00/0000", "dd/MM/yyyy"));
            pst_insert.setString(++paramIndex, subscriberName);
            pst_insert.setString(++paramIndex, department);
            pst_insert.setString(++paramIndex, institute);
            pst_insert.setString(++paramIndex, address);
            pst_insert.setString(++paramIndex, address);
            pst_insert.setInt(++paramIndex, cityID);
            pst_insert.setInt(++paramIndex, stateID);
            pst_insert.setInt(++paramIndex, pin);
            pst_insert.setInt(++paramIndex, countryID);
            //pst_insert.setInt(++paramIndex, 0);
            pst_insert.setInt(++paramIndex, 0);
            pst_insert.setString(++paramIndex, email);
            pst_insert.addBatch();
            recordCounter++;

            int ret = this.db.executeUpdatePreparedStatement(pst_insert);
            if (ret == 0) {
                logger.fatal("Skipping Duplicate Subscriber : " + subscriberNumber + " Name: " + subscriberName);
                DuplicateList.add(subscriberName);
                duplicateRows++;
            } else {
                insertedRows++;
            }

            if(recordCounter == COMMIT_BATCH_SIZE){
                logger.debug("commiting database after " + String.valueOf(insertedRows) + " rows");
                conn.commit();
                recordCounter = 0;
            }
        }
        conn.commit();
        logger.debug("Total Rows: " + totalRows);
        logger.debug("Rows Inserted: " + insertedRows);
        logger.debug("Duplicate Rows: " + duplicateRows);
        ListIterator li = DuplicateList.listIterator();
        while(li.hasNext()){
            logger.error("Subscriber id Skipped(duplicate rows): " + li.next());
        }
    }
}
