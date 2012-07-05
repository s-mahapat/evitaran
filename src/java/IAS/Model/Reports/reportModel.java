
package IAS.Model.Reports;

import javax.servlet.http.HttpServletRequest;
import java.sql.*;
import IAS.Model.*;
import java.text.ParseException;
import IAS.Class.Queries;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import IAS.Class.util;
import org.apache.log4j.Logger;
import IAS.Class.JDSLogger;
import java.io.IOException;
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
import java.io.StringReader;
import java.io.StringWriter;
/**
 *
 * @author Deepali
 */
public class reportModel extends JDSModel{

    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Model.reports");

    public reportModel(HttpServletRequest request) throws SQLException{

       super(request);

    }

    public ResultSet listRates() throws SQLException, ParseException, ParserConfigurationException, TransformerException {

        int year = Integer.parseInt(request.getParameter("year"));
        String proc = null;
        ResultSet rs = null;
        proc = "{call cir_subscription_rates(?, ?)}";
        CallableStatement cs = conn.prepareCall(proc);
        int paramIndex = 1;        
        cs.setInt(paramIndex, year);
        cs.setString(++paramIndex, request.getParameter("subscriberType"));
        int rscs = cs.executeUpdate();
        if (rscs == 1){
        String sql = Queries.getQuery("rep_sub_rate");        
        PreparedStatement stGet = conn.prepareStatement(sql);
        rs = this.db.executeQueryPreparedStatement(stGet);
        }
        return rs;
    }

    public ResultSet searchJournalGroup() throws SQLException, ParseException, ParserConfigurationException, TransformerException {

        String sql;
        String journalGroupName = request.getParameter("journalGroupName");
        if ("0".equals(journalGroupName)) {
            journalGroupName = null;
        }

        sql = Queries.getQuery("list_journal_group");
        sql += "  t2.journalGroupName =" + "'" + journalGroupName + "'";

        PreparedStatement stGet = conn.prepareStatement(sql);
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        return rs;
    }

    public ResultSet searchSubType() throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml = null;
        String subType = request.getParameter("subtype");
        String nationality = request.getParameter("nationality");
        String institutional = request.getParameter("institutional");
        String selall = request.getParameter("selall");
        String sql;
        int param = 0;
        if ("0".equals(selall)) {
                selall = null;
            }
        if (selall != null){

            sql = Queries.getQuery("search_subtype_all");
        }
        else {
            sql = Queries.getQuery("search_subtype_prm");

            if (subType != null && subType.length() > 0) {
                sql += " subType=" + "'" + subType + "'";
                param = 1;
            }

            if (nationality != null && nationality.length() > 0) {
                if (param == 0){
                    sql += " nationality =" + "'" + nationality + "'";
                    param = 1;
                }
                else{
                    sql += " and nationality =" + "'" + nationality + "'";
                }
            }

            if (institutional != null && institutional.length() > 0) {
                 if (param == 0){
                    sql += " institutional =" + "'" + institutional + "'";
                    param = 1;
                }
                else{
                    sql += " and institutional =" + "'" + institutional + "'";
                }
            }
            sql += " order by id";
        }

