/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Controller.Print;

import IAS.Bean.Inward.inwardFormBean;
import IAS.Class.ChequeReturnPDF;
import IAS.Class.JDSLogger;
import IAS.Controller.JDSController;
import IAS.Model.Inward.inwardModel;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

public class Print extends JDSController {

    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Controller.Print");

    @Override
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String requestURI = request.getRequestURI();
        requestURI = requestURI.replaceFirst("(?i)/JDS/Print/", "");
        String[] requestParams = requestURI.split("/");

        String document = requestParams[0];
        String documentID = requestParams[1];
        String action = requestParams[2];

        try {
            if (document.equalsIgnoreCase("inward")) {
                inwardModel _inwardModel = new inwardModel(request);
                inwardFormBean _inwardFormBean = new inwardFormBean();
                _inwardFormBean = _inwardModel.GetInward(documentID);
                request.setAttribute("inwardFormBean", _inwardFormBean);
                if (action.equalsIgnoreCase("chqreturn")) {
                    ChequeReturnPDF _chequePdf = new ChequeReturnPDF();
                    ByteArrayOutputStream baos = _chequePdf.getPDF(_inwardFormBean.getSubscriberIdAsText(), _inwardFormBean.getInwardNumber(), _inwardFormBean.getChqddNumber(), _inwardFormBean.getPaymentDate(), _inwardFormBean.getAmount(), _inwardFormBean.getChequeDDReturnReason());
                    byte pdfData[] = baos.toByteArray();
                    String fileName = _inwardFormBean.getInwardNumber() + ".pdf";
                    response.reset();
                    response.setContentType("application/pdf");
                    response.setHeader("Content-disposition", "inline; filename=" + fileName);
                    try (OutputStream output = response.getOutputStream()) {
                        output.write(pdfData);
                    }
                }

            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            throw new javax.servlet.ServletException(e);
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
