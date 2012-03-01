
package IAS.Model.masterdata;

import javax.servlet.http.HttpServletRequest;
import IAS.Bean.masterdata.countryFormBean;
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
public class countryModel extends JDSModel{

    private countryFormBean _countryFormBean = null;
    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Model.masterdata");

    public countryModel(HttpServletRequest request) throws SQLException{

        super(request);
    }

    public synchronized void Save () throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException{

        countryFormBean countryFormBean = new IAS.Bean.masterdata.countryFormBean();
        request.setAttribute("countryFormBean", countryFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, countryFormBean);
        this._countryFormBean = countryFormBean;

        if (_countryFormBean.getId() != 0) {

            this._updateCountry();

        } else {

            String sql;

            // the query name from the jds_sql properties files in WEB-INF/properties folder
            sql = Queries.getQuery("country_insert");

            PreparedStatement st = conn.prepareStatement(sql, com.mysql.jdbc.Statement.RETURN_GENERATED_KEYS);
            int paramIndex = 1;
            st.setString(paramIndex, _countryFormBean.getCountry());

            try
            {
                if (db.executeUpdatePreparedStatement(st) == 1) {
                    try (ResultSet rs = st.getGeneratedKeys()) {
                        while(rs.next()){
                            int i = rs.getInt(1);
                            //set the city id generated at the database
                            _countryFormBean.setId(i);
                        }
                    }
                }
            }catch (Exception MySQLIntegrityConstraintViolationException)
            {
                logger.error(MySQLIntegrityConstraintViolationException.getMessage(), MySQLIntegrityConstraintViolationException);
            }
            request.setAttribute("countryFormBean", this._countryFormBean);
        }
    }

    public String editCountry() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        return this.GetCountry();

    }

    public String viewCountry() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        return this.GetCountry();

    }

    public String GetCountry() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        countryFormBean countryFormBean = new IAS.Bean.masterdata.countryFormBean();
        request.setAttribute("countryFormBean", countryFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, countryFormBean);
        this._countryFormBean = countryFormBean;

        String sql;
        // the query name from the jds_sql properties files in WEB-INF/properties folder
        sql = Queries.getQuery("get_country_by_id");

        PreparedStatement st = conn.prepareStatement(sql);

        st.setInt(1, _countryFormBean.getId());

        ResultSet rs = db.executeQueryPreparedStatement(st);
        // populate the bean from the resultset using the beanprocessor class
        while (rs.next()) {
            BeanProcessor bProc = new BeanProcessor();
            Class type = Class.forName("IAS.Bean.masterdata.countryFormBean");
            this._countryFormBean = (IAS.Bean.masterdata.countryFormBean) bProc.toBean(rs, type);
        }
        rs.close();

        request.setAttribute("countryFormBean", this._countryFormBean);
        return _countryFormBean.getCountry();
    }

    private synchronized void _updateCountry() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("update_country");

        PreparedStatement st = conn.prepareStatement(sql);

        int paramIndex = 1;
        st.setString(paramIndex, _countryFormBean.getCountry());
        st.setInt(++paramIndex, _countryFormBean.getId());
        try
        {
            db.executeUpdatePreparedStatement(st);
        }catch (Exception MySQLIntegrityConstraintViolationException)
        {
            logger.error(MySQLIntegrityConstraintViolationException.getMessage(), MySQLIntegrityConstraintViolationException);
        }
        request.setAttribute("countryFormBean", this._countryFormBean);
    }

    public String searchCountry() throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml = null;
        String sql = Queries.getQuery("search_country");
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;
        stGet.setString(paramIndex, "%" + request.getParameter("country") + "%");
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        xml = util.convertResultSetToXML(rs);
        return xml;
    }
}

