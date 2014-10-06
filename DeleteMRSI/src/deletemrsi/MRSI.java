/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package deletemrsi;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Logger;

/**
 *
 * @author Shailendra
 */
public class MRSI {

    Connection conn = null;
    static final Logger logger = Logger.getLogger(MRSI.class.getName());

    public MRSI() throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.jdbc.Driver");
        // setup the connection with the DB.
        conn = DriverManager.getConnection("jdbc:mysql://localhost/evitaran?" + "user=evitaran&password=evitaran");
    }

    public void deActivateSubscription(int[] subscriberIDs) throws SQLException {

        String sql_get_sub_id = "select id from subscriber where subscriberNumber=?";
        String sql_deactivate_subn = "select id from subscription where subscriberID=?";
        String sql_update_subn_details = "update subscriptiondetails set active=False where subscriptionID=?";
        PreparedStatement pst = conn.prepareStatement(sql_get_sub_id);
        PreparedStatement pst2 = conn.prepareStatement(sql_deactivate_subn);
        PreparedStatement pst3 = conn.prepareStatement(sql_update_subn_details);
        for (int i : subscriberIDs) {
            logger.info("Getting subscription for subscriber: ".concat(String.valueOf(i)));
            pst.setString(1, String.valueOf(i));
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.first()) {
                    int sub_id = rs.getInt(1);
                    pst2.setInt(1, sub_id);
                    ResultSet rs2 = pst2.executeQuery();
                    if (rs2.first()) {
                        int subn_id = rs2.getInt(1);
                        pst3.setInt(1, subn_id);
                        pst3.addBatch();
                    }
                    //logger.info("Subscriptions deactivated for subscriber: ".concat(String.valueOf(rc)));
                }
            }
        }
        pst3.executeBatch();

    }

}
