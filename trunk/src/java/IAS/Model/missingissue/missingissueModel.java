
package IAS.Model.missingissue;

import IAS.Bean.missingissue.missingissueFormBean;
import com.itextpdf.text.DocumentException;
import IAS.Class.JDSLogger;
import javax.servlet.http.HttpServletRequest;
import IAS.Class.Queries;
import IAS.Class.convertToPdf;
import java.io.OutputStream;
import javax.servlet.http.HttpServletResponse;
import IAS.Class.ServletContextInfo;
import IAS.Class.msgsend;
import IAS.Class.util;
import IAS.Model.JDSModel;
import com.mysql.jdbc.Statement;
import java.io.FileInputStream;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Properties;
import javax.servlet.ServletContext;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import org.apache.log4j.Logger;
import org.apache.commons.dbutils.BeanProcessor;
/**
 *
 * @author aloko
 */
public class missingissueModel extends JDSModel {

    private missingissueFormBean _missingissueFormBean = null;
    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Model.missingissue");

    public missingissueModel(HttpServletRequest request) throws SQLException{

       super(request);

    }

    public void passId() throws IllegalAccessException, ParseException,
            ParserConfigurationException, SQLException, TransformerException,
            IOException, InvocationTargetException, Exception
    {
        _missingissueFormBean = new missingissueFormBean();


        String sql = Queries.getQuery("get_subscriber_detail");
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;
        stGet.setString(paramIndex, request.getParameter("subscriberNumber"));
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        while (rs.next()) {
            BeanProcessor bProc = new BeanProcessor();
            Class type = Class.forName("IAS.Bean.missingissue.missingissueFormBean");
            this._missingissueFormBean = (IAS.Bean.missingissue.missingissueFormBean) bProc.toBean(rs, type);
        }
        _missingissueFormBean.setMiId(Integer.parseInt(request.getParameter("miId")));
        _missingissueFormBean.setInwardNumber(request.getParameter("inwardNumber"));
        _missingissueFormBean.setSubscriberNumber(request.getParameter("subscriberNumber"));
        request.setAttribute("missingissueFormBean", _missingissueFormBean);
    }

    public String save()  throws IllegalAccessException, ParseException,
            ParserConfigurationException, SQLException, TransformerException,
            IOException, InvocationTargetException, Exception {

        String xml = null;
        String subscriberNumber = request.getParameter("subscriberNumber");
        String inwardNumber = request.getParameter("inwardNumber");
        String subscriptionId[] = request.getParameterValues("subscriptionId");
        String journalGroupName[] = request.getParameterValues("journalGroupName");
        String journalName[] = request.getParameterValues("journalName");
        String year[] = request.getParameterValues("year");
        String missingMonth[] = request.getParameterValues("month");
        String mcopies[] = request.getParameterValues("mcopies");
        int missingissueId = 0;
        conn.setAutoCommit(false);
        try {
                String sql = Queries.getQuery("insert_missing_issue");
                PreparedStatement st = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                int paramIndex = 0;
                //float balance = subscriptionTotal - this._inwardFormBean.getAmount();



                st.setString(++paramIndex, inwardNumber);
                st.setString(++paramIndex, subscriberNumber);
                //st.setDate(++paramIndex, util.dateStringToSqlDate(util.getDateString()));
                if (db.executeUpdatePreparedStatement(st) == 1) {
                    ResultSet rs = st.getGeneratedKeys();
                    rs.first();
                    missingissueId = rs.getInt(1);

                    int[] res = this.__addMissingJournals(missingissueId,
                            util.convertStringArraytoIntArray(subscriptionId),
                            journalGroupName,
                            journalName,
                            missingMonth,
                            util.convertStringArraytoIntArray(year),
                            util.convertStringArraytoIntArray(mcopies));

                    xml = util.convertStringToXML(String.valueOf(missingissueId), "missingissueId");
                    conn.commit();
                }
        }catch (SQLException | ParseException | NumberFormatException e) {
            conn.rollback();
        } finally {
            conn.setAutoCommit(true);
        }
        return xml;
    }

