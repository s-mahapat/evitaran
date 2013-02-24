package IAS.Controller.Email;

import IAS.Bean.Invoice.InvoiceFormBean;
import IAS.Bean.Inward.inwardFormBean;
import IAS.Class.*;
import IAS.Controller.JDSController;
import IAS.Model.Invoice.InvoiceModel;
import IAS.Model.Inward.inwardModel;
import IAS.Model.Subscriber.subscriberModel;
import com.itextpdf.text.DocumentException;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Calendar;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import org.apache.log4j.Logger;

public class Email extends JDSController {

    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Controller.Email");

    @Override
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String requestURI = request.getRequestURI();
        requestURI = requestURI.replaceFirst("(?i)/?\\w+/Email/", "");
        String[] requestParams = requestURI.split("/");

        String document = requestParams[0];
        String documentID = requestParams[1];
        String action = requestParams[2];
        boolean success = false;

        try {
            // for all inwards
            if (document.equalsIgnoreCase("inward")) {
                inwardModel _inwardModel = new inwardModel(request);
                inwardFormBean _inwardFormBean = _inwardModel.GetInward(documentID);
                request.setAttribute("inwardFormBean", _inwardFormBean);

                // for inward cheque return
                if (action.equalsIgnoreCase("chqreturn")) {
                    int chq_no = Integer.parseInt(request.getParameter("chq_no"));
                    _inwardFormBean = _inwardModel.getChequeReturnDetails(documentID, chq_no);
                    ChequeReturnPDF _chequePdf = new ChequeReturnPDF();

                    // if the reason is other, then the reason for return should be from the 'others' field
                    String returnReason = _inwardFormBean.getReturnReason();
                    ByteArrayOutputStream baos = _chequePdf.getPDF(_inwardFormBean.getSubscriberIdAsText(),
                            _inwardFormBean.getInwardNumber(),
                            _inwardFormBean.getChqddNumberAsText(),
                            _inwardFormBean.getPaymentDate(),
                            _inwardFormBean.getAmount(),
                            returnReason);
                    byte pdfData[] = baos.toByteArray();
                    String fileName = _inwardFormBean.getInwardNumber() + ".pdf";
                    msgsend _mailer = new msgsend();
                    String emailBody = _inwardModel.getChequeReturnEmailBody(_inwardFormBean.getChqddNumberAsText(),
                            _inwardFormBean.getAmount(),
                            _inwardFormBean.getPaymentDate(),
                            returnReason);

                    success = _mailer.sendEmailToSubscriberWithAttachment(_inwardFormBean.getEmail(),
                            "Cheque/DD No: " + _inwardFormBean.getChqddNumber() + " Return",
                            emailBody,
                            fileName,
                            pdfData,
                            "application/pdf");

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
                            _inwardFormBean.getAmount(),
                            letterNumber,
                            letterDate,
                            customText);
                    byte pdfData[] = baos.toByteArray();
                    String fileName = _inwardFormBean.getInwardNumber() + ".pdf";
                    msgsend _mailer = new msgsend();
                    String emailBody = _inwardModel.getInwardAckEmailBody(
                            _inwardFormBean.getChqddNumberAsText(),
                            _inwardFormBean.getAmount(),
                            _inwardFormBean.getPaymentDate(),
                            _inwardFormBean.getBankName(),
                            _inwardFormBean.getInwardPurpose(),
                            customText);

                    if (_inwardFormBean.getAmount() > 0) {
                        success = _mailer.sendEmailToSubscriberWithAttachment(_inwardFormBean.getEmail(),
                                "Acknowledgement of receipt of payment",
                                emailBody,
                                fileName,
                                pdfData,
                                "application/pdf");
                    } else {
                        success = _mailer.sendEmailToSubscriberWithoutAttachment(_inwardFormBean.getEmail(),
                                "Acknowledgement of receipt of payment",
                                emailBody);
                    }



                } // for request for invoice
                else if (action.equalsIgnoreCase("rfi")) {
                    String _inwardNumber = documentID;
                    RequestForInvoicePDF _rfiPDF = new RequestForInvoicePDF(request);
                    ByteArrayOutputStream baos = _rfiPDF.getPDF(_inwardNumber);
                    byte pdfData[] = baos.toByteArray();
                    String fileName = _inwardNumber + ".pdf";
                    msgsend _mailer = new msgsend();
                    String emailBody = _inwardModel.getRequestForInvoiceEmailBody();
                    success = _mailer.sendEmailToSubscriberWithAttachment(_inwardFormBean.getEmail(),
                            "Request For Invoice",
                            emailBody,
                            fileName,
                            pdfData,
                            "application/pdf");
                } else if (action.equalsIgnoreCase("opb")) {
                    String inwardNumber = documentID;
                    InvoiceFormBean _invoiceFormBean = _inwardModel.getInvoiceDetail(inwardNumber);
                    OutStandingPendingBillPDF _opbpdf = new OutStandingPendingBillPDF(request);
                    ByteArrayOutputStream baos = _opbpdf.getPDF(inwardNumber);
                    byte pdfData[] = baos.toByteArray();
                    String fileName = _invoiceFormBean.getInvoiceNumber() + ".pdf";
                    msgsend _mailer = new msgsend();
                    String emailBody = new InvoiceModel(request).getOutStandingPaymentEmailBody(_invoiceFormBean.getAmount());
                    success = _mailer.sendEmailToSubscriberWithAttachment(_inwardFormBean.getEmail(),
                            "Invoice for outstanding payment",
                            emailBody,
                            fileName,
                            pdfData,
                            "application/pdf");
                }


            } else if (document.equalsIgnoreCase("prl")) {
                PlReferListPDF _PlReferListPDF = new PlReferListPDF();
                InvoiceModel _invoiceModel = new InvoiceModel(request);

                String invoice_no = documentID;
                ByteArrayOutputStream baos = _PlReferListPDF.getPlReferListPage(invoice_no);
                byte pdfData[] = baos.toByteArray();

                // form the file name from next year
                String fileName = "Invoice_for_" + String.valueOf(Calendar.getInstance().get(Calendar.YEAR) + 1) + ".pdf";
                String subscriber_number = action;
                subscriberModel _subModel = new subscriberModel(request);
                IAS.Bean.Subscriber.subscriberFormBean _subscriberBean = _subModel.GetSubscriber(subscriber_number);
                msgsend _mailer = new msgsend();

                // get the email body content
                String emailBody = _invoiceModel.getPRLEmailBody();

                // send the email
                success = _mailer.sendEmailToSubscriberWithAttachment(_subscriberBean.getEmail(),
                        "Invoice for " + String.valueOf(Calendar.getInstance().get(Calendar.YEAR) + 1),
                        emailBody,
                        fileName,
                        pdfData,
                        "application/pdf");
                // if the email was sent successfully update the prl_details table with the status
                // so that it is not sent the second time
                if (success) {
                    _invoiceModel.updatePRLEmailStatus(invoice_no);
                }

            }
        } catch (SQLException | IOException | ParseException | InvocationTargetException | IllegalAccessException | ClassNotFoundException | DocumentException | NumberFormatException | ParserConfigurationException | TransformerException e) {
            logger.error(e.getMessage(), e);
            throw new javax.servlet.ServletException(e);
        } finally {
            String xml;
            try {
                // convert true/false to 1/0
                String successValue = (success == true) ? "1" : "0";
                xml = util.convertStringToXML(successValue, "success");
                request.setAttribute("xml", xml);
                String url = "/xmlserver";
                RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
                rd.forward(request, response);
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
    }// </editor-fold>
}
