/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Controller.Print;

import IAS.Bean.Inward.inwardFormBean;
import IAS.Class.AgentInvoicePDF;
import IAS.Class.ChequeReturnPDF;
import IAS.Class.Database;
import IAS.Class.InwardAckPDF;
import IAS.Class.JDSLogger;
import IAS.Class.OutStandingPendingBillPDF;
import IAS.Class.PlReferListPDF;
import IAS.Class.RequestForInvoicePDF;
import IAS.Controller.JDSController;
import IAS.Model.Inward.inwardModel;
import com.itextpdf.text.DocumentException;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Calendar;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import org.apache.log4j.Logger;

public class Print extends JDSController {

    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Controller.Print");

    @Override
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String requestURI = request.getRequestURI();
        requestURI = requestURI.replaceFirst("(?i)/?\\w+/Print/", "");
        String[] requestParams = requestURI.split("/");

        String document = requestParams[0];
        String documentID = requestParams[1];
        String action = requestParams[2];

        try {
            // for inward print
            if (document.equalsIgnoreCase("inward")) {
                inwardModel _inwardModel = new inwardModel(request);
                inwardFormBean _inwardFormBean;

                // for inward cheque return, create the pdf
                if (action.equalsIgnoreCase("chqreturn")) {
                    int chq_no = Integer.parseInt(request.getParameter("chq_no"));
                    _inwardFormBean = _inwardModel.getChequeReturnDetails(documentID, chq_no);
                    ChequeReturnPDF _chequePdf = new ChequeReturnPDF();
                    String returnReason = _inwardFormBean.getReturnReason();

                    ByteArrayOutputStream baos = _chequePdf.getPDF(_inwardFormBean.getSubscriberIdAsText(),
                            _inwardFormBean.getInwardNumber(),
                            _inwardFormBean.getChqddNumberAsText(),
                            _inwardFormBean.getPaymentDate(),
                            _inwardFormBean.getAmount(),
                            returnReason);
                    String fileName = _inwardFormBean.getInwardNumber() + ".pdf";
                    this.sendPDFResponse(baos, fileName, response);
                } // for inward acknowledgement
                else if (action.equalsIgnoreCase("ack")) {

                    String _inwardNumber = request.getParameter("inwardNumber");
                    String letterNumber = request.getParameter("lno");
                    String letterDate = request.getParameter("ldate");
                    String customText = request.getParameter("ctext");
                    //inwardModel _inwardModel = new inwardModel(request);
                    //inwardFormBean _inwardFormBean = new inwardFormBean();
                    _inwardFormBean = _inwardModel.GetInward(_inwardNumber);
                    int subid = Integer.parseInt(documentID);
                    Connection conn = Database.getConnection();
                    InwardAckPDF _inwardAckPdf = new InwardAckPDF(conn);
                    ByteArrayOutputStream baos = _inwardAckPdf.getPDF(subid,
                            _inwardNumber,
                            _inwardFormBean.getPaymentMode(),
                            _inwardFormBean.getInwardPurpose(),
                            _inwardFormBean.getInwardPurposeID(),
                            _inwardFormBean.getChqddNumberAsText(),
                            _inwardFormBean.getPaymentDate(),
                            _inwardFormBean.getAmount(),
                            letterNumber,
                            letterDate,
                            customText);

                    String fileName = _inwardFormBean.getInwardNumber() + ".pdf";
                    this.sendPDFResponse(baos, fileName, response);

                } // for request for invoice
                else if (action.equalsIgnoreCase("rfi")) {
                    String inwardNumber = documentID;
                    RequestForInvoicePDF _rfiPdf = new RequestForInvoicePDF(request);
                    ByteArrayOutputStream baos = _rfiPdf.getPDF(inwardNumber);

                    String fileName = inwardNumber + ".pdf";
                    this.sendPDFResponse(baos, fileName, response);
                } else if (action.equalsIgnoreCase("opb")) {
                    String inwardNumber = documentID;
                    OutStandingPendingBillPDF _opbpdf = new OutStandingPendingBillPDF(request);
                    ByteArrayOutputStream baos = _opbpdf.getPDF(inwardNumber);
                    String fileName = inwardNumber + ".pdf";
                    this.sendPDFResponse(baos, fileName, response);
                } else if (action.equalsIgnoreCase("agentInvoice")) {
                    String inwardNumber = documentID;
                    AgentInvoicePDF _agentInvoicePDF = new AgentInvoicePDF(request);
                    ByteArrayOutputStream baos = _agentInvoicePDF.getPDF(inwardNumber);
                    String fileName = inwardNumber + ".pdf";
                    this.sendPDFResponse(baos, fileName, response);
                }

            } // for all subscription
            else if (document.equalsIgnoreCase("subscription")) {
            } // for request for invoice
            else if (document.equalsIgnoreCase("prl")) {
                PlReferListPDF _PlReferListPDF = new PlReferListPDF();
                ByteArrayOutputStream baos = _PlReferListPDF.getPDF(Integer.parseInt(action));
                String fileName = String.valueOf(Calendar.getInstance().get(Calendar.YEAR) + 1) + "_Invoice.pdf";
                this.sendPDFResponse(baos, fileName, response);
            }
        } catch (SQLException | IOException | ParseException | InvocationTargetException | IllegalAccessException | ClassNotFoundException | DocumentException | NumberFormatException | ParserConfigurationException | TransformerException e) {
            logger.error(e.getMessage(), e);
            throw new javax.servlet.ServletException(e);
        }
    }

    /*private void sendResponse(ByteArrayOutputStream baos, String fileName, HttpServletResponse response) throws IOException {

        byte pdfData[] = baos.toByteArray();
        response.reset();
        response.setContentType("application/pdf");
        response.setHeader("Content-disposition", "inline; filename=" + fileName);
        try (OutputStream output = response.getOutputStream()) {
            output.write(pdfData);
        }
    }*/

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
