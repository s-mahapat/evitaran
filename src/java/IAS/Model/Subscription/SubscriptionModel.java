package IAS.Model.Subscription;

import IAS.Bean.Invoice.InvoiceFormBean;
import IAS.Bean.Inward.inwardFormBean;
import IAS.Bean.Subscription.SubscriptionDetailBean;
import IAS.Bean.Subscription.SubscriptionFormBean;
import IAS.Class.Ajax.AjaxResponse;
import IAS.Class.JDSConstants;
import IAS.Class.JDSLogger;
import IAS.Class.Queries;
import IAS.Class.util;
import IAS.Model.JDSModel;
import IAS.Model.Subscriber.subscriberModel;
import com.mysql.jdbc.Statement;
import com.thoughtworks.xstream.XStream;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import org.apache.commons.dbutils.BeanProcessor;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.ResultSetHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
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
    private int nextYearSubscriptionPeriod = 0;
    private Connection connection = null;

    public SubscriptionModel(HttpServletRequest request) throws SQLException {
        // call the base class constructor.
        super(request);
        this.connection = super.getConnection();
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

    public SubscriptionModel() throws SQLException {
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
        //String Total[] = request.getParameterValues("total");
        float subscriptionTotal = Float.parseFloat(request.getParameter("subscriptionTotal"));
        //String remarks = request.getParameter("remarks");
        int subscriptionID;

        AjaxResponse resp = new AjaxResponse();

        // check that there is a valid subscriber number
        if (this.subscriberNumber == null || this.subscriberNumber.length() == 0) {
            xml = resp.getSuccessXML(false, "Cannot add subscription without a valid subscriber ID");
            return xml;
        }

        //this.inwardNumber = "12A-00001";
        if (this.inwardNumber == null) {
            xml = resp.getSuccessXML(false, "No Inward Under Process. Cannot add a subscription without an Inward");
        } else {

            SubscriptionDetailBean _subscriptionDetailBean = new SubscriptionDetailBean();
            FillBean(this.request, _subscriptionBean);
            FillBean(this.request, _subscriptionDetailBean);
            _subscriptionBean.setSubscriptionTotal(subscriptionTotal);
            request.setAttribute("subscriptionFormBean", _subscriptionBean);
            request.setAttribute("subscriptionDetailBean", _subscriptionDetailBean);

            // start transaction here.
            Connection conn = this.getConnection();
            conn.setAutoCommit(false);
            try {
                subscriptionID = this.addNewSubscription(conn, this.subscriberNumber, this.inwardNumber, util.getDateString());
                if (subscriptionID > 0) {
                    //set the subscription id and total in the bean
                    _subscriptionBean.setSubscriptionID(subscriptionID);

                    int[] res = this.__addSubscriptionDetail(conn,
                            subscriptionID,
                            util.convertStringArraytoIntArray(journalGroupID),
                            util.convertStringArraytoIntArray(startYear),
                            util.convertStringArraytoIntArray(startMonth),
                            util.convertStringArraytoIntArray(endYear),
                            util.convertStringArraytoIntArray(Copies),
                            //util.convertStringArraytoFloatArray(Total),
                            util.convertStringArraytoIntArray(journalPriceGroupID));

                    for (int i = 0; i < res.length; i++) {
                        if (res[i] != 1) {
                            xml = resp.getSuccessXML(false, "Failed to save subscription details");
                            throw (new SQLException("Failed to update scubscription details"));
                        }
                    }

                    /*
                     ************************************************************
                     *
                     // PROCESS AGENT INWARD - // Do not create invoice if the subscriptions
                     * are created for agent inwards
                     *
                     ************************************************************
                     */
                    if (_inwardFormBean.getAgentName() == null || (_inwardFormBean.getAgentName().equals(""))) {
                        // Update the Performa Invoice
                        if (inwardPurposeID == JDSConstants.INWARD_PURPOSE_REQUEST_FOR_INVOICE) {
                            this.updateInvoice(1);
                        } else if (this._inwardFormBean.getAmount() < subscriptionTotal) {
                            // create an invoice if the subscription value is greater
                            // than what he has paid in the inward
                            _subscriptionBean.setBalance(subscriptionTotal - this._inwardFormBean.getAmount());
                            this.updateInvoice(2);
                        }
                    }
                    //Update inward with completed flag once the transaction is completed
                    // if (this.CompleteInward(this.inwardID) == 1) {
                    //   session.setAttribute("inwardUnderProcess", null);
                    //}
                    xml = util.convertStringToXML(String.valueOf(subscriptionID), "subscriptionID");

                    conn.commit(); // complete the transaction here.
                }
            } catch (SQLException | ParseException | NumberFormatException e) {
                conn.rollback();
            } finally {
                conn.setAutoCommit(true);
                conn.close();
            }

        }
        return xml;
    }

    public void complete_inward() throws SQLException {
        //Update inward with completed flag once the transaction is completed
        this.CompleteInward(this.inwardID);
    }

    private int[] __addSubscriptionDetail(Connection conn,
            int subscriptionID, int[] journalGroupID,
            int[] startYear, int[] startMonth, int[] endYear, int[] copies,
            int[] journalPriceGroupID) throws SQLException {

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

    private int[] __addSubscriptionDetail(
            int subscriptionID, int[] journalGroupID,
            int[] startYear, int[] startMonth, int[] endYear, int[] copies,
            float[] total, int[] journalPriceGroupID) throws SQLException {

        String sql = Queries.getQuery("insert_subscription_detail");
        int[] res;
        try (Connection conn = this.getConnection();
                PreparedStatement st = conn.prepareStatement(sql)) {
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

    public int addNewSubscription(Connection conn, String subscriberNumber, String inwardNumber, String subscriptionDate) throws SQLException {

        int subscriptionID = 0;

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("insert_subscription");
        try (PreparedStatement st = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);) {
            int paramIndex = 0;
            st.setString(++paramIndex, subscriberNumber);
            st.setString(++paramIndex, inwardNumber);
            st.setDate(++paramIndex, util.dateStringToSqlDate(subscriptionDate));
            int ra = st.executeUpdate();

            // check if the row was added
            if (ra == 1) {
                try (ResultSet rs = st.getGeneratedKeys()) {
                    rs.first();
                    subscriptionID = rs.getInt(1);
                }
            }
        } catch (ParseException ex) {
            logger.error(ex);
        } finally {
            //conn.close();
            return subscriptionID;
        }

    }

    public int addNewSubscription(String subscriberNumber, String inwardNumber, String subscriptionDate) throws SQLException {

        int subscriptionID = 0;

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("insert_subscription");
        try (Connection conn = this.getConnection();
                PreparedStatement st = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);) {
            int paramIndex = 0;
            st.setString(++paramIndex, subscriberNumber);
            st.setString(++paramIndex, inwardNumber);
            st.setDate(++paramIndex, util.dateStringToSqlDate(subscriptionDate));
            int ra = st.executeUpdate();

            // check if the row was added
            if (ra == 1) {
                try (ResultSet rs = st.getGeneratedKeys()) {
                    rs.first();
                    subscriptionID = rs.getInt(1);
                }
            }
        } catch (ParseException ex) {
            logger.error(ex);
        } finally {
            //conn.close();
            return subscriptionID;
        }

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
        try {
            this.insertUpdateInvoiceForSubscription(subscriptionID, 2, total);
        } catch (ParseException | InvocationTargetException | IllegalAccessException ex) {
            throw new SQLException(ex);
        }
        return res;
    }

    /*
     Given a subscription id, it returns the invoice type associated with the
     subscription. All Please refer invoices will not be considered
     */
    private int getInvoiceType(int subscriptionID) {
        int invoice_type_id = 0;
        return invoice_type_id;
    }

    /*
     * This method is to be used by agent excel upload functionality
     * to save subscription detail
     */
    public int[] addNewSubscriptionDetail(
            int subscriptionID,
            int[] journalGroupID,
            int startYear,
            int startMonth,
            int endYear,
            int[] copies,
            String subscriberNumber) throws SQLException {

        int res[] = new int[journalGroupID.length];
        int[] _journalPriceGroupID = new int[journalGroupID.length];
        int numYears = endYear - startYear + 1;
        int subscriberTypeID = new subscriberModel(request).getSubscriberType(subscriberNumber);

        int[] _startYear = new int[journalGroupID.length];
        int[] _startMonth = new int[journalGroupID.length];
        int[] _endYear = new int[journalGroupID.length];
        //int[] _copies = {copies};
        float[] _total = {0};

        for (int j = 0; j < journalGroupID.length; j++) {
            _startYear[j] = startYear;
            _startMonth[j] = startMonth;
            _endYear[j] = endYear;

        }

        /* if the start month is not Jan, then consider it as one year less
         * for e.g. Jul 2012 to Jun 2013, would normally be considered as 2 yrs, but its
         * actually one year. so deduct 1 from the num of years
         */
        if (startMonth > 1) {
            numYears--;
        }

        // Get the price group ids for all the journals
        for (int i = 0; i < journalGroupID.length; i++) {
            try {
                _journalPriceGroupID[i] = this.getJournalPriceGroupID(startYear, numYears, journalGroupID[i], subscriberTypeID);
            } catch (TransformerException | ParserConfigurationException ex) {
                logger.error(ex);
                return res;
            }
        }
        res = this.__addSubscriptionDetail(
                subscriptionID, journalGroupID,
                _startYear, _startMonth,
                _endYear, copies,
                _total, _journalPriceGroupID);
        return res;
    }

    public int updateSubscriptionDetail(int id, int startYear, int startMonth,
            int endYear, boolean active, int copies, int SubscriberTypeID)
            throws ParserConfigurationException, SQLException, TransformerException {

        Connection _conn = this.getConnection();
        int rc = 0;
        int journalGroupID = 0;
        boolean oldactiveFlag;
        boolean inactive = false;
        int endMonth = 12;
        int numYears = endYear - startYear + 1;

        /* set the endmonth to month - 1 if the start month in not jan else the end
         month is default december
        
         also decrease the numYears by 1 for such a case
         */
        if (startMonth > 1) {
            endMonth = startMonth - 1;
            numYears--;
        }

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
        _conn.setAutoCommit(false);

        //get journal journal grpid,active,subscriptionid and total from subscriptiondetails table
        String sql = "select journalGroupID,active from subscriptiondetails where id=" + id;
        try (PreparedStatement pst = _conn.prepareStatement(sql)) {
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.first()) {
                    journalGroupID = rs.getInt(1);
                    oldactiveFlag = rs.getBoolean(2);
                    if (oldactiveFlag == false && active == false) {
                        inactive = true; //if old and new active flag is the same and its inactive, do not go further
                    }
                }
            }

        }
        if (inactive) {
            _conn.setAutoCommit(true);
            _conn.close();
            return (rc);
        }

        // get the new price group id and price
        int newPriceGroupID = this.getJournalPriceGroupID(startYear, numYears, journalGroupID, SubscriberTypeID);

        //float total = copies * rs.getInt(2);
        sql = Queries.getQuery("update_subscription_detail");
        try (PreparedStatement st = _conn.prepareStatement(sql)) {
            int paramIndex = 0;
            st.setInt(++paramIndex, startYear);
            st.setInt(++paramIndex, startMonth);
            st.setInt(++paramIndex, endMonth);
            st.setInt(++paramIndex, endYear);
            st.setInt(++paramIndex, newPriceGroupID);
            st.setInt(++paramIndex, copies);
            st.setBoolean(++paramIndex, active);
            st.setInt(++paramIndex, id);
            rc = st.executeUpdate();
            _conn.commit();
        } catch (SQLException e) {
            _conn.rollback();
            throw (e);
        } finally {
            _conn.commit();
            _conn.setAutoCommit(true);
            _conn.close();
            return rc;
        }

    }

    public int deleteSubscription() throws ParserConfigurationException, SQLException, TransformerException {

        String sql = Queries.getQuery("delete_subscription");
        int rc;
        try (Connection _conn = this.getConnection(); PreparedStatement st = _conn.prepareStatement(sql)) {
            int paramIndex = 0;
            int subscriptionId = Integer.parseInt(request.getParameter("id"));
            st.setInt(++paramIndex, subscriptionId);
            rc = st.executeUpdate();
        } finally {
            //_conn.close();
        }
        return rc;
    }

    public String getSubscription() throws ParserConfigurationException, SQLException, TransformerException, IOException {

        String xml;

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("get_subscription_for_subscriber");
        try (Connection _conn = this.getConnection(); PreparedStatement st = _conn.prepareStatement(sql)) {
            int paramIndex = 0;
            st.setString(++paramIndex, this.subscriberNumber);
            try (ResultSet rs = st.executeQuery()) {
                if (rs != null) {
                    xml = util.convertResultSetToXML(rs);
                } else {
                    xml = util.convertStringToXML("Failed to get subscription", "error");
                }
            }
        } finally {
            //_conn.close();
        }
        return xml;

    }

    public SubscriptionFormBean getSubscriptionByID(int _id) throws ParserConfigurationException,
            SQLException, TransformerException, IOException {

        String sql = Queries.getQuery("get_subscription_info_by_id");
        IAS.Bean.Subscription.SubscriptionFormBean _SubscriptionFormBean = null;
        BeanProcessor bProc = new BeanProcessor();
        try (Connection conn = this.getConnection(); PreparedStatement st = conn.prepareStatement(sql);) {
            st.setInt(1, _id);
            try (ResultSet rs = st.executeQuery()) {
                rs.first();
                _SubscriptionFormBean = bProc.toBean(rs, IAS.Bean.Subscription.SubscriptionFormBean.class);
            }

            return _SubscriptionFormBean;
        }

    }

    public String getSubscriptionDetailBySubscriptionID(int _id, int subscriber_type_id) throws ParserConfigurationException,
            SQLException, TransformerException, IOException {

        String xml;
        String sql;
        subscriberModel _subscriberModel = new subscriberModel(request);
        boolean isFree = _subscriberModel.isSubscriberTypeFree(subscriber_type_id);

        if (isFree) {
            sql = Queries.getQuery("get_subscription_detail_by_subscription_id_free");
        } else {
            // the query name from the jds_sql properties files in WEB-INF/properties folder
            sql = Queries.getQuery("get_subscription_detail_by_subscription_id");
        }

        try (Connection _conn = this.getConnection(); PreparedStatement st = _conn.prepareStatement(sql);) {
            st.setInt(1, _id);
            try (ResultSet rs = st.executeQuery()) {
                xml = util.convertResultSetToXML(rs);
            }
        } finally {
            //_conn.close();
        }
        return xml;
    }

    public String getSubscriptionDetails() throws ParserConfigurationException, SQLException, TransformerException, IOException {

        String xml;
        String sql;
        int subscription_id = Integer.parseInt(request.getParameter("id"));
        int subscriber_type_id = Integer.parseInt(request.getParameter("subtypeid"));

        subscriberModel _subscriberModel = new subscriberModel(request);
        boolean isFree = _subscriberModel.isSubscriberTypeFree(subscriber_type_id);

        /* if free subscriber then dont bother about price group ID
         * so pick another query for free subscribers
         */
        if (isFree) {
            // the query name from the jds_sql properties files in WEB-INF/properties folder
            sql = Queries.getQuery("get_subscription_details_free_subscribers");
        } else {
            // the query name from the jds_sql properties files in WEB-INF/properties folder
            sql = Queries.getQuery("get_subscription_details");
        }
        try (Connection _conn = this.getConnection();
                PreparedStatement st = _conn.prepareStatement(sql)) {
            int paramIndex = 0;
            st.setInt(++paramIndex, subscription_id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs != null) {
                    xml = util.convertResultSetToXML(rs);
                } else {
                    logger.error("Failed to get subscription details for id: " + subscription_id);
                    xml = util.convertStringToXML("Failed to get subscription details", "error");
                }
            }
        } finally {
            //_conn.close();
        }
        return xml;
    }

    public String getSubscriptionDetailsForInward(String InwardNumber) throws ParserConfigurationException, SQLException, TransformerException, IOException {

        List<IAS.Bean.Subscription.SubscriptionDetail> sub_details = this.getSubscriptionDetailsObjectsForInward(InwardNumber);
        String xml = null;
        try {
            XStream xstream = new XStream();
            xstream.alias("row", IAS.Bean.Subscription.SubscriptionDetail.class);
            xstream.alias("results", List.class);
            xml = xstream.toXML(sub_details);
        } catch (Exception e) {
            logger.error(e);
        }
        return xml;
    }

    public List<IAS.Bean.Subscription.SubscriptionDetail> getSubscriptionDetailsObjectsForInward(String InwardNumber) throws SQLException {

        // Use the BeanListHandler implementation to convert all
        // ResultSet rows into a List of IAS.Bean.Subscription.SubscriptionDetail JavaBeans.
        ResultSetHandler<List<IAS.Bean.Subscription.SubscriptionDetail>> h = new BeanListHandler<>(IAS.Bean.Subscription.SubscriptionDetail.class);

        // No DataSource so we must handle Connections manually
        QueryRunner run = new QueryRunner();

        List<IAS.Bean.Subscription.SubscriptionDetail> sub_details = null;

        HashMap JournalGrpIDsMap = new HashMap();

        try (Connection _conn = this.getConnection()) {
            // Execute the SQL statement and return the results in a List of
            // Person objects generated by the BeanListHandler.
            sub_details = run.query(_conn, Queries.getQuery("get_subscription_details_for_inward"),
                    h, InwardNumber);

            for (IAS.Bean.Subscription.SubscriptionDetail detail : sub_details) {
                if (JournalGrpIDsMap.containsKey(detail.getJournalGroupID())) {
                    detail.setRate(0);
                } else {
                    JournalGrpIDsMap.put(detail.getJournalGroupID(), 1);
                }
            }
        } catch (SQLException ex) {
            logger.error(ex);
        } finally {
            return sub_details;
        }
    }

    public String getJournalPrice(int startYear, int numYears, int journalGroupID, int subscriberTypeID) throws TransformerException,
            ParserConfigurationException,
            SQLException,
            IOException {

        subscriberModel _subscriberModel = new subscriberModel(request);
        if (_subscriberModel.isSubscriberTypeFree(subscriberTypeID)) {
            return "<results><row><id>0</id><rate>0.0</rate></row></results>";
        }

        String xml = null;
        String sql = Queries.getQuery("get_journal_group_price");
        try (Connection _conn = this.getConnection(); PreparedStatement ps = _conn.prepareStatement(sql);) {
            ps.setInt(1, journalGroupID);
            ps.setInt(2, subscriberTypeID);
            ps.setInt(3, startYear);
            ps.setInt(4, numYears);
            try (ResultSet rs = ps.executeQuery()) {
                xml = util.convertResultSetToXML(rs);
            }
        }
        return xml;
    }

    public int getJournalPriceGroupID(int startYear, int numYears, int journalGroupID, int subscriberTypeID) throws TransformerException,
            ParserConfigurationException,
            SQLException {

        int priceGroupID = 0;
        String sql = Queries.getQuery("get_journal_group_price");
        try (Connection _conn = this.getConnection(); PreparedStatement ps = _conn.prepareStatement(sql);) {
            ps.setInt(1, journalGroupID);
            ps.setInt(2, subscriberTypeID);
            ps.setInt(3, startYear);
            ps.setInt(4, numYears);
            try (ResultSet rs = ps.executeQuery();) {
                if (rs.first()) {
                    priceGroupID = rs.getInt(1);
                }
            }
        } finally {
            //_conn.close();
        }
        return priceGroupID;
    }

    public String getJournalGroupContents(int journalGroupID) throws SQLException, ParserConfigurationException, TransformerException {
        // get connection from pool

        String xml = null;

        String sql = Queries.getQuery("get_journal_groupid_contents");
        try (Connection _conn = this.getConnection(); PreparedStatement ps = _conn.prepareStatement(sql);) {
            ps.setInt(1, journalGroupID);
            try (ResultSet rs = ps.executeQuery();) {
                xml = util.convertResultSetToXML(rs);
            }
        } finally {
            //_conn.close();
            return xml;
        }
    }

    private synchronized String getNextInvoiceNumber() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException {

        String nextInvoice = null;
        // Invoice Type to be tagged in the invoice number similar to subscriber and inward
        String invoiceType = "I";
        //get the last invoice number from invoice table
        String lastInvoiceSql = Queries.getQuery("get_last_invoice");
        String lastInvoice;

        // get connection from pool
        try (Connection _conn = this.getConnection(); PreparedStatement pst = _conn.prepareStatement(lastInvoiceSql);) {
            try (ResultSet rs = pst.executeQuery()) {
                Calendar calendar = Calendar.getInstance();
                //if true there exists a previous invoice for the year, so just increment the invoice number.
                if (rs.first()) {
                    lastInvoice = rs.getString(1);
                    // if this condition succeeds then it menas we found an invoice with the new naming pattern
                    if (lastInvoice.length() == 11 && lastInvoice.contains("-")) {
                        // get the last invoice number after the split
                        int invoice = Integer.parseInt(lastInvoice.substring(6));
                        //increment
                        ++invoice;
                        //apend the year, month character and new invoice number.
                        nextInvoice = lastInvoice.substring(0, 2) + getMonthToCharacterMap(calendar.get(Calendar.MONTH)) + "-" + invoiceType + "-" + String.format("%05d", invoice);
                        return nextInvoice;
                    }

                }
                // there is no previous record for the year, so start the numbering afresh
                String year = String.valueOf(calendar.get(Calendar.YEAR)).substring(2);
                nextInvoice = year + getMonthToCharacterMap(calendar.get(Calendar.MONTH)) + "-" + invoiceType + "-" + String.format("%05d", 1);

            }
        } finally {
            //_conn.close();
        }
        return nextInvoice;
    }

    private String getNextInvoiceNumber(String lastInvoice) throws SQLException,
            ParseException,
            java.lang.reflect.InvocationTargetException,
            java.lang.IllegalAccessException {

        if (lastInvoice == null) {
            return this.getNextInvoiceNumber();
        }
        String nextInvoice;

        // get the last invoice number after the split
        int invoice = Integer.parseInt(lastInvoice.substring(6));
        //increment
        ++invoice;

        nextInvoice = lastInvoice.substring(0, 6) + String.format("%05d", invoice);
        return nextInvoice;
    }

    private int updateInvoice(int invoice_type_id) throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException {

        //Connection _conn = (Connection) request.getSession(false).getAttribute("connection");
        InvoiceFormBean invoiceFormBean = new IAS.Bean.Invoice.InvoiceFormBean();
        request.setAttribute("invoiceFormBean", invoiceFormBean);
        String sql;
        int paramIndex = 0;
        int invoiceID = 0;
        //get the next invoice number and fill the bean
        String invoiceNumber = getNextInvoiceNumber();
        invoiceFormBean.setInvoiceNumber(invoiceNumber);
        invoiceFormBean.setInvoiceTypeID(invoice_type_id);

        //subscription ID
        int SubscriptionID = _subscriptionBean.getSubscriptionID();
        float amount = _subscriptionBean.getSubscriptionTotal();
        if (invoice_type_id == 2) {
            amount = _subscriptionBean.getBalance();
        }
        invoiceFormBean.setSubscriptionID(SubscriptionID);

        //upadte _invoiceFormBean
        this._invoiceFormBean = invoiceFormBean;

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        sql = Queries.getQuery("invoice_insert");
        try (Connection _conn = this.getConnection();
                PreparedStatement st = _conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            st.setString(++paramIndex, invoiceNumber);
            st.setInt(++paramIndex, SubscriptionID);
            st.setDate(++paramIndex, util.dateStringToSqlDate(util.getDateString()));
            st.setInt(++paramIndex, invoice_type_id);
            st.setFloat(++paramIndex, amount);
            if (st.executeUpdate() == 1) {
                try (ResultSet rs = st.getGeneratedKeys()) {
                    rs.first();
                    invoiceID = rs.getInt(1);
                }
            }

        } finally {
            //_conn.close();
        }

        return invoiceID;
    }

    /**
     * Given a subscription id creates/updates an invoice of the given type
     *
     * @param subscriptionID The subscription ID for which invoice should be
     * created/updated
     * @param invoice_type_id The type of invoice to be created/updated. 1,2,3
     * @param amount The invoice amount
     * @return Invoice id
     * @throws java.sql.SQLException
     * @throws java.text.ParseException
     * @throws java.lang.reflect.InvocationTargetException
     * @throws java.lang.IllegalAccessException
     */
    public int insertUpdateInvoiceForSubscription(int subscriptionID,
            int invoice_type_id,
            float amount) throws SQLException, ParseException, InvocationTargetException, IllegalAccessException {

        /* get the existing invoice if any */
        String sql = Queries.getQuery("select_invoice_by_subid");
        int invoice_id;
        try (Connection _conn = this.getConnection(); PreparedStatement st = _conn.prepareStatement(sql)) {
            st.setInt(1, subscriptionID);
            //st.setInt(2, invoice_type_id);
            ResultSet rs = st.executeQuery();
            if (rs.first()) {
                // there is already an row for the subscriptiton, we need to update the amount
                invoice_id = rs.getInt("id");
                sql = Queries.getQuery("update_invoice_amount");
                try (PreparedStatement upd_st = _conn.prepareStatement(sql)) {
                    upd_st.setFloat(1, amount);
                    upd_st.setInt(2, invoice_id);
                    upd_st.executeUpdate();
                }

            } else {
                // here there is no existing invoice for this subscriptionid and invoice_type_id
                // we will add a new invoice here
                String invoiceNumber = getNextInvoiceNumber();
                sql = Queries.getQuery("insert_new_invoice");
                try (PreparedStatement insert_st = _conn.prepareStatement(sql)) {
                    insert_st.setString(1, invoiceNumber);
                    insert_st.setInt(2, subscriptionID);
                    insert_st.setDate(3, util.dateStringToSqlDate(util.getDateString()));
                    insert_st.setInt(4, invoice_type_id);
                    insert_st.setFloat(5, amount);
                    invoice_id = insert_st.executeUpdate();
                }

            }

        }
        return invoice_id;
    }

    public String getSubscriptionInwardInfo(int subid) throws
            SQLException,
            ParserConfigurationException,
            TransformerException {

        String sql = Queries.getQuery("get_subscription_inward_amount");
        String xml;
        try (Connection _conn = this.getConnection(); PreparedStatement st = _conn.prepareStatement(sql)) {
            st.setInt(1, subid);
            try (ResultSet rs = st.executeQuery()) {
                xml = util.convertResultSetToXML(rs);
            }
        } finally {
            //_conn.close();
        }
        return xml;

    }

    public String getPleaseReferList(int medium, int year, String ctext) throws SQLException,
            ParserConfigurationException,
            TransformerException,
            ParseException,
            InvocationTargetException,
            IllegalAccessException {

        // select prl that is generated on the same day, atleast this way
        // we save some time and space else every click will generate a new PRL list
        String sql = "select id from prl where year=? and DATE(date)=DATE(NOW())";
        int prl_id = 0;
        try (Connection _conn = this.getConnection(); PreparedStatement st = _conn.prepareStatement(sql)) {
            st.setInt(1, year);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.first()) {
                    prl_id = rs.getInt(1);
                }
            }
        } catch (SQLException ex) {
            logger.error(ex);
            return null;
        } finally {
            //_conn.close();
        }

        if (prl_id == 0) {
            // this means that there is no existing PRL list for the year
            prl_id = this._generatePleaseReferList(year, ctext);
        }
        return _getPleaseReferList(prl_id, year, medium);

    }

    private String _getPleaseReferList(int prl_id, int year, int medium) throws SQLException,
            ParserConfigurationException,
            TransformerException {

        String sql = Queries.getQuery("get_pl_refer_list_for_email_and_all");
        String xml = null;
        String email_search_string = null;
        /*
         * if medium == 1 get all subscribers that have email id.
         */
        if (medium == 1) {
            email_search_string = "%@%"; // search for valid email ids
        } else if (medium == 2) {
            email_search_string = "";  // not valid email ids
            sql = Queries.getQuery("get_pl_refer_list_for_print_only");
        } else if (medium == 3) {
            email_search_string = "%"; // search for all
        }
        try (Connection _conn = this.getConnection(); PreparedStatement pst = _conn.prepareStatement(sql)) {
            pst.setInt(1, prl_id);
            pst.setInt(2, year);
            pst.setString(3, email_search_string);
            try (ResultSet rs = pst.executeQuery()) {
                xml = util.convertResultSetToXML(rs);
            }
        } finally {
            //_conn.close();
        }
        return xml;
    }

    private int _generatePleaseReferList(int year, String ctext) throws SQLException,
            ParserConfigurationException,
            TransformerException,
            ParseException,
            InvocationTargetException,
            IllegalAccessException {

        Connection _conn = this.getConnection();
        String sql;
        int prl_id = 0;

        // start transaction here
        _conn.setAutoCommit(false);

        // first insert the new row into prl table and get the prl id
        sql = "insert into prl(year,ctext) values (?,?)";
        try (PreparedStatement pst = _conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pst.setInt(1, year);
            pst.setString(2, ctext); // save the custom text in db
            pst.executeUpdate();
            try (ResultSet rs = pst.getGeneratedKeys()) {
                if (rs.first()) {
                    prl_id = rs.getInt(1);  // get the prl id
                }
            }
        } catch (SQLException ex) {
            logger.error(ex);
            _conn.rollback();
            _conn.setAutoCommit(true);
            //_conn.close();
        }
        // get the subscribers and thier subscription for which the
        // prl should be sent
        sql = Queries.getQuery("get_pl_refer_list");

        String sql_insert_prl_details = "insert into prl_details(prl_id, invoice_id, period) values (?, ?, ?)";
        String invoiceNumber = null;
        boolean isNullRs = false;
        try (PreparedStatement pst = _conn.prepareStatement(sql_insert_prl_details)) {
            try (PreparedStatement st = _conn.prepareStatement(sql)) {
                st.setInt(1, year); // set the year for which prl list should be retreived
                st.setInt(2, year);
                try (ResultSet rs = st.executeQuery()) {
                    if (!rs.isBeforeFirst()) {
                        isNullRs = true;   // set this if there is atleast 1 record is the resultset, this ensures
                        // we do not save PRL for an empty list
                    } else {
                        rs.beforeFirst();   // move it back to the starting of the resultset
                    }

                    while (rs.next()) {  // for each record from the query insert into the prl_details table

                        invoiceNumber = this.getNextInvoiceNumber(invoiceNumber);
                        int subscription_id = rs.getInt(2);
                        int invoice_id = 0;
                        float rate = getNextYearSubscriptionRate(subscription_id, year);
                        int _nextYearSubscriptionPeriod = this.getNextYearSubscriptionPeriod();

                        // insert the invoice and get the invoice id
                        // the query name from the jds_sql properties files in WEB-INF/properties folder
                        sql = Queries.getQuery("invoice_insert");
                        try (PreparedStatement _st = _conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                            _st.setString(1, invoiceNumber);
                            _st.setInt(2, subscription_id);
                            _st.setDate(3, util.dateStringToSqlDate(util.getDateString()));
                            _st.setInt(4, 3); // invoice type
                            _st.setFloat(5, rate);
                            if (_st.executeUpdate() == 1) {
                                try (ResultSet _rs = _st.getGeneratedKeys()) {
                                    _rs.first();
                                    invoice_id = _rs.getInt(1);
                                }
                            }

                        }
                        pst.setInt(1, prl_id);
                        pst.setInt(2, invoice_id);
                        pst.setInt(3, _nextYearSubscriptionPeriod);
                        pst.addBatch();  // add all to the batch
                    }
                    pst.executeBatch();
                    //_conn.commit(); // now save the data since all went well in the transaction

                }
            }
        } catch (SQLException ex) {
            logger.error(ex);
            _conn.rollback();
        } finally {
            if (isNullRs) {
                _conn.rollback();
            } else {
                _conn.commit();
            }
            _conn.setAutoCommit(true);
            _conn.close();
        }
        return prl_id;
    }

    private int getNextYearSubscriptionPeriod() {
        return this.nextYearSubscriptionPeriod;
    }

    private float getNextYearSubscriptionRate(int subscription_id, int current_year) throws SQLException {
        // the current_year does not mean the actual calendar year, but refers to the year for which the
        // PRL is being generated
        // get subscription info for subscription id
        String sql = Queries.getQuery("get_subscription_details_prl");
        float _rate = 0;
        this.nextYearSubscriptionPeriod = 0;

        try (Connection _conn = this.getConnection(); PreparedStatement pst = _conn.prepareStatement(sql)) {
            pst.setInt(1, subscription_id);
            pst.setInt(2, current_year);
            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    //String journalName = rs.getString("journalGroupName");
                    int period = rs.getInt("period");
                    int subtype = rs.getInt("subtype");
                    int journalGrpID = rs.getInt("journalGroupID");
                    //int startYear = rs.getInt("startYear");
                    int endYear = rs.getInt("endYear");
                    //int startMonth = rs.getInt("startMonth");
                    //int _years;

                    // increase the start year by 1, since we are calculating PRL/invoice for
                    // next year
                    int newstartYear = endYear + 1;

                    // if the period == 0 it may be a legacy subscription, then we can only
                    // find the minimum subscription period for this
                    if (period > 0) {
                        _rate += getRate(journalGrpID, subtype, newstartYear, period);
                    }

                    /* if the user has a subscription period which is not defined in the database we will get rate
                     * as 0. We need to find the minimum subscription period for that subscriber and get the
                     * price for that period. This happens mostly in case of legacy subscription before JDS.
                     */
                    if (_rate == 0) {
                        period = this.getMinimumSubscriptionPeriod(journalGrpID, subtype, newstartYear);
                        _rate += getRate(journalGrpID, subtype, newstartYear, period);
                    }
                    // only update the subscription period with the minimum period for all subscription details
                    // of the subscription
                    if (period > 0 && this.nextYearSubscriptionPeriod == 0) {
                        this.nextYearSubscriptionPeriod = period;
                    } else if (period < this.nextYearSubscriptionPeriod) {
                        this.nextYearSubscriptionPeriod = period;
                    }
                }
            } catch (SQLException ex) {
                logger.error(ex);
            } catch (Exception ex) {
                logger.error(ex);
            }
        } finally {
            //_conn.close();
        }
        return _rate;
    }

    private float getRate(int journalGrpID, int subtypeID, int startYear, int period) throws SQLException {

        String sql = Queries.getQuery("get_journal_grp_price");
        int _rate = 0;
        try (Connection _conn = this.getConnection();
                PreparedStatement pst = _conn.prepareStatement(sql)) {
            pst.setInt(1, journalGrpID);
            pst.setInt(2, subtypeID);
            pst.setInt(3, startYear);
            pst.setInt(4, period);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.first()) {
                    _rate = rs.getInt("rate");
                }
            }
        } finally {
            //_conn.close();
            return (float) _rate;
        }
    }

    private int getMinimumSubscriptionPeriod(int journalGrpID, int subtypeID, int startYear) throws SQLException {

        String sql = Queries.getQuery("get_journal_group_price_for_minimum_period");
        int _period = 0;
        try (Connection _conn = this.getConnection(); PreparedStatement pst = _conn.prepareStatement(sql)) {
            pst.setInt(1, journalGrpID);
            pst.setInt(2, subtypeID);
            pst.setInt(3, startYear);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.first()) {
                    _period = rs.getInt("period");
                }
            }
        } finally {
            //_conn.close();
            return _period;
        }
    }

    public String getPaymentsForSubscription(int subscription_id) throws SQLException, ParserConfigurationException, TransformerException {

        String sql = Queries.getQuery("get_payments_for_subscription");
        String xml = null;
        try (Connection _conn = this.getConnection(); PreparedStatement pst = _conn.prepareStatement(sql)) {
            pst.setInt(1, subscription_id);
            try (ResultSet rs = pst.executeQuery()) {
                xml = util.convertResultSetToXML(rs);
            }
        } finally {
            //_conn.close();
            return xml;
        }

    }

    /*
     * Returns a list of journal grp ids that the subscriber has already subscribed to in that year and start month
     * This helps us check duplicate subscription before adding a new subscription
     */
    public List<Integer> getDuplicateSubscription(int subscriber_id, int[] journal_grp_ids, int[] start_years, int[] start_months) throws SQLException {
        List<Integer> duplicate_journal_grp_ids = new ArrayList<>();
        int count;

        String sql = Queries.getQuery("check_dup_subscription");
        try (Connection _conn = this.getConnection(); PreparedStatement pst = _conn.prepareStatement(sql)) {
            for (int i = 0; i < journal_grp_ids.length; i++) {
                int journal_grp_id = journal_grp_ids[i];
                pst.setInt(1, start_years[i]);
                pst.setInt(2, start_months[i]);
                pst.setInt(3, subscriber_id);
                pst.setInt(4, journal_grp_id);

                try (ResultSet rs = pst.executeQuery()) {
                    if (rs.first()) {
                        count = rs.getInt("count");
                        if (count > 0) {
                            duplicate_journal_grp_ids.add(journal_grp_id);
                        }
                    }
                }
            }

        } finally {
            //_conn.close();
        }
        return duplicate_journal_grp_ids;
    }
}
