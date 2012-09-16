/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Controller.UserMgr;

import IAS.Model.UserMgr.ResetPwdModel;
import java.io.IOException;
import java.rmi.ServerException;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Shailendra
 */
public class ChangePwd extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String newPassword = request.getParameter("passwordField");

        try {
            ResetPwdModel _rpwModel = new ResetPwdModel();
            boolean isPwdchanged = _rpwModel.updatePassword(email, newPassword);
            if (isPwdchanged) {
                response.sendRedirect(request.getContextPath() + "/home");
                //RequestDispatcher rd = request.getRequestDispatcher("/home");
                //rd.forward(request, response);
            }
        } catch (SQLException e) {
            throw (new ServerException(e.getMessage()));
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
