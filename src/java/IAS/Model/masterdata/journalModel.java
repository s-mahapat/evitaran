/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.masterdata;

import javax.servlet.http.HttpServletRequest;
import IAS.Bean.masterdata.journalFormBean;
import IAS.Class.Database;
import javax.servlet.http.HttpSession;
import java.sql.*;
import IAS.Model.*;
import java.text.ParseException;
import IAS.Class.Queries;
import org.apache.commons.dbutils.BeanProcessor;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import IAS.Class.util;
/**
 *
 * @author Deepali
 */
public class journalModel extends JDSModel{
    private HttpServletRequest request = null;
    private journalFormBean _journalFormBean = null;
    private Connection conn = null;
    private Database db = null;
    private HttpSession session = null;

    public journalModel(HttpServletRequest request, journalFormBean _Bean) throws SQLException{
        this.request = request;
        this._journalFormBean = _Bean;
        this.session = request.getSession(false);
        if(this.session == null){
            throw(new SQLException("Database connection not found in the session"));
        }

        this.db = (Database)session.getAttribute("db_connection");
        this.conn = db.getConnection();

    }
    
    public void Save () throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException{

        //journalFormBean journalFormBean = new IAS.Bean.masterdata.journalFormBean();
        String sql;

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, _journalFormBean);    
        
        if (_journalFormBean.getJournalId() != 0) {
            
            this._updateJournal();
            
        } else {

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        sql = Queries.getQuery("journal_insert");

        PreparedStatement st = conn.prepareStatement(sql);
        int paramIndex = 1;
        st.setString(paramIndex, _journalFormBean.getJournalCode());
        st.setString(++paramIndex, _journalFormBean.getJournalName());
        st.setInt(++paramIndex, _journalFormBean.getIssnNo());
        st.setInt(++paramIndex, _journalFormBean.getPages());
        st.setInt(++paramIndex, _journalFormBean.getStartYear());
        st.setInt(++paramIndex, _journalFormBean.getIssues());
        db.executeUpdatePreparedStatement(st);
        
        sql = Queries.getQuery("get_journal_by_name");

        PreparedStatement stGet = conn.prepareStatement(sql);
        paramIndex = 1;
        stGet.setString(paramIndex, _journalFormBean.getJournalCode());
        stGet.setString(++paramIndex, _journalFormBean.getJournalName());
        stGet.setInt(++paramIndex, _journalFormBean.getIssnNo());
        stGet.setInt(++paramIndex, _journalFormBean.getPages());
        stGet.setInt(++paramIndex, _journalFormBean.getStartYear());
        stGet.setInt(++paramIndex, _journalFormBean.getIssues());
        ResultSet rs = db.executeQueryPreparedStatement(stGet);
        
        // populate the bean from the resultset using the beanprocessor class
        while (rs.next()) {
            
            BeanProcessor bProc = new BeanProcessor();
            Class type = Class.forName("IAS.Bean.masterdata.journalFormBean");
            this._journalFormBean = (IAS.Bean.masterdata.journalFormBean) bProc.toBean(rs, type);
        }
        rs.close(); 
        
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

        String sql;
        
        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, _journalFormBean);

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        sql = Queries.getQuery("get_journal_by_id");

        PreparedStatement st = conn.prepareStatement(sql);

        st.setInt(1, _journalFormBean.getJournalId());

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
    
    private void _updateJournal() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        // the query name from the jds_sql properties files in WEB-INF/properties folder
        String sql = Queries.getQuery("update_journal");

        PreparedStatement st = conn.prepareStatement(sql);

        int paramIndex = 1;
        st.setString(paramIndex, _journalFormBean.getJournalCode());
        st.setString(++paramIndex, _journalFormBean.getJournalName());
        st.setInt(++paramIndex, _journalFormBean.getIssnNo());
        st.setInt(++paramIndex, _journalFormBean.getPages());
        st.setInt(++paramIndex, _journalFormBean.getStartYear());
        st.setInt(++paramIndex, _journalFormBean.getIssues());
        st.setInt(++paramIndex, _journalFormBean.getJournalId());
        db.executeUpdatePreparedStatement(st);

        sql = Queries.getQuery("get_journal_by_id");

        PreparedStatement stGet = conn.prepareStatement(sql);
        paramIndex = 1;
        stGet.setInt(paramIndex, _journalFormBean.getJournalId());
        ResultSet rs = db.executeQueryPreparedStatement(stGet);
        
        // populate the bean from the resultset using the beanprocessor class
        while (rs.next()) {
            
            BeanProcessor bProc = new BeanProcessor();
            Class type = Class.forName("IAS.Bean.masterdata.journalFormBean");
            this._journalFormBean = (IAS.Bean.masterdata.journalFormBean) bProc.toBean(rs, type);
        }
        rs.close(); 
        
        request.setAttribute("journalFormBean", this._journalFormBean);
    }

    public String searchJournal() throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml = null;
        String sql = Queries.getQuery("search_journal");
        
        ResultSet rs = this.db.executeQuery(sql);

        xml = util.convertResultSetToXML(rs);

        return xml;
    }    
}        
       
