/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import IAS.Model.Subscriber.subscriberModel;
import org.apache.log4j.*;
import IAS.Class.JDSLogger;

public class subscriber extends HttpServlet {

    private subscriberModel _subscriberModel = null;
    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Controller.subscriber");

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String url = null;
        try {

            _subscriberModel = new IAS.Model.Subscriber.subscriberModel(request);

            if (action.equalsIgnoreCase("save")) {
                //if the record count saved is 1, it indicates that the record was saved else fail.
                if (_subscriberModel.Save() == 1) {
                    url = "/jsp/subscriber/viewsubscriber.jsp";
                }
            } else if (action.equalsIgnoreCase("edit")) {
                if (_subscriberModel.editSubscriber() != null) {
                    url = "/jsp/subscriber/editsubscriber.jsp";
                }
            } else if (action.equalsIgnoreCase("display")) {
                if (_subscriberModel.viewSubscriber() != null) {
                    url = "/jsp/subscriber/viewsubscriber.jsp";
                }
            } else if (action.equalsIgnoreCase("search")) {

                String xml = _subscriberModel.searchSubscriber();
                request.setAttribute("xml", xml);
                url = "/xmlserver";

            } else if (action.equalsIgnoreCase("viewsubscription")) {

                //fill in the subscriber bean
                if (_subscriberModel.GetSubscriber() != null) {
                    url = "/jsp/subscription/viewsubscription.jsp";
                }

            } else if (action.equalsIgnoreCase("editsubscription")) {

                //fill in the subscriber bean
                if (_subscriberModel.GetSubscriber() != null) {
                    url = "/jsp/subscription/editsubscription.jsp";
                }
            } else if (action.equalsIgnoreCase("add")) {

                //fill in the subscriber bean
                if (_subscriberModel.GetSubscriber() != null) {
                    url = "/jsp/subscription/addnewsubscription.jsp";
                }

            } else if (action.equalsIgnoreCase("gpi")) {
                url = "/jsp/invoice/proforma.jsp";
            } else if (action.equalsIgnoreCase("mil")) {
                url = "/jsp/missingissue/missingissuelist.jsp";
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            throw new javax.servlet.ServletException(e);
        } finally {
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
