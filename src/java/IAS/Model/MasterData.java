/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model;

import javax.servlet.http.HttpSession;

/**
 *
 * @author Shailendra Mahapatra
 */
public class MasterData {

    private HttpSession session = null;
    private static MasterData instance = null;

    public static MasterData getInstance(HttpSession session) {
        if (instance != null) {
            return instance;
        } else {
            instance = new MasterData();
            instance.session = session;
        }
        return instance;
    }

    /*public ResultSet getColumnsData(String[] Columns, String table) throws SQLException{

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
     public ResultSet getColumnData(String Column, String table) throws SQLException {

     String query = "SELECT DISTINCT " + Column + " from " + table;

     ResultSet rs = null;
     Database db = (Database) session.getAttribute("db_connection");
     rs = db.executeQuery(query);
     return rs;
     }*/
}
