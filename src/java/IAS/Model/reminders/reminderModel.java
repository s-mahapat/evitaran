
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
import java.io.StringWriter;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
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

    public String search()  throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml = null;
        String sql = Queries.getQuery("get_reminders_subscriber");
        sql += " and subscriber.email <> \"\"  or subscriber.email <> null";
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;
        stGet.setString(paramIndex, request.getParameter("reminderType"));
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        
        xml = util.convertResultSetToXML(rs);
        return xml;
    }

    public ResultSet getReminders(String medium)  throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String sql = Queries.getQuery("get_reminders_subscriber");
                // E = Email Only
        if (medium.equals("E")) {
            
            sql += " and subscriber.email <> \"\"  or subscriber.email <> null";
            
        }
        // P = print only
        else if (medium.equals("P")){
            sql += " and subscriber.email = \"\" or subscriber.email = null";
        }
        // A = print all
        else if(medium.equals("A")) {
            
        }
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


    public String buildXml(ResultSet rsGet, String medium)   throws SQLException, ParseException, ParserConfigurationException, TransformerException, IOException {
        String xml = null;
// Get data for reminders
        //ResultSet rsGet = getReminders();

        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document doc = builder.newDocument();
        Element results = doc.createElement("results");
        doc.appendChild(results);
        
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

           // Add the row element
            Element subscriber = doc.createElement("subscriber");
            results.appendChild(subscriber);

            Element _subtypecode = doc.createElement("subtypecode");
            subscriber.appendChild(_subtypecode);
            _subtypecode.appendChild(doc.createTextNode(subtypecode));

            Element _subscriberNumber = doc.createElement("subscriberNumber");
            subscriber.appendChild(_subscriberNumber);
            _subscriberNumber.appendChild(doc.createTextNode(subscriberNumber));

            Element _subscriberName = doc.createElement("subscriberName");
            subscriber.appendChild(_subscriberName);
            _subscriberName.appendChild(doc.createTextNode(subscriberName));
            
            Element _balance = doc.createElement("balance");
            subscriber.appendChild(_balance);
            _balance.appendChild(doc.createTextNode(Integer.toString(balance)));
            
            Element _department = doc.createElement("department");
            subscriber.appendChild(_department);
            _department.appendChild(doc.createTextNode(department));
            
            Element _institution = doc.createElement("institution");
            subscriber.appendChild(_institution);
            _institution.appendChild(doc.createTextNode(institution));
            
            Element _shippingAddress = doc.createElement("shippingAddress");
            subscriber.appendChild(_shippingAddress);
            _shippingAddress.appendChild(doc.createTextNode(shippingAddress));
            
            Element _city = doc.createElement("city");
            subscriber.appendChild(_city);
            _city.appendChild(doc.createTextNode(city));
            
            Element _district = doc.createElement("district");
            subscriber.appendChild(_district);
            _district.appendChild(doc.createTextNode(district));
            
            
            Element _state = doc.createElement("state");
            subscriber.appendChild(_state);
            _state.appendChild(doc.createTextNode(state));
            
            Element _country = doc.createElement("country");
            subscriber.appendChild(_country);
            _country.appendChild(doc.createTextNode(country));
            
            Element _pincode = doc.createElement("pincode");
            subscriber.appendChild(_pincode);
            _pincode.appendChild(doc.createTextNode(pincode));
            
            Element _email = doc.createElement("email");
            subscriber.appendChild(_email);
            _email.appendChild(doc.createTextNode(email));
            
           //get the subscription details
           String sqlgetjnls = Queries.getQuery("get_subscribed_journals");
           PreparedStatement stgetjnls = conn.prepareStatement(sqlgetjnls);
           int paramIndex = 1;  
           //Object reminderId = null;
           //reminderId = rsGet.getObject(1);
           stgetjnls.setInt(paramIndex, reminders_id);
           ResultSet rsgetjnls = this.db.executeQueryPreparedStatement(stgetjnls);
           while (rsgetjnls.next()){
           String journalCode   = rsgetjnls.getString(1);
           String journalName   = rsgetjnls.getString(2);
           String journalGroupName  = rsgetjnls.getString(3);
           int copies           = rsgetjnls.getInt(4);
           int startYear        = rsgetjnls.getInt(5);
           int startMonth       = rsgetjnls.getInt(6);
           int endMonth         = rsgetjnls.getInt(7);
           int endYear          = rsgetjnls.getInt(8);

            // Add the row element
             Element journals = doc.createElement("journals");
             subscriber.appendChild(journals);

             Element _journalCode = doc.createElement("journalCode");
             journals.appendChild(_journalCode);
             _journalCode.appendChild(doc.createTextNode(journalCode));

             Element _journalName = doc.createElement("journalName");
             journals.appendChild(_journalName);
             _journalName.appendChild(doc.createTextNode(journalName));

             Element _copies = doc.createElement("copies");
             journals.appendChild(_copies);
             _copies.appendChild(doc.createTextNode(Integer.toString(copies)));

             Element _startMonth = doc.createElement("startMonth");
             journals.appendChild(_startMonth);
             _startMonth.appendChild(doc.createTextNode(Integer.toString(startMonth)));

             Element _startYear = doc.createElement("startYear");
             journals.appendChild(_startYear);
             _startYear.appendChild(doc.createTextNode(Integer.toString(startYear)));

             Element _endMonth = doc.createElement("endMonth");
             journals.appendChild(_endMonth);
             _endMonth.appendChild(doc.createTextNode(Integer.toString(endMonth)));

             Element _endYear = doc.createElement("endYear");
             journals.appendChild(_endYear);
             _endYear.appendChild(doc.createTextNode(Integer.toString(endYear)));
          
           }
          // insert the record to sent reminders
          int ins = insertReminderDetails(Integer.toString(reminders_id), medium);
          
        }    
        
        DOMSource domSource = new DOMSource(doc);
        try (StringWriter writer = new StringWriter()) {
            StreamResult result = new StreamResult(writer);
            TransformerFactory tf = TransformerFactory.newInstance();
            Transformer transformer = tf.newTransformer();
            transformer.transform(domSource, result);
            xml = writer.toString();
        }
        
        return xml;
    }
    
    public String sendEmail(String medium)  throws SQLException, ParseException, ParserConfigurationException, TransformerException, IOException {

        boolean status = false;
        String xml = null;
        // Get data for reminders
        ResultSet rsGet = getReminders(medium);
        xml = buildXml(rsGet, medium);
        return xml;
    }

    public String printOnly(String medium) throws SQLException, ParseException, ParserConfigurationException, TransformerException, IOException {
        boolean status = false;
        String xml = null;
        // Get data for reminders
        ResultSet rsGet = getReminders(medium);
        xml = buildXml(rsGet, medium);
        return xml;
    }

    public String printAll(String medium)  throws SQLException, ParseException, ParserConfigurationException, TransformerException, IOException {
        boolean status = false;
        String xml = null;
        // Get data for reminders
        ResultSet rsGet = getReminders(medium);
        xml = buildXml(rsGet, medium);
        return xml;     
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
}