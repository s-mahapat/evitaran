/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.Subscription;

import java.sql.Connection;

/**
 *
 * @author Shailendra Mahapatra
 */
public class BackIssueListModel {

    private Connection conn = null;
    public BackIssueListModel(Connection _conn){
        this.conn = _conn;
    }



}
