/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Controller.masterdata;

import IAS.Class.JDSLogger;
import IAS.Controller.JDSController;
import IAS.Model.masterdata.journalDetailsModel;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author aloko
 */
public class journalDetails extends JDSController {

    private journalDetailsModel _journalDetailsModel = null;
    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Controller.masterData");

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String url = null;

        try{

            _journalDetailsModel = new IAS.Model.masterdata.journalDetailsModel(request);

            if(action.equalsIgnoreCase("searchJournalDetails")){

                String xml = _journalDetailsModel.searchJournalDetails();
                request.setAttribute("xml", xml);
                url = "/xmlserver";

            } else if(action.equalsIgnoreCase("getPageSize")){
                String xml =
                    "<select>" +
                        "<option value='A4'>A4</option>" +
                        "<option value='Other'>Other</option>" +
                    "</select>";
                request.setAttribute("xml", xml);
                url = "/xmlserver";

            } else if(action.equalsIgnoreCase("save")) {
                String xml = _journalDetailsModel.save();
                request.setAttribute("xml", xml);
                //url = "/jsp/masterdata/journalDetails.jsp";
                url = "/xmlserver";

            } else if(action.equalsIgnoreCase("goToJournalVolumeDetails")) {
                url = "/jsp/masterdata/journalVolumeDetails.jsp";
            } else if(action.equalsIgnoreCase("goToJournalDetails")) {
                url = "/jsp/masterdata/journalDetails.jsp";
            } else if(action.equalsIgnoreCase("getMonths")) {
                String xml = _journalDetailsModel.getMonths();
                request.setAttribute("xml", xml);
                url = "/xmlserver";
            } else if(action.equalsIgnoreCase("searchJournalVolumeDetails")) {
                String xml = _journalDetailsModel.searchJournalVolumeDetails();
                request.setAttribute("xml", xml);
                url = "/xmlserver";
            } else if(action.equalsIgnoreCase("saveJournalVolumeDetails")) {
                _journalDetailsModel.saveJournalVolumeDetails();
                //url = "/jsp/masterdata/journalVolumeDetails.jsp";
                url = "/xmlserver";
            }

        }catch (Exception e) {
            logger.error(e.getMessage(), e);
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
     * Handles the HTTP
     * <code>GET</code> method.
     *
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
     * Handles the HTTP
     * <code>POST</code> method.
     *
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
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
