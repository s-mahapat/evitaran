package IAS.Model.Subscriber;

import IAS.Bean.Invoice.InvoiceFormBean;
import IAS.Bean.Inward.inwardFormBean;
import IAS.Bean.Subscriber.subscriberFormBean;
import IAS.Class.Database;
import IAS.Class.JDSConstants;
import IAS.Class.JDSLogger;
import IAS.Class.Queries;
import IAS.Class.util;
import IAS.Model.JDSModel;
import com.mysql.jdbc.Statement;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Calendar;
import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import org.apache.commons.dbutils.BeanProcessor;
import org.apache.log4j.Logger;
import org.xml.sax.SAXException;

public class subscriberModel extends JDSModel {

    private subscriberFormBean _subscriberFormBean = null;
    private String inwardNumber;
    private int inwardID;
    private int inwardPurposeID;
    private inwardFormBean _inwardFormBean;
    private static Logger logger = JDSLogger.getJDSLogger(subscriberModel.class.getName());

    public subscriberModel(HttpServletRequest request) throws SQLException {
        //call the base class constructor
        super(request);
        if (session.getAttribute("inwardUnderProcess") != null) {
            this._inwardFormBean = (inwardFormBean) session.getAttribute("inwardUnderProcess");
            this.inwardNumber = _inwardFormBean.getInwardNumber();
            this.inwardID = _inwardFormBean.getInwardID();
            this.inwardPurposeID = _inwardFormBean.getInwardPurposeID();
        } else {
            this.inwardNumber = null;
        }
    }

    public int Save() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException {

        subscriberFormBean subscriberFormBean = new IAS.Bean.Subscriber.subscriberFormBean();
        request.setAttribute("subscriberFormBean", subscriberFormBean);
        String sql;
        String mode = "Create";

        // get the connection from connection pool
        Connection conn = this.getConnection();

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, subscriberFormBean);
        this._subscriberFormBean = subscriberFormBean;

