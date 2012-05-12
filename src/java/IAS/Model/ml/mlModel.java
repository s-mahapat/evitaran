
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
    
    public String generate() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {
        
        String xml = null;
        String url = null;
        String sql = Queries.getQuery("insert_ml");
        PreparedStatement st = conn.prepareStatement(sql);
        int paramIndex = 1;
        st.setString(paramIndex, request.getParameter("journalName"));
        st.setString(++paramIndex, request.getParameter("issue"));
        st.setString(++paramIndex, request.getParameter("year"));        
        st.setString(++paramIndex, request.getParameter("month"));
        st.setString(++paramIndex, request.getParameter("mlCreationDate"));
        try
            {
                if (db.executeUpdatePreparedStatement(st) == 1) {
                        try (ResultSet rs = st.getGeneratedKeys()) {
                            while(rs.next()){
                                int i = rs.getInt(1);
                                String sqlgetml = Queries.getQuery("generate_ml");
                                PreparedStatement stgetml = conn.prepareStatement(sqlgetml);
                                paramIndex = 1;
                                stgetml.setString(paramIndex, request.getParameter("journalName"));
                                stgetml.setString(++paramIndex, request.getParameter("issue"));
                                stgetml.setString(paramIndex, request.getParameter("year"));        
                                stgetml.setString(++paramIndex, request.getParameter("month"));
                                stgetml.setString(++paramIndex, request.getParameter("mlCreationDate"));
                                ResultSet rsgetml = db.executeQueryPreparedStatement(stgetml);
                                xml = util.convertResultSetToXML(rsgetml);
                                request.setAttribute("xml", xml);
                                url = "/xmlserver";                                
                                while (rsgetml.next()) {
                                    String sqlmldtl = Queries.getQuery("insert_mldtl");
                                    PreparedStatement stmldtl = conn.prepareStatement(sqlmldtl);
                                    paramIndex = 1;
                                    stmldtl.setString(paramIndex, request.getParameter("i"));
                                    Object value = null;
                                    for (int j = 1; j <= 15; i++) {
                                        value = rsgetml.getObject(i);
                                        stmldtl.setString(++paramIndex, value.toString());
                                    }
                                    stmldtl.setString(++paramIndex, request.getParameter("year"));        
                                    stmldtl.setString(++paramIndex, request.getParameter("month"));
                                    db.executeUpdatePreparedStatement(stmldtl);
                                }
                                rs.close();                               
                            }
                        }
                    }
            }catch (Exception MySQLIntegrityConstraintViolationException)
            {
                logger.error(MySQLIntegrityConstraintViolationException.getMessage(), MySQLIntegrityConstraintViolationException);
            }
       
         
        return xml;
    }
    
    public String print(HttpServletResponse response) throws IOException, DocumentException
    {
        //Query whatever you want here
        String xml = null;
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