package IAS.Model.missingissue;

import IAS.Model.missingissue.*;
import IAS.Model.missingissue.missingissueModel;
import IAS.Bean.missingissue.milFormBean;
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
import java.io.StringWriter;
import java.lang.reflect.InvocationTargetException;
import javax.xml.parsers.ParserConfigurationException;
import java.text.ParseException;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

/**
 *
 * @author aloko
 */
public class milModel extends JDSModel {

    private milFormBean _milFormBean = null;
    private missingissueModel _missingissueModel = null;
    private static final Logger logger = JDSLogger.getJDSLogger(milModel.class.getName());
    private Connection conn;

    public milModel(HttpServletRequest request) throws SQLException {

        super(request);
        conn = this.getConnection();
    }

    public String generate() throws IllegalAccessException, ParseException,
            ParserConfigurationException, SQLException, TransformerException,
            IOException, InvocationTargetException, Exception {
        
        String xml = null;
        xml = updateAction();
        return xml;
    }
    
    public String updateAction() throws IllegalAccessException, ParseException,
            ParserConfigurationException, SQLException, TransformerException,
            IOException, InvocationTargetException, Exception {
        
        String xml = "";
        String fromDate = request.getParameter("from");
        String toDate = request.getParameter("to");
        String subscriberNumber = request.getParameter("subscriberNumber");
        if ("0".equals(fromDate)) {
            fromDate = null;
        }
        if ("0".equals(toDate)) {
            toDate = null;
        }
        if ("0".equals(subscriberNumber)) {
            subscriberNumber = null;
        }
        
        String sql = null;
        if (subscriberNumber != null && subscriberNumber.compareToIgnoreCase("NULL") != 0 && subscriberNumber.length() > 0){
            sql = Queries.getQuery("get_missing_issue_id_by_sub");
        }
        else {
            sql = Queries.getQuery("get_missing_issue_id_by_date");
            sql += " and missing_issue.msEntryDate between " + "STR_TO_DATE(" + '"' + fromDate + '"' + ",'%d/%m/%Y')" + " and " + "STR_TO_DATE(" + '"' + toDate + '"' + ",'%d/%m/%Y')";
        }        
 
        PreparedStatement stGet = conn.prepareStatement(sql);
        if (subscriberNumber != null && subscriberNumber.compareToIgnoreCase("NULL") != 0 && subscriberNumber.length() > 0){
            stGet.setString(1, subscriberNumber);
        }   
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        int miJlId = 0;
        int mailingid = 0;
        int miId = 0;
        
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document doc = builder.newDocument();
        Element results = doc.createElement("results");
        doc.appendChild(results);
        
        while (rs.next()) {

            Object value = null;
            value = rs.getObject(1);
            miJlId = Integer.parseInt(value.toString());
            value = rs.getObject(2);
            miId = Integer.parseInt(value.toString());  
            value = rs.getObject(3);
            mailingid = Integer.parseInt(value.toString());   
            if ( mailingid == 0){                
                mailingid = addToMailingList(miJlId);
                setAction ("M", miJlId);
                updateMailingInfo(miJlId, mailingid);
            }
            else {
                setAction ("R", miJlId);
            }  
            
            ResultSet rsGet = getList(miJlId);
            
             while (rsGet.next()){
            //Extract subscriber Details
                int id    = rsGet.getInt(1);
                int mailinglistid            = rsGet.getInt(2);
                subscriberNumber = rsGet.getString(3);
                String subscriberName = rsGet.getString(4);
                String journalCode    = rsGet.getString(5);
                String journalName    = rsGet.getString(6);
                int year    = rsGet.getInt(7);
                int volumeNo    = rsGet.getInt(8);
                int issue    = rsGet.getInt(9);
                int missingCopies    = rsGet.getInt(10);


                // Add the row element
                
                Element missingissue = doc.createElement("row");
                results.appendChild(missingissue);

                Element _id = doc.createElement("id");
                missingissue.appendChild(_id);
                _id.appendChild(doc.createTextNode(Integer.toString(id)));

                Element _mailinglistid = doc.createElement("mailinglistid");
                missingissue.appendChild(_mailinglistid);
                _mailinglistid.appendChild(doc.createTextNode(Integer.toString(mailinglistid)));

                Element _subscriberNumber = doc.createElement("subscriberNumber");
                missingissue.appendChild(_subscriberNumber);
                _subscriberNumber.appendChild(doc.createTextNode(subscriberNumber));

                Element _subscriberName = doc.createElement("subscriberName");
                missingissue.appendChild(_subscriberName);
                _subscriberName.appendChild(doc.createTextNode(subscriberName));

                Element _journalCode = doc.createElement("journalCode");
                missingissue.appendChild(_journalCode);
                _journalCode.appendChild(doc.createTextNode(journalCode));

                Element _journalName = doc.createElement("journalName");
                missingissue.appendChild(_journalName);
                _journalName.appendChild(doc.createTextNode(journalName));

                Element _year = doc.createElement("year");
                missingissue.appendChild(_year);
                _year.appendChild(doc.createTextNode(Integer.toString(year)));

                Element _volumeNo = doc.createElement("volumeNo");
                missingissue.appendChild(_volumeNo);
                _volumeNo.appendChild(doc.createTextNode(Integer.toString(volumeNo)));   

                Element _issue = doc.createElement("issue");
                missingissue.appendChild(_issue);
                _issue.appendChild(doc.createTextNode(Integer.toString(issue)));

                Element _missingCopies = doc.createElement("missingCopies");
                missingissue.appendChild(_missingCopies);
                _missingCopies.appendChild(doc.createTextNode(Integer.toString(missingCopies)));   
            }
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
    
    public ResultSet getList(int miJlId) throws IllegalAccessException, ParseException,
            ParserConfigurationException, SQLException, TransformerException,
            IOException, InvocationTargetException, Exception {
        
        String xml = "";
        String sql = null;      
        sql = Queries.getQuery("get_missing_journals_by_mid");
        PreparedStatement stGet = conn.prepareStatement(sql);        
        stGet.setInt(1, miJlId); 
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        //xml = util.convertResultSetToXML(rs);
        return rs;
    }
    
    public void setAction(String action, int miJlId) throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml = null;
        String sql = Queries.getQuery("update_missing_journal_action");
        PreparedStatement st = conn.prepareStatement(sql);
        int paramIndex = 1;
        st.setString(paramIndex, action);
        st.setInt(++paramIndex, miJlId);
        db.executeUpdatePreparedStatement(st);
    }
    
    public void updateMailingInfo(int miJlId, int mailingId) throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml = null;
        String sql = Queries.getQuery("update_missing_journal_ml");
        PreparedStatement st = conn.prepareStatement(sql);
        int paramIndex = 1;
        st.setInt(paramIndex, mailingId);
        st.setInt(++paramIndex, miJlId);
        db.executeUpdatePreparedStatement(st);
    }
    
