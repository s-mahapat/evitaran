/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.Subscription;

import IAS.Class.JDSLogger;
import IAS.Class.Queries;
import IAS.Class.util;
import IAS.Model.JDSModel;
import com.mysql.jdbc.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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

    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Model.SubscriptionModel");

    public SubscriptionModel(HttpServletRequest request) throws SQLException {
        // call the base class constructor.
        super(request);

        //this.journalName = request.getParameter("journalName");
        //this.copies = 0;
        this.subscriberNumber = request.getParameter("subscriberNumber");
        if (session.getAttribute("inwardUnderProcess") != null) {
            this.inwardNumber = session.getAttribute("inwardUnderProcess").toString();
        } else {
            this.inwardNumber = null;
        }

    }

    public String addSubscription() throws ParserConfigurationException, SQLException, TransformerException {

        String xml = null;
        String journalCodes[] = request.getParameterValues("journalCode");
        String startYear[] = request.getParameterValues("startYear");
        String endYear[] = request.getParameterValues("endYear");
        String Copies[] = request.getParameterValues("copies");
        float subscriptionTotal = Float.parseFloat(request.getParameter("subscriptionTotal"));
        String remarks = request.getParameter("remarks");
        int subscriptionID;

        //this.inwardNumber = "12A-00001";
        if (this.inwardNumber == null) {
            xml = util.convertStringToXML("No Inward Under Process. Cannot add a subscription without an Inward","error");
        } else {
            // the query name from the jds_sql properties files in WEB-INF/properties folder
            String sql = Queries.getQuery("insert_subscription");
            PreparedStatement st = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            int paramIndex = 0;
            st.setString(++paramIndex, this.subscriberNumber);
            st.setString(++paramIndex, this.inwardNumber);
            st.setFloat(++paramIndex, subscriptionTotal);
            st.setString(++paramIndex, remarks);
            if (db.executeUpdatePreparedStatement(st) == 1) {
                ResultSet rs = st.getGeneratedKeys();
                rs.first();
                subscriptionID = rs.getInt(1);
                sql = Queries.getQuery("insert_subscription_detail");
                st = conn.prepareStatement(sql);
                for(int i=0; i<journalCodes.length ;i++){
                    paramIndex = 0;
                    st.setInt(++paramIndex,subscriptionID);
                    st.setString(++paramIndex, journalCodes[i]);
                    st.setInt(++paramIndex, Integer.parseInt(Copies[i]));
                    st.setInt(++paramIndex, Integer.parseInt(startYear[i]));
                    st.setInt(++paramIndex, Integer.parseInt(endYear[i]));
                    if(db.executeUpdatePreparedStatement(st)!=1){
                        throw(new SQLException("Failed to insert subscription details"));
                    }
                }
                xml = util.convertStringToXML(String.valueOf(subscriptionID),"subscriptionID");

            }else{
                //failed to update subscription
                throw(new SQLException("Failed to insert subscription"));
            }
        }
        return xml;
    }

    public int deleteSubscription() throws ParserConfigurationException, SQLException, TransformerException {

        String sql = Queries.getQuery("delete_subscription");
        PreparedStatement st = conn.prepareStatement(sql);
        int paramIndex = 0;
        int subscriptionId = Integer.parseInt(request.getParameter("id"));
        st.setInt(++paramIndex, subscriptionId);
        return db.executeUpdatePreparedStatement(st);
    }

    public String getSubscription() throws ParserConfigurationException, SQLException, TransformerException {

        String xml = null;
        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("search_subscrption");
        PreparedStatement st = conn.prepareStatement(sql);
        int paramIndex = 0;
        st.setString(++paramIndex, this.subscriberNumber);
        ResultSet rs = db.executeQueryPreparedStatement(st);
        if (rs != null) {
            xml = util.convertResultSetToXML(rs);
        } else {
            xml = util.convertStringToXML("Failed to get subscription","error");
        }
        return xml;

    }

    public String getSubscriptionDetails() throws ParserConfigurationException, SQLException, TransformerException {

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
            xml = util.convertStringToXML("Failed to get subscription details","error");
        }
        return xml;
    }
}
