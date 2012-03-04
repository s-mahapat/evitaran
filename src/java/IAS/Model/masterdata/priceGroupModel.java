
package IAS.Model.masterdata;

import javax.servlet.http.HttpServletRequest;
import IAS.Bean.masterdata.priceGroupFormBean;
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
public class priceGroupModel extends JDSModel{

    private priceGroupFormBean _priceGroupFormBean = null;
    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Model.masterdata");

    public priceGroupModel(HttpServletRequest request) throws SQLException{

       super(request);

    }

    public synchronized void Save () throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException{

        priceGroupFormBean priceGroupFormBean = new IAS.Bean.masterdata.priceGroupFormBean();
        request.setAttribute("priceGroupFormBean", priceGroupFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, priceGroupFormBean);
        this._priceGroupFormBean = priceGroupFormBean;

        if (_priceGroupFormBean.getId() != 0) {

            this._updatePriceGroup();

        } else {

            String sql;

            // the query name from the jds_sql properties files in WEB-INF/properties folder
            sql = Queries.getQuery("priceGroup_insert");

            PreparedStatement st = conn.prepareStatement(sql, com.mysql.jdbc.Statement.RETURN_GENERATED_KEYS);
            int paramIndex = 1;
            st.setString(++paramIndex, _priceGroupFormBean.getPriceGroupName());
            try
            {
            if (db.executeUpdatePreparedStatement(st) == 1) {
                    try (ResultSet rs = st.getGeneratedKeys()) {
                        while(rs.next()){
                            int i = rs.getInt(1);
                            //set the city id generated at the database
                            _priceGroupFormBean.setId(i);
                        }
                    }
                }
            }catch (Exception MySQLIntegrityConstraintViolationException)
            {
                logger.error(MySQLIntegrityConstraintViolationException.getMessage(), MySQLIntegrityConstraintViolationException);
            }
            request.setAttribute("priceGroupFormBean", this._priceGroupFormBean);
        }
    }

    public String editPriceGroup() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        return this.GetPriceGroup();

    }

    public String viewPriceGroup() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        return this.GetPriceGroup();

    }

    public String GetPriceGroup() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        priceGroupFormBean priceGroupFormBean = new IAS.Bean.masterdata.priceGroupFormBean();
        request.setAttribute("priceGroupFormBean", priceGroupFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, priceGroupFormBean);
        this._priceGroupFormBean = priceGroupFormBean;

        String sql;
        // the query name from the jds_sql properties files in WEB-INF/properties folder
        sql = Queries.getQuery("get_priceGroup_by_id");

        PreparedStatement st = conn.prepareStatement(sql);

        st.setInt(1, _priceGroupFormBean.getId());

        ResultSet rs = db.executeQueryPreparedStatement(st);
        // populate the bean from the resultset using the beanprocessor class
        while (rs.next()) { 
            BeanProcessor bProc = new BeanProcessor();
            Class type = Class.forName("IAS.Bean.masterdata.priceGroupFormBean");
            this._priceGroupFormBean = (IAS.Bean.masterdata.priceGroupFormBean) bProc.toBean(rs, type);
        }
        rs.close();

        request.setAttribute("priceGroupFormBean", this._priceGroupFormBean);
        return _priceGroupFormBean.getPriceGroupName();
    }

    private synchronized void _updatePriceGroup() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("update_priceGroup");

        PreparedStatement st = conn.prepareStatement(sql);

        int paramIndex = 1;
        st.setString(++paramIndex, _priceGroupFormBean.getPriceGroupName());
        st.setInt(++paramIndex, _priceGroupFormBean.getId());

        try
        {
            db.executeUpdatePreparedStatement(st);
        }catch (Exception MySQLIntegrityConstraintViolationException)
        {
            logger.error(MySQLIntegrityConstraintViolationException.getMessage(), MySQLIntegrityConstraintViolationException);
        }
        request.setAttribute("priceGroupFormBean", this._priceGroupFormBean);
    }

    public String searchPriceGroup() throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        
        String xml = null;
        String sql = Queries.getQuery("search_priceGroup");
        PreparedStatement stGet = conn.prepareStatement(sql);
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        xml = util.convertResultSetToXML(rs);
        return xml;
        
    }
}

