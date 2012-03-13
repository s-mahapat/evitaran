
package IAS.Controller.reports;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import IAS.Model.Reports.reportModel;

import org.apache.log4j.Logger;
import IAS.Class.JDSLogger;
import IAS.Class.msgsend;
import IAS.Class.util;
import java.sql.ResultSet;
import javax.servlet.ServletContext;
/**
 *
 * @author Deepali
 */
public class reports extends HttpServlet {

    private reportModel _reportModel = null;
    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Controller.reports");

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String url = null;

        try{

            _reportModel = new IAS.Model.Reports.reportModel(request);

            if(action.equalsIgnoreCase("listJournal")){

                ResultSet rs = _reportModel.searchJournal();
                String xml = util.convertResultSetToXML(rs);
                request.setAttribute("xml", xml);
                url = "/xmlserver";

            }else if(action.equalsIgnoreCase("listJournalPrint")){

                ResultSet rs = _reportModel.searchJournal();
                request.setAttribute("ResultSet", rs);
                url = "/jsp/reports/listJournalPrint.jsp";

            }else if(action.equalsIgnoreCase("listSubType")){

                ResultSet rs = _reportModel.searchSubType();
                String xml = util.convertResultSetToXML(rs);
                request.setAttribute("xml", xml);
                url = "/xmlserver";

            }else if(action.equalsIgnoreCase("listSubTypePrint")){

                ResultSet rs = _reportModel.searchSubType();
                request.setAttribute("ResultSet", rs);
                url = "/jsp/reports/listSubTypePrint.jsp";

            }else if(action.equalsIgnoreCase("listInwards")){

                String xml = _reportModel.searchInwards();
                request.setAttribute("xml", xml);
                url = "/xmlserver";
            }else if(action.equalsIgnoreCase("listAgents")){

                String xml = _reportModel.searchAgents();
                request.setAttribute("xml", xml);
                url = "/xmlserver";
            }

        }catch (Exception e) {
            logger.error(e.getMessage(), e);

            ServletContext context = getServletContext();
            String emailPropertiesFile = context.getRealPath("/WEB-INF/classes/jds_email.properties");
            msgsend smtpMailSender = new msgsend();
            smtpMailSender.sendMailWithAuthentication(
                    emailPropertiesFile,
                    "jds.adm.all@gmail.com", "", "",
                    "Exception generated in JDS code",
                    util.getExceptionStackTraceAsString(e),
                    "JDS", "");

            throw new javax.servlet.ServletException(e);

        } finally {
            if(url == null){
                url = "/jsp/errors/404.jsp";
                logger.error("Redirect url was not found, forwarding to 404");
            }
            else
            {
                logger.debug("Called->" + url);
            }
            RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
            if (rd != null && url != null) {
                rd.forward(request, response);
            }
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
