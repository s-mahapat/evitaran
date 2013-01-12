package IAS.Model.masterdata;

import IAS.Bean.masterdata.journalDetailsFormBean;
import IAS.Class.JDSLogger;
import IAS.Class.Queries;
import IAS.Model.JDSModel;
import java.lang.reflect.InvocationTargetException;
import java.sql.*;
import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import org.apache.log4j.Logger;

/**
 *
 * @author aloko
 */
public class journalDetailsModel extends JDSModel{

    private journalDetailsFormBean _journalDetailsFormBean = null;
    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Model.masterdata");

    public journalDetailsModel(HttpServletRequest request) throws SQLException{

       super(request);

    }

    public String getMonths() throws SQLException {

        String xml;

        // Get the list of journals
        String sql = Queries.getQuery("get_months");
        PreparedStatement st = conn.prepareStatement(sql);
        ResultSet rs = this.db.executeQueryPreparedStatement(st);
        xml = "<select>";
        while (rs.next()){
            //for(int i=1; i<=12; i++){
                String month = rs.getString(1);
                xml = xml + "<option value=" + "'" + month + "'>" + month + "</option>";
            //}
        }
        xml = xml + "</select>";
        return xml;
    }

    public void saveJournalVolumeDetails()throws IllegalAccessException, InvocationTargetException, SQLException{
        journalDetailsFormBean journalDetailsFormBean = new IAS.Bean.masterdata.journalDetailsFormBean();
        request.setAttribute("journalDetailsFormBean", journalDetailsFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, journalDetailsFormBean);
        this._journalDetailsFormBean = journalDetailsFormBean;

        // If the journal_volume_details_id exists, then update with new details
        // If the journal_volume_details_id does not exist, then insert
        if(_journalDetailsFormBean.getVid() == 0){

            String query = Queries.getQuery("insert_journal_volume_details");
            PreparedStatement pst = conn.prepareStatement(query);

            int index = 1;
            pst.setString(index++, _journalDetailsFormBean.getJournalName());
            pst.setInt(index++, _journalDetailsFormBean.getYear());
            pst.setInt(index++, _journalDetailsFormBean.getVolume_number());
            pst.setString(index++, _journalDetailsFormBean.getStart_month());

            db.executeUpdatePreparedStatement(pst);

        }else {
            String sql = Queries.getQuery("update_journal_volume_details");
            PreparedStatement st = conn.prepareStatement(sql);
            int paramIndex = 1;
            st.setInt(paramIndex++, _journalDetailsFormBean.getVolume_number());
            st.setString(paramIndex++, _journalDetailsFormBean.getStart_month());
            st.setInt(paramIndex++, _journalDetailsFormBean.getVid());
            int success = db.executeUpdatePreparedStatement(st);

        }

        request.setAttribute("journalDetailsFormBean", this._journalDetailsFormBean);
    }

    public void save() throws IllegalAccessException, InvocationTargetException, SQLException{
        journalDetailsFormBean journalDetailsFormBean = new IAS.Bean.masterdata.journalDetailsFormBean();
        request.setAttribute("journalDetailsFormBean", journalDetailsFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, journalDetailsFormBean);
        this._journalDetailsFormBean = journalDetailsFormBean;

        // Get the ID if present in the journal_details table
        String sql = Queries.getQuery("check_if_journal_details_exist");
        PreparedStatement st = conn.prepareStatement(sql);
        int paramIndex = 1;
        st.setString(paramIndex++, _journalDetailsFormBean.getJournalName());
        st.setInt(paramIndex++, _journalDetailsFormBean.getYear());
        ResultSet rs = db.executeQueryPreparedStatement(st);
        // Update the journal_details table if it exists, else it means it is a new entry in the journal_details table
        if(rs.next()){
            int journalDetailsId = rs.getInt(1);
            sql = Queries.getQuery("update_journal_details");
            st = conn.prepareStatement(sql);
            paramIndex = 1;
            st.setString(paramIndex++, _journalDetailsFormBean.getPages());
            st.setInt(paramIndex++, _journalDetailsFormBean.getIssues());
            st.setString(paramIndex++, _journalDetailsFormBean.getPage_size());
            st.setInt(paramIndex++, _journalDetailsFormBean.getNo_of_volumes());
            st.setInt(paramIndex++, journalDetailsId);
            int success = db.executeUpdatePreparedStatement(st);
        } else {

            int journalId=0;

            String query = Queries.getQuery("insert_journal_details");
            PreparedStatement pst = conn.prepareStatement(query);

            int index = 1;
            pst.setString(index++, _journalDetailsFormBean.getJournalName());
            pst.setInt(index++, _journalDetailsFormBean.getYear());
            pst.setString(index++, _journalDetailsFormBean.getPages());
            pst.setInt(index++, _journalDetailsFormBean.getIssues());
            pst.setString(index++, _journalDetailsFormBean.getPage_size());
            pst.setInt(index++, _journalDetailsFormBean.getNo_of_volumes());

            db.executeUpdatePreparedStatement(pst);
        }

        request.setAttribute("journalDetailsFormBean", this._journalDetailsFormBean);
    }

