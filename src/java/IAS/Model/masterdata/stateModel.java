package IAS.Model.masterdata;

import IAS.Bean.masterdata.stateFormBean;
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
public class stateModel extends JDSModel {

    private stateFormBean _stateFormBean = null;
    private static final Logger logger = JDSLogger.getJDSLogger(stateModel.class.getName());

    public stateModel(HttpServletRequest request) throws SQLException {
        super(request);
    }

    public synchronized void Save() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

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

            try (Connection conn = this.getConnection(); PreparedStatement st = conn.prepareStatement(sql, com.mysql.jdbc.Statement.RETURN_GENERATED_KEYS)) {
                int paramIndex = 1;
                st.setString(paramIndex, _stateFormBean.getState());
                if (st.executeUpdate() == 1) {
                    try (ResultSet rs = st.getGeneratedKeys()) {
                        while (rs.next()) {
                            int i = rs.getInt(1);
                            //set the city id generated at the database
                            _stateFormBean.setId(i);
                        }
                    }
                }
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

        try (Connection conn = this.getConnection(); PreparedStatement st = conn.prepareStatement(sql)) {
            st.setInt(1, _stateFormBean.getId());
            // populate the bean from the resultset using the beanprocessor class
            try (ResultSet rs = st.executeQuery()) {
                // populate the bean from the resultset using the beanprocessor class
                while (rs.next()) {
                    BeanProcessor bProc = new BeanProcessor();
                    this._stateFormBean = (IAS.Bean.masterdata.stateFormBean) bProc.toBean(rs, IAS.Bean.masterdata.stateFormBean.class);
                }
            }
        }

        request.setAttribute("stateFormBean", this._stateFormBean);
        return _stateFormBean.getState();
    }

    private synchronized void _updateState() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("update_state");

        try (Connection conn = this.getConnection(); PreparedStatement st = conn.prepareStatement(sql)) {
            int paramIndex = 1;
            st.setString(paramIndex, _stateFormBean.getState());
            st.setInt(++paramIndex, _stateFormBean.getId());
            st.executeUpdate();
        }
        request.setAttribute("stateFormBean", this._stateFormBean);
    }

    public String searchState() throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml = null;
        String sql = Queries.getQuery("search_state");
        try (Connection conn = this.getConnection(); PreparedStatement stGet = conn.prepareStatement(sql)) {
            int paramIndex = 1;
            stGet.setString(paramIndex, "%" + request.getParameter("state") + "%");
            try (ResultSet rs = stGet.executeQuery()) {
                xml = util.convertResultSetToXML(rs);
            }
        }
        return xml;
    }
}