        PreparedStatement stGet = conn.prepareStatement(sql);

        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        return rs;
        //xml = util.convertResultSetToXML(rs);
        //return xml;
    }

     public String searchInwards() throws SQLException, ParseException, ParserConfigurationException, TransformerException, SAXException, IOException {
        String xml = null;
        String sql = Queries.getQuery("search_inward");
        String city = request.getParameter("city");
        String country = request.getParameter("country");
        String state = request.getParameter("state");
        String currency = request.getParameter("currency");
        String language = request.getParameter("language");
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        String inwardPurpose = request.getParameter("inwardPurpose");
        String paymentMode = request.getParameter("paymentMode");
        int pageNumber = Integer.parseInt(request.getParameter("page"));
        int pageSize = Integer.parseInt(request.getParameter("rows"));
        String orderBy = request.getParameter("sidx");
        String sortOrder = request.getParameter("sord");
        int totalQueryCount = 0;
        double totalPages = 0;
        if ("0".equals(city)) {
            city = null;
        }
        if ("0".equals(country)) {
            country = null;
        }
        if ("0".equals(state)) {
            state = null;
        }
        if ("0".equals(currency)) {
            currency = null;
        }
        if ("0".equals(language)) {
            language = null;
        }
        if ("0".equals(inwardPurpose)) {
            city = null;
        }
        if ("0".equals(paymentMode)) {
            paymentMode = null;
        }
        if (inwardPurpose != null && inwardPurpose.compareToIgnoreCase("NULL") != 0 && inwardPurpose.length() > 0) {
            sql += " and t3.purpose =" + "'" + inwardPurpose + "'";
        }

        if (city != null && city.compareToIgnoreCase("NULL") != 0  && city != null && city.length() > 0) {
            sql += " and t2.id = t1.city and t2.city = " + "\"" + city + "\"";
        }

        if (country != null && country.compareToIgnoreCase("NULL") != 0  && country.length() > 0) {
            sql += " and t7.id = t1.country and t7.country = " + "\"" + country + "\"";
        }

        if (state != null && state.compareToIgnoreCase("NULL") != 0  && state.length() > 0) {
            sql += " and t8.id = t1.state and t8.state = " + "\"" + state + "\"";
        }

        if (paymentMode != null && paymentMode.compareToIgnoreCase("NULL") != 0  && paymentMode.length() > 0) {
            sql += " and t6.id = t1.paymentMode and t6.paymentMode = " + "\"" + paymentMode + "\"";
        }

        if (currency != null && currency.compareToIgnoreCase("NULL") != 0  && currency.length() > 0) {
            sql += " and t5.id = t1.currency and t5.currency = " + "\"" + currency + "\"";
        }

        if (language != null && language.compareToIgnoreCase("NULL") != 0  && language.length() > 0) {
            sql += " and language = " + "\"" + language + "\"";
        }

        if (fromDate != null && fromDate.length() > 0 && toDate != null && toDate.length() > 0) {
            sql += " and inwardCreationDate between " + "STR_TO_DATE(" + '"' + fromDate + '"' + ",'%d/%m/%Y')" + " and " + "STR_TO_DATE(" + '"' + toDate + '"' + ",'%d/%m/%Y')";
        }

        sql += " group by inwardNumber, subscriberId, t1.from, inwardCreationDate, city, chqddNumber, inwardPurpose order by " + orderBy + " " + sortOrder;
        ResultSet rs = this.db.executeQueryPreparedStatementWithPages(sql, pageNumber, pageSize);//this.db.executeQuery(sql);
        xml = util.convertResultSetToXML(rs);

        sql = "select count(*) from (" + sql + ") as tbl";
        rs = this.db.executeQuery(sql);
        while(rs.next()){
            totalQueryCount = rs.getInt(1);
        }

        if(totalQueryCount > 0){
            totalPages = (double)totalQueryCount/(double)pageSize;
            totalPages = java.lang.Math.ceil(totalPages);
        }
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        InputSource is = new InputSource(new StringReader(xml));
        Document doc = builder.parse(is);
        Element root = doc.getDocumentElement();

        Element page = doc.createElement("page");
        Element total = doc.createElement("total");
        Element records = doc.createElement("records");

        root.appendChild(page);
        page.appendChild(doc.createTextNode(String.valueOf(pageNumber)));

        root.appendChild(total);
        total.appendChild(doc.createTextNode(String.valueOf(totalPages)));

        root.appendChild(records);
        records.appendChild(doc.createTextNode(String.valueOf(totalQueryCount)));

        DOMSource domSource = new DOMSource(doc);
        StringWriter writer = new StringWriter();
        StreamResult result = new StreamResult(writer);
        TransformerFactory tf = TransformerFactory.newInstance();
        Transformer transformer = tf.newTransformer();
        transformer.transform(domSource, result);
        xml = writer.toString();
        writer.close();


        return xml;
    }

     public ResultSet searchInwardsAll() throws SQLException, ParseException, ParserConfigurationException, TransformerException, SAXException, IOException {

        String sql = Queries.getQuery("search_inward");
        String city = request.getParameter("city");
        String country = request.getParameter("country");
        String state = request.getParameter("state");
        String currency = request.getParameter("currency");
        String language = request.getParameter("language");
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        String inwardPurpose = request.getParameter("inwardPurpose");
        String paymentMode = request.getParameter("paymentMode");

        if ("0".equals(city)) {
            city = null;
        }
        if ("0".equals(country)) {
            country = null;
        }
        if ("0".equals(state)) {
            state = null;
        }
        if ("0".equals(currency)) {
            currency = null;
        }
        if ("0".equals(language)) {
            language = null;
        }
        if ("0".equals(inwardPurpose)) {
            inwardPurpose = null;
        }
        if ("0".equals(paymentMode)) {
            paymentMode = null;
        }
        if (inwardPurpose != null && inwardPurpose.compareToIgnoreCase("NULL") != 0 && inwardPurpose.length() > 0) {
            sql += " and t3.purpose =" + "'" + inwardPurpose + "'";
        }

        if (city != null && city.compareToIgnoreCase("NULL") != 0  && city != null && city.length() > 0) {
            sql += " and t2.id = t1.city and t2.city = " + "\"" + city + "\"";
        }

        if (country != null && country.compareToIgnoreCase("NULL") != 0  && country.length() > 0) {
            sql += " and t7.id = t1.country and t7.country = " + "\"" + country + "\"";
        }

        if (state != null && state.compareToIgnoreCase("NULL") != 0  && state.length() > 0) {
            sql += " and t8.id = t1.state and t8.state = " + "\"" + state + "\"";
        }

        if (paymentMode != null && paymentMode.compareToIgnoreCase("NULL") != 0  && paymentMode.length() > 0) {
            sql += " and t6.id = t1.paymentMode and t6.payment_mode = " + "\"" + paymentMode + "\"";
        }

        if (currency != null && currency.compareToIgnoreCase("NULL") != 0  && currency.length() > 0) {
            sql += " and t5.id = t1.currency and t5.currency = " + "\"" + currency + "\"";
        }

        if (language != null && language.compareToIgnoreCase("NULL") != 0  && language.length() > 0) {
            sql += " and language = (select id from languages where language=" + "\"" + language + "\")";
        }

        if (fromDate != null && fromDate.length() > 0 && toDate != null && toDate.length() > 0) {
            sql += " and inwardCreationDate between " + "STR_TO_DATE(" + '"' + fromDate + '"' + ",'%d/%m/%Y')" + " and " + "STR_TO_DATE(" + '"' + toDate + '"' + ",'%d/%m/%Y')";
        }

        sql += " group by inwardNumber, subscriberId, t1.from, inwardCreationDate, city, chqddNumber, inwardPurpose";
        PreparedStatement stGet = conn.prepareStatement(sql);
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);//this.db.executeQuery(sql);

        //sql = "select count(*) from (" + sql + ") as tbl";
        //rs = this.db.executeQuery(sql);

        return rs;
    }

     public ResultSet searchAgents() throws SQLException, ParseException, ParserConfigurationException, TransformerException, SAXException, IOException {
        String xml = null;
        String sql;
        String city = request.getParameter("city");
        String country = request.getParameter("country");
        String state = request.getParameter("state");
        String selall = request.getParameter("selall");
        int param = 0;

        if ("0".equals(selall)) {
                selall = null;
            }
        if (selall != null){

            sql = Queries.getQuery("list_agent_all");
        }
        else {
            sql = Queries.getQuery("list_agent_prm");
            if ("0".equals(city)) {
                city = null;
            }
            if ("0".equals(country)) {
                country = null;
            }
            if ("0".equals(state)) {
                state = null;
            }

            if (city != null && city.compareToIgnoreCase("NULL") != 0  && city != null && city.length() > 0) {
                sql += " t2.id = t1.cityId and t2.city = " + "'" + city + "'";
                param = 1;
            }

            if (country != null && country.compareToIgnoreCase("NULL") != 0  && country.length() > 0) {
                if (param == 1) {
                    sql += " and t5.id = t1.countryId and t5.country = " + "\"" + country + "\"";
                }else {
                    sql += " t5.id = t1.countryId and t5.country = " + "\"" + country + "\"";
                    param = 1;
                }
            }

            if (state != null && state.compareToIgnoreCase("NULL") != 0  && state.length() > 0) {
                if (param == 1) {
                    sql += " and t4.id = t1.stateId and t4.state = " + "\"" + state + "\"";
                }else {
                    sql += " t4.id = t1.stateId and t4.state = " + "\"" + state + "\"";
                    param = 1;
                }
            }
        }
        PreparedStatement stGet = conn.prepareStatement(sql);

        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        return rs;
    }

 public ResultSet searchSubscriber() throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml = null;

        String subType = request.getParameter("subtype");
        String nationality = request.getParameter("nationality");
        String institutional = request.getParameter("institutional");
        String subscriberType = request.getParameter("subscriberType");
        String journalGroupName = request.getParameter("journalGroupName");
        String country = request.getParameter("country");
        String state = request.getParameter("state");
        String city = request.getParameter("city");
        String fromDate = request.getParameter("from");
        String toDate = request.getParameter("to");

        String sql = null;

         /* Deepali insert query here
        int param = 0;

        if (selall != null){

            sql = Queries.getQuery("search_subtype_all");
        }
        else {
            sql = Queries.getQuery("search_subtype_prm");

            if (subType != null && subType.length() > 0) {
                sql += " subType=" + "'" + subType + "'";
                param = 1;
            }

            if (nationality != null && nationality.length() > 0) {
                if (param == 0){
                    sql += " nationality =" + "'" + nationality + "'";
                    param = 1;
                }
                else{
                    sql += " and nationality =" + "'" + nationality + "'";
                }
            }

            if (institutional != null && institutional.length() > 0) {
                 if (param == 0){
                    sql += " institutional =" + "'" + institutional + "'";
                    param = 1;
                }
                else{
                    sql += " and institutional =" + "'" + institutional + "'";
                }
            }
            sql += " order by id";
        }

         *
         */
        PreparedStatement stGet = conn.prepareStatement(sql);

        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        return rs;
    }

      public ResultSet statement() throws SQLException, ParseException, ParserConfigurationException, TransformerException, SAXException, IOException {

        String journalName = request.getParameter("journalName");
        String year = request.getParameter("year");
        String subscriberType = request.getParameter("subscriberType");

        if ("0".equals(journalName)) {
            journalName = null;
        }

        if ("0".equals(year)) {
            year = null;
        }

        if ("0".equals(subscriberType)) {
            subscriberType = null;
        }

        String sql = null;
        sql = Queries.getQuery("statement");
        int param = 0;

        if (journalName != null && journalName.length() > 0) {
            sql += " journals.journalName=" + "'" + journalName + "'";
            param = 1;
        }

        if (subscriberType != null && subscriberType.length() > 0) {
            if (param == 0){
                sql += " subscriber_type.subtypedesc=" + "'" + subscriberType + "'";
                param = 1;
            }
            else{
                sql += " and subscriber_type.subtypedesc=" + "'" + subscriberType + "'";
            }
        }

        if (year != null && year.length() > 0) {
             if (param == 0){
                sql += " subscriptiondetails.startYear <=" + "'" + year + "'";
                sql += " and subscriptiondetails.endYear >=" + "'" + year + "'";
                param = 1;
            }
            else{
                sql += " and subscriptiondetails.startYear <=" + "'" + year + "'";
                sql += " and subscriptiondetails.endYear >=" + "'" + year + "'";
            }
        }

        sql += " group by  subscriber_type.subtypecode, journals.journalCode";
        sql += " order by journals.journalCode, subscriber_type.subtypecode";

        PreparedStatement stGet = conn.prepareStatement(sql);
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        return rs;
      }

      public ResultSet circulationFigures() throws SQLException, ParseException, ParserConfigurationException, TransformerException, SAXException, IOException {
        int year = Integer.parseInt(request.getParameter("year"));
        String proc = null;
        ResultSet rs = null;
        proc = "{call circulation_figures(?)}";
        CallableStatement cs = conn.prepareCall(proc);
        int paramIndex = 1;        
        cs.setInt(paramIndex, year);
        int rscs = cs.executeUpdate();
        if (rscs == 1){
        String sql = Queries.getQuery("list_circulation_figures");        
        PreparedStatement stGet = conn.prepareStatement(sql);
        rs = this.db.executeQueryPreparedStatement(stGet);
        }
        return rs;
      }

 public ResultSet searchCirculationFigures() throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml = null;
        String sql;
        sql = Queries.getQuery("list_circulation_figures");
        PreparedStatement stGet = conn.prepareStatement(sql);
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        return rs;
    }
}

