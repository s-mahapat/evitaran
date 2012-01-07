package IAS.Model;

import javax.servlet.http.HttpServletRequest;
import IAS.Bean.subscriberFormBean;
import java.sql.*;
import IAS.Class.Queries;
import IAS.Class.Database;
import javax.servlet.http.HttpSession;
import IAS.Class.util;
import java.text.ParseException;
import java.util.Calendar;
import org.apache.commons.dbutils.BeanProcessor;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;

public class subscriberModel extends JDSModel {

    private HttpServletRequest request = null;
    private subscriberFormBean _subscriberFormBean = null;
    private Connection conn = null;
    private Database db = null;
    private HttpSession session = null;

    public subscriberModel(HttpServletRequest request) throws SQLException {
        this.request = request;
        this.session = request.getSession(false);
        if (this.session == null) {
            throw (new SQLException("Database connection not found in the session"));
        }
        this.db = (Database) session.getAttribute("db_connection");
        this.conn = db.getConnection();
    }

    public int Save() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException {

        subscriberFormBean subscriberFormBean = new IAS.Bean.subscriberFormBean();
        request.setAttribute("subscriberFormBean", subscriberFormBean);
        String sql;
        String mode = "Create";

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, subscriberFormBean);
        this._subscriberFormBean = subscriberFormBean;

        /* check that the subscriber number is not present on the screen,
         * if present means its and edit subscriber else create new subscriber.
         */
        if (subscriberFormBean.getSubscriberNumber().isEmpty() == false) {
            return this._updateSubscriber();
        } else {
            //get the next subscriber number
            subscriberFormBean.setSubscriberNumber(getNextSubscriberNumber());
            // the query name from the jds_sql properties files in WEB-INF/properties folder
            sql = Queries.getQuery("subscriber_insert");
            PreparedStatement st = conn.prepareStatement(sql);
            // fill in the statement params
            this._setSubscriberStatementParams(st, mode);
            return db.executeUpdatePreparedStatement(st);
        }
    }

    private synchronized String getNextSubscriberNumber() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException {

        String nextSubscriber = null;
        // Identify the subscriber type i.e.Free or Paid
        String subtype = "S";
        //get the last subscriber number from subscriber table
        String lastSubscriberSql = Queries.getQuery("get_last_subscriber");
        ResultSet rs = db.executeQuery(lastSubscriberSql);
        Calendar calendar = Calendar.getInstance();
        String lastSubscriber = null;
        int lastSubscriberYear = 0;
        while (rs.next()) {
            lastSubscriber = rs.getString(1);
            java.sql.Date dt = rs.getDate(2);
            Calendar inCal = Calendar.getInstance();
            inCal.setTime(dt);
            lastSubscriberYear = inCal.get(Calendar.YEAR);
        }

        //if true there exists a previous subscriber for the year, so just increment the subscriber number.
        if (lastSubscriberYear == calendar.get(Calendar.YEAR)) {
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
        return nextSubscriber;
    }

    private String getMonthToCharacterMap(int _month) {
        char[] alphabet = "abcdefghijkl".toCharArray();
        // the calendar objects month starts from 0
        String monthChar = Character.toString(alphabet[_month]);
        return monthChar.toUpperCase();
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
        PreparedStatement st = conn.prepareStatement(sql);
        // fill in the statement params
        this._setSubscriberStatementParams(st, mode);
        return db.executeUpdatePreparedStatement(st);
    }

    public String GetSubscriber() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        String sql;
        subscriberFormBean subscriberFormBean = new IAS.Bean.subscriberFormBean();

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, subscriberFormBean);
        // the query name from the jds_sql properties files in WEB-INF/properties folder
        sql = Queries.getQuery("get_subscriber_by_number");
        PreparedStatement st = conn.prepareStatement(sql);
        st.setString(1, subscriberFormBean.getSubscriberNumber());
        ResultSet rs = db.executeQueryPreparedStatement(st);
        // populate the bean from the resultset using the beanprocessor class
        while (rs.next()) {
            BeanProcessor bProc = new BeanProcessor();
            Class type = Class.forName("IAS.Bean.subscriberFormBean");
            subscriberFormBean = (IAS.Bean.subscriberFormBean) bProc.toBean(rs, type);
        }
        rs.close();
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
        st.setString(++paramIndex, _subscriberFormBean.getSubscriberAddress());
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
        if (mode.equalsIgnoreCase("Update")) {
            st.setString(++paramIndex, _subscriberFormBean.getSubscriberNumber());
        }
    }

    public String searchSubscriber() throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml = null;
        String sql = Queries.getQuery("search_subscriber");
        String subscriberNumber = request.getParameter("subscriberNumber");
        String subscriberName = request.getParameter("subscriberName");
        String email = request.getParameter("email");
        String city = request.getParameter("city");
        String pincode = request.getParameter("pincode");

        if (subscriberNumber != null && subscriberNumber.length() > 0) {
            sql += " and subscriberNumber=" + "'" + subscriberNumber + "'";
        }

        if (subscriberName != null && subscriberName.length() > 0) {
            sql += " and subscriberName like " + "'%" + subscriberName + "%'";
        }

        if (city.compareToIgnoreCase("NULL") != 0 && city != null && city.length() > 0) {
            sql += " and t2.id=t1.city and t2.city = " + "\"" + city + "\"";
        }

        if (email != null && email.length() > 0) {
            sql += " and email =" + "'" + email + "'";
        }

        if (pincode.compareToIgnoreCase("NULL") != 0 && pincode != null && pincode.length() > 0) {
            sql += " and pincode =" + "'" + pincode + "'";
        }

        sql += " group by subscriberNumber, subscriberName, city, email, pincode";

        ResultSet rs = this.db.executeQuery(sql);

        xml = util.convertResultSetToXML(rs);

        return xml;
    }
}
