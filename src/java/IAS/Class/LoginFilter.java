/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import IAS.Bean.User.LoggedInUserBean;
import IAS.Controller.home;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author smahapat
 */
public class LoginFilter implements Filter {

    private static final boolean debug = false;
    private static final String jdbcDriver = "com.mysql.jdbc.Driver";
    private static final Logger logger = JDSLogger.getJDSLogger(home.class.getName());
    private Connection connection;
    private ServletContext context;
    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured.
    private FilterConfig filterConfig = null;

    public LoginFilter() {
        this.context = ServletContextInfo.getServletContext();
        try {
            Class.forName(jdbcDriver);    // set Java database connectivity driver
        } catch (ClassNotFoundException e) {
            logger.error(e.getMessage());
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
    }

    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("LoginFilter:DoBeforeProcessing");
        }
        // Write code here to process the request and/or response before
        // the rest of the filter chain is invoked.

        // For example, a logging filter might log items on the request object,
        // such as the parameters.

    }

    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("LoginFilter:DoAfterProcessing");
        }
        String url = null;
        boolean isPasswordReset = false;

        // Write code here to process the request and/or response after
        // the rest of the filter chain is invoked.
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession(false);

        if (req.getUserPrincipal() != null) {
            synchronized (session) {
                // get the connection from the session if it exists.
                try {
                    connection = (Connection) session.getAttribute("connection");

                    if (connection == null) {
                        String username = context.getInitParameter("db_user");
                        String password = context.getInitParameter("db_password");
                        String dbURL = context.getInitParameter("db_driver") + "://"
                                + context.getInitParameter("db_host") + "/"
                                + context.getInitParameter("db_name");

                        connection = DriverManager.getConnection(dbURL, username, password);
                        session.setAttribute("connection", connection);
                    }

                    connection.setAutoCommit(true);

                    // db = new Database(connection);
                    // session.setAttribute("db_connection", db);
                    session.setAttribute("inwardUnderProcess", null);

                    String sql = Queries.getQuery("logged_in_user");
                    if (req.getUserPrincipal() != null) {
                        String userName = req.getUserPrincipal().getName();

                        // For monochrome users
                        String userRole = null;
                        boolean isMonochrome = req.isUserInRole("monochrome");
                        boolean isReadonly = req.isUserInRole("readonly");

                        if (isMonochrome) {
                            userRole = "monochrome";
                        } else if (isReadonly) {
                            userRole = "readonly";
                        }

                        // set the user information in the session
                        PreparedStatement pst = connection.prepareStatement(sql);

                        pst.setString(1, userName);

                        ResultSet rs = pst.executeQuery();

                        rs.first();

                        String firstName = rs.getString(1);
                        String lastName = rs.getString(2);
                        isPasswordReset = rs.getBoolean(3);
                        LoggedInUserBean userBean = new LoggedInUserBean();

                        userBean.setUserName(userName);
                        userBean.setFirstName(firstName);
                        userBean.setLastName(lastName);
                        userBean.setUserRole(userRole);
                        session.setAttribute("userBean", userBean);
                    }

                    // if the password was reset then redirect him to change password screen
                    if (isPasswordReset) {
                        url = "jsp/login/changepwd.jsp";
                    }
                } catch (Exception e) {
                    logger.fatal(e);
                    url = "jsp/errors/error.jsp";
                }
            }
            // if the url is set then only forward the request, else just ignore
            if (url != null) {
                RequestDispatcher rd = request.getRequestDispatcher(url);
                rd.forward(request, response);
            }
        }
    }

    /**
     *
     * @param request The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        if (debug) {
            log("LoginFilter:doFilter()");
        }

        doBeforeProcessing(request, response);

        Throwable problem = null;
        try {
            chain.doFilter(request, response);
        } catch (Throwable t) {
            // If an exception is thrown somewhere down the filter chain,
            // we still want to execute our after processing, and then
            // rethrow the problem after that.
            problem = t;
            t.printStackTrace();
        }

        doAfterProcessing(request, response);

        // If there was a problem, we want to rethrow it if it is
        // a known type, otherwise log it.
        if (problem != null) {
            if (problem instanceof ServletException) {
                throw (ServletException) problem;
            }
            if (problem instanceof IOException) {
                throw (IOException) problem;
            }
            sendProcessingError(problem, response);
        }
    }

    /**
     * Return the filter configuration object for this filter.
     */
    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    /**
     * Set the filter configuration object for this filter.
     *
     * @param filterConfig The filter configuration object
     */
    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    /**
     * Destroy method for this filter
     */
    public void destroy() {
    }

    /**
     * Init method for this filter
     */
    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {
                log("LoginFilter:Initializing filter");
            }
        }
    }

    /**
     * Return a String representation of this object.
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("LoginFilter()");
        }
        StringBuffer sb = new StringBuffer("LoginFilter(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }

    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);

        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); //NOI18N

                // PENDING! Localize this for next official release
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");
                pw.print(stackTrace);
                pw.print("</pre></body>\n</html>"); //NOI18N
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        }
    }

    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
        }
        return stackTrace;
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }
}
