
package IAS.Model.reminders;

import IAS.Bean.MailingList.mlFormBean;
import IAS.Bean.reminder.subscriberInfo;
import IAS.Bean.reminder.subscriptionInfo;
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
import javax.xml.parsers.ParserConfigurationException;
import java.text.ParseException;
import java.util.Properties;
import IAS.Class.msgsend;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import javax.activation.DataSource;
import javax.mail.util.ByteArrayDataSource;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.xml.sax.SAXException;
/**
 *
 * @author aloko
 */
public class reminderModel extends JDSModel {

    private mlFormBean _mlFormBean = null;
    private static final Logger logger = JDSLogger.getJDSLogger(reminderModel.class.getName());
    private Connection conn;

    public reminderModel(HttpServletRequest request) throws SQLException{

       super(request);
       conn = this.getConnection();

    }

    public String search()  throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml = null;
        String fromDate = request.getParameter("from");
        String toDate = request.getParameter("to");
        String sql = Queries.getQuery("gen_reminders_subscriber");
        sql += " and reminderDate between " + "STR_TO_DATE(" + '"' + fromDate + '"' + ",'%d/%m/%Y')" + " and " + "STR_TO_DATE(" + '"' + toDate + '"' + ",'%d/%m/%Y')";
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;
        stGet.setString(paramIndex, request.getParameter("reminderType"));
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);

        xml = util.convertResultSetToXML(rs);
        return xml;
    }

    public ResultSet getReminders(String medium, String sender)  throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String fromDate = request.getParameter("from");
        String toDate = request.getParameter("to");
        String sql = Queries.getQuery("get_reminders_subscriber");
        if (sender =="send"){
            sql += " and reminders.reminderDate = curdate()";
        }else {
            sql += " and reminderDate between " + "STR_TO_DATE(" + '"' + fromDate + '"' + ",'%d/%m/%Y')" + " and " + "STR_TO_DATE(" + '"' + toDate + '"' + ",'%d/%m/%Y')";
        }

                // E = Email Only
        if (medium.equals("E")) {

            sql += " and (subscriber.email <> \"\"  or subscriber.email <> null)";

        }
        // P = print only
        else if (medium.equals("P")){
            sql += " and (subscriber.email = \"\" or subscriber.email = null)";
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
        sql += " and reminders.reminderDate = curdate()";
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
        int subscriptionId = 0;
        int paramIndex = 1;
        while (rs.next()){
            subscriptionId = rs.getInt("subscriptionId");   
            int amount = rs.getInt("amount");
            int payment = rs.getInt("payment");
            int balance = 0;
            balance = amount - payment;
            if (balance > 0){
                paramIndex = 1;
                stInsRem.setInt(paramIndex, subscriptionId);
                stInsRem.setInt(++paramIndex, balance);
                stInsRem.setInt(++paramIndex, remType);
                stInsRem.executeUpdate();
            }
        }        
        ResultSet rsReminders = getGenReminders();
        xml = util.convertResultSetToXML(rsReminders);
        return xml;
    }

    public List<subscriberInfo> buildRemindersData(ResultSet rsGet, String medium)   throws SQLException, ParseException, ParserConfigurationException, TransformerException, IOException {

        List<subscriberInfo> subscriberInfo = new ArrayList<subscriberInfo>();

        //Loop the data for individual subscriber for reminder
        while (rsGet.next()){
            subscriberInfo sInfo = new subscriberInfo();

            //Extract subscriber Details
            int subscriber_id    = rsGet.getInt(1);
            sInfo.setSubscriber_id(subscriber_id);

            int subId            = rsGet.getInt(2);
            sInfo.setSubId(subId);

            String subtypecode   = rsGet.getString(3);
            sInfo.setSubtypecode(subtypecode);

            String subscriberNumber = rsGet.getString(4);
            sInfo.setSubscriberNumber(subscriberNumber);

            String subscriberName = rsGet.getString(5);
            sInfo.setSubscriberName(subscriberName);

            int balance          = rsGet.getInt(6);
            sInfo.setBalance(balance);

            int reminderType     = rsGet.getInt(7);
            sInfo.setReminderType(reminderType);

            String reminderDate  = rsGet.getString(8);
            sInfo.setReminderDate(reminderDate);

            String department    = rsGet.getString(9);
            sInfo.setDepartment(department);

            String institution   = rsGet.getString(10);
            sInfo.setInstitution(institution);

            String shippingAddress = rsGet.getString(11);
            sInfo.setShippingAddress(shippingAddress);

            String city          = rsGet.getString(12);
            sInfo.setCity(city);

            String district      = rsGet.getString(13);
            sInfo.setDistrict(district);

            String state         = rsGet.getString(14);
            sInfo.setState(state);

            String country       = rsGet.getString(15);
            sInfo.setCountry(country);

            String pincode       = rsGet.getString(16);
            sInfo.setPincode(pincode);

            String email         = rsGet.getString(17);
            sInfo.setEmail(email);

            int reminders_id     = rsGet.getInt(18);
            sInfo.setReminders_id(reminders_id);

            //get the subscription details
            String sqlgetjnls = Queries.getQuery("get_subscribed_journals");
            PreparedStatement stgetjnls = conn.prepareStatement(sqlgetjnls);
            int paramIndex = 1;

            stgetjnls.setInt(paramIndex, reminders_id);
            ResultSet rsgetjnls = this.db.executeQueryPreparedStatement(stgetjnls);

            while (rsgetjnls.next()){

                subscriptionInfo subsInfo = new subscriptionInfo();

                String journalName   = rsgetjnls.getString(1);
                subsInfo.setJournalName(journalName);

                int startYear        = rsgetjnls.getInt(2);
                subsInfo.setStartYear(startYear);

                int startMonth       = rsgetjnls.getInt(3);
                subsInfo.setStartMonth(startMonth);

                int endMonth         = rsgetjnls.getInt(4);
                subsInfo.setEndMonth(endMonth);

                int endYear          = rsgetjnls.getInt(5);
                subsInfo.setEndYear(endYear);

                int copies           = rsgetjnls.getInt(6);
                subsInfo.setCopies(copies);

                sInfo.getSubscriptionInfo().add(subsInfo);

            }

            // insert the record to sent reminders
            //int ins = insertReminderDetails(Integer.toString(reminders_id), medium);

            subscriberInfo.add(sInfo);

        }

        return subscriberInfo;
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

            Element _reminderType = doc.createElement("reminderType");
            subscriber.appendChild(_reminderType);
            _reminderType.appendChild(doc.createTextNode(Integer.toString(reminderType)));

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

    public String sendEmail(String medium, String sender)  throws SQLException, ParseException, ParserConfigurationException, TransformerException, IOException, DocumentException, SAXException {

        boolean status = false;
        String xml = "";
        // Get data for reminders
        ResultSet rsGet = getReminders(medium, sender);
        List<subscriberInfo> sinfo = buildRemindersData(rsGet, medium);

        msgsend sendMsg = new msgsend("text/html");
        boolean success = true;
        String message = "Failed to send email to the following address:";
        //Loop the data for individual subscriber for reminder
        Iterator itr = sinfo.listIterator();

        while (itr.hasNext()){

            subscriberInfo s = (subscriberInfo)itr.next();
            int reminderType     = s.getReminderType();
            String email         = s.getEmail();
            List<subscriberInfo> singleSubscriberInfo = new ArrayList<subscriberInfo>();
            singleSubscriberInfo.add(s);

            // Get the pdf content
            logger.debug("Starting to get pdf to be sent as attachment");

            String msg;

            convertToPdf c2Pdf          = new convertToPdf();
            ByteArrayOutputStream baos  = c2Pdf.generateReminders(singleSubscriberInfo);

            if(reminderType == 1){
                Properties properties = c2Pdf.getRemindersProperties();
                msg = properties.getProperty("reminderType1");
            }else if(reminderType == 2) {
                Properties properties = c2Pdf.getRemindersProperties();
                msg = properties.getProperty("reminderType2");
            }else if(reminderType == 3) {
                Properties properties = c2Pdf.getRemindersProperties();
                msg = properties.getProperty("reminderType3");
            } else {
                message = "Incorrect reminder type received, aborting..";
                success = false;
                break;
            }
            logger.debug("Done getting mail attachment");

            logger.debug("Starting to send email");
            // If message sending passed
            byte[] bytes = baos.toByteArray();
            DataSource ds = new ByteArrayDataSource(bytes, "application/pdf");
            if(!sendMsg.sendMail(email, "", "jds.ias.mails@gmail.com", "Reminder", msg, "", "invoice.pdf", ds)){
                success = false;
                message = message + " " + email;
            }
            logger.debug("Done sending email");
        }

        // Communicate status back to the user
        String successValue = (success == true) ? "1" : "0";
        if(successValue.equals("1")){
            xml = util.convertStringToXML(successValue, "success");
        }else {
            HashMap<String, String> xmlResponse = new HashMap<>();
            xmlResponse.put("success", successValue);
            xmlResponse.put("message", message);
            xml = util.createXMLResponse(xmlResponse);
        }

        return xml;
    }

    public List<subscriberInfo> printOnly(String medium, String sender) throws SQLException, ParseException, ParserConfigurationException, TransformerException, IOException {
        boolean status = false;
        String xml = null;
        // Get data for reminders
        ResultSet rsGet = getReminders(medium, sender);
        //xml = buildXml(rsGet, medium);
        List<subscriberInfo> sinfo = buildRemindersData(rsGet, medium);
        //return xml;
        return sinfo;
    }

    public List<subscriberInfo> printAll(String medium, String sender)  throws SQLException, ParseException, ParserConfigurationException, TransformerException, IOException {
        boolean status = false;
        String xml = null;
        // Get data for reminders
        ResultSet rsGet = getReminders(medium, sender);
        //xml = buildXml(rsGet, medium);
        List<subscriberInfo> sinfo = buildRemindersData(rsGet, medium);
        //return xml;
        return sinfo;
    }

   public int insertReminderDetails(String reminderId, String medium)  throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String sqlins = Queries.getQuery("insert_reminder_details");
        PreparedStatement stins = conn.prepareStatement(sqlins);
        int paramIndex = 0;
        stins.setString(++paramIndex, reminderId.toString());
        stins.setString(++paramIndex, medium);
        stins.setString(++paramIndex, "1");
        if (db.executeUpdatePreparedStatement(stins) == 1)
            return 1;
        else
            return 0;
    }
}