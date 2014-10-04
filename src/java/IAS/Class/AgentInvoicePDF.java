/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import IAS.Bean.Invoice.InvoiceFormBean;
import IAS.Bean.Inward.inwardFormBean;
import IAS.Model.AgentProc.agentProcModel;
import IAS.Model.Inward.inwardModel;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.net.MalformedURLException;
import java.sql.SQLException;
import java.text.ParseException;
import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;

public class AgentInvoicePDF extends JDSPDF {

    private HttpServletRequest request = null;

    public AgentInvoicePDF(HttpServletRequest request) throws SQLException {
        super();
        this.request = request;
    }

    public ByteArrayOutputStream getPDF(String InwardNumber) throws DocumentException,
            MalformedURLException,
            IOException,
            SQLException,
            ParseException,
            ParserConfigurationException,
            TransformerException,
            ClassNotFoundException,
            InvocationTargetException,
            IllegalAccessException {

        com.itextpdf.text.Document document = this.getPDFDocument();

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        PdfWriter pdfWriter = this.getPDFWriter(document, outputStream);

        document.open();
        document.add(this.getLetterHead());
        document.add(this.getRFILetterBody(InwardNumber));
        document.add(this.getLetterFooter());
        this.addPaymentFooter(document, pdfWriter);
        document.close();
        pdfWriter.close();
        return outputStream;
    }

