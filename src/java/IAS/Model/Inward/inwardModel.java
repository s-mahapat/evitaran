/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.Inward;

import IAS.Bean.Invoice.InvoiceFormBean;
import IAS.Bean.Inward.inwardFormBean;
import IAS.Bean.Subscriber.subscriberFormBean;
import IAS.Class.JDSLogger;
import IAS.Class.Queries;
import IAS.Class.util;
import IAS.Model.JDSModel;
import IAS.Model.Subscription.SubscriptionModel;
import com.mysql.jdbc.Statement;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Calendar;
import java.util.Properties;
import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import org.apache.commons.dbutils.BeanProcessor;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.ResultSetHandler;
import org.apache.log4j.Logger;
import org.xml.sax.SAXException;

/**
 *
 * @author Shailendra Mahapatra
 */
public class inwardModel extends JDSModel {

    private inwardFormBean _inwardFormBean = null;
    //private HttpServletRequest request;
    Properties props = null;
    private static Logger logger = JDSLogger.getJDSLogger(inwardModel.class.getName());

    public inwardModel() throws SQLException {
    }

    public inwardModel(HttpServletRequest request) throws SQLException, IOException {
        //call the base class constructor
        super(request);
        this.request = request;
        //throw (new SQLException("Database connection not found in the session"));
        InputStream is = request.getServletContext().getResourceAsStream("/WEB-INF/classes/email_templates.properties");
        props = new Properties();
        props.load(is);

    }

