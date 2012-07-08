/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.Inward;

import IAS.Bean.Invoice.InvoiceFormBean;
import IAS.Bean.Inward.inwardFormBean;
import IAS.Class.Queries;
import IAS.Class.util;
import IAS.Model.JDSModel;
import com.mysql.jdbc.Statement;
import java.io.IOException;
import java.io.InputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Calendar;
import java.util.Properties;
import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import org.apache.commons.dbutils.BeanProcessor;
import org.xml.sax.SAXException;

/**
 *
 * @author Shailendra Mahapatra
 */
public class inwardModel extends JDSModel {

    private inwardFormBean _inwardFormBean = null;
    Properties props = null;

    public inwardModel(HttpServletRequest request) throws SQLException, IOException {
        //call the base class constructor
        super(request);
        //throw (new SQLException("Database connection not found in the session"));
        InputStream is = request.getServletContext().getResourceAsStream("/WEB-INF/classes/email_templates.properties");
        props = new Properties();
        props.load(is);

    }
    
    public inwardModel(){
        
    }

    public int Save() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException {

        inwardFormBean inwardFormBean = new IAS.Bean.Inward.inwardFormBean();
        request.setAttribute("inwardFormBean", inwardFormBean);
        String sql;
        int rc = 0;

        //throw new SQLException("Generated this exception");

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, inwardFormBean);
        this._inwardFormBean = inwardFormBean;

