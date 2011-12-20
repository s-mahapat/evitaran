/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model;

import javax.servlet.*;
import java.sql.*;
import IAS.Class.Queries;
import java.util.Calendar;

public class InwardSubscriberHelper {

    private static ServletContext context = null;
    private static String sql;
    private static Connection connection = null;
    private static int lastInward = 0;
    private static boolean readDB = true;
    private static boolean readOnce = false;

    public InwardSubscriberHelper(ServletContext _context) {

        this.context = _context;

    }

    private static void _connect(){
        String username = context.getInitParameter("db_user");
        String password = context.getInitParameter("db_password");
        String dbURL = context.getInitParameter("db_driver") + "://" + context.getInitParameter("db_host") + "/" + context.getInitParameter("db_name");
        try {
            connection = DriverManager.getConnection(dbURL, username, password);


        } catch (SQLException ex) {
        } catch (Exception ex) {
        }
    }

    public static int getNextInwardNumber() throws SQLException{

        Calendar cal = Calendar.getInstance();

        // read the database on jan 1st only one.
        if(cal.MONTH == 1 && cal.DAY_OF_MONTH == 1 && !readOnce){
            readDB = true;
            readOnce = true;
        }

        if(readDB){
            _getInwardNumberFromDb();
        }else{
            return ++lastInward;
        }
        return lastInward;
    }

    public static void setLastInwardNumber(int _inwardNumber){

        lastInward = _inwardNumber;
    }

    private static void _getInwardNumberFromDb() throws SQLException{

        _connect();
        PreparedStatement st = null;
        ResultSet rs = null;
        sql = Queries.getQuery("get_last_inward");
        st = connection.prepareStatement(sql);
        rs = st.executeQuery();
    }
}