    private Paragraph getRFILetterBody(String InwardNumber) throws SQLException,
            ParseException,
            ParserConfigurationException,
            TransformerException,
            ClassNotFoundException,
            IOException,
            DocumentException,
            InvocationTargetException,
            IllegalAccessException {

        //*********************************
        // Fetching inward and invoice data
        //*********************************
        inwardModel _inwardModel = new inwardModel(this.request);
        inwardFormBean _inwardFormBean = _inwardModel.GetInward(InwardNumber);
        agentProcModel _agentProcModel = new agentProcModel(this.request);
        InvoiceFormBean _invoiceBean = _agentProcModel.getAgentInvoiceDetail(InwardNumber, this.request);

        //*********************************
        // Declaring the paragraphs for PDF
        //*********************************
        Paragraph paragraphOuter = new Paragraph();
        Paragraph addressParagraph = new Paragraph();
        //PdfPTable addressTable = new PdfPTable(1);
        PdfPTable InvoiceInfoTable = new PdfPTable(2);
        //Paragraph paragraphInvoiceInfo = new Paragraph();
        Paragraph paragraphBody = new Paragraph();
        Paragraph paragraphInvoiceAddress = new Paragraph();

        paragraphOuter.setSpacingBefore(JDSPDF.LESS_OUTER_PARAGRAPH_SPACE);
        paragraphOuter.setIndentationLeft(JDSPDF.LEFT_INDENTATION_LESS);
        paragraphOuter.setAlignment(Element.ALIGN_LEFT);

        //*********************************
        // Invoice Header for invoice number and inward number
        //*********************************
        Paragraph invoiceHeader = new Paragraph(new Chunk("INVOICE", JDSPDF.JDS_BOLD_FONT));
        invoiceHeader.setAlignment(Element.ALIGN_CENTER);

        InvoiceInfoTable.setWidthPercentage(70);
        Paragraph invoiceNumber = new Paragraph(new Chunk("Invoice No: " + _invoiceBean.getInvoiceNumber(), JDSPDF.JDS_FONT_BODY));
        Paragraph inwardNumber = new Paragraph(new Chunk("Inward No: " + InwardNumber, JDSPDF.JDS_FONT_BODY));

        PdfPCell inwardNumberCell = new PdfPCell(inwardNumber);
        PdfPCell invoiceNumberCell = new PdfPCell(invoiceNumber);

        invoiceNumberCell.setBorder(Rectangle.NO_BORDER);
        invoiceNumberCell.setHorizontalAlignment(Element.ALIGN_LEFT);
        invoiceNumberCell.setVerticalAlignment(Element.ALIGN_TOP);
        //invoiceNumberCell.setPaddingLeft(JDSPDF.LEFT_INDENTATION_LESS);

        inwardNumberCell.setBorder(Rectangle.NO_BORDER);
        inwardNumberCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
        inwardNumberCell.setVerticalAlignment(Element.ALIGN_TOP);

        InvoiceInfoTable.addCell(invoiceNumberCell);
        InvoiceInfoTable.addCell(inwardNumberCell);
        //paragraphInvoiceInfo.setSpacingBefore(JDSPDF.OUTER_PARAGRAPH_SPACE);

        //*********************************
        // create invoice address table
        //*********************************
        //addressParagraph.add(addressTable);
        //addressParagraph.setIndentationLeft(JDSPDF.LEFT_INDENTATION_LESS);
        //addressParagraph.setSpacingBefore(JDSPDF.LESS_OUTER_PARAGRAPH_SPACE);
        //addressTable.setWidthPercentage(100);
        Chunk invoiceAddressHeader = new Chunk("INVOICE ADDRESS", JDSPDF.JDS_FONT_BODY);
        invoiceAddressHeader.setTextRise(2);
        invoiceAddressHeader.setUnderline(1, 0);
        paragraphInvoiceAddress.add(invoiceAddressHeader);
        paragraphInvoiceAddress.add(Chunk.NEWLINE);
        paragraphInvoiceAddress.add(new Phrase(_invoiceBean.getInvoiceAddress(), JDSPDF.JDS_FONT_BODY));
        paragraphInvoiceAddress.add(Chunk.NEWLINE);
        paragraphInvoiceAddress.add(new Phrase(_inwardFormBean.getAgentName(), JDSPDF.JDS_FONT_BODY));
        paragraphInvoiceAddress.add(Chunk.NEWLINE);
        paragraphInvoiceAddress.add(new Phrase(_invoiceBean.getCity(), JDSPDF.JDS_FONT_BODY));
        paragraphInvoiceAddress.add(Chunk.NEWLINE);
        paragraphInvoiceAddress.add(new Phrase(_invoiceBean.getCountry(), JDSPDF.JDS_FONT_BODY));
        if (_invoiceBean.getPincode() > 0) {
            paragraphInvoiceAddress.add(Chunk.NEWLINE);
            paragraphInvoiceAddress.add(new Phrase(String.valueOf(_invoiceBean.getPincode()), JDSPDF.JDS_FONT_BODY));
        }
        PdfPCell invoiceAddressCell = new PdfPCell(paragraphInvoiceAddress);
        invoiceAddressCell.setBorder(Rectangle.NO_BORDER);
        invoiceAddressCell.setHorizontalAlignment(Element.ALIGN_LEFT);
        invoiceAddressCell.setVerticalAlignment(Element.ALIGN_TOP);

        this.insertCell(InvoiceInfoTable, "", Element.ALIGN_LEFT, 1, JDS_BOLD_FONT, Rectangle.NO_BORDER);
        this.insertCell(InvoiceInfoTable, "", Element.ALIGN_LEFT, 1, JDS_BOLD_FONT, Rectangle.NO_BORDER);

        InvoiceInfoTable.addCell(invoiceAddressCell);
        this.insertCell(InvoiceInfoTable, "", Element.ALIGN_LEFT, 1, JDS_BOLD_FONT, Rectangle.NO_BORDER);

        //addressTable.addCell(invoiceAddressCell);
        paragraphBody.setIndentationLeft(JDSPDF.LEFT_INDENTATION_LESS);
        paragraphBody.setSpacingBefore(JDSPDF.INNER_PARAGRAPH_SPACE);

        //*********************************
        //Balance Table
        //*********************************
        PdfPTable table = new PdfPTable(3);
        table.setWidthPercentage(75);

        PdfPCell cell1 = new PdfPCell(new Paragraph("Subscription Value", JDSPDF.JDS_FONT_BODY));
        cell1.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell1.setVerticalAlignment(Element.ALIGN_MIDDLE);

        PdfPCell cell2 = new PdfPCell(new Paragraph("Amount Paid", JDSPDF.JDS_FONT_BODY));
        cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell2.setVerticalAlignment(Element.ALIGN_MIDDLE);

        PdfPCell cell3 = new PdfPCell(new Paragraph("Balance", JDSPDF.JDS_FONT_BODY));
        cell3.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell3.setVerticalAlignment(Element.ALIGN_MIDDLE);

        table.addCell(cell1);
        table.addCell(cell2);
        table.addCell(cell3);

        PdfPCell c1 = new PdfPCell(new Phrase(String.valueOf(_invoiceBean.getSubscriptionTotal()), JDSPDF.JDS_FONT_NORMAL_SMALL));
        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
        c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
        table.addCell(c1);

        PdfPCell c2 = new PdfPCell(new Phrase(String.valueOf(_inwardFormBean.getAmount()), JDSPDF.JDS_FONT_NORMAL_SMALL));
        c2.setHorizontalAlignment(Element.ALIGN_CENTER);
        c2.setVerticalAlignment(Element.ALIGN_MIDDLE);
        table.addCell(c2);

        PdfPCell c3 = new PdfPCell(new Phrase(String.valueOf(_invoiceBean.getBalance()), JDSPDF.JDS_FONT_NORMAL_SMALL));
        c3.setHorizontalAlignment(Element.ALIGN_CENTER);
        c3.setVerticalAlignment(Element.ALIGN_MIDDLE);
        table.addCell(c3);

        //*********************************
        //Convert balance in words
        //*********************************
        paragraphBody.add(table);
        EnglishNumberToWords _EnglishNumberToWords = new EnglishNumberToWords();
        paragraphBody.add(Chunk.NEWLINE);
        Paragraph invoiceAmount = new Paragraph(_EnglishNumberToWords.convertDouble(_invoiceBean.getBalance()).toUpperCase(), JDSPDF.JDS_FONT_NORMAL_SMALL);
        invoiceAmount.setIndentationLeft(JDSPDF.LEFT_INDENTATION_LESS * 5);
        paragraphBody.add(invoiceAmount);

        //*********************************
        // Return the whole paragraph
        //*********************************
        paragraphOuter.add(invoiceHeader);
        paragraphOuter.add(InvoiceInfoTable);
        paragraphOuter.add(addressParagraph);
        paragraphOuter.add(paragraphBody);

        return paragraphOuter;
    }
}
