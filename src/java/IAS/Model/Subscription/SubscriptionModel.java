/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.Subscription;

import IAS.Bean.Invoice.InvoiceFormBean;
import IAS.Bean.Inward.inwardFormBean;
import IAS.Bean.Subscription.SubscriptionDetailBean;
import IAS.Bean.Subscription.SubscriptionFormBean;
import IAS.Class.JDSConstants;
import IAS.Class.JDSLogger;
import IAS.Class.Queries;
import IAS.Class.util;
import IAS.Model.JDSModel;
import com.mysql.jdbc.Statement;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Calendar;
import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import org.apache.log4j.Logger;

/**
 *
 * @author Shailendra Mahapatra
 */
public class SubscriptionModel extends JDSModel {

    private String subscriberNumber;
    private String inwardNumber;
    private int inwardID;
    private int inwardPurposeID = 0;
    private inwardFormBean _inwardFormBean;
    private InvoiceFormBean _invoiceFormBean;
    private SubscriptionFormBean _subscriptionBean;
    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Model.SubscriptionModel");

    public SubscriptionModel(HttpServletRequest request) throws SQLException {
        // call the base class constructor.
        super(request);
        _subscriptionBean = new SubscriptionFormBean();
        //this.journalName = request.getParameter("journalName");
        //this.copies = 0;
        this.subscriberNumber = request.getParameter("subscriberNumber");

        if (session.getAttribute("inwardUnderProcess") != null) {
            this._inwardFormBean = (inwardFormBean) session.getAttribute("inwardUnderProcess");
            this.inwardNumber = _inwardFormBean.getInwardNumber();
            this.inwardID = _inwardFormBean.getInwardID();
            this.inwardPurposeID = _inwardFormBean.getInwardPurposeID();
        } else {
            this.inwardNumber = null;
        }
    }

    public String addSubscription() throws IllegalAccessException, ParseException,
            ParserConfigurationException, SQLException, TransformerException,
            IOException, InvocationTargetException, Exception {

        String xml = null;
        String journalGroupID[] = request.getParameterValues("journalGroupID");
        String journalPriceGroupID[] = request.getParameterValues("journalPriceGroupID");
        String startYear[] = request.getParameterValues("startYear");
        String startMonth[] = request.getParameterValues("startMonth");
        String endYear[] = request.getParameterValues("endYear");
        String Copies[] = request.getParameterValues("copies");
        String Total[] = request.getParameterValues("total");
        float subscriptionTotal = Float.parseFloat(request.getParameter("subscriptionTotal"));
        //String remarks = request.getParameter("remarks");
        int subscriptionID;

        //this.inwardNumber = "12A-00001";
        if (this.inwardNumber == null) {
            xml = util.convertStringToXML("No Inward Under Process. Cannot add a subscription without an Inward", "error");
        } else {

            SubscriptionDetailBean _subscriptionDetailBean = new SubscriptionDetailBean();
            FillBean(this.request, _subscriptionBean);
            FillBean(this.request, _subscriptionDetailBean);
            _subscriptionBean.setSubscriptionTotal(subscriptionTotal);
            request.setAttribute("subscriptionFormBean", _subscriptionBean);
            request.setAttribute("subscriptionDetailBean", _subscriptionDetailBean);
            PreparedStatement st = null;

            // start transaction here.
            conn.setAutoCommit(false);
            try {
                // the query name from the jds_sql properties files in WEB-INF/properties folder
                String sql = Queries.getQuery("insert_subscription");
                st = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                int paramIndex = 0;
                //float balance = subscriptionTotal - this._inwardFormBean.getAmount();


                st.setString(++paramIndex, this.subscriberNumber);
                st.setString(++paramIndex, this.inwardNumber);
                //st.setFloat(++paramIndex, balance);
                st.setDate(++paramIndex, util.dateStringToSqlDate(util.getDateString()));
                //st.setFloat(++paramIndex, subscriptionTotal);
                //st.setString(++paramIndex, remarks);
                if (db.executeUpdatePreparedStatement(st) == 1) {
                    try (ResultSet rs = st.getGeneratedKeys()) {
                        rs.first();
                        subscriptionID = rs.getInt(1);
                    }

                    //set the subscription id and total in the bean
                    _subscriptionBean.setSubscriptionID(subscriptionID);

                    int[] res = this.__addSubscriptionDetail(subscriptionID,
                            util.convertStringArraytoIntArray(journalGroupID),
                            util.convertStringArraytoIntArray(startYear),
                            util.convertStringArraytoIntArray(startMonth),
                            util.convertStringArraytoIntArray(endYear),
                            util.convertStringArraytoIntArray(Copies),
                            util.convertStringArraytoFloatArray(Total),
                            util.convertStringArraytoIntArray(journalPriceGroupID));

                    for (int i = 0; i < res.length; i++) {
                        if (res[i] != 1) {
                            xml = util.convertStringToXML("Failed to save subscription details", "error");
                            throw (new SQLException("Failed to update scubscription details"));
                        }
                    }


                    // Update the Performa Invoice
                    if (inwardPurposeID == JDSConstants.INWARD_PURPOSE_REQUEST_FOR_INVOICE) {
                        this.updateInvoice();
                    }

                    //Update inward with completed flag once the transaction is completed
                    if (this.CompleteInward(this.inwardID) == 1) {
                        session.setAttribute("inwardUnderProcess", null);
                    }
                    xml = util.convertStringToXML(String.valueOf(subscriptionID), "subscriptionID");

                    conn.commit(); // complete the transaction here.
                }
            } catch (SQLException | ParseException | NumberFormatException e) {
                conn.rollback();
            } finally {
                conn.setAutoCommit(true);
                st.close();
            }

        }
        return xml;
    }

