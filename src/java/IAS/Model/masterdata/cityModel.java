
package IAS.Model.masterdata;

import IAS.Bean.masterdata.cityFormBean;
import IAS.Class.Database;
import IAS.Class.JDSLogger;
import IAS.Class.Queries;
import IAS.Class.util;
import IAS.Model.JDSModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
public class cityModel extends JDSModel{

    private cityFormBean _cityFormBean = null;
    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Model.masterdata");

    public cityModel(HttpServletRequest request) throws SQLException{

        super(request);
    }

    public synchronized void Save () throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException{

        cityFormBean cityFormBean = new IAS.Bean.masterdata.cityFormBean();
        request.setAttribute("cityFormBean", cityFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, cityFormBean);
        this._cityFormBean = cityFormBean;

        if (_cityFormBean.getId() != 0) {

            this._updateCity();

        } else {

            String sql;

            // the query name from the jds_sql properties files in WEB-INF/properties folder
            sql = Queries.getQuery("city_insert");

            PreparedStatement st = conn.prepareStatement(sql, com.mysql.jdbc.Statement.RETURN_GENERATED_KEYS);
            int paramIndex = 1;
            st.setString(paramIndex, _cityFormBean.getCity());

            try
            {
                if (db.executeUpdatePreparedStatement(st) == 1) {
                    try (ResultSet rs = st.getGeneratedKeys()) {
                        while(rs.next()){
                            int i = rs.getInt(1);
                            //set the city id generated at the database
                            _cityFormBean.setId(i);
                        }
                    }
                }
            }catch (Exception MySQLIntegrityConstraintViolationException)
            {
                logger.error(MySQLIntegrityConstraintViolationException.getMessage(), MySQLIntegrityConstraintViolationException);
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

        cityFormBean cityFormBean = new IAS.Bean.masterdata.cityFormBean();
        request.setAttribute("cityFormBean", cityFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, cityFormBean);
        this._cityFormBean = cityFormBean;

        String sql;
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

    private synchronized void _updateCity() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("update_city");

        PreparedStatement st = conn.prepareStatement(sql);

        int paramIndex = 1;
        st.setString(paramIndex, _cityFormBean.getCity());
        st.setInt(++paramIndex, _cityFormBean.getId());
        try
        {
            db.executeUpdatePreparedStatement(st);
        }catch (Exception MySQLIntegrityConstraintViolationException)
        {
            logger.error(MySQLIntegrityConstraintViolationException.getMessage(), MySQLIntegrityConstraintViolationException);
        }
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
    
    public String CitySearch(String term) throws SQLException{
        Connection _conn = Database.getConnection();
        String xml = null;
        String sql = Queries.getQuery("city_search");
        try(PreparedStatement stGet = _conn.prepareStatement(sql)){
            stGet.setString(1, term + "%");
            try(ResultSet rs = stGet.executeQuery()){
                xml = util.convertResultSetToXML(rs);
            }
        }finally{
            _conn.close();
            return xml;
        }
        
        
    }
}