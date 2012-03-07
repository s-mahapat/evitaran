/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.Inward;

import IAS.Bean.Inward.inwardFormBean;
import IAS.Class.Queries;
import IAS.Class.util;
import IAS.Model.JDSModel;
import java.io.IOException;
import java.io.StringReader;
import java.io.StringWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Calendar;
import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import org.apache.commons.dbutils.BeanProcessor;
import java.lang.Math;
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
 * @author Shailendra Mahapatra
 */
public class inwardModel extends JDSModel {

    private inwardFormBean _inwardFormBean = null;

    public inwardModel(HttpServletRequest request) throws SQLException {
        //call the base class constructor
        super(request);
        //throw (new SQLException("Database connection not found in the session"));

    }

    public int Save() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException {

        inwardFormBean inwardFormBean = new IAS.Bean.Inward.inwardFormBean();
        request.setAttribute("inwardFormBean", inwardFormBean);
        String sql;

        //throw new SQLException("Generated this exception");

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, inwardFormBean);
        this._inwardFormBean = inwardFormBean;

        // check that the inward number is not present on the screen, if present means its and edit inward else create new inward.

        if (inwardFormBean.getInwardNumber().isEmpty() == false) {
            return this._updateInward();
        } else {

            //get the next inward number
            inwardFormBean.setInwardNumber(getNextInwardNumber());

            // the query name from the jds_sql properties files in WEB-INF/properties folder
            sql = Queries.getQuery("insert_inward");

            PreparedStatement st = conn.prepareStatement(sql);

            // fill in the statement params
            this._setNewInwardStatementParams(st);

            return db.executeUpdatePreparedStatement(st);
        }

    }

    public String editInward() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        return this.GetInward();

    }

    public String viewInward() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        return this.GetInward();

    }

    public String updateChequeReturn() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException{

        inwardFormBean inwardFormBean = new IAS.Bean.Inward.inwardFormBean();
        request.setAttribute("inwardFormBean", inwardFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, inwardFormBean);
        this._inwardFormBean = inwardFormBean;

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("update_cheque_return");

        PreparedStatement st = conn.prepareStatement(sql);
        int paramIndex = 0;
        st.setBoolean(++paramIndex, true);
        st.setString(++paramIndex, inwardFormBean.getChequeDDReturnReason());
        st.setString(++paramIndex, inwardFormBean.getChequeDDReturnReasonOther());
        st.setDate(++paramIndex, util.dateStringToSqlDate(util.getDateString()));
        st.setString(++paramIndex, inwardFormBean.getInwardNumber());

        db.executeUpdatePreparedStatement(st);

        return this.GetInward();

    }

    private int _updateInward() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException {

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("update_inward");

        PreparedStatement st = conn.prepareStatement(sql);

        // fill in the statement params
        this._setUpdateInwardStatementParams(st);

        return db.executeUpdatePreparedStatement(st);

    }

    public String GetInward() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        String sql;
        inwardFormBean inwardFormBean = new IAS.Bean.Inward.inwardFormBean();

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, inwardFormBean);

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        sql = Queries.getQuery("get_inward_by_number");

        PreparedStatement st = conn.prepareStatement(sql);

        st.setString(1, inwardFormBean.getInwardNumber());

        ResultSet rs = db.executeQueryPreparedStatement(st);

        // populate the bean from the resultset using the beanprocessor class
        while (rs.next()) {
            BeanProcessor bProc = new BeanProcessor();
            Class type = Class.forName("IAS.Bean.Inward.inwardFormBean");
            inwardFormBean = (IAS.Bean.Inward.inwardFormBean) bProc.toBean(rs, type);

        }
        rs.close();

        request.setAttribute("inwardFormBean", inwardFormBean);
        return inwardFormBean.getInwardNumber();
    }

    private void _setNewInwardStatementParams(PreparedStatement st) throws SQLException, ParseException {
        int paramIndex = 0;
        st.setString(++paramIndex, _inwardFormBean.getInwardNumber());
        st.setString(++paramIndex, _inwardFormBean.getFrom());
        st.setString(++paramIndex, _inwardFormBean.getCountry());
        st.setString(++paramIndex, _inwardFormBean.getState());
        st.setString(++paramIndex, _inwardFormBean.getDistrict());
        st.setString(++paramIndex, _inwardFormBean.getCity());
        st.setInt(++paramIndex, _inwardFormBean.getPincode());
        st.setString(++paramIndex, _inwardFormBean.getEmail());
        st.setString(++paramIndex, _inwardFormBean.getInstitution());
        st.setString(++paramIndex, _inwardFormBean.getDepartment());
        st.setDate(++paramIndex, util.dateStringToSqlDate(_inwardFormBean.getInwardCreationDate()));
        st.setString(++paramIndex, _inwardFormBean.getSubscriberId());
        st.setString(++paramIndex, _inwardFormBean.getInwardPurpose());
        st.setString(++paramIndex, _inwardFormBean.getPaymentMode());
        st.setString(++paramIndex, _inwardFormBean.getBankName());
        st.setInt(++paramIndex, _inwardFormBean.getChqddNumber());
        st.setDate(++paramIndex, util.dateStringToSqlDate(_inwardFormBean.getPaymentDate()));
        st.setFloat(++paramIndex, _inwardFormBean.getAmount());
        st.setString(++paramIndex, _inwardFormBean.getCurrency());
        st.setBoolean(++paramIndex, _inwardFormBean.isChequeDDReturn());
        st.setString(++paramIndex, _inwardFormBean.getChequeDDReturnReason());
        st.setString(++paramIndex, _inwardFormBean.getChequeDDReturnReasonOther());
        st.setInt(++paramIndex, _inwardFormBean.getReceiptNumber());
        st.setString(++paramIndex, _inwardFormBean.getAckDate());
        st.setString(++paramIndex, _inwardFormBean.getRemarks());
    }

    private void _setUpdateInwardStatementParams(PreparedStatement st) throws SQLException, ParseException {
        int paramIndex = 0;
        st.setString(++paramIndex, _inwardFormBean.getFrom());
        st.setString(++paramIndex, _inwardFormBean.getCountry());
        st.setString(++paramIndex, _inwardFormBean.getState());
        st.setString(++paramIndex, _inwardFormBean.getDistrict());
        st.setString(++paramIndex, _inwardFormBean.getCity());
        st.setInt(++paramIndex, _inwardFormBean.getPincode());
        st.setString(++paramIndex, _inwardFormBean.getEmail());
        st.setString(++paramIndex, _inwardFormBean.getInstitution());
        st.setString(++paramIndex, _inwardFormBean.getDepartment());
        //st.setDate(++paramIndex, util.dateStringToSqlDate(_inwardFormBean.getInwardCreationDate()));
        st.setString(++paramIndex, _inwardFormBean.getSubscriberId());
        st.setString(++paramIndex, _inwardFormBean.getInwardPurpose());
        st.setString(++paramIndex, _inwardFormBean.getPaymentMode());
        st.setString(++paramIndex, _inwardFormBean.getBankName());
        st.setInt(++paramIndex, _inwardFormBean.getChqddNumber());
        st.setDate(++paramIndex, util.dateStringToSqlDate(_inwardFormBean.getPaymentDate()));
        st.setFloat(++paramIndex, _inwardFormBean.getAmount());
        st.setString(++paramIndex, _inwardFormBean.getCurrency());
        st.setBoolean(++paramIndex, _inwardFormBean.isChequeDDReturn());
        st.setString(++paramIndex, _inwardFormBean.getChequeDDReturnReason());
        st.setString(++paramIndex, _inwardFormBean.getChequeDDReturnReasonOther());
        st.setInt(++paramIndex, _inwardFormBean.getReceiptNumber());
        st.setString(++paramIndex, _inwardFormBean.getAckDate());
        st.setString(++paramIndex, _inwardFormBean.getRemarks());
        st.setString(++paramIndex, _inwardFormBean.getInwardNumber());
    }

    /*
     * This method is a synchronized method so that no two get the same inward number
     */
    private synchronized String getNextInwardNumber() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException {

        String nextInward = null;
        //get the last inward number from inward table
        String lastInwardSql = Queries.getQuery("get_last_inward");

        ResultSet rs = db.executeQuery(lastInwardSql);
        Calendar calendar = Calendar.getInstance();


        ResultSetMetaData rsmd = rs.getMetaData();
        //int colCount = rsmd.getColumnCount();
        String lastInward = null;
        int lastInwardYear = 0;
        while (rs.next()) {

            lastInward = rs.getString(1);
            java.sql.Date dt = rs.getDate(2);
            Calendar inCal = Calendar.getInstance();
            inCal.setTime(dt);
            lastInwardYear = inCal.get(Calendar.YEAR);

        }

        //if true there exists a previous inward for the year, so just increment the inward number.
        if (lastInwardYear == calendar.get(Calendar.YEAR)) {

            // get the last inward number after the split
            int inward = Integer.parseInt(lastInward.substring(4));

            //increment
            ++inward;


            //apend the year, month character and new inward number.
            nextInward = lastInward.substring(0, 2) + getMonthToCharacterMap(calendar.get(Calendar.MONTH)) + "-" + String.format("%05d", inward);
        } else {
            // there is no previous record for the year, so start the numbering afresh
            String year = String.valueOf(calendar.get(Calendar.YEAR)).substring(2);
            nextInward = year + getMonthToCharacterMap(calendar.get(Calendar.MONTH)) + "-" + String.format("%05d", 1);
        }

        return nextInward;
    }

    private String getMonthToCharacterMap(int _month) {

        char[] alphabet = "abcdefghijkl".toCharArray();

        // the calendar objects month starts from 0
        String monthChar = Character.toString(alphabet[_month]);
        return monthChar.toUpperCase();

    }

    public String searchInward() throws SQLException, ParseException, ParserConfigurationException, TransformerException, SAXException, IOException {
        String xml = null;
        String sql = Queries.getQuery("search_inward");
        String inwardNumber = request.getParameter("inwardNumber");
        String chequeNumber = request.getParameter("chequeNumber");
        String city = request.getParameter("city");
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        String inwardPurpose = request.getParameter("inwardPurpose");
        int pageNumber = Integer.parseInt(request.getParameter("page"));
        int pageSize = Integer.parseInt(request.getParameter("rows"));
        String orderBy = request.getParameter("sidx");
        String sortOrder = request.getParameter("sord");
        int totalQueryCount = 0;
        double totalPages = 0;

        if (inwardNumber != null && inwardNumber.length() > 0) {
            sql += " and inwardNumber=" + "'" + inwardNumber + "'";
        }

        if (inwardPurpose != null && inwardPurpose.compareToIgnoreCase("NULL") != 0 && inwardPurpose.length() > 0) {
            sql += " and t3.purpose =" + "'" + inwardPurpose + "'";
        }

        if (chequeNumber != null && chequeNumber.length() > 0) {
            sql += " and chqddNumber =" + "'" + chequeNumber + "'";
        }

        if (city != null && city.compareToIgnoreCase("NULL") != 0  && city != null && city.length() > 0) {
            sql += " and t2.id=t1.city and t2.city = " + "\"" + city + "\"";
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

    public String getPendngInwards() throws SQLException, ParseException, ParserConfigurationException, TransformerException{

        String xml = null;

        String sql = Queries.getQuery("pending_inwards");
        String inwardPurpose = request.getParameter("inwardPurpose");
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");

        if (inwardPurpose.compareToIgnoreCase("NULL") != 0 && inwardPurpose != null && inwardPurpose.length() > 0) {
            sql += " and t3.purpose =" + "'" + inwardPurpose + "'";
        }

        if (fromDate != null && fromDate.length() > 0 && toDate != null && toDate.length() > 0) {
            sql += " and inwardCreationDate between " + "STR_TO_DATE(" + '"' + fromDate + '"' + ",'%d/%m/%Y')" + " and " + "STR_TO_DATE(" + '"' + toDate + '"' + ",'%d/%m/%Y')";
        }

        sql += " group by inwardNumber, subscriberId, t1.from, inwardCreationDate, city, chqddNumber, inwardPurpose";

        ResultSet rs = this.db.executeQuery(sql);

        xml = util.convertResultSetToXML(rs);

        return xml;
    }
}
