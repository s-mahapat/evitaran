
package IAS.Model.masterdata;

import javax.servlet.http.HttpServletRequest;
import IAS.Bean.masterdata.subGroupFormBean;
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
public class subGroupModel extends JDSModel{

    private subGroupFormBean _subGroupFormBean = null;
    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Model.masterdata");

    public subGroupModel(HttpServletRequest request) throws SQLException{

       super(request);

    }

    public synchronized void Save () throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException{

        subGroupFormBean subGroupFormBean = new IAS.Bean.masterdata.subGroupFormBean();
        request.setAttribute("subGroupFormBean", subGroupFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, subGroupFormBean);
        this._subGroupFormBean = subGroupFormBean;

        if (_subGroupFormBean.getId() != 0) {

            this._updateSubGroup();

        } else {

            String sql;

            // the query name from the jds_sql properties files in WEB-INF/properties folder
            sql = Queries.getQuery("subGroup_insert");

            PreparedStatement st = conn.prepareStatement(sql, com.mysql.jdbc.Statement.RETURN_GENERATED_KEYS);
            int paramIndex = 1;
            st.setString(++paramIndex, _subGroupFormBean.getSubGroupName());
            try
            {
            if (db.executeUpdatePreparedStatement(st) == 1) {
                    try (ResultSet rs = st.getGeneratedKeys()) {
                        while(rs.next()){
                            int i = rs.getInt(1);
                            //set the city id generated at the database
                            _subGroupFormBean.setId(i);
                        }
                    }
                }
            }catch (Exception MySQLIntegrityConstraintViolationException)
            {
                logger.error(MySQLIntegrityConstraintViolationException.getMessage(), MySQLIntegrityConstraintViolationException);
            }
            request.setAttribute("subGroupFormBean", this._subGroupFormBean);
        }
    }

    public String editSubGroup() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        return this.GetSubGroup();

    }

    public String viewSubGroup() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        return this.GetSubGroup();

    }

    public String GetSubGroup() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        subGroupFormBean subGroupFormBean = new IAS.Bean.masterdata.subGroupFormBean();
        request.setAttribute("subGroupFormBean", subGroupFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, subGroupFormBean);
        this._subGroupFormBean = subGroupFormBean;

        String sql;
        // the query name from the jds_sql properties files in WEB-INF/properties folder
        sql = Queries.getQuery("get_subGroup_by_id");

        PreparedStatement st = conn.prepareStatement(sql);

        st.setInt(1, _subGroupFormBean.getId());

        ResultSet rs = db.executeQueryPreparedStatement(st);
        // populate the bean from the resultset using the beanprocessor class
        while (rs.next()) { 
            BeanProcessor bProc = new BeanProcessor();
            Class type = Class.forName("IAS.Bean.masterdata.subGroupFormBean");
            this._subGroupFormBean = (IAS.Bean.masterdata.subGroupFormBean) bProc.toBean(rs, type);
        }
        rs.close();

        request.setAttribute("subGroupFormBean", this._subGroupFormBean);
        return _subGroupFormBean.getSubGroupName();
    }

    private synchronized void _updateSubGroup() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("update_subGroup");

        PreparedStatement st = conn.prepareStatement(sql);

        int paramIndex = 1;
        st.setString(++paramIndex, _subGroupFormBean.getSubGroupName());
        st.setInt(++paramIndex, _subGroupFormBean.getId());

        try
        {
            db.executeUpdatePreparedStatement(st);
        }catch (Exception MySQLIntegrityConstraintViolationException)
        {
            logger.error(MySQLIntegrityConstraintViolationException.getMessage(), MySQLIntegrityConstraintViolationException);
        }
        request.setAttribute("subGroupFormBean", this._subGroupFormBean);
    }

    public String searchSubGroup() throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        
        String xml = null;
        String sql = Queries.getQuery("search_subGroup");
        PreparedStatement stGet = conn.prepareStatement(sql);
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        xml = util.convertResultSetToXML(rs);
        return xml;
        
    }
}