    private int[] __addSubscriptionDetail(
            int subscriptionID, int[] journalGroupID,
            int[] startYear, int[] startMonth, int[] endYear, int[] copies,
            float[] total, int[] journalPriceGroupID) throws SQLException {

        String sql = Queries.getQuery("insert_subscription_detail");
        int[] res;
        try (PreparedStatement st = conn.prepareStatement(sql)) {
            int paramIndex;
            for (int i = 0; i < journalGroupID.length; i++) {
                paramIndex = 0;
                st.setInt(++paramIndex, subscriptionID);
                st.setInt(++paramIndex, journalGroupID[i]);
                st.setInt(++paramIndex, journalPriceGroupID[i]);
                st.setInt(++paramIndex, copies[i]);
                st.setInt(++paramIndex, startYear[i]);
                st.setInt(++paramIndex, startMonth[i]);
                st.setInt(++paramIndex, util.getPreviousMonth(startMonth[i]));
                st.setInt(++paramIndex, endYear[i]);
                //st.setFloat(++paramIndex, total[i]);
                st.addBatch();
            }
            res = st.executeBatch();
        }
        return res;

    }

    public int[] addNewSubscriptionDetail(int subscriptionID, int journalGroupID,
            int startYear, int startMonth, int endYear, int copies,
            float total, int journalPriceGroupID) throws SQLException {

        int[] _journalGroupID = {journalGroupID};
        int[] _journalPriceGroupID = {journalPriceGroupID};
        int[] _startYear = {startYear};
        int[] _startMonth = {startMonth};
        int[] _endYear = {endYear};
        int[] _copies = {copies};
        float[] _total = {total};


        int res[] = this.__addSubscriptionDetail(
                subscriptionID, _journalGroupID,
                _startYear, _startMonth,
                _endYear, _copies,
                _total, _journalPriceGroupID);
        return res;
    }

