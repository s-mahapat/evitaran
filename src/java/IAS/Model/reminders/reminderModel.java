
package IAS.Model.reminders;

import IAS.Model.reminders.*;
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
public class reminderModel extends JDSModel {

    private mlFormBean _mlFormBean = null;
    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Model.MailingList");

    public reminderModel(HttpServletRequest request) throws SQLException{

       super(request);

    }

    public ResultSet search()  throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String sql = Queries.getQuery("check_ml");
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;
        stGet.setString(paramIndex, request.getParameter("journalName"));
        stGet.setString(++paramIndex, request.getParameter("issue"));
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
            return rs;
    }

   
    public String generate() throws SQLException, ParseException, ParserConfigurationException, TransformerException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {
        String xml = null;        
        String proc = "{ call create_reminder_type1(?,?,?) }";
        CallableStatement cs = conn.prepareCall(proc);
        int paramIndex = 1;        
        cs.setString(paramIndex, request.getParameter("reminderType"));
        cs.setString(paramIndex, request.getParameter("medium"));
        cs.setString(paramIndex, request.getParameter("language"));
        cs.execute();
        String sql = Queries.getQuery("get_reminders");
        PreparedStatement stGet = conn.prepareStatement(sql);
        stGet.setString(paramIndex, request.getParameter("reminderType"));
        ResultSet rsGet = this.db.executeQueryPreparedStatement(stGet);
        xml = util.convertResultSetToXML(rsGet);
        return xml;
    }

    public String print(HttpServletResponse response) throws SQLException, ParseException, ParserConfigurationException, TransformerException, IOException, DocumentException
    {
        //Query whatever you want here
        String xml = null;
       // int stat = this.search();
        ResultSet rs = null;

        //Now convert to pdf here
        //convertToPdf toPdf = new convertToPdf();
        //ByteArrayOutputStream baos = toPdf.getPdf(rs, response);

        // setting some response headers
        //response.setHeader("Expires", "0");
        //response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
        //response.setHeader("Pragma", "public");
        // setting the content type
        //response.setContentType("application/pdf");
        //response.setHeader("Content-disposition","attachment; filename=ml.pdf");
        // the contentlength
        //response.setContentLength(baos.size());
        // write ByteArrayOutputStream to the ServletOutputStream
        //OutputStream os = response.getOutputStream();
        //baos.writeTo(os);
        //os.flush();
        //os.close();

        return xml;
    }

}