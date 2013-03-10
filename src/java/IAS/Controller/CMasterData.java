
/*
* To change this template, choose Tools | Templates
* and open the template in the editor.
 */
package IAS.Controller;

//~--- non-JDK imports --------------------------------------------------------

import IAS.Model.MasterDataModel;

//~--- JDK imports ------------------------------------------------------------

import java.io.IOException;

import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;

/**
 *
 * @author Shailendra Mahapatra
 */
public class CMasterData extends JDSController {
    @Override
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String xml;
        String url = null;

        try {
            MasterDataModel mm             = new MasterDataModel();
            String          mdataRequested = request.getParameter("md").toLowerCase();

            // String mdataReqKey = request.getParameter("mdkey");
            String mdataReqValue   = request.getParameter("mdvalue");
            String optionalParam[] = request.getParameterValues("optionalParam");

            xml = mm.getMasterData(mdataRequested, mdataReqValue, optionalParam);
            request.setAttribute("xml", xml);
            url = "/xmlserver";
        } catch (SQLException | ParserConfigurationException | TransformerException e) {
            throw(new ServletException(e.getMessage(), e));
        } finally {
            RequestDispatcher rd = getServletContext().getRequestDispatcher(url);

            if ((rd != null) && (url != null)) {
                rd.forward(request, response);
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
