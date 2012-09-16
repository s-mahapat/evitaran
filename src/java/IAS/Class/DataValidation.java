/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DataValidation {

    private Connection conn = null;

    public DataValidation() throws SQLException {
        this.conn = Database.getConnection();
    }

    public boolean validateSubscriberNo(String subscriberNo) throws SQLException {
        PreparedStatement st = conn.prepareStatement(Queries.getQuery("validate_subscriberno"));
        st.setString(1, subscriberNo);
        ResultSet rs = st.executeQuery();
        boolean rsfirst = rs.first();
        rs.close();
        return rsfirst;
    }

    public boolean validateCity(String city) throws SQLException {
        PreparedStatement st = conn.prepareStatement(Queries.getQuery("validate_city"));
        st.setString(1, city);
        ResultSet rs = st.executeQuery();
        boolean rsfirst = rs.first();
        rs.close();
        return rsfirst;
    }

    public boolean validateDistrict(String district) throws SQLException {
        PreparedStatement st = conn.prepareStatement(Queries.getQuery("validate_district"));
        st.setString(1, district);
        ResultSet rs = st.executeQuery();
        boolean bfirst = rs.first();
        rs.close();
        return bfirst;
    }

    public boolean validateState(String state) throws SQLException {
        PreparedStatement st = conn.prepareStatement(Queries.getQuery("validate_state"));
        st.setString(1, state);
        ResultSet rs = st.executeQuery();
        rs.close();
        return rs.first();
    }

    public boolean validateCountry(String country) throws SQLException {
        PreparedStatement st = conn.prepareStatement(Queries.getQuery("validate_country"));
        st.setString(1, country);
        ResultSet rs = st.executeQuery();
        rs.close();
        return rs.first();
    }

    public boolean validateSubtype(String subtype, String subtypedesc) throws SQLException {
        PreparedStatement st = conn.prepareStatement(Queries.getQuery("validate_subtype"));
        st.setString(1, subtype);
        st.setString(1, subtypedesc);
        ResultSet rs = st.executeQuery();
        rs.close();
        return rs.first();
    }

    public boolean validatePincode(String pincode) {
        int iPincode = 0;
        boolean retPincode = false;
        if (pincode.length() == 6) {
            try {
                retPincode = true;
                iPincode = Integer.parseInt(pincode);
            } catch (NumberFormatException e) {
                retPincode = false;
            }
        } else {
            retPincode = false;
        }
        return retPincode;
    }

    public void Close() throws SQLException {
        this.conn.close();
    }
}
