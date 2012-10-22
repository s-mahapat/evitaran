/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.BulkEmail;

import IAS.Class.JDSLogger;
import IAS.Class.Queries;
import IAS.Class.ServletContextInfo;
import IAS.Class.msgsend;
import IAS.Class.util;
import IAS.Model.JDSModel;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.StringWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Properties;
import javax.mail.Address;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.apache.log4j.Logger;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

/**
 *
 * @author aloko
 */
public class BulkEmailModel extends JDSModel{

    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Model.BulkEmailModel");

    public BulkEmailModel(HttpServletRequest request) throws SQLException{
        super(request);
    }

    public String validateEmail() throws ParserConfigurationException, IOException, TransformerConfigurationException, TransformerException{

        String to = request.getParameter("to");
        String message = "";
        boolean success = true;
        try {
            //new InternetAddress(to).validate();
            Address[] toUser = InternetAddress.parse(to, false);
            for(Address s: toUser){
                new InternetAddress(s.toString()).validate();
            }
        } catch (AddressException ex) {
            message = ex.getMessage();
            success = false;
        }

        HashMap<String, String> xmlResponse = new HashMap<>();
        String successValue = (success == true) ? "1" : "0";
        xmlResponse.put("success", successValue);
        xmlResponse.put("message", message);
        String xml = util.createXMLResponse(xmlResponse);

        //String xml = util.convertStringToXML(successValue, "success");

        return xml;
    }

    public String sendEmail() throws SQLException, ParserConfigurationException, TransformerException, IOException, AddressException{

        String subject  = request.getParameter("subject");
        //String msg      = request.getParameter("content");
        String encodedMessage = request.getParameter("content");
        String msg = util.decodeURIComponent(encodedMessage);
        String selall   = request.getParameter("selectFromDb");

        String emailIDs = "";

        // Select email ID's from db
        if (selall.equals("1") && selall != null) {

            String sql = Queries.getQuery("get_email_ids");
            PreparedStatement st = conn.prepareStatement(sql, com.mysql.jdbc.Statement.RETURN_GENERATED_KEYS);
            ResultSet rs = this.db.executeQueryPreparedStatement(st);
            while(rs.next()){
                // Append all the emailIDs separated by a space
                emailIDs = emailIDs + " " + rs.getString(1);
            }
            // For now for testing over-write all the emailIDs
            //emailIDs = "";
        }else {
            // Get Email ID's from user
            emailIDs = request.getParameter("to");
        }
        boolean success = true;
        Address[] toUser = InternetAddress.parse(emailIDs, false);
        String message = "Failed to send email to the following address:";

        ServletContext context          = ServletContextInfo.getServletContext();
        String emailPropertiesFile      = context.getRealPath("/WEB-INF/classes/jds_email.properties");
        Properties properties = new Properties();
        properties.load(new FileInputStream(emailPropertiesFile));

        msgsend sendMsg = new msgsend();
        for(Address s: toUser){
            //boolean success = sendMsg.sendMail("", "", emailIDs + " jds.ias.mails@gmail.com", subject, msg, "", "", null);
            logger.debug("Starting to send emails");
            String email = s.toString();
            // If message sending passed
            if(!sendMsg.sendMail(email, "", "jds.ias.mails@gmail.com", subject, msg, "", "", null)){
                success = false;
                message = message + " " + email;
            }
            logger.debug("Done sending emails");
        }

        String xml = "";
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
}
