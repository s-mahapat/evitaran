
package IAS.Controller;

import IAS.Class.JDSLogger;
import IAS.Class.ServletContextInfo;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

public class templates extends HttpServlet {

    private static final Logger logger = JDSLogger.getJDSLogger(templates.class.getName());

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        int template_type = Integer.parseInt(request.getParameter("id"));
        //PrintWriter out = response.getWriter();
        response.setHeader("Pragma", "public");
        response.setHeader("Cache-Control", "no-store");
        response.addHeader("Cache-Control", "max-age=0");

        switch (template_type) {
            case 1:
                response.setContentType("application/vnd.ms-excel");
                response.setHeader("Content-Disposition", "inline; filename=AgentUpload.xls");
                this.SendFileContents(ServletContextInfo.getContextRealPath()+ "/templates/AgentUpload.xls", response);
        }
    }

    private void SendFileContents(String file, HttpServletResponse response) {
        FileInputStream fin = null;
        try {
            fin = new FileInputStream(file);
        } catch (FileNotFoundException e) {
            logger.error(e);
        }
        int size;
        size = 2048;
        try {
            response.setContentLength(fin.available());
            byte[] buffer = new byte[size];
            ServletOutputStream os;

            os = response.getOutputStream();
            int length;
            while ((length = fin.read(buffer)) != -1) {
                os.write(buffer, 0, length);

            }
            fin.close();
            os.flush();
            os.close();
        } catch (IOException e) {
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
