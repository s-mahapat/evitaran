
/*
* To change this template, choose Tools | Templates
* and open the template in the editor.
 */
package IAS.Controller.missingissue;

//~--- non-JDK imports --------------------------------------------------------

import IAS.Class.JDSLogger;
import IAS.Controller.JDSController;
import IAS.Model.missingissue.missingissueModel;
import java.io.IOException;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author Shailendra Mahapatra
 */
public class missingissue extends JDSController {
    private static final Logger logger             = JDSLogger.getJDSLogger("IAS.Controller.missingissue");
    private missingissueModel   _missingissueModel = null;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String url    = null;

        try {
            _missingissueModel = new IAS.Model.missingissue.missingissueModel(request);

            if (action.equalsIgnoreCase("addInfo")) {
                int miId = 0;

                miId = _missingissueModel.checkMissingExists();

                if (miId == 0) {
                    url = "/jsp/missingissue/missingissueAddInfo.jsp";
                } else {

                    // request.setAttribute("miId", miId);
                    _missingissueModel.setAttri(miId);
                    url = "/jsp/missingissue/missingissuelist.jsp";
                }
            } else if (action.equalsIgnoreCase("save")) {

                // save the subscription details sent from the UI
                String xml = _missingissueModel.save();

                request.setAttribute("xml", xml);
                url = "/xmlserver";
            } else if (action.equalsIgnoreCase("checkGenerate")) {
                String xml = _missingissueModel.checkGenerate();

                request.setAttribute("xml", xml);
                url = "/xmlserver";
            } else if (action.equalsIgnoreCase("missinglist")) {
                _missingissueModel.passId();
                url = "/jsp/missingissue/missingissuelist.jsp";
            } else if (action.equalsIgnoreCase("getList")) {
                String xml = _missingissueModel.getList();

                request.setAttribute("xml", xml);
                url = "/xmlserver";
            } else if (action.equalsIgnoreCase("getCopies")) {
                String xml = _missingissueModel.getCopies();

                request.setAttribute("xml", xml);
                url = "/xmlserver";
            } else if (action.equalsIgnoreCase("alreadySent")) {
                String xml = _missingissueModel.alreadySent();

                request.setAttribute("xml", xml);
                url = "/xmlserver";
            } else if (action.equalsIgnoreCase("noCopies")) {
                String xml = _missingissueModel.noCopies();

                request.setAttribute("xml", xml);
                url = "/xmlserver";
            } else if (action.equalsIgnoreCase("gMiList")) {
                String xml = _missingissueModel.generateMl();

                request.setAttribute("xml", xml);
                url = "/xmlserver";
            } else if (action.equalsIgnoreCase("reprint")) {
                String xml = _missingissueModel.reprint();

                request.setAttribute("xml", xml);
                url = "/xmlserver";
            } else if (action.equalsIgnoreCase("getLabel")) {
                String xml = _missingissueModel.getLabel();

                request.setAttribute("xml", xml);
                url = "/xmlserver";
            }  else if (action.equalsIgnoreCase("saveList")) {
                String xml = _missingissueModel.saveList();

                request.setAttribute("xml", xml);
                url = "/xmlserver";
            }  else if (action.equalsIgnoreCase("generateMlForMi")) {

                /*
                 * String xml = _missingissueModel.generateMLforMI(response);
                 * //request.setAttribute("xml", xml);
                 * url = "/pdfserver";
                 *
                 */
                ResultSet rs = _missingissueModel.generateMLforMI();

                request.setAttribute("ResultSet", rs);

                String type = request.getParameter("printType");

                if (type.equals("printLabel")) {
                    url = "/pdfserver?action=generatebilPrintLabel";
                }

                if (type.equals("printSticker")) {
                    url = "/pdfserver?action=generatebilPrintSticker";
                }
            } else if (action.equalsIgnoreCase("printNoCopies")) {

                /*
                 * String xml = _missingissueModel.printNoCopies(response);
                 * //request.setAttribute("xml", xml);
                 * url = "/pdfserver";
                 *
                 */
                url = "/pdfserver?action=miPrintNoCopies";
            } else if (action.equalsIgnoreCase("printAlreadySent")) {

                /*
                 * String xml = _missingissueModel.printAlreadySent(response);
                 * //request.setAttribute("xml", xml);
                 * url = "/pdfserver";
                 *
                 */
                url = "/pdfserver?action=miPrintAlreadySent";
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);

            throw new javax.servlet.ServletException(e);
        } finally {
            RequestDispatcher rd = getServletContext().getRequestDispatcher(url);

            if ((rd != null) && (url != null)) {
                rd.forward(request, response);

                // response.sendRedirect(request.getContextPath() + url);
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
    }    // </editor-fold>
}


//~ Formatted by Jindent --- http://www.jindent.com
