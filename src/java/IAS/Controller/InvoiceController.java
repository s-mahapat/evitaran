/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Controller;

import IAS.Bean.Subscriber.subscriberFormBean;
import IAS.Class.InvoiceBillPDF;
import IAS.Class.JDSLogger;
import IAS.Model.Invoice.InvoiceModel;
import com.itextpdf.text.DocumentException;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import org.apache.log4j.Logger;

public class InvoiceController extends JDSController {

    private HttpServletRequest req;
    private HttpServletResponse resp;
    private ServletContext context;
    private String[] params;
    private static final Logger logger = JDSLogger.getJDSLogger(InvoiceController.class.getName());

    public InvoiceController(HttpServletRequest req, HttpServletResponse resp, ServletContext context, String[] params) {
        this.req = req;
        this.resp = resp;
        this.context = context;
        this.params = params;
    }

    private ByteArrayOutputStream getPDF(int invoiceid) {
        InvoiceBillPDF invoiceBill = new InvoiceBillPDF();
        ByteArrayOutputStream baos = null;
        try {
            baos = invoiceBill.getPDF(invoiceid);
        } catch (DocumentException | IOException | SQLException | ParseException | ParserConfigurationException | TransformerException | ClassNotFoundException ex) {
            logger.error(ex);
        } finally {
            return baos;
        }
    }

    public void actionBill() throws IOException {
        int invoiceid = Integer.parseInt(this.params[0]);
        ByteArrayOutputStream baos = this.getPDF(invoiceid);
        String fileName = this.params[0] + ".pdf";
        this.sendPDFResponse(baos, fileName, this.resp);
    }

    public void actionEmailbill() throws ServletException {
        int invoiceid = Integer.parseInt(this.params[0]);
        ByteArrayOutputStream baos = this.getPDF(invoiceid);
        byte pdfData[] = baos.toByteArray();
        String fileName = this.params[0] + ".pdf";
        try {
            InvoiceModel invoiceModel = new InvoiceModel(this.req);
            subscriberFormBean subscriber = invoiceModel.getSubscriberInfo(invoiceid);
            this.sendEmailWithAttachment(subscriber.getEmail(), "Statement", invoiceModel.getStatementEmailBody(), fileName, pdfData, this.req, this.resp);
        } catch (SQLException | IOException | ServletException ex) {
            logger.error(ex);
        }

    }
}