    public String searchJournalVolumeDetails() throws SQLException, IllegalAccessException, InvocationTargetException, ParserConfigurationException, TransformerException{
        journalDetailsFormBean journalDetailsFormBean = new IAS.Bean.masterdata.journalDetailsFormBean();
        request.setAttribute("journalDetailsFormBean", journalDetailsFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, journalDetailsFormBean);
        this._journalDetailsFormBean = journalDetailsFormBean;

        int year = _journalDetailsFormBean.getYear();
        String journalName = _journalDetailsFormBean.getJournalName();

        String xml = "";
        xml = xml + "<?xml version='1.0' encoding='utf-8'?>\n";
        xml = xml + "<results>";

        // For the selected year and journal get the journal_detail ID
        String sql = Queries.getQuery("get_journal_details_id");
        PreparedStatement st = conn.prepareStatement(sql);
        int paramIndex = 1;
        st.setString(paramIndex++, _journalDetailsFormBean.getJournalName());
        st.setInt(paramIndex++, _journalDetailsFormBean.getYear());
        ResultSet rs = db.executeQueryPreparedStatement(st);
        // If the journal_details_id exists, then check if the journal_volume_details exist
        // If the journal_volume_details exist, then extract information and send
        // If the journal_volume_details do not exist, then send blank information
        if(rs.next()){
            int journalDetailsId = rs.getInt(1);
            int no_of_volumes = rs.getInt(2);

            sql = Queries.getQuery("get_journal_volume_details");
            st = conn.prepareStatement(sql);
            st.setInt(1, journalDetailsId);
            ResultSet rs1 = this.db.executeQueryPreparedStatement(st);
            for(int i=0; i<no_of_volumes; i++) {
                // if the journal_volume_details do not exist, then send blank information
                int id = 0;
                int volume_number = 0;
                String start_month = "";
                if(rs1.next()){
                    id = rs1.getInt(1);
                    volume_number = rs1.getInt(2);
                    start_month = rs1.getString(3);
                }
                xml = xml + "<row>";
                xml = xml + "<vid>" + id + "</vid>";
                xml = xml + "<journalName>" + journalName + "</journalName>";
                xml = xml + "<no_of_volumes>" + no_of_volumes + "</no_of_volumes>";
                xml = xml + "<volume_number>" + volume_number + "</volume_number>";
                xml = xml + "<start_month>" + start_month + "</start_month>";
                xml = xml + "</row>";
            }
        }else {
            // Since journal_detail itself does not exist, do not send back anything
        }
        xml = xml + "</results>";


        request.setAttribute("journalDetailsFormBean", this._journalDetailsFormBean);
        return xml;

    }

    public String searchJournalDetails() throws SQLException, IllegalAccessException, InvocationTargetException, ParserConfigurationException, TransformerException{
        journalDetailsFormBean journalDetailsFormBean = new IAS.Bean.masterdata.journalDetailsFormBean();
        request.setAttribute("journalDetailsFormBean", journalDetailsFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, journalDetailsFormBean);
        this._journalDetailsFormBean = journalDetailsFormBean;

        int year = _journalDetailsFormBean.getYear();

        String xml = "";
        xml = xml + "<?xml version='1.0' encoding='utf-8'?>\n";
        xml = xml + "<results>";

        request.setAttribute("journalDetailsFormBean", this._journalDetailsFormBean);

        // Get the list of journals
        String sql = Queries.getQuery("getJournalName");
        PreparedStatement st = conn.prepareStatement(sql);
        ResultSet rs = this.db.executeQueryPreparedStatement(st);
        //ResultSetMetaData rsmd = rs.getMetaData();
        //int numberOfColumns = rsmd.getColumnCount();

        while(rs.next()){

            String journalName = rs.getString(1);

            String pages="";
            int issues=0;
            String page_size="";
            int no_of_volumes=0;

            // For the selected journal get journal details
            sql = Queries.getQuery("get_journal_details");
            st = conn.prepareStatement(sql);
            st.setString(1, journalName);
            st.setInt(2, year);
            ResultSet rs1 = this.db.executeQueryPreparedStatement(st);
            if(rs1.next()){
                pages = rs1.getString(1);
                issues = rs1.getInt(2);
                page_size = rs1.getString(3);
                no_of_volumes = rs1.getInt(4);
            }
            xml = xml + "<row>";
            xml = xml + "<journalName>" + journalName + "</journalName>";
            xml = xml + "<pages>" + pages + "</pages>";
            xml = xml + "<issues>" + issues + "</issues>";
            xml = xml + "<page_size>" + page_size + "</page_size>";
            xml = xml + "<no_of_volumes>" + no_of_volumes + "</no_of_volumes>";

            xml = xml + "</row>";

        }

        xml = xml + "</results>";

        return xml;

    }

}
