/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Controller;

import IAS.Bean.User.LoggedInUserBean;
import IAS.Class.Database;
import IAS.Class.JDSLogger;
import IAS.Class.Queries;
import java.io.IOException;
import java.sql.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
//import com.mysql.jdbc.PreparedStatement;

/**
 *
 * @author Shailendra Mahapatra
 */
public class home extends JDSController {

    //private ServletContext context = null;
    private static final String jdbcDriver = "com.mysql.jdbc.Driver";
    private Connection connection;
    private static final Logger logger = JDSLogger.getJDSLogger(home.class.getName());
    private ServletContext context;

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

    @Override
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String url;
        HttpSession session = request.getSession(false);
        if (null == session.getAttribute("name")) {
            session = request.getSession(true);
            logger.debug("Created a new session with id: " + session.getId());
            synchronized (session) {

                //get the connection from the session if it exists.
                try {
                    connection = (Connection) session.getAttribute("connection");
                    if (connection == null) {
                        String username = context.getInitParameter("db_user");
                        String password = context.getInitParameter("db_password");
                        String dbURL = context.getInitParameter("db_driver") + "://" + context.getInitParameter("db_host") + "/" + context.getInitParameter("db_name");

                        connection = DriverManager.getConnection(dbURL, username, password);
                        session.setAttribute("connection", connection);
                    }
                    connection.setAutoCommit(true);
                    //db = new Database(connection);
                    //session.setAttribute("db_connection", db);
                    session.setAttribute("inwardUnderProcess", null);

                    String sql = Queries.getQuery("logged_in_user");
                    String userName = request.getUserPrincipal().getName();

                    //For monochrome users
                    String userRole = null;
                    boolean isMonochrome = request.isUserInRole("monochrome");
                    if (isMonochrome) {
                        userRole = "monochrome";
                    }

                    // set the user information in the session
                    PreparedStatement pst = connection.prepareStatement(sql);
                    pst.setString(1, userName);
                    ResultSet rs = pst.executeQuery();
                    rs.first();
                    String firstName = rs.getString(1);
                    String lastName = rs.getString(2);
                    boolean isPasswordReset = rs.getBoolean(3);

                    LoggedInUserBean userBean = new LoggedInUserBean();
                    userBean.setUserName(userName);
                    userBean.setFirstName(firstName);
                    userBean.setLastName(lastName);
                    userBean.setUserRole(userRole);
                    session.setAttribute("userBean", userBean);

                    url = "jsp/home.jsp";

                    // if the password was reset then redirect him to change password screen
                    if (isPasswordReset) {
                        url = "jsp/login/changepwd.jsp";
                    }


                } catch (Exception e) {
                    logger.fatal(e);
                    url = "jsp/errors/error.jsp";
                }

            }
        } else {
            url = "jsp/home.jsp";
        }
        RequestDispatcher rd = request.getRequestDispatcher(url);
        rd.forward(request, response);


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
