/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package JDSMigration;

import java.sql.PreparedStatement;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import jxl.read.biff.BiffException;
import org.apache.log4j.Logger;

/**
 *
 * @author aloko
 */
public class circulationFigures extends MigrationBase{

    private static final Logger logger = Logger.getLogger(circulationFigures.class.getName());

    private String select_journals = "SELECT id, journalCode, journalName from journals";
    private String select_subscriberTypes = "select id, subtypecode from subscriber_type";
    private String select_subscriptions = "select count(subscriber.subscriberNumber), sum(subscriptiondetails.copies)" +
                                          " from" +
                                          " subscriptiondetails left join subscription on subscriptiondetails.subscriptionID = subscription.id" +
                                          " left join subscriber on subscription.subscriberID = subscriber.id" +
                                          " left join subscriber_type on subscriber.subtype = subscriber_type.id" +
                                          " left join journal_groups on subscriptiondetails.journalGroupID = journal_groups.id" +
                                          " right join journal_group_contents on journal_group_contents.journalGroupId = journal_groups.id" +
                                          " left join journals on journal_group_contents.journalId = journals.id" +
                                          " where journals.journalCode = ? and subscriber_type.subtypecode = ?" +
                                          " and datediff(date_format(concat(subscriptiondetails.endYear,'-',subscriptiondetails.endMonth,'-30'),'%Y/%m/%d'), date_format(curdate(),'%Y/%m/%d'))>= 0" +
                                          " and datediff(date_format(concat(subscriptiondetails.startYear,'-',subscriptiondetails.startMonth,'-1'),'%Y/%m/%d'), date_format(curdate(),'%Y/%m/%d'))<= 0" +
                                          " group by journals.journalCode and subscriber_type.subtypecode";


    public circulationFigures() throws SQLException{
        this.conn = this.db.getConnection();
        conn.setAutoCommit(false);
    }

    void getCount() throws FileNotFoundException, IOException, BiffException, SQLException
    {

        String[] datacolumns = null;


        PreparedStatement pst1 = this.conn.prepareStatement(select_journals);
        ResultSet rs1 = db.executeQueryPreparedStatement(pst1);
        // For each journal
        while(rs1.next())
        {
            int journalId = rs1.getInt(1);
            String journalCode = rs1.getString(2);
            //System.out.println("Journal Code: " + journalCode);
            String journalName = rs1.getString(3);
            PreparedStatement pst2 = this.conn.prepareStatement(select_subscriberTypes);
            ResultSet rs2 = db.executeQueryPreparedStatement(pst2);
            int totalCopies=0;
            // For each subscriner type
            while(rs2.next())
            {
                int subtypeId = rs2.getInt(1);
                String subtypecode = rs2.getString(2);
                int paramIndex = 1;
                PreparedStatement pst3 = this.conn.prepareStatement(select_subscriptions);
                pst3.setString(paramIndex, journalCode);
                pst3.setString(++paramIndex, subtypecode);
                ResultSet rs3 = db.executeQueryPreparedStatement(pst3);
                int subscriberCount = 0;
                int copies = 0;
                if (rs3.next())
                {
                    subscriberCount = rs3.getInt(1);
                    copies = rs3.getInt(2);
                    totalCopies = totalCopies + copies;
                }
                logger.debug("Journal Code: " + journalCode + "->subtype: " + subtypecode + "-> Subscriber Count: " + subscriberCount + "-> Subscriber Copies: " + copies);
            }
            logger.debug("Total copies: " + totalCopies);
        }
    }
}
