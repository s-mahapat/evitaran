
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

        ResultSet rs = getMlDtlResultset(mlId);

        xml = util.convertResultSetToXML(rs);
        return xml;
    }

    public ResultSet getMlDtlResultset(int mlId) throws SQLException
    {
        String sql = Queries.getQuery("search_mldtl");
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;
        stGet.setInt(paramIndex, mlId);
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);

        return(rs);
    }

    public synchronized String generate() throws SQLException, ParseException, ParserConfigurationException, TransformerException,
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
                            if(value == null)
                                stmldtl.setString(++paramIndex, "");
                            else
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

    public synchronized String printml(HttpServletResponse response, String type) throws DocumentException, IOException, SQLException, ParseException, ParserConfigurationException, TransformerException
    {
        logger.debug("Start of label printing");

        //Query whatever you want here
        int mlId = searchMl();
        ResultSet rs = getMlDtlResultset(mlId);

        OutputStream os = response.getOutputStream();

        convertToPdf c2Pdf = new convertToPdf();
        if(type.equals("LABEL"))
            c2Pdf.addLabelContent(rs, os);
        if(type.equals("STICKER"))
            c2Pdf.addStickerContent(rs, os);

        response.setContentType("application/pdf");
        response.setHeader("Content-disposition", "attachment; filename=ml.pdf");

        os.flush();
        os.close();

        String pdf = null;
        //pdf = baos.toString();
        //pdf = new String(baos.toByteArray());
        //pdf = util.toString(baos);

        logger.debug("End of label printing");

        return pdf;
    }
}