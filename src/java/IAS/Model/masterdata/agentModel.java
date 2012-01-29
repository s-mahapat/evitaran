/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.masterdata;

import javax.servlet.http.HttpServletRequest;
import IAS.Bean.masterdata.agentFormBean;
import IAS.Class.Database;
import javax.servlet.http.HttpSession;
import java.sql.*;
import IAS.Model.*;
import java.text.ParseException;
import IAS.Class.Queries;
import org.apache.commons.dbutils.BeanProcessor;
import IAS.Class.util;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
/**
 *
 * @author Deepali
 */
public class agentModel extends JDSModel{
    private HttpServletRequest request = null;
    private agentFormBean _agentFormBean = null;
    private Connection conn = null;
    private Database db = null;
    private HttpSession session = null;

    public agentModel(HttpServletRequest request, agentFormBean _Bean) throws SQLException{
        this.request = request;
        this._agentFormBean = _Bean;
        this.session = request.getSession(false);
        if(this.session == null){
            throw(new SQLException("Database connection not found in the session"));
        }

        this.db = (Database)session.getAttribute("db_connection");
        this.conn = db.getConnection();

    }
    
    public void Save () throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException{

        //agentFormBean agentFormBean = new IAS.Bean.masterdata.agentFormBean();
        String sql;

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, _agentFormBean);    
        
        if (_agentFormBean.getAgentId() != 0) {
            
            this._updateAgent();
            
        } else {

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        sql = Queries.getQuery("agent_insert");

        PreparedStatement st = conn.prepareStatement(sql);
        int paramIndex = 1;
        st.setString(paramIndex, _agentFormBean.getAgentName());
        st.setString(++paramIndex, _agentFormBean.getRegDate());        
        st.setString(++paramIndex, _agentFormBean.getEmailId());
        st.setString(++paramIndex, _agentFormBean.getAddress());
        st.setString(++paramIndex, _agentFormBean.getCity());
        st.setString(++paramIndex, _agentFormBean.getDistrict());
        st.setString(++paramIndex, _agentFormBean.getState());
        st.setString(++paramIndex, _agentFormBean.getCountry());
        st.setInt(++paramIndex, _agentFormBean.getPinCode());
        st.setInt(++paramIndex, _agentFormBean.getDiscount());
        
        db.executeUpdatePreparedStatement(st);
        
        sql = Queries.getQuery("get_agent_by_name");

        PreparedStatement stGet = conn.prepareStatement(sql);
        paramIndex = 1;
        stGet.setString(paramIndex, _agentFormBean.getAgentName());
        stGet.setString(++paramIndex, _agentFormBean.getRegDate());        
        stGet.setString(++paramIndex, _agentFormBean.getEmailId());
        stGet.setString(++paramIndex, _agentFormBean.getAddress());
        stGet.setString(++paramIndex, _agentFormBean.getCity());
        stGet.setString(++paramIndex, _agentFormBean.getDistrict());
        stGet.setString(++paramIndex, _agentFormBean.getState());
        stGet.setString(++paramIndex, _agentFormBean.getCountry());
        stGet.setInt(++paramIndex, _agentFormBean.getPinCode());
        stGet.setInt(++paramIndex, _agentFormBean.getDiscount());
        ResultSet rs = db.executeQueryPreparedStatement(stGet);
        
        // populate the bean from the resultset using the beanprocessor class
        while (rs.next()) {
            
            BeanProcessor bProc = new BeanProcessor();
            Class type = Class.forName("IAS.Bean.masterdata.agentFormBean");
            this._agentFormBean = (IAS.Bean.masterdata.agentFormBean) bProc.toBean(rs, type);
        }
        rs.close(); 
        
        request.setAttribute("agentFormBean", this._agentFormBean);
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

        String sql;
        
        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, _agentFormBean);

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        sql = Queries.getQuery("get_agent_by_id");

        PreparedStatement st = conn.prepareStatement(sql);

        st.setInt(1, _agentFormBean.getAgentId());

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
    
    private void _updateAgent() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("update_agent");

        PreparedStatement st = conn.prepareStatement(sql);

        int paramIndex = 1;
        st.setString(paramIndex, _agentFormBean.getAgentName());
        st.setString(++paramIndex, _agentFormBean.getRegDate());        
        st.setString(++paramIndex, _agentFormBean.getEmailId());
        st.setString(++paramIndex, _agentFormBean.getAddress());
        st.setString(++paramIndex, _agentFormBean.getCity());
        st.setString(++paramIndex, _agentFormBean.getDistrict());
        st.setString(++paramIndex, _agentFormBean.getState());
        st.setString(++paramIndex, _agentFormBean.getCountry());
        st.setInt(++paramIndex, _agentFormBean.getPinCode());
        st.setInt(++paramIndex, _agentFormBean.getDiscount());
        st.setInt(++paramIndex, _agentFormBean.getAgentId());
        db.executeUpdatePreparedStatement(st);

        sql = Queries.getQuery("get_agent_by_id");

        PreparedStatement stGet = conn.prepareStatement(sql);
        paramIndex = 1;
        stGet.setInt(paramIndex, _agentFormBean.getAgentId());
        ResultSet rs = db.executeQueryPreparedStatement(stGet);
        
        // populate the bean from the resultset using the beanprocessor class
        while (rs.next()) {
            
            BeanProcessor bProc = new BeanProcessor();
            Class type = Class.forName("IAS.Bean.masterdata.agentFormBean");
            this._agentFormBean = (IAS.Bean.masterdata.agentFormBean) bProc.toBean(rs, type);
        }
        rs.close(); 
        
        request.setAttribute("agentFormBean", this._agentFormBean);
    }
    
    public String searchAgent() throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml = null;
        String sql = Queries.getQuery("search_agent");
        
        ResultSet rs = this.db.executeQuery(sql);

        xml = util.convertResultSetToXML(rs);

        return xml;
    }    
}        
       
