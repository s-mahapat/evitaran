
package IAS.Model.Reports;

import IAS.Model.Reports.*;
import javax.servlet.http.HttpServletRequest;
import java.sql.*;
import IAS.Model.*;
import java.text.ParseException;
import IAS.Class.Queries;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import IAS.Class.util;
import org.apache.log4j.Logger;
import IAS.Class.JDSLogger;
/**
 *
 * @author Deepali
 */
public class reportModel extends JDSModel{

    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Model.reports");

    public reportModel(HttpServletRequest request) throws SQLException{

       super(request);

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
    public String searchSubType() throws SQLException, ParseException, ParserConfigurationException, TransformerException {
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

