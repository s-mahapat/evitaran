
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

    public int searchMl()  throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String sql = Queries.getQuery("check_ml");
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;
        stGet.setString(paramIndex, request.getParameter("journalName"));       
        stGet.setString(++paramIndex, request.getParameter("issue"));           
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        if(rs.next())
            return rs.getInt(1);
        else
            return 0;
    }

    public String getMlDtl(int mlId)  throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml = null;
        String sql = Queries.getQuery("search_mldtl");
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;
        stGet.setInt(paramIndex, mlId);    
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);     
        xml = util.convertResultSetToXML(rs);
        return xml;
    }
        
    public String generate() throws SQLException, ParseException, ParserConfigurationException, TransformerException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {
        //  Declare Variables        
        String xml = null;
        int i = 0;
        int mlid = 0;
        mlid = this.searchMl(); 
        // Check if the record exists in mialing_list for that journal and issue.
        // If record deosnot exists insert record first to mailing list
        // Then retried id for current iserted record
        //Fetch the mailing list
        // Inster the mailing_list_detail into mailing list table with mailing_list Id as reference.
        if (mlid == 0) {
            String sql = Queries.getQuery("insert_ml");
            PreparedStatement st = conn.prepareStatement(sql);
            int paramIndex = 1;
            st.setString(paramIndex, request.getParameter("journalName"));
            st.setString(++paramIndex, request.getParameter("issue"));
            st.setString(++paramIndex, request.getParameter("year"));        
            st.setString(++paramIndex, request.getParameter("month"));
            if (db.executeUpdatePreparedStatement(st) == 1) {
                String sqlml = Queries.getQuery("get_ml_id");
                PreparedStatement stml = conn.prepareStatement(sqlml);
                paramIndex = 1;
                stml.setString(paramIndex, request.getParameter("journalName"));
                stml.setString(++paramIndex, request.getParameter("issue"));
                stml.setString(++paramIndex, request.getParameter("year"));        
                stml.setString(++paramIndex, request.getParameter("month")); 
                ResultSet rsml = this.db.executeQueryPreparedStatement(stml);
                if(rsml.next()){
                    i = rsml.getInt(1);
                    String sqlgetml = Queries.getQuery("select_generateml");
                    PreparedStatement stgetml = conn.prepareStatement(sqlgetml);
                    paramIndex = 1;
                    stgetml.setString(paramIndex, request.getParameter("journalName"));
                    stgetml.setString(++paramIndex, request.getParameter("year"));
                    stgetml.setString(++paramIndex, request.getParameter("year"));   
                    //stgetml.setString(++paramIndex, request.getParameter("month"));
                    //stgetml.setString(++paramIndex, request.getParameter("month"));
                    ResultSet rsgetml = db.executeQueryPreparedStatement(stgetml);
                    while (rsgetml.next()) {
                        String sqlmldtl = Queries.getQuery("insert_mldtl");
                        PreparedStatement stmldtl = conn.prepareStatement(sqlmldtl);
                        paramIndex = 1;
                        stmldtl.setInt(paramIndex, i );
                        Object value = null;
                        for (int j = 1; j <= 21; j++) {
                            value = rsgetml.getObject(j);
                            stmldtl.setString(++paramIndex, value.toString());
                        }
                        stmldtl.setString(++paramIndex, request.getParameter("issue"));
                        stmldtl.setString(++paramIndex, request.getParameter("month"));
                        stmldtl.setString(++paramIndex, request.getParameter("year"));  
                        db.executeUpdatePreparedStatement(stmldtl);
                    }
                }                       
            }
        }
        else{
            i = mlid;
        }        
        xml = this.getMlDtl(i);
        return xml;
    }
    
    public String print(HttpServletResponse response) throws SQLException, ParseException, ParserConfigurationException, TransformerException, IOException, DocumentException
    {
        //Query whatever you want here
        String xml = null;
       // int stat = this.search();
        ResultSet rs = null;
        
        //Now convert to pdf here
        convertToPdf toPdf = new convertToPdf();
        ByteArrayOutputStream baos = toPdf.getPdf(rs, response);
        
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