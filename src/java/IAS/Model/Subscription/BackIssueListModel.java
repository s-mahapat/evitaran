/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.Subscription;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class BackIssueListModel {

    private Connection conn = null;
    public BackIssueListModel(Connection _conn){
        this.conn = _conn;
    }

    public boolean addToBackIssueList(int subscription_detail_id,
                                      int journal_group_id,
                                      int copies) throws SQLException{

        // call the stored procedure in the db

        String sql = "{call add_to_back_issue(?,?,?)}";
        CallableStatement cs = this.conn.prepareCall(sql);
        cs.setInt(1, subscription_detail_id);
        cs.setInt(2, journal_group_id);
        cs.setInt(3, copies);
        int rs = cs.executeUpdate();
        return true;

    }



}
