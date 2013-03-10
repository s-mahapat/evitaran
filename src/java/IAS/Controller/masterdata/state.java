package IAS.Controller.masterdata;

//~--- non-JDK imports --------------------------------------------------------

import IAS.Class.JDSLogger;

import IAS.Controller.JDSController;

import IAS.Model.masterdata.stateModel;

import org.apache.log4j.Logger;

//~--- JDK imports ------------------------------------------------------------

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class state extends JDSController {
    private static final Logger logger      = JDSLogger.getJDSLogger("IAS.Controller.masterData");
    private stateModel          _stateModel = null;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String url    = null;

        try {
            _stateModel = new IAS.Model.masterdata.stateModel(request);

            if (action.equalsIgnoreCase("save")) {
                _stateModel.Save();
                url = "/jsp/masterdata/displayState.jsp";
            } else if (action.equalsIgnoreCase("edit")) {
                _stateModel.editState();
                url = "/jsp/masterdata/editState.jsp";
            } else if (action.equalsIgnoreCase("view")) {
                _stateModel.viewState();
                url = "/jsp/masterdata/displayState.jsp";
            } else if (action.equalsIgnoreCase("search")) {

                // searchInward gets all the inwards based on the search criteria entered on screen by the user.
                String xml = _stateModel.searchState();

                request.setAttribute("xml", xml);
                url = "/xmlserver";
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);

            throw new javax.servlet.ServletException(e);
        } finally {
            if (url == null) {
                url = "/jsp/errors/404.jsp";
                logger.error("Redirect url was not found, forwarding to 404");
            } else {
                logger.debug("Called->" + url);
            }

            RequestDispatcher rd = getServletContext().getRequestDispatcher(url);

            if ((rd != null) && (url != null)) {
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
    }    // </editor-fold>
}


//~ Formatted by Jindent --- http://www.jindent.com
