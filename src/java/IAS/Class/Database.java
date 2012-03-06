/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;
import org.apache.log4j.Logger;

public class Database implements HttpSessionBindingListener {

    ServletContext context;
    private Connection connection = null;
    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Class.Database");

    public Database() {
    }

    public Database(Connection conn) {
        this.connection = conn;
        //this.context = _context;
    }

    public void setConnection(Connection conn) {
        this.connection = conn;
    }

    @Override
    public void valueUnbound(HttpSessionBindingEvent ev) {

        try {
            if (connection != null) {
                logger.debug("Closing database connection, session close event");
                //connection.rollback();
                connection.close();
            }
        } catch (SQLException e) {
            logger.error(e);
        } catch (Exception e) {
            logger.error(e);
        }

    }

    @Override
    public void valueBound(HttpSessionBindingEvent event) {

        logger.debug("Created a new session with id " + event.getSession().getId());

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

    public ResultSet executeQueryPreparedStatementWithPages(String query, int pageNumber, int pageSize) throws SQLException {

        ResultSet rs;
        int start = (pageNumber - 1) * pageSize;
        query += " LIMIT " + start + "," + pageSize;
        PreparedStatement pstatement = connection.prepareStatement(query);
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
