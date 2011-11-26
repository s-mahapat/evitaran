/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Servlet;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author aloko
 */
@WebServlet(name = "errorHandler", urlPatterns = {"/errorHandler"})
public class errorHandler extends HttpServlet {

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @see Reference http://www.tutorialspoint.com/servlets/servlets-exception-handling.htm
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
                // Analyze the servlet exception       
                
                Integer statusCode = (Integer)
                request.getAttribute("javax.servlet.error.status_code");
                
                String exceptionType = (String)
                        request.getAttribute("javax.servlet.error.exception_type");
                
                String errorMsg = (String)
                        request.getAttribute("javax.servlet.error.message");
                
                String requestUri = (String)
                request.getAttribute("javax.servlet.error.request_uri");
                if (requestUri == null){
                 requestUri = "Unknown";
                } 
                
                Throwable throwable = (Throwable)
                request.getAttribute("javax.servlet.error.exception");
                
                String servletName = (String)
                        request.getAttribute("javax.servlet.error.servlet_name");
                if (servletName == null){
                 servletName = "Unknown";
                }

                // Set response content type
                response.setContentType("text/html");

                String title = "Error/Exception Information";
                String docType = "<!doctype html public \"-//w3c//dtd html 4.0 " + "transitional//en\">\n";
                out.println(docType +
                "<html>\n" +
                "<head><title>" + title + "</title></head>\n" +
                "<body bgcolor=\"#f0f0f0\">\n");
                
                out.println("Kindly report the following messages to " 
                        + "<A HREF=\"mailto:deepaligokhale7@gmail.com\">Deepali Gokhale</A>"                         
                        + "<br></br>");
                out.println("Click on the link to goto <a href=\""
                        + response.encodeURL("http://localhost:8080/JDS/jsp/home.jsp")
                        + "\">Home Page</a>."
                        + "<br></br>");

                out.println("<h2>Error information</h2>");
                out.println("Current Date and Time: " + new java.util.Date(System.currentTimeMillis())+ "<br></br>");
                out.println("The status code : " + statusCode + "<br></br>");
                out.println("Exception type : " + exceptionType + "<br></br>");
                out.println("Error Message : " + errorMsg + "<br></br>");
                out.println("Servlet Name : " + servletName + "</br></br>");
                out.println("The request URI: " + requestUri + "<br><br>");
                //out.println("Exception Type : " + throwable.getClass( ).getName( ) + "</br></br>");
                //out.println("The exception message: " + throwable.getMessage( ) + "<br></br>");
                out.println("Remote address: " + request.getRemoteAddr() + "tried to load http://" + request.getServerName() + request.getRequestURI() + "</br></br>");
                out.println("User agent = " + request.getHeader("User-Agent") + "</br></br>");
                
                Object exception = request.getAttribute( "javax.servlet.error.exception" );
                // if we have the exception dump it out to the page
                if( exception != null ) {
                    ByteArrayOutputStream bos = null;
                    try {
                        out.println( "<p><hr noshade><p><pre>" );
                        bos = new ByteArrayOutputStream();
                        PrintWriter writer = new PrintWriter( bos, true );
                        ( (Exception) exception ).printStackTrace( writer );
                        out.println( bos.toString() );
                    }
                    finally {
                        out.println( "</pre>" );
                        if( bos != null ) bos.close();
                    }
                }
    
                out.println("</body>");
                out.println("</html>");
        } finally {            
            out.close();
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
