/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package JDSMigration;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.ListIterator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import jxl.read.biff.BiffException;
import org.apache.log4j.Logger;

/**
 *
 * @author Shailendra Mahapatra
 */
public class Temp extends MigrationBase {

    private int COMMIT_BATCH_SIZE = 1000;
    private static final Logger logger = Logger.getLogger(Temp.class.getName());
    int totalRows = 0;
    int insertedRows = 0;
    int duplicateRows = 0;
    private String sql_insert = "insert IGNORE into subscriber(subtype, subscriberNumber"
            + ",subscriberName, department"
            + ",institution, shippingAddress, invoiceAddress"
            + ",city, state, pincode, country, deactive, email, phone, fax)values"
            + "((select id from subscriber_type where subtypecode = ?),?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    PreparedStatement pst_insert = null;
    HashMap<String, String> agentSubscriberMap;

    public Temp(HashMap<String, String> _agentSubscriberMap) throws SQLException {
        super(); // call the base class constructor
        this.dataFile = this.dataFolder + "\\temp.xls";
        //this.dataFile = this.dataFolder + "\\subscriber\\indtemp.txt";
        this.conn = this.db.getConnection();
        conn.setAutoCommit(false);
        agentSubscriberMap = _agentSubscriberMap;

    }

    @Override
    public void Migrate() throws FileNotFoundException, IOException, ParseException, SQLException, BiffException {

        this.openExcel(dataFile);
        String _line = null;
        int lineNum = 0;
        int excelRow = 0;
        int recordCounter = 0;
        List DuplicateList = new ArrayList();

        String[] datacolumns;
        pst_insert = this.conn.prepareStatement(sql_insert);

        //conn.setAutoCommit(false);

        // truncate the old data
        //this.truncateTable("Subscriber");

        while (true) {
            datacolumns = this.getNextRow();
            lineNum++;
            excelRow = lineNum + 1;
            if (datacolumns == null) {
                break;
            }

            String subscriberNumber = datacolumns[2];
            String subscriberName = datacolumns[7].trim();
            if (subscriberName == null || subscriberName.length() == 0) {
                // if there is no subscriber name we skip the record
                logger.error("No subscriber name for subscriber:" + subscriberNumber + " at row no: " + excelRow);
                subscriberIDsWithoutNames.put(subscriberNumber, null);
                continue;
            }

            /*for (int i = 0; i < numOfCols; i++) {
             columns[i] = "";
             datacolumns[i] = "";
             }*/
            totalRows++;
            //columns = _line.split(Pattern.quote("\t"));
            //System.arraycopy(columns, 0, datacolumns, 0, columns.length);

            String agentCode = datacolumns[0];
            String subscribercode = datacolumns[1];

            String remarksAgent = datacolumns[3];

            String department = datacolumns[8];
            String institute = datacolumns[9];
            String address = datacolumns[10];
            String temp_invoice_address = address;
            String invoiceaddress = "";
            String cityAndPin = datacolumns[11];
            String country = datacolumns[13];
            String email = datacolumns[55];
            String phone = datacolumns[56];
            String agent = datacolumns[46];
            String state = "";
            if (email.isEmpty()) {
                String temp = datacolumns[3];
                email = temp.replaceAll("Another Email: ", "");
            }
            if (!validateEmail(email)) {
                email = "";
                logger.warn("Found email ID " + email + " that is not valid for subscriber name: " + subscriberName);
            }

            //skip foreign suscribers
            /*if(subscribercode.equalsIgnoreCase("FP") || subscribercode.equalsIgnoreCase("FI")){
             logger.debug("Skipping foreign subscriber:" + subscriberNumber);
             continue;
             }*/

            if (subscribercode.equalsIgnoreCase("1P")
                    || subscribercode.equalsIgnoreCase("P")
                    || subscribercode.equalsIgnoreCase("I")) {
                subscribercode = "IP";
            }


            if (subscriberNumber.isEmpty() || Integer.parseInt(subscriberNumber) == 0) {
                logger.fatal("No Subscriber Number found for:" + subscriberName + " at line number:" + lineNum);
                continue;
            }

            int pin;
            pin = this.getPinCode(datacolumns[14].replaceAll(" ", ""));
            String remarks = "";//datacolumns[10];
            String city = "";
            String pin2 = "";

            //country field has ****, remove them
            country = country.replaceAll("\\*", "");

            //subscriberName,department, institution and address have "" quotes, remove them
            subscriberName = subscriberName.replaceAll("\"", "");
            department = department.replaceAll("\"", "");
            institute = institute.replaceAll("\"", "");
            address = address.replaceAll("\"", "");
            //address2 = address2.replaceAll("\"", "");

            int countryID = 0, stateID = 0, cityID = 0;
            //remove the spaces from city and then separate the pincode from the city
            Pattern p = Pattern.compile("^(.*?)\\s+(\\d+\\s+\\d+)$");
            Matcher m = p.matcher(cityAndPin);
            if (m.find()) {
                city = m.group(1);
                pin2 = m.group(2);
                // remove spaces between the pin code e.g. 123 456
                //pin = Integer.parseInt(m.group(2).replaceAll(" ", ""));
            }

            logger.debug("Inserting subscriber: " + subscriberNumber);

            // At times the city name in JDS db and city name mentioned may in the xls may not match due to say spelling mistake.
            // Try to correct that before checking if the city exist in the JDS db.
            if (this.cityMap.containsKey(city)) {
                city = this.cityMap.get(city);
            }
            // get the city id
            cityID = this.getCityID(city);
            if (cityID == 0) {
                // if this is not a city, check if this is a state
                //String state = city;
                //if (this.stateMap.containsKey(state)) {
                //state = this.stateMap.get(state);
                //}
                //stateID = this.getStateID(state);
                //if(stateID == 0) {
                logger.warn("Found city/state " + city + " which does not have a entry in the database");
                address = (cityID == 0) ? address : address + "\n" + city;
                //}

            } else {
                logger.debug("city " + city + " has the id : " + cityID);
            }

            // get the country id, check the state hash map first, there are many cases where the state is mentioned in the country field
            if (this.countryMap.containsKey(country)) {
                country = this.countryMap.get(country);
            }
            countryID = this.getCountryID(country);
            // If country is not found, check if this is a state
            if (countryID == 0) {
                state = country;
                if (this.stateMap.containsKey(state)) {
                    state = this.stateMap.get(state);
                }
                stateID = this.getStateID(state);
                // If state is also not found means we either have a country or a state which is not present in the db
                if (stateID == 0) {
                    logger.warn("Found state/country " + country + " which does not have a entry in the database");
                    address = (stateID > 0) ? address : address + "\n" + country;
                } // If we found a valid state, means the country is India.
                else {
                    country = "India";
                    countryID = this.getCountryID(country);
                }
            }

            if (countryID == 0
                    && (subscribercode.equalsIgnoreCase("IP")
                    || subscribercode.equalsIgnoreCase("II")
                    || subscribercode.equalsIgnoreCase("IC"))) {
                countryID = this.getIndiaID();
            }

            // By default the pin is extracted from the pin column,
            // but in some cases the pin code is present in the citypin column
            // If the pin column is empty, then check if the cityPin column has the pin code
            if (pin == 0) {
                pin = this.getPinCode(pin2);
                if (pin == 0) {
                    logger.warn("Found pin to be 0 for subscriber number " + subscriberNumber);
                } else {
                    logger.debug("pin Code is : " + pin);
                }
            }

            int agentId = 0;
            if (subscriberName.startsWith("(") || subscriberName.startsWith("[Ref")
                    || subscriberName.startsWith("(Ref") || subscriberName.startsWith("(REF")) {
                if (!department.equals("") || department != null) {
                    agentId = getAgentID(department, address, cityID, stateID, pin, countryID);
                }
            } else if (!remarksAgent.isEmpty()
                    && (remarksAgent.toUpperCase().indexOf("KUMARI") > -1
                    || remarksAgent.toUpperCase().indexOf("MEERA TRUST") > -1
                    || remarksAgent.toUpperCase().indexOf("KALM") > -1)) {
                agentId = this.getAgentID("Kumari Ali Mera Trust", "", 0, 0, 0, 0);

            } else if (!agent.isEmpty()
                    && agent.toUpperCase().indexOf("KLAM") > -1) {
                agentId = this.getAgentID("Kumari Ali Mera Trust", "", 0, 0, 0, 0);
            } else if (!agent.isEmpty()) {
                agentId = this.getAgentID(agent, "", 0, 0, 0, 0);
            }

            if (agentId != 0) {
                agentSubscriberMap.put(subscriberNumber, Integer.toString(agentId));
                logger.debug(subscriberNumber + "->" + Integer.toString(agentId));
            }
            if(department.length() > 0){
                invoiceaddress = invoiceaddress.length() > 0 ? (invoiceaddress + "\n" + department) : department;
                //invoiceaddress += "\n" + department;
            }
            if(institute.length() > 0){
                invoiceaddress = invoiceaddress.length() > 0 ? (invoiceaddress + "\n" + institute) : institute;
                //invoiceaddress += "\n" + institute;
            }
            if(temp_invoice_address.length() > 0){
                invoiceaddress = invoiceaddress.length() > 0 ? (invoiceaddress + "\n" + temp_invoice_address) : temp_invoice_address;
                //invoiceaddress += "\n" + temp_invoice_address;
            }
            if(city.length() > 0){
                invoiceaddress = invoiceaddress.length() > 0 ? (invoiceaddress + "\n" + city) : city;
                //invoiceaddress += "\n" + city;
            }

            if(state.length() > 0){
                invoiceaddress = invoiceaddress.length() > 0 ? (invoiceaddress + "\n" + state) : state;
            }

            if(pin > 0){
                invoiceaddress = invoiceaddress.length() > 0 ? (invoiceaddress + "\n" + String.valueOf(pin)) : String.valueOf(pin);
                //invoiceaddress += "\n" + String.valueOf(pin);
            }
            int paramIndex = 0;
            pst_insert.setString(++paramIndex, subscribercode);
            pst_insert.setString(++paramIndex, subscriberNumber);
            //pst_insert.setDate(++paramIndex, util.dateStringToSqlDate("00/00/0000", "dd/MM/yyyy"));
            pst_insert.setString(++paramIndex, subscriberName);
            pst_insert.setString(++paramIndex, department);
            pst_insert.setString(++paramIndex, institute);
            pst_insert.setString(++paramIndex, address);
            pst_insert.setString(++paramIndex, invoiceaddress);
            pst_insert.setInt(++paramIndex, cityID);
            pst_insert.setInt(++paramIndex, stateID);
            pst_insert.setInt(++paramIndex, pin);
            pst_insert.setInt(++paramIndex, countryID);
            //pst_insert.setInt(++paramIndex, 0);
            pst_insert.setInt(++paramIndex, 0);
            pst_insert.setString(++paramIndex, email);
            pst_insert.setString(++paramIndex, phone);
            pst_insert.setString(++paramIndex, null); // for fax
            //pst_insert.addBatch();
            recordCounter++;

            int ret = pst_insert.executeUpdate();
            if (ret == 0) {
                logger.fatal("Skipping Duplicate Subscriber : " + subscriberNumber + " Name: " + subscriberName);
                DuplicateList.add(subscriberNumber);
                duplicateRows++;
            } else {
                insertedRows++;
            }



            if (recordCounter == COMMIT_BATCH_SIZE) {
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
        while (li.hasNext()) {
            logger.error("Subscriber id Skipped(duplicate rows): " + li.next());
        }
    }
}
