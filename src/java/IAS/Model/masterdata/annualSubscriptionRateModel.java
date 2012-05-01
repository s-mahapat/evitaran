
package IAS.Model.masterdata;

import IAS.Bean.masterdata.annualSubscriptionRateFormBean;
import IAS.Model.JDSModel;
import java.lang.reflect.InvocationTargetException;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import org.apache.log4j.Logger;
import IAS.Class.JDSLogger;
import javax.servlet.http.HttpServletRequest;
import java.sql.*;
import IAS.Class.Queries;
import IAS.Class.util;
import javax.xml.parsers.ParserConfigurationException;
import java.text.ParseException;

/**
 *
 * @author aloko
 */
public class annualSubscriptionRateModel extends JDSModel {

    private annualSubscriptionRateFormBean _annualSubscriptionRateFormBean = null;
    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Model.masterdata");

    public annualSubscriptionRateModel(HttpServletRequest request) throws SQLException{

       super(request);

    }

    public synchronized void save () throws IllegalAccessException, InvocationTargetException, SQLException{
        annualSubscriptionRateFormBean annualSubscriptionRateFormBean = new IAS.Bean.masterdata.annualSubscriptionRateFormBean();
        request.setAttribute("annualSubscriptionRateFormBean", annualSubscriptionRateFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, annualSubscriptionRateFormBean);
        this._annualSubscriptionRateFormBean = annualSubscriptionRateFormBean;

        String sql = Queries.getQuery("update_printOrder");

        PreparedStatement st = conn.prepareStatement(sql);

        int paramIndex = 1;

        //st.setInt(paramIndex, _printOrderFormBean.getPrintOrder());

        try
        {
            int success = db.executeUpdatePreparedStatement(st);
        }catch (Exception MySQLIntegrityConstraintViolationException)
        {
            logger.error(MySQLIntegrityConstraintViolationException.getMessage(), MySQLIntegrityConstraintViolationException);
        }
        request.setAttribute("printOrderFormBean", this._annualSubscriptionRateFormBean);

    }
    
    public synchronized String addAndSearch()  throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        
        // First check if the entry exist
        String sql = Queries.getQuery("check_subRate");
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;
        stGet.setString(paramIndex, request.getParameter("journalGroupName"));
        stGet.setString(++paramIndex, request.getParameter("subscriberType"));
        stGet.setString(++paramIndex, request.getParameter("year"));
        stGet.setString(++paramIndex, request.getParameter("noofYear"));
        //stGet.setString(++paramIndex, request.getParameter("rate"));
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        // If the entry does not exist, then add to the db
        if(!rs.next())
        {
            sql = Queries.getQuery("add_subRate");
            PreparedStatement stAdd = conn.prepareStatement(sql);
            paramIndex = 1;
            stAdd.setString(paramIndex, request.getParameter("journalGroupName"));
            stAdd.setString(++paramIndex, request.getParameter("subscriberType"));
            stAdd.setString(++paramIndex, request.getParameter("year"));
            stAdd.setString(++paramIndex, request.getParameter("noofYear"));
            stAdd.setString(++paramIndex, request.getParameter("rate"));
            int success = db.executeUpdatePreparedStatement(stAdd);
            //rs = this.db.executeQueryPreparedStatement(stAdd);
        }
        
        // Now run the search query and display
        String xml = search();
        return xml;
    }

    public String search()  throws SQLException, ParseException, ParserConfigurationException, TransformerException {

        String xml = null;
        String sql = Queries.getQuery("search_subRate");
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;
        stGet.setString(paramIndex, request.getParameter("year"));
        stGet.setString(++paramIndex, request.getParameter("journalGroupName"));
        stGet.setString(++paramIndex, request.getParameter("subscriberType"));
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        xml = util.convertResultSetToXML(rs);
        return xml;
    }

    public String add() throws IllegalAccessException, InvocationTargetException, SQLException, ParserConfigurationException, TransformerException {

        annualSubscriptionRateFormBean annualSubscriptionRateFormBean = new IAS.Bean.masterdata.annualSubscriptionRateFormBean();
        request.setAttribute("annualSubscriptionRateFormBean", annualSubscriptionRateFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, annualSubscriptionRateFormBean);
        this._annualSubscriptionRateFormBean = annualSubscriptionRateFormBean;

        request.setAttribute("printOrderFormBean", this._annualSubscriptionRateFormBean);

        String sql = Queries.getQuery("update_printOrder");

        PreparedStatement st = conn.prepareStatement(sql);
        //st.setInt(1, this._annualSubscriptionRateFormBean.getYear());

        ResultSet rs = this.db.executeQueryPreparedStatement(st);
        String xml = null;
        xml = util.convertResultSetToXML(rs);
        return xml;
    }

}