package IAS.Model.Reports;

import IAS.Bean.Reports.printOrderFormBeanReport;
import IAS.Bean.Reports.subscriptionFiguresFormBeanReport;
import IAS.Bean.Reports.subscriptionRatesFormBeanReport;
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
import java.util.Calendar;
import java.util.Date;
import javax.xml.transform.TransformerConfigurationException;
/**
 *
 * @author Deepali
 */
public class reportModel extends JDSModel {

    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Model.reports");
    private Connection conn;

    public reportModel(HttpServletRequest request) throws SQLException {

        super(request);
        this.conn = this.getConnection();

    }

    public String getRatesXML(int year, String subscriberType) throws ParserConfigurationException, SQLException, TransformerConfigurationException, TransformerException, IOException {
        String xml = null;
        String proc = null;
        int journalGpId = 0;
        String journalGroup = null;
        int period = 0;
        int rate = 0;
        int count = 1;

        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document doc = builder.newDocument();
        Element results = doc.createElement("results");
        doc.appendChild(results);

        String sqlJournalGrp = Queries.getQuery("journal_groups");
        PreparedStatement stGetJGrp = conn.prepareStatement(sqlJournalGrp);
        ResultSet rsJGrp = this.db.executeQueryPreparedStatement(stGetJGrp);
        while (rsJGrp.next()){
            journalGpId = rsJGrp.getInt(1);
            journalGroup = rsJGrp.getString(2);

            // Add the row element
            Element row = doc.createElement("row");
            results.appendChild(row);

            Element _journalCode = doc.createElement("journalGroup");
            row.appendChild(_journalCode);
            _journalCode.appendChild(doc.createTextNode(journalGroup));

            Element _year = doc.createElement("year");
            row.appendChild(_year);
            _year.appendChild(doc.createTextNode(Integer.toString(year)));

            String sqlPeriod = Queries.getQuery("get_rate_period");
            PreparedStatement stGetPeriod = conn.prepareStatement(sqlPeriod);
            stGetPeriod.setInt(1, year);
            ResultSet rsPeriod = this.db.executeQueryPreparedStatement(stGetPeriod);

            while (rsPeriod.next()){
                period = rsPeriod.getInt(1);
                String sqlRate = Queries.getQuery("get_rate");
                PreparedStatement stGetRate = conn.prepareStatement(sqlRate);
                stGetRate.setInt(1, year);
                stGetRate.setInt(2, period);
                stGetRate.setInt(3, journalGpId);
                stGetRate.setString(4, subscriberType);
                ResultSet rsRate = this.db.executeQueryPreparedStatement(stGetRate);

                Element _rate = doc.createElement("year" + period);
                row.appendChild(_rate);
                if(rsRate.next()){
                    rate = rsRate.getInt(1);
                    _rate.appendChild(doc.createTextNode(Integer.toString(rate)));
                }else {
                    _rate.appendChild(doc.createTextNode(""));
                }
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

    public String listRates() throws SQLException, ParseException, ParserConfigurationException, TransformerException, IOException {

        int year = Integer.parseInt(request.getParameter("year"));
        String subscriberType = request.getParameter("subscriberType");
        //subscriberType = "Indian Schools and Colleges";

        String xml = getRatesXML(year, subscriberType);
        /*
        String xml = "<?xml version='1.0' encoding='UTF-8'?>" +
                    "<results>" +
                        "<row>" +
                            "<journalGroup>Pramana - Journal of Physics</journalGroup>" +
                            "<year>2012</year>" +
                            "<year1>750</year1>" +
                            "<year2>750</year2>" +
                            "<year3>750</year3>" +
                            "<year5>750</year5>" +
                        "</row>" +
                        "<row>" +
                            "<journalGroup>Journal of Astrophysics and Astronomy</journalGroup>" +
                            "<year>2012</year>" +
                            "<year1>300</year1>" +
                            "<year2>750</year2>" +
                            "<year3>750</year3>" +
                            "<year5>750</year5>" +
                        "</row>" +
                    "</results>";
                    */
        return xml;
    }

    public void constructTableJournalRates() throws SQLException, ParserConfigurationException, SAXException, IOException, IllegalAccessException, InvocationTargetException, TransformerConfigurationException, TransformerException {

        subscriptionRatesFormBeanReport subscriptionRatesFormBeanReport = new IAS.Bean.Reports.subscriptionRatesFormBeanReport();
        FillBean(this.request, subscriptionRatesFormBeanReport);

        int year = subscriptionRatesFormBeanReport.getYear();
        if(year == 0) {
            year = Calendar.getInstance().get(Calendar.YEAR);
        }

        String subscriberType = subscriptionRatesFormBeanReport.getSubscriberType();
        if(subscriberType.isEmpty()){
            subscriberType = "Indian Schools and Colleges";
        }

        //String data = getRatesXML(year, subscriberType);

        String sql = Queries.getQuery("get_rate_period");
        PreparedStatement st = conn.prepareStatement(sql);
        st.setInt(1, year);
        ResultSet rs = db.executeQueryPreparedStatement(st);

        String colNames = "['Journal Group', 'Year',";
        String colModel = "[" + "{name:'journalGroup', index:'journalGroup', xmlmap:'journalGroup'},"
                            + "{name:'year', index:'year', xmlmap:'year'},";

        while(rs.next()) {
            int period = rs.getInt(1);
            colNames = colNames + "'" + period + " Year'";
            colModel = colModel + "{name:'year" + period + "'," + "index:'year" + period + "'," + "align:'center'," +"xmlmap:'year" + period + "'}";

            if(rs.isLast() == false) {
                colNames = colNames + ",";
                colModel = colModel + ",";
            }
        }

        colNames = colNames + "]";
        colModel = colModel + "]";

        subscriptionRatesFormBeanReport _subscriptionRatesFormBeanReport = new IAS.Bean.Reports.subscriptionRatesFormBeanReport();
        _subscriptionRatesFormBeanReport.setColM(colModel);
        _subscriptionRatesFormBeanReport.setColN(colNames);
        _subscriptionRatesFormBeanReport.setYear(year);
        _subscriptionRatesFormBeanReport.setSubscriberType(subscriberType);
        //_subscriptionRatesFormBeanReport.setData(data);
        request.setAttribute("subscriptionRatesFormBeanReport", _subscriptionRatesFormBeanReport);

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

    public ResultSet printSubscribersList() {

        ResultSet rs = null;
        return rs;
    }

    public ResultSet searchSubscriber() throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml = null;

        String subType = request.getParameter("subtype");
        String nationality = request.getParameter("nationality");
        String institutional = request.getParameter("institutional");
        String subscriberType = request.getParameter("subscriberType");
        String journalName = request.getParameter("journalName");
        String country = request.getParameter("country");
        String state = request.getParameter("state");
        String city = request.getParameter("city");
        String fromDate = request.getParameter("from");
        String toDate = request.getParameter("to");
        String selall = request.getParameter("selall");

        String sql = null;


        if ("0".equals(city)) {
            city = null;
        }
        if ("0".equals(country)) {
            country = null;
        }
        if ("0".equals(state)) {
            state = null;
        }
        if ("0".equals(subType)) {
            subType = null;
        }
        if ("0".equals(nationality)) {
            nationality = null;
        }
        if ("0".equals(institutional)) {
            institutional = null;
        }
        if ("0".equals(subscriberType)) {
            subscriberType = null;
        }
        if ("0".equals(journalName)) {
            journalName = null;
        }


        sql = Queries.getQuery("list_susbsriber");
        if (subType != null && subType.compareToIgnoreCase("NULL") != 0 && subType.length() > 0) {
            sql += " and subscriber_type.subtype =" + "'" + subType + "'";
        }
        if (subscriberType != null && subscriberType.compareToIgnoreCase("NULL") != 0 && subscriberType.length() > 0) {
            sql += " and subscriber_type.subtypedesc =" + "'" + subscriberType + "'";
        }
        if (city != null && city.compareToIgnoreCase("NULL") != 0 && city != null && city.length() > 0) {
            sql += " and cities.city = " + "'" + city + "'";
        }

        if (country != null && country.compareToIgnoreCase("NULL") != 0 && country.length() > 0) {
            sql += " and countries.country = " + "'" + country + "'";
        }

        if (state != null && state.compareToIgnoreCase("NULL") != 0 && state.length() > 0) {
                sql += " and states.state = " + "'" + state + "'";
        }

        if (journalName != null && journalName.compareToIgnoreCase("NULL") != 0 && journalName.length() > 0) {
            sql += " and journals.journalName = " + "'" + journalName + "'";
        }

        if (nationality != null && nationality.compareToIgnoreCase("NULL") != 0 && nationality.length() > 0) {
            sql += " and subscriber_type.nationality = " + "'" + nationality + "'";
        }

        if (institutional != null && institutional.compareToIgnoreCase("NULL") != 0 && institutional.length() > 0) {
            sql += " and subscriber_type.institutional = " + "'" + institutional + "'";
        }

        if ("1".equals(selall)) {
            selall = "0";
            sql += " and subscriber.deactive <> " +  selall;
        }

        if (fromDate != null && fromDate.length() > 0 && toDate != null && toDate.length() > 0) {
            sql += " and subscription.subscriptionDate between " + "STR_TO_DATE(" + '"' + fromDate + '"' + ",'%d/%m/%Y')" + " and " + "STR_TO_DATE(" + '"' + toDate + '"' + ",'%d/%m/%Y')";
        }

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

    public String circulationFigures() throws SQLException, ParseException, ParserConfigurationException, TransformerException, SAXException, IOException {

        String year = request.getParameter("year");
        String month = request.getParameter("month");


        if ("0".equals(year)) {
            year = null;
        }

        if ("0".equals(month)) {
            month = null;
        }

        // Add the results element
        String xml = null;
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document doc = builder.newDocument();
        Element results = doc.createElement("results");
        doc.appendChild(results);

        int totalTotalCopies = 0;
        int totalBalanceCopies=0;
        int totalPrintOrder = 0;
        int totalInstI = 0;
        int totalInstF = 0;
        int totalIndI = 0;
        int totalIndF = 0;
        int totalAuth = 0;
        int totalFree = 0;

        String sql = null;
        sql = Queries.getQuery("cf_journals");
        int paramIndex = 1;
        PreparedStatement stGet = conn.prepareStatement(sql);
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        while (rs.next())
        {
            int totalCopies = 0;
            int balanceCopies=0;
            int printOrder = 0;
            int instI = 0;
            int instF = 0;
            int indI = 0;
            int indF = 0;
            int auth = 0;
            int free = 0;

            int journalId = rs.getInt(1);
            String journalCode = rs.getString(2);

            String sqlIssues = null;
            sqlIssues = Queries.getQuery("cf_issue");
            PreparedStatement stGetIssues = conn.prepareStatement(sqlIssues);
            paramIndex = 1;
            stGetIssues.setString(paramIndex, request.getParameter("year"));
            stGetIssues.setInt(++paramIndex, journalId);
            stGetIssues.setString(++paramIndex, request.getParameter("month"));
            ResultSet rsIssues = this.db.executeQueryPreparedStatement(stGetIssues);
            while (rsIssues.next())
            {
                int issue = rsIssues.getInt(1);

                // Add the row element. Add information for a journal
                Element row = doc.createElement("row");
                results.appendChild(row);

                // Add journal Code as first column
                Element _journalCode = doc.createElement("journalCode");
                row.appendChild(_journalCode);
                _journalCode.appendChild(doc.createTextNode(journalCode));

                // Add journal Code as first column
                Element _issue = doc.createElement("issue");
                row.appendChild(_issue);
                _issue.appendChild(doc.createTextNode(Integer.toString(issue)));

                String sqlInstI = null;
                sqlInstI = Queries.getQuery("cf_inst_i");
                PreparedStatement stGetInstI = conn.prepareStatement(sqlInstI);
                paramIndex = 1;
                stGetInstI.setString(paramIndex, request.getParameter("year"));
                stGetInstI.setInt(++paramIndex, journalId);
                stGetInstI.setInt(++paramIndex, issue);
                ResultSet rsInstI = this.db.executeQueryPreparedStatement(stGetInstI);
                if (rsInstI.next())
                {
                    instI = rsInstI.getInt(1);
                }

                Element _instI = doc.createElement("instIndia");
                row.appendChild(_instI);
                _instI.appendChild(doc.createTextNode(Integer.toString(instI)));

                totalInstI = totalInstI + instI;

                String sqlInstF = null;
                sqlInstF = Queries.getQuery("cf_inst_f");
                PreparedStatement stGetInstF = conn.prepareStatement(sqlInstF);
                paramIndex = 1;
                stGetInstF.setString(paramIndex, request.getParameter("year"));
                stGetInstF.setInt(++paramIndex, journalId);
                stGetInstF.setInt(++paramIndex, issue);
                ResultSet rsInstF = this.db.executeQueryPreparedStatement(stGetInstF);
                if (rsInstF.next())
                {
                    instF = rsInstF.getInt(1);
                }

                Element _instF = doc.createElement("instAbroad");
                row.appendChild(_instF);
                _instF.appendChild(doc.createTextNode(Integer.toString(instF)));

                totalInstF = totalInstF + instF;

                String sqlIndI = null;
                sqlIndI = Queries.getQuery("cf_ind_i");
                PreparedStatement stGetIndI = conn.prepareStatement(sqlIndI);
                paramIndex = 1;
                stGetIndI.setString(paramIndex, request.getParameter("year"));
                stGetIndI.setInt(++paramIndex, journalId);
                stGetIndI.setInt(++paramIndex, issue);
                ResultSet rsIndI = this.db.executeQueryPreparedStatement(stGetIndI);
                if (rsIndI.next())
                {
                    indI = rsIndI.getInt(1);
                }

                Element _indI = doc.createElement("indIndia");
                row.appendChild(_indI);
                _indI.appendChild(doc.createTextNode(Integer.toString(indI)));

                totalIndI = totalIndI + indI;

                String sqlIndF = null;
                sqlIndF = Queries.getQuery("cf_ind_f");
                PreparedStatement stGetIndF = conn.prepareStatement(sqlIndF);
                paramIndex = 1;
                stGetIndF.setString(paramIndex, request.getParameter("year"));
                stGetIndF.setInt(++paramIndex, journalId);
                stGetIndF.setInt(++paramIndex, issue);
                ResultSet rsIndF = this.db.executeQueryPreparedStatement(stGetIndF);
                if (rsIndF.next())
                {
                    indF = rsIndF.getInt(1);
                }

                Element _indF = doc.createElement("indAbroad");
                row.appendChild(_indF);
                _indF.appendChild(doc.createTextNode(Integer.toString(indF)));

                totalIndF = totalIndF + indF;

                String sqlFree = null;
                sqlFree = Queries.getQuery("cf_free");
                PreparedStatement stGetFree = conn.prepareStatement(sqlFree);
                paramIndex = 1;
                stGetFree.setString(paramIndex, request.getParameter("year"));
                stGetFree.setInt(++paramIndex, journalId);
                stGetFree.setInt(++paramIndex, issue);
                ResultSet rsFree = this.db.executeQueryPreparedStatement(stGetFree);
                if (rsFree.next())
                {
                    free = rsFree.getInt(1);
                }

                Element _free = doc.createElement("comp");
                row.appendChild(_free);
                _free.appendChild(doc.createTextNode(Integer.toString(free)));

                totalFree = totalFree + free;

                String sqlAuth = null;
                sqlAuth = Queries.getQuery("cf_auth");
                PreparedStatement stGetAuth = conn.prepareStatement(sqlAuth);
                paramIndex = 1;
                stGetAuth.setString(paramIndex, request.getParameter("year"));
                stGetAuth.setInt(++paramIndex, journalId);
                stGetAuth.setInt(++paramIndex, issue);
                ResultSet rsAuth = this.db.executeQueryPreparedStatement(stGetAuth);
                if (rsAuth.next())
                {
                    auth = rsAuth.getInt(1);
                }

                Element _auth = doc.createElement("auth");
                row.appendChild(_auth);
                _auth.appendChild(doc.createTextNode(Integer.toString(auth)));

                totalAuth = totalAuth + auth;

                String sqlPrintOrder = null;
                sqlPrintOrder = Queries.getQuery("cf_print_order");
                PreparedStatement stGetPrintOrder = conn.prepareStatement(sqlPrintOrder);
                paramIndex = 1;
                stGetPrintOrder.setString(paramIndex, request.getParameter("year"));
                stGetPrintOrder.setInt(++paramIndex, journalId);
                stGetPrintOrder.setInt(++paramIndex, issue);
                ResultSet rsPrintOrder = this.db.executeQueryPreparedStatement(stGetPrintOrder);
                if (rsPrintOrder.next())
                {
                    printOrder = rsPrintOrder.getInt(1);
                }

                Element _printOrder = doc.createElement("printOrder");
                row.appendChild(_printOrder);
                _printOrder.appendChild(doc.createTextNode(Integer.toString(printOrder)));

                totalPrintOrder = totalPrintOrder + printOrder;

                totalCopies = instI + instF + indI + indF + auth + free;
                balanceCopies = printOrder - totalCopies;

                Element _totalCopies = doc.createElement("totalCopies");
                row.appendChild(_totalCopies);
                _totalCopies.appendChild(doc.createTextNode(Integer.toString(totalCopies)));

                Element _balanceCopies = doc.createElement("balanceCopies");
                row.appendChild(_balanceCopies);
                _balanceCopies.appendChild(doc.createTextNode(Integer.toString(balanceCopies)));

                totalTotalCopies = totalTotalCopies + totalCopies;
                totalBalanceCopies = totalBalanceCopies + balanceCopies;
            }
         }

            // Add the row element. Add for total
            Element row = doc.createElement("row");
            results.appendChild(row);

            Element _journalCode = doc.createElement("journalCode");
            row.appendChild(_journalCode);
            _journalCode.appendChild(doc.createTextNode("Total"));

            // Add journal Code as first column
            Element _issue = doc.createElement("issue");
            row.appendChild(_issue);
            _issue.appendChild(doc.createTextNode("-->"));

            Element _instI = doc.createElement("instIndia");
            row.appendChild(_instI);
            _instI.appendChild(doc.createTextNode(Integer.toString(totalInstI)));

            Element _instF = doc.createElement("instAbroad");
            row.appendChild(_instF);
            _instF.appendChild(doc.createTextNode(Integer.toString(totalInstF)));

            Element _indI = doc.createElement("indIndia");
            row.appendChild(_indI);
            _indI.appendChild(doc.createTextNode(Integer.toString(totalIndF)));

            Element _indF = doc.createElement("indAbroad");
            row.appendChild(_indF);
            _indF.appendChild(doc.createTextNode(Integer.toString(totalIndF)));

            Element _free = doc.createElement("comp");
            row.appendChild(_free);
            _free.appendChild(doc.createTextNode(Integer.toString(totalFree)));

            Element _auth = doc.createElement("auth");
            row.appendChild(_auth);
            _auth.appendChild(doc.createTextNode(Integer.toString(totalAuth)));

            Element _totalCopies = doc.createElement("totalCopies");
            row.appendChild(_totalCopies);
            _totalCopies.appendChild(doc.createTextNode(Integer.toString(totalTotalCopies)));

            Element _printOrder = doc.createElement("printOrder");
            row.appendChild(_printOrder);
            _printOrder.appendChild(doc.createTextNode(Integer.toString(totalPrintOrder)));

            Element _balanceCopies = doc.createElement("balanceCopies");
            row.appendChild(_balanceCopies);
            _balanceCopies.appendChild(doc.createTextNode(Integer.toString(totalBalanceCopies)));


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
        stGet.setString(++paramIndex, request.getParameter("volume"));
        stGet.setString(++paramIndex, request.getParameter("month"));
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
        st.setInt(1, year);
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
            st.setInt(2, year);
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

        int year = Calendar.getInstance().get(Calendar.YEAR);

        String sql = Queries.getQuery("get_max_no_of_issues");
        PreparedStatement st = conn.prepareStatement(sql);
        st.setInt(1, year);
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

        String year = request.getParameter("year");
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
                Calendar cal = Calendar.getInstance();
                int currYear = cal.get(Calendar.YEAR);
                String date = "";
                if (Integer.parseInt(year) == currYear) {

                    sqlSubFigures += " and curdate()";


                }
                else{

                    date = year + "-12-31";
                    date = "date_format(" + '"' + date + '"' + ",'%y/%m/%d')";
                    sqlSubFigures += " and " + date;
                }
                sqlSubFigures += " BETWEEN date_format( concat(subscriptiondetails.startYear, '-', subscriptiondetails.startMonth, '-', '1'), '%Y/%m/%d')";
                sqlSubFigures += " AND LAST_DAY(concat(subscriptiondetails.endYear, '-', subscriptiondetails.endMonth, '-', '1'))";
                sqlSubFigures += " GROUP BY journals.journalCode AND subscriber_type.subtypecode";

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

 public ResultSet listInvoice() throws SQLException, ParseException, ParserConfigurationException, TransformerException, SAXException, IOException {
String xml = null;

        String subType = request.getParameter("subtype");
        String journalName = request.getParameter("journalName");
        String fromDate = request.getParameter("from");
        String toDate = request.getParameter("to");

        String sql = null;

        if ("0".equals(subType)) {
            subType = null;
        }
        if ("0".equals(journalName)) {
            journalName = null;
        }

        sql = Queries.getQuery("list_invoice");

        if (subType != null && subType.compareToIgnoreCase("NULL") != 0 && subType.length() > 0) {
            sql += " and subscriber_type.subtypedesc =" + "'" + subType + "'";
        }

        if (journalName != null && journalName.compareToIgnoreCase("NULL") != 0 && journalName.length() > 0) {
            sql += " and journals.journalName = " + "'" + journalName + "'";
        }

        if (fromDate != null && fromDate.length() > 0 && toDate != null && toDate.length() > 0) {
            sql += " and invoice.invoiceCreationDate between " + "STR_TO_DATE(" + '"' + fromDate + '"' + ",'%d/%m/%Y')" + " and " + "STR_TO_DATE(" + '"' + toDate + '"' + ",'%d/%m/%Y')";
        }
        PreparedStatement stGet = conn.prepareStatement(sql);
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        return rs;
      }

     public ResultSet listReminders()  throws SQLException, ParseException, ParserConfigurationException, TransformerException {

        String fromDate = request.getParameter("from");
        String toDate = request.getParameter("to");

        String sql = Queries.getQuery("list_reminders_subscriber");

        if (fromDate != null && fromDate.length() > 0 && toDate != null && toDate.length() > 0) {
            sql += " and reminders.reminderDate between " + "STR_TO_DATE(" + '"' + fromDate + '"' + ",'%d/%m/%Y')" + " and " + "STR_TO_DATE(" + '"' + toDate + '"' + ",'%d/%m/%Y')";
        }

        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;
        stGet.setString(paramIndex, request.getParameter("reminderType"));
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        return rs;

    }

     public String outstaningBalnace()  throws SQLException, ParseException, ParserConfigurationException, TransformerException, IOException {

        int periodStart = Integer.parseInt(request.getParameter("periodStart"));
        int periodEnd = Integer.parseInt(request.getParameter("periodEnd"));
        int subEnd = Integer.parseInt(request.getParameter("subEnd"));
        String all = request.getParameter("totalBalance");
        String xml = null;
        int totalBalance = 0;

        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document doc = builder.newDocument();
        Element results = doc.createElement("results");
        doc.appendChild(results);
   // For Legacy Data

        String sql = Queries.getQuery("get_legacy_balance");
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        while (rs.next()){
            String subscriberNumber = rs.getString("subscriberNumber");
            int subscriptionId = rs.getInt("subscriptionId");
            String journalCode = "";
            int balance = rs.getInt("balance");
            String proInvNo = rs.getString("proInvNo");
            String proInvDate = rs.getString("proInvDate");
            int startYear = 0;
            int endYear = 0;
            int newStart = 0;
            int newEnd = 0;
            String period = "";
            int subexists = 0;

            String sqljournals = Queries.getQuery("get_sub_journals");
            if (subEnd != 0){
                sqljournals += " and subscriptiondetails.endYear  = " + subEnd;
            }
            else if (periodStart != 0 && periodEnd != 0){
                sqljournals += " and subscriptiondetails.startYear  >= " + periodStart;
                sqljournals += " and subscriptiondetails.endYear  <= " + periodEnd;
            }
            PreparedStatement stGetJournals = conn.prepareStatement(sqljournals);
            stGetJournals.setInt(paramIndex, subscriptionId);
            ResultSet rsJournals = this.db.executeQueryPreparedStatement(stGetJournals);
            while (rsJournals.next()){
                if (journalCode.equals("")){
                    journalCode += rsJournals.getString(1);
                }
                else {
                    journalCode += ", " + rsJournals.getString(1);
                }
                if (startYear == 0 && endYear == 0) {
                    startYear = rsJournals.getInt("startYEar");
                    endYear = rsJournals.getInt("endYear");
                    newStart = startYear;
                    newEnd = endYear;
                }
                else{
                    newStart = rsJournals.getInt("startYEar");
                    newEnd = rsJournals.getInt("endYear");
                    if (newStart < startYear){
                        startYear = newStart;
                    }
                    if (newEnd < endYear){
                        endYear = newEnd;
                    }
                }
                subexists = 1;
           }
            period = startYear + "-" + endYear;


            if (subexists == 1){
                totalBalance = totalBalance + balance;
                Element row = doc.createElement("row");
                results.appendChild(row);

                Element _subscriberNumber = doc.createElement("subscriberNumber");
                row.appendChild(_subscriberNumber);
                _subscriberNumber.appendChild(doc.createTextNode(subscriberNumber));

                Element _journalCode = doc.createElement("journalCode");
                row.appendChild(_journalCode);
                _journalCode.appendChild(doc.createTextNode(journalCode));

                Element _period = doc.createElement("period");
                row.appendChild(_period);
                _period.appendChild(doc.createTextNode(period));

                Element _balance = doc.createElement("balance");
                row.appendChild(_balance);
                _balance.appendChild(doc.createTextNode(Integer.toString(balance)));

                Element _proInvNo = doc.createElement("proInvNo");
                row.appendChild(_proInvNo);
                _proInvNo.appendChild(doc.createTextNode(proInvNo));

                Element _proInvDate = doc.createElement("proInvDate");
                row.appendChild(_proInvDate);
                _proInvDate.appendChild(doc.createTextNode(proInvDate));

                subexists = 0;
            }
        }

       // For current Data
        String sqlcurr = Queries.getQuery("get_current_balance");
        PreparedStatement stGetCurr = conn.prepareStatement(sqlcurr);
        paramIndex = 1;
        ResultSet rsCurr = this.db.executeQueryPreparedStatement(stGetCurr);
        while (rsCurr.next()){
            String subscriberNumber = rsCurr.getString("subscriberNumber");
            int subscriptionId = rsCurr.getInt("subscriptionId");
            String journalCode = "";
            int balance = rsCurr.getInt("balance");
            String proInvNo = rsCurr.getString("proInvNo");
            String proInvDate = rsCurr.getString("proInvDate");
            int startYear = 0;
            int endYear = 0;
            int newStart = 0;
            int newEnd = 0;
            String period = "";
            int subexists = 0;



            String sqljournalsCurr = Queries.getQuery("get_sub_journals");
            //String sqljournals = Queries.getQuery("get_sub_journals");
            if (subEnd != 0){
                sqljournalsCurr += " and subscriptiondetails.endYear  = " + subEnd;
            }
            else if (periodStart != 0 && periodEnd != 0){
                sqljournalsCurr += " and subscriptiondetails.startYear  >= " + periodStart;
                sqljournalsCurr += " and subscriptiondetails.endYear  <= " + periodEnd;
            }
            PreparedStatement stGetJournals = conn.prepareStatement(sqljournalsCurr);
            stGetJournals.setInt(paramIndex, subscriptionId);
            ResultSet rsJournals = this.db.executeQueryPreparedStatement(stGetJournals);
            while (rsJournals.next()){
                if (journalCode.equals("")){
                    journalCode += rsJournals.getString(1);
                }
                else {
                    journalCode += ", " + rsJournals.getString(1);
                }
                if (startYear == 0 && endYear == 0) {
                    startYear = rsJournals.getInt("startYEar");
                    endYear = rsJournals.getInt("endYear");
                    newStart = startYear;
                    newEnd = endYear;
                }
                else{
                    newStart = rsJournals.getInt("startYEar");
                    newEnd = rsJournals.getInt("endYear");
                    if (newStart < startYear){
                        startYear = newStart;
                    }
                    if (newEnd < endYear){
                        endYear = newEnd;
                    }
                }
                subexists = 1;
           }
            period = startYear + "-" + endYear;

            if (subexists == 1){
                totalBalance = totalBalance + balance;

                Element row = doc.createElement("row");
                results.appendChild(row);

                Element _subscriberNumber = doc.createElement("subscriberNumber");
                row.appendChild(_subscriberNumber);
                _subscriberNumber.appendChild(doc.createTextNode(subscriberNumber));

                Element _journalCode = doc.createElement("journalCode");
                row.appendChild(_journalCode);
                _journalCode.appendChild(doc.createTextNode(journalCode));

                Element _period = doc.createElement("period");
                row.appendChild(_period);
                _period.appendChild(doc.createTextNode(period));

                Element _balance = doc.createElement("balance");
                row.appendChild(_balance);
                _balance.appendChild(doc.createTextNode(Integer.toString(balance)));

                Element _proInvNo = doc.createElement("proInvNo");
                row.appendChild(_proInvNo);
                _proInvNo.appendChild(doc.createTextNode(proInvNo));

                Element _proInvDate = doc.createElement("proInvDate");
                row.appendChild(_proInvDate);
                _proInvDate.appendChild(doc.createTextNode(proInvDate));

                subexists = 0;
            }
        }

            Element row = doc.createElement("row");
            results.appendChild(row);

            Element _journalCode = doc.createElement("journalCode");
            row.appendChild(_journalCode);
            _journalCode.appendChild(doc.createTextNode("Total Balance -->"));

            Element _balance = doc.createElement("balance");
            row.appendChild(_balance);
            _balance.appendChild(doc.createTextNode(Integer.toString(totalBalance)));

        DOMSource domSource = new DOMSource(doc);
        try (StringWriter writer = new StringWriter()) {
            StreamResult result = new StreamResult(writer);
            TransformerFactory tf = TransformerFactory.newInstance();
            Transformer transformer = tf.newTransformer();
            transformer.transform(domSource, result);
            xml = writer.toString();
        }
        //


        //if (fromDate != null && fromDate.length() > 0 && toDate != null && toDate.length() > 0) {
          //  sql += " and reminders.reminderDate between " + "STR_TO_DATE(" + '"' + fromDate + '"' + ",'%d/%m/%Y')" + " and " + "STR_TO_DATE(" + '"' + toDate + '"' + ",'%d/%m/%Y')";
        //}


        return xml;

    }
}
