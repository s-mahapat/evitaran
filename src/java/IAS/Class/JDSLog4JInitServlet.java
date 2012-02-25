/*
 * Reference - http://www.avajava.com/tutorials/lessons/how-do-i-change-my-log4j-settings-while-my-web-application-is-running.html
 *
 * Log file is present at ${catalina.home}/logs/JDS/jds.log. catalina.home = directory where Tomcat is installed
 *
 * To re-load the log4j properties file at run-time, type in the following in the browser
 * http://localhost:8080/JDS/JDSLog4JInitServlet?reloadPropertiesFile
 *
 * Different logging levels available are: DEBUG, INFO, WARN, ERROR, FATAL
 * To change the log level at run-time, type in the following in the browser
 * http://localhost:8080/JDS/JDSLog4JInitServlet?logLevel=WARN
 * This will change the default level from DEBUG to WARN
 *
 */
package IAS.Class;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.BasicConfigurator;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

/**
 *
 * @author aloko
 */
public class JDSLog4JInitServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    public void init(ServletConfig config) throws ServletException {
            System.out.println("Log4JInitServlet is initializing log4j");
            String log4jLocation = config.getInitParameter("log4j-properties-location");

            ServletContext sc = config.getServletContext();

            if (log4jLocation == null) {
                    System.err.println("*** No log4j-properties-location init param, so initializing log4j with BasicConfigurator");
                    BasicConfigurator.configure();
            } else {
                    String webAppPath = sc.getRealPath("/");
                    String log4jProp = webAppPath + log4jLocation;
                    File JDSLoggerPropertiesFile = new File(log4jProp);
                    if (JDSLoggerPropertiesFile.exists()) {
                            System.out.println("Initializing log4j with: " + log4jProp);
                            PropertyConfigurator.configure(log4jProp);
                    } else {
                            System.err.println("*** " + log4jProp + " file not found, so initializing log4j with BasicConfigurator");
                            BasicConfigurator.configure();
                    }
            }
            super.init(config);
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
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
		response.setContentType("text/html");
		out = response.getWriter();
		out.println("This is the Log4JInitServlet<br/>");
		String logLevel = request.getParameter("logLevel");
		String reloadPropertiesFile = request.getParameter("reloadPropertiesFile");
		if (logLevel != null) {
			setLogLevelWithParameter(out, logLevel);
		} else if (reloadPropertiesFile != null) {
			out.println("Attempting to reload log4j properties file<br/>");
			loadLog4jPropertiesFile(out);
		} else {
			out.println("no logLevel or reloadPropertiesFile parameters were found<br/>");
		}
        } finally {
            out.close();
        }
    }

    private void setLogLevelWithParameter(PrintWriter out, String logLevel) {
            Logger root = Logger.getRootLogger();
            boolean logLevelRecognized = true;
            if ("DEBUG".equalsIgnoreCase(logLevel)) {
                    root.setLevel(Level.DEBUG);
            } else if ("INFO".equalsIgnoreCase(logLevel)) {
                    root.setLevel(Level.INFO);
            } else if ("WARN".equalsIgnoreCase(logLevel)) {
                    root.setLevel(Level.WARN);
            } else if ("ERROR".equalsIgnoreCase(logLevel)) {
                    root.setLevel(Level.ERROR);
            } else if ("FATAL".equalsIgnoreCase(logLevel)) {
                    root.setLevel(Level.FATAL);
            } else {
                    logLevelRecognized = false;
            }

            if (logLevelRecognized) {
                    out.println("Log level has been set to: " + logLevel + "<br/>");
            } else {
                    out.println("logLevel parameter '" + logLevel + "' level not recognized<br/>");
            }
    }

    private void loadLog4jPropertiesFile(PrintWriter out) {
            ServletContext sc = getServletContext();
            String log4jLocation = getInitParameter("log4j-properties-location");

            if (log4jLocation == null) {
                    out.println("*** No log4j-properties-location init param, so initializing log4j with BasicConfigurator<br/>");
                    BasicConfigurator.configure();
            } else {
                    String webAppPath = sc.getRealPath("/");
                    String log4jProp = webAppPath + log4jLocation;
                    File log4jFile = new File(log4jProp);
                    if (log4jFile.exists()) {
                            out.println("Initializing log4j with: " + log4jProp + "<br/>");
                            PropertyConfigurator.configure(log4jProp);
                    } else {
                            out.println("*** " + log4jProp + " file not found, so initializing log4j with BasicConfigurator<br/>");
                            BasicConfigurator.configure();
                    }
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
        return "JDS Log4J Configurator";
    }// </editor-fold>
}
