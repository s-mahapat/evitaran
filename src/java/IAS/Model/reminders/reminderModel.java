
package IAS.Model.reminders;

import IAS.Model.reminders.*;
import IAS.Bean.MailingList.mlFormBean;
import IAS.Model.JDSModel;
import com.itextpdf.text.DocumentException;
import java.io.IOException;
import javax.xml.transform.TransformerException;
import org.apache.log4j.Logger;
import IAS.Class.JDSLogger;
import javax.servlet.http.HttpServletRequest;
import java.sql.*;
import IAS.Class.Queries;
import IAS.Class.convertToPdf;
import IAS.Class.util;
import java.io.ByteArrayOutputStream;
import java.io.OutputStream;
import javax.xml.parsers.ParserConfigurationException;
import java.text.ParseException;
import javax.servlet.http.HttpServletResponse;
import java.util.Properties;
import javax.servlet.ServletContext;
import IAS.Class.ServletContextInfo;
import java.io.FileInputStream;
import IAS.Class.msgsend;

/**
 *
 * @author aloko
 */
public class reminderModel extends JDSModel {

    private mlFormBean _mlFormBean = null;
    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Model.MailingList");

    public reminderModel(HttpServletRequest request) throws SQLException{

       super(request);

    }

    public ResultSet search()  throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String sql = Queries.getQuery("search_reminders_subscriber");
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;
        stGet.setString(paramIndex, request.getParameter("reminderType"));
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        return rs;
    }

       public ResultSet getReminders()  throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String sql = Queries.getQuery("get_reminders_subscriber");
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;
        stGet.setString(paramIndex, request.getParameter("reminderType"));
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        return rs;
    }


    public ResultSet getGenReminders()  throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String sql = Queries.getQuery("gen_reminders_subscriber");
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;
        stGet.setString(paramIndex, request.getParameter("reminderType"));
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        return rs;
    }

    public String generate() throws SQLException, ParseException, ParserConfigurationException, TransformerException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        String xml = null;
        ResultSet rs = null;
        Connection conn = this.getConnection();
        int subscription_total = 0;
        int payment_total = 0;
        int balance = 0;
        String sqlSubTotal = Queries.getQuery("get_subscription_total");
        PreparedStatement stSubRate = conn.prepareStatement(sqlSubTotal);

        String sqlPayTotal = Queries.getQuery("get_payment_total");
        PreparedStatement stPayRate = conn.prepareStatement(sqlPayTotal);

        String sqlInsRem = Queries.getQuery("insert_rem");
        PreparedStatement stInsRem = conn.prepareStatement(sqlInsRem);

        String sql = null;
        int remType = 0;
        remType = Integer.parseInt(request.getParameter("reminderType"));
        if (remType == 1){
            sql = Queries.getQuery("get_susbcriber_for_rem1");
        }
        else if (remType == 2){
            sql = Queries.getQuery("get_susbcriber_for_rem2");
        }
        else if (remType == 3){
            sql = Queries.getQuery("get_susbcriber_for_rem3");
        }

        PreparedStatement stGet = conn.prepareStatement(sql);
        rs = stGet.executeQuery();
        Object value = null;
        int paramIndex = 1;
        while (rs.next()){
            value = rs.getObject(1);
            stSubRate.setString(1, value.toString());
            ResultSet rsSubRate = stSubRate.executeQuery();
            if (rsSubRate.next()){
                subscription_total = rsSubRate.getInt(1);
                stPayRate.setString(1, value.toString());
                ResultSet rsPayRate = stPayRate.executeQuery();
                if (rsSubRate.next()){
                    payment_total = rsSubRate.getInt(1);
                }
                balance = subscription_total - payment_total;
                if (balance > 0){
                    paramIndex = 1;
                    stInsRem.setString(paramIndex, value.toString());
                    stInsRem.setInt(++paramIndex, balance);
                    stInsRem.setInt(++paramIndex, remType);
                    stInsRem.executeUpdate();
                }
            }
        }
        ResultSet rsReminders = getGenReminders();
        xml = util.convertResultSetToXML(rsReminders);
        return xml;
    }


    public ResultSet send()  throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml = null;

        ResultSet rsGet = getReminders();
        return rsGet;
    }

    public String sendEmail(String medium)  throws SQLException, ParseException, ParserConfigurationException, TransformerException, IOException {

        boolean status = false;
        String xml = null;
        // Get data for reminders
        ResultSet rsGet = getReminders();
        //Loop the data for individual subscriber for reminder
        while (rsGet.next()){
           //Extract subscriber Details
           int subscriber_id    = rsGet.getInt(1); 
           int subId            = rsGet.getInt(2);
           String subtypecode   = rsGet.getString(3);
           String subscriberNumber = rsGet.getString(4);
           String subscriberName = rsGet.getString(5);
           int balance          = rsGet.getInt(6);
           int reminderType     = rsGet.getInt(7);
           String reminderDate  = rsGet.getString(8);
           String department    = rsGet.getString(9);
           String institution   = rsGet.getString(10);
           String shippingAddress = rsGet.getString(11);
           String city          = rsGet.getString(12);
           String district      = rsGet.getString(13);
           String state         = rsGet.getString(14);
           String country       = rsGet.getString(15);
           String pincode       = rsGet.getString(16);
           String email         = rsGet.getString(17);
           int reminders_id     = rsGet.getInt(18);
                                
           //get the subscription details
           String sqlgetjnls = Queries.getQuery("get_subscribed_journals");
           PreparedStatement stgetjnls = conn.prepareStatement(sqlgetjnls);
           int paramIndex = 1;  
           //Object reminderId = null;
           //reminderId = rsGet.getObject(1);
           stgetjnls.setInt(paramIndex, reminders_id);
           ResultSet rsgetjnls = this.db.executeQueryPreparedStatement(stgetjnls);
           
           String journalCode   = rsgetjnls.getString(1);
           String journalName   = rsgetjnls.getString(2);
           String journalGroupName  = rsgetjnls.getString(3);
           int copies           = rsgetjnls.getInt(4);
           int startYear        = rsgetjnls.getInt(5);
           int startMonth       = rsgetjnls.getInt(6);
           int endMonth         = rsgetjnls.getInt(7);
           int endYear          = rsgetjnls.getInt(8);
           
                      
          // insert the record to sent reminders
          int ins = insertReminderDetails(Integer.toString(reminders_id), medium);
        }    
        
        if(status)
            xml = util.convertStringToXML("success", "action");
        else
            xml = util.convertStringToXML("failure", "action");

        return xml;
    }

    public ResultSet printOnly(String medium) {
        ResultSet rs = null;
        return rs;
    }

    public ResultSet printAll(String medium)  throws SQLException, ParseException, ParserConfigurationException, TransformerException, IOException {
        boolean status = false;
        String xml = null;
        // Get data for reminders
        ResultSet rsGet = getGenReminders();
        
        return rsGet;        
    }

   public int print()  throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String medium = request.getParameter("medium");
        ResultSet rsGet = getReminders();

        return 1;
    }

   public int insertReminderDetails(String reminderId, String medium)  throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String sqlins = Queries.getQuery("insert_reminder_details");
        PreparedStatement stins = conn.prepareStatement(sqlins);
        int paramIndex = 0;
        stins.setString(++paramIndex, reminderId.toString());
        stins.setString(++paramIndex, medium);
        stins.setString(++paramIndex, "E");
        if (db.executeUpdatePreparedStatement(stins) == 1)
            return 1;
        else
            return 0;
    }

    public String print1(HttpServletResponse response) throws SQLException, ParseException, ParserConfigurationException, TransformerException, IOException, DocumentException
    {
        //Query whatever you want here
        String xml = null;
       // int stat = this.search();
        ResultSet rs = null;

        //Now convert to pdf here
        //convertToPdf toPdf = new convertToPdf();
        //ByteArrayOutputStream baos = toPdf.getPdf(rs, response);

        // setting some response headers
        //response.setHeader("Expires", "0");
        //response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
        //response.setHeader("Pragma", "public");
        // setting the content type
        //response.setContentType("application/pdf");
        //response.setHeader("Content-disposition","attachment; filename=ml.pdf");
        // the contentlength
        //response.setContentLength(baos.size());
        // write ByteArrayOutputStream to the ServletOutputStream
        //OutputStream os = response.getOutputStream();
        //baos.writeTo(os);
        //os.flush();
        //os.close();

        return xml;
    }

}