        // check that the inward number is not present on the screen, if present means its and edit inward else create new inward.
        //start of transaction
        conn.setAutoCommit(false);
        if (inwardFormBean.getInwardNumber().isEmpty() == false) {
            rc = this._updateInward();
        } else {

            //get the next inward number
            inwardFormBean.setInwardNumber(getNextInwardNumber());


            // the query name from the jds_sql properties files in WEB-INF/properties folder
            sql = Queries.getQuery("insert_inward");

            PreparedStatement st = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            // fill in the statement params
            this._setNewInwardStatementParams(st);

            rc = st.executeUpdate();
            int subscriptionID = inwardFormBean.getSubscriptionID();
            //update the payment info if subscription id is not null
            if (subscriptionID != 0 && rc == 1) {
                sql = Queries.getQuery("insert_payment");
                PreparedStatement pst = conn.prepareStatement(sql);
                ResultSet rs = st.getGeneratedKeys();
                rs.first();
                int inwardID = rs.getInt(1);
                pst.setInt(1, inwardID);
                pst.setInt(2, subscriptionID);
                rc = pst.executeUpdate();

            }
        }
        conn.commit();
        conn.setAutoCommit(true);
        return rc;

    }

    public inwardFormBean editInward() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        return this.GetInward();

    }

    public inwardFormBean viewInward() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        return this.GetInward();

    }

    public inwardFormBean updateChequeReturn() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

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

        int rc = 0;
        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("update_inward");

        PreparedStatement st = conn.prepareStatement(sql);
        // fill in the statement params
        this._setUpdateInwardStatementParams(st);
        rc = st.executeUpdate();
        int subscriptionID = this._inwardFormBean.getSubscriptionID();
        if(subscriptionID > 0){
            sql = Queries.getQuery("update_payment_info");
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, subscriptionID);
            pst.setString(2, this._inwardFormBean.getInwardNumber());
            rc = pst.executeUpdate();
        }
        return rc;

    }

    public inwardFormBean GetInward() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        String sql;
        inwardFormBean inwardFormBean = new IAS.Bean.Inward.inwardFormBean();

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, inwardFormBean);

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        sql = Queries.getQuery("get_inward_by_number");

        PreparedStatement st = conn.prepareStatement(sql);

        st.setString(1, inwardFormBean.getInwardNumber());

        try (ResultSet rs = db.executeQueryPreparedStatement(st)) {
            while (rs.next()) {
                BeanProcessor bProc = new BeanProcessor();
                Class type = Class.forName("IAS.Bean.Inward.inwardFormBean");
                inwardFormBean = (IAS.Bean.Inward.inwardFormBean) bProc.toBean(rs, type);

            }
        }

        //request.setAttribute("inwardFormBean", inwardFormBean);
        return inwardFormBean;
    }
    
    public inwardFormBean GetInward(String inwardNumber) throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        String sql;
        inwardFormBean inwardFormBean = new IAS.Bean.Inward.inwardFormBean();

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, inwardFormBean);

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        sql = Queries.getQuery("get_inward_by_number");

        PreparedStatement st = conn.prepareStatement(sql);

        st.setString(1, inwardNumber);

        try (ResultSet rs = db.executeQueryPreparedStatement(st)) {
            while (rs.next()) {
                BeanProcessor bProc = new BeanProcessor();
                Class type = Class.forName("IAS.Bean.Inward.inwardFormBean");
                inwardFormBean = (IAS.Bean.Inward.inwardFormBean) bProc.toBean(rs, type);

            }
        }

        //request.setAttribute("inwardFormBean", inwardFormBean);
        return inwardFormBean;
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
        st.setString(++paramIndex, _inwardFormBean.getLanguage());
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
        st.setString(++paramIndex, _inwardFormBean.getLanguage());
        st.setString(++paramIndex, _inwardFormBean.getInwardNumber());
    }

    /*
     * This method is a synchronized method so that no two get the same inward
     * number
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

//    private String getMonthToCharacterMap(int _month) {
//
//        char[] alphabet = "abcdefghijkl".toCharArray();
//
//        // the calendar objects month starts from 0
//        String monthChar = Character.toString(alphabet[_month]);
//        return monthChar.toUpperCase();
//
//    }
    public String searchInward() throws SQLException, ParseException, ParserConfigurationException, TransformerException, SAXException, IOException {
        String xml = null;
        String sql = Queries.getQuery("search_inwards");
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
        String completed = request.getParameter("completed");
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

        if (city != null && city.compareToIgnoreCase("NULL") != 0 && city != null && city.length() > 0) {
            sql += " and t2.id=t1.city and t2.city = " + "\"" + city + "\"";
        }

        if (fromDate != null && fromDate.length() > 0 && toDate != null && toDate.length() > 0) {
            sql += " and inwardCreationDate between " + "STR_TO_DATE(" + '"' + fromDate + '"' + ",'%d/%m/%Y')" + " and " + "STR_TO_DATE(" + '"' + toDate + '"' + ",'%d/%m/%Y')";
        }

        if (completed != null && completed.length() > 0) {
            sql += " and completed=" + completed;
        }
        sql += " group by inwardNumber, subscriberId, t1.from, inwardCreationDate, city, chqddNumber, inwardPurpose order by inwardID " + sortOrder;
        ResultSet rs = this.db.executeQueryPreparedStatementWithPages(sql, pageNumber, pageSize);//this.db.executeQuery(sql);

        sql = "select count(*) from (" + sql + ") as tbl";
        ResultSet rs_count = this.db.executeQuery(sql);
        rs_count.first();
        totalQueryCount = rs_count.getInt(1);
        xml = util.convertResultSetToXML(rs, pageNumber, pageSize, totalQueryCount);
        return xml;
    }

    public String subscriberInward() throws SQLException, ParseException, ParserConfigurationException, TransformerException, SAXException, IOException {
        String xml = null;
        String sql = Queries.getQuery("search_subscriber_inward");
        String ajax_sql = sql + " LIMIT ?, ?";
        String subscriberNumber = request.getParameter("subscriberNumber");
        int pageNumber = Integer.parseInt(request.getParameter("page"));
        int pageSize = Integer.parseInt(request.getParameter("rows"));
        String orderBy = request.getParameter("sidx");
        String sortOrder = request.getParameter("sord");

        int totalQueryCount = 0;
        double totalPages = 0;
        PreparedStatement pst = conn.prepareStatement(ajax_sql);
        pst.setString(1, subscriberNumber);
        pst.setInt(2, (pageSize * (pageNumber - 1)));
        pst.setInt(3, pageSize);
        ResultSet rs = pst.executeQuery();

        sql = "select count(*) from (" + sql + ") as tbl";
        pst = conn.prepareStatement(sql);
        pst.setString(1, subscriberNumber);
        ResultSet rs_count = pst.executeQuery();
        rs_count.first();
        totalQueryCount = rs_count.getInt(1);
        xml = util.convertResultSetToXML(rs, pageNumber, pageSize, totalQueryCount);

        return xml;
    }

    public String getPendngInwards() throws SQLException, ParseException, ParserConfigurationException, TransformerException {

        String xml;

        String sql = Queries.getQuery("pending_inwards");
        String inwardPurpose = request.getParameter("inwardPurpose");
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        int pageNumber = Integer.parseInt(request.getParameter("page"));
        int pageSize = Integer.parseInt(request.getParameter("rows"));
        String orderBy = request.getParameter("sidx");
        String sortOrder = request.getParameter("sord");

        if (inwardPurpose != null && inwardPurpose.compareToIgnoreCase("NULL") != 0 && inwardPurpose.length() > 0) {
            sql += " and t3.purpose =" + "'" + inwardPurpose + "'";
        }

        if (fromDate != null && fromDate.length() > 0 && toDate != null && toDate.length() > 0) {
            sql += " and inwardCreationDate between " + "STR_TO_DATE(" + '"' + fromDate + '"' + ",'%d/%m/%Y')" + " and " + "STR_TO_DATE(" + '"' + toDate + '"' + ",'%d/%m/%Y')";
        }

        sql += " order by sortdate " + sortOrder;

        ResultSet rs = this.db.executeQuery(sql);

        sql = "select count(*) from (" + sql + ") as tbl";
        ResultSet rs_count = this.db.executeQuery(sql);
        rs_count.first();
        int totalQueryCount = rs_count.getInt(1);
        xml = util.convertResultSetToXML(rs, pageNumber, pageSize, totalQueryCount);
        return xml;
    }

    public InvoiceFormBean getInvoiceDetail() throws SQLException, ParseException, ParserConfigurationException, TransformerException, ClassNotFoundException {
        String InwardNumber = request.getParameter("inwardNumber");
        return this.getInvoiceDetail(InwardNumber);
        
    }
    
    public InvoiceFormBean getInvoiceDetail(String InwardNumber) throws SQLException, ParseException, ParserConfigurationException, TransformerException, ClassNotFoundException {
        String sql;
        InvoiceFormBean invoiceFormBean = new IAS.Bean.Invoice.InvoiceFormBean();
        sql = Queries.getQuery("get_invoice_detail");
        PreparedStatement st = conn.prepareStatement(sql);
        st.setString(1, InwardNumber);
        try (ResultSet rs = db.executeQueryPreparedStatement(st)) {
            while (rs.next()) {
                BeanProcessor bProc = new BeanProcessor();
                Class type = Class.forName("IAS.Bean.Invoice.InvoiceFormBean");
                invoiceFormBean = (IAS.Bean.Invoice.InvoiceFormBean) bProc.toBean(rs, type);
            }
        }
        request.setAttribute("invoiceFormBean", invoiceFormBean);
        return invoiceFormBean;
    }
    
    public String getChequeReturnEmailBody(int chqDDNumber, float amount, String chqDate, String reason) throws IOException{
                
        String template = props.getProperty("cheque_return_email_body");
        return String.format(   template, 
                                String.valueOf(chqDDNumber),
                                chqDate,
                                String.valueOf(amount),
                                reason);
    }
    
    public String getInwardAckEmailBody(int chqDDNumber, float amount, String chqDate, String bank){
        String template = props.getProperty("inward_ack_email_body");
        return String.format(   template, 
                                String.valueOf(chqDDNumber),
                                chqDate,
                                bank,
                                String.valueOf(amount));
    }
    
    public String getRequestForInvoiceEmailBody(){
        return props.getProperty("inward_request_for_invoice");        
    }
}
