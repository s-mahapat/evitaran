/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.masterdata;

import javax.servlet.http.HttpServletRequest;
import IAS.Bean.masterdata.subTypeFormBean;
import IAS.Class.Database;
import javax.servlet.http.HttpSession;
import java.sql.*;
import IAS.Model.*;
import java.text.ParseException;
import IAS.Class.Queries;
import org.apache.commons.dbutils.BeanProcessor;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import IAS.Class.util;
/**
 *
 * @author Deepali
 */
public class subTypeModel extends JDSModel{
    private HttpServletRequest request = null;
    private subTypeFormBean _subTypeFormBean = null;
    private Connection conn = null;
    private Database db = null;
    private HttpSession session = null;

    public subTypeModel(HttpServletRequest request, subTypeFormBean _Bean) throws SQLException{
        this.request = request;
        this._subTypeFormBean = _Bean;
        this.session = request.getSession(false);
        if(this.session == null){
            throw(new SQLException("Database connection not found in the session"));
        }

        this.db = (Database)session.getAttribute("db_connection");
        this.conn = db.getConnection();

    }
    
    public void Save () throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException{

        //subTypeFormBean subTypeFormBean = new IAS.Bean.masterdata.subTypeFormBean();
        String sql;

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, _subTypeFormBean);    
        
        if (_subTypeFormBean.getSubTypeId() != 0) {
            
            this._updateSubType();
            
        } else {

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        sql = Queries.getQuery("subType_insert");

        PreparedStatement st = conn.prepareStatement(sql);
        int paramIndex = 1;
        st.setString(paramIndex, _subTypeFormBean.getSubTypeCode());
        st.setString(++paramIndex, _subTypeFormBean.getSubTypeName());
        st.setString(++paramIndex, _subTypeFormBean.getFreePaid());
        st.setString(++paramIndex, _subTypeFormBean.getNationality());
        st.setString(++paramIndex, _subTypeFormBean.getInstitutional());
        st.setInt(++paramIndex, _subTypeFormBean.getFreeCopies());
        st.setInt(++paramIndex, _subTypeFormBean.getDiscount());
        db.executeUpdatePreparedStatement(st);
        
        sql = Queries.getQuery("get_subType_by_name");

        PreparedStatement stGet = conn.prepareStatement(sql);
        paramIndex = 1;
        stGet.setString(paramIndex, _subTypeFormBean.getSubTypeCode());
        stGet.setString(++paramIndex, _subTypeFormBean.getSubTypeName());
        stGet.setString(++paramIndex, _subTypeFormBean.getFreePaid());
        stGet.setString(++paramIndex, _subTypeFormBean.getNationality());
        stGet.setString(++paramIndex, _subTypeFormBean.getInstitutional());
        stGet.setInt(++paramIndex, _subTypeFormBean.getFreeCopies());
        stGet.setInt(++paramIndex, _subTypeFormBean.getDiscount());
        ResultSet rs = db.executeQueryPreparedStatement(stGet);
        
        // populate the bean from the resultset using the beanprocessor class
        while (rs.next()) {
            
            BeanProcessor bProc = new BeanProcessor();
            Class type = Class.forName("IAS.Bean.masterdata.subTypeFormBean");
            this._subTypeFormBean = (IAS.Bean.masterdata.subTypeFormBean) bProc.toBean(rs, type);
        }
        rs.close(); 
        
        request.setAttribute("subTypeFormBean", this._subTypeFormBean);
        }
    }
        
    public String editSubType() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        return this.GetSubType();

    }

    public String viewSubType() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        return this.GetSubType();

    }   

    public String GetSubType() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        String sql;
        
        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, _subTypeFormBean);

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        sql = Queries.getQuery("get_subType_by_id");

        PreparedStatement st = conn.prepareStatement(sql);

        st.setInt(1, _subTypeFormBean.getSubTypeId());

        ResultSet rs = db.executeQueryPreparedStatement(st);
        // populate the bean from the resultset using the beanprocessor class
        while (rs.next()) {
            BeanProcessor bProc = new BeanProcessor();
            Class type = Class.forName("IAS.Bean.masterdata.subTypeFormBean");
            this._subTypeFormBean = (IAS.Bean.masterdata.subTypeFormBean) bProc.toBean(rs, type);
        }
        rs.close();

        request.setAttribute("subTypeFormBean", this._subTypeFormBean);
        return _subTypeFormBean.getSubTypeName();
    }
    
    private void _updateSubType() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("update_subType");

        PreparedStatement st = conn.prepareStatement(sql);

        int paramIndex = 1;
        st.setString(paramIndex, _subTypeFormBean.getSubTypeCode());
        st.setString(++paramIndex, _subTypeFormBean.getSubTypeName());
        st.setString(++paramIndex, _subTypeFormBean.getFreePaid());
        st.setString(++paramIndex, _subTypeFormBean.getNationality());
        st.setString(++paramIndex, _subTypeFormBean.getInstitutional());
        st.setInt(++paramIndex, _subTypeFormBean.getFreeCopies());
        st.setInt(++paramIndex, _subTypeFormBean.getDiscount());
        st.setInt(++paramIndex, _subTypeFormBean.getSubTypeId());
        db.executeUpdatePreparedStatement(st);

        sql = Queries.getQuery("get_subType_by_id");

        PreparedStatement stGet = conn.prepareStatement(sql);
        paramIndex = 1;
        stGet.setInt(paramIndex, _subTypeFormBean.getSubTypeId());
        ResultSet rs = db.executeQueryPreparedStatement(stGet);
        
        // populate the bean from the resultset using the beanprocessor class
        while (rs.next()) {
            
            BeanProcessor bProc = new BeanProcessor();
            Class type = Class.forName("IAS.Bean.masterdata.subTypeFormBean");
            this._subTypeFormBean = (IAS.Bean.masterdata.subTypeFormBean) bProc.toBean(rs, type);
        }
        rs.close(); 
        
        request.setAttribute("subTypeFormBean", this._subTypeFormBean);
    }

    public String searchSubType() throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml = null;
        String sql = Queries.getQuery("search_subType");
        
        ResultSet rs = this.db.executeQuery(sql);

        xml = util.convertResultSetToXML(rs);

        return xml;
    }
}        
       
