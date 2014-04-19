/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Controller;

import java.io.IOException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Shailendra
 */
public class LogoutController extends JDSController {
    
    private final HttpServletRequest req;
    private final HttpServletResponse resp;
    private final ServletContext context;
    private final String[] params;
    
    public LogoutController(HttpServletRequest req, HttpServletResponse resp, ServletContext context, String[] params) {
        this.req = req;
        this.resp = resp;
        this.context = context;
        this.params = params;
    }
    
    public void actionDo()
            throws ServletException, IOException {
        String url = context.getContextPath();
        HttpSession session = this.req.getSession(false);        
        if (session != null) {
            session.setMaxInactiveInterval(0);
            session.invalidate();
            this.resp.sendRedirect(url + "/jsp/home.jsp");
        }
        //RequestDispatcher rd = getServletContext().getRequestDispatcher("/jsp/home.jsp");
        //rd.forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
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
     * Handles the HTTP <code>POST</code> method.
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
