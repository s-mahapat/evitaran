/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.masterdata;

import javax.servlet.http.HttpServletRequest;
import IAS.Bean.masterdata.districtFormBean;
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
public class districtModel extends JDSModel{
    private HttpServletRequest request = null;
    private districtFormBean _districtFormBean = null;
    private Connection conn = null;
    private Database db = null;
    private HttpSession session = null;

    public districtModel(HttpServletRequest request, districtFormBean _Bean) throws SQLException{
        this.request = request;
        this._districtFormBean = _Bean;
        this.session = request.getSession(false);
        if(this.session == null){
            throw(new SQLException("Database connection not found in the session"));
        }

        this.db = (Database)session.getAttribute("db_connection");
        this.conn = db.getConnection();

    }
    
    public void Save () throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException{

        //districtFormBean districtFormBean = new IAS.Bean.masterdata.districtFormBean();
        String sql;

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, _districtFormBean);    
        
        if (_districtFormBean.getId() != 0) {
            
            this._updateDistrict();
            
        } else {

            // the query name from the jds_sql properties files in WEB-INF/properties folder
            sql = Queries.getQuery("district_insert");

            PreparedStatement st = conn.prepareStatement(sql, com.mysql.jdbc.Statement.RETURN_GENERATED_KEYS);
            int paramIndex = 1;
            st.setString(paramIndex, _districtFormBean.getDistrict());
            if (db.executeUpdatePreparedStatement(st) == 1) {
                ResultSet rs = st.getGeneratedKeys();
                while(rs.next()){
                    int i = rs.getInt(1);
                    //set the city id generated at the database
                    _districtFormBean.setId(i);
                }
                rs.close();
            }
            request.setAttribute("districtFormBean", this._districtFormBean);
        }
    }
        
    public String editDistrict() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        return this.GetDistrict();

    }

    public String viewDistrict() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        return this.GetDistrict();

    }   

    public String GetDistrict() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        String sql;
        
        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, _districtFormBean);

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        sql = Queries.getQuery("get_district_by_id");

        PreparedStatement st = conn.prepareStatement(sql);

        st.setInt(1, _districtFormBean.getId());

        ResultSet rs = db.executeQueryPreparedStatement(st);
        // populate the bean from the resultset using the beanprocessor class
        while (rs.next()) {
            BeanProcessor bProc = new BeanProcessor();
            Class type = Class.forName("IAS.Bean.masterdata.districtFormBean");
            this._districtFormBean = (IAS.Bean.masterdata.districtFormBean) bProc.toBean(rs, type);
        }
        rs.close();

        request.setAttribute("districtFormBean", this._districtFormBean);
        return _districtFormBean.getDistrict();
    }
    
    private void _updateDistrict() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("update_district");

        PreparedStatement st = conn.prepareStatement(sql);

        int paramIndex = 1;
        st.setString(paramIndex, _districtFormBean.getDistrict());
        st.setInt(++paramIndex, _districtFormBean.getId());
        db.executeUpdatePreparedStatement(st);     
        request.setAttribute("districtFormBean", this._districtFormBean);
    }
    
    public String searchDistrict() throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml = null;
        String sql = Queries.getQuery("search_district");
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;
        stGet.setString(paramIndex, "%" + request.getParameter("district") + "%");
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        xml = util.convertResultSetToXML(rs);
        return xml;
    }    
}        
       
