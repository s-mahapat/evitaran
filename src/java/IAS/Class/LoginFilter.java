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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
            throws IOException, ServletException, SQLException {
        if (debug) {
            log("LoginFilter:DoAfterProcessing");
        }
        String url = null;
        boolean isPasswordReset = false;

        // Write code here to process the request and/or response after
        // the rest of the filter chain is invoked.
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession(false);
        LoggedInUserBean ubean = (LoggedInUserBean) session.getAttribute("userBean");

        // if the user bean is already populated, we do not need
        // to create the bean and connection again.
        if (ubean == null && req.getUserPrincipal() != null) {
            synchronized (session) {
                // get the connection from the session if it exists.
                try (Connection conn = Database.getConnection()) {
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

                        LoggedInUserBean userBean = new LoggedInUserBean();

                        // set the user information in the session
                        try (PreparedStatement pst = conn.prepareStatement(sql)) {
                            pst.setString(1, userName);
                            try (ResultSet rs = pst.executeQuery()) {
                                rs.first();
                                String firstName = rs.getString(1);
                                String lastName = rs.getString(2);
                                isPasswordReset = rs.getBoolean(3);
                                userBean.setUserName(userName);
                                userBean.setFirstName(firstName);
                                userBean.setLastName(lastName);
                            }

                        }
                        userBean.setUserRole(userRole);
                        session.setAttribute("userBean", userBean);
                    }

                    // if the password was reset then redirect him to change password screen
                    if (isPasswordReset) {
                        url = "jsp/login/changepwd.jsp";
                    }
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
        Throwable problem = null;
        if (debug) {
            log("LoginFilter:doFilter()");
        }
        try {
            doBeforeProcessing(request, response);
            chain.doFilter(request, response);
            doAfterProcessing(request, response);
        } catch (SQLException ex) {
            RequestDispatcher rd = request.getRequestDispatcher("/jsp/login/login.jsp");
            rd.forward(request, response);
        } catch (IOException | ServletException ex) {
            problem = ex;
        }

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
