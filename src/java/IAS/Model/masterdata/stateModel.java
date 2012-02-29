
package IAS.Model.masterdata;

import javax.servlet.http.HttpServletRequest;
import IAS.Bean.masterdata.stateFormBean;
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
public class stateModel extends JDSModel{

    private stateFormBean _stateFormBean = null;
    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Model.masterdata");

    public stateModel(HttpServletRequest request) throws SQLException{

        super(request);
    }

    public void Save () throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException{

        stateFormBean stateFormBean = new IAS.Bean.masterdata.stateFormBean();
        request.setAttribute("stateFormBean", stateFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, stateFormBean);
        this._stateFormBean = stateFormBean;

        if (_stateFormBean.getId() != 0) {

            this._updateState();

        } else {

            String sql;

            // the query name from the jds_sql properties files in WEB-INF/properties folder
            sql = Queries.getQuery("state_insert");

            PreparedStatement st = conn.prepareStatement(sql, com.mysql.jdbc.Statement.RETURN_GENERATED_KEYS);
            int paramIndex = 1;
            st.setString(paramIndex, _stateFormBean.getState());

            try
            {
                if (db.executeUpdatePreparedStatement(st) == 1) {
                    try (ResultSet rs = st.getGeneratedKeys()) {
                        while(rs.next()){
                            int i = rs.getInt(1);
                            //set the city id generated at the database
                            _stateFormBean.setId(i);
                        }
                    }
                }
            }catch (Exception MySQLIntegrityConstraintViolationException)
            {
                logger.error(MySQLIntegrityConstraintViolationException.getMessage(), MySQLIntegrityConstraintViolationException);
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

        stateFormBean stateFormBean = new IAS.Bean.masterdata.stateFormBean();
        request.setAttribute("stateFormBean", stateFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, stateFormBean);
        this._stateFormBean = stateFormBean;

        String sql;
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
        try
        {
            db.executeUpdatePreparedStatement(st);
        }catch (Exception MySQLIntegrityConstraintViolationException)
        {
            logger.error(MySQLIntegrityConstraintViolationException.getMessage(), MySQLIntegrityConstraintViolationException);
        }
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

