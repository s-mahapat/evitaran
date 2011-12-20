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
import IAS.Model.inwardModel;
import IAS.Bean.inwardFormBean;
import java.sql.SQLException;

/**
 *
 * @author Shailendra Mahapatra
 */
public class inward extends HttpServlet {

    private inwardModel _inwardModel = null;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String url = null;

        inwardFormBean _inwardFormBean = new IAS.Bean.inwardFormBean();
        /* set the attribute to the same name as the bean id used in the inward form, else
         * the next screen may not have the bean contents accessible. The bean has to be passed on in the
         * request to the next page
         */
        //
        try {

            _inwardModel = new IAS.Model.inwardModel(request, _inwardFormBean);
            if (action.equalsIgnoreCase("save")) {

                //if the record count saved is 1, it indicates that the record was saved else fail.
                if(_inwardModel.Save(request, _inwardFormBean) == 1){
                   url = "/jsp/inward/viewinward.jsp";
               }else{
                   url = "/jsp/errors/error.jsp";
               }

            } else if (action.equalsIgnoreCase("edit")) {
                url = "/jsp/inward/editinward.jsp";
            } else if (action.equalsIgnoreCase("view")) {
                url = "/jsp/inward/viewinward.jsp";
            } else if (action.equalsIgnoreCase("sendAck")) {
                url = "/jsp/inward/ackinward.jsp";
            } else if (action.equalsIgnoreCase("sendReturn")) {
                url = "/jsp/inward/returninward.jsp";
            }


        } catch (SQLException e) {
            url = "/jsp/errors/error.jsp";
        } catch (Exception e) {
            url = "/jsp/errors/error.jsp";
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
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