    public int updateSubscriptionDetail(int id, int startYear, int startMonth,
            int endYear, boolean active, int copies, int SubscriberTypeID)
            throws ParserConfigurationException, SQLException, TransformerException {

        int rc;
        PreparedStatement st = null;
        try {

            /*
             * The logic used here is first get the old journalgroupid, active
             * and total value from subscription details table for the row being
             * edited. Get the new journal group id then calculate the new total
             * price for the row Get the sum(total) of all active transactions.
             * if newactive = True and oldactive=True then subscriptionValue =
             * subscriptionValue - old total value + new Total value if
             * newactive = True and oldactive=False then subscriptionValue =
             * subscriptionValue + new Total value if newactive = False and
             * oldactive=True then subscriptionValue = subscriptionValue - new
             * Total value update the database
             */

            //set autocommit(false) to start transaction
            conn.setAutoCommit(false);

            //get journal journal grpid,active,subscriptionid and total from subscriptiondetails table
            String sql = "select journalGroupID,active,subscriptionID from subscriptiondetails where id=" + id;
            ResultSet rs = db.executeQuery(sql);
            rs.first();
            int journalGroupID = rs.getInt(1);
            boolean oldactiveFlag = rs.getBoolean(2);
            //float oldTotal = rs.getFloat(3);
            //int subscriptionID = rs.getInt(3);

            if ((oldactiveFlag || active) == false) {
                return (0); //if old and new active flag is the same and its inactive, do not go further
            }
            rs.close();

            // get the new price group id and price
            rs = this.getJournalPrice(startYear, (endYear - startYear + 1), journalGroupID, SubscriberTypeID);
            rs.first();

            int newPriceGroupID = rs.getInt(1);
            //float total = copies * rs.getInt(2);     
            sql = Queries.getQuery("update_subscription_detail");
            st = conn.prepareStatement(sql);
            int paramIndex = 0;
            st.setInt(++paramIndex, startYear);
            st.setInt(++paramIndex, startMonth);
            st.setInt(++paramIndex, endYear);
            st.setInt(++paramIndex, newPriceGroupID);
            //st.setFloat(++paramIndex, total);
            st.setInt(++paramIndex, copies);
            st.setBoolean(++paramIndex, active);
            st.setInt(++paramIndex, id);
            rc = st.executeUpdate();

            conn.commit();
            return rc;

        } catch (SQLException e) {
            conn.rollback();
            throw (e);
        } finally {
            conn.setAutoCommit(true);
            st.close();
            //st.close();
        }


    }

    public int deleteSubscription() throws ParserConfigurationException, SQLException, TransformerException {

        String sql = Queries.getQuery("delete_subscription");
        int rc;
        try (PreparedStatement st = conn.prepareStatement(sql)) {
            int paramIndex = 0;
            int subscriptionId = Integer.parseInt(request.getParameter("id"));
            st.setInt(++paramIndex, subscriptionId);
            rc = st.executeUpdate();
        }
        return rc;
    }

    public String getSubscription() throws ParserConfigurationException, SQLException, TransformerException, IOException {

        String xml;
        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("get_subscription_for_subscriber");
        try (PreparedStatement st = conn.prepareStatement(sql)) {
            int paramIndex = 0;
            st.setString(++paramIndex, this.subscriberNumber);
            try (ResultSet rs = db.executeQueryPreparedStatement(st)) {
                if (rs != null) {
                    xml = util.convertResultSetToXML(rs);
                } else {
                    xml = util.convertStringToXML("Failed to get subscription", "error");
                }
            }
        }
        return xml;

    }

    public ResultSet getSubscriptionByID(int _id) throws ParserConfigurationException,
            SQLException, TransformerException, IOException {

        String sql = Queries.getQuery("get_subscription_info_by_id");
        ResultSet rs;
        PreparedStatement st = conn.prepareStatement(sql);
        st.setInt(1, _id);
        rs = st.executeQuery();
        return rs;
    }

    public ResultSet getSubscriptionDetailBySubscriptionID(int _id) throws ParserConfigurationException,
            SQLException, TransformerException, IOException {
        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("get_subscription_detail_by_subscription_id");
        ResultSet rs;
        PreparedStatement st = conn.prepareStatement(sql);
        st.setInt(1, _id);
        rs = st.executeQuery();
        return rs;
    }

    public String getSubscriptionDetails() throws ParserConfigurationException, SQLException, TransformerException, IOException {

        String xml;
        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("get_subscription_details");
        try (PreparedStatement st = conn.prepareStatement(sql)) {
            int paramIndex = 0;
            st.setInt(++paramIndex, Integer.parseInt(request.getParameter("id")));
            try (ResultSet rs = st.executeQuery()) {
                if (rs != null) {
                    xml = util.convertResultSetToXML(rs);
                } else {
                    logger.error("Failed to get subscription details for id: " + request.getParameter("id"));
                    xml = util.convertStringToXML("Failed to get subscription details", "error");
                }
            }
        }
        return xml;
    }

