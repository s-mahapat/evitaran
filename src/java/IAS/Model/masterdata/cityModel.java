package IAS.Model.masterdata;

import IAS.Bean.masterdata.cityFormBean;
import IAS.Class.Database;
import IAS.Class.JDSLogger;
import IAS.Class.Queries;
import IAS.Class.util;
import IAS.Model.JDSModel;
import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException;
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
public class cityModel extends JDSModel {

    private cityFormBean _cityFormBean = null;
    private static final Logger logger = JDSLogger.getJDSLogger(IAS.Model.masterdata.cityModel.class.getName());

    public cityModel(HttpServletRequest request) throws SQLException {
        super(request);
    }

    public synchronized int Save() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        cityFormBean cityFormBean = new IAS.Bean.masterdata.cityFormBean();
        request.setAttribute("cityFormBean", cityFormBean);
        int cityID = 0;

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, cityFormBean);
        this._cityFormBean = cityFormBean;
        if (_cityFormBean.getId() != 0) {

            this._updateCity();

        } else {

            String sql;

            // the query name from the jds_sql properties files in WEB-INF/properties folder
            sql = Queries.getQuery("city_insert");
            try (Connection conn = this.getConnection(); PreparedStatement st = conn.prepareStatement(sql, com.mysql.jdbc.Statement.RETURN_GENERATED_KEYS)) {
                int paramIndex = 1;
                st.setString(paramIndex, _cityFormBean.getCity());
                if (st.executeUpdate() == 1) {
                    try (ResultSet rs = st.getGeneratedKeys()) {
                        while (rs.next()) {
                            cityID = rs.getInt(1);
                            //set the city id generated at the database
                            _cityFormBean.setId(cityID);
                        }
                    }
                    request.setAttribute("cityFormBean", this._cityFormBean);
                }

            }

        }
        return cityID;
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
        try (Connection conn = this.getConnection(); PreparedStatement st = conn.prepareStatement(sql)) {
            st.setInt(1, _cityFormBean.getId());
            // populate the bean from the resultset using the beanprocessor class
            try (ResultSet rs = st.executeQuery()) {
                // populate the bean from the resultset using the beanprocessor class
                while (rs.next()) {
                    BeanProcessor bProc = new BeanProcessor();
                    this._cityFormBean = bProc.toBean(rs, IAS.Bean.masterdata.cityFormBean.class);
                }
            }
        }

        request.setAttribute("cityFormBean", this._cityFormBean);
        return _cityFormBean.getCity();
    }

    private synchronized void _updateCity() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("update_city");
        try (Connection conn = this.getConnection(); PreparedStatement st = conn.prepareStatement(sql)) {
            int paramIndex = 1;
            st.setString(paramIndex, _cityFormBean.getCity());
            st.setInt(++paramIndex, _cityFormBean.getId());
            st.executeUpdate();
        } catch (Exception MySQLIntegrityConstraintViolationException) {
            logger.error(MySQLIntegrityConstraintViolationException.getMessage(), MySQLIntegrityConstraintViolationException);
        }
        request.setAttribute("cityFormBean", this._cityFormBean);
    }

    public String searchCity() throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml;
        String sql = Queries.getQuery("search_city");
        try (Connection _conn = Database.getConnection(); PreparedStatement stGet = _conn.prepareStatement(sql)) {
            int paramIndex = 1;
            stGet.setString(paramIndex, "%" + request.getParameter("city") + "%");
            try (ResultSet rs = stGet.executeQuery()) {
                xml = util.convertResultSetToXML(rs);
            }
        }
        return xml;
    }

    public String CitySearch(String term) throws SQLException {

        String xml = null;
        String sql = Queries.getQuery("city_search");
        try (Connection _conn = Database.getConnection(); PreparedStatement stGet = _conn.prepareStatement(sql)) {
            stGet.setString(1, term + "%");
            try (ResultSet rs = stGet.executeQuery()) {
                xml = util.convertResultSetToXML(rs);
            }
        } finally {
            return xml;
        }

    }
}
