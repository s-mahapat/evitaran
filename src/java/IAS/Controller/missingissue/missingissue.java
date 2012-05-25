/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Controller.missingissue;

import IAS.Class.JDSConstants;
import IAS.Class.JDSLogger;
import IAS.Controller.JDSController;
import IAS.Model.Inward.inwardModel;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import IAS.Bean.missingissue.missingissueFormBean;
import IAS.Model.missingissue.missingissueModel;
/**
 *
 * @author Shailendra Mahapatra
 */
public class missingissue extends JDSController {

    
    private missingissueModel _missingissueModel = null;
    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Controller.missingissue");

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
        String url = null;

        try {
            _missingissueModel = new IAS.Model.missingissue.missingissueModel(request);
            if (action.equalsIgnoreCase("addInfo")) {
                
                url = "/jsp/missingissue/missingissueAddInfo.jsp";
            }
            else if (action.equalsIgnoreCase("save")) {
                
                //save the subscription details sent from the UI
                String xml = _missingissueModel.save();
                request.setAttribute("xml", xml);
                url = "/xmlserver";

            }
            else if (action.equalsIgnoreCase("missinglist")) {
                
                url = "/jsp/missingissue/missingissuelist.jsp";
            }
            else if (action.equalsIgnoreCase("getList")) {
                
                String xml = _missingissueModel.getList();
                request.setAttribute("xml", xml);
                url = "/xmlserver";
            }
        }
         catch (Exception e) {
            logger.error(e.getMessage(), e);
            throw new javax.servlet.ServletException(e);

        } finally {
            RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
            if (rd != null && url != null) {
                rd.forward(request, response);
                //response.sendRedirect(request.getContextPath() + url);
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
