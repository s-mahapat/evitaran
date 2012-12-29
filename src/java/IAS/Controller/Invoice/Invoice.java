/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Controller.Invoice;

import IAS.Class.Ajax.AjaxResponse;
import IAS.Class.JDSLogger;
import IAS.Class.util;
import IAS.Controller.JDSController;
import IAS.Model.Invoice.InvoiceModel;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import org.apache.log4j.Logger;
/**
 *
 * @author Shailendra Mahapatra
 */
public class Invoice extends JDSController {

    private static final Logger logger = JDSLogger.getJDSLogger(Invoice.class.getName());

    @Override
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String url = null;
        //String inwardNumber = request.getParameter("inwardNumber");
        //String subscriberNumber = request.getParameter("subscriberNumber");
        try {

            if (action.equalsIgnoreCase("new")) {
                //Request for Invoice
                url = "/jsp/invoice/proforma.jsp";
            }else if(action.equalsIgnoreCase("paymentinfo")){
                int invoice_id = Integer.parseInt(request.getParameter("invoiceid"));
                InvoiceModel _invoiceModel = new InvoiceModel();
                String xml = _invoiceModel.getInvoicePaymentInfo(invoice_id);
                response.setContentType("text/xml");
                response.getWriter().write(xml);

            }
        } catch (NumberFormatException | SQLException | IOException e) {
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
