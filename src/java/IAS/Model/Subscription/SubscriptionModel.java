/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.Subscription;

import IAS.Bean.Inward.inwardFormBean;
import IAS.Bean.Subscription.SubscriptionDetailBean;
import IAS.Bean.Subscription.SubscriptionFormBean;
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
    private inwardFormBean _inwardFormBean;
    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Model.SubscriptionModel");

    public SubscriptionModel(HttpServletRequest request) throws SQLException {
        // call the base class constructor.
        super(request);

        //this.journalName = request.getParameter("journalName");
        //this.copies = 0;
        this.subscriberNumber = request.getParameter("subscriberNumber");

        if (session.getAttribute("inwardUnderProcess") != null) {
            this._inwardFormBean = (inwardFormBean) session.getAttribute("inwardUnderProcess");
            this.inwardNumber = _inwardFormBean.getInwardNumber();
        } else {
            this.inwardNumber = null;
        }

    }

    public String addSubscription() throws IllegalAccessException, ParseException,
            ParserConfigurationException, SQLException, TransformerException,
            IOException, InvocationTargetException {

        String xml = null;
        String journalCodes[] = request.getParameterValues("journalGroupID");
        String journalGroupID[] = request.getParameterValues("journalGroupID");
        String startYear[] = request.getParameterValues("startYear");
        String endYear[] = request.getParameterValues("endYear");
        String Copies[] = request.getParameterValues("copies");
        String Total[] = request.getParameterValues("total");
        float subscriptionTotal = Float.parseFloat(request.getParameter("subscriptionTotal"));
        String remarks = request.getParameter("remarks");
        int subscriptionID;

        //this.inwardNumber = "12A-00001";
        if (this.inwardNumber == null) {
            xml = util.convertStringToXML("No Inward Under Process. Cannot add a subscription without an Inward", "error");
        } else {
            SubscriptionFormBean _subscriptionBean = new SubscriptionFormBean();
            SubscriptionDetailBean _subscriptionDetailBean = new SubscriptionDetailBean();

            FillBean(this.request, _subscriptionBean);
            FillBean(this.request, _subscriptionDetailBean);
            _subscriptionBean.setSubscriptionTotal(subscriptionTotal);
            request.setAttribute("subscriptionFormBean", _subscriptionBean);
            request.setAttribute("subscriptionDetailBean", _subscriptionDetailBean);

            // the query name from the jds_sql properties files in WEB-INF/properties folder
            String sql = Queries.getQuery("insert_subscription");
            PreparedStatement st = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            int paramIndex = 0;
            float balance = subscriptionTotal - this._inwardFormBean.getAmount();
            st.setString(++paramIndex, this.subscriberNumber);
            st.setString(++paramIndex, this.inwardNumber);
            st.setFloat(++paramIndex, balance);
            st.setDate(++paramIndex, util.dateStringToSqlDate(util.getDateString()));
            st.setFloat(++paramIndex, subscriptionTotal);
            st.setString(++paramIndex, remarks);
            if (db.executeUpdatePreparedStatement(st) == 1) {
                ResultSet rs = st.getGeneratedKeys();
                rs.first();
                subscriptionID = rs.getInt(1);

                //set the subscription id and total in the bean
                _subscriptionBean.setSubscriptionID(subscriptionID);


                sql = Queries.getQuery("insert_subscription_detail");
                st = conn.prepareStatement(sql);
                for (int i = 0; i < journalCodes.length; i++) {
                    paramIndex = 0;
                    st.setInt(++paramIndex, subscriptionID);
                    st.setInt(++paramIndex, Integer.parseInt(journalCodes[i]));
                    st.setInt(++paramIndex, Integer.parseInt(journalGroupID[i]));
                    st.setInt(++paramIndex, Integer.parseInt(Copies[i]));
                    st.setInt(++paramIndex, Integer.parseInt(startYear[i]));
                    st.setInt(++paramIndex, Integer.parseInt(endYear[i]));
                    st.setFloat(++paramIndex, Float.parseFloat(Total[i]));
                    if (db.executeUpdatePreparedStatement(st) != 1) {
                        throw (new SQLException("Failed to insert subscription details"));
                    }
                }
                xml = util.convertStringToXML(String.valueOf(subscriptionID), "subscriptionID");

            } else {
                //failed to update subscription
                throw (new SQLException("Failed to insert subscription"));
            }
        }
        return xml;
    }

    public int updateSubscriptionDetail(int id, int startYear, int endYear,
            boolean active, int copies, int SubscriberTypeID)
            throws ParserConfigurationException, SQLException, TransformerException {

        int rc;
        try {
            conn.setAutoCommit(false);
            String sql = Queries.getQuery("update_subscription_detail");
            PreparedStatement st = conn.prepareStatement(sql);
            int paramIndex = 0;
            st.setInt(++paramIndex, startYear);
            st.setInt(++paramIndex, endYear);
            st.setInt(++paramIndex, copies);
            st.setBoolean(++paramIndex, active);
            st.setInt(++paramIndex, id);
            rc = db.executeUpdatePreparedStatement(st);

            //update the balance and subscription total after update
            sql = "CALL updateSubscriptionBalance(" + id + ")";
            db.executeUpdate(sql);

            //update the price group
            sql = "select journalGroupID from subscriptiondetails where id=" + id;
            ResultSet rs = db.executeQuery(sql);
            rs.first();
            int journalGroupID = rs.getInt(1);
            rs = this.getJournalPrice(startYear, (endYear - startYear + 1), journalGroupID, SubscriberTypeID);
            rs.first();
            sql = "update subscriptiondetails set journalPriceGroupID=? , total = ? where id=?";
            st = conn.prepareStatement(sql);
            paramIndex = 0;
            st.setInt(++paramIndex, rs.getInt(1));
            st.setFloat(++paramIndex, copies * rs.getFloat(2));
            st.setInt(++paramIndex, id);
            rc = db.executeUpdatePreparedStatement(st);
            conn.commit();
        } catch (SQLException e) {
            conn.rollback();
            throw(e);
        }finally{
            conn.setAutoCommit(true);
        }
        return rc;

    }

    public int deleteSubscription() throws ParserConfigurationException, SQLException, TransformerException {

        String sql = Queries.getQuery("delete_subscription");
        PreparedStatement st = conn.prepareStatement(sql);
        int paramIndex = 0;
        int subscriptionId = Integer.parseInt(request.getParameter("id"));
        st.setInt(++paramIndex, subscriptionId);
        return db.executeUpdatePreparedStatement(st);
    }

    public String getSubscription() throws ParserConfigurationException, SQLException, TransformerException, IOException {

        String xml = null;
        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("get_subscription_for_subscriber");
        PreparedStatement st = conn.prepareStatement(sql);
        int paramIndex = 0;
        st.setString(++paramIndex, this.subscriberNumber);
        ResultSet rs = db.executeQueryPreparedStatement(st);
        if (rs != null) {
            xml = util.convertResultSetToXML(rs);
        } else {
            xml = util.convertStringToXML("Failed to get subscription", "error");
        }
        return xml;

    }

    public ResultSet getSubscriptionByID(int _id) throws ParserConfigurationException,
            SQLException, TransformerException, IOException {

        String sql = Queries.getQuery("get_subscription_info_by_id");
        PreparedStatement st = conn.prepareStatement(sql);
        st.setInt(1, _id);
        ResultSet rs = db.executeQueryPreparedStatement(st);
        return rs;
    }

    public ResultSet getSubscriptionDetailBySubscriptionID(int _id) throws ParserConfigurationException,
            SQLException, TransformerException, IOException {
        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("get_subscription_detail_by_subscription_id");
        PreparedStatement st = conn.prepareStatement(sql);
        st.setInt(1, _id);
        ResultSet rs = db.executeQueryPreparedStatement(st);
        return rs;
    }

    public String getSubscriptionDetails() throws ParserConfigurationException, SQLException, TransformerException, IOException {

        String xml = null;
        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("get_subscription_details");
        PreparedStatement st = conn.prepareStatement(sql);
        int paramIndex = 0;
        st.setInt(++paramIndex, Integer.parseInt(request.getParameter("id")));
        ResultSet rs = db.executeQueryPreparedStatement(st);
        if (rs != null) {
            xml = util.convertResultSetToXML(rs);
        } else {
            logger.error("Failed to get subscription details for id: " + request.getParameter("id"));
            xml = util.convertStringToXML("Failed to get subscription details", "error");
        }
        return xml;
    }

    public ResultSet getSubscriptionDetailsForInward(String InwardNumber) throws ParserConfigurationException, SQLException, TransformerException, IOException {

        String xml = null;
        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("get_subscription_details_for_inward");
        PreparedStatement st = conn.prepareStatement(sql);
        int paramIndex = 0;
        st.setString(++paramIndex, InwardNumber);
        ResultSet rs = db.executeQueryPreparedStatement(st);
        return rs;

    }

    public ResultSet getJournalPrice(int startYear, int numYears, int journalGroupID, int subscriberTypeID) throws SQLException {
        String sql = Queries.getQuery("get_journal_group_price");
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, journalGroupID);
        ps.setInt(2, subscriberTypeID);
        ps.setInt(3, startYear);
        ps.setInt(4, numYears);
        ResultSet rs = this.db.executeQueryPreparedStatement(ps);
        return rs;
    }

    public ResultSet getJournalGroupContents(int journalGroupID) throws SQLException, ParserConfigurationException, TransformerException {
        String sql = Queries.getQuery("get_journal_groupid_contents");
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, journalGroupID);
        ResultSet rs = this.db.executeQueryPreparedStatement(ps);
        return rs;

    }
}
