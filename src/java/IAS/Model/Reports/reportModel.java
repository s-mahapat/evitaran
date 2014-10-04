package IAS.Model.Reports;

import IAS.Bean.Reports.printOrderFormBeanReport;
import IAS.Bean.Reports.subscriptionFiguresFormBeanReport;
import IAS.Bean.Reports.subscriptionRatesFormBeanReport;
import IAS.Class.JDSLogger;
import IAS.Class.Queries;
import IAS.Class.util;
import IAS.Model.*;
import com.sun.rowset.CachedRowSetImpl;
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
import javax.xml.transform.TransformerConfigurationException;

/**
 *
 * @author Deepali
 */
public class reportModel extends JDSModel {

    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Model.reports");

    public reportModel(HttpServletRequest request) throws SQLException {

        super(request);

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
        try (Connection conn = this.getConnection(); PreparedStatement stGetJGrp = conn.prepareStatement(sqlJournalGrp); ResultSet rsJGrp = stGetJGrp.executeQuery();) {

            while (rsJGrp.next()) {
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
                try (PreparedStatement stGetPeriod = conn.prepareStatement(sqlPeriod)) {
                    stGetPeriod.setInt(1, year);
                    try (ResultSet rsPeriod = stGetPeriod.executeQuery()) {
                        while (rsPeriod.next()) {
                            period = rsPeriod.getInt(1);
                            String sqlRate = Queries.getQuery("get_rate");
                            PreparedStatement stGetRate = conn.prepareStatement(sqlRate);
                            stGetRate.setInt(1, year);
                            stGetRate.setInt(2, period);
                            stGetRate.setInt(3, journalGpId);
                            stGetRate.setString(4, subscriberType);
                            ResultSet rsRate = stGetRate.executeQuery();

                            Element _rate = doc.createElement("year" + period);
                            row.appendChild(_rate);
                            if (rsRate.next()) {
                                rate = rsRate.getInt(1);
                                _rate.appendChild(doc.createTextNode(Integer.toString(rate)));
                            } else {
                                _rate.appendChild(doc.createTextNode(""));
                            }
                        }
                    }
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
        if (year == 0) {
            year = Calendar.getInstance().get(Calendar.YEAR);
        }

        String subscriberType = subscriptionRatesFormBeanReport.getSubscriberType();
        if (subscriberType.isEmpty()) {
            subscriberType = "Indian Schools and Colleges";
        }

        //String data = getRatesXML(year, subscriberType);
        String sql = Queries.getQuery("get_rate_period");
        try (Connection conn = this.getConnection(); PreparedStatement st = conn.prepareStatement(sql)) {
            st.setInt(1, year);
            ResultSet rs = st.executeQuery();

            String colNames = "['Journal Group', 'Year',";
            String colModel = "[" + "{name:'journalGroup', index:'journalGroup', xmlmap:'journalGroup'},"
                    + "{name:'year', index:'year', xmlmap:'year'},";

            while (rs.next()) {
                int period = rs.getInt(1);
                colNames = colNames + "'" + period + " Year'";
                colModel = colModel + "{name:'year" + period + "'," + "index:'year" + period + "'," + "align:'center'," + "xmlmap:'year" + period + "'}";

                if (rs.isLast() == false) {
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

    }

    public CachedRowSetImpl searchJournalGroup() throws SQLException, ParseException, ParserConfigurationException, TransformerException {

        String sql;
        String journalGroupName = request.getParameter("journalGroupName");
        if ("0".equals(journalGroupName)) {
            journalGroupName = null;
        }
        CachedRowSetImpl crs = new CachedRowSetImpl();
        sql = Queries.getQuery("list_journal_group");
        sql += "  t2.journalGroupName =" + "'" + journalGroupName + "'";
        try (Connection conn = this.getConnection(); PreparedStatement stGet = conn.prepareStatement(sql);) {
            try (ResultSet rs = stGet.executeQuery()) {
                crs.populate(rs);
            }
        }

        return crs;
    }

    public CachedRowSetImpl searchSubType() throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml = null;
        String subType = request.getParameter("subtype");
        String nationality = request.getParameter("nationality");
        String institutional = request.getParameter("institutional");
        String selall = request.getParameter("selall");
        String sql;
        int param = 0;
        CachedRowSetImpl crs = new CachedRowSetImpl();
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
        try (Connection conn = this.getConnection(); PreparedStatement stGet = conn.prepareStatement(sql);) {

            try (ResultSet rs = stGet.executeQuery()) {
                crs.populate(rs);
            }
        }
        return crs;
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
        int start = (pageNumber - 1) * pageSize;
        sql += " LIMIT " + start + "," + pageSize;
        try (Connection conn = this.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            xml = util.convertResultSetToXML(rs);
            sql = "select count(*) from (" + sql + ") as tbl";
            try (PreparedStatement pst = conn.prepareStatement(sql)) {
                try (ResultSet rs2 = pst.executeQuery()) {
                    while (rs2.next()) {
                        totalQueryCount = rs2.getInt(1);
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
                    try (StringWriter writer = new StringWriter()) {
                        StreamResult result = new StreamResult(writer);
                        TransformerFactory tf = TransformerFactory.newInstance();
                        Transformer transformer = tf.newTransformer();
                        transformer.transform(domSource, result);
                        xml = writer.toString();
                    }
                }
            }
        }
        return xml;
    }

    public CachedRowSetImpl searchInwardsAll() throws SQLException, ParseException, ParserConfigurationException, TransformerException, SAXException, IOException {

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
        CachedRowSetImpl crs = new CachedRowSetImpl();
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
        try (Connection conn = this.getConnection(); PreparedStatement stGet = conn.prepareStatement(sql);) {

            try (ResultSet rs = stGet.executeQuery()) {
                crs.populate(rs);
            }
        }
        return crs;
    }

    public CachedRowSetImpl searchAgents() throws SQLException, ParseException, ParserConfigurationException, TransformerException, SAXException, IOException {
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
        CachedRowSetImpl crs = new CachedRowSetImpl();
        try (Connection conn = this.getConnection(); PreparedStatement stGet = conn.prepareStatement(sql);) {

            try (ResultSet rs = stGet.executeQuery()) {
                crs.populate(rs);
            }
        }
        return crs;
    }

    public ResultSet printSubscribersList() {

        ResultSet rs = null;
        return rs;
    }

    public CachedRowSetImpl searchSubscriber(String orderBy) throws SQLException, ParseException, ParserConfigurationException, TransformerException {

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
        String agentName = request.getParameter("agentName");

        String sql;

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
        if ("0".equals(agentName)) {
            agentName = null;
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
        if (agentName != null && agentName.compareToIgnoreCase("NULL") != 0 && agentName.length() > 0) {
            sql += " and agents.agentName = " + "'" + agentName + "'";
        }

        if (nationality != null && nationality.compareToIgnoreCase("NULL") != 0 && nationality.length() > 0) {
            sql += " and subscriber_type.nationality = " + "'" + nationality + "'";
        }

        if (institutional != null && institutional.compareToIgnoreCase("NULL") != 0 && institutional.length() > 0) {
            sql += " and subscriber_type.institutional = " + "'" + institutional + "'";
        }

        if ("1".equals(selall)) {
            selall = "0";
            sql += " and subscriber.deactive <> True";
        }

        if (fromDate != null && fromDate.length() > 0 && toDate != null && toDate.length() > 0) {
            sql += " and subscription.subscriptionDate between " + "STR_TO_DATE(" + '"' + fromDate + '"' + ",'%d/%m/%Y')" + " and " + "STR_TO_DATE(" + '"' + toDate + '"' + ",'%d/%m/%Y')";
        }

        sql += " order by" + " " + orderBy;
        CachedRowSetImpl crs = new CachedRowSetImpl();
        try (Connection conn = this.getConnection(); PreparedStatement stGet = conn.prepareStatement(sql);) {

            try (ResultSet rs = stGet.executeQuery()) {
                crs.populate(rs);
            }
        }
        return crs;
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
        try (Connection conn = this.getConnection(); PreparedStatement stGet = conn.prepareStatement(sql);) {
            stGet.setString(paramIndex, request.getParameter("journalName"));
            try (ResultSet rs = stGet.executeQuery();) {
                if (rs.next()) {
                    int totalNoOfSubscribers = 0;
                    int totalNoOfCopies = 0;
                    int journalId;
                    journalId = rs.getInt(1);
                    String sqlSubType;
                    sqlSubType = Queries.getQuery("subscriber_type");
                    try (PreparedStatement stGetSubType = conn.prepareStatement(sqlSubType); ResultSet rsSubType = stGetSubType.executeQuery()) {

                        while (rsSubType.next()) {
                            Object value = null;
                            String sqlStatement = null;
                            sqlStatement = Queries.getQuery("statement");
                            try (PreparedStatement stGetStatement = conn.prepareStatement(sqlStatement);) {
                                paramIndex = 1;

                                String subtypecode = (rsSubType.getObject(1)).toString();
                                String subtypedesc = (rsSubType.getObject(2)).toString();

                                stGetStatement.setString(paramIndex, subtypecode);
                                stGetStatement.setInt(++paramIndex, journalId);
                                stGetStatement.setString(++paramIndex, request.getParameter("issue"));
                                stGetStatement.setString(++paramIndex, request.getParameter("year"));
                                stGetStatement.setString(++paramIndex, subtypecode);
                                stGetStatement.setString(++paramIndex, request.getParameter("volume"));
                                try (ResultSet rsStatement = stGetStatement.executeQuery()) {

                                    int subCount = 0;
                                    int copies = 0;

                                    if (rsStatement.next()) {

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

                                    Element _subType = doc.createElement("subtypedesc");
                                    row.appendChild(_subType);
                                    _subType.appendChild(doc.createTextNode(subtypedesc));

                                    Element _subCount = doc.createElement("subCount");
                                    row.appendChild(_subCount);
                                    _subCount.appendChild(doc.createTextNode(Integer.toString(subCount)));

                                    Element _copies = doc.createElement("copies");
                                    row.appendChild(_copies);
                                    _copies.appendChild(doc.createTextNode(Integer.toString(copies)));
                                }
                            }
                        }
                    }

                    // Add the row element. Add the total number of copies and subscriber count here
                    Element row = doc.createElement("row");
                    results.appendChild(row);

                    Element _subType = doc.createElement("subtypedesc");
                    row.appendChild(_subType);
                    _subType.appendChild(doc.createTextNode("Total"));

                    Element _subCount = doc.createElement("subCount");
                    row.appendChild(_subCount);
                    _subCount.appendChild(doc.createTextNode(Integer.toString(totalNoOfSubscribers)));

                    Element _copies = doc.createElement("copies");
                    row.appendChild(_copies);
                    _copies.appendChild(doc.createTextNode(Integer.toString(totalNoOfCopies)));
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
        int totalBalanceCopies = 0;
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
        try (Connection conn = this.getConnection(); PreparedStatement stGet = conn.prepareStatement(sql); ResultSet rs = stGet.executeQuery();) {

            while (rs.next()) {
                int totalCopies = 0;
                int balanceCopies = 0;
                int printOrder = 0;
                int instI = 0;
                int instF = 0;
                int indI = 0;
                int indF = 0;
                int auth = 0;
                int free = 0;

                int journalId = rs.getInt(1);
                String journalCode = rs.getString(2);
                String journalName = rs.getString(3);

                String sqlIssues = null;
                sqlIssues = Queries.getQuery("cf_issue_volumeno");
                try (PreparedStatement stGetIssues = conn.prepareStatement(sqlIssues);) {
                    paramIndex = 1;
                    stGetIssues.setString(paramIndex, request.getParameter("year"));
                    stGetIssues.setInt(++paramIndex, journalId);
                    stGetIssues.setString(++paramIndex, request.getParameter("month"));
                    try (ResultSet rsIssues = stGetIssues.executeQuery()) {
                        while (rsIssues.next()) {
                            int issue = rsIssues.getInt(1);
                            int volume = rsIssues.getInt(2);

                            // Add the row element. Add information for a journal
                            Element row = doc.createElement("row");
                            results.appendChild(row);

                            // Add journal Code as first column
                            Element _journalName = doc.createElement("journalName");
                            row.appendChild(_journalName);
                            _journalName.appendChild(doc.createTextNode(journalName));

                            // Add journal Code as first column
                            Element _volume = doc.createElement("volume");
                            row.appendChild(_volume);
                            _volume.appendChild(doc.createTextNode(Integer.toString(volume)));

                            // Add journal Code as first column
                            Element _issue = doc.createElement("issue");
                            row.appendChild(_issue);
                            _issue.appendChild(doc.createTextNode(Integer.toString(issue)));

                            String sqlInstI;
                            sqlInstI = Queries.getQuery("cf_inst_i");
                            try (PreparedStatement stGetInstI = conn.prepareStatement(sqlInstI);) {
                                paramIndex = 1;
                                stGetInstI.setString(paramIndex, request.getParameter("year"));
                                stGetInstI.setInt(++paramIndex, journalId);
                                stGetInstI.setInt(++paramIndex, issue);
                                stGetInstI.setInt(++paramIndex, volume);
                                try (ResultSet rsInstI = stGetInstI.executeQuery();) {
                                    if (rsInstI.next()) {
                                        instI = rsInstI.getInt(1);
                                    }
                                }
                            }

                            Element _instI = doc.createElement("instIndia");
                            row.appendChild(_instI);
                            _instI.appendChild(doc.createTextNode(Integer.toString(instI)));

                            totalInstI = totalInstI + instI;

                            String sqlInstF = null;
                            sqlInstF = Queries.getQuery("cf_inst_f");
                            try (PreparedStatement stGetInstF = conn.prepareStatement(sqlInstF);) {
                                paramIndex = 1;
                                stGetInstF.setString(paramIndex, request.getParameter("year"));
                                stGetInstF.setInt(++paramIndex, journalId);
                                stGetInstF.setInt(++paramIndex, issue);
                                stGetInstF.setInt(++paramIndex, volume);
                                try (ResultSet rsInstF = stGetInstF.executeQuery();) {
                                    if (rsInstF.next()) {
                                        instF = rsInstF.getInt(1);
                                    }
                                }
                            }

                            Element _instF = doc.createElement("instAbroad");
                            row.appendChild(_instF);
                            _instF.appendChild(doc.createTextNode(Integer.toString(instF)));

                            totalInstF = totalInstF + instF;

                            String sqlIndI = null;
                            sqlIndI = Queries.getQuery("cf_ind_i");
                            try (PreparedStatement stGetIndI = conn.prepareStatement(sqlIndI)) {
                                paramIndex = 1;
                                stGetIndI.setString(paramIndex, request.getParameter("year"));
                                stGetIndI.setInt(++paramIndex, journalId);
                                stGetIndI.setInt(++paramIndex, issue);
                                stGetIndI.setInt(++paramIndex, volume);
                                try (ResultSet rsIndI = stGetIndI.executeQuery()) {
                                    if (rsIndI.next()) {
                                        indI = rsIndI.getInt(1);
                                    }
                                }
                            }

                            Element _indI = doc.createElement("indIndia");
                            row.appendChild(_indI);
                            _indI.appendChild(doc.createTextNode(Integer.toString(indI)));

                            totalIndI = totalIndI + indI;

                            String sqlIndF = null;
                            sqlIndF = Queries.getQuery("cf_ind_f");
                            try (PreparedStatement stGetIndF = conn.prepareStatement(sqlIndF)) {
                                paramIndex = 1;
                                stGetIndF.setString(paramIndex, request.getParameter("year"));
                                stGetIndF.setInt(++paramIndex, journalId);
                                stGetIndF.setInt(++paramIndex, issue);
                                stGetIndF.setInt(++paramIndex, volume);
                                try (ResultSet rsIndF = stGetIndF.executeQuery()) {
                                    if (rsIndF.next()) {
                                        indF = rsIndF.getInt(1);
                                    }
                                }
                            }

                            Element _indF = doc.createElement("indAbroad");
                            row.appendChild(_indF);
                            _indF.appendChild(doc.createTextNode(Integer.toString(indF)));

                            totalIndF = totalIndF + indF;

                            String sqlFree = null;
                            sqlFree = Queries.getQuery("cf_free");
                            try (PreparedStatement stGetFree = conn.prepareStatement(sqlFree)) {
                                paramIndex = 1;
                                stGetFree.setString(paramIndex, request.getParameter("year"));
                                stGetFree.setInt(++paramIndex, journalId);
                                stGetFree.setInt(++paramIndex, issue);
                                stGetFree.setInt(++paramIndex, volume);
                                try (ResultSet rsFree = stGetFree.executeQuery()) {
                                    if (rsFree.next()) {
                                        free = rsFree.getInt(1);
                                    }
                                }
                            }

                            Element _free = doc.createElement("comp");
                            row.appendChild(_free);
                            _free.appendChild(doc.createTextNode(Integer.toString(free)));

                            totalFree = totalFree + free;

                            String sqlAuth = null;
                            sqlAuth = Queries.getQuery("cf_auth");
                            try (PreparedStatement stGetAuth = conn.prepareStatement(sqlAuth)) {
                                paramIndex = 1;
                                stGetAuth.setString(paramIndex, request.getParameter("year"));
                                stGetAuth.setInt(++paramIndex, journalId);
                                stGetAuth.setInt(++paramIndex, issue);
                                stGetAuth.setInt(++paramIndex, volume);
                                try (ResultSet rsAuth = stGetAuth.executeQuery()) {
                                    if (rsAuth.next()) {
                                        auth = rsAuth.getInt(1);
                                    }
                                }
                            }

                            Element _auth = doc.createElement("auth");
                            row.appendChild(_auth);
                            _auth.appendChild(doc.createTextNode(Integer.toString(auth)));

                            totalAuth = totalAuth + auth;

                            String sqlPrintOrder = null;
                            sqlPrintOrder = Queries.getQuery("cf_print_order");
                            try (PreparedStatement stGetPrintOrder = conn.prepareStatement(sqlPrintOrder)) {
                                paramIndex = 1;
                                stGetPrintOrder.setString(paramIndex, request.getParameter("year"));
                                stGetPrintOrder.setInt(++paramIndex, journalId);
                                stGetPrintOrder.setInt(++paramIndex, issue);
                                stGetPrintOrder.setInt(++paramIndex, volume);
                                try (ResultSet rsPrintOrder = stGetPrintOrder.executeQuery()) {
                                    if (rsPrintOrder.next()) {
                                        printOrder = rsPrintOrder.getInt(1);
                                    }
                                }
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
                }
            }
        }

        // Add the row element. Add for total
        Element row = doc.createElement("row");
        results.appendChild(row);

        Element _journalName = doc.createElement("journalName");
        row.appendChild(_journalName);
        _journalName.appendChild(doc.createTextNode("Total"));

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

    public CachedRowSetImpl searchCirculationFigures() throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String sql;
        sql = Queries.getQuery("list_circulation_figures");
        CachedRowSetImpl crs = new CachedRowSetImpl();
        try (Connection conn = this.getConnection(); PreparedStatement stGet = conn.prepareStatement(sql);) {

            try (ResultSet rs = stGet.executeQuery()) {
                crs.populate(rs);
            }
        }
        return crs;
    }

    public CachedRowSetImpl listMl() throws SQLException, ParseException, ParserConfigurationException, TransformerException, SAXException, IOException {
        String sql = Queries.getQuery("listml");
        CachedRowSetImpl crs = new CachedRowSetImpl();
        try (Connection conn = this.getConnection(); PreparedStatement stGet = conn.prepareStatement(sql);) {
            int paramIndex = 1;
            stGet.setString(paramIndex, request.getParameter("journalName"));
            stGet.setString(++paramIndex, request.getParameter("issue"));
            stGet.setString(++paramIndex, request.getParameter("year"));
            stGet.setString(++paramIndex, request.getParameter("volume"));
            stGet.setString(++paramIndex, request.getParameter("month"));
            try (ResultSet rs = stGet.executeQuery()) {
                crs.populate(rs);
            }
        }
        return crs;
    }

    public CachedRowSetImpl listBil() throws SQLException, ParseException, ParserConfigurationException, TransformerException, SAXException, IOException {
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

        CachedRowSetImpl crs = new CachedRowSetImpl();
        try (Connection conn = this.getConnection(); PreparedStatement stGet = conn.prepareStatement(sql);) {
            int paramIndex = 1;
            stGet.setString(paramIndex, request.getParameter("journalName"));
            stGet.setString(++paramIndex, request.getParameter("issue"));
            stGet.setString(++paramIndex, request.getParameter("year"));
            stGet.setString(++paramIndex, request.getParameter("volume"));
            try (ResultSet rs = stGet.executeQuery()) {
                crs.populate(rs);
            }
        }
        return crs;

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
    public String printOrderTableDetails() {
        String xml = "";
        xml = xml + "<?xml version='1.0' encoding='utf-8'?>\n";

        xml = xml + "<results>";

        xml = xml + "<colNames>" + "['Issue No','Print Order']" + "</colNames>";
        xml = xml + "<colModel>" + "[{name:'issues', index:'issues', width:80, align:'center', xmlmap:'issues'},{name:'printOrder', index:'printOrder', width:80, align:'center',xmlmap:'printOrder'}]" + "</colModel>";

        xml = xml + "<colData>";
        xml = xml + "[";
        xml = xml + "{<issues>10</issues>,<printOrder>10</printOrder>},";
        xml = xml + "{<issues>20</issues>,<printOrder>20</printOrder>}";
        xml = xml + "]";
        xml = xml + "</colData>";

        xml = xml + "</results>";

        return (xml);
    }

    public String printOrderTableDetailsList() throws SQLException, IllegalAccessException, InvocationTargetException {

        printOrderFormBeanReport printOrderFormBeanReport = new IAS.Bean.Reports.printOrderFormBeanReport();
        request.setAttribute("printOrderFormBeanReport", printOrderFormBeanReport);
        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, printOrderFormBeanReport);

        int year = printOrderFormBeanReport.getYear();

        String sql = Queries.getQuery("get_max_no_of_issues");
        try (Connection conn = this.getConnection(); PreparedStatement st = conn.prepareStatement(sql);) {
            st.setInt(1, year);
            try (ResultSet rs = st.executeQuery()) {
                int maxNoOfIssues = 0;
                if (rs.next()) {
                    maxNoOfIssues = rs.getInt(1);
                }
            }

            String xml = "";
            xml = xml + "<?xml version='1.0' encoding='utf-8'?>\n";
            xml = xml + "<results>";

            sql = Queries.getQuery("get_list_of_journals");
            try (PreparedStatement st2 = conn.prepareStatement(sql); ResultSet rsLJ = st2.executeQuery()) {

                ResultSetMetaData rsmd = rsLJ.getMetaData();
                String colName = rsmd.getColumnName(1);

                // Loop over every journal
                while (rsLJ.next()) {
                    xml = xml + "<row>";
                    String journalCode = rsLJ.getString(1);

                    xml = xml + "<" + colName + ">" + journalCode + "</" + colName + ">";

                    int issueNo = 1;
                    // Loop over volume nos
                    String sql1 = Queries.getQuery("get_volume_number");
                    try (PreparedStatement st1 = conn.prepareStatement(sql1);) {
                        st1.setString(1, journalCode);
                        st1.setInt(2, year);
                        try (ResultSet rsNI1 = st1.executeQuery()) {

                            while (rsNI1.next()) {

                                int volume_number = rsNI1.getInt(1);

                                int noOfIssuesPerVolume = getNoOfIssuesPerVolume(journalCode, volume_number);
                                // Loop over no of issues in that volume
                                for (int j = 1; j <= noOfIssuesPerVolume; j++) {

                                    sql = Queries.getQuery("get_print_order");
                                    try (PreparedStatement st3 = conn.prepareStatement(sql);) {
                                        int paramIndex = 1;
                                        st3.setInt(paramIndex++, year);
                                        st3.setString(paramIndex++, journalCode);
                                        st3.setInt(paramIndex++, j);
                                        st3.setInt(paramIndex++, volume_number);
                                        try (ResultSet rsPO = st3.executeQuery()) {
                                            String print_order = "";
                                            if (rsPO.next()) {
                                                print_order = Integer.toString(rsPO.getInt(1));
                                            }
                                            xml = xml + "<col" + issueNo + ">";
                                            xml = xml + print_order;
                                            xml = xml + "</col" + issueNo + ">";
                                        }

                                        issueNo++;
                                    }
                                }
                            }
                        }
                    }

                    // Get Max no of issues for this journal journals
                    int maxNoOfIssuesForJournal = getMaxNoOfIssuesFromAllJournals(year);
                    int residualIssues = maxNoOfIssuesForJournal - (issueNo - 1);

                    for (int i = 0; i < residualIssues; i++) {
                        xml = xml + "<col" + issueNo + ">" + "NA" + "</col" + issueNo + ">";
                        issueNo++;
                    }

                    xml = xml + "</row>";
                }
            }
            xml = xml + "</results>";

            return (xml);
        }
    }

    public int getNoOfIssuesPerVolume(String journalCode, int volume_number) throws SQLException {
        int maxNoOfIssues = 0;
        String sql = Queries.getQuery("getissuesPO");
        try (Connection conn = this.getConnection(); PreparedStatement st = conn.prepareStatement(sql);) {
            st.setString(1, journalCode);
            st.setInt(2, volume_number);
            try (ResultSet rsNI = st.executeQuery()) {
                if (rsNI.next()) {
                    maxNoOfIssues = rsNI.getInt(1);
                }
            }
        }
        return maxNoOfIssues;
    }

    public int getMaxNoOfIssuesFromAllJournals(int year) throws SQLException {
        String sql = Queries.getQuery("get_max_no_of_issues");
        int maxNoOfIssues = 0;
        try (Connection conn = this.getConnection(); PreparedStatement st = conn.prepareStatement(sql);) {
            st.setInt(1, year);
            try (ResultSet rsNI = st.executeQuery();) {
                if (rsNI.next()) {
                    maxNoOfIssues = rsNI.getInt(1);
                }
            }
        }
        return maxNoOfIssues;
    }

    public int getMaxNoOfIssuesForJournal(String journalCode, int year) throws SQLException {
        String sql = Queries.getQuery("get_no_of_issues");
        int maxNoOfIssues = 0;
        try (Connection conn = this.getConnection(); PreparedStatement st = conn.prepareStatement(sql);) {
            st.setString(1, journalCode);
            st.setInt(2, year);
            try (ResultSet rsNI = st.executeQuery()) {

                if (rsNI.next()) {
                    maxNoOfIssues = rsNI.getInt(1);
                }
            }
        }
        return maxNoOfIssues;
    }

    public void contructTableForPrintOrderReport() throws SQLException, ParserConfigurationException, SAXException, IOException, IllegalAccessException, InvocationTargetException {

        //printOrderFormBeanReport _printOrderFormBeanReport = new IAS.Bean.Reports.printOrderFormBeanReport();
        //request.setAttribute("printOrderFormBeanReport", _printOrderFormBeanReport);
        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        //FillBean(this.request, _printOrderFormBeanReport);
        int year = Calendar.getInstance().get(Calendar.YEAR);
        int maxNoOfIssues = 0;
        String sql = Queries.getQuery("get_max_no_of_issues");
        try (Connection conn = this.getConnection(); PreparedStatement st = conn.prepareStatement(sql);) {
            st.setInt(1, year);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                maxNoOfIssues = rs.getInt(1);
            }
        }

        String colNames = "['Journal',";
        String colModel = "[" + "{name:'journalCode', index:'journalCode', xmlmap:'journalCode'},";
        for (int i = 1; i <= maxNoOfIssues; i++) {
            colNames = colNames + "'" + i + "'";
            colModel = colModel + "{name:'col" + i + "'," + "index:'col" + i + "'," + "align:'center'," + "xmlmap:'col" + i + "'}";

            if (i != maxNoOfIssues) {
                colNames = colNames + ",";
                colModel = colModel + ",";
            }

            if (i == maxNoOfIssues) {
                colNames = colNames + "]";
                colModel = colModel + "]";
            }
        }

        printOrderFormBeanReport _printOrderFormBeanReport = new IAS.Bean.Reports.printOrderFormBeanReport();
        _printOrderFormBeanReport.setColM(colModel);
        _printOrderFormBeanReport.setColN(colNames);
        request.setAttribute("printOrderFormBeanReport", _printOrderFormBeanReport);

    }

    public String printOrderTableDetailsTest() {
        String xml = "";
        xml = xml + "<?xml version='1.0' encoding='utf-8'?>\n";
        xml = xml + "<results>";
        //xml = xml + "<colData>"  + "</colData>";
        //xml = xml + "<colNames>" + "['Issue No','Print Order']" + "</colNames>";
        //xml = xml + "<colModel>" + "[{name:'issues', index:'issues', width:80, align:'center', xmlmap:'issues'},{name:'printOrder', index:'printOrder', width:80, align:'center',xmlmap:'printOrder'}]" +"</colModel>";
        //xml = xml + "<colModel>" + "[{name:'issues', index:'issues', xmlmap:'issues'},{name:'printOrder', index:'printOrder', xmlmap:'printOrder'}]" +"</colModel>";

        xml = xml + "<rows>";
        xml = xml + "<issues>" + "10" + "</issues>";
        xml = xml + "<printOrder>" + "20" + "</printOrder>";
        xml = xml + "</rows>";

        xml = xml + "<rows>";
        xml = xml + "<issues>" + "30" + "</issues>";
        xml = xml + "<printOrder>" + "40" + "</printOrder>";
        xml = xml + "</rows>";

        xml = xml + "</results>";

        return (xml);
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
        try (Connection conn = this.getConnection(); PreparedStatement stGetJournals = conn.prepareStatement(sql);
                ResultSet rs1 = stGetJournals.executeQuery();) {

            while (rs1.next()) {
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
                try (PreparedStatement stGetSubType = conn.prepareStatement(sqlSubType);
                        ResultSet rs2 = stGetSubType.executeQuery();) {

                    //int k=0;
                    while (rs2.next()) {
                        String subtypecode = rs2.getString(1);
                        int paramIndex = 1;
                        String sqlSubFigures = null;
                        sqlSubFigures = Queries.getQuery("subscription_Figures");
                        Calendar cal = Calendar.getInstance();
                        int currYear = cal.get(Calendar.YEAR);
                        String date = "";
                        if (Integer.parseInt(year) == currYear) {

                            sqlSubFigures += " and curdate()";

                        } else {

                            date = year + "-12-31";
                            date = "date_format(" + '"' + date + '"' + ",'%y/%m/%d')";
                            sqlSubFigures += " and " + date;
                        }
                        sqlSubFigures += " BETWEEN date_format( concat(subscriptiondetails.startYear, '-', subscriptiondetails.startMonth, '-', '1'), '%Y/%m/%d')";
                        sqlSubFigures += " AND LAST_DAY(concat(subscriptiondetails.endYear, '-', subscriptiondetails.endMonth, '-', '1')) and subscriptiondetails.active = '1'";
                        sqlSubFigures += " GROUP BY journals.journalCode AND subscriber_type.subtypecode";

                        try (PreparedStatement stGetFigures = conn.prepareStatement(sqlSubFigures);) {
                            stGetFigures.setString(paramIndex, journalCode);
                            stGetFigures.setString(++paramIndex, subtypecode);

                            try (ResultSet rs3 = stGetFigures.executeQuery()) {
                                int subscriberCount = 0;
                                int copies = 0;
                                if (rs3.next()) {
                                    subscriberCount = rs3.getInt(1);
                                    copies = rs3.getInt(2);
                                }
                                totalNoOfSubscribers = totalNoOfSubscribers + subscriberCount;
                                totalNoOfCopies = totalNoOfCopies + copies;

                                Element _subType = doc.createElement(subtypecode + "-No");
                                row.appendChild(_subType);
                                _subType.appendChild(doc.createTextNode(Integer.toString(subscriberCount)));

                                Element _subCount = doc.createElement(subtypecode + "-C");
                                row.appendChild(_subCount);
                                _subCount.appendChild(doc.createTextNode(Integer.toString(copies)));
                            }
                        }
                    }
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

    @SuppressWarnings("empty-statement")
    public String subscriptionFiguresLegacy() throws SQLException, ParseException, ParserConfigurationException, TransformerException, SAXException, IOException {

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
        try (Connection conn = this.getConnection(); PreparedStatement stGetJournals = conn.prepareStatement(sql);
                ResultSet rs1 = stGetJournals.executeQuery()) {

            // Should be the size of the total no of subscribers
            //int[] tNoS = new int[16];
            //int[] tNoC = new int[16];
            while (rs1.next()) {
                int totalNoOfSubscribers = 0;
                int totalNoOfCopies = 0;
                String journalCode = rs1.getString(1);

                // Add the row element
                Element row = doc.createElement("row");
                results.appendChild(row);

                Element _journalCode = doc.createElement("journalCode");
                row.appendChild(_journalCode);
                _journalCode.appendChild(doc.createTextNode(journalCode));

                String subTypes[] = {"Inst_I", "Inst_A", "IND_I", "IND_A", "COMP"};
                String subTypesQueries[]
                        = {"(subscriber_type.subtypecode = 'II' OR subscriber_type.subtypecode = 'IN' OR subscriber_type.subtypecode = 'IC' OR subscriber_type.subtypecode = 'MEMBER')",
                            "(subscriber_type.subtypecode = 'FI')",
                            "(subscriber_type.subtypecode = 'IP' OR subscriber_type.subtypecode = 'LSP')",
                            "(subscriber_type.subtypecode = 'FP')",
                            "(subscriber_type.subtypecode = 'AS' OR subscriber_type.subtypecode = 'EBALL' OR subscriber_type.subtypecode = 'EF' OR subscriber_type.subtypecode = 'EI' OR subscriber_type.subtypecode = 'FELJM' OR subscriber_type.subtypecode = 'GRANT' OR subscriber_type.subtypecode = 'HONFEL' OR subscriber_type.subtypecode = 'WC')"
                        };
                // This is funny but this is how the report is generated by Peter.
                // Calculation of II and COMP is different for II
                if (journalCode.equals("CURR")) {
                    //subTypesQueries[0] = {"(subscriber_type.subtypecode = 'II' OR subscriber_type.subtypecode = 'IN' OR subscriber_type.subtypecode = 'IC' OR subscriber_type.subtypecode = 'MEMBER')"};
                    subTypesQueries = new String[]{"(subscriber_type.subtypecode = 'II' OR subscriber_type.subtypecode = 'IN' OR subscriber_type.subtypecode = 'IC' OR subscriber_type.subtypecode = 'MEMBER')",
                        "(subscriber_type.subtypecode = 'FI')",
                        "(subscriber_type.subtypecode = 'IP')",
                        "(subscriber_type.subtypecode = 'FP')",
                        "(subscriber_type.subtypecode = 'AS' OR subscriber_type.subtypecode = 'EBALL' OR subscriber_type.subtypecode = 'EF' OR subscriber_type.subtypecode = 'EI' OR subscriber_type.subtypecode = 'FELJM' OR subscriber_type.subtypecode = 'GRANT' OR subscriber_type.subtypecode = 'HONFEL' OR subscriber_type.subtypecode = 'WC' OR subscriber_type.subtypecode = 'LSP')"
                    };
                }

                for (int i = 0; i < subTypes.length; i++) {
                    String sqlSubFigures = null;
                    int paramIndex = 1;

                    sqlSubFigures = Queries.getQuery("subscription_Figures_Legacy");
                    sqlSubFigures = sqlSubFigures + " AND " + subTypesQueries[i];
                    Calendar cal = Calendar.getInstance();
                    int currYear = cal.get(Calendar.YEAR);
                    String date = "";
                    if (Integer.parseInt(year) == currYear) {
                        sqlSubFigures += " AND curdate()";
                    } else {
                        date = year + "-12-31";
                        date = "date_format(" + '"' + date + '"' + ",'%y/%m/%d')";
                        sqlSubFigures += " and " + date;
                    }
                    sqlSubFigures += " BETWEEN date_format( concat(subscriptiondetails.startYear, '-', subscriptiondetails.startMonth, '-', '1'), '%Y/%m/%d')";
                    sqlSubFigures += " AND LAST_DAY(concat(subscriptiondetails.endYear, '-', subscriptiondetails.endMonth, '-', '1')) and subscriptiondetails.active = '1'";
                    sqlSubFigures += " GROUP BY journals.journalCode AND subscriber_type.subtypecode";

                    try (PreparedStatement stGetFigures = conn.prepareStatement(sqlSubFigures)) {
                        stGetFigures.setString(paramIndex, journalCode);

                        try (ResultSet rs3 = stGetFigures.executeQuery()) {
                            int subscriberCount = 0;
                            int copies = 0;
                            if (rs3.next()) {
                                subscriberCount = rs3.getInt(1);
                                copies = rs3.getInt(2);
                            }

                            if (i == (subTypes.length - 1)) {
                                Element _subCountTotal = doc.createElement("SUB_COPIES");
                                row.appendChild(_subCountTotal);
                                _subCountTotal.appendChild(doc.createTextNode(Integer.toString(totalNoOfCopies)));
                            }

                            totalNoOfSubscribers = totalNoOfSubscribers + subscriberCount;
                            totalNoOfCopies = totalNoOfCopies + copies;

                            Element _subCount = doc.createElement(subTypes[i]);
                            row.appendChild(_subCount);
                            _subCount.appendChild(doc.createTextNode(Integer.toString(copies)));
                        }
                    }

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

    public void constructTableSubcriptionFigures() throws SQLException, ParserConfigurationException, SAXException, IOException, IllegalAccessException, InvocationTargetException {

        String sql = Queries.getQuery("subscriber_type");
        try (Connection conn = this.getConnection(); PreparedStatement st = conn.prepareStatement(sql); ResultSet rs = st.executeQuery();) {

            int maxNoOfIssues = 0;

            String colNames = "['Journal',";
            String colModel = "[" + "{name:'journalCode', index:'journalCode', xmlmap:'journalCode'},";

            while (rs.next()) {
                String subtypecode = rs.getString(1);
                colNames = colNames + "'" + subtypecode + "-No'";
                colNames = colNames + ",";
                colNames = colNames + "'" + subtypecode + "-C'";
                colModel = colModel + "{name:'" + subtypecode + "-No'," + "index:'" + subtypecode + "-No'," + "align:'center'," + "xmlmap:'" + subtypecode + "-No'}";
                colModel = colModel + ",";
                colModel = colModel + "{name:'" + subtypecode + "-C'," + "index:'" + subtypecode + "-C'," + "align:'center'," + "xmlmap:'" + subtypecode + "-C'}";

                if (rs.isLast() == false) {
                    colNames = colNames + ",";
                    colModel = colModel + ",";
                } else {
                    colNames = colNames + ",'Total-No'";
                    colNames = colNames + ",";
                    colNames = colNames + "'Total-C'";

                    colModel = colModel + ",{name:'" + "Total" + "-No'," + "index:'" + "Total" + "-No'," + "align:'center'," + "xmlmap:'" + "Total" + "-No'}";
                    colModel = colModel + ",";
                    colModel = colModel + "{name:'" + "Total" + "-C'," + "index:'" + "Total" + "-C'," + "align:'center'," + "xmlmap:'" + "Total" + "-C'}";

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

    public String listInvoice() throws SQLException, ParseException, ParserConfigurationException, TransformerException, SAXException, IOException {
        String from = request.getParameter("from");
        String to = request.getParameter("to");
        String invoiceType = request.getParameter("invoiceType");
        String all = request.getParameter("totalBalance");
        String xml = null;
        int totalBalance = 0;
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document doc = builder.newDocument();
        Element results = doc.createElement("results");
        doc.appendChild(results);
        int paramIndex = 1;
        int count = 0;

        // For current Data
        String sqlcurr = Queries.getQuery("get_current_invoice");
        if (from != null && from.length() > 0 && to != null && to.length() > 0) {
            sqlcurr += " and invoice.invoiceCreationDate between " + "STR_TO_DATE(" + '"' + from + '"' + ",'%d/%m/%Y')" + " and " + "STR_TO_DATE(" + '"' + to + '"' + ",'%d/%m/%Y')";
        }
        sqlcurr += " group by invoice.id";
        try (Connection conn = this.getConnection(); PreparedStatement stGetCurr = conn.prepareStatement(sqlcurr);) {
            paramIndex = 1;
            stGetCurr.setString(paramIndex, invoiceType);
            try (ResultSet rsCurr = stGetCurr.executeQuery()) {

                // Get list of all subscribers who have a balance
                while (rsCurr.next()) {
                    String subscriberNumber = rsCurr.getString("subscriberNumber");
                    int subscriptionId = rsCurr.getInt("subscriptionId");
                    String journalCode = "";
                    int amount = rsCurr.getInt("amount");
                    String proInvNo = rsCurr.getString("proInvNo");
                    if (proInvNo == null || proInvNo.isEmpty()) {
                        proInvNo = "-";
                    }
                    String proInvDate = rsCurr.getString("proInvDate");
                    int startYear = 0;
                    int endYear = 0;
                    int newStart = 0;
                    int newEnd = 0;
                    String period = "";
                    int subexists = 0;

                    String sqljournalsCurr = Queries.getQuery("get_sub_journals_inv");
                    try (PreparedStatement stGetJournals = conn.prepareStatement(sqljournalsCurr)) {
                        stGetJournals.setInt(paramIndex, subscriptionId);
                        try (ResultSet rsJournals = stGetJournals.executeQuery()) {

                            // Get the list of journals
                            while (rsJournals.next()) {
                                if (journalCode.equals("")) {
                                    journalCode += rsJournals.getString(1);
                                } else {
                                    journalCode += ", " + rsJournals.getString(1);
                                }
                                if (startYear == 0 && endYear == 0) {
                                    startYear = rsJournals.getInt("startYear");
                                    endYear = rsJournals.getInt("endYear");
                                    newStart = startYear;
                                    newEnd = endYear;
                                } else {
                                    newStart = rsJournals.getInt("startYear");
                                    newEnd = rsJournals.getInt("endYear");
                                    if (newStart < startYear) {
                                        startYear = newStart;
                                    }
                                    if (newEnd < endYear) {
                                        endYear = newEnd;
                                    }
                                }
                                subexists = 1;
                            }
                        }
                    }

                    period = startYear + "-" + endYear;

                    if (subexists == 1) {

                        totalBalance = totalBalance + amount;

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

                        Element _balance = doc.createElement("amount");
                        row.appendChild(_balance);
                        _balance.appendChild(doc.createTextNode(Integer.toString(amount)));

                        Element _proInvNo = doc.createElement("proInvNo");
                        row.appendChild(_proInvNo);
                        _proInvNo.appendChild(doc.createTextNode(proInvNo));

                        Element _proInvDate = doc.createElement("proInvDate");
                        row.appendChild(_proInvDate);
                        _proInvDate.appendChild(doc.createTextNode(proInvDate));

                        subexists = 0;
                    }
                }
            }

            // For Agent Balance
            String sql = Queries.getQuery("get_agent_inoive");

            if (from != null && from.length() > 0 && to != null && to.length() > 0) {
                sql += " and agent_invoice.invoiceCreationDate between " + "STR_TO_DATE(" + '"' + from + '"' + ",'%d/%m/%Y')" + " and " + "STR_TO_DATE(" + '"' + to + '"' + ",'%d/%m/%Y')";
            }

            sql += " group by agent_invoice.id";
            try (PreparedStatement stGet = conn.prepareStatement(sql);) {
                stGet.setString(paramIndex, invoiceType);
                try (ResultSet rs = stGet.executeQuery()) {

                    while (rs.next()) {
                        String agentName = rs.getString("agentName");
                        int agentId = rs.getInt("agentId");
                        int amount = rs.getInt("amount");

                        String proInvNo = rs.getString("proInvNo");
                        if (proInvNo.equals(null) || proInvNo.equals("")) {
                            proInvNo = "-";
                        }
                        String proInvDate = rs.getString("proInvDate");

                        int startYear = 0;
                        int endYear = 0;
                        int newStart = 0;
                        int newEnd = 0;
                        String period = "";
                        String subscriberNumber = "";
                        int subexists = 0;
                        String sqlSub = Queries.getQuery("get_agent_subscribers_inv");

                        try (PreparedStatement stGetSub = conn.prepareStatement(sqlSub);) {
                            stGetSub.setInt(paramIndex, agentId);
                            try (ResultSet rsSub = stGetSub.executeQuery()) {
                                while (rsSub.next()) {

                                    if (subscriberNumber.equals("")) {
                                        subscriberNumber += rsSub.getString("subscriberNumber");
                                    } else {
                                        subscriberNumber += ", " + rsSub.getString("subscriberNumber");
                                    }
                                    if (startYear == 0 && endYear == 0) {
                                        startYear = rsSub.getInt("startYEar");
                                        endYear = rsSub.getInt("endYear");
                                        newStart = startYear;
                                        newEnd = endYear;
                                    } else {
                                        newStart = rsSub.getInt("startYEar");
                                        newEnd = rsSub.getInt("endYear");
                                        if (newStart < startYear) {
                                            startYear = newStart;
                                        }
                                        if (newEnd < endYear) {
                                            endYear = newEnd;
                                        }
                                    }
                                    subexists = 1;
                                }
                            }
                        }

                        if (subexists == 1) {

                            totalBalance = totalBalance + amount;

                            Element row = doc.createElement("row");
                            results.appendChild(row);

                            Element _subscriberNumber = doc.createElement("subscriberNumber");
                            row.appendChild(_subscriberNumber);
                            _subscriberNumber.appendChild(doc.createTextNode(subscriberNumber));

                            Element _journalCode = doc.createElement("journalCode");
                            row.appendChild(_journalCode);
                            _journalCode.appendChild(doc.createTextNode(agentName));

                            Element _period = doc.createElement("period");
                            row.appendChild(_period);
                            _period.appendChild(doc.createTextNode(period));

                            Element _balance = doc.createElement("amount");
                            row.appendChild(_balance);
                            _balance.appendChild(doc.createTextNode(Integer.toString(amount)));

                            Element _proInvNo = doc.createElement("proInvNo");
                            row.appendChild(_proInvNo);
                            _proInvNo.appendChild(doc.createTextNode(proInvNo));

                            Element _proInvDate = doc.createElement("proInvDate");
                            row.appendChild(_proInvDate);
                            _proInvDate.appendChild(doc.createTextNode(proInvDate));

                            subexists = 0;
                        }

                    }
                }
            }
        }

        // For total Row
        Element row = doc.createElement("row");
        results.appendChild(row);

        Element _subscriberNumber = doc.createElement("subscriberNumber");
        row.appendChild(_subscriberNumber);
        _subscriberNumber.appendChild(doc.createTextNode("-"));

        Element _journalCode = doc.createElement("journalCode");
        row.appendChild(_journalCode);
        _journalCode.appendChild(doc.createTextNode("Total Amount -->"));

        Element _period = doc.createElement("period");
        row.appendChild(_period);
        _period.appendChild(doc.createTextNode("-"));

        Element _balance = doc.createElement("amount");
        row.appendChild(_balance);
        _balance.appendChild(doc.createTextNode(Integer.toString(totalBalance)));

        Element _proInvNo = doc.createElement("proInvNo");
        row.appendChild(_proInvNo);
        _proInvNo.appendChild(doc.createTextNode("-"));

        Element _proInvDate = doc.createElement("proInvDate");
        row.appendChild(_proInvDate);
        _proInvDate.appendChild(doc.createTextNode("-"));

        DOMSource domSource = new DOMSource(doc);
        //checkForNullTextNodes();
        try (StringWriter writer = new StringWriter()) {
            StreamResult result = new StreamResult(writer);
            TransformerFactory tf = TransformerFactory.newInstance();
            Transformer transformer = tf.newTransformer();
            transformer.transform(domSource, result);
            xml = writer.toString();
        }
        return xml;
    }

    public CachedRowSetImpl listReminders() throws SQLException, ParseException, ParserConfigurationException, TransformerException {

        String fromDate = request.getParameter("from");
        String toDate = request.getParameter("to");

        String sql = Queries.getQuery("list_reminders_subscriber");

        if (fromDate != null && fromDate.length() > 0 && toDate != null && toDate.length() > 0) {
            sql += " and reminders.reminderDate between " + "STR_TO_DATE(" + '"' + fromDate + '"' + ",'%d/%m/%Y')" + " and " + "STR_TO_DATE(" + '"' + toDate + '"' + ",'%d/%m/%Y')";
        }
        CachedRowSetImpl crs = new CachedRowSetImpl();
        try (Connection conn = this.getConnection(); PreparedStatement stGet = conn.prepareStatement(sql);) {
            int paramIndex = 1;
            stGet.setString(paramIndex, request.getParameter("remType"));
            try (ResultSet rs = stGet.executeQuery()) {
                crs.populate(rs);
            }
        }
        return crs;

    }

    public String outstaningBalnace() throws SQLException, ParseException, ParserConfigurationException, TransformerException, IOException {

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
        int paramIndex = 1;
        int count = 0;

        // For current Data
        String sqlcurr = Queries.getQuery("get_current_balance");
        try (Connection conn = this.getConnection(); PreparedStatement stGetCurr = conn.prepareStatement(sqlcurr);) {
            paramIndex = 1;
            try (ResultSet rsCurr = stGetCurr.executeQuery()) {

                // Get list of all subscribers who have a balance
                while (rsCurr.next()) {
                    String subscriberNumber = rsCurr.getString("subscriberNumber");
                    int subscriptionId = rsCurr.getInt("subscriptionId");
                    String journalCode = "";
                    int amount = rsCurr.getInt("amount");
                    int payment = rsCurr.getInt("payment");
                    int balance = amount - payment;
                    String proInvNo = rsCurr.getString("proInvNo");
                    if (proInvNo == null || proInvNo.isEmpty()) {
                        proInvNo = "-";
                    }
                    String proInvDate = rsCurr.getString("proInvDate");
                    proInvDate = util.changeDateFormat(proInvDate);
                    int startYear = 0;
                    int endYear = 0;
                    int newStart = 0;
                    int newEnd = 0;
                    String period = "";
                    int subexists = 0;

                    String sqljournalsCurr = Queries.getQuery("get_sub_journals");
                    //String sqljournals = Queries.getQuery("get_sub_journals");
                    if (subEnd != 0) {
                        sqljournalsCurr += " and subscriptiondetails.endYear  = " + subEnd;
                    } else if (periodStart != 0 && periodEnd != 0) {
                        sqljournalsCurr += " and subscriptiondetails.startYear  >= " + periodStart;
                        sqljournalsCurr += " and subscriptiondetails.endYear  <= " + periodEnd;
                    }

                    try (PreparedStatement stGetJournals = conn.prepareStatement(sqljournalsCurr)) {
                        stGetJournals.setInt(paramIndex, subscriptionId);
                        try (ResultSet rsJournals = stGetJournals.executeQuery()) {

                            // Get the list of journals
                            while (rsJournals.next()) {
                                if (journalCode.equals("")) {
                                    journalCode += rsJournals.getString(1);
                                } else {
                                    journalCode += ", " + rsJournals.getString(1);
                                }
                                if (startYear == 0 && endYear == 0) {
                                    startYear = rsJournals.getInt("startYEar");
                                    endYear = rsJournals.getInt("endYear");
                                    newStart = startYear;
                                    newEnd = endYear;
                                } else {
                                    newStart = rsJournals.getInt("startYEar");
                                    newEnd = rsJournals.getInt("endYear");
                                    if (newStart < startYear) {
                                        startYear = newStart;
                                    }
                                    if (newEnd < endYear) {
                                        endYear = newEnd;
                                    }
                                }
                                subexists = 1;
                            }
                        }
                    }

                    period = startYear + "-" + endYear;

                    if (subexists == 1 && balance > 0) {

                        if (subscriberNumber == null || journalCode == null || period == null
                                || Integer.toString(balance) == null || proInvNo == null || proInvDate == null) {
                            logger.fatal("Count: " + count++ + " " + "Subscriber No: " + " " + subscriberNumber);
                        }

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
            }

            // For Agent Balance
            String sql = Queries.getQuery("get_agent_balance");
            try (PreparedStatement stGet = conn.prepareStatement(sql)) {

                try (ResultSet rs = stGet.executeQuery()) {

                    while (rs.next()) {
                        String agentName = rs.getString("agentName");
                        int agentId = rs.getInt("agentId");
                        int amount = rs.getInt("amount");
                        int payment = rs.getInt("payment");;
                        int balance = 0;

                        String proInvNo = rs.getString("proInvNo");
                        if (proInvNo.equals(null) || proInvNo.equals("")) {
                            proInvNo = "-";
                        }
                        String proInvDate = rs.getString("proInvDate");
                        proInvDate = util.changeDateFormat(proInvDate);

                        int startYear = 0;
                        int endYear = 0;
                        int newStart = 0;
                        int newEnd = 0;
                        String period = "";
                        String subscriberNumber = "";

                        balance = amount - payment;
                        int subexists = 0;
                        String sqlSub = Queries.getQuery("get_agent_subscribers");
                        if (periodStart != 0 && periodEnd != 0) {
                            sqlSub += " and subscriptiondetails.startYear  >= " + periodStart;
                            sqlSub += " and subscriptiondetails.endYear  <= " + periodEnd;
                        }
                        sqlSub += " group by subscription.id order by subscriber.subscriberNumber";

                        try (PreparedStatement stGetSub = conn.prepareStatement(sqlSub)) {
                            stGetSub.setInt(paramIndex, agentId);
                            try (ResultSet rsSub = stGetSub.executeQuery();) {

                                while (rsSub.next()) {

                                    if (subscriberNumber.equals("")) {
                                        subscriberNumber += rsSub.getString("subscriberNumber");
                                    } else {
                                        subscriberNumber += ", " + rsSub.getString("subscriberNumber");
                                    }
                                    if (startYear == 0 && endYear == 0) {
                                        startYear = rsSub.getInt("startYEar");
                                        endYear = rsSub.getInt("endYear");
                                        newStart = startYear;
                                        newEnd = endYear;
                                    } else {
                                        newStart = rsSub.getInt("startYEar");
                                        newEnd = rsSub.getInt("endYear");
                                        if (newStart < startYear) {
                                            startYear = newStart;
                                        }
                                        if (newEnd < endYear) {
                                            endYear = newEnd;
                                        }
                                    }
                                    subexists = 1;
                                }
                            }
                        }

                        if (subexists == 1 && balance > 0) {

                            totalBalance = totalBalance + balance;

                            Element row = doc.createElement("row");
                            results.appendChild(row);

                            Element _subscriberNumber = doc.createElement("subscriberNumber");
                            row.appendChild(_subscriberNumber);
                            _subscriberNumber.appendChild(doc.createTextNode(subscriberNumber));

                            Element _journalCode = doc.createElement("journalCode");
                            row.appendChild(_journalCode);
                            _journalCode.appendChild(doc.createTextNode(agentName));

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
                }
            }
        }

        // For total Row
        Element row = doc.createElement("row");
        results.appendChild(row);

        Element _subscriberNumber = doc.createElement("subscriberNumber");
        row.appendChild(_subscriberNumber);
        _subscriberNumber.appendChild(doc.createTextNode("-"));

        Element _journalCode = doc.createElement("journalCode");
        row.appendChild(_journalCode);
        _journalCode.appendChild(doc.createTextNode("Total Balance -->"));

        Element _period = doc.createElement("period");
        row.appendChild(_period);
        _period.appendChild(doc.createTextNode("-"));

        Element _balance = doc.createElement("balance");
        row.appendChild(_balance);
        _balance.appendChild(doc.createTextNode(Integer.toString(totalBalance)));

        Element _proInvNo = doc.createElement("proInvNo");
        row.appendChild(_proInvNo);
        _proInvNo.appendChild(doc.createTextNode("-"));

        Element _proInvDate = doc.createElement("proInvDate");
        row.appendChild(_proInvDate);
        _proInvDate.appendChild(doc.createTextNode("-"));

        DOMSource domSource = new DOMSource(doc);
        //checkForNullTextNodes();
        try (StringWriter writer = new StringWriter()) {
            StreamResult result = new StreamResult(writer);
            TransformerFactory tf = TransformerFactory.newInstance();
            Transformer transformer = tf.newTransformer();
            transformer.transform(domSource, result);
            xml = writer.toString();
        }

        return xml;

    }

    public CachedRowSetImpl gml() throws SQLException, ParseException, ParserConfigurationException, TransformerException {

        String sql;
        String xml = null;
        int year = Integer.parseInt(request.getParameter("year"));
        sql = Queries.getQuery("gml");
        CachedRowSetImpl crs = new CachedRowSetImpl();
        try (Connection conn = this.getConnection(); PreparedStatement stGet = conn.prepareStatement(sql);) {
            stGet.setInt(1, year);
            try (ResultSet rs = stGet.executeQuery()) {
                crs.populate(rs);
            }
        }
        return crs;
    }
}

/*
 void checkForNullTextNodes() {
 //Document doc
 }
 */
