/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Controller;

import IAS.Class.Database;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;
import javax.servlet.*;
import java.sql.*;
/**
 *
 * @author Shailendra Mahapatra
 */
public class home extends HttpServlet {

    private ServletContext context = null;
    private static final String jdbcDriver = "com.mysql.jdbc.Driver";
    private static String dbURL = "jdbc:mysql://localhost/";
    private Connection connection;

    @Override
    public void init() throws ServletException {
        try {
            this.context = getServletContext();
            Class.forName(jdbcDriver); //set Java database connectivity driver
        } catch (ClassNotFoundException e) {
            //System.out.println(e.getMessage());
        } catch (Exception e) {
            //System.out.println(e.getMessage());
        }
    }
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = context.getInitParameter("db_user");
        String password = context.getInitParameter("db_password");
        dbURL += context.getInitParameter("db_name") ;

        try {
            HttpSession session = request.getSession(true);
            synchronized(session){
                //get the connection from the session if it exists.

                Database db = (Database)session.getAttribute("db_connection");
                if(db == null){
                    connection = DriverManager.getConnection(dbURL, username, password);
                    db = new Database(connection,request.getServletContext());
                    session.setAttribute("db_connection", db);
                }


            }

        } catch (Exception e) {
            //System.out.println(e.getMessage());
        }
        String url = "jsp/home.jsp";
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
