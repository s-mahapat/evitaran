/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model;

import javax.servlet.http.HttpServletRequest;
import IAS.Bean.inwardFormBean;
import java.sql.*;
import IAS.Class.Queries;
import IAS.Class.Database;
import javax.servlet.http.HttpSession;
import IAS.Class.util;
import java.text.ParseException;
import java.util.Calendar;
import org.apache.commons.dbutils.BeanProcessor;

/**
 *
 * @author Shailendra Mahapatra
 */
public class inwardModel extends JDSModel {

    private HttpServletRequest request = null;
    private inwardFormBean _inwardFormBean = null;
    private Connection conn = null;
    private Database db = null;
    private HttpSession session = null;

    public inwardModel(HttpServletRequest request) throws SQLException {
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

        inwardFormBean inwardFormBean = new IAS.Bean.inwardFormBean();
        request.setAttribute("inwardFormBean", inwardFormBean);
        String sql;

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, inwardFormBean);
        this._inwardFormBean = inwardFormBean;

        /* check that the inward number is not present on the screen,
         * if present means its and edit inward else create new inward.
         */
        if (inwardFormBean.getInwardNumber().isEmpty() == false) {
            return this._updateInward();
        } else {

            //get the next inward number
            inwardFormBean.setInwardNumber(getNextInwardNumber());

            // the query name from the jds_sql properties files in WEB-INF/properties folder
            sql = Queries.getQuery("inward_insert");

            PreparedStatement st = conn.prepareStatement(sql);

            // fill in the statement params
            this._setNewInwardStatementParams(st);

            return db.executeUpdatePreparedStatement(st);
        }

    }

    public String editInward() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException{

        return GetInward();

    }

    private int _updateInward() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException{

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("update_inward");

        PreparedStatement st = conn.prepareStatement(sql);

        // fill in the statement params
        this._setUpdateInwardStatementParams(st);

        return db.executeUpdatePreparedStatement(st);

    }

    public String GetInward() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        String sql;
        inwardFormBean inwardFormBean = new IAS.Bean.inwardFormBean();

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, inwardFormBean);

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        sql = Queries.getQuery("get_inward_by_number");

        PreparedStatement st = conn.prepareStatement(sql);

        st.setString(1, inwardFormBean.getInwardNumber());

        ResultSet rs = db.executeQueryPreparedStatement(st);

        // populate the bean from the resultset using the beanprocessor class
        while (rs.next()) {
            BeanProcessor bProc = new BeanProcessor();
            Class type = Class.forName("IAS.Bean.inwardFormBean");
            inwardFormBean = (IAS.Bean.inwardFormBean) bProc.toBean(rs, type);

        }
        rs.close();

        request.setAttribute("inwardFormBean", inwardFormBean);
        return inwardFormBean.getInwardNumber();
    }

    private void _setNewInwardStatementParams(PreparedStatement st) throws SQLException, ParseException {
        int paramIndex = 0;
        st.setString(++paramIndex, _inwardFormBean.getInwardNumber());
        st.setString(++paramIndex, _inwardFormBean.getFrom());
        st.setString(++paramIndex, _inwardFormBean.getCountry());
        st.setString(++paramIndex, _inwardFormBean.getState());
        st.setString(++paramIndex, _inwardFormBean.getCity());
        st.setInt(++paramIndex, _inwardFormBean.getPincode());
        st.setString(++paramIndex, _inwardFormBean.getEmail());
        st.setString(++paramIndex, _inwardFormBean.getInstitution());
        st.setString(++paramIndex, _inwardFormBean.getDepartment());
        st.setDate(++paramIndex, util.dateStringToSqlDate(_inwardFormBean.getInwardCreationDate()));
        st.setInt(++paramIndex, _inwardFormBean.getSubscriberId());
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
    }

    private void _setUpdateInwardStatementParams(PreparedStatement st) throws SQLException, ParseException {
        int paramIndex = 0;
        st.setString(++paramIndex, _inwardFormBean.getFrom());
        st.setString(++paramIndex, _inwardFormBean.getCountry());
        st.setString(++paramIndex, _inwardFormBean.getState());
        st.setString(++paramIndex, _inwardFormBean.getCity());
        st.setInt(++paramIndex, _inwardFormBean.getPincode());
        st.setString(++paramIndex, _inwardFormBean.getEmail());
        st.setString(++paramIndex, _inwardFormBean.getInstitution());
        st.setString(++paramIndex, _inwardFormBean.getDepartment());
        //st.setDate(++paramIndex, util.dateStringToSqlDate(_inwardFormBean.getInwardCreationDate()));
        st.setInt(++paramIndex, _inwardFormBean.getSubscriberId());
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
        st.setString(++paramIndex, _inwardFormBean.getInwardNumber());
    }

    /*
     * This method is a synchronized method so that no two get the same inward number
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

    private String getMonthToCharacterMap(int _month) {

        char[] alphabet = "abcdefghijkl".toCharArray();

        // the calendar objects month starts from 0
        String monthChar = Character.toString(alphabet[_month]);
        return monthChar.toUpperCase();

    }
}
