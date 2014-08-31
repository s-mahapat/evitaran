/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.masterdata;

import IAS.Bean.masterdata.agentFormBean;
import IAS.Class.JDSLogger;
import IAS.Class.Queries;
import IAS.Class.util;
import IAS.Model.*;
import java.sql.*;
import java.text.ParseException;
import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import org.apache.commons.dbutils.BeanProcessor;
import org.apache.log4j.Logger;

/**
 *
 * @author Deepali
 */
public class agentModel extends JDSModel {

    private agentFormBean _agentFormBean = null;
    private static final Logger logger = JDSLogger.getJDSLogger(IAS.Model.masterdata.agentModel.class.getName());

    public agentModel(HttpServletRequest request) throws SQLException {
        super(request);
    }

    public synchronized void Save() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        agentFormBean agentFormBean = new IAS.Bean.masterdata.agentFormBean();
        request.setAttribute("agentFormBean", agentFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, agentFormBean);
        this._agentFormBean = agentFormBean;

        if (_agentFormBean.getId() != 0) {

            this._updateAgent();

        } else {

            String sql;

            // the query name from the jds_sql properties files in WEB-INF/properties folder
            sql = Queries.getQuery("agent_insert");
            try (Connection conn = this.getConnection(); PreparedStatement st = conn.prepareStatement(sql, com.mysql.jdbc.Statement.RETURN_GENERATED_KEYS);) {
                int paramIndex = 1;
                st.setString(paramIndex, _agentFormBean.getAgentName());
                st.setDate(++paramIndex, util.dateStringToSqlDate(_agentFormBean.getRegDate()));
                st.setString(++paramIndex, _agentFormBean.getEmailId());
                st.setString(++paramIndex, _agentFormBean.getAddress());
                st.setString(++paramIndex, _agentFormBean.getCity());
                st.setString(++paramIndex, _agentFormBean.getDistrict());
                st.setString(++paramIndex, _agentFormBean.getState());
                st.setString(++paramIndex, _agentFormBean.getCountry());
                st.setInt(++paramIndex, _agentFormBean.getPinCode());
                st.setInt(++paramIndex, _agentFormBean.getDiscount());

                try {
                    if (st.executeUpdate() == 1) {
                        try (ResultSet rs = st.getGeneratedKeys()) {
                            while (rs.next()) {
                                int i = rs.getInt(1);
                                //set the city id generated at the database
                                _agentFormBean.setId(i);
                            }
                        }
                    }
                } catch (SQLException MySQLIntegrityConstraintViolationException) {
                    logger.error(MySQLIntegrityConstraintViolationException.getMessage(), MySQLIntegrityConstraintViolationException);
                }
                request.setAttribute("subTypeFormBean", this._agentFormBean);
            }

        }
    }

    public String editAgent() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        return this.GetAgent();

    }

    public String viewAgent() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        return this.GetAgent();

    }

    public String GetAgent() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        agentFormBean agentFormBean = new IAS.Bean.masterdata.agentFormBean();
        request.setAttribute("subTypeFormBean", agentFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, agentFormBean);
        this._agentFormBean = agentFormBean;

        String sql;
        // the query name from the jds_sql properties files in WEB-INF/properties folder
        sql = Queries.getQuery("get_agent_by_id");

        try (Connection conn = this.getConnection(); PreparedStatement st = conn.prepareStatement(sql)) {

            st.setInt(1, _agentFormBean.getId());
            // populate the bean from the resultset using the beanprocessor class
            try (ResultSet rs = st.executeQuery()) {
                // populate the bean from the resultset using the beanprocessor class
                while (rs.next()) {
                    BeanProcessor bProc = new BeanProcessor();
                    Class type = Class.forName("IAS.Bean.masterdata.agentFormBean");
                    this._agentFormBean = (IAS.Bean.masterdata.agentFormBean) bProc.toBean(rs, type);
                }
            }
        }

        request.setAttribute("agentFormBean", this._agentFormBean);
        return _agentFormBean.getAgentName();
    }

    private synchronized void _updateAgent() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("update_agent");
        try (Connection conn = this.getConnection(); PreparedStatement st = conn.prepareStatement(sql)) {
            int paramIndex = 1;
            st.setString(paramIndex, _agentFormBean.getAgentName());

            String dateFromDb = _agentFormBean.getRegDate();
            if (!util.checkDateFormat(dateFromDb)) {
                dateFromDb = util.changeDateFormat(dateFromDb);
            }

            st.setDate(++paramIndex, util.dateStringToSqlDate(dateFromDb));
            st.setString(++paramIndex, _agentFormBean.getAddress());
            st.setString(++paramIndex, _agentFormBean.getEmailId());
            st.setString(++paramIndex, _agentFormBean.getCity());
            st.setString(++paramIndex, _agentFormBean.getDistrict());
            st.setString(++paramIndex, _agentFormBean.getState());
            st.setString(++paramIndex, _agentFormBean.getCountry());
            st.setInt(++paramIndex, _agentFormBean.getPinCode());
            st.setInt(++paramIndex, _agentFormBean.getDiscount());
            st.setInt(++paramIndex, _agentFormBean.getId());
            st.executeUpdate();
        } catch (Exception MySQLIntegrityConstraintViolationException) {
            logger.error(MySQLIntegrityConstraintViolationException.getMessage(), MySQLIntegrityConstraintViolationException);
        }
        request.setAttribute("agentFormBean", this._agentFormBean);
    }

    public String searchAgent() throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml;
        String sql = Queries.getQuery("search_agent_screen");
        try (Connection conn = this.getConnection();) {
            int paramIndex = 1;

            String agentName = request.getParameter("agentName");
            String city = request.getParameter("city");

            if (!city.isEmpty()) {
                sql += " t2.city like" + "'%" + city + "%'";
            }

            if (!agentName.isEmpty()) {
                if (!city.isEmpty()) {
                    sql += " and";
                }
                sql += " t1.agentName like " + "'%" + agentName + "%'";
            } else {
                if (!city.isEmpty()) {
                    sql += " and";
                }
                sql += " t1.agentName like " + "'%%'";
            }
            try (PreparedStatement stGet = conn.prepareStatement(sql); ResultSet rs = stGet.executeQuery();) {
                xml = util.convertResultSetToXML(rs);
            }
        }

        return xml;
    }
}
