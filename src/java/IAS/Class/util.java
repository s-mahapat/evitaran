/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

//import java.util.*;
import java.text.*;
//import java.sql.*;

/**
 *
 * @author Shailendra Mahapatra
 */
public final class util {

    public static String getDateString() {
        Format dtformat = new SimpleDateFormat("dd/MM/yyyy");
        java.util.Date dt = new java.util.Date();
        return dtformat.format(dt);
    }

    public static String getDateString(String dateFormat) {
        Format dtformat = new SimpleDateFormat(dateFormat);
        java.util.Date dt = new java.util.Date();
        return dtformat.format(dt);
    }

    public static java.sql.Date dateStringToSqlDate(String stringDate) throws ParseException{

        DateFormat formater = new SimpleDateFormat("dd/MM/yyyy");
        java.util.Date parsedUtilDate = formater.parse(stringDate);
        java.sql.Date sqlDate = new java.sql.Date(parsedUtilDate.getTime());
        return sqlDate;
    }
}
