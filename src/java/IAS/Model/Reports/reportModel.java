package IAS.Model.Reports;

import IAS.Bean.Reports.printOrderFormBeanReport;
import IAS.Bean.Reports.subscriptionFiguresFormBeanReport;
import IAS.Class.JDSLogger;
import IAS.Class.Queries;
import IAS.Class.util;
import IAS.Model.*;
import java.io.IOException;
import java.io.StringReader;
import java.io.StringWriter;
import java.lang.reflect.InvocationTargetException;
import java.sql.*;
import java.text.ParseException;
import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.apache.log4j.Logger;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

/**
 *
 * @author Deepali
 */
public class reportModel extends JDSModel {

    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Model.reports");

    public reportModel(HttpServletRequest request) throws SQLException {

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
        if (cs.execute()) {
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
        if (selall != null) {

            sql = Queries.getQuery("search_subtype_all");
        } else {
            sql = Queries.getQuery("search_subtype_prm");

            if (subType != null && subType.length() > 0) {
                sql += " subType=" + "'" + subType + "'";
                param = 1;
            }

            if (nationality != null && nationality.length() > 0) {
                if (param == 0) {
                    sql += " nationality =" + "'" + nationality + "'";
                    param = 1;
                } else {
                    sql += " and nationality =" + "'" + nationality + "'";
                }
            }

            if (institutional != null && institutional.length() > 0) {
                if (param == 0) {
                    sql += " institutional =" + "'" + institutional + "'";
                    param = 1;
                } else {
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

        if (city != null && city.compareToIgnoreCase("NULL") != 0 && city != null && city.length() > 0) {
            sql += " and t2.id = t1.city and t2.city = " + "\"" + city + "\"";
        }

        if (country != null && country.compareToIgnoreCase("NULL") != 0 && country.length() > 0) {
            sql += " and t7.id = t1.country and t7.country = " + "\"" + country + "\"";
        }

        if (state != null && state.compareToIgnoreCase("NULL") != 0 && state.length() > 0) {
            sql += " and t8.id = t1.state and t8.state = " + "\"" + state + "\"";
        }

        if (paymentMode != null && paymentMode.compareToIgnoreCase("NULL") != 0 && paymentMode.length() > 0) {
            sql += " and t6.id = t1.paymentMode and t6.paymentMode = " + "\"" + paymentMode + "\"";
        }

        if (currency != null && currency.compareToIgnoreCase("NULL") != 0 && currency.length() > 0) {
            sql += " and t5.id = t1.currency and t5.currency = " + "\"" + currency + "\"";
        }

        if (language != null && language.compareToIgnoreCase("NULL") != 0 && language.length() > 0) {
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
        while (rs.next()) {
            totalQueryCount = rs.getInt(1);
        }

        if (totalQueryCount > 0) {
            totalPages = (double) totalQueryCount / (double) pageSize;
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

        if (city != null && city.compareToIgnoreCase("NULL") != 0 && city != null && city.length() > 0) {
            sql += " and t2.id = t1.city and t2.city = " + "\"" + city + "\"";
        }

        if (country != null && country.compareToIgnoreCase("NULL") != 0 && country.length() > 0) {
            sql += " and t7.id = t1.country and t7.country = " + "\"" + country + "\"";
        }

        if (state != null && state.compareToIgnoreCase("NULL") != 0 && state.length() > 0) {
            sql += " and t8.id = t1.state and t8.state = " + "\"" + state + "\"";
        }

        if (paymentMode != null && paymentMode.compareToIgnoreCase("NULL") != 0 && paymentMode.length() > 0) {
            sql += " and t6.id = t1.paymentMode and t6.payment_mode = " + "\"" + paymentMode + "\"";
        }

        if (currency != null && currency.compareToIgnoreCase("NULL") != 0 && currency.length() > 0) {
            sql += " and t5.id = t1.currency and t5.currency = " + "\"" + currency + "\"";
        }

        if (language != null && language.compareToIgnoreCase("NULL") != 0 && language.length() > 0) {
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
        if (selall != null) {

            sql = Queries.getQuery("list_agent_all");
        } else {
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

            if (city != null && city.compareToIgnoreCase("NULL") != 0 && city != null && city.length() > 0) {
                sql += " t2.id = t1.cityId and t2.city = " + "'" + city + "'";
                param = 1;
            }

            if (country != null && country.compareToIgnoreCase("NULL") != 0 && country.length() > 0) {
                if (param == 1) {
                    sql += " and t5.id = t1.countryId and t5.country = " + "\"" + country + "\"";
                } else {
                    sql += " t5.id = t1.countryId and t5.country = " + "\"" + country + "\"";
                    param = 1;
                }
            }

            if (state != null && state.compareToIgnoreCase("NULL") != 0 && state.length() > 0) {
                if (param == 1) {
                    sql += " and t4.id = t1.stateId and t4.state = " + "\"" + state + "\"";
                } else {
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

        /*
         * Deepali insert query here int param = 0;
         *
         * if (selall != null){
         *
         * sql = Queries.getQuery("search_subtype_all"); } else { sql =
         * Queries.getQuery("search_subtype_prm");
         *
         * if (subType != null && subType.length() > 0) { sql += " subType=" +
         * "'" + subType + "'"; param = 1; }
         *
         * if (nationality != null && nationality.length() > 0) { if (param ==
         * 0){ sql += " nationality =" + "'" + nationality + "'"; param = 1; }
         * else{ sql += " and nationality =" + "'" + nationality + "'"; } }
         *
         * if (institutional != null && institutional.length() > 0) { if (param
         * == 0){ sql += " institutional =" + "'" + institutional + "'"; param =
         * 1; } else{ sql += " and institutional =" + "'" + institutional + "'";
         * } } sql += " order by id"; }
         *
         *
         */
        PreparedStatement stGet = conn.prepareStatement(sql);

        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        return rs;
    }

    public String statement() throws SQLException, ParseException, ParserConfigurationException, TransformerException, SAXException, IOException {
        String journalName = request.getParameter("journalName");
        String year = request.getParameter("year");
        String issue = request.getParameter("issue");

        if ("0".equals(journalName)) {
            journalName = null;
        }

        if ("0".equals(year)) {
            year = null;
        }

        if ("0".equals(issue)) {
            issue = null;
        }

        // Add the results element
        String xml = null;
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document doc = builder.newDocument();
        Element results = doc.createElement("results");
        doc.appendChild(results);

        String sql = null;
        sql = Queries.getQuery("journal_id");
        int paramIndex = 1;
        PreparedStatement stGet = conn.prepareStatement(sql);
        stGet.setString(paramIndex, request.getParameter("journalName"));
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        if (rs.next())
        {
            int totalNoOfSubscribers=0;
            int totalNoOfCopies=0;
            int journalId = 0;
            journalId = rs.getInt(1);
            String sqlSubType = null;
            sqlSubType = Queries.getQuery("subscriber_type");
            PreparedStatement stGetSubType = conn.prepareStatement(sqlSubType);
            ResultSet rsSubType = this.db.executeQueryPreparedStatement(stGetSubType);
            while (rsSubType.next())
            {
                Object value = null;
                String sqlStatement = null;
                sqlStatement = Queries.getQuery("statement");
                PreparedStatement stGetStatement = conn.prepareStatement(sqlStatement);
                paramIndex = 1;
                stGetStatement.setInt(paramIndex, journalId);
                stGetStatement.setString(++paramIndex, request.getParameter("issue"));
                stGetStatement.setString(++paramIndex, request.getParameter("year"));
                value = rsSubType.getObject(1);
                stGetStatement.setString(++paramIndex, value.toString());
                ResultSet rsStatement = this.db.executeQueryPreparedStatement(stGetStatement);

                String subtypecode = value.toString();
                int subCount = 0;
                int copies = 0;

                if (rsStatement.next())
                {

                    value = rsStatement.getObject(1);
                    subtypecode = value.toString();

                    value = rsStatement.getObject(2);
                    subCount = Integer.parseInt(value.toString());

                    value = rsStatement.getObject(3);
                    copies = Integer.parseInt(value.toString());
                    //System.out.println("Subs type: " + subtypecode + " Subs Count: " + subCount + " No of copies: " + copies);

                    totalNoOfSubscribers = totalNoOfSubscribers + subCount;
                    totalNoOfCopies = totalNoOfCopies + copies;
                }
                // Add the row element. Add information for all subscribers
                Element row = doc.createElement("row");
                results.appendChild(row);

                Element _subType = doc.createElement("subtypecode");
                row.appendChild(_subType);
                _subType.appendChild(doc.createTextNode(subtypecode));

                Element _subCount = doc.createElement("subCount");
                row.appendChild(_subCount);
                _subCount.appendChild(doc.createTextNode(Integer.toString(subCount)));

                Element _copies = doc.createElement("copies");
                row.appendChild(_copies);
                _copies.appendChild(doc.createTextNode(Integer.toString(copies)));
            }

            // Add the row element. Add the total number of copies and subscriber count here
            Element row = doc.createElement("row");
            results.appendChild(row);

            Element _subType = doc.createElement("subtypecode");
            row.appendChild(_subType);
            _subType.appendChild(doc.createTextNode("Total"));

            Element _subCount = doc.createElement("subCount");
            row.appendChild(_subCount);
            _subCount.appendChild(doc.createTextNode(Integer.toString(totalNoOfSubscribers)));

            Element _copies = doc.createElement("copies");
            row.appendChild(_copies);
            _copies.appendChild(doc.createTextNode(Integer.toString(totalNoOfCopies)));
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

    public ResultSet circulationFigures() throws SQLException, ParseException, ParserConfigurationException, TransformerException, SAXException, IOException {
        int year = Integer.parseInt(request.getParameter("year"));
        String proc;
        ResultSet rs = null;
        proc = "{call circulation_figures(?)}";
        CallableStatement cs = conn.prepareCall(proc);
        int paramIndex = 1;
        cs.setInt(paramIndex, year);
        if (cs.execute() == true) {
            String sql = Queries.getQuery("list_circulation_figures");
            PreparedStatement stGet = conn.prepareStatement(sql);
            rs = this.db.executeQueryPreparedStatement(stGet);
        }
        return rs;
    }

    public ResultSet searchCirculationFigures() throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String sql;
        sql = Queries.getQuery("list_circulation_figures");
        PreparedStatement stGet = conn.prepareStatement(sql);
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        return rs;
    }

 public ResultSet listMl() throws SQLException, ParseException, ParserConfigurationException, TransformerException, SAXException, IOException {
        String sql = Queries.getQuery("listml");
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;
        stGet.setString(paramIndex, request.getParameter("journalName"));
        stGet.setString(++paramIndex, request.getParameter("issue"));
        stGet.setString(++paramIndex, request.getParameter("year"));
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        return rs;
      }

 public ResultSet listBil() throws SQLException, ParseException, ParserConfigurationException, TransformerException, SAXException, IOException {
        String toDate = request.getParameter("to");
        String fromDate = request.getParameter("from");
        String subscriberType = request.getParameter("subscriberType");

        if ("0".equals(toDate)) {
            toDate = null;
        }

        if ("0".equals(fromDate)) {
            fromDate = null;
        }

        if ("0".equals(subscriberType)) {
            subscriberType = null;
        }

        String sql = null;
        sql = Queries.getQuery("listbil");


        if (subscriberType != null && subscriberType.length() > 0) {

                sql += " and subscriber_type.subtypedesc=" + "'" + subscriberType + "'";
        }

        if (fromDate != null && fromDate.length() > 0 && toDate != null && toDate.length() > 0) {
                sql += " and t1.bildate >=" + "'" + toDate + "'";
                sql += " and t1.bildate <=" + "'" + fromDate + "'";
        }
        int paramIndex = 1;
        PreparedStatement stGet = conn.prepareStatement(sql);
        stGet.setString(paramIndex, request.getParameter("journalName"));
        stGet.setString(++paramIndex, request.getParameter("issue"));
        stGet.setString(++paramIndex, request.getParameter("year"));
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        return rs;

      }


    /*
    public String printOrderTableDetails()
    {
        String colNames = "<colNames>" + "['Issue No','Print Order']" + "</colNames>";
        String colModel = "<colModel>" + "[{name:'issues', index:'issues', width:80, align:'center', xmlmap:'issues'},{name:'printOrder', index:'printOrder', width:80, align:'center',xmlmap:'printOrder'}]" +"</colModel>";
        String colData =  "<colData>";
        colData = colData + "[";
        colData = colData + "{<issues>10</issues>,<printOrder>10</printOrder>},";
        colData = colData + "{<issues>20</issues>,<printOrder>20</printOrder>}";
        colData = colData + "]";
        colData = colData + "</colData>";

        request.setAttribute("colNames", colNames);
        request.setAttribute("colData", colData);
        request.setAttribute("colModel", colModel);

        String xml="";
        return xml;
    }
    */

    public String printOrderTableDetails()
    {
        String xml = "";
        xml = xml + "<?xml version='1.0' encoding='utf-8'?>\n";

        xml = xml + "<results>";

        xml = xml + "<colNames>" + "['Issue No','Print Order']" + "</colNames>";
        xml = xml + "<colModel>" + "[{name:'issues', index:'issues', width:80, align:'center', xmlmap:'issues'},{name:'printOrder', index:'printOrder', width:80, align:'center',xmlmap:'printOrder'}]" +"</colModel>";

        xml = xml + "<colData>";
        xml = xml + "[";
        xml = xml + "{<issues>10</issues>,<printOrder>10</printOrder>},";
        xml = xml + "{<issues>20</issues>,<printOrder>20</printOrder>}";
        xml = xml + "]";
        xml = xml + "</colData>";

        xml = xml + "</results>";

        return(xml);
    }

    public String printOrderTableDetailsList() throws SQLException, IllegalAccessException, InvocationTargetException {

        printOrderFormBeanReport printOrderFormBeanReport = new IAS.Bean.Reports.printOrderFormBeanReport();
        request.setAttribute("printOrderFormBeanReport", printOrderFormBeanReport);
        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, printOrderFormBeanReport);

        int year = printOrderFormBeanReport.getYear();

        String sql = Queries.getQuery("get_max_no_of_issues");
        PreparedStatement st = conn.prepareStatement(sql);
        ResultSet rs = db.executeQueryPreparedStatement(st);
        int maxNoOfIssues = 0;
        if(rs.next()) {
            maxNoOfIssues = rs.getInt(1);
        }

        String xml = "";
        xml = xml + "<?xml version='1.0' encoding='utf-8'?>\n";
        xml = xml + "<results>";

        sql = Queries.getQuery("get_list_of_journals");
        st = conn.prepareStatement(sql);
        ResultSet rsLJ = db.executeQueryPreparedStatement(st);
        ResultSetMetaData rsmd = rsLJ.getMetaData();
        String colName = rsmd.getColumnName(1);

        while(rsLJ.next())
        {
            xml = xml + "<row>";
            String journalCode = rsLJ.getString(1);

            xml = xml + "<" + colName + ">" + journalCode + "</" + colName + ">";

            sql = Queries.getQuery("get_no_of_issues");
            st = conn.prepareStatement(sql);
            st.setString(1, journalCode);
            ResultSet rsNI = db.executeQueryPreparedStatement(st);
            int noOfIssues = 0;
            if(rsNI.next()) {
                noOfIssues = rsNI.getInt(1);
            }

            for(int i=1; i<=maxNoOfIssues; i++){

                if(i>noOfIssues)
                {
                    xml = xml + "<col" + i + ">" + "NA" + "</col" + i + ">";
                }else {
                    xml = xml + "<col" + i + ">";

                    sql = Queries.getQuery("get_print_order");
                    st = conn.prepareStatement(sql);
                    int paramIndex = 1;
                    st.setInt(paramIndex++, year);
                    st.setString(paramIndex++, journalCode);
                    st.setInt(paramIndex++, i);
                    ResultSet rsPO = db.executeQueryPreparedStatement(st);
                    String print_order = "";
                    if(rsPO.next()) {
                        print_order = Integer.toString(rsPO.getInt(1));
                    }
                    xml = xml + print_order;
                    xml = xml + "</col" + i + ">";
                }
            }
            xml = xml + "</row>";
        }
        xml = xml + "</results>";

        return(xml);
    }

    public void contructTableForPrintOrderReport() throws SQLException, ParserConfigurationException, SAXException, IOException, IllegalAccessException, InvocationTargetException {

        //printOrderFormBeanReport _printOrderFormBeanReport = new IAS.Bean.Reports.printOrderFormBeanReport();
        //request.setAttribute("printOrderFormBeanReport", _printOrderFormBeanReport);
        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        //FillBean(this.request, _printOrderFormBeanReport);

        String sql = Queries.getQuery("get_max_no_of_issues");
        PreparedStatement st = conn.prepareStatement(sql);
        ResultSet rs = db.executeQueryPreparedStatement(st);
        int maxNoOfIssues = 0;
        if(rs.next()) {
            maxNoOfIssues = rs.getInt(1);
        }

        String colNames = "['Journal',";
        String colModel = "[" + "{name:'journalCode', index:'journalCode', xmlmap:'journalCode'},";
        for(int i=1; i<=maxNoOfIssues; i++)
        {
            colNames = colNames + "'" + i + "'";
            colModel = colModel + "{name:'col" + i + "'," + "index:'col" + i + "'," + "align:'center'," +"xmlmap:'col" + i + "'}";

            if(i != maxNoOfIssues) {
                colNames = colNames + ",";
                colModel = colModel + ",";
            }

            if(i == maxNoOfIssues) {
                colNames = colNames + "]";
                colModel = colModel + "]";
            }
        }

        printOrderFormBeanReport _printOrderFormBeanReport = new IAS.Bean.Reports.printOrderFormBeanReport();
        _printOrderFormBeanReport.setColM(colModel);
        _printOrderFormBeanReport.setColN(colNames);
        request.setAttribute("printOrderFormBeanReport", _printOrderFormBeanReport);

    }

    public String printOrderTableDetailsTest()
    {
        String xml = "";
        xml = xml + "<?xml version='1.0' encoding='utf-8'?>\n";
        xml = xml + "<results>";
        //xml = xml + "<colData>"  + "</colData>";
        //xml = xml + "<colNames>" + "['Issue No','Print Order']" + "</colNames>";
        //xml = xml + "<colModel>" + "[{name:'issues', index:'issues', width:80, align:'center', xmlmap:'issues'},{name:'printOrder', index:'printOrder', width:80, align:'center',xmlmap:'printOrder'}]" +"</colModel>";
        //xml = xml + "<colModel>" + "[{name:'issues', index:'issues', xmlmap:'issues'},{name:'printOrder', index:'printOrder', xmlmap:'printOrder'}]" +"</colModel>";

        xml = xml + "<rows>";
        xml = xml + "<issues>" + "10" +"</issues>";
        xml = xml + "<printOrder>" + "20" + "</printOrder>";
        xml = xml + "</rows>";

        xml = xml + "<rows>";
        xml = xml + "<issues>" + "30" +"</issues>";
        xml = xml + "<printOrder>" + "40" + "</printOrder>";
        xml = xml + "</rows>";

        xml = xml + "</results>";

        return(xml);
    }

    public String subscriptionFigures() throws SQLException, ParseException, ParserConfigurationException, TransformerException, SAXException, IOException {

        // Add the results element
        String xml = null;
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document doc = builder.newDocument();
        Element results = doc.createElement("results");
        doc.appendChild(results);

        String sql = null;
        sql = Queries.getQuery("get_list_of_journals");
        PreparedStatement stGetJournals = this.conn.prepareStatement(sql);
        ResultSet rs1 = db.executeQueryPreparedStatement(stGetJournals);

        // Should be the size of the total no of subscribers
        //int[] tNoS = new int[16];
        //int[] tNoC = new int[16];

        while(rs1.next())
        {
            int totalNoOfSubscribers = 0;
            int totalNoOfCopies = 0;
            String journalCode = rs1.getString(1);

            // Add the row element
            Element row = doc.createElement("row");
            results.appendChild(row);

            Element _journalCode = doc.createElement("journalCode");
            row.appendChild(_journalCode);
            _journalCode.appendChild(doc.createTextNode(journalCode));

            String sqlSubType = null;
            sqlSubType = Queries.getQuery("subscriber_type");
            PreparedStatement stGetSubType = this.conn.prepareStatement(sqlSubType);
            ResultSet rs2 = db.executeQueryPreparedStatement(stGetSubType);

            //int k=0;

            while(rs2.next())
            {
                String subtypecode = rs2.getString(1);
                int paramIndex = 1;
                String sqlSubFigures = null;
                sqlSubFigures = Queries.getQuery("subscription_Figures");
                PreparedStatement stGetFigures = this.conn.prepareStatement(sqlSubFigures);
                stGetFigures.setString(paramIndex, journalCode);
                stGetFigures.setString(++paramIndex, subtypecode);
                ResultSet rs3 = db.executeQueryPreparedStatement(stGetFigures);
                int subscriberCount = 0;
                int copies = 0;
                if (rs3.next())
                {
                    subscriberCount = rs3.getInt(1);
                    copies = rs3.getInt(2);
                }
                //tNoS[k] = tNoS[k] + subscriberCount;
                //tNoC[k] = tNoC[k] + copies;

                totalNoOfSubscribers = totalNoOfSubscribers + subscriberCount;
                totalNoOfCopies = totalNoOfCopies + copies;

                Element _subType = doc.createElement(subtypecode + "-No");
                row.appendChild(_subType);
                _subType.appendChild(doc.createTextNode(Integer.toString(subscriberCount)));

                Element _subCount = doc.createElement(subtypecode + "-C");
                row.appendChild(_subCount);
                _subCount.appendChild(doc.createTextNode(Integer.toString(copies)));

                //k++;

                //System.out.println("Journal Code: " + journalCode + " -> subType Code: " + subtypecode + " -> Subscriber Count: " + subscriberCount + " -> Subscriber Copies: " + copies);
            }
            Element _subTypeTotal = doc.createElement("Total" + "-No");
            row.appendChild(_subTypeTotal);
            _subTypeTotal.appendChild(doc.createTextNode(Integer.toString(totalNoOfSubscribers)));

            Element _subCountTotal = doc.createElement("Total" + "-C");
            row.appendChild(_subCountTotal);
            _subCountTotal.appendChild(doc.createTextNode(Integer.toString(totalNoOfCopies)));

            /*
            if(rs1.isLast()) {
                Element _total = doc.createElement("Total");
                row.appendChild(_total);
                for(int j=0; j<16; j++) {
                    _total.appendChild(doc.createTextNode(Integer.toString(tNoS[j])));
                    _total.appendChild(doc.createTextNode(Integer.toString(tNoC[j])));
                }
            }
            */
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

        public void constructTableSubcriptionFigures() throws SQLException, ParserConfigurationException, SAXException, IOException, IllegalAccessException, InvocationTargetException {


        String sql = Queries.getQuery("subscriber_type");
        PreparedStatement st = conn.prepareStatement(sql);
        ResultSet rs = db.executeQueryPreparedStatement(st);
        int maxNoOfIssues = 0;

        String colNames = "['Journal',";
        String colModel = "[" + "{name:'journalCode', index:'journalCode', xmlmap:'journalCode'},";

        while(rs.next()) {
            String subtypecode = rs.getString(1);
            colNames = colNames + "'" + subtypecode + "-No'";
            colNames = colNames + ",";
            colNames = colNames + "'" + subtypecode + "-C'";
            colModel = colModel + "{name:'" + subtypecode + "-No'," + "index:'" + subtypecode + "-No'," + "align:'center'," +"xmlmap:'" + subtypecode + "-No'}";
            colModel = colModel + ",";
            colModel = colModel + "{name:'" + subtypecode + "-C'," + "index:'" + subtypecode + "-C'," + "align:'center'," +"xmlmap:'" + subtypecode + "-C'}";

            if(rs.isLast() == false) {
                colNames = colNames + ",";
                colModel = colModel + ",";
            }
            else {
                colNames = colNames + ",'Total-No'";
                colNames = colNames + ",";
                colNames = colNames + "'Total-C'";

                colModel = colModel + ",{name:'" + "Total" + "-No'," + "index:'" + "Total" + "-No'," + "align:'center'," +"xmlmap:'" + "Total" + "-No'}";
                colModel = colModel + ",";
                colModel = colModel + "{name:'" + "Total" + "-C'," + "index:'" + "Total" + "-C'," + "align:'center'," +"xmlmap:'" + "Total" + "-C'}";

                colNames = colNames + "]";
                colModel = colModel + "]";
            }
        }

        subscriptionFiguresFormBeanReport _subscriptionFiguresFormBeanReport = new IAS.Bean.Reports.subscriptionFiguresFormBeanReport();
        _subscriptionFiguresFormBeanReport.setColM(colModel);
        _subscriptionFiguresFormBeanReport.setColN(colNames);
        request.setAttribute("subscriptionFiguresFormBeanReport", _subscriptionFiguresFormBeanReport);

    }


}
