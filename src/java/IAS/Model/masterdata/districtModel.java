package IAS.Model.masterdata;

import javax.servlet.http.HttpServletRequest;
import IAS.Bean.masterdata.districtFormBean;
import IAS.Class.Database;
import java.sql.*;
import IAS.Model.*;
import java.text.ParseException;
import IAS.Class.Queries;
import org.apache.commons.dbutils.BeanProcessor;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import IAS.Class.util;
import org.apache.log4j.Logger;
import IAS.Class.JDSLogger;

/**
 *
 * @author Deepali
 */
public class districtModel extends JDSModel {

    private districtFormBean _districtFormBean = null;
    private static final Logger logger = JDSLogger.getJDSLogger(IAS.Model.masterdata.districtModel.class.getName());

    public districtModel(HttpServletRequest request) throws SQLException {
        super(request);
    }

    public synchronized void Save() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        districtFormBean districtFormBean = new IAS.Bean.masterdata.districtFormBean();
        request.setAttribute("districtFormBean", districtFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, districtFormBean);
        this._districtFormBean = districtFormBean;

        if (_districtFormBean.getId() != 0) {

            this._updateDistrict();

        } else {

            String sql;

            // the query name from the jds_sql properties files in WEB-INF/properties folder
            sql = Queries.getQuery("district_insert");
            try (Connection conn = this.getConnection(); PreparedStatement st = conn.prepareStatement(sql, com.mysql.jdbc.Statement.RETURN_GENERATED_KEYS);) {
                int paramIndex = 1;
                st.setString(paramIndex, _districtFormBean.getDistrict());
                try {
                    if (st.executeUpdate() == 1) {
                        try (ResultSet rs = st.getGeneratedKeys()) {
                            while (rs.next()) {
                                int i = rs.getInt(1);
                                //set the city id generated at the database
                                _districtFormBean.setId(i);
                            }
                        }
                    }
                } catch (SQLException MySQLIntegrityConstraintViolationException) {
                    logger.error(MySQLIntegrityConstraintViolationException.getMessage(), MySQLIntegrityConstraintViolationException);
                }
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

        districtFormBean districtFormBean = new IAS.Bean.masterdata.districtFormBean();
        request.setAttribute("districtFormBean", districtFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, districtFormBean);
        this._districtFormBean = districtFormBean;

        String sql;
        // the query name from the jds_sql properties files in WEB-INF/properties folder
        sql = Queries.getQuery("get_district_by_id");
        try (Connection conn = this.getConnection(); PreparedStatement st = conn.prepareStatement(sql);) {

            st.setInt(1, _districtFormBean.getId());

            // populate the bean from the resultset using the beanprocessor class
            try (ResultSet rs = st.executeQuery()) {
                // populate the bean from the resultset using the beanprocessor class
                while (rs.next()) {
                    BeanProcessor bProc = new BeanProcessor();
                    Class type = Class.forName("IAS.Bean.masterdata.districtFormBean");
                    this._districtFormBean = (IAS.Bean.masterdata.districtFormBean) bProc.toBean(rs, type);
                }
            }

            request.setAttribute("districtFormBean", this._districtFormBean);
        }
        return _districtFormBean.getDistrict();
    }

    private synchronized void _updateDistrict() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("update_district");
        try (Connection conn = this.getConnection()) {
            PreparedStatement st = conn.prepareStatement(sql);
            int paramIndex = 1;
            st.setString(paramIndex, _districtFormBean.getDistrict());
            st.setInt(++paramIndex, _districtFormBean.getId());
            st.executeUpdate();
        } catch (Exception MySQLIntegrityConstraintViolationException) {
            logger.error(MySQLIntegrityConstraintViolationException.getMessage(), MySQLIntegrityConstraintViolationException);
        }
        request.setAttribute("districtFormBean", this._districtFormBean);
    }

    public String searchDistrict(String term) throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml;
        String sql = Queries.getQuery("search_district");
        try (Connection _conn = this.getConnection(); PreparedStatement stGet = _conn.prepareStatement(sql)) {
            int paramIndex = 1;
            stGet.setString(paramIndex, "%" + term + "%");
            try (ResultSet rs = stGet.executeQuery()) {
                xml = util.convertResultSetToXML(rs);
            }
        }
        return xml;
    }
}
