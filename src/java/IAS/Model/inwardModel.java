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
import java.text.*;
import java.text.ParseException;
import java.util.Calendar;


/**
 *
 * @author Shailendra Mahapatra
 */
public class inwardModel extends JDSModel{

    private HttpServletRequest request = null;
    private inwardFormBean _inwardFormBean = null;
    private Connection conn = null;
    private Database db = null;
    private HttpSession session = null;

    public inwardModel(HttpServletRequest request, inwardFormBean _Bean) throws SQLException{
        this.request = request;
        this._inwardFormBean = _Bean;
        this.session = request.getSession(false);
        if(this.session == null){
            throw(new SQLException("Database connection not found in the session"));
        }

        this.db = (Database)session.getAttribute("db_connection");
        this.conn = db.getConnection();

    }

    public int Save (HttpServletRequest request, inwardFormBean _Bean) throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException{

        String sql;

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request,_Bean);
        request.setAttribute("inwardFormBean", _Bean);


        _inwardFormBean.setInwardNumber(getNextInwardNumber());

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        sql = Queries.getQuery("inward_insert");

        PreparedStatement st = conn.prepareStatement(sql);
        int paramIndex = 1;
        st.setString(paramIndex, _inwardFormBean.getInwardNumber());
        st.setString(++paramIndex, _inwardFormBean.getFrom());
        st.setString(++paramIndex, _inwardFormBean.getCountry());
        st.setString(++paramIndex, _inwardFormBean.getState());
        st.setString(++paramIndex,_inwardFormBean.getCity());
        st.setInt(++paramIndex,_inwardFormBean.getPincode());
        st.setString(++paramIndex,_inwardFormBean.getEmail());
        st.setString(++paramIndex,_inwardFormBean.getInstitution());
        st.setString(++paramIndex, _inwardFormBean.getDepartment());
        //st.setTimestamp(10, Calendar.getInstance().);
        //st.setDate(10, util.dateStringToSqlDate(_inwardFormBean.getInwardCreationDate()));
        st.setInt(++paramIndex, _inwardFormBean.getSubscriberId());
        st.setString(++paramIndex,_inwardFormBean.getInwardPurpose());
        st.setString(++paramIndex, _inwardFormBean.getPaymentMode());
        st.setInt(++paramIndex, _inwardFormBean.getChqddNumber());
        st.setDate(++paramIndex, util.dateStringToSqlDate(_inwardFormBean.getPaymentDate()));
        st.setFloat(++paramIndex, _inwardFormBean.getAmount());
        st.setString(++paramIndex, _inwardFormBean.getCurrency());
        st.setBoolean(++paramIndex, _inwardFormBean.isChequeReturn());
        st.setString(++paramIndex, _inwardFormBean.getChequeReturnReason());
        st.setString(++paramIndex, _inwardFormBean.getChequeReturnReasonOther());
        st.setInt(++paramIndex, _inwardFormBean.getReceiptNumber());
        st.setString(++paramIndex, _inwardFormBean.getAckDate());
        st.setString(++paramIndex, _inwardFormBean.getRemarks());
        return db.executeUpdatePreparedStatement(st);

    }


    private String getNextInwardNumber()throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException{

        String nextInward = null;
        //get the last inward number from inward table
        String lastInwardSql = Queries.getQuery("get_last_inward");
        ResultSet rs = db.executeQuery(lastInwardSql);
        Calendar calendar = Calendar.getInstance();


        ResultSetMetaData rsmd = rs.getMetaData();
        int colCount = rsmd.getColumnCount();
        String lastInward = null;
        int lastInwardYear = 0;
        while (rs.next()) {

            lastInward = rs.getString("inward_no");
            java.sql.Date dt = rs.getDate("creation_date");
            Calendar inCal = Calendar.getInstance();
            inCal.setTime(dt);
            lastInwardYear = inCal.get(Calendar.YEAR);

        }

        //if true there exists a previous inward for the year, so just increment the inward number.
        if(lastInwardYear == calendar.get(Calendar.YEAR)){

            // get the last inward number after the split
            int inward = Integer.parseInt(lastInward.substring(4));

            //increment
            ++inward;


            //apend the year, month character and new inward number.
            nextInward = lastInward.substring(0, 2) + getMonthToCharacterMap(calendar.get(Calendar.MONTH)) + "-" + String.format("%05d",inward);
        }else{
            // there is no previous record for the year, so start the numbering afresh
            String year = String.valueOf(calendar.get(Calendar.YEAR)).substring(2);
            nextInward = year + getMonthToCharacterMap(calendar.get(Calendar.MONTH)) + "-" + String.format("%05d",1);
        }

        return nextInward;
    }

    private String getMonthToCharacterMap(int _month){

        char[] alphabet= "abcdefghijkl".toCharArray();

        // the calendar objects month starts from 0
        String monthChar = Character.toString(alphabet[_month]);
        return monthChar.toUpperCase();

    }


}
