/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DataValidationFromDB {

    private Database db = null;
    private Connection conn = null;

    public DataValidationFromDB(Database db, Connection conn) {
        this.db = new Database();
    }

    public boolean validateCity(String city) throws SQLException {
        conn = Database.getConnection();
        PreparedStatement st = conn.prepareStatement(Queries.getQuery("validate_city"));
        st.setString(1, city);
        ResultSet rs = db.executeQueryPreparedStatement(st);
        boolean rsfirst = rs.first();
        conn.close();
        return rsfirst;
        
    }

    public boolean validateDistrict(String district) throws SQLException {
        conn = Database.getConnection();
        PreparedStatement st = conn.prepareStatement(Queries.getQuery("validate_district"));
        st.setString(1, district);
        ResultSet rs = db.executeQueryPreparedStatement(st);
        boolean bfirst = rs.first();
        conn.close();
        return bfirst;
    }

    public boolean validateCountry(String country) throws SQLException {
        PreparedStatement st = Database.getConnection().prepareStatement(Queries.getQuery("validate_country"));
        st.setString(1, country);
        ResultSet rs = db.executeQueryPreparedStatement(st);
        return rs.first();
    }
}
