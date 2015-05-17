/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package JDSMigration;

import java.sql.*;
import org.apache.log4j.Logger;

public class Database {

    private String JDS_DATABASE = "evitaran";
    private String JDS_DATABASE_HOST = "localhost";
    private String JDS_USER = "root";
    private String JDS_PASSWORD = "root";
    private Connection connection = null;
    private String jdbcDriver = "com.mysql.jdbc.Driver";
    private static final Logger logger = Logger.getRootLogger();

    public Database() {
        String dbURL = "jdbc:mysql://" + this.JDS_DATABASE_HOST + "/" + this.JDS_DATABASE;
        try {

            Class.forName(jdbcDriver); //set Java database connectivity driver
            connection = DriverManager.getConnection(dbURL, this.JDS_USER, this.JDS_PASSWORD);
            if(connection == null){
                throw(new SQLException("Could not connect to database"));
            }
            connection.setAutoCommit(true);

        } catch (ClassNotFoundException e) {

            logger.fatal("Driver not found");

        } catch (Exception e) {
            logger.fatal(e);
        }
    }

    public Database(Connection conn) {
        this.connection = conn;
        //this.context = _context;
    }

    public void setConnection(Connection conn) {
        this.connection = conn;
    }

    public Connection getConnection() {
        return connection;
    }

    public ResultSet executeQuery(String query) throws SQLException {
        PreparedStatement st;
        ResultSet rs;
        st = connection.prepareStatement(query);
        rs = st.executeQuery();

        if (st == null) {
            return null;
        } else {
            return rs;
        }

    }

    public ResultSet executeQueryPreparedStatement(PreparedStatement pstatement) throws SQLException {

        ResultSet rs;
        rs = pstatement.executeQuery();
        if (pstatement == null) {
            return null;
        } else {
            return rs;
        }

    }

    public int executeUpdate(String statement) throws SQLException {

        PreparedStatement st = null;
        int rs = 0;
        st = connection.prepareStatement(statement);
        rs = st.executeUpdate();

        if (st == null) {
            return 0;
        } else {
            return rs;
        }

    }

    public int executeUpdatePreparedStatement(PreparedStatement pstatement) throws SQLException {

        int rs = 0;
        rs = pstatement.executeUpdate();
        //this.connection.commit();
        if (pstatement == null) {
            return 0;
        } else {
            return rs;
        }

    }

    public void close() {
        try {
            connection.close();
        } catch (SQLException sqlException) {
            //sqlException.printStackTrace();
            connection = null;
        }
    }

    @Override
    protected void finalize() {
        try {
            super.finalize();
        } catch (java.lang.Throwable e) {
        }
        close();
    }
}
