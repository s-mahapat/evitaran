
package IAS.Model.masterdata;

import java.lang.reflect.InvocationTargetException;
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

        /*
        if (_printOrderFormBean.getId() != 0) {

            this._updatePrintOrder();

        } else {

            String sql;

            // the query name from the jds_sql properties files in WEB-INF/properties folder
            sql = Queries.getQuery("printOrder_insert");

            PreparedStatement st = conn.prepareStatement(sql, com.mysql.jdbc.Statement.RETURN_GENERATED_KEYS);

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
        */
    }

    //public String editPrintOrder() throws SQLException, ParseException,
    public void editPrintOrder() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException, ParserConfigurationException, TransformerException {

        this.GetPrintOrder();

    }

    //public String viewPrintOrder() throws SQLException, ParseException,
    public void viewPrintOrder() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException, ParserConfigurationException, TransformerException {

        this.GetPrintOrder();

    }

    //public String GetPrintOrder() throws SQLException, ParseException,
    public void GetPrintOrder() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException, ParserConfigurationException, TransformerException {

        printOrderFormBean printOrderFormBean = new IAS.Bean.masterdata.printOrderFormBean();
        request.setAttribute("printOrderFormBean", printOrderFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, printOrderFormBean);
        this._printOrderFormBean = printOrderFormBean;

        String sql;
        // the query name from the jds_sql properties files in WEB-INF/properties folder
        sql = Queries.getQuery("get_print_order_by_year");

        PreparedStatement st = conn.prepareStatement(sql);
        String year = request.getParameter("selectedYear");

        st.setInt(1, Integer.valueOf(year));

        ResultSet rs = this.db.executeQueryPreparedStatement(st);
        /*
        String xml = null;
        xml = util.convertResultSetToXML(rs);
        return xml;
         */

        // populate the bean from the resultset using the beanprocessor class
        /*
        while (rs.next()) {
            BeanProcessor bProc = new BeanProcessor();
            Class type = Class.forName("IAS.Bean.masterdata.printOrderFormBean");
            this._printOrderFormBean = (IAS.Bean.masterdata.printOrderFormBean) bProc.toBean(rs, type);
        }
         */
        rs.close();

        request.setAttribute("printOrderFormBean", this._printOrderFormBean);
        //return _printOrderFormBean.getPrintOrderName();
    }

    private synchronized void _updatePrintOrder() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("update_printOrder");

        PreparedStatement st = conn.prepareStatement(sql);

        int paramIndex = 1;
        /*
        st.setString(paramIndex, _printOrderFormBean.getPrintOrderCode());
        st.setString(++paramIndex, _printOrderFormBean.getPrintOrderName());
        st.setString(++paramIndex, _printOrderFormBean.getIssnNo());
        st.setInt(++paramIndex, _printOrderFormBean.getPages());
        st.setInt(++paramIndex, _printOrderFormBean.getStartYear());
        st.setInt(++paramIndex, _printOrderFormBean.getIssues());
        st.setInt(++paramIndex, _printOrderFormBean.getId());
         *
         */
        try
        {
            db.executeUpdatePreparedStatement(st);
        }catch (Exception MySQLIntegrityConstraintViolationException)
        {
            logger.error(MySQLIntegrityConstraintViolationException.getMessage(), MySQLIntegrityConstraintViolationException);
        }
        request.setAttribute("printOrderFormBean", this._printOrderFormBean);
    }

    public String searchPrintOrders() throws SQLException, ParseException, ParserConfigurationException, TransformerException, IllegalAccessException, InvocationTargetException {

        printOrderFormBean printOrderFormBean = new IAS.Bean.masterdata.printOrderFormBean();
        request.setAttribute("printOrderFormBean", printOrderFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, printOrderFormBean);
        this._printOrderFormBean = printOrderFormBean;

        request.setAttribute("printOrderFormBean", this._printOrderFormBean);

        String xml = null;
        String sql = Queries.getQuery("get_year");
        PreparedStatement stGet = conn.prepareStatement(sql);

        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        xml = util.convertResultSetToXML(rs);
        //xml = util.convertResultSetWithoutIDToXML(rs);
        return xml;
    }

    public String getPrintOrder() throws SQLException, ParseException, ParserConfigurationException, TransformerException, IllegalAccessException, InvocationTargetException {

        printOrderFormBean printOrderFormBean = new IAS.Bean.masterdata.printOrderFormBean();
        request.setAttribute("printOrderFormBean", printOrderFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, printOrderFormBean);
        this._printOrderFormBean = printOrderFormBean;

        request.setAttribute("printOrderFormBean", this._printOrderFormBean);

        String xml = null;
        String sql = Queries.getQuery("get_print_order_by_year");

        PreparedStatement st = conn.prepareStatement(sql);
        String year = request.getParameter("selectedYear");

        st.setInt(1, Integer.valueOf(year));

        ResultSet rs = this.db.executeQueryPreparedStatement(st);
        xml = util.convertResultSetToXML(rs);
        //xml = util.convertResultSetWithoutIDToXML(rs);
        return xml;
    }
}

