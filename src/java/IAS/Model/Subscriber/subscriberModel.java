package IAS.Model.Subscriber;

import IAS.Bean.Inward.inwardFormBean;
import IAS.Bean.Subscriber.subscriberFormBean;
import IAS.Class.Queries;
import IAS.Class.util;
import IAS.Model.JDSModel;
import com.mysql.jdbc.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Calendar;
import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import org.apache.commons.dbutils.BeanProcessor;

public class subscriberModel extends JDSModel {

    private subscriberFormBean _subscriberFormBean = null;

    public subscriberModel(HttpServletRequest request) throws SQLException {
        //call the base class constructor
        super(request);
    }

    public int Save() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException {

        subscriberFormBean subscriberFormBean = new IAS.Bean.Subscriber.subscriberFormBean();
        request.setAttribute("subscriberFormBean", subscriberFormBean);
        String sql;
        String mode = "Create";

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, subscriberFormBean);
        this._subscriberFormBean = subscriberFormBean;

        /*
         * check that the subscriber number is not present on the screen, if
         * present means its and edit subscriber else create new subscriber.
         */
        if (subscriberFormBean.getSubscriberNumber().isEmpty() == false) {
            return this._updateSubscriber();
        } else {
            //get the next subscriber number
            subscriberFormBean.setSubscriberNumber(getNextSubscriberNumber());
            // the query name from the jds_sql properties files in WEB-INF/properties folder
            sql = Queries.getQuery("subscriber_insert");
            PreparedStatement st = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            // fill in the statement params
            this._setSubscriberStatementParams(st, mode);
            int rowsAffected = db.executeUpdatePreparedStatement(st);

            //If the mode was create new user update the inward with the new subscriber that was created
            if (mode.equalsIgnoreCase("Create")) {
                ResultSet rs = st.getGeneratedKeys();
                rs.first();
                inwardFormBean _inwardFormBean = (inwardFormBean)this.session.getAttribute("inwardUnderProcess");
                String inwardUnderProcess = _inwardFormBean.getInwardNumber();
                int _subscriberId = rs.getInt(1);

                if (inwardUnderProcess != null) {
                    String _sql = Queries.getQuery("update_subscriber_in_inward");
                    PreparedStatement pst = conn.prepareStatement(_sql);
                    pst.setInt(1, _subscriberId);
                    pst.setString(2, inwardUnderProcess);
                    db.executeUpdatePreparedStatement(pst);
                }
            }
            return rowsAffected;

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
        subscriberFormBean subscriberFormBean = new IAS.Bean.Subscriber.subscriberFormBean();

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
            Class type = Class.forName("IAS.Bean.Subscriber.subscriberFormBean");
            subscriberFormBean = (IAS.Bean.Subscriber.subscriberFormBean) bProc.toBean(rs, type);
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
        st.setString(++paramIndex, _subscriberFormBean.getAgent());
        st.setBoolean(++paramIndex, _subscriberFormBean.isDeactive());
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
        String condition = " where";

        if (subscriberNumber != null && subscriberNumber.length() > 0) {
            sql += condition + " subscriberNumber=" + "'" + subscriberNumber + "'";
            condition = " and";
        }

        if (subscriberName != null && subscriberName.length() > 0) {
            sql += condition + " subscriberName like " + "'%" + subscriberName + "%'";
            condition = " and";
        }

        if (city != null && city.compareToIgnoreCase("NULL") != 0 && city.length() > 0) {
            sql += condition + " t2.id=t1.city and t2.city = " + "\"" + city + "\"";
            condition = " and";

        }

        if (email != null && email.length() > 0) {
            sql += condition + " email =" + "'" + email + "'";
            condition = " and";
        }

        if (pincode != null && pincode.compareToIgnoreCase("NULL") != 0 && pincode.length() > 0) {
            sql += condition + " pincode =" + "'" + pincode + "'";
        }

        sql += " group by subscriberNumber, subscriberName, city, email, pincode";

        ResultSet rs = this.db.executeQuery(sql);

        xml = util.convertResultSetToXML(rs);

        return xml;
    }

    public int getSubscriberType(String SubscriberNumber) throws SQLException{
        String sql = Queries.getQuery("get_subscriber_type");
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, SubscriberNumber);
        int subscriberType;
        try (ResultSet rs = this.db.executeQueryPreparedStatement(ps)) {
            rs.first();
            subscriberType = rs.getInt(1);
            rs.close();
        }
        return subscriberType;
    }
}
