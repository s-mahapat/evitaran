package IAS.Model.ml;

import IAS.Bean.MailingList.mlFormBean;
import IAS.Class.JDSLogger;
import IAS.Class.Queries;
import IAS.Class.util;
import IAS.Model.JDSModel;
import com.sun.rowset.CachedRowSetImpl;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.*;
import java.text.ParseException;
import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import org.apache.log4j.Logger;

/**
 *
 * @author aloko
 */
public class mlModel extends JDSModel {

    private mlFormBean _mlFormBean = null;
    private static final Logger logger = JDSLogger.getJDSLogger(IAS.Model.ml.mlModel.class.getName());

    public mlModel(HttpServletRequest request) throws SQLException {

        super(request);

    }

    public int searchMl() throws SQLException, ParseException, ParserConfigurationException, TransformerException {

        // get the connection from connection pool
        String sql = Queries.getQuery("check_ml");
        try (Connection conn = this.getConnection(); PreparedStatement stGet = conn.prepareStatement(sql);) {
            int paramIndex = 1;
            stGet.setString(paramIndex, request.getParameter("journalName"));
            stGet.setString(++paramIndex, request.getParameter("year"));
            stGet.setString(++paramIndex, request.getParameter("volume"));
            stGet.setString(++paramIndex, request.getParameter("issue"));
            stGet.setString(++paramIndex, request.getParameter("month"));
            try (ResultSet rs = stGet.executeQuery();) {
                if (rs.next()) {
                    return rs.getInt(1);
                } else {
                    return 0;
                }
            }
        } finally {

        }

    }

    public String getMlDtl(int mlId) throws SQLException, ParseException, ParserConfigurationException, TransformerException {

        // get the connection from connection pool       
        String xml = null;
        String sql = Queries.getQuery("search_mldtl_ui");
        try (Connection conn = this.getConnection(); PreparedStatement stGet = conn.prepareStatement(sql);) {
            int paramIndex = 1;
            stGet.setInt(paramIndex, mlId);
            try (ResultSet rs = stGet.executeQuery();) {
                xml = util.convertResultSetToXML(rs);
            }

        } finally {
            return xml;
        }

    }

    public String checkMl() throws IllegalAccessException, ParseException,
            ParserConfigurationException, SQLException, TransformerException,
            IOException, InvocationTargetException, Exception {

        String xml;
        int mlid;
        mlid = this.searchMl();
        xml = util.convertStringToXML(String.valueOf(mlid), "mlid");
        return xml;
    }

    public String search() throws IllegalAccessException, ParseException,
            ParserConfigurationException, SQLException, TransformerException,
            IOException, InvocationTargetException, Exception {
        String xml;
        int mlid;
        mlid = this.searchMl();
        if (mlid != 0);
        {
            xml = this.getMlDtl(mlid);
        }
        return xml;
    }

    public CachedRowSetImpl getMlDtlResultset(int mlId) throws SQLException {

        String printOption = request.getParameter("printOption");

        String sql = Queries.getQuery("search_mldtl");

        if (printOption.equals("O")) {
            sql += " and ml.copies = 1 and country = 'India' order by ml.pincode";
        } else if (printOption.equals("E")) {
            sql += " and ml.copies > 1 and country = 'India' order by ml.pincode";
        } else if (printOption.equals("F")) {
            sql += " and country <> 'India' order by ml.pincode";
        }
        CachedRowSetImpl crs = new CachedRowSetImpl();
        // get the connection from connection pool
        try (Connection conn = this.getConnection();
                PreparedStatement stGet = conn.prepareStatement(sql);) {
            stGet.setInt(1, mlId);
            try (ResultSet rs = stGet.executeQuery();) {
                crs.populate(rs);
            }
        }

        return (crs);
    }

    public synchronized String generate() throws IllegalAccessException, ParseException,
            ParserConfigurationException, SQLException, TransformerException,
            IOException, InvocationTargetException, SQLException, ParseException, ParserConfigurationException, TransformerException,
            ClassNotFoundException {

        //  Declare Variables
        String xml;
        int i = 0;
        int mlid;
        mlid = this.searchMl();
        String journalName = request.getParameter("journalName");
        String issue = request.getParameter("issue");
        String year = request.getParameter("year");
        String volumeNumber = request.getParameter("volume");
        String month = request.getParameter("month");

        // get the connection from connection pool
        Connection conn = this.getConnection();

        // Check if the record exists in mialing_list for that journal and issue.
        // If record deosnot exists insert record first to mailing list
        // Then retried id for current iserted record
        //Fetch the mailing list
        // Inster the mailing_list_detail into mailing list table with mailing_list Id as reference.
        if (mlid == 0) {
            conn.setAutoCommit(false);
            try {
                int mailing_list_id = 0;
                String sql = Queries.getQuery("insert_ml");
                PreparedStatement st = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                int paramIndex = 1;
                st.setString(paramIndex, journalName);
                st.setString(++paramIndex, issue);
                st.setString(++paramIndex, year);
                st.setString(++paramIndex, month);
                st.setString(++paramIndex, volumeNumber);

                if (st.executeUpdate() == 1) {
                    try (ResultSet rsml = st.getGeneratedKeys();) {
                        if (rsml.first()) {
                            // get the newly added mailing list id
                            mailing_list_id = rsml.getInt(1);
                        }
                    }

                    String sqlgetml = Queries.getQuery("select_generateml");
                    String sqlmldtl = Queries.getQuery("insert_mldtl");
                    try (PreparedStatement stgetml = conn.prepareStatement(sqlgetml);
                            PreparedStatement stmldtl = conn.prepareStatement(sqlmldtl);) {

                        if (mailing_list_id > 0) {
                            i = mailing_list_id;
                            int mlIndex = 0;
                            paramIndex = 1;
                            stgetml.setString(paramIndex, journalName);
                            stgetml.setString(++paramIndex, year);
                            stgetml.setString(++paramIndex, month);
                            try (ResultSet rsgetml = stgetml.executeQuery()) {
                                while (rsgetml.next()) {
                                    ++mlIndex;
                                    paramIndex = 1;
                                    stmldtl.setInt(paramIndex, i);
                                    Object value = null;
                                    for (int j = 1; j <= 21; j++) {
                                        value = rsgetml.getObject(j);
                                        if (value == null) {
                                            stmldtl.setString(++paramIndex, "");
                                        } else {
                                            stmldtl.setString(++paramIndex, value.toString());
                                        }
                                    }
                                    stmldtl.setString(++paramIndex, volumeNumber);
                                    stmldtl.setString(++paramIndex, issue);
                                    stmldtl.setString(++paramIndex, month);
                                    stmldtl.setString(++paramIndex, year);
                                    stmldtl.executeUpdate();
                                    //stmldtl.close();
                                }
                            }
                            if (mlIndex == 0) {
                                throw new SQLException("No record found");
                            } else {
                                conn.commit();
                            }
                        }
                    }
                }

            } catch (SQLException e) {
                logger.error(e);
                //SQLException | NumberFormatException
                conn.rollback();
            } finally {
                conn.setAutoCommit(true);

                // return the connection back to the pool
                this.CloseConnection(conn);
            }
        } else {
            i = mlid;
        }
        xml = this.getMlDtl(i);
        return xml;
    }

    public ResultSet printml() throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        logger.debug("Start of  mailing list resultset generation");
        //Query whatever you want here
        int mlId = searchMl();
        ResultSet rs = getMlDtlResultset(mlId);
        logger.debug("End of mailing list resultset generation");
        return rs;
    }
    /*
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
     *
     */
}
