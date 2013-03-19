package IAS.Model.Subscriber;

import IAS.Bean.Invoice.InvoiceFormBean;
import IAS.Bean.Inward.inwardFormBean;
import IAS.Bean.Subscriber.subscriberFormBean;
import IAS.Class.JDSConstants;
import IAS.Class.JDSLogger;
import IAS.Class.Queries;
import IAS.Class.util;
import IAS.Model.JDSModel;
import com.mysql.jdbc.Statement;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
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
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.ResultSetHandler;
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
        //this.connection = super.getConnection();
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
        //String sql;
        String mode = "Create";

        // get the connection from connection pool
        Connection _conn = this.getConnection();

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, subscriberFormBean);
        this._subscriberFormBean = subscriberFormBean;

        if (_subscriberFormBean.isSameInvoiceAddress()) {
            String strInvoiceAddress = getInvoiceAddress(_subscriberFormBean);
            _subscriberFormBean.setInvoiceAddress(strInvoiceAddress);
        }
        /*
         * check that the subscriber number is not present on the screen, if
         * present means its and edit subscriber else create new subscriber.
         */
        if (!subscriberFormBean.getSubscriberNumber().isEmpty()) {
            return this._updateSubscriber();
        } else {
            int _subscriberId = this.SaveNewSubscriber(_subscriberFormBean);
            String agentName = _inwardFormBean.getAgentName();
            /*
             ************************************************************
             *
             * PROCESS AGENT INWARD - // subscriber ID should not be added
             *  in Inward if agent is there in inward
             *
             ************************************************************
             */
            //If the mode was create new user update the inward with the new subscriber that was created
            if (mode.equalsIgnoreCase("Create") && (agentName == null || agentName.isEmpty())) {
                if (this.inwardNumber != null) {
                    String _sql = Queries.getQuery("update_subscriber_in_inward");
                    try (PreparedStatement pst = _conn.prepareStatement(_sql)) {
                        pst.setInt(1, _subscriberId);
                        pst.setString(2, this.inwardNumber);
                        pst.executeUpdate();
                    } catch (SQLException e) {
                        logger.error(e.getMessage(), e);
                        throw e;
                    }
                }
            }

            // return the connection back to the pool
            //_conn.close();

            return _subscriberId;

        }
    }

    public int SaveNewSubscriber(subscriberFormBean _subscriberFormBean) throws IllegalAccessException, SQLException, ParseException, InvocationTargetException {

        Connection conn = this.getConnection();
        int _subscriberId = 0;

        //get the next subscriber number
        _subscriberFormBean.setSubscriberNumber(getNextSubscriberNumber());
        this._subscriberFormBean = _subscriberFormBean;
        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("subscriber_insert");
        try (PreparedStatement st = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);) {
            // fill in the statement params
            this._setSubscriberStatementParams(st, "create");
            int rowsAffected = st.executeUpdate();

            if (rowsAffected == 1) {
                try (ResultSet rs = st.getGeneratedKeys()) {
                    rs.first();
                    _subscriberId = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            logger.error(e);
            throw e;
        } finally {

            // return the connection to the pool
            //conn.close();
            return _subscriberId;
        }
    }

    public String fetchNextSubscriberNumberById(int subscriberId) throws SQLException, ParseException, ClassNotFoundException {
        String nextSubscriberNum = "";
        Connection _conn = (Connection) request.getSession(false).getAttribute("connection");
        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("get_next_subscriber_number");
        try (PreparedStatement st = _conn.prepareStatement(sql)) {
            st.setInt(1, subscriberId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.first()) {
                    nextSubscriberNum = rs.getString(1);
                }
            } catch (SQLException e) {
                logger.error(e.getMessage(), e);
                throw e;
            }
        } catch (SQLException e) {
            logger.error(e.getMessage(), e);
            throw e;
        }
        return nextSubscriberNum;
    }

    public String fetchFirstSubscriberNumber() throws SQLException, ParseException, ClassNotFoundException {
        String firstSubscriberNum = "";
        Connection _conn = (Connection) request.getSession(false).getAttribute("connection");
        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("get_first_subscriber_number");
        try (PreparedStatement st = _conn.prepareStatement(sql)) {
            try (ResultSet rs = st.executeQuery()) {
                if (rs.first()) {
                    firstSubscriberNum = rs.getString(1);
                }
            } catch (SQLException e) {
                logger.error(e.getMessage(), e);
                throw e;
            }
        } catch (SQLException e) {
            logger.error(e.getMessage(), e);
            throw e;
        }
        return firstSubscriberNum;
    }

    public String getNextSubscriber(int subscriberId) throws SQLException, ParseException, ClassNotFoundException {
        String subscriberNo;
        subscriberFormBean subscriberFormBean = new IAS.Bean.Subscriber.subscriberFormBean();

        subscriberNo = this.fetchNextSubscriberNumberById(subscriberId);
        if (subscriberNo.isEmpty()) {
            subscriberNo = this.fetchFirstSubscriberNumber();
        }
        // get the connection from connection pool
        Connection _conn = this.getConnection();

        String sql = Queries.getQuery("get_subscriber_by_number");
        try (PreparedStatement st = _conn.prepareStatement(sql)) {
            st.setString(1, subscriberNo);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    BeanProcessor bProc = new BeanProcessor();
                    subscriberFormBean = (IAS.Bean.Subscriber.subscriberFormBean) bProc.toBean(rs, IAS.Bean.Subscriber.subscriberFormBean.class);
                }
            } catch (SQLException e) {
                logger.error(e.getMessage(), e);
                throw e;
            }
        } catch (SQLException e) {
            logger.error(e.getMessage(), e);
            throw e;
        }
        request.setAttribute("subscriberFormBean", subscriberFormBean);
        return subscriberFormBean.getSubscriberNumber();
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
            //this.CloseConnection(conn);
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
            //this.CloseConnection(conn);
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
                    subscriberFormBean = bProc.toBean(rs, IAS.Bean.Subscriber.subscriberFormBean.class);
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
            //this.CloseConnection(conn);
        }
        request.setAttribute("subscriberFormBean", subscriberFormBean);
        return subscriberFormBean.getSubscriberNumber();
    }

    public subscriberFormBean GetSubscriber(String subscriber_number) throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        // get the connection from connection pool
        Connection _conn = this.getConnection();

        String sql;
        subscriberFormBean _subscriberFormBean2 = null;

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        sql = Queries.getQuery("get_subscriber_by_number");
        try (PreparedStatement st = _conn.prepareStatement(sql)) {
            st.setString(1, subscriber_number);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    BeanProcessor bProc = new BeanProcessor();
                    _subscriberFormBean2 = bProc.toBean(rs, IAS.Bean.Subscriber.subscriberFormBean.class);
                }
            } catch (SQLException e) {
                logger.error(e.getMessage(), e);
                throw e;
            }
        } catch (SQLException e) {
            logger.error(e.getMessage(), e);
            throw e;
        } finally {
            // _conn.close();
        }
        return _subscriberFormBean2;
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
        st.setString(++paramIndex, _subscriberFormBean.getPhone());
        st.setString(++paramIndex, _subscriberFormBean.getFax());
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
            //this.CloseConnection(conn);
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
            //this.CloseConnection(conn);
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
        String exactMatchCondition;
        String searchRegex;
        int pageNumber;
        int pageSize;
        boolean matchExact;
        try {
            pageNumber = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException ex) {
            pageNumber = 1;
        }
        try {
            pageSize = Integer.parseInt(request.getParameter("rows"));
        } catch (NumberFormatException ex) {
            pageSize = 10;
        }
        try {
            matchExact = Boolean.parseBoolean(request.getParameter("exact"));
        } catch (NumberFormatException ex) {
            matchExact = false;
        }

        if (matchExact) {
            exactMatchCondition = "=";
            searchRegex = "";
        } else {
            exactMatchCondition = "LIKE";
            searchRegex = "%";
        }
        //String orderBy = request.getParameter("sidx");
        //String sortOrder = request.getParameter("sord");
        int totalQueryCount;
        //double totalPages = 0;

        if (subscriberNumber != null && subscriberNumber.length() > 0) {
            if (matchExact) {
                sql += condition + " subscriberNumber " + exactMatchCondition + "'" + subscriberNumber + "'";
            } else {
                sql += condition + " subscriberNumber " + exactMatchCondition + " " + "'%" + subscriberNumber + "%'";
            }
            condition = " and";
        }

        if (subscriberName != null && subscriberName.length() > 0) {
            sql += condition + " subscriberName like " + "'%" + subscriberName + "%'";
            condition = " and";
        }

        if (city != null && city.compareToIgnoreCase("Select") != 0 && city.length() > 0) {
            sql += condition + " t2.city like " + "'%" + city + "%'";
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

        // close the connection
        //this.CloseConnection(conn);

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
            conn.close();
            // return the connection back to the pool
            //this.CloseConnection(conn);
        }
        return subscriberType;
    }

    public String subscriberInvoices() throws SQLException, ParseException, ParserConfigurationException, TransformerException, SAXException, IOException {

        // get the connection from connection pool
        Connection _conn = this.getConnection();

        String xml;
        String sql = Queries.getQuery("search_subscriber_invoice");
        String ajax_sql = sql + " LIMIT ?, ?";

        String subscriberNumber = request.getParameter("subscriberNumber");
        int pageNumber = Integer.parseInt(request.getParameter("page"));
        int pageSize = Integer.parseInt(request.getParameter("rows"));
        //String orderBy = request.getParameter("sidx");
        //String sortOrder = request.getParameter("sord");
        int totalQueryCount;
        try (PreparedStatement pst = _conn.prepareStatement(ajax_sql);) {
            pst.setString(1, subscriberNumber);
            pst.setInt(2, (pageSize * (pageNumber - 1)));
            pst.setInt(3, pageSize);

            try (ResultSet rs = pst.executeQuery();) {
                sql = "select count(*) from (" + sql + ") as tbl";
                PreparedStatement pst2 = _conn.prepareStatement(sql);
                pst2.setString(1, subscriberNumber);
                ResultSet rs_count = pst2.executeQuery();
                rs_count.first();
                totalQueryCount = rs_count.getInt(1);
                xml = util.convertResultSetToXML(rs, pageNumber, pageSize, totalQueryCount);
            }
        } finally {
            //_conn.close();
        }
        return xml;
    }

    public InvoiceFormBean getInvoiceDetail() throws SQLException, ParseException, ParserConfigurationException, TransformerException, ClassNotFoundException {

        // get the connection from connection pool
        Connection _conn = this.getConnection();

        String sql;
        InvoiceFormBean invoiceFormBean = new IAS.Bean.Invoice.InvoiceFormBean();
        sql = Queries.getQuery("get_invoice_detail_usng_invno");
        PreparedStatement st = _conn.prepareStatement(sql);
        st.setString(1, request.getParameter("invoiceNo"));

        try (ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                BeanProcessor bProc = new BeanProcessor();
                invoiceFormBean = bProc.toBean(rs, IAS.Bean.Invoice.InvoiceFormBean.class);
            }
        } finally {
            // return the connection back to the pool
            //_conn.close();
        }
        request.setAttribute("invoiceFormBean", invoiceFormBean);
        return invoiceFormBean;
    }

    public String getReminders(String subscriberNumber) throws SQLException,
            ParserConfigurationException, TransformerException {

        // get the connection from connection pool
        Connection conn = this.getConnection();

        String sql = Queries.getQuery("get_subscriber_reminders");
        try (PreparedStatement st = conn.prepareStatement(sql);) {
            st.setString(1, subscriberNumber);
            try (ResultSet rs = st.executeQuery();) {
                return util.convertResultSetToXML(rs);
            }
        } finally {
            // return the connection back to the pool
            //this.CloseConnection(conn);
        }

    }

    public String getMissingIssues(int subscriberID) throws SQLException,
            ParserConfigurationException, TransformerException {

        // get the connection from connection pool
        Connection conn = this.getConnection();

        String sql = Queries.getQuery("get_missing_issues_for_subscriber");

        try (PreparedStatement st = conn.prepareStatement(sql)) {
            st.setInt(1, subscriberID);
            try (ResultSet rs = st.executeQuery();) {
                return util.convertResultSetToXML(rs);
            }
        } finally {
            // return the connection back to the pool
            //this.CloseConnection(conn);
        }

    }

    public boolean isSubscriberTypeFree(int subTypeID) throws SQLException {

        Connection _conn = this.getConnection();
        String sql = Queries.getQuery("is_free_subscriber");
        int isFree = 0;
        try (PreparedStatement st = _conn.prepareStatement(sql)) {
            st.setInt(1, subTypeID);
            try (ResultSet rs = st.executeQuery();) {
                if (rs.first()) {
                    isFree = rs.getInt(1);
                }
            }
        } finally {
            //_conn.close();
        }
        return isFree == 1 ? true : false;
    }

    public boolean isSubscriberFree(int subID) throws SQLException {

        Connection _conn = this.getConnection();
        String sql = Queries.getQuery("get_subscriber_type_for_id");
        int subtypeID = 0;
        try (PreparedStatement st = _conn.prepareStatement(sql)) {
            st.setInt(1, subID);
            try (ResultSet rs = st.executeQuery();) {
                if (rs.first()) {
                    subtypeID = rs.getInt(1);
                }
            }
        } finally {
            //_conn.close();
        }
        return this.isSubscriberTypeFree(subtypeID);
    }

    public String getChequeReturn(String subscriberNumber) throws SQLException {

        Connection _conn = this.getConnection();
        QueryRunner run = new QueryRunner();
        String xml = null;

        ResultSetHandler<String> h = new ResultSetHandler<String>() {
            @Override
            public String handle(ResultSet rs) throws SQLException {
                String xml = null;
                try {
                    xml = util.convertResultSetToXML(rs);
                } catch (ParserConfigurationException | TransformerException ex) {
                } finally {
                    return xml;
                }

            }
        };

        try {
            xml = run.query(_conn, Queries.getQuery("get_chq_return_for_subscriber"), h, subscriberNumber);
        } catch (Exception ex) {
            logger.error(ex);
        } finally {
            // _conn.close();
        }
        return xml;
    }

    public String getInvoiceAddress(subscriberFormBean subscriberFormBean) {
        String strCRLF = "\n";
        String strInvoiceAddress = subscriberFormBean.getInvoiceAddress();

        strInvoiceAddress += subscriberFormBean.getDepartment().length() > 0 ? strCRLF.concat(subscriberFormBean.getDepartment()) : " ";
        strInvoiceAddress += subscriberFormBean.getInstitution().length() > 0 ? strCRLF.concat(subscriberFormBean.getInstitution()) : " ";
        strInvoiceAddress += subscriberFormBean.getCity().length() > 0 ? strCRLF.concat(subscriberFormBean.getCity()) : " ";
        strInvoiceAddress += subscriberFormBean.getDistrict().length() > 0 ? strCRLF.concat(subscriberFormBean.getDistrict()) : " ";
        strInvoiceAddress += subscriberFormBean.getState().length() > 0 ? strCRLF.concat(subscriberFormBean.getState()) : " ";

        if (!subscriberFormBean.getCountry().isEmpty()) {
            if (subscriberFormBean.getCountry().equalsIgnoreCase("INDIA")) { // Do not add INDIA in the address
                if (!subscriberFormBean.getPincodeAsText().isEmpty()) {
                    strInvoiceAddress = strInvoiceAddress.concat(strCRLF)
                            .concat(subscriberFormBean.getPincodeAsText());
                }
            } else {
                strInvoiceAddress = strInvoiceAddress.concat(strCRLF)
                        .concat(subscriberFormBean.getCountry())
                        .concat(strCRLF)
                        .concat(subscriberFormBean.getPincodeAsText());
            }
        }
        return strInvoiceAddress;
    }
}
