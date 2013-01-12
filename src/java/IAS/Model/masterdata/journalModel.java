
package IAS.Model.masterdata;

import javax.servlet.http.HttpServletRequest;
import IAS.Bean.masterdata.journalFormBean;
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
public class journalModel extends JDSModel{

    private journalFormBean _journalFormBean = null;
    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Model.masterdata");

    public journalModel(HttpServletRequest request) throws SQLException{

       super(request);

    }

    public synchronized void Save () throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException{

        journalFormBean journalFormBean = new IAS.Bean.masterdata.journalFormBean();
        request.setAttribute("journalFormBean", journalFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, journalFormBean);
        this._journalFormBean = journalFormBean;

        if (_journalFormBean.getId() != 0) {

            this._updateJournal();

        } else {

            String sql;

            // the query name from the jds_sql properties files in WEB-INF/properties folder
            sql = Queries.getQuery("journal_insert");

            PreparedStatement st = conn.prepareStatement(sql, com.mysql.jdbc.Statement.RETURN_GENERATED_KEYS);
            int paramIndex = 1;
            st.setString(paramIndex, _journalFormBean.getJournalCode());
            st.setString(++paramIndex, _journalFormBean.getJournalName());
            st.setString(++paramIndex, _journalFormBean.getIssnNo());
            st.setInt(++paramIndex, _journalFormBean.getStartYear());

            try
            {
            if (db.executeUpdatePreparedStatement(st) == 1) {
                    try (ResultSet rs = st.getGeneratedKeys()) {
                        while(rs.next()){
                            int i = rs.getInt(1);
                            //set the city id generated at the database
                            _journalFormBean.setId(i);
                        }
                    }
                }
            }catch (Exception MySQLIntegrityConstraintViolationException)
            {
                logger.error(MySQLIntegrityConstraintViolationException.getMessage(), MySQLIntegrityConstraintViolationException);
            }
            request.setAttribute("journalFormBean", this._journalFormBean);
        }
    }

    public String editJournal() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        return this.GetJournal();

    }

    public String viewJournal() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        return this.GetJournal();

    }

    public String GetJournal() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        journalFormBean journalFormBean = new IAS.Bean.masterdata.journalFormBean();
        request.setAttribute("journalFormBean", journalFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, journalFormBean);
        this._journalFormBean = journalFormBean;

        String sql;
        // the query name from the jds_sql properties files in WEB-INF/properties folder
        sql = Queries.getQuery("get_journal_by_id");

        PreparedStatement st = conn.prepareStatement(sql);

        st.setInt(1, _journalFormBean.getId());

        ResultSet rs = db.executeQueryPreparedStatement(st);
        // populate the bean from the resultset using the beanprocessor class
        while (rs.next()) {
            BeanProcessor bProc = new BeanProcessor();
            Class type = Class.forName("IAS.Bean.masterdata.journalFormBean");
            this._journalFormBean = (IAS.Bean.masterdata.journalFormBean) bProc.toBean(rs, type);
        }
        rs.close();

        request.setAttribute("journalFormBean", this._journalFormBean);
        return _journalFormBean.getJournalName();
    }

    private synchronized void _updateJournal() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("update_journal");

        PreparedStatement st = conn.prepareStatement(sql);

        int paramIndex = 1;
        st.setString(paramIndex, _journalFormBean.getJournalCode());
        st.setString(++paramIndex, _journalFormBean.getJournalName());
        st.setString(++paramIndex, _journalFormBean.getIssnNo());
        st.setInt(++paramIndex, _journalFormBean.getStartYear());
        st.setInt(++paramIndex, _journalFormBean.getId());

        try
        {
            db.executeUpdatePreparedStatement(st);
        }catch (Exception MySQLIntegrityConstraintViolationException)
        {
            logger.error(MySQLIntegrityConstraintViolationException.getMessage(), MySQLIntegrityConstraintViolationException);
        }
        request.setAttribute("journalFormBean", this._journalFormBean);
    }

    public String searchJournal() throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml = null;
        String sql = Queries.getQuery("search_journal");
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;

        String journalCode = request.getParameter("journalCode");
        String journalName = request.getParameter("journalName");

        if(!journalCode.isEmpty())
            stGet.setString(paramIndex++, "%" + journalCode + "%");
        else
            stGet.setString(paramIndex++, journalCode);

        if(!journalName.isEmpty())
            stGet.setString(paramIndex++, "%" + journalName + "%");
        else
            stGet.setString(paramIndex++, journalName);

        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        xml = util.convertResultSetToXML(rs);
        return xml;
    }
}