    public int Save() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException {

        inwardFormBean inwardFormBean = new IAS.Bean.Inward.inwardFormBean();
        request.setAttribute("inwardFormBean", inwardFormBean);
        String sql;
        int rc;
        int inwardID = 0;
        //throw new SQLException("Generated this exception");
        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        try (Connection conn = this.getConnection()) {
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

                try (ResultSet rs = st.getGeneratedKeys()) {
                    rs.first();
                    inwardID = rs.getInt(1);
                    rs.close();
                } catch (SQLException e) {
                    throw (new SQLException(e));
                }

                int subscriptionID = inwardFormBean.getSubscriptionID();
                //update the payment info if subscription id is not null
                if (subscriptionID != 0 && rc == 1) {
                    sql = Queries.getQuery("insert_payment");
                    try (PreparedStatement pst = conn.prepareStatement(sql)) {
                        pst.setInt(1, inwardID);
                        pst.setInt(2, subscriptionID);
                        rc = pst.executeUpdate();
                    }
                }
                //update inward-agent details
                String agentName = inwardFormBean.getAgentName();
                if (!agentName.isEmpty() && rc == 1) {
                    sql = Queries.getQuery("insert_in_agent_dtls");
                    PreparedStatement pst = conn.prepareStatement(sql);
                    pst.setInt(1, inwardID);
                    pst.setString(2, agentName);
                    rc = pst.executeUpdate();
                }
            }
            conn.commit();
            conn.setAutoCommit(true);
        }
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
        inwardFormBean __inwardFormBean;
        FillBean(this.request, inwardFormBean);
        this._inwardFormBean = inwardFormBean;
        String sql = Queries.getQuery("update_cheque_return");
        String sql_details = Queries.getQuery("update_cheque_return_details");
        try (Connection _conn = this.getConnection();
                PreparedStatement st = _conn.prepareStatement(sql);
                PreparedStatement pst = _conn.prepareStatement(sql_details);) {
            _conn.setAutoCommit(false);
            int paramIndex = 0;
            st.setBoolean(++paramIndex, true);
            st.setString(++paramIndex, inwardFormBean.getChequeDDReturnReason());
            st.setString(++paramIndex, inwardFormBean.getChequeDDReturnReasonOther());
            st.setDate(++paramIndex, util.dateStringToSqlDate(util.getDateString()));
            st.setString(++paramIndex, "Instrument of amount " + inwardFormBean.getAmount() + " returned");
            st.setString(++paramIndex, inwardFormBean.getInwardNumber());
            st.executeUpdate();
            paramIndex = 0;
            pst.setString(++paramIndex, inwardFormBean.getChequeDDReturnReason());
            pst.setString(++paramIndex, inwardFormBean.getChequeDDReturnReasonOther());
            pst.setDate(++paramIndex, util.dateStringToSqlDate(util.getDateString()));
            pst.setFloat(++paramIndex, inwardFormBean.getAmount());
            pst.setInt(++paramIndex, inwardFormBean.getInwardID());
            pst.setInt(++paramIndex, inwardFormBean.getChqddNumber());
            pst.setDate(++paramIndex, util.dateStringToSqlDate(inwardFormBean.getPaymentDate()));
            pst.executeUpdate();
            _conn.commit();
            /*
             Create or update an invoice when the cheque is returned
             */
            int subscriptionID = this.getSubscriptionID(inwardFormBean.getInwardID());
            SubscriptionModel subscriptionModel = new SubscriptionModel();
            int invoice_type_id = 2; // for outstanding payment
            subscriptionModel.insertUpdateInvoiceForSubscription(subscriptionID, invoice_type_id, inwardFormBean.getAmount());

            __inwardFormBean = this.GetInward();

        }
        return __inwardFormBean;

    }

    /**
     * Given an inward id returns the subscription id that was created from the
     * inward
     *
     * @param inwardID inward id
     * @return subscription id
     * @throws SQLException
     */
    private int getSubscriptionID(int inwardID) throws SQLException {
        int subscriptionID = 0;
        String sql = Queries.getQuery("get_subscription_for_inward");
        try (Connection conn = this.getConnection(); PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, inwardID);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.first()) {
                    subscriptionID = rs.getInt("subscriptionID");
                }
            }
        }
        return subscriptionID;
    }

    public inwardFormBean getChequeReturnDetails(String inwardNumber, int chq_no) throws SQLException {

        inwardFormBean _inwardFormBean2return;
        try (Connection _conn = this.getConnection()) {
            String sql = Queries.getQuery("print_email_chq_return");

            ResultSetHandler<inwardFormBean> h = new ResultSetHandler<inwardFormBean>() {
                @Override
                public inwardFormBean handle(ResultSet rs) throws SQLException {
                    inwardFormBean inwardFormBean = null;
                    while (rs.next()) {
                        BeanProcessor bProc = new BeanProcessor();
                        inwardFormBean = bProc.toBean(rs, IAS.Bean.Inward.inwardFormBean.class);
                    }
                    return inwardFormBean;
                }
            };

            QueryRunner run = new QueryRunner();
            _inwardFormBean2return = run.query(_conn, sql, h, inwardNumber, chq_no);
        }
        return _inwardFormBean2return;
    }

    private int _updateInward() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException {

        int rc = 0;

        // get the connection from base class
        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("update_inward");

        try (Connection conn = this.getConnection(); PreparedStatement st = conn.prepareStatement(sql)) {
            // mulitple tables are updated, so it should be done in a transaction
            conn.setAutoCommit(false);
            this._setUpdateInwardStatementParams(st);
            rc = st.executeUpdate();

            /*int subscriptionID = this._inwardFormBean.getSubscriptionID();
             if (subscriptionID > 0) {
             sql = Queries.getQuery("update_payment_info");
             try (PreparedStatement pst = conn.prepareStatement(sql)) {
             pst.setInt(1, subscriptionID);
             pst.setString(2, this._inwardFormBean.getInwardNumber());
             rc = pst.executeUpdate();
             }
             }*/
            //update inward-agent details
            sql = Queries.getQuery("get_in_agent_dtls");
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, _inwardFormBean.getInwardID());
            ResultSet rs = pst.executeQuery();
            if (rs.first()) {
                int count = rs.getInt("count");
                if (count > 0) {
                    sql = Queries.getQuery("update_in_agent_dtls");
                    PreparedStatement pst2 = conn.prepareStatement(sql);
                    pst2.setString(1, _inwardFormBean.getAgentName());
                    pst2.setInt(2, _inwardFormBean.getInwardID());
                    pst2.executeUpdate();
                } else {
                    sql = Queries.getQuery("insert_in_agent_dtls");
                    PreparedStatement pst3 = conn.prepareStatement(sql);
                    pst3.setInt(1, _inwardFormBean.getInwardID());
                    pst3.setString(2, _inwardFormBean.getAgentName());
                    rc = pst3.executeUpdate();
                }
            }
            // commit at the end, which means all is well
            conn.commit();
            conn.setAutoCommit(true);
        } finally {
            return rc;
        }

    }

    public inwardFormBean GetInward() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        String sql;
        inwardFormBean inwardFormBean = new IAS.Bean.Inward.inwardFormBean();

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, inwardFormBean);

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        sql = Queries.getQuery("get_inward_by_number");
        try (Connection conn = this.getConnection();
                PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, inwardFormBean.getInwardNumber());
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    BeanProcessor bProc = new BeanProcessor();
                    inwardFormBean = bProc.toBean(rs, IAS.Bean.Inward.inwardFormBean.class);

                }
            }
        }

        //request.setAttribute("inwardFormBean", inwardFormBean);
        return inwardFormBean;
    }

    public inwardFormBean GetInward(String inwardNumber) throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        String sql;
        inwardFormBean inwardFormBean = new IAS.Bean.Inward.inwardFormBean();
        try (Connection conn = this.getConnection()) {
            //FillBean(this.request, inwardFormBean);

            // the query name from the jds_sql properties files in WEB-INF/properties folder
            sql = Queries.getQuery("get_inward_by_number");

            try (PreparedStatement st = conn.prepareStatement(sql)) {

                st.setString(1, inwardNumber);

                try (ResultSet rs = st.executeQuery()) {
                    while (rs.next()) {
                        BeanProcessor bProc = new BeanProcessor();
                        Class type = Class.forName("IAS.Bean.Inward.inwardFormBean");
                        inwardFormBean = (IAS.Bean.Inward.inwardFormBean) bProc.toBean(rs, type);
                    }

                }
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
        st.setString(++paramIndex, _inwardFormBean.getLetterNumber());
        st.setDate(++paramIndex, util.dateStringToSqlDate(_inwardFormBean.getLetterDate()));

        /*
         * if the inward is of any non process type like Advertisement, Payment,
         * Others, Manuscript a trigger on the DB side marks the inward as complete
         * This ensures that we do not get the inwards in the pending inwards screen
         */
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
        st.setString(++paramIndex, _inwardFormBean.getLetterNumber());
        st.setDate(++paramIndex, util.dateStringToSqlDate(_inwardFormBean.getLetterDate()));
        st.setString(++paramIndex, _inwardFormBean.getInwardNumber());
    }

    /*
     * This method is a synchronized method so that no two get the same inward
     * number
     */
    private synchronized String getNextInwardNumber() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException {

        String nextInward;
        //get the last inward number from inward table
        String lastInwardSql = Queries.getQuery("get_last_inward");
        Calendar calendar;
        String lastInward;
        int lastInwardYear;

        try (Connection conn = this.getConnection();
                PreparedStatement pst = conn.prepareStatement(lastInwardSql);
                ResultSet rs = pst.executeQuery()) {
            calendar = Calendar.getInstance();
            //ResultSetMetaData rsmd = rs.getMetaData();
            lastInward = null;
            lastInwardYear = 0;
            while (rs.next()) {

                lastInward = rs.getString(1);
                java.sql.Date dt = rs.getDate(2);
                Calendar inCal = Calendar.getInstance();
                inCal.setTime(dt);
                lastInwardYear = inCal.get(Calendar.YEAR);

            }
            rs.close();

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

    public String searchInward() throws SQLException, ParseException, ParserConfigurationException, TransformerException, SAXException, IOException {
        String xml;
        String sql = Queries.getQuery("search_inwards");
        String from = request.getParameter("from");
        String inwardNumber = request.getParameter("inwardNumber");
        String chequeNumber = request.getParameter("chequeNumber");
        String city = request.getParameter("city");
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        String inwardPurpose = request.getParameter("inwardPurpose");
        int pageNumber = Integer.parseInt(request.getParameter("page"));
        int pageSize = Integer.parseInt(request.getParameter("rows"));
        //String orderBy = request.getParameter("sidx");
        String sortOrder = request.getParameter("sord");
        String completed = request.getParameter("completed");
        int totalQueryCount;

        if (from != null && from.length() > 0) {
            sql += " and t1.from like" + "'%" + from + "%'";
        }

        if (inwardNumber != null && inwardNumber.length() > 0) {
            sql += " and inwardNumber like" + "'%" + inwardNumber + "%'";
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

        // if the user selects ALL from the UI then do not limit the number of rows that are displayed
        if (pageSize > 0) {
            String sql_count = "select count(*) from (" + sql + ") as tbl";

            try (Connection conn = this.getConnection();
                    PreparedStatement pst = conn.prepareStatement(sql_count);
                    ResultSet rs_count = pst.executeQuery();) {
                rs_count.first();
                totalQueryCount = rs_count.getInt(1);
            }

            int start = (pageNumber - 1) * pageSize;
            sql += " LIMIT " + start + "," + pageSize;

            try (Connection conn = this.getConnection();
                    PreparedStatement pstatement = conn.prepareStatement(sql);) {
                try (ResultSet rs = pstatement.executeQuery();) {
                    xml = util.convertResultSetToXML(rs, pageNumber, pageSize, totalQueryCount);
                }
            }
        } else {
            // this is executed when the user selects all from the UI
            try (Connection conn = this.getConnection();
                    PreparedStatement pstatement = conn.prepareStatement(sql);) {
                try (ResultSet rs = pstatement.executeQuery();) {
                    xml = util.convertResultSetToXML(rs);
                }
            }
        }

        return xml;
    }

    public String subscriberInward() throws SQLException, ParseException, ParserConfigurationException, TransformerException, SAXException, IOException {
        String xml;
        String sql = Queries.getQuery("search_subscriber_inward");
        String ajax_sql = sql + " LIMIT ?, ?";
        String subscriberNumber = request.getParameter("subscriberNumber");
        int pageNumber = Integer.parseInt(request.getParameter("page"));
        int pageSize = Integer.parseInt(request.getParameter("rows"));
        //String orderBy = request.getParameter("sidx");
        //String sortOrder = request.getParameter("sord");
        try ( // get the connection from base class
                Connection conn = this.getConnection();) {
            int totalQueryCount;
            String sql_count = "select count(*) from (" + sql + ") as tbl";
            try (PreparedStatement pst = conn.prepareStatement(sql_count);) {
                pst.setString(1, subscriberNumber);
                try (ResultSet rs_count = pst.executeQuery();) {
                    rs_count.first();
                    totalQueryCount = rs_count.getInt(1);
                }
            }
            try (PreparedStatement pst = conn.prepareStatement(ajax_sql)) {
                pst.setString(1, subscriberNumber);
                pst.setInt(2, (pageSize * (pageNumber - 1)));
                pst.setInt(3, pageSize);
                try (ResultSet rs = pst.executeQuery();) {
                    xml = util.convertResultSetToXML(rs, pageNumber, pageSize, totalQueryCount);
                }

            }
        }

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
        //String orderBy = request.getParameter("sidx");
        String sortOrder = request.getParameter("sord");
        int totalQueryCount = 0;

        try ( // get the connection from base class
                Connection conn = this.getConnection();) {
            if (inwardPurpose != null && inwardPurpose.compareToIgnoreCase("NULL") != 0 && inwardPurpose.length() > 0) {
                sql += " and t3.purpose =" + "'" + inwardPurpose + "'";
            }
            if (fromDate != null && fromDate.length() > 0 && toDate != null && toDate.length() > 0) {
                sql += " and inwardCreationDate between " + "STR_TO_DATE(" + '"' + fromDate + '"' + ",'%d/%m/%Y')" + " and " + "STR_TO_DATE(" + '"' + toDate + '"' + ",'%d/%m/%Y')";
            }
            sql += " order by t1.id desc, sortdate " + sortOrder;
            String sql_count = "select count(*) from (" + sql + ") as tbl";
            try (PreparedStatement pst = conn.prepareStatement(sql_count);) {
                try (ResultSet rs_count = pst.executeQuery();) {
                    rs_count.first();
                    totalQueryCount = rs_count.getInt(1);
                }
            }
            int start = (pageNumber - 1) * pageSize;
            sql += " LIMIT " + start + "," + pageSize;
            try (PreparedStatement pstatement = conn.prepareStatement(sql);) {
                try (ResultSet rs = pstatement.executeQuery();) {
                    xml = util.convertResultSetToXML(rs, pageNumber, pageSize, totalQueryCount);
                }
            }
        }

        return xml;
    }

    public InvoiceFormBean getInvoiceDetail() throws SQLException, ParseException, ParserConfigurationException, TransformerException, ClassNotFoundException {
        String InwardNumber = request.getParameter("inwardNumber");
        return this.getInvoiceDetail(InwardNumber);

    }

    public InvoiceFormBean getInvoiceDetail(String InwardNumber) throws SQLException, ParseException, ParserConfigurationException, TransformerException, ClassNotFoundException {
        InvoiceFormBean invoiceFormBean;
        try (Connection _conn = this.getConnection()) {
            String sql;
            invoiceFormBean = new IAS.Bean.Invoice.InvoiceFormBean();
            sql = Queries.getQuery("get_invoice_detail");
            PreparedStatement st = _conn.prepareStatement(sql);
            st.setString(1, InwardNumber);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    BeanProcessor bProc = new BeanProcessor();
                    invoiceFormBean = bProc.toBean(rs, IAS.Bean.Invoice.InvoiceFormBean.class);
                }
            }
        }

        request.setAttribute("invoiceFormBean", invoiceFormBean);
        return invoiceFormBean;
    }

    public String getChequeReturnEmailBody(String chqDDNumber, float amount, String chqDate, String reason) throws IOException {

        String template = props.getProperty("cheque_return_email_body");
        return String.format(template,
                chqDDNumber,
                chqDate,
                String.valueOf(amount),
                reason);
    }

    public String getInwardAckEmailBody(String chqDDNumber, float amount, String chqDate, String bank, String inwardPurpose, String ctext) {
        String template;
        String body;
        if (amount > 0) {
            template = props.getProperty("inward_ack_email_body");
            body = String.format(template, inwardPurpose,
                    chqDDNumber,
                    chqDate,
                    bank,
                    String.valueOf(amount),
                    ctext);
        } else {
            template = props.getProperty("inward_ack_email_body_no_amount");
            body = String.format(template, inwardPurpose, ctext);
        }
        return body;

    }

    public String getRequestForInvoiceEmailBody() {
        return props.getProperty("inward_request_for_invoice");
    }

    public String getAgentInvoiceEmailBody() {
        return props.getProperty("agent_invoice");
    }

    public subscriberFormBean getSubscriberDetail() throws SQLException, ParseException, ParserConfigurationException, TransformerException, ClassNotFoundException {
        String SubscriberNo = request.getParameter("subscriberNumber");
        return this.getSubscriberDetails(SubscriberNo);
    }

    public subscriberFormBean getSubscriberDetails(String SubscriberNo) throws SQLException, ParseException, ParserConfigurationException, TransformerException, ClassNotFoundException {

        // get the connection from connection pool
        String sql;
        subscriberFormBean _subscriberFormBean = new IAS.Bean.Subscriber.subscriberFormBean();
        sql = Queries.getQuery("get_subscriber_by_number");

        try (Connection conn = this.getConnection();
                PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, SubscriberNo);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    BeanProcessor bProc = new BeanProcessor();
                    Class type = Class.forName("IAS.Bean.Subscriber.subscriberFormBean");
                    _subscriberFormBean = (IAS.Bean.Subscriber.subscriberFormBean) bProc.toBean(rs, type);
                }
                rs.close();
            }

        }
        request.setAttribute("subscriberFormBean", _subscriberFormBean);
        return _subscriberFormBean;
    }

    public int updateSubscriberInInward(String subScriberNumber, String inwardNumber) {

        int rc = 0;
        ResultSetHandler<Object[]> h = new ResultSetHandler<Object[]>() {
            @Override
            public Object[] handle(ResultSet rs) throws SQLException {
                Object[] result = new Object[1];
                if (rs.first()) {
                    result[0] = rs.getInt(1);
                }
                return result;
            }
        };

        try (Connection _conn = this.getConnection()) {
            QueryRunner run = new QueryRunner();
            Object[] subids = run.query(_conn, Queries.getQuery("get_subscriber_id_from_number"), h, subScriberNumber);
            int subid = (int) subids[0];
            if (subid > 0) {
                String sql = Queries.getQuery("update_subscriber_in_inward");
                rc = run.update(_conn, sql, subid, inwardNumber);
            }

        } catch (SQLException ex) {
            logger.error(ex);
        } finally {
            return rc;
        }
    }

    /**
     * inward_number: inward to: new inward type code from database
     *
     * @param inward_number
     * @param to
     * @return
     * @throws java.sql.SQLException
     */
    public int modifyInwardPurpose(String inward_number, int to) throws SQLException {
        String sql = Queries.getQuery("change_inward_type");

        int rc = 0;

        try (Connection conn = this.getConnection();
                PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, to);
            pst.setString(2, inward_number);
            rc = pst.executeUpdate();
        } catch (Exception ex) {
            // no op
        } finally {
            return rc;
        }
    }

    public int invalidateInward(String inward_number) throws SQLException {
        int rc = 0;
        String sql = Queries.getQuery("invalidate_inward");
        try (Connection conn = this.getConnection();
                PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setBoolean(1, false);
            pst.setString(2, inward_number);
            rc = pst.executeUpdate();
        } catch (Exception ex) {
            // no op
        } finally {
            return rc;
        }
    }
}
