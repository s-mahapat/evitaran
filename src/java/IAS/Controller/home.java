/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Controller;

import IAS.Class.Database;
import IAS.Class.JDSLogger;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author Shailendra Mahapatra
 */
public class home extends JDSController {

    private ServletContext context = null;
    private static final String jdbcDriver = "com.mysql.jdbc.Driver";
    private Connection connection;
    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Controller.home");

    @Override
    public void init() throws ServletException {

        try {
            this.context = getServletContext();
            Class.forName(jdbcDriver); //set Java database connectivity driver
        } catch (ClassNotFoundException e) {
            logger.error(e.getMessage());
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
    }

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

        String username = context.getInitParameter("db_user");
        String password = context.getInitParameter("db_password");
        String dbURL =
                context.getInitParameter("db_driver") + "://"
                + context.getInitParameter("db_host") + "/"
                + context.getInitParameter("db_name");

        String url = null;
        HttpSession session = request.getSession(true);
        logger.debug("Created a new session with id: " + session.getId());
        synchronized (session) {

            //get the connection from the session if it exists.
            try {
                Database db = (Database) session.getAttribute("db_connection");
                if (db != null) {
                    db.close(); //close the existing connection, to reopen another one
                }
                connection = DriverManager.getConnection(dbURL, username, password);
                connection.setAutoCommit(true);
                db = new Database(connection);
                session.setAttribute("db_connection", db);
                session.setAttribute("inwardUnderProcess", null);
                url = "jsp/home.jsp";

            } catch (SQLException e) {
                url = "jsp/errors/error.jsp";
            } finally {
                RequestDispatcher rd = request.getRequestDispatcher(url);
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
