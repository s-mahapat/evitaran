package IAS.Controller.Email;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import IAS.Bean.Inward.inwardFormBean;
import IAS.Class.JDSLogger;
import IAS.Controller.JDSController;
import IAS.Model.Inward.inwardModel;
import org.apache.log4j.Logger;
import IAS.Class.ChequeReturnPDF;
import java.io.ByteArrayOutputStream;
import java.io.OutputStream;

public class Email extends JDSController {

    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Controller.Email");
    
    @Override
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String requestURI = request.getRequestURI();
        requestURI = requestURI.replaceFirst("/JDS/Email/", "");
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
                ChequeReturnPDF _chequePdf = new ChequeReturnPDF();
                ByteArrayOutputStream baos =  _chequePdf.getPDF(_inwardFormBean.getSubscriberIdAsText()
                                                                , _inwardFormBean.getInwardNumber()
                                                                , _inwardFormBean.getChqddNumber()
                                                                , _inwardFormBean.getPaymentDate()
                                                                , _inwardFormBean.getAmount()
                                                                , _inwardFormBean.getChequeDDReturnReason());
                byte pdfData[] = baos.toByteArray();
                String fileName = _inwardFormBean.getInwardNumber() + ".pdf";
                response.reset(); // Some JSF component library or some Filter might have set some headers in the buffer beforehand. We want to get rid of them, else it may collide.
                response.setContentType("application/pdf"); // Check http://www.w3schools.com/media/media_mimeref.asp for all types. Use if necessary ServletContext#getMimeType() for auto-detection based on filename.
                response.setHeader("Content-disposition", "inline; filename=" + fileName); // The Save As popup magic is done here. You can give it any filename you want, this only won't work in MSIE, it will use current request URL as filename instead.

                // Write file to response.
                OutputStream output = response.getOutputStream();
                
                output.write(pdfData);
                output.close();

//                RequestDispatcher rd = getServletContext().getRequestDispatcher("/jsp/inward/chequereturnbody.jsp");
//                CustomResponse _customResponse = new CustomResponse(response);
//                rd.forward(request, _customResponse);
//                String html = _customResponse.getOutput();
//                //IAS.Class.msgsend mailer = new msgsend();
//                //mailer.sendHTMLEmailWithAuthentication("jds.adm.all@gmail.com", 
//                    //                                    "shailendra.mahapatra@gmail.com", "Test", html);
//                convertToPdf _pdfconverter = new convertToPdf();
//                _pdfconverter.htmlChequeReturnToPDF(html);
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
