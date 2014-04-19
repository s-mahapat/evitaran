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
    private static final Logger logger = JDSLogger.getJDSLogger(IAS.Model.masterdata.annualSubscriptionRateModel.class.getName());

    public annualSubscriptionRateModel(HttpServletRequest request) throws SQLException {
        super(request);
    }

    public synchronized void save() throws IllegalAccessException, InvocationTargetException, SQLException {
        annualSubscriptionRateFormBean annualSubscriptionRateFormBean = new IAS.Bean.masterdata.annualSubscriptionRateFormBean();
        request.setAttribute("annualSubscriptionRateFormBean", annualSubscriptionRateFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, annualSubscriptionRateFormBean);
        this._annualSubscriptionRateFormBean = annualSubscriptionRateFormBean;

        String sql = Queries.getQuery("update_printOrder");
        try (Connection conn = this.getConnection(); PreparedStatement st = conn.prepareStatement(sql)) {
            int paramIndex = 1;
            int success = st.executeUpdate();
        } catch (Exception MySQLIntegrityConstraintViolationException) {
            logger.error(MySQLIntegrityConstraintViolationException.getMessage(), MySQLIntegrityConstraintViolationException);
        }
        request.setAttribute("printOrderFormBean", this._annualSubscriptionRateFormBean);

    }

    public synchronized String addAndSearch() throws SQLException, ParseException, ParserConfigurationException, TransformerException {

        // First check if the entry exist
        String sql = Queries.getQuery("check_subRate");
        String xml = null;
        try (Connection conn = this.getConnection(); PreparedStatement stGet = conn.prepareStatement(sql)) {
            int paramIndex = 1;
            stGet.setString(paramIndex, request.getParameter("journalGroupName"));
            stGet.setString(++paramIndex, request.getParameter("subscriberType"));
            stGet.setString(++paramIndex, request.getParameter("year"));
            stGet.setString(++paramIndex, request.getParameter("noofYear"));
            //stGet.setString(++paramIndex, request.getParameter("rate"));
            try (ResultSet rs = stGet.executeQuery()) {
                // If the entry does not exist, then add to the db
                if (!rs.next()) {
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

            }

            // Now run the search query and display
            xml = search();
        } finally {
            return xml;
        }
    }

    public String search() throws SQLException, ParseException, ParserConfigurationException, TransformerException {

        String xml;
        String sql = Queries.getQuery("search_subRate");
        try (Connection conn = this.getConnection(); PreparedStatement stGet = conn.prepareStatement(sql)) {
            int paramIndex = 1;
            stGet.setString(paramIndex, request.getParameter("year"));
            stGet.setString(++paramIndex, request.getParameter("journalGroupName"));
            stGet.setString(++paramIndex, request.getParameter("subscriberType"));
            try (ResultSet rs = stGet.executeQuery()) {
                xml = util.convertResultSetToXML(rs);
            }
        }
        return xml;
    }

    public String add() throws IllegalAccessException, InvocationTargetException, SQLException, ParserConfigurationException, TransformerException {

        annualSubscriptionRateFormBean annualSubscriptionRateFormBean = new IAS.Bean.masterdata.annualSubscriptionRateFormBean();
        request.setAttribute("annualSubscriptionRateFormBean", annualSubscriptionRateFormBean);
        String xml;
        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, annualSubscriptionRateFormBean);
        this._annualSubscriptionRateFormBean = annualSubscriptionRateFormBean;

        request.setAttribute("printOrderFormBean", this._annualSubscriptionRateFormBean);

        String sql = Queries.getQuery("update_printOrder");
        try (Connection conn = this.getConnection(); ResultSet rs = conn.prepareStatement(sql).executeQuery()) {
            xml = util.convertResultSetToXML(rs);
        }

        return xml;
    }

}
