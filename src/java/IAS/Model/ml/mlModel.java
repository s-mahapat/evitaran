
package IAS.Model.ml;

import IAS.Bean.MailingList.mlFormBean;
import IAS.Model.JDSModel;
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
public class mlModel extends JDSModel {

    private mlFormBean _mlFormBean = null;
    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Model.MailingList");

    public mlModel(HttpServletRequest request) throws SQLException{

       super(request);

    }

    public String search()  throws SQLException, ParseException, ParserConfigurationException, TransformerException {

        String xml = null;
        return xml;
    }
    
    public String generate() throws SQLException, ParserConfigurationException, TransformerException
    {
        String xml = null;
        /*
        String sql = Queries.getQuery("generateMailingList");
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;
        stGet.setString(paramIndex, request.getParameter("year"));
        stGet.setString(++paramIndex, request.getParameter("journalName"));
        stGet.setString(++paramIndex, request.getParameter("month"));
        stGet.setString(++paramIndex, request.getParameter("mlCreationDate"));
        stGet.setString(++paramIndex, request.getParameter("issue"));
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        xml = util.convertResultSetToXML(rs);
         */
        return xml;
    }
    
    public String print()
    {
        String xml = null;
        return xml;
    }    

}