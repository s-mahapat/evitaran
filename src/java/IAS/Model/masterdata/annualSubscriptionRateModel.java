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
import java.io.IOException;
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
  
    public synchronized String save() throws SQLException, ParserConfigurationException, TransformerException, IOException {
        String xml = null;
        int id                  = Integer.parseInt(request.getParameter("id"));
        /*
        String journalGroupName =  request.getParameter("journalGroupName");
        String subtypedesc   =  request.getParameter("subtypedesc");
        String year             =  request.getParameter("year");
        String period           =  request.getParameter("period");
        String rate             =  request.getParameter("rate");
        */
        String active           =  request.getParameter("active");
        int status = 0;
        if(active.equals("Yes")) {
            status = 1;
        }
        
        String sql = Queries.getQuery("save_subRate");
        try (Connection conn = this.getConnection(); PreparedStatement stUpdate = conn.prepareStatement(sql)) {
            int paramIndex = 1;
            /*
            stUpdate.setString(paramIndex, request.getParameter("journalGroupName"));
            stUpdate.setString(++paramIndex, request.getParameter("subtypedesc"));
            stUpdate.setString(++paramIndex, request.getParameter("year"));
            stUpdate.setString(++paramIndex, request.getParameter("period"));
            stUpdate.setString(++paramIndex, request.getParameter("rate"));
            */
            stUpdate.setInt(paramIndex, status);
            stUpdate.setString(++paramIndex, request.getParameter("id"));
            
            int success = db.executeUpdatePreparedStatement(stUpdate);
            xml = util.convertStringToXML(Integer.toString(success), "success");
        }
        
        return xml;
    }
    
    public synchronized String verify() throws SQLException, ParserConfigurationException, TransformerException, IOException {
                // First check if the entry exist 
        String sql = Queries.getQuery("verify_subRate");
        String xml = null;
        int exists = 1;        
        try (Connection conn = this.getConnection(); PreparedStatement stGet = conn.prepareStatement(sql)) {
            int paramIndex = 1;
            stGet.setString(paramIndex, request.getParameter("journalGroupName"));
            stGet.setString(++paramIndex, request.getParameter("subtypedesc"));
            stGet.setString(++paramIndex, request.getParameter("year"));
            stGet.setString(++paramIndex, request.getParameter("noofYear"));
            //stGet.setString(++paramIndex, request.getParameter("rate"));
            
            try (ResultSet rs = stGet.executeQuery()) {
                // If the entry does not exist, then add to the db                
                if (!rs.next()) {
                    exists = 0;
                } else {
                    exists = 1;
                }
            }
        }
        xml = util.convertStringToXML(Integer.toString(exists), "exists");                    
        return xml;
    }

    public synchronized String addNewRate() throws SQLException, ParseException, ParserConfigurationException, TransformerException {

        // First check if the entry exist 
        //String sql = Queries.getQuery("check_subRate");
        String sql = Queries.getQuery("add_subRate");
        String xml = null;
        try (Connection conn = this.getConnection(); PreparedStatement stAdd = conn.prepareStatement(sql)) {
            int paramIndex = 1;
            //stGet.setString(paramIndex, request.getParameter("journalGroupName"));
            //stGet.setString(++paramIndex, request.getParameter("subtypedesc"));
            //stGet.setString(++paramIndex, request.getParameter("year"));
            //stGet.setString(++paramIndex, request.getParameter("noofYear"));
            //stGet.setString(++paramIndex, request.getParameter("rate"));
            //try (ResultSet rs = stGet.executeQuery()) {
                // If the entry does not exist, then add to the db
                //if (!rs.next()) {
                    //sql = Queries.getQuery("add_subRate");
                    //PreparedStatement stAdd = conn.prepareStatement(sql);
                    paramIndex = 1;
                    stAdd.setString(paramIndex, request.getParameter("journalGroupName"));
                    stAdd.setString(++paramIndex, request.getParameter("subtypedesc"));
                    stAdd.setString(++paramIndex, request.getParameter("year"));
                    stAdd.setString(++paramIndex, request.getParameter("noofYear"));
                    stAdd.setString(++paramIndex, request.getParameter("rate"));
                    //stAdd.setInt(++paramIndex, Integer.parseInt(request.getParameter("active")));
                    int success = db.executeUpdatePreparedStatement(stAdd);
                    //rs = this.db.executeQueryPreparedStatement(stAdd);
                //}

            //}

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
            stGet.setString(++paramIndex, request.getParameter("subtypedesc"));
            try (ResultSet rs = stGet.executeQuery()) {
                xml = util.convertResultSetToXML(rs);
            }
        }
        return xml;
    }
    
}