    public ResultSet getSubscriptionDetailsForInward(String InwardNumber) throws ParserConfigurationException, SQLException, TransformerException, IOException {

        String xml = null;
        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("get_subscription_details_for_inward");
        ResultSet rs;
        PreparedStatement st = conn.prepareStatement(sql);
        int paramIndex = 0;
        st.setString(++paramIndex, InwardNumber);
        rs = st.executeQuery();
        return rs;

    }

    public ResultSet getJournalPrice(int startYear, int numYears, int journalGroupID, int subscriberTypeID) throws TransformerException,
            ParserConfigurationException,
            SQLException {
        String sql = Queries.getQuery("get_journal_group_price");
        ResultSet rs;
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, journalGroupID);
        ps.setInt(2, subscriberTypeID);
        ps.setInt(3, startYear);
        ps.setInt(4, numYears);
        rs = ps.executeQuery();
        return rs;
    }

    public ResultSet getJournalGroupContents(int journalGroupID) throws SQLException, ParserConfigurationException, TransformerException {
        String sql = Queries.getQuery("get_journal_groupid_contents");
        ResultSet rs;
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, journalGroupID);
        rs = ps.executeQuery();
        return rs;


    }

    private synchronized String getNextInvoiceNumber() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException {

        String nextInvoice;
        // Invoice Type to be tagged in the invoice number similar to subscriber and inward
        String invoiceType = "I";
        //get the last invoice number from invoice table
        String lastInvoiceSql = Queries.getQuery("get_last_invoice");
        try (ResultSet rs = db.executeQuery(lastInvoiceSql)) {
            Calendar calendar = Calendar.getInstance();
            String lastInvoice;
            //if true there exists a previous invoice for the year, so just increment the invoice number.
            if (rs.first()) {
                lastInvoice = rs.getString(1);
                // get the last invoice number after the split
                int invoice = Integer.parseInt(lastInvoice.substring(6));
                //increment
                ++invoice;
                //apend the year, month character and new invoice number.
                nextInvoice = lastInvoice.substring(0, 2) + getMonthToCharacterMap(calendar.get(Calendar.MONTH)) + "-" + invoiceType + "-" + String.format("%05d", invoice);
            } else {
                // there is no previous record for the year, so start the numbering afresh
                String year = String.valueOf(calendar.get(Calendar.YEAR)).substring(2);
                nextInvoice = year + getMonthToCharacterMap(calendar.get(Calendar.MONTH)) + "-" + invoiceType + "-" + String.format("%05d", 1);
            }
        }
        return nextInvoice;
    }

    private int updateInvoice() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException {

        InvoiceFormBean invoiceFormBean = new IAS.Bean.Invoice.InvoiceFormBean();
        request.setAttribute("invoiceFormBean", invoiceFormBean);
        String sql;
        int paramIndex = 0;
        int invoiceID = 0;
        //get the next invoice number and fill the bean
        String invoiceNumber = getNextInvoiceNumber();
        invoiceFormBean.setInvoiceNumber(invoiceNumber);

        //subscription ID
        int SubscriptionID = _subscriptionBean.getSubscriptionID();
        invoiceFormBean.setSubscriptionID(SubscriptionID);

        //upadte _invoiceFormBean
        this._invoiceFormBean = invoiceFormBean;

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        sql = Queries.getQuery("invoice_insert");
        try (PreparedStatement st = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            st.setString(++paramIndex, invoiceNumber);
            st.setInt(++paramIndex, SubscriptionID);
            st.setDate(++paramIndex, util.dateStringToSqlDate(util.getDateString()));
            if (db.executeUpdatePreparedStatement(st) == 1) {
                try (ResultSet rs = st.getGeneratedKeys()) {
                    rs.first();
                    invoiceID = rs.getInt(1);
                }
            }

        }

        return invoiceID;
    }
    
    public String getSubscriptionInwardInfo(int subid) throws 
            SQLException, 
            ParserConfigurationException,
            TransformerException{
        String sql = Queries.getQuery("get_subscription_inward_amount");
        String xml;
        try(PreparedStatement st = conn.prepareStatement(sql)){
            st.setInt(1, subid);
            try(ResultSet rs = st.executeQuery()){
                xml = util.convertResultSetToXML(rs);
            }
        }
        return xml;
        
    }
}