        /*
         * check that the subscriber number is not present on the screen, if
         * present means its and edit subscriber else create new subscriber.
         */
        if (!subscriberFormBean.getSubscriberNumber().isEmpty()) {
            return this._updateSubscriber();
        } else {
            //get the next subscriber number
            subscriberFormBean.setSubscriberNumber(getNextSubscriberNumber());
            // the query name from the jds_sql properties files in WEB-INF/properties folder
            sql = Queries.getQuery("subscriber_insert");
            PreparedStatement st = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            // fill in the statement params
            this._setSubscriberStatementParams(st, mode);
            int rowsAffected = st.executeUpdate();

            //If the mode was create new user update the inward with the new subscriber that was created
            if (mode.equalsIgnoreCase("Create")) {
                int _subscriberId;
                try (ResultSet rs = st.getGeneratedKeys()) {
                    rs.first();
                    _subscriberId = rs.getInt(1);
                } catch (SQLException e) {
                    logger.error(e.getMessage(), e);
                    throw e;
                }

                if (this.inwardNumber != null) {
                    String _sql = Queries.getQuery("update_subscriber_in_inward");
                    try (PreparedStatement pst = conn.prepareStatement(_sql)) {
                        pst.setInt(1, _subscriberId);
                        pst.setString(2, this.inwardNumber);
                        db.executeUpdatePreparedStatement(pst);
                    } catch (SQLException e) {
                        logger.error(e.getMessage(), e);
                        throw e;
                    }
                }
            }

            // return the connection back to the pool
            this.CloseConnection(conn);

            return rowsAffected;

        }
    }

    private synchronized String getNextSubscriberNumber() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException {

        String nextSubscriber;
        // Identify the subscriber type i.e.Free or Paid
        String subtype = "S";
        //get the last subscriber number from subscriber table
        String lastSubscriberSql = Queries.getQuery("get_last_subscriber");

        //java.sql.ResultSetMetaData metaData = rs.getMetaData();
        Calendar calendar = Calendar.getInstance();
        String lastSubscriber;

        // get the connection from connection pool
        Connection conn = this.getConnection();

        try (ResultSet rs = conn.prepareStatement(lastSubscriberSql).executeQuery();) {
            //if true there exists a previous subscriber for the year, so just increment the subscriber number.
            if (rs.first()) {

                lastSubscriber = rs.getString(1);

                // get the last subscriber number after the split
                int subscriber = Integer.parseInt(lastSubscriber.substring(6));
                //increment
                ++subscriber;
                //apend the year, month character and new subscriber number.
                nextSubscriber = lastSubscriber.substring(0, 2) + getMonthToCharacterMap(calendar.get(Calendar.MONTH)) + "-" + subtype + "-" + String.format("%05d", subscriber);
            } else {
                // there is no previous record for the year, so start the numbering afresh
                String year = String.valueOf(calendar.get(Calendar.YEAR)).substring(2);
                nextSubscriber = year + getMonthToCharacterMap(calendar.get(Calendar.MONTH)) + "-" + subtype + "-" + String.format("%05d", 1);
            }
        } catch (SQLException e) {
            logger.error(e.getMessage(), e);
            throw e;
        } finally {
            // return the connection back to the pool
            this.CloseConnection(conn);
        }

        return nextSubscriber;
    }

    public String editSubscriber() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {
        return GetSubscriber();
    }

    public String viewSubscriber() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        return this.GetSubscriber();
    }

    private int _updateSubscriber() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException {

        String mode = "Update";
        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("update_subscriber");
        int dbUpdateFlag;

        // get the connection from connection pool
        Connection conn = this.getConnection();

        try (PreparedStatement st = conn.prepareStatement(sql)) {
            this._setSubscriberStatementParams(st, mode);
            dbUpdateFlag = 0;
            if (db.executeUpdatePreparedStatement(st) == 1) {
                //Update inward with completed flag once the transaction is completed
                if ((this.inwardNumber != null) && (this.inwardPurposeID == JDSConstants.INWARD_PURPOSE_ADDRESS_CHANGE)) {
                    if (this.CompleteInward(this.inwardID) == 1) {
                        session.setAttribute("inwardUnderProcess", null);
                    }
                }
                dbUpdateFlag = 1;
            }
        } catch (SQLException e) {
            logger.error(e.getMessage(), e);
            throw e;
        } finally {
            // return the connection back to the pool
            this.CloseConnection(conn);
        }
        return dbUpdateFlag;
    }

    public String GetSubscriber() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        // get the connection from connection pool
        Connection conn = this.getConnection();

        String sql;
        subscriberFormBean subscriberFormBean = new IAS.Bean.Subscriber.subscriberFormBean();

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, subscriberFormBean);
        // the query name from the jds_sql properties files in WEB-INF/properties folder
        sql = Queries.getQuery("get_subscriber_by_number");
        try (PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, subscriberFormBean.getSubscriberNumber());
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    BeanProcessor bProc = new BeanProcessor();
                    Class type = Class.forName("IAS.Bean.Subscriber.subscriberFormBean");
                    subscriberFormBean = (IAS.Bean.Subscriber.subscriberFormBean) bProc.toBean(rs, type);
                }
            } catch (SQLException e) {
                logger.error(e.getMessage(), e);
                throw e;
            }
        } catch (SQLException e) {
            logger.error(e.getMessage(), e);
            throw e;
        } finally {
            // return the connection back to the pool
            this.CloseConnection(conn);
        }
        request.setAttribute("subscriberFormBean", subscriberFormBean);
        return subscriberFormBean.getSubscriberNumber();
    }

    private void _setSubscriberStatementParams(PreparedStatement st, String mode) throws SQLException, ParseException {
        int paramIndex = 0;
        if (mode.equalsIgnoreCase("Create")) {
            st.setString(++paramIndex, _subscriberFormBean.getSubscriberNumber());
            st.setDate(++paramIndex, util.dateStringToSqlDate(_subscriberFormBean.getSubscriberCreationDate()));
        }
        st.setString(++paramIndex, _subscriberFormBean.getSubscriberName());
        st.setString(++paramIndex, _subscriberFormBean.getShippingAddress());
        st.setString(++paramIndex, _subscriberFormBean.getInvoiceAddress());
        st.setString(++paramIndex, _subscriberFormBean.getCity());
        st.setString(++paramIndex, _subscriberFormBean.getDistrict());
        st.setString(++paramIndex, _subscriberFormBean.getState());
        st.setString(++paramIndex, _subscriberFormBean.getCountry());
        st.setInt(++paramIndex, _subscriberFormBean.getPincode());
        st.setString(++paramIndex, _subscriberFormBean.getSubtype());
        st.setString(++paramIndex, _subscriberFormBean.getSubtypedesc());
        st.setString(++paramIndex, _subscriberFormBean.getDepartment());
        st.setString(++paramIndex, _subscriberFormBean.getInstitution());
        st.setString(++paramIndex, _subscriberFormBean.getEmail());
        st.setString(++paramIndex, _subscriberFormBean.getAgentName());
        st.setBoolean(++paramIndex, _subscriberFormBean.isDeactive());
        if (mode.equalsIgnoreCase("Update")) {
            st.setString(++paramIndex, _subscriberFormBean.getSubscriberNumber());
        }
    }

    public String getDistinctSubscriberNames(String searchTerm) throws SQLException,
            ParserConfigurationException, TransformerException {

        String sql = Queries.getQuery("subscriber_names");
        String xml;
        // get the connection from connection pool
        Connection conn = this.getConnection();

        try (PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setString(1, searchTerm + "%");
            try (ResultSet rs = pst.executeQuery()) {
                xml = util.convertResultSetToXML(rs);
            }
        } finally {
            // return the connection back to the pool
            this.CloseConnection(conn);
        }
        return xml;

    }

    public String getDepartmentNames(String searchTerm) throws SQLException,
            ParserConfigurationException, TransformerException {

        // get the connection from connection pool
        Connection conn = this.getConnection();
        String xml;
        String sql = Queries.getQuery("department_names");

        try (PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setString(1, searchTerm + "%");
            try (ResultSet rs = pst.executeQuery()) {
                xml = util.convertResultSetToXML(rs);
            }
        } finally {
            // return the connection back to the pool
            this.CloseConnection(conn);
        }
        return xml;

    }

    public String getInstitutionNames(String searchTerm) throws SQLException,
            ParserConfigurationException, TransformerException {

        // get the connection from connection pool
        Connection conn = this.getConnection();
        String xml;
        String sql = Queries.getQuery("institution_names");

        try (PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setString(1, searchTerm + "%");
            try (ResultSet rs = pst.executeQuery()) {
                xml = util.convertResultSetToXML(rs);
            }
        } finally {
            // return the connection back to the pool
            this.CloseConnection(conn);
        }
        return xml;

    }

    public String searchSubscriber() throws SQLException, ParseException,
            ParserConfigurationException, TransformerException, IOException, SAXException {

        // get the connection from connection pool
        Connection conn = this.getConnection();

        String xml;
        String sql = Queries.getQuery("search_subscriber");
        String subscriberNumber = request.getParameter("subscriberNumber");
        String subscriberName = request.getParameter("subscriberName");
        String email = request.getParameter("email");
        String city = request.getParameter("city");
        String pincode = request.getParameter("pincode");
        //String country = request.getParameter("country");
        //String state = request.getParameter("state");
        String institution = request.getParameter("institution");
        String department = request.getParameter("department");
        String condition = " where";
        int pageNumber = Integer.parseInt(request.getParameter("page"));
        int pageSize = Integer.parseInt(request.getParameter("rows"));
        //String orderBy = request.getParameter("sidx");
        //String sortOrder = request.getParameter("sord");
        int totalQueryCount;
        //double totalPages = 0;

        if (subscriberNumber != null && subscriberNumber.length() > 0) {
            sql += condition + " subscriberNumber=" + "'" + subscriberNumber + "'";
            condition = " and";
        }

        if (subscriberName != null && subscriberName.length() > 0) {
            sql += condition + " subscriberName like " + "'%" + subscriberName + "%'";
            condition = " and";
        }

        if (city != null && city.compareToIgnoreCase("Select") != 0 && city.length() > 0) {
            sql += condition + " t2.city = " + "\"" + city + "\"";
            condition = " and";

        }

        if (email != null && email.length() > 0) {
            sql += condition + " email =" + "'" + email + "'";
            condition = " and";
        }

        if (institution != null && institution.length() > 0) {
            sql += condition + " institution like" + "'%" + institution + "%'";
            condition = " and";
        }

        if (department != null && department.length() > 0) {
            sql += condition + " department like" + "'%" + department + "%'";
            condition = " and";
        }

        if (pincode != null && pincode.compareToIgnoreCase("NULL") != 0 && pincode.length() > 0) {
            sql += condition + " pincode =" + "'" + pincode + "'";
        }
        ResultSet rs_count;

        int start = (pageNumber - 1) * pageSize;
        sql += " LIMIT " + start + "," + pageSize;
        PreparedStatement pstatement = Database.getConnection().prepareStatement(sql);
        try (ResultSet rs = pstatement.executeQuery();) {
            sql = "select count(*) from (" + sql + ") as tbl";
            rs_count = this.db.executeQuery(sql);
            rs_count.first();
            totalQueryCount = rs_count.getInt(1);
            rs_count.close();
            xml = util.convertResultSetToXML(rs, pageNumber, pageSize, totalQueryCount);
        } catch (SQLException e) {
            logger.error(e.getMessage(), e);
            throw e;
        } finally {
            // return the connection back to the pool
            this.CloseConnection(conn);
        }
        return xml;
    }

    public int getSubscriberType(String SubscriberNumber) throws SQLException {

        // get the connection from connection pool
        Connection conn = this.getConnection();

        String sql = Queries.getQuery("get_subscriber_type");
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, SubscriberNumber);
        int subscriberType;
        try (ResultSet rs = ps.executeQuery()) {
            rs.first();
            subscriberType = rs.getInt(1);
            rs.close();
        } finally {
            // return the connection back to the pool
            this.CloseConnection(conn);
        }
        return subscriberType;
    }

    public String subscriberInvoices() throws SQLException, ParseException, ParserConfigurationException, TransformerException, SAXException, IOException {

        // get the connection from connection pool
        Connection conn = this.getConnection();

        String xml;
        String sql = Queries.getQuery("search_subscriber_invoice");
        String ajax_sql = sql + " LIMIT ?, ?";

        String subscriberNumber = request.getParameter("subscriberNumber");
        int pageNumber = Integer.parseInt(request.getParameter("page"));
        int pageSize = Integer.parseInt(request.getParameter("rows"));
        //String orderBy = request.getParameter("sidx");
        //String sortOrder = request.getParameter("sord");
        int totalQueryCount;
        try (PreparedStatement pst = conn.prepareStatement(ajax_sql);) {
            pst.setString(1, subscriberNumber);
            pst.setInt(2, (pageSize * (pageNumber - 1)));
            pst.setInt(3, pageSize);

            try (ResultSet rs = pst.executeQuery();) {
                sql = "select count(*) from (" + sql + ") as tbl";
                PreparedStatement pst2 = conn.prepareStatement(sql);
                pst2.setString(1, subscriberNumber);
                ResultSet rs_count = pst2.executeQuery();
                rs_count.first();
                totalQueryCount = rs_count.getInt(1);
                xml = util.convertResultSetToXML(rs, pageNumber, pageSize, totalQueryCount);
            }
        } finally {
            // return the connection back to the pool
            this.CloseConnection(conn);
        }
        return xml;
    }

    public InvoiceFormBean getInvoiceDetail() throws SQLException, ParseException, ParserConfigurationException, TransformerException, ClassNotFoundException {

        // get the connection from connection pool
        Connection conn = this.getConnection();

        String sql;
        InvoiceFormBean invoiceFormBean = new IAS.Bean.Invoice.InvoiceFormBean();
        sql = Queries.getQuery("get_invoice_detail_usng_invno");
        PreparedStatement st = conn.prepareStatement(sql);
        st.setString(1, request.getParameter("invoiceNo"));

        try (ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                BeanProcessor bProc = new BeanProcessor();
                Class type = Class.forName("IAS.Bean.Invoice.InvoiceFormBean");
                invoiceFormBean = (IAS.Bean.Invoice.InvoiceFormBean) bProc.toBean(rs, type);
            }
        } finally {
            // return the connection back to the pool
            this.CloseConnection(conn);
        }
        request.setAttribute("invoiceFormBean", invoiceFormBean);
        return invoiceFormBean;
    }

    public String getReminders(String subscriberNumber) throws SQLException, 
            ParserConfigurationException,TransformerException {

        // get the connection from connection pool
        Connection conn = this.getConnection();

        String sql = Queries.getQuery("get_subscriber_reminders");
        try (PreparedStatement st = conn.prepareStatement(sql);) {
            st.setString(1, subscriberNumber);
            try (ResultSet rs = st.executeQuery();) {
                return util.convertResultSetToXML(rs);
            }
        }finally {
            // return the connection back to the pool
            this.CloseConnection(conn);
        }

    }

    public String getMissingIssues(int subscriberID) throws SQLException,
            ParserConfigurationException,TransformerException {

        // get the connection from connection pool
        Connection conn = this.getConnection();
        ResultSet _rs;

        String sql = Queries.getQuery("get_missing_issues_for_subscriber");

        try (PreparedStatement st = conn.prepareStatement(sql)) {
            st.setInt(1, subscriberID);
            try(ResultSet rs = st.executeQuery();){
               return util.convertResultSetToXML(rs); 
            }
        }finally {
            // return the connection back to the pool
            this.CloseConnection(conn);
        }
        
    }
}