    public int addToMailingList(int miJlId) throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        int mailingid = 0;
        
        String sqlInsMil = Queries.getQuery("insert_mldtl_mil");
        PreparedStatement stInsMlMil = conn.prepareStatement(sqlInsMil);
        
        String sql = Queries.getQuery("generate_ml_insert");
        PreparedStatement st = conn.prepareStatement(sql);
        
        int paramIndex = 1;
        st.setInt(paramIndex, miJlId);
        ResultSet rs = this.db.executeQueryPreparedStatement(st);
        while (rs.next()) {
            // insert record by record to mailing list
            String milid = null;
            paramIndex = 0;
            Object value = null;
            for (int j = 1; j <= 27; j++) {
                value = rs.getObject(j);
                if (value == null) {
                    stInsMlMil.setString(++paramIndex, "");
                } else {
                    stInsMlMil.setString(++paramIndex, value.toString());
                }
                if (j == 27) {
                    milid = value.toString();
                }
            }
            //stInsMlMil.setDate(++paramIndex, util.dateStringToSqlDate(request.getParameter("milCreationDate")));
            mailingid = stInsMlMil.executeUpdate();
            try
            {
                if (db.executeUpdatePreparedStatement(stInsMlMil) == 1) {
                    try (ResultSet rsIns = stInsMlMil.getGeneratedKeys()) {
                        while(rsIns.next()){
                            mailingid = rsIns.getInt(1);                            
                        }
                    }
                }
            }catch (Exception MySQLIntegrityConstraintViolationException)
            {
                logger.error(MySQLIntegrityConstraintViolationException.getMessage(), MySQLIntegrityConstraintViolationException);
            }            
        }        
        return mailingid;
    }    

    public ResultSet printmil() throws IllegalAccessException, ParseException,
            ParserConfigurationException, SQLException, TransformerException,
            IOException, InvocationTargetException, Exception {
        
        String xml = "";
        String fromDate = request.getParameter("from");
        String toDate = request.getParameter("to");
        String subscriberNumber = request.getParameter("subscriberNumber");
        int miId[] = util.convertStringArraytoIntArray(request.getParameterValues("miId"));
        String mailing = request.getParameter("mailingids");
//        if ("0".equals(fromDate)) {
//            fromDate = null;
//        }
//        if ("0".equals(toDate)) {
//            toDate = null;
//        }
//        if ("0".equals(subscriberNumber)) {
//            subscriberNumber = null;
//        }
//        
        String sql = null;
        sql = Queries.getQuery("print_mi_ml");
        sql = sql + " and missing_issue_journals.id in (";
//        for (int i = 0; i < miId.length; i++){
//            
//            mailing += miId[i];
//            if(i != miId.length-1) {
//                mailing = mailing + ",";
//            }
//        } 
        sql = sql + mailing +")";
        PreparedStatement stGet = conn.prepareStatement(sql);
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);       
        return rs;
    }
 
    public String getIds() throws IllegalAccessException, ParseException,
            ParserConfigurationException, SQLException, TransformerException,
            IOException, InvocationTargetException, Exception {
        
        String xml = "";
        int miId[] = util.convertStringArraytoIntArray(request.getParameterValues("miId"));
        String mailing = "";

        for (int i = 0; i < miId.length; i++){
            
            mailing += miId[i];
            if(i != miId.length-1) {
                mailing = mailing + ",";
            }
        } 
     
        return mailing;
    }
    
    public String search() throws IllegalAccessException, ParseException,
            ParserConfigurationException, SQLException, TransformerException,
            IOException, InvocationTargetException, Exception {
        
        String xml = "";
        String fromDate = request.getParameter("from");
        String toDate = request.getParameter("to");
        String subscriberNumber = request.getParameter("subscriberNumber");
        if ("0".equals(fromDate)) {
            fromDate = null;
        }
        if ("0".equals(toDate)) {
            toDate = null;
        }
        if ("0".equals(subscriberNumber)) {
            subscriberNumber = null;
        }
        
        String sql = null;
        if (subscriberNumber != null && subscriberNumber.compareToIgnoreCase("NULL") != 0 && subscriberNumber.length() > 0){
            sql = Queries.getQuery("retrieve_missing_issue_id_by_sub");
        }
        else {
            sql = Queries.getQuery("retrieve_missing_issue_id_by_date");
            sql += " and missing_issue.msEntryDate between " + "STR_TO_DATE(" + '"' + fromDate + '"' + ",'%d/%m/%Y')" + " and " + "STR_TO_DATE(" + '"' + toDate + '"' + ",'%d/%m/%Y')";
        }        
 
        PreparedStatement stGet = conn.prepareStatement(sql);
        if (subscriberNumber != null && subscriberNumber.compareToIgnoreCase("NULL") != 0 && subscriberNumber.length() > 0){
            stGet.setString(1, subscriberNumber);
        }   
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        int miJlId = 0;
        int mailingid = 0;
        int miId = 0;
        
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document doc = builder.newDocument();
        Element results = doc.createElement("results");
        doc.appendChild(results);
        
        while (rs.next()) {

            Object value = null;
            value = rs.getObject(1);
            miJlId = Integer.parseInt(value.toString());
            value = rs.getObject(2);
            miId = Integer.parseInt(value.toString());  
            value = rs.getObject(3);
            mailingid = Integer.parseInt(value.toString());   
            
            ResultSet rsGet = getList(miJlId);
            
             while (rsGet.next()){
            //Extract subscriber Details
                int id    = rsGet.getInt(1);
                int mailinglistid            = rsGet.getInt(2);
                subscriberNumber = rsGet.getString(3);
                String subscriberName = rsGet.getString(4);
                String journalCode    = rsGet.getString(5);
                String journalName    = rsGet.getString(6);
                int year    = rsGet.getInt(7);
                int volumeNo    = rsGet.getInt(8);
                int issue    = rsGet.getInt(9);
                int missingCopies    = rsGet.getInt(10);

                // Add the row element
                
                Element missingissue = doc.createElement("row");
                results.appendChild(missingissue);

                Element _id = doc.createElement("id");
                missingissue.appendChild(_id);
                _id.appendChild(doc.createTextNode(Integer.toString(id)));

                Element _mailinglistid = doc.createElement("mailinglistid");
                missingissue.appendChild(_mailinglistid);
                _mailinglistid.appendChild(doc.createTextNode(Integer.toString(mailinglistid)));

                Element _subscriberNumber = doc.createElement("subscriberNumber");
                missingissue.appendChild(_subscriberNumber);
                _subscriberNumber.appendChild(doc.createTextNode(subscriberNumber));

                Element _subscriberName = doc.createElement("subscriberName");
                missingissue.appendChild(_subscriberName);
                _subscriberName.appendChild(doc.createTextNode(subscriberName));

                Element _journalCode = doc.createElement("journalCode");
                missingissue.appendChild(_journalCode);
                _journalCode.appendChild(doc.createTextNode(journalCode));

                Element _journalName = doc.createElement("journalName");
                missingissue.appendChild(_journalName);
                _journalName.appendChild(doc.createTextNode(journalName));

                Element _year = doc.createElement("year");
                missingissue.appendChild(_year);
                _year.appendChild(doc.createTextNode(Integer.toString(year)));

                Element _volumeNo = doc.createElement("volumeNo");
                missingissue.appendChild(_volumeNo);
                _volumeNo.appendChild(doc.createTextNode(Integer.toString(volumeNo)));   

                Element _issue = doc.createElement("issue");
                missingissue.appendChild(_issue);
                _issue.appendChild(doc.createTextNode(Integer.toString(issue)));

                Element _missingCopies = doc.createElement("missingCopies");
                missingissue.appendChild(_missingCopies);
                _missingCopies.appendChild(doc.createTextNode(Integer.toString(missingCopies)));   
            }
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
}