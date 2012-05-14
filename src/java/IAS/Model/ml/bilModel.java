
package IAS.Model.ml;

import IAS.Bean.MailingList.mlFormBean;
import IAS.Model.JDSModel;
import com.itextpdf.text.DocumentException;
import java.io.IOException;
import javax.xml.transform.TransformerException;
import org.apache.log4j.Logger;
import IAS.Class.JDSLogger;
import javax.servlet.http.HttpServletRequest;
import java.sql.*;
import IAS.Class.Queries;
import IAS.Class.convertToPdf;
import IAS.Class.util;
import java.io.ByteArrayOutputStream;
import java.io.OutputStream;
import javax.xml.parsers.ParserConfigurationException;
import java.text.ParseException;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author aloko
 */
public class bilModel extends JDSModel {

    private mlFormBean _mlFormBean = null;
    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Model.MailingList");

    public bilModel(HttpServletRequest request) throws SQLException{

       super(request);

    }

     public String search()  throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml = null;
        String sql = Queries.getQuery("search_bil");
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;
        stGet.setString(paramIndex, request.getParameter("subscriberNumber"));    
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        xml = util.convertResultSetToXML(rs);
        return xml;
    }
        
    public String generate() throws SQLException, ParseException, ParserConfigurationException, TransformerException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException
    {
       String xml = null;
        int i = 0;

        
       // Get the records from back_issue_list where bil is not generated. 
       // Prepare insert string string for bil to ml_dtl
       // get ml id for the record and associate wil bil insert
       // insert bil to ML
       // modify corresponding bil with generated tag and date
       // get bil        

        String sql = Queries.getQuery("generate_bil");
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;
        stGet.setString(paramIndex, request.getParameter("subscriberNumber"));
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        while (rs.next()) {
            // insert record by record to mailing list
            String bilid = null;
            String sqlInsBil = Queries.getQuery("insert_mldtl_bil");
            PreparedStatement stInsMlBil = conn.prepareStatement(sqlInsBil);
            paramIndex = 0;
            Object value = null;
            for (int j = 1; j <= 26; j++) {                    
                value = rs.getObject(j);
                stInsMlBil.setString(++paramIndex, value.toString());
                if (j == 26)
                    bilid = value.toString();                    
            }
            stInsMlBil.setDate(++paramIndex, util.dateStringToSqlDate(request.getParameter("bilCreationDate")));                
            db.executeUpdatePreparedStatement(stInsMlBil);
            String sqlUpdBil = Queries.getQuery("update_bil");
            PreparedStatement stUpdBil = conn.prepareStatement(sqlUpdBil);
            int paramIndexUpd = 1;
            stUpdBil.setString(paramIndexUpd, bilid);
            db.executeUpdatePreparedStatement(stUpdBil);
        }
        xml = this.search();
        return xml;
    }
    
    public String print()
    {
        String xml = null;
        return xml;
    }    

}