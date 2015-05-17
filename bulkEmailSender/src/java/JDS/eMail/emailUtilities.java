/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package JDS.eMail;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author aloko
 */
public class emailUtilities {

    public synchronized int saveSubjectToDB(Connection connection, String subject) throws SQLException
    {
        String queryFormat = "INSERT INTO subject (subject) VALUES('" + subject + "')";
        Statement statement = (Statement) connection.createStatement();
        boolean rowsAffected = statement.execute(queryFormat);
        if(rowsAffected) {
            System.out.println("Error in getting ID");
            return 0;
        }
        ResultSet result = statement.executeQuery("SELECT LAST_INSERT_ID() AS id");
        result.next();
        int subjectID = result.getInt("id");
        return subjectID;
    }

    public synchronized int saveMessageToDB(Connection connection, String message) throws SQLException
    {
        /* What I have found is that if at the end of message you press and enter,
         * then the enter is replaced by "<p>&nbsp;</p>". These set of characters
         * confuse the jQuery when the data is fetched and sent to the jQuery.
         * Hence removing it from the string before inserting into dB
        */
        message = message.replaceAll("<p>&nbsp;</p>", "");
        String queryFormat = "INSERT INTO messagetext (messageText) VALUES('" + message + "')";
        Statement statement = (Statement) connection.createStatement();
        boolean rowsAffected = statement.execute(queryFormat);
        if(rowsAffected) {
            System.out.println("Error in getting ID");
            return 0;
        }
        ResultSet result = statement.executeQuery("SELECT LAST_INSERT_ID() AS id");
        result.next();
        int messageTextID = result.getInt("id");
        return messageTextID;
    }

    public synchronized void saveMsgToDB(Connection connection, String to, int subjectID,
            int messageTextID, String status) throws SQLException
    {
        Date dateNow = new Date();
        SimpleDateFormat dateformatYYYYMMDD = new SimpleDateFormat("yyyyMMdd");
        StringBuilder nowYYYYMMDD = new StringBuilder( dateformatYYYYMMDD.format( dateNow ) );


        String queryFormat = "INSERT INTO besdata (emailid, status, date, messageTextID, subjectID) values"
                + "("
                + "'" + to + "', "
                + "'" + status + "', "
                + "'" + nowYYYYMMDD.toString() + "', "
                + "'" + Integer.toString(messageTextID) + "', "
                + "'" + Integer.toString(subjectID) + "'"
                + ")";
        Statement statement = (Statement) connection.createStatement();
        boolean execute = statement.execute(queryFormat);
    }
}
