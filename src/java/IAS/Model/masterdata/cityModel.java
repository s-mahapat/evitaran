/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.masterdata;

import javax.servlet.http.HttpServletRequest;
import IAS.Bean.masterdata.cityFormBean;
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
public class cityModel extends JDSModel{
    private HttpServletRequest request = null;
    private cityFormBean _cityFormBean = null;
    private Connection conn = null;
    private Database db = null;
    private HttpSession session = null;

    public cityModel(HttpServletRequest request, cityFormBean _Bean) throws SQLException{
        this.request = request;
        this._cityFormBean = _Bean;
        this.session = request.getSession(false);
        if(this.session == null){
            throw(new SQLException("Database connection not found in the session"));
        }

        this.db = (Database)session.getAttribute("db_connection");
        this.conn = db.getConnection();

    }
    
    public void Save () throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException{

        //cityFormBean cityFormBean = new IAS.Bean.masterdata.cityFormBean();
        String sql;

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, _cityFormBean);    
        
        if (_cityFormBean.getId() != 0) {
            
            this._updateCity();
            
        } else {

            // the query name from the jds_sql properties files in WEB-INF/properties folder
            sql = Queries.getQuery("city_insert");

            PreparedStatement st = conn.prepareStatement(sql, com.mysql.jdbc.Statement.RETURN_GENERATED_KEYS);
            int paramIndex = 1;
            st.setString(paramIndex, _cityFormBean.getCity());
            if (db.executeUpdatePreparedStatement(st) == 1) {
                ResultSet rs = st.getGeneratedKeys();
                while(rs.next()){
                    int i = rs.getInt(1);
                    //set the city id generated at the database
                    _cityFormBean.setId(i);
                }
                rs.close();
            }
            request.setAttribute("cityFormBean", this._cityFormBean);
        }
    }
        
    public String editCity() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        return this.GetCity();

    }

    public String viewCity() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        return this.GetCity();

    }   

    public String GetCity() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        String sql;
        
        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, _cityFormBean);

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        sql = Queries.getQuery("get_city_by_id");

        PreparedStatement st = conn.prepareStatement(sql);

        st.setInt(1, _cityFormBean.getId());

        ResultSet rs = db.executeQueryPreparedStatement(st);
        // populate the bean from the resultset using the beanprocessor class
        while (rs.next()) {
            BeanProcessor bProc = new BeanProcessor();
            Class type = Class.forName("IAS.Bean.masterdata.cityFormBean");
            this._cityFormBean = (IAS.Bean.masterdata.cityFormBean) bProc.toBean(rs, type);
        }
        rs.close();

        request.setAttribute("cityFormBean", this._cityFormBean);
        return _cityFormBean.getCity();
    }
    
    private void _updateCity() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("update_city");

        PreparedStatement st = conn.prepareStatement(sql);

        int paramIndex = 1;
        st.setString(paramIndex, _cityFormBean.getCity());
        st.setInt(++paramIndex, _cityFormBean.getId());
        db.executeUpdatePreparedStatement(st);     
        request.setAttribute("cityFormBean", this._cityFormBean);
    }
    
    public String searchCity() throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml = null;
        String sql = Queries.getQuery("search_city");
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;
        stGet.setString(paramIndex, "%" + request.getParameter("city") + "%");
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        xml = util.convertResultSetToXML(rs);
        return xml;
    }    
}        
       
