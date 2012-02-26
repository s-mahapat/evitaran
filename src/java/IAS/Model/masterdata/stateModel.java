/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.masterdata;

import javax.servlet.http.HttpServletRequest;
import IAS.Bean.masterdata.stateFormBean;
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
public class stateModel extends JDSModel{
    private HttpServletRequest request = null;
    private stateFormBean _stateFormBean = null;
    private Connection conn = null;
    private Database db = null;
    private HttpSession session = null;

    public stateModel(HttpServletRequest request, stateFormBean _Bean) throws SQLException{
        this.request = request;
        this._stateFormBean = _Bean;
        this.session = request.getSession(false);
        if(this.session == null){
            throw(new SQLException("Database connection not found in the session"));
        }

        this.db = (Database)session.getAttribute("db_connection");
        this.conn = db.getConnection();

    }
    
    public void Save () throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException{

        //stateFormBean stateFormBean = new IAS.Bean.masterdata.stateFormBean();
        String sql;

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, _stateFormBean);    
        
        if (_stateFormBean.getId() != 0) {
            
            this._updateState();
            
        } else {

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        sql = Queries.getQuery("state_insert");

         PreparedStatement st = conn.prepareStatement(sql, com.mysql.jdbc.Statement.RETURN_GENERATED_KEYS);
            int paramIndex = 1;
            st.setString(paramIndex, _stateFormBean.getState());
            if (db.executeUpdatePreparedStatement(st) == 1) {
                ResultSet rs = st.getGeneratedKeys();
                while(rs.next()){
                    int i = rs.getInt(1);
                    //set the city id generated at the database
                    _stateFormBean.setId(i);
                }
                rs.close();
            }
            request.setAttribute("stateFormBean", this._stateFormBean);
        }
    }
        
    public String editState() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        return this.GetState();

    }

    public String viewState() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        return this.GetState();

    }   

    public String GetState() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        String sql;
        
        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, _stateFormBean);

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        sql = Queries.getQuery("get_state_by_id");

        PreparedStatement st = conn.prepareStatement(sql);

        st.setInt(1, _stateFormBean.getId());

        ResultSet rs = db.executeQueryPreparedStatement(st);
        // populate the bean from the resultset using the beanprocessor class
        while (rs.next()) {
            BeanProcessor bProc = new BeanProcessor();
            Class type = Class.forName("IAS.Bean.masterdata.stateFormBean");
            this._stateFormBean = (IAS.Bean.masterdata.stateFormBean) bProc.toBean(rs, type);
        }
        rs.close();

        request.setAttribute("stateFormBean", this._stateFormBean);
        return _stateFormBean.getState();
    }
    
    private void _updateState() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("update_state");

        PreparedStatement st = conn.prepareStatement(sql);

        int paramIndex = 1;
        st.setString(paramIndex, _stateFormBean.getState());
        st.setInt(++paramIndex, _stateFormBean.getId());
        db.executeUpdatePreparedStatement(st);
       
        request.setAttribute("stateFormBean", this._stateFormBean);
    }

    public String searchState() throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml = null;
        String sql = Queries.getQuery("search_state");
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;
        stGet.setString(paramIndex, "%" + request.getParameter("state") + "%");
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        xml = util.convertResultSetToXML(rs);
        return xml;
    }    
}        
       
