/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Controller;

import IAS.Class.JDSLogger;
import IAS.Class.msgsend;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author Shailendra Mahapatra
 */
public class errorHandler extends JDSController {

    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Controller.errorHandler");

    @Override
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Throwable throwable = (Throwable) request.getAttribute(RequestDispatcher.ERROR_EXCEPTION);
        StackTraceElement elements[] = throwable.getStackTrace();
        String exceptionMessage = "<html><head><title>" + "Exception" + "</title></head><body><p>" +
                throwable.getClass().getCanonicalName();
        exceptionMessage += "<br>" + throwable.getMessage();
        exceptionMessage += "<br>---------------------------------<br>";

        for (int i = 0, n = elements.length; i < n; i++) {

            exceptionMessage += "<br>Class: " + elements[i].getClassName() + "<br>";
            exceptionMessage += "Method Name: " + elements[i].getMethodName() + "<br>";
            exceptionMessage += "Line Number: " + elements[i].getLineNumber() + "<br>";
            exceptionMessage += "File Name: " + elements[i].getFileName() + "<br>";
            exceptionMessage += "---------------------------------------------<br>";
        }
        exceptionMessage = exceptionMessage + "</body></html>";

        //String exceptionMessage = throwable.getMessage();
        //StackTraceElement[] trace = throwable.getStackTrace();
        logger.fatal(throwable);
        msgsend smtpMailSender = new msgsend();

        smtpMailSender.sendExceptionMail(exceptionMessage);

        if (this.isAjax(request)) {
            response.setStatus(500);
            response.getWriter().write("Error in processing request");
        } else {
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/jsp/errors/error.jsp");
            rd.forward(request, response);
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
