package IAS.Controller.Email;

import IAS.Bean.Inward.inwardFormBean;
import IAS.Class.*;
import IAS.Controller.JDSController;
import IAS.Model.Inward.inwardModel;
import com.itextpdf.text.DocumentException;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
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
                    ChequeReturnPDF _chequePdf = new ChequeReturnPDF();
                    
                    // if the reason is other, then the reason for return should be from the 'others' field
                    String returnReason = _inwardFormBean.getChequeDDReturnReason();
                    if(returnReason.equalsIgnoreCase("others")){
                        returnReason = _inwardFormBean.getChequeDDReturnReasonOther();
                    }
                    ByteArrayOutputStream baos = _chequePdf.getPDF( _inwardFormBean.getSubscriberIdAsText(), 
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
                    
                    success = _mailer.sendEmailToSubscriberWithAttachment(  _inwardFormBean.getEmail(),
                                                                            "Cheque/DD No: " + _inwardFormBean.getChqddNumber() + " Return",
                                                                            emailBody,
                                                                            fileName,
                                                                            pdfData,
                                                                            "application/pdf");
                    
                }
                // for inward acknowledgement
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
                    String emailBody = _inwardModel.getInwardAckEmailBody(_inwardFormBean.getChqddNumberAsText(),
                                                                            _inwardFormBean.getAmount(),  
                                                                            _inwardFormBean.getPaymentDate(),
                                                                            _inwardFormBean.getBankName()
                                                                            );
                    
                    success = _mailer.sendEmailToSubscriberWithAttachment(  _inwardFormBean.getEmail(),
                                                                            "Acknowledgement of receipt of payment",
                                                                            emailBody,
                                                                            fileName,
                                                                            pdfData,
                                                                            "application/pdf");
                    
                }
                // for request for invoice
                else if (action.equalsIgnoreCase("rfi")) {
                    String _inwardNumber = documentID;
                    RequestForInvoicePDF _rfiPDF = new RequestForInvoicePDF(request);
                    ByteArrayOutputStream baos = _rfiPDF.getPDF(_inwardNumber);
                    byte pdfData[] = baos.toByteArray();
                    String fileName = _inwardNumber + ".pdf";
                    msgsend _mailer = new msgsend();
                    String emailBody = _inwardModel.getRequestForInvoiceEmailBody();
                    success = _mailer.sendEmailToSubscriberWithAttachment(  _inwardFormBean.getEmail(),
                                                                            "Request For Invoice",
                                                                            emailBody,
                                                                            fileName,
                                                                            pdfData,
                                                                            "application/pdf");
                }
                

            }
        } catch (SQLException | IOException | ParseException | InvocationTargetException | IllegalAccessException | ClassNotFoundException | DocumentException | NumberFormatException | ParserConfigurationException | TransformerException e) {
            logger.error(e.getMessage(), e);
            throw new javax.servlet.ServletException(e);
        } finally{            
            String xml;
            try{
                // convert true/false to 1/0
                String successValue = (success == true) ? "1" : "0";
                xml = util.convertStringToXML(successValue, "success");
                request.setAttribute("xml", xml);
                String url = "/xmlserver";
                RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
                rd.forward(request, response);
            }catch(ParserConfigurationException | TransformerException | IOException | ServletException ex){
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
