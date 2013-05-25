package IAS.Controller;

//~--- JDK imports ------------------------------------------------------------
import IAS.Class.msgsend;
import IAS.Class.util;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;

@WebServlet(
    name = "JDSController",
urlPatterns = {"/JDSController"})
public class JDSController extends HttpServlet {

    /*
     * public JDSController(HttpServletRequest request) throws ServletException{
     *   this.session = request.getSession(false); //do not create the session if it does not exist
     *   if (this.session == null) {
     *       throw (new ServletException("Session does not exist.Database connection not found in the session"));
     *   }
     *
     *   this.db = (Database) session.getAttribute("db_connection");
     *   this.conn = db.getConnection();
     *
     * }
     */
    public boolean isAjax(HttpServletRequest request) {
        return "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    public void redirect(HttpServletResponse response, String view) throws IOException {
        //view = "jsp/" + view + ".jsp";
        response.sendRedirect(view);
    }

    public void forward(HttpServletRequest request, HttpServletResponse response, String view)
            throws IOException, ServletException {
        RequestDispatcher rd = request.getRequestDispatcher(view);

        rd.forward(request, response);
    }

    public void sendPDFResponse(ByteArrayOutputStream baos, String fileName, HttpServletResponse response) throws IOException {

        byte pdfData[] = baos.toByteArray();
        response.reset();
        response.setContentType("application/pdf");
        response.setHeader("Content-disposition", "inline; filename=" + fileName);
        try (OutputStream output = response.getOutputStream()) {
            output.write(pdfData);
        }
    }

    public void sendEmailWithAttachment(String toEmail, String subject, String emailBody, String attachmentName, byte[] pdfData, HttpServletRequest request, HttpServletResponse response) throws ServletException{
        boolean success = false;
        try {
            msgsend _mailer = new msgsend();
            success = _mailer.sendEmailToSubscriberWithAttachment(toEmail,
                    subject,
                    emailBody,
                    attachmentName,
                    pdfData,
                    "application/pdf");
        } catch (IOException ex) {
        }
        finally{
            String xml;
            try {
                // convert true/false to 1/0
                String successValue = (success == true) ? "1" : "0";
                xml = util.convertStringToXML(successValue, "success");
                request.setAttribute("xml", xml);
                String url = "/xmlserver";
                this.forward(request, response, url);
            } catch (ParserConfigurationException | TransformerException | IOException | ServletException ex) {
                throw new ServletException(ex.getMessage());
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
    }    // </editor-fold>
}


//~ Formatted by Jindent --- http://www.jindent.com
