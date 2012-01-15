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

/**
 *
 * @author Shailendra Mahapatra
 */
public class addMasterData extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String url = null;
        if (action.equalsIgnoreCase("addSubType")) {

            url = "/jsp/masterdata/addNewSubType.jsp";
        } else if (action.equalsIgnoreCase("addJournal")) {

            url = "/jsp/masterdata/addJournal.jsp";

        } else if (action.equalsIgnoreCase("addAgent")) {

            url = "/jsp/masterdata/addAgent.jsp";
        } else if (action.equalsIgnoreCase("addCity")) {

            url = "/jsp/masterdata/addCity.jsp";

        } else if (action.equalsIgnoreCase("addCountry")) {

            url = "/jsp/masterdata/addCountry.jsp";

        } else if (action.equalsIgnoreCase("addDistrict")) {

            url = "/jsp/masterdata/addDistrict.jsp";

        } else if (action.equalsIgnoreCase("addState")) {

            url = "/jsp/masterdata/addState.jsp";

        }
        RequestDispatcher rd = request.getRequestDispatcher(url);
        rd.forward(request, response);


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
