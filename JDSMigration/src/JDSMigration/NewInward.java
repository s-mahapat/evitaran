/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package JDSMigration;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import jxl.read.biff.BiffException;
import org.apache.log4j.Logger;

/**
 *
 * @author Shailendra Mahapatra
 */
public class NewInward extends MigrationBase {

    private static final Logger logger = Logger.getLogger(NewInward.class);

    public NewInward() throws SQLException {
        //super(); // call the base class constructor
        this.dataFile = this.dataFolder + "\\NEWINW.xls";
    }

    @Override
    public void Migrate() throws FileNotFoundException, IOException, ParseException, SQLException {

        this.conn.setAutoCommit(false);
        int totalRows = 0;
        int insertedRows = 0;
        int commitSize = 0;

        /*HashMap<String, String> cityMap = new HashMap<>();
         cityMap.put("Bang", "Bengaluru");
         cityMap.put("Banga", "Bengaluru");
         cityMap.put("Bagalpur", "Bhagalpur");
         cityMap.put("Trichy", "Tiruchirappalli");
         cityMap.put("Tircy", "Tiruchirappalli");
         cityMap.put("Tiruchirapalli", "Tiruchirappalli");
         cityMap.put("Nohali", "Mohali");
         cityMap.put("Hyd", "Hyderabad");
         cityMap.put("Trivandrum", "Thiruvananthapuram");
         cityMap.put("Cochin", "Kochi");
         cityMap.put("WB", "West Bengal");
         cityMap.put("Shimoa", "Shivamogga (Shimoga)");
         cityMap.put("Visak", "Visakhapatnam");
         cityMap.put("Orissa", "Odisha");
         cityMap.put("Nelore", "Nellore");
         cityMap.put("Yamunagar", "Yamunanagar");*/



        //int recordCount = 0;
        String pattern = "(\\d+.*\\d*)";

        Pattern r = Pattern.compile(pattern);
        //Format dtformat = new SimpleDateFormat("MM/dd/yyyy");
        //Connection conn = this.db.getConnection();
        //String sql_truncate = "truncate table inward";
        String sql = "select id from cities where city = ?";
        //String sql_distrcit = "select id from districts where district = ?";
        //String sql_state = "select id from states where state = ?";
        //String sql_country = "select id from countries where country = ?";
        String insert_sql = "insert into inward(inwardNumber,inward.from,country,state,district,city,email,inwardCreationDate,inwardPurpose,chqddNumber,paymentmode,currency,amount,remarks,completed, language) "
                + "values (?,?,?,(select id from states where state = ?),(select id from districts where district = ?),?,?,?,(select id from inward_purpose where purpose=?),?,?,(select id from currency where currency = ?),?,?,true, ?)";

        //db.executeUpdate(sql_truncate);
        PreparedStatement pst = conn.prepareStatement(sql);
        PreparedStatement pst_district = conn.prepareStatement(sql_distrcit);
        PreparedStatement pst_state = conn.prepareStatement(sql_state);
        PreparedStatement pst_country = conn.prepareStatement(sql_country);
        PreparedStatement pst_insert = conn.prepareStatement(insert_sql);


        this.openExcel(dataFile);
        //String _line = null;
        String[] columns;
        while (true) {

            try {
                columns = this.getNextRow();
                if (columns == null) {
                    break;
                }
                totalRows++;
                int cityId = 0;
                //int districtId = 0;
                int countryId = 0;
                int paramIndex = 0;
                boolean isCityFound = true;

                //String[] columns = _line.split(Pattern.quote("\t"));

                java.sql.Date inwardDate = util.dateStringToSqlDate(columns[1], "MM/dd/yyyy");


                String From = columns[2];
                String City = columns[3];
                String inwardPurpose = columns[4].toLowerCase();
                String Currency = "INR";
                String szchqddNumber = columns[5];
                String remarks = null;
                String language = columns[9];
                int langcode = 1;

                if (language.toUpperCase().contains("HINDI")) {
                    langcode = 2;
                }

                String inwardNumber = columns[11] + "-" + String.format("%05d", Integer.parseInt(columns[0]));
                
                // if the from field is null skip the record
                if (From == null || From.isEmpty()) {
                    logger.debug(inwardNumber + " :From field is empty, rownumber = " + totalRows);
                    //continue;
                }



                // replace all non word characters
                City = City.replaceAll("'", "");
                City = City.replaceAll("\"", "");
                City = City.replaceAll("\\W+\\d+$", "");

                From = From.replaceAll("\"", "");

                logger.debug("Migrating inward: " + inwardNumber);
                logger.debug("City name is " + City);

                if (cityMap.containsKey(City)) {

                    City = cityMap.get(City);
                    logger.debug("Found City name in Hash map: " + City);
                }


                pst_insert.setString(++paramIndex, inwardNumber);
                pst_insert.setString(++paramIndex, From);

                // search if the city is there in the db
                pst.setString(1, City);

                ResultSet rs = this.db.executeQueryPreparedStatement(pst);
                if (rs.isBeforeFirst()) {
                    while (rs.next()) {
                        cityId = rs.getInt(1);
                        logger.debug(City + " has the city id: " + rs.getInt(1));
                        pst_insert.setInt(++paramIndex, countryId);
                        pst_insert.setString(++paramIndex, null);
                        pst_insert.setString(++paramIndex, null);
                        pst_insert.setInt(++paramIndex, cityId);

                    }
                } else {
                    logger.debug(City + " is not in the city table..look up district");
                    pst_district.setString(1, City);
                    rs = this.db.executeQueryPreparedStatement(pst_district);
                    if (rs.isBeforeFirst()) {
                        // district found
                        while (rs.next()) {
                            logger.debug(City + " has the district id: " + rs.getInt(1));
                            pst_insert.setInt(++paramIndex, countryId);
                            pst_insert.setString(++paramIndex, null);
                            pst_insert.setString(++paramIndex, City);
                            pst_insert.setInt(++paramIndex, cityId);

                        }
                    } else {
                        // district also not found
                        logger.debug(City + " is not in the district table..look up state");
                        pst_state.setString(1, City);
                        rs = this.db.executeQueryPreparedStatement(pst_state);
                        if (rs.isBeforeFirst()) {
                            // state found
                            while (rs.next()) {
                                logger.debug(City + " has the state id: " + rs.getInt(1));
                                pst_insert.setInt(++paramIndex, countryId);
                                pst_insert.setString(++paramIndex, City);
                                pst_insert.setString(++paramIndex, null);
                                pst_insert.setInt(++paramIndex, cityId);

                            }
                        } else {
                            // state also not found
                            logger.debug(City + " is not in the state table..look up country");
                            pst_country.setString(1, City);
                            rs = this.db.executeQueryPreparedStatement(pst_country);
                            if (rs.isBeforeFirst()) {
                                // country found
                                while (rs.next()) {
                                    countryId = rs.getInt(1);
                                    logger.debug(City + " has the country id: " + countryId);
                                    pst_insert.setInt(++paramIndex, countryId);
                                    pst_insert.setString(++paramIndex, null);
                                    pst_insert.setString(++paramIndex, null);
                                    pst_insert.setInt(++paramIndex, cityId);

                                }

                            } else {
                                isCityFound = false;
                                remarks = remarks == null ? City : remarks + City;
                                pst_insert.setInt(++paramIndex, countryId);
                                pst_insert.setString(++paramIndex, null);
                                pst_insert.setString(++paramIndex, null);
                                pst_insert.setInt(++paramIndex, cityId);
                            }


                        }
                    }

                }
                pst_insert.setString(++paramIndex, columns[10]);
                pst_insert.setDate(++paramIndex, inwardDate);

                if (inwardPurpose == null) {
                    logger.error("No inward reason for: " + inwardNumber);
                    inwardPurpose = "Others";
                    //continue;
                }

                if (inwardPurpose.contains("subscription") || inwardPurpose.contains("sub")) {
                    inwardPurpose = "Renew Subscription";
                } else if (inwardPurpose.contains("advertisement")) {
                    inwardPurpose = "Advertisement";
                } else if (inwardPurpose.contains("invoice")) {
                    inwardPurpose = "Request For Invoice";
                } else if (inwardPurpose.contains("reprint")) {
                    inwardPurpose = "Reprint";
                } else if (inwardPurpose.contains("manuscript")) {
                    inwardPurpose = "Manuscript";
                } else if (inwardPurpose.contains("fellowship")) {
                    inwardPurpose = "New Subscription";
                } else {
                    if(!inwardPurpose.isEmpty()) {
                        remarks = (remarks == null) ? inwardPurpose : remarks + inwardPurpose;
                        logger.debug("Could not find inward reason " + inwardPurpose + " for inward " + inwardNumber + ". Added to remarks");
                    } else {
                        logger.error("Could not find inward reason " + inwardPurpose + " for inward " + inwardNumber);
                    }
                    //remarks = inwardPurpose;
                    
                    inwardPurpose = "Others";
                    //continue;
                }
                pst_insert.setString(++paramIndex, inwardPurpose);

                // chq dd number
                int chqddNumber = 0;
                int paymentmode = 0;
                if (szchqddNumber.matches("^\\d+")) {
                    chqddNumber = Integer.parseInt(columns[5]);
                    paymentmode = 1;
                }
                pst_insert.setInt(++paramIndex, chqddNumber);
                pst_insert.setInt(++paramIndex, paymentmode);

                if (columns[7].equals("$")) {
                    Currency = "USD";
                }
                pst_insert.setString(++paramIndex, Currency);
                float amount = 0;

                Matcher m = r.matcher(columns[8]);
                if (m.find()) {
                    amount = Float.parseFloat(columns[8]);
                } else {
                    amount = 0;
                }

                //float amount = (columns[8] != null || !columns[8].isEmpty()) ? Float.parseFloat(columns[8]) : 0;
                //float amount = Float.parseFloat(columns[8])  0.0;
                pst_insert.setFloat(++paramIndex, amount);

                // if the city is not found add it in the remarks, append to the existing remarks
                if (columns[9] != null && !columns[9].isEmpty()) {
                    remarks = (remarks == null) ? columns[9] : remarks + columns[9];
                    //remarks += columns[9];
                }

                pst_insert.setString(++paramIndex, remarks);
                pst_insert.setInt(++paramIndex, langcode);

                db.executeUpdatePreparedStatement(pst_insert);
                insertedRows++;
                commitSize++;
                if (commitSize == COMMIT_SIZE) {
                    this.conn.commit();
                    commitSize = 0;
                }
            } catch (IOException | BiffException | ParseException | NumberFormatException | SQLException e) {
                logger.error(e.getMessage());
            }

        } // end of while
        this.conn.commit();
        this.conn.setAutoCommit(true);
        logger.error("Total Records: " + (totalRows - 1));
        logger.error("Inserted Records: " + insertedRows);

    }   // migrate
} // class