    public String getmissingissue()  throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml = null;
        int copies = 0;
        String sql = Queries.getQuery("get_missing_journals");
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;
        stGet.setString(paramIndex, request.getParameter("missingissueId"));
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        xml = util.convertResultSetToXML(rs);
        return xml;
    }

    public String getCopies()  throws IllegalAccessException, ParseException,
            ParserConfigurationException, SQLException, TransformerException,
            IOException, InvocationTargetException, Exception {
        String xml = null;
        int copies = 0;
        String sql = Queries.getQuery("get_copies");
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;
        stGet.setString(paramIndex, request.getParameter("journalGroupName"));
        stGet.setString(++paramIndex, request.getParameter("subscriptionId"));
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        if(rs.next())
            copies = rs.getInt(1);
        else
            copies =  0;
        xml = util.convertStringToXML(String.valueOf(copies), "copies");
        return xml;
    }

    public String getList()  throws IllegalAccessException, ParseException,
            ParserConfigurationException, SQLException, TransformerException,
            IOException, InvocationTargetException, Exception {
        String xml = null;
        String sql = Queries.getQuery("get_missing_journals");
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;
        stGet.setString(paramIndex, request.getParameter("miId"));
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        xml = util.convertResultSetToXML(rs);
        return xml;
    }

    private int[] __addMissingJournals(
            int missingissueId, int[] subscriptionId, String[] journalGroupName, String[] journalName,
            String[] month, int[] year, int[] mcopies) throws SQLException {

        String sql = Queries.getQuery("insert_missing_journals");
        PreparedStatement st = conn.prepareStatement(sql);
        int paramIndex = 0;
        for (int i = 0; i < journalName.length; i++) {
            paramIndex = 0;
            st.setInt(++paramIndex, missingissueId);
            st.setInt(++paramIndex, subscriptionId[i]);
            st.setString(++paramIndex, journalGroupName[i]);
            st.setString(++paramIndex, journalName[i]);
            st.setString(++paramIndex, journalName[i]);
            st.setString(++paramIndex, month[i]);
            st.setInt(++paramIndex, year[i]);
            st.setInt(++paramIndex, mcopies[i]);
            st.addBatch();
        }
        int res[] = st.executeBatch();
        return res;
    }

    public String reprint()  throws IllegalAccessException, ParseException,
            ParserConfigurationException, SQLException, TransformerException,
            IOException, InvocationTargetException, Exception {
        String xml = null;
        String sql = Queries.getQuery("reprint_mi_list");
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;
        stGet.setString(paramIndex, request.getParameter("miId"));
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        if (rs.next()){
            xml = util.convertResultSetToXML(rs);
            conn.setAutoCommit(false);
            try {
                setAction("R");
                completeInward();
            }catch (SQLException | ParseException | NumberFormatException e) {
                conn.rollback();
            } finally {
                conn.setAutoCommit(true);
            }
        }
        return xml;
    }

    /*
    // This function will actually generate the pdf for the missing issue
    public String printNoCopies(HttpServletResponse response) throws IOException, DocumentException
    {
        ServletContext context = ServletContextInfo.getServletContext();
        String emailPropertiesFile =  context.getRealPath("/WEB-INF/classes/jds_missingissue.properties");
        Properties properties = new Properties();
        properties.load(new FileInputStream(emailPropertiesFile));

        String msg = properties.getProperty("missingIssueNoCopy");

        OutputStream os = response.getOutputStream();
        convertToPdf c2Pdf = new convertToPdf();
        c2Pdf.printMIresponse(os, msg);

        response.setContentType("application/pdf");
        response.setHeader("Content-disposition", "attachment; filename=reprint.pdf");
        os.flush();
        os.close();

        String pdf = null;
        return pdf;

    }
     *
     */

    /*
    // This function will actually generate the pdf for the missing issue
    public String printAlreadySent(HttpServletResponse response) throws IOException, DocumentException
    {
        ServletContext context = ServletContextInfo.getServletContext();
        String emailPropertiesFile =  context.getRealPath("/WEB-INF/classes/jds_missingissue.properties");
        Properties properties = new Properties();
        properties.load(new FileInputStream(emailPropertiesFile));

        String msg = properties.getProperty("missingIssueAlreadySent");

        OutputStream os = response.getOutputStream();
        convertToPdf c2Pdf = new convertToPdf();
        c2Pdf.printMIresponse(os, msg);

        response.setContentType("application/pdf");
        response.setHeader("Content-disposition", "attachment; filename=reprint.pdf");
        os.flush();
        os.close();

        String pdf = null;
        return pdf;

    }
     *
     */

    public ResultSet generateMLforMI() throws SQLException
    {
        String sql = Queries.getQuery("reprint_mi_list");
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;
        stGet.setString(paramIndex, request.getParameter("miId"));

        String type = request.getParameter("printOption");
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);

        return rs;
    }

    /*
    public String generateMLforMI(HttpServletResponse response) throws SQLException, IOException, DocumentException
    {
        String xml = null;
        String sql = Queries.getQuery("reprint_mi_list");
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;
        stGet.setString(paramIndex, request.getParameter("miId"));

        String type = request.getParameter("printOption");
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);

        // Generate the reprint mailing list
        OutputStream os = response.getOutputStream();
        convertToPdf c2Pdf = new convertToPdf();
        if(type.equals("LABEL"))
            c2Pdf.addLabelContent(rs, os);
        if(type.equals("STICKER"))
            c2Pdf.addStickerContent(rs, os);

        response.setContentType("application/pdf");
        response.setHeader("Content-disposition", "attachment; filename=reprint.pdf");
        os.flush();
        String pdf = null;
        return pdf;
    }
     *
     */

     public String generateMl()  throws IllegalAccessException, ParseException,
            ParserConfigurationException, SQLException, TransformerException,
            IOException, InvocationTargetException, Exception {
        String xml = null;
        String miId = null;
        conn.setAutoCommit(false);
        miId = request.getParameter("miId");
        String sql = Queries.getQuery("generate_ml");
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 0;
        stGet.setString(++paramIndex, request.getParameter("miId"));
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        try{
            while(rs.next()){
                String sqlmldtl = Queries.getQuery("insert_mldtl_mil");
                PreparedStatement stmldtl = conn.prepareStatement(sqlmldtl);
                paramIndex = 0;

                Object value = null;
                for (int j = 1; j <= 26; j++) {
                    value = rs.getObject(j);
                    String temp = "";
                    if(value == null)
                        temp = "";
                    else
                        temp = value.toString();
                    stmldtl.setString(++paramIndex, temp);
                }
                //stmldtl.setString(++paramIndex, miId );
                db.executeUpdatePreparedStatement(stmldtl);
            }
        //xml = util.convertResultSetToXML(rs);
            setAction("M");
            completeInward();
        }catch (SQLException | ParseException | NumberFormatException e) {
            conn.rollback();
        } finally {
            conn.setAutoCommit(true);
        }
        return xml;
    }

    public String noCopies()  throws IllegalAccessException, ParseException,
            ParserConfigurationException, SQLException, TransformerException,
            IOException, InvocationTargetException, Exception {

            boolean status = false;
            String xml = null;
            String replyOption = request.getParameter("replyOption");
            //If the user chosses to print
            if(replyOption.equals("Print"))
            {
                xml = util.convertStringToXML("print", "action");
                status = true;
            }
            //If the user chosses to send email
            if(replyOption.equals("EMail"))
            {
                ServletContext context = ServletContextInfo.getServletContext();
                String emailPropertiesFile =  context.getRealPath("/WEB-INF/classes/jds_missingissue.properties");
                Properties properties = new Properties();
                properties.load(new FileInputStream(emailPropertiesFile));
                String msg = properties.getProperty("missingIssueNoCopy");
                String to = request.getParameter("email");
                msgsend sendMsg = new msgsend();
                status = sendMsg.sendMailWithAuthenticationUseTLS(to, "", "", "Missing Issues", msg, "", "", null);
                if(status)
                    xml = util.convertStringToXML("success", "action");
                else
                    xml = util.convertStringToXML("failure", "action");
            }
            if(status)
            {
                setAction("N");
                completeInward();
            }
            return xml;

    }

    public String alreadySent()  throws IllegalAccessException, ParseException,
            ParserConfigurationException, SQLException, TransformerException,
            IOException, InvocationTargetException, Exception {

        boolean status = false;
        String xml = null;
        String replyOption = request.getParameter("replyOption");
        //If the user chosses to print
        if(replyOption.equals("Print"))
        {
            xml = util.convertStringToXML("print", "action");
            status = true;
        }
        //If the user chosses to send email
        if(replyOption.equals("EMail"))
        {
            ServletContext context = ServletContextInfo.getServletContext();
            String emailPropertiesFile =  context.getRealPath("/WEB-INF/classes/jds_missingissue.properties");
            Properties properties = new Properties();
            properties.load(new FileInputStream(emailPropertiesFile));
            String msg = properties.getProperty("missingIssueAlreadySent");
            String to = request.getParameter("email");
            msgsend sendMsg = new msgsend();
            status = sendMsg.sendMailWithAuthenticationUseTLS(to, "", "", "Missing Issues", msg, "", "", null);
            if(status)
                xml = util.convertStringToXML("success", "action");
            else
                xml = util.convertStringToXML("failure", "action");
        }
        if(status)
        {
            setAction("S");
            completeInward();
        }
        return xml;
    }

    public void completeInward()  throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml = null;
        String sql = Queries.getQuery("complete_inward");
        PreparedStatement st = conn.prepareStatement(sql);
        int paramIndex = 1;
        st.setString(paramIndex, request.getParameter("inwardNumber"));
        db.executeUpdatePreparedStatement(st);
    }

    public void setAction(String action)  throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml = null;
        String sql = Queries.getQuery("update_missing_action");
        PreparedStatement st = conn.prepareStatement(sql);
        int paramIndex = 1;
        st.setString(paramIndex, action);
        st.setString(++paramIndex, request.getParameter("miId"));
        db.executeUpdatePreparedStatement(st);
    }

    public int checkMissingExists()  throws IllegalAccessException, ParseException,
            ParserConfigurationException, SQLException, TransformerException,
            IOException, InvocationTargetException, Exception {
        int miId = 0;
        String sql = Queries.getQuery("get_miId_for_inward");
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;
        stGet.setString(paramIndex, request.getParameter("inwardNumber"));
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        if(rs.next()){
            Object value = null;
            value = rs.getObject(1);
            miId = Integer.parseInt(value.toString());
            value = rs.getObject(2);
            request.setAttribute("subscriberNumber", value.toString());
        }
        return miId;
    }

        public void setAttri(int miId) throws IllegalAccessException, ParseException,
            ParserConfigurationException, SQLException, TransformerException,
            IOException, InvocationTargetException, Exception
    {
        _missingissueFormBean = new missingissueFormBean();


        String sql = Queries.getQuery("get_subscriber_detail");
        PreparedStatement stGet = conn.prepareStatement(sql);
        int paramIndex = 1;
        stGet.setString(paramIndex, request.getParameter("subscriberNumber"));
        ResultSet rs = this.db.executeQueryPreparedStatement(stGet);
        while (rs.next()) {
            BeanProcessor bProc = new BeanProcessor();
            Class type = Class.forName("IAS.Bean.missingissue.missingissueFormBean");
            this._missingissueFormBean = (IAS.Bean.missingissue.missingissueFormBean) bProc.toBean(rs, type);
        }
        _missingissueFormBean.setMiId(miId);
        _missingissueFormBean.setInwardNumber(request.getParameter("inwardNumber"));
        _missingissueFormBean.setSubscriberNumber(request.getParameter("subscriberNumber"));
        request.setAttribute("missingissueFormBean", _missingissueFormBean);
    }
}