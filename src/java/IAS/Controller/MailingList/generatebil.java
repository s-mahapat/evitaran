package IAS.Controller.MailingList;

import IAS.Model.ml.bilModel;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import IAS.Class.JDSLogger;
import IAS.Controller.JDSController;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;

/**
 *
 * @author aloko
 */
public class generatebil extends JDSController {
    private bilModel _bilModel = null;
    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Controller.masterData");

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String url = null;

        try {
            _bilModel = new IAS.Model.ml.bilModel(request);

                if(action.equalsIgnoreCase("search")){

                String xml = _bilModel.search();
                request.setAttribute("xml", xml);
                url = "/xmlserver";

            }else if(action.equalsIgnoreCase("generate")){

                String xml = _bilModel.generate();

                request.setAttribute("xml", xml);
                url = "/xmlserver";

            }else if(action.equalsIgnoreCase("printLabel")){

                ResultSet rs = _bilModel.printbil();
                request.setAttribute("ResultSet", rs);
                //url = "/pdfserver?action=generatemlPrintLabel";
                url = "/pdfserver?action=generatebilPrintLabel";

            }else if(action.equalsIgnoreCase("printSticker")){

                ResultSet rs = _bilModel.printbil();
                request.setAttribute("ResultSet", rs);
                //url = "/pdfserver?action=generatemlPrintSticker";
                url = "/pdfserver?action=generatebilPrintSticker";
            }

        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            throw new javax.servlet.ServletException(e);

        } finally {
            if(url == null){
                url = "/jsp/errors/404.jsp";
                logger.error("Redirect url was not found, forwarding to 404");
            }
            else
            {
                logger.debug("Called->" + url);
            }
            RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
            if (rd != null && url != null) {
                rd.forward(request, response);
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
        return "Short description";
    }// </editor-fold>
}
