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
public class bilModel extends JDSModel {

    private mlFormBean _mlFormBean = null;
    private static final Logger logger = JDSLogger.getJDSLogger(bilModel.class.getName());

    public bilModel(HttpServletRequest request) throws SQLException {
        super(request);

    }

    public String searchGen(String bilIDsForDisplay) throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml = null;

        ResultSet rs = getBILDtlUi(bilIDsForDisplay);

        xml = util.convertResultSetToXML(rs);
        return xml;
    }

    public String search() throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml = null;

        ResultSet rs = getBILDtlUi();

        xml = util.convertResultSetToXML(rs);
        return xml;
    }

    public ResultSet getBILDtlUi(String bilIDsForDisplay) throws SQLException {

        String fromDate = request.getParameter("from");
        String toDate = request.getParameter("to");
        String subscriberNumber = request.getParameter("subscriberNumber");
        if ("0".equals(fromDate)) {
            fromDate = null;
        }
        if ("0".equals(toDate)) {
            toDate = null;
        }
        if ("0".equals(subscriberNumber) || "value".equals(subscriberNumber)) {
            subscriberNumber = null;
        }
        String sql = Queries.getQuery("search_bil_ui");

        if (subscriberNumber != null && subscriberNumber.compareToIgnoreCase("NULL") != 0 && subscriberNumber.length() > 0) {
            sql += " and mailing_list_detail.subscriberNumber =" + "'" + subscriberNumber + "'";
        } else {
            sql += bilIDsForDisplay;
        }
        Connection conn = this.getConnection();
        PreparedStatement stGet = conn.prepareStatement(sql);
        //int paramIndex = 1;
        //stGet.setString(paramIndex, request.getParameter("subscriberNumber"));
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        return rs;
    }

    public ResultSet getBILDtlUi() throws SQLException {

        String fromDate = request.getParameter("from");
        String toDate = request.getParameter("to");
        String subscriberNumber = request.getParameter("subscriberNumber");
        if ("0".equals(fromDate)) {
            fromDate = null;
        }
        if ("0".equals(toDate)) {
            toDate = null;
        }
        if ("0".equals(subscriberNumber) || "value".equals(subscriberNumber)) {
            subscriberNumber = null;
        }
        String sql = Queries.getQuery("search_bil_ui");

        if (subscriberNumber != null && subscriberNumber.compareToIgnoreCase("NULL") != 0 && subscriberNumber.length() > 0) {
            sql += " and mailing_list_detail.subscriberNumber =" + "'" + subscriberNumber + "'";
        } else {
            sql += " and back_issue_list.added_on between " + "STR_TO_DATE(" + '"' + fromDate + '"' + ",'%d/%m/%Y')" + " and " + "STR_TO_DATE(" + '"' + toDate + '"' + ",'%d/%m/%Y')";
        }
        Connection conn = this.getConnection();
        PreparedStatement stGet = conn.prepareStatement(sql);
        //int paramIndex = 1;
        //stGet.setString(paramIndex, request.getParameter("subscriberNumber"));
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        return rs;
    }

    public ResultSet getBILDtl(String bilid[]) throws SQLException {
        String fromDate = request.getParameter("from");
        String toDate = request.getParameter("to");
        String subscriberNumber = request.getParameter("subscriberNumber");
        String billist = "";
        if ("0".equals(fromDate)) {
            fromDate = null;
        }
        if ("0".equals(toDate)) {
            toDate = null;
        }
        if ("0".equals(subscriberNumber)) {
            subscriberNumber = null;
        }
        for (int i = 0; i < bilid.length; i++) {
            billist = billist + bilid[i];
            if(i != bilid.length-1) {
                billist = billist + ",";
            }
        }
        String sql = Queries.getQuery("search_bil");
        if (billist != null) {
            sql += " and mailing_list_detail.bilid in (" + billist + ")";
        } 
        if (subscriberNumber != null && subscriberNumber.compareToIgnoreCase("NULL") != 0 && subscriberNumber.length() > 0) {
            sql += " and mailing_list_detail.subscriberNumber = " + "'" + subscriberNumber + "'";
        } else {
            sql += " and back_issue_list.added_on between " + "STR_TO_DATE(" + '"' + fromDate + '"' + ",'%d/%m/%Y')" + " and " + "STR_TO_DATE(" + '"' + toDate + '"' + ",'%d/%m/%Y')";
        }
        Connection conn = this.getConnection();
        PreparedStatement stGet = conn.prepareStatement(sql);
        //int paramIndex = 1;
        //stGet.setString(paramIndex, request.getParameter("subscriberNumber"));
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        return rs;
    }

        public ResultSet getBILDtl() throws SQLException {
        String fromDate = request.getParameter("from");
        String toDate = request.getParameter("to");
        String subscriberNumber = request.getParameter("subscriberNumber");
        String billist = "";
        if ("0".equals(fromDate)) {
            fromDate = null;
        }
        if ("0".equals(toDate)) {
            toDate = null;
        }
        if ("0".equals(subscriberNumber)) {
            subscriberNumber = null;
        }

        String sql = Queries.getQuery("search_bil");
        if (subscriberNumber != null && subscriberNumber.compareToIgnoreCase("NULL") != 0 && subscriberNumber.length() > 0) {
            sql += " and mailing_list_detail.subscriberNumber = " + "'" + subscriberNumber + "'";
        } else {
            sql += " and back_issue_list.added_on between " + "STR_TO_DATE(" + '"' + fromDate + '"' + ",'%d/%m/%Y')" + " and " + "STR_TO_DATE(" + '"' + toDate + '"' + ",'%d/%m/%Y')";
        }
        Connection conn = this.getConnection();
        PreparedStatement stGet = conn.prepareStatement(sql);
        //int paramIndex = 1;
        //stGet.setString(paramIndex, request.getParameter("subscriberNumber"));
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        return rs;
    }
        
    public synchronized String generate() throws SQLException, ParseException, ParserConfigurationException, TransformerException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException {

        String xml = null;
        //int i = 0;
        Connection conn = this.getConnection();

        // Get the records from back_issue_list where bil is not generated.
        // Prepare insert string string for bil to ml_dtl
        // get ml id for the record and associate wil bil insert
        // insert bil to ML
        // modify corresponding bil with generated tag and date
        // get bil
        String fromDate = request.getParameter("from");
        String toDate = request.getParameter("to");
        String subscriberNumber = request.getParameter("subscriberNumber");
        if ("0".equals(fromDate)) {
            fromDate = null;
        }
        if ("0".equals(toDate)) {
            toDate = null;
        }
        if ("0".equals(subscriberNumber)) {
            subscriberNumber = null;
        }
        String sql = Queries.getQuery("generate_bil");

        if (subscriberNumber != null && subscriberNumber.compareToIgnoreCase("NULL") != 0 && subscriberNumber.length() > 0) {
            sql += " and subscriber.subscriberNumber =" + "'" + subscriberNumber + "'";
        } else {
            sql += " and back_issue_list.added_on between " + "STR_TO_DATE(" + '"' + fromDate + '"' + ",'%d/%m/%Y')" + " and " + "STR_TO_DATE(" + '"' + toDate + '"' + ",'%d/%m/%Y')";
        }

        String sqlInsBil = Queries.getQuery("insert_mldtl_bil");
        PreparedStatement stInsMlBil = conn.prepareStatement(sqlInsBil);

        String bilIDsForDisplay = " and mailing_list_detail.bilid in (";

        try (PreparedStatement stGet = conn.prepareStatement(sql);) {
            try (ResultSet rs = stGet.executeQuery();) {
                while (rs.next()) {
                    // insert record by record to mailing list
                    String bilid = null;
                    int paramIndex = 0;
                    Object value = null;
                    for (int j = 1; j <= 27; j++) {
                        value = rs.getObject(j);
                        if (value == null) {
                            stInsMlBil.setString(++paramIndex, "");
                        } else {
                            stInsMlBil.setString(++paramIndex, value.toString());
                        }
                        if (j == 27) {
                            bilid = value.toString();
                        }
                    }
                    stInsMlBil.setDate(++paramIndex, util.dateStringToSqlDate(request.getParameter("bilCreationDate")));
                    stInsMlBil.executeUpdate();
                    //db.executeUpdatePreparedStatement(stInsMlBil);
                    String sqlUpdBil = Queries.getQuery("update_bil");
                    PreparedStatement stUpdBil = conn.prepareStatement(sqlUpdBil);
                    int paramIndexUpd = 1;
                    stUpdBil.setString(paramIndexUpd, bilid);
                    stUpdBil.executeUpdate();
                    //db.executeUpdatePreparedStatement(stUpdBil);
                    bilIDsForDisplay = bilIDsForDisplay + bilid;
                    if (!rs.isLast()) {
                        bilIDsForDisplay = bilIDsForDisplay + ",";
                    }
                }
                bilIDsForDisplay = bilIDsForDisplay + ")";
            }
        } catch (Exception e) {
            logger.error(e);
        } finally {
            conn.close();
            if (bilIDsForDisplay.contains("()")) {
                xml = xml = xml + "<?xml version='1.0' encoding='utf-8'?>\n" + "<results>" + "</results>";
            } else {
                xml = this.searchGen(bilIDsForDisplay);
            }
            return xml;
        }
    }

    public ResultSet printbil() throws SQLException {
        logger.debug("Start of  mailing list resultset generation");
        //Query whatever you want here
        ResultSet rs = getBILDtl();
        logger.debug("End of mailing list resultset generation");
        return rs;
    }
    
    public ResultSet printbilGen() throws SQLException {
        logger.debug("Start of  mailing list resultset generation");
        String bilid1[] = request.getParameterValues("bilid");
        
        //bilid=677&bilid=678&bilid=679: bilid=680bilid=681bilid=682bilid=683bilid=684bilid=685bilid=686bilid=687bilid=688bilid=689bilid=690
        
        bilid1[0] = bilid1[0].replace("&", "");
        bilid1[0] = bilid1[0].substring(6);
        String delims = "bilid=";        
        String[] bilid = bilid1[0].split(delims);
        
        /*
        String[] bilid = new String[3];
        bilid[0] = "677";
        bilid[1] = "678";
        bilid[2] = "679";        
        */
        //Query whatever you want here
        ResultSet rs = getBILDtl(bilid);
        logger.debug("End of mailing list resultset generation");
        return rs;
    }
    /*
     public synchronized String printbil(HttpServletResponse response, String type) throws DocumentException, IOException, SQLException
     {
     logger.debug("Start of label printing");

     //Query whatever you want here
     ResultSet rs = getBILDtl();

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
