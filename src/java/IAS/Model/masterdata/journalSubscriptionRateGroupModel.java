package IAS.Model.masterdata;

import IAS.Bean.masterdata.journalSubscriptionRateGroupFormBean;
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

/**
 *
 * @author aloko
 */
public class journalSubscriptionRateGroupModel extends JDSModel {

    private journalSubscriptionRateGroupFormBean _journalSubscriptionRateGroupFormBean = null;
    private static final Logger logger = JDSLogger.getJDSLogger(journalSubscriptionRateGroupModel.class.getName());

    public journalSubscriptionRateGroupModel(HttpServletRequest request) throws SQLException {
        super(request);
    }

    public synchronized void save() throws IllegalAccessException, InvocationTargetException, SQLException {
        journalSubscriptionRateGroupFormBean journalSubscriptionRateGroupFormBean = new IAS.Bean.masterdata.journalSubscriptionRateGroupFormBean();
        request.setAttribute("journalSubscriptionRateGroupFormBean", journalSubscriptionRateGroupFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, journalSubscriptionRateGroupFormBean);
        this._journalSubscriptionRateGroupFormBean = journalSubscriptionRateGroupFormBean;

        String sql = Queries.getQuery("update_printOrder");

        try (Connection conn = this.getConnection(); PreparedStatement st = conn.prepareStatement(sql)) {

            //int paramIndex = 1;
            st.executeUpdate();
        } catch (Exception MySQLIntegrityConstraintViolationException) {
            logger.error(MySQLIntegrityConstraintViolationException.getMessage(), MySQLIntegrityConstraintViolationException);
        }
        request.setAttribute("printOrderFormBean", this._journalSubscriptionRateGroupFormBean);

    }

    public String search() throws IllegalAccessException, InvocationTargetException, SQLException, ParserConfigurationException, TransformerException {
        journalSubscriptionRateGroupFormBean journalSubscriptionRateGroupFormBean = new IAS.Bean.masterdata.journalSubscriptionRateGroupFormBean();
        request.setAttribute("journalSubscriptionRateGroupFormBean", journalSubscriptionRateGroupFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, journalSubscriptionRateGroupFormBean);
        this._journalSubscriptionRateGroupFormBean = journalSubscriptionRateGroupFormBean;

        request.setAttribute("printOrderFormBean", this._journalSubscriptionRateGroupFormBean);

        String sql = Queries.getQuery("update_printOrder");
        String xml;
        try (Connection conn = this.getConnection(); PreparedStatement st = conn.prepareStatement(sql)) {
            try (ResultSet rs = st.executeQuery()) {
                xml = util.convertResultSetToXML(rs);
            }
        }
        return xml;
    }

    public String add() throws IllegalAccessException, InvocationTargetException, SQLException, ParserConfigurationException, TransformerException {

        journalSubscriptionRateGroupFormBean journalSubscriptionRateGroupFormBean = new IAS.Bean.masterdata.journalSubscriptionRateGroupFormBean();
        request.setAttribute("journalSubscriptionRateGroupFormBean", journalSubscriptionRateGroupFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, journalSubscriptionRateGroupFormBean);
        this._journalSubscriptionRateGroupFormBean = journalSubscriptionRateGroupFormBean;

        request.setAttribute("printOrderFormBean", this._journalSubscriptionRateGroupFormBean);
        String xml;
        String sql = Queries.getQuery("update_printOrder");
        try (Connection conn = this.getConnection(); ResultSet rs = conn.prepareStatement(sql).executeQuery()) {
            xml = util.convertResultSetToXML(rs);
        }
        return xml;
    }

}
