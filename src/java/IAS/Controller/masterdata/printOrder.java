package IAS.Controller.masterdata;

//~--- non-JDK imports --------------------------------------------------------

import IAS.Class.JDSLogger;

import IAS.Controller.JDSController;

import IAS.Model.masterdata.printOrderModel;

import org.apache.log4j.Logger;

//~--- JDK imports ------------------------------------------------------------

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Shailendra Mahapatra
 */
public class printOrder extends JDSController {
    private static final Logger logger           = JDSLogger.getJDSLogger("IAS.Controller.masterData");
    private printOrderModel     _printOrderModel = null;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String url    = null;

        try {
            _printOrderModel = new IAS.Model.masterdata.printOrderModel(request);

            /*
             * if(action.equalsIgnoreCase("add")){
             *
             *   String xml = _printOrderModel.addPrintOrder();
             *   request.setAttribute("xml", xml);
             *   url = "/xmlserver";
             *
             * }else
             */
            if (action.equalsIgnoreCase("save")) {
                _printOrderModel.Save();
                url = "/jsp/masterdata/displayPrintOrder.jsp";
            } else if (action.equalsIgnoreCase("searchPrintOrder")) {
                String xml = _printOrderModel.searchPrintOrder();

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
