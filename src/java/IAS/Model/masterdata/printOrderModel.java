
package IAS.Model.masterdata;

import javax.servlet.http.HttpServletRequest;
import IAS.Bean.masterdata.printOrderFormBean;
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
public class printOrderModel extends JDSModel{

    private printOrderFormBean _printOrderFormBean = null;
    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Model.masterdata");

    public printOrderModel(HttpServletRequest request) throws SQLException{

       super(request);

    }

    public synchronized void Save () throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException{

        printOrderFormBean printOrderFormBean = new IAS.Bean.masterdata.printOrderFormBean();
        request.setAttribute("printOrderFormBean", printOrderFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, printOrderFormBean);
        this._printOrderFormBean = printOrderFormBean;

        if (_printOrderFormBean.getId() != 0) {

            this._updatePrintOrder();

        } else {

            String sql;

            // the query name from the jds_sql properties files in WEB-INF/properties folder
            sql = Queries.getQuery("printOrder_insert");

            PreparedStatement st = conn.prepareStatement(sql, com.mysql.jdbc.Statement.RETURN_GENERATED_KEYS);
            int paramIndex = 1;
            st.setString(paramIndex, _printOrderFormBean.getPrintOrderCode());
            st.setString(++paramIndex, _printOrderFormBean.getPrintOrderName());
            st.setString(++paramIndex, _printOrderFormBean.getIssnNo());
            st.setInt(++paramIndex, _printOrderFormBean.getPages());
            st.setInt(++paramIndex, _printOrderFormBean.getStartYear());
            st.setInt(++paramIndex, _printOrderFormBean.getIssues());

            try
            {
            if (db.executeUpdatePreparedStatement(st) == 1) {
                    try (ResultSet rs = st.getGeneratedKeys()) {
                        while(rs.next()){
                            int i = rs.getInt(1);
                            //set the city id generated at the database
                            _printOrderFormBean.setId(i);
                        }
                    }
                }
            }catch (Exception MySQLIntegrityConstraintViolationException)
            {
                logger.error(MySQLIntegrityConstraintViolationException.getMessage(), MySQLIntegrityConstraintViolationException);
            }
            request.setAttribute("printOrderFormBean", this._printOrderFormBean);
        }
    }

    public String editPrintOrder() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        return this.GetPrintOrder();

    }

    public String viewPrintOrder() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        return this.GetPrintOrder();

    }

    public String GetPrintOrder() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        printOrderFormBean printOrderFormBean = new IAS.Bean.masterdata.printOrderFormBean();
        request.setAttribute("printOrderFormBean", printOrderFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, printOrderFormBean);
        this._printOrderFormBean = printOrderFormBean;

        String sql;
        // the query name from the jds_sql properties files in WEB-INF/properties folder
        sql = Queries.getQuery("get_printOrder_by_id");

        PreparedStatement st = conn.prepareStatement(sql);

        st.setInt(1, _printOrderFormBean.getId());

        ResultSet rs = db.executeQueryPreparedStatement(st);
        // populate the bean from the resultset using the beanprocessor class
        while (rs.next()) {
            BeanProcessor bProc = new BeanProcessor();
            Class type = Class.forName("IAS.Bean.masterdata.printOrderFormBean");
            this._printOrderFormBean = (IAS.Bean.masterdata.printOrderFormBean) bProc.toBean(rs, type);
        }
        rs.close();

        request.setAttribute("printOrderFormBean", this._printOrderFormBean);
        return _printOrderFormBean.getPrintOrderName();
    }

    private synchronized void _updatePrintOrder() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("update_printOrder");

        PreparedStatement st = conn.prepareStatement(sql);

        int paramIndex = 1;
        st.setString(paramIndex, _printOrderFormBean.getPrintOrderCode());
        st.setString(++paramIndex, _printOrderFormBean.getPrintOrderName());
        st.setString(++paramIndex, _printOrderFormBean.getIssnNo());
        st.setInt(++paramIndex, _printOrderFormBean.getPages());
        st.setInt(++paramIndex, _printOrderFormBean.getStartYear());
        st.setInt(++paramIndex, _printOrderFormBean.getIssues());
        st.setInt(++paramIndex, _printOrderFormBean.getId());

        try
        {
            db.executeUpdatePreparedStatement(st);
        }catch (Exception MySQLIntegrityConstraintViolationException)
        {
            logger.error(MySQLIntegrityConstraintViolationException.getMessage(), MySQLIntegrityConstraintViolationException);
        }
        request.setAttribute("printOrderFormBean", this._printOrderFormBean);
    }

    public String searchYear() throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml = null;
        String sql = Queries.getQuery("get_year");
        PreparedStatement stGet = conn.prepareStatement(sql);

        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        xml = util.convertResultSetToXML(rs);
        return xml;
    }
}

