package IAS.Model.masterdata;

import IAS.Bean.masterdata.subTypeFormBean;
import IAS.Class.JDSLogger;
import IAS.Class.Queries;
import IAS.Class.util;
import IAS.Model.*;
import java.sql.*;
import java.text.ParseException;
import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import org.apache.commons.dbutils.BeanProcessor;
import org.apache.log4j.Logger;

/**
 *
 * @author Deepali
 */
public class subTypeModel extends JDSModel {

    private subTypeFormBean _subTypeFormBean = null;
    private static final Logger logger = JDSLogger.getJDSLogger(subTypeModel.class.getName());

    public subTypeModel(HttpServletRequest request) throws SQLException {
        super(request);
    }

    public synchronized void Save() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        subTypeFormBean subTypeFormBean = new IAS.Bean.masterdata.subTypeFormBean();
        request.setAttribute("subTypeFormBean", subTypeFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, subTypeFormBean);
        this._subTypeFormBean = subTypeFormBean;

        if (_subTypeFormBean.getId() != 0) {

            this._updateSubType();

        } else {

            String sql;

            // the query name from the jds_sql properties files in WEB-INF/properties folder
            sql = Queries.getQuery("subType_insert");

            try (Connection conn = this.getConnection(); PreparedStatement st = conn.prepareStatement(sql, com.mysql.jdbc.Statement.RETURN_GENERATED_KEYS);) {
                int paramIndex = 1;
                st.setString(paramIndex, _subTypeFormBean.getSubtypecode());
                st.setString(++paramIndex, _subTypeFormBean.getSubtypedesc());
                st.setString(++paramIndex, _subTypeFormBean.getSubtype());
                st.setString(++paramIndex, _subTypeFormBean.getNationality());
                st.setString(++paramIndex, _subTypeFormBean.getInstitutional());
                st.setInt(++paramIndex, _subTypeFormBean.getFreejrnl());
                st.setInt(++paramIndex, _subTypeFormBean.getDiscount());
                if (st.executeUpdate() == 1) {
                    try (ResultSet rs = st.getGeneratedKeys()) {
                        while (rs.next()) {
                            int i = rs.getInt(1);
                            //set the city id generated at the database
                            _subTypeFormBean.setId(i);
                        }
                    }
                }

            } catch (Exception MySQLIntegrityConstraintViolationException) {
                logger.error(MySQLIntegrityConstraintViolationException.getMessage(), MySQLIntegrityConstraintViolationException);
            }
            request.setAttribute("subTypeFormBean", this._subTypeFormBean);
        }
    }

    public String editSubType() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        return this.GetSubType();

    }

    public String viewSubType() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        return this.GetSubType();

    }

    public String GetSubType() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        subTypeFormBean subTypeFormBean = new IAS.Bean.masterdata.subTypeFormBean();
        request.setAttribute("subTypeFormBean", subTypeFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, subTypeFormBean);
        this._subTypeFormBean = subTypeFormBean;

        String sql;
        // the query name from the jds_sql properties files in WEB-INF/properties folder
        sql = Queries.getQuery("get_subType_by_id");

        try (Connection conn = this.getConnection(); PreparedStatement st = conn.prepareStatement(sql)) {

            st.setInt(1, _subTypeFormBean.getId());

            // populate the bean from the resultset using the beanprocessor class
            try (ResultSet rs = st.executeQuery()) {
                // populate the bean from the resultset using the beanprocessor class
                while (rs.next()) {
                    BeanProcessor bProc = new BeanProcessor();
                    Class type = Class.forName("IAS.Bean.masterdata.subTypeFormBean");
                    this._subTypeFormBean = (IAS.Bean.masterdata.subTypeFormBean) bProc.toBean(rs, type);
                }
            }
        }

        request.setAttribute("subTypeFormBean", this._subTypeFormBean);
        return _subTypeFormBean.getSubtypedesc();
    }

    private synchronized void _updateSubType() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("update_subType");

        try (Connection conn = this.getConnection(); PreparedStatement st = conn.prepareStatement(sql);) {
            int paramIndex = 1;
            st.setString(paramIndex, _subTypeFormBean.getSubtypecode());
            st.setString(++paramIndex, _subTypeFormBean.getSubtypedesc());
            st.setString(++paramIndex, _subTypeFormBean.getSubtype());
            st.setString(++paramIndex, _subTypeFormBean.getNationality());
            st.setString(++paramIndex, _subTypeFormBean.getInstitutional());
            st.setInt(++paramIndex, _subTypeFormBean.getFreejrnl());
            st.setInt(++paramIndex, _subTypeFormBean.getDiscount());
            st.setInt(++paramIndex, _subTypeFormBean.getId());
            st.executeUpdate();
        } catch (Exception MySQLIntegrityConstraintViolationException) {
            logger.error(MySQLIntegrityConstraintViolationException.getMessage(), MySQLIntegrityConstraintViolationException);
        }
        request.setAttribute("subTypeFormBean", this._subTypeFormBean);
    }

    public String searchSubType() throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml;
        String sql = Queries.getQuery("search_subType");
        try (Connection conn = this.getConnection(); PreparedStatement stGet = conn.prepareStatement(sql);) {
            int paramIndex = 1;
            String subtypecode = request.getParameter("subtypecode");
            String subtype = request.getParameter("subtype");

            if (!subtypecode.isEmpty()) {
                stGet.setString(paramIndex++, "%" + subtypecode + "%");
            } else {
                stGet.setString(paramIndex++, subtypecode);
            }

            if (!subtype.isEmpty()) {
                stGet.setString(paramIndex++, "%" + subtype + "%");
            } else {
                stGet.setString(paramIndex++, subtype);
            }

            try (ResultSet rs = stGet.executeQuery()) {
                xml = util.convertResultSetToXML(rs);
            }
        }

        return xml;
    }

}
