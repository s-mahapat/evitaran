/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.masterdata;

import javax.servlet.http.HttpServletRequest;
import IAS.Bean.masterdata.countryFormBean;
import IAS.Class.Database;
import javax.servlet.http.HttpSession;
import java.sql.*;
import IAS.Model.*;
import java.text.ParseException;
import IAS.Class.Queries;

/**
 *
 * @author Deepali
 */
public class countryModel extends JDSModel{
    private HttpServletRequest request = null;
    private countryFormBean _countryFormBean = null;
    private Connection conn = null;
    private Database db = null;
    private HttpSession session = null;

    public countryModel(HttpServletRequest request, countryFormBean _Bean) throws SQLException{
        this.request = request;
        this._countryFormBean = _Bean;
        this.session = request.getSession(false);
        if(this.session == null){
            throw(new SQLException("Database connection not found in the session"));
        }

        this.db = (Database)session.getAttribute("db_connection");
        this.conn = db.getConnection();

    }
    
        public int Save (HttpServletRequest request, countryFormBean _Bean) throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException{

        String sql;

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request,_Bean);
        request.setAttribute("countryFormBean", _Bean);



        // the query name from the jds_sql properties files in WEB-INF/properties folder
        sql = Queries.getQuery("country_insert");

        PreparedStatement st = conn.prepareStatement(sql);
        int paramIndex = 1;
        st.setString(paramIndex, _countryFormBean.getCountry());
        return db.executeUpdatePreparedStatement(st);

    }
}
        
