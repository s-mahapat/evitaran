/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Servlet;

import IAS.Class.JDSLogger;
import IAS.Class.Queries;
import IAS.Class.ServletContextInfo;
import IAS.Class.convertToPdf;
import IAS.Controller.JDSController;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author aloko
 */
public class pdfserver extends JDSController {

    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Servlet.pdfserver");

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        try (ServletOutputStream os = response.getOutputStream()) {
            if(action.equalsIgnoreCase("printResultset")){
                /*
                ServletContext context = ServletContextInfo.getServletContext();
                String emailPropertiesFile =  context.getRealPath("/WEB-INF/classes/jds_missingissue.properties");
                Properties properties = new Properties();
                properties.load(new FileInputStream(emailPropertiesFile));
                String msg = properties.getProperty("missingIssueNoCopy");
                 */

                String query = (String) request.getAttribute("query");
                ResultSet rs = (ResultSet) request.getAttribute("ResultSet");

                convertToPdf c2Pdf = new convertToPdf();
                //c2Pdf.printMIresponse(os, msg);
                c2Pdf.convertResultSetToPdf(os, rs, query);
                response.setContentType("application/pdf");
                response.setHeader("Content-disposition", "attachment; filename=report.pdf");
                os.flush();

            } else if(action.equalsIgnoreCase("printXML")){

                String query = (String) request.getAttribute("query");
                String xml = (String) request.getAttribute("xml");
                /*
                String filename = "output.pdf";
                Object obj = request.getAttribute("filename");
                if(obj != null){
                    filename = obj.toString();
                }
                */

                convertToPdf c2Pdf = new convertToPdf();
                c2Pdf.convertXMLResponseToPDF(os, xml, query);

                response.setContentType("application/pdf");
                response.setHeader("Content-disposition", "attachment; filename=report.pdf");
                //response.setHeader("Content-disposition", "attachment; filename=" + filename);
                os.flush();

            }else if(action.equalsIgnoreCase("generatemlPrintLabel")){
                logger.debug("Start of mailing list label generation");
                ResultSet rs = (ResultSet) request.getAttribute("ResultSet");

                String noHeader = request.getParameter("noHeader");
                String periodicals = request.getParameter("periodicals");
                convertToPdf c2Pdf = new convertToPdf(noHeader, periodicals);
                c2Pdf.addLabelContent(rs, os);
                response.setContentType("application/pdf");
                response.setHeader("Content-disposition", "attachment; filename=ml.pdf");
                os.flush();
                logger.debug("End of mailing list label generation");

            }else if(action.equalsIgnoreCase("generatemlPrintSticker")){
                logger.debug("Start of mailing list sticker generation");
                ResultSet rs = (ResultSet) request.getAttribute("ResultSet");
                String noHeader = request.getParameter("noHeader");
                String periodicals = request.getParameter("periodicals");
                convertToPdf c2Pdf = new convertToPdf(noHeader, periodicals);
                c2Pdf.addStickerContent(rs, os);
                response.setContentType("application/pdf");
                response.setHeader("Content-disposition", "attachment; filename=ml.pdf");
                os.flush();
                logger.debug("End of mailing list sticker generation");

            }else if(action.equalsIgnoreCase("miPrintNoCopies")){
                ServletContext context = ServletContextInfo.getServletContext();
                String emailPropertiesFile =  context.getRealPath("/WEB-INF/classes/jds_missingissue.properties");
                Properties properties = new Properties();
                properties.load(new FileInputStream(emailPropertiesFile));

                String msg = properties.getProperty("missingIssueNoCopy");

                convertToPdf c2Pdf = new convertToPdf();
                c2Pdf.printMIresponse(os, msg);

                response.setContentType("application/pdf");
                response.setHeader("Content-disposition", "attachment; filename=missing_issue.pdf");
                os.flush();

            }else if(action.equalsIgnoreCase("miPrintAlreadySent")){
                ServletContext context = ServletContextInfo.getServletContext();
                String emailPropertiesFile =  context.getRealPath("/WEB-INF/classes/jds_missingissue.properties");
                Properties properties = new Properties();
                properties.load(new FileInputStream(emailPropertiesFile));

                String msg = properties.getProperty("missingIssueAlreadySent");

                convertToPdf c2Pdf = new convertToPdf();
                c2Pdf.printMIresponse(os, msg);

                response.setContentType("application/pdf");
                response.setHeader("Content-disposition", "attachment; filename=missing_issue.pdf");
                os.flush();

            } else if(action.equalsIgnoreCase("printRemindersPrintAll")){

                /*
                ResultSet rsGet = (ResultSet) request.getAttribute("ResultSet");

                //Loop the data for individual subscriber for reminder
                while (rsGet.next()){
                   //Extract subscriber Details


                   //get the subscription details
                   String sqlgetjnls = Queries.getQuery("get_subscribed_journals");
                   PreparedStatement stgetjnls = conn.prepareStatement(sqlgetjnls);
                   int paramIndex = 1;
                   Object reminderId = null;
                   reminderId = rsGet.getObject(1);
                   stgetjnls.setInt(paramIndex, rsGet.getInt(1));
                   ResultSet rsgetjnls = this.db.executeQueryPreparedStatement(stgetjnls);

                  //Compose and send mail
                        ServletContext context = ServletContextInfo.getServletContext();
                        String emailPropertiesFile =  context.getRealPath("/WEB-INF/classes/jds_missingissue.properties");
                        Properties properties = new Properties();
                        properties.load(new FileInputStream(emailPropertiesFile));
                        String msg = properties.getProperty("missingIssueNoCopy");
                        String to = request.getParameter("email");
                        msgsend sendMsg = new msgsend();
                        status = sendMsg.sendMailWithAuthenticationUseTLS(to, "", "jds.ias.mails@gmail.com", "Missing Issues", msg, "", "", null);


                  // insert the record to sent reminders
                  int ins =insertReminderDetails(reminderId.toString(), medium);
                }
                 *
                 */
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            throw new javax.servlet.ServletException(e);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
