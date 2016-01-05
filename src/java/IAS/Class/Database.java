/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletContext;
import javax.sql.DataSource;
import org.apache.log4j.Logger;

public class Database{

    ServletContext context;
    private static DataSource datasource;
    private static final Logger logger = JDSLogger.getJDSLogger(Database.class.getName());

    private static DataSource getDataSource() throws SQLException {
        if (datasource == null) {
            try {
                Context initCtx = new InitialContext();
                datasource = (DataSource) initCtx.lookup("java:/comp/env/jdbc/evitaran");
            } catch (NamingException e) {
                logger.fatal(e);
                throw (new SQLException(e.getMessage()));
            }
        }
        return datasource;
    }

    public static Connection getConnection() throws SQLException {
        return getDataSource().getConnection();
    }

    public int executeUpdatePreparedStatement(PreparedStatement pstatement) throws SQLException {

        int rs;
        
        if (pstatement == null) {
            return 0;
        } else {
            rs = pstatement.executeUpdate();
            return rs;
        }

    }

}
