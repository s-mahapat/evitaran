
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
       
    public String generate() throws SQLException, ParseException, ParserConfigurationException, TransformerException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {
        String xml = null;        
        String proc = null;
        int remType = 0;
        remType = Integer.parseInt(request.getParameter("reminderType"));
        if (remType == 1){
            proc = "{ call create_reminder_type1(?) }";
        }
        else if (remType == 2){
            proc = "{ call create_reminder_type2(?) }";
        }
        else if (remType == 3){
            proc = "{ call create_reminder_type3(?) }";
        }
        CallableStatement cs = conn.prepareCall(proc);
        int paramIndex = 1;        
        cs.setString(paramIndex, request.getParameter("reminderType"));
       //cs.setString(paramIndex, request.getParameter("medium"));
       // cs.setString(paramIndex, request.getParameter("language"));
        //cs.execute();
        int rs = cs.executeUpdate();
        if (rs == 1){
            ResultSet rsGet = getReminders();
            xml = util.convertResultSetToXML(rsGet);
        }
        return xml;
    }

    public ResultSet send()  throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String medium = request.getParameter("medium");
        ResultSet rsGet = getReminders();
        if (medium == "E"){
            sendEmail(medium);                    
        }
        else{
            print();
        }
        
        return rsGet;
    }
    
    public int sendEmail(String medium)  throws SQLException, ParseException, ParserConfigurationException, TransformerException {

        String sql = Queries.getQuery("send_email_reminders");
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;        
        stGet.setString(paramIndex, request.getParameter("reminderType"));        
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        while (rs.next()) {            
            String sqlgetjnls = Queries.getQuery("get_subscribed_journals");
            PreparedStatement stgetjnls = conn.prepareStatement(sqlgetjnls);
            paramIndex = 1;
            Object reminderId = null;
            reminderId = rs.getObject(1);
            Object subscriberId = null;
            subscriberId = rs.getObject(2);
            Object subscriptionId = null;
            subscriptionId = rs.getObject(3);
            stgetjnls.setString(paramIndex, subscriptionId.toString());
            ResultSet rsgetjnls = this.db.executeQueryPreparedStatement(stgetjnls);
            while (rsgetjnls.next()){
                Object value = null;
                for (int j = 3; j <= 21; j++) {
                    value = rs.getObject(j);
                }
            }
            Object value = null;
            for (int j = 3; j <= 21; j++) {
                value = rs.getObject(j);
            }
            //send email
            int ins =insertReminderDetails(reminderId.toString(), medium);

        }
        return 1;
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