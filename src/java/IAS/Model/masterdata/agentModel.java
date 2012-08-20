/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.masterdata;

import javax.servlet.http.HttpServletRequest;
import IAS.Bean.masterdata.agentFormBean;
import IAS.Class.Database;
import java.sql.*;
import IAS.Model.*;
import java.text.ParseException;
import IAS.Class.Queries;
import org.apache.commons.dbutils.BeanProcessor;
import IAS.Class.util;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import org.apache.log4j.Logger;
import IAS.Class.JDSLogger;
/**
 *
 * @author Deepali
 */
public class agentModel extends JDSModel{

    private agentFormBean _agentFormBean = null;
    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Model.masterdata");

    public agentModel(HttpServletRequest request) throws SQLException{

        //super(request);

    }

    public synchronized void Save () throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException{

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

            PreparedStatement st = conn.prepareStatement(sql, com.mysql.jdbc.Statement.RETURN_GENERATED_KEYS);
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

            try
            {
                if (db.executeUpdatePreparedStatement(st) == 1) {
                        try (ResultSet rs = st.getGeneratedKeys()) {
                            while(rs.next()){
                                int i = rs.getInt(1);
                                //set the city id generated at the database
                                _agentFormBean.setId(i);
                            }
                        }
                    }
            }catch (Exception MySQLIntegrityConstraintViolationException)
            {
                logger.error(MySQLIntegrityConstraintViolationException.getMessage(), MySQLIntegrityConstraintViolationException);
            }
            request.setAttribute("subTypeFormBean", this._agentFormBean);
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

        PreparedStatement st = conn.prepareStatement(sql);

        st.setInt(1, _agentFormBean.getId());

        ResultSet rs = db.executeQueryPreparedStatement(st);
        // populate the bean from the resultset using the beanprocessor class
        while (rs.next()) {
            BeanProcessor bProc = new BeanProcessor();
            Class type = Class.forName("IAS.Bean.masterdata.agentFormBean");
            this._agentFormBean = (IAS.Bean.masterdata.agentFormBean) bProc.toBean(rs, type);
        }
        rs.close();

        request.setAttribute("agentFormBean", this._agentFormBean);
        return _agentFormBean.getAgentName();
    }

    private synchronized void _updateAgent() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("update_agent");

        PreparedStatement st = conn.prepareStatement(sql);

        int paramIndex = 1;
        st.setString(paramIndex, _agentFormBean.getAgentName());

        String dateFromDb = _agentFormBean.getRegDate();
        if(!util.checkDateFormat(dateFromDb))
        dateFromDb = util.changeDateFormat(dateFromDb);

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

        try
        {
            db.executeUpdatePreparedStatement(st);
        }catch (Exception MySQLIntegrityConstraintViolationException)
        {
            logger.error(MySQLIntegrityConstraintViolationException.getMessage(), MySQLIntegrityConstraintViolationException);
        }
        request.setAttribute("agentFormBean", this._agentFormBean);
    }

    public String searchAgent() throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml = null;
        String sql = Queries.getQuery("search_agent");
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;

        String agentName = request.getParameter("agentName");
        String city = request.getParameter("city");

        if(!city.isEmpty())
            stGet.setString(paramIndex++, "%" + city + "%");
        else
            stGet.setString(paramIndex++, "%%");

        if(!agentName.isEmpty())
            stGet.setString(paramIndex++, "%" + agentName + "%");
        else
            stGet.setString(paramIndex++, "%%");

        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        xml = util.convertResultSetToXML(rs);
        return xml;
    }
}

