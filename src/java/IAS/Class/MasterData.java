/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;
import javax.servlet.http.HttpSession;
import java.sql.*;
/**
 *
 * @author Shailendra Mahapatra
 */
public class MasterData {
    private HttpSession session = null;
    private static MasterData instance = null;

    public static MasterData getInstance(HttpSession session){
        if(instance!=null){
            return instance;
        }else{
            instance = new MasterData();
            instance.session = session;
        }
        return instance;
    }

    public ResultSet getColumnData(String[] Columns, String table){

        String columnStr = Columns[0];

        for(int i=1;i<Columns.length;i++){

            columnStr += Columns[i];
        }

        String query = "SELECT " + columnStr + " from " + table;

        ResultSet rs = null;
        Database db = (Database)session.getAttribute("db_connection");
        rs = db.executeQuery(query);
        return rs;
    }





}
