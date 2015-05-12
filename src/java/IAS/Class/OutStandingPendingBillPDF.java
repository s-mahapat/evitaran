/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import IAS.Bean.Invoice.InvoiceFormBean;
import IAS.Model.Inward.inwardModel;
import IAS.Model.Subscription.SubscriptionModel;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;

/**
 *
 * @author Newton
 */
public class OutStandingPendingBillPDF extends JDSPDF {

    private HttpServletRequest request = null;

    public OutStandingPendingBillPDF(HttpServletRequest request) throws SQLException {
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
            ClassNotFoundException {

        com.itextpdf.text.Document document = this.getPDFDocument();

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        PdfWriter pdfWriter = this.getPDFWriter(document, outputStream);

        document.open();
        document.add(this.getLetterHead());
        //document.add(this.getSalutation());
        document.add(this.getLetterBody(InwardNumber));
        document.add(this.getLetterFooter());
        this.addPaymentFooter(document, pdfWriter);
        document.close();
        pdfWriter.close();
        return outputStream;

    }

    private Paragraph getLetterBody(String InwardNumber) throws SQLException,
            ParseException,
            ParserConfigurationException,
            TransformerException,
            ClassNotFoundException,
            IOException,
            DocumentException {

        //Connection conn = Database.getConnection();
        inwardModel _inwardModel = new inwardModel(this.request);
        InvoiceFormBean _invoiceBean = _inwardModel.getInvoiceDetail(InwardNumber);

        Paragraph paragraphOuter = new Paragraph();
        //Paragraph addressParagraph = new Paragraph();
        //PdfPTable addressTable = new PdfPTable(2);
        PdfPTable InvoiceInfoTable = new PdfPTable(2);
        //Paragraph paragraphInvoiceInfo = new Paragraph();
        Paragraph paragraphBody = new Paragraph();
        Paragraph paragraphShippingAddress = new Paragraph();
        Paragraph paragraphInvoiceAddress = new Paragraph();

        paragraphOuter.setSpacingBefore(JDSPDF.LESS_OUTER_PARAGRAPH_SPACE);
        //paragraphOuter.setIndentationLeft(JDSPDF.LEFT_INDENTATION_LESS * 10);
        paragraphOuter.setAlignment(Element.ALIGN_LEFT);

        Paragraph invoiceHeader = new Paragraph(new Chunk("INVOICE", JDSPDF.JDS_BOLD_FONT));
        invoiceHeader.setAlignment(Element.ALIGN_CENTER);

        InvoiceInfoTable.setSpacingBefore(OUTER_PARAGRAPH_SPACE);
        InvoiceInfoTable.setWidthPercentage(70);
        Paragraph invoiceNumber = new Paragraph(new Chunk("Invoice No: " + _invoiceBean.getInvoiceNumber(), JDSPDF.JDS_FONT_BODY));
        Paragraph invoiceDate = new Paragraph(new Chunk("Invoice Date: " + _invoiceBean.getInvoiceCreationDate(), JDSPDF.JDS_FONT_BODY));
        Paragraph subscriberNumber = new Paragraph(new Chunk("Sub No: " + _invoiceBean.getSubscriberNumber(), JDSPDF.JDS_FONT_BODY));

        PdfPCell subscriberNumberCell = new PdfPCell(subscriberNumber);
        PdfPCell invoiceNumberCell = new PdfPCell(invoiceNumber);
        PdfPCell invoiceDateCell = new PdfPCell(invoiceDate);
        PdfPCell blankCell = new PdfPCell();

        blankCell.setBorder(Rectangle.NO_BORDER);

        //PdfPCell invoiceHeaderCell = new PdfPCell(invoiceHeader);
        subscriberNumberCell.setBorder(Rectangle.NO_BORDER);
        subscriberNumberCell.setHorizontalAlignment(Element.ALIGN_LEFT);
        subscriberNumberCell.setVerticalAlignment(Element.ALIGN_TOP);
        //subscriberNumberCell.setPaddingLeft(JDSPDF.LEFT_INDENTATION_LESS);

        //invoiceHeaderCell.setBorder(Rectangle.NO_BORDER);
        //invoiceHeaderCell.setHorizontalAlignment(Element.ALIGN_CENTER);
        //invoiceHeaderCell.setVerticalAlignment(Element.ALIGN_TOP);
        invoiceNumberCell.setBorder(Rectangle.NO_BORDER);
        invoiceNumberCell.setHorizontalAlignment(Element.ALIGN_LEFT);
        invoiceNumberCell.setVerticalAlignment(Element.ALIGN_TOP);
        invoiceNumberCell.setPaddingLeft(JDSPDF.LEFT_INDENTATION_MORE * 2);

        invoiceDateCell.setBorder(Rectangle.NO_BORDER);
        invoiceDateCell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
        invoiceDateCell.setVerticalAlignment(Element.ALIGN_TOP);
        invoiceDateCell.setPaddingLeft(JDSPDF.LEFT_INDENTATION_MORE * 2);

        InvoiceInfoTable.addCell(subscriberNumberCell);
        //InvoiceInfoTable.addCell(invoiceHeaderCell);
        InvoiceInfoTable.addCell(invoiceNumberCell);

        InvoiceInfoTable.addCell(blankCell);
        InvoiceInfoTable.addCell(invoiceDateCell);

        //paragraphInvoiceInfo.setIndentationLeft(40);
        //paragraphInvoiceInfo.setSpacingBefore(JDSPDF.OUTER_PARAGRAPH_SPACE);
        // create the shipping and invoice address table with 1 row and 2 cols
        /*addressParagraph.add(addressTable);
         addressParagraph.setIndentationLeft(JDSPDF.LEFT_INDENTATION_LESS);
         addressParagraph.setSpacingBefore(JDSPDF.LESS_OUTER_PARAGRAPH_SPACE);
         addressTable.setWidthPercentage(100);*/
        //paragraphInvoiceAddress.setIndentationLeft(JDSPDF.LEFT_INDENTATION_MORE);
        Chunk invoiceAddressHeader = new Chunk("INVOICE ADDRESS", JDSPDF.JDS_FONT_BODY);
        invoiceAddressHeader.setTextRise(2);
        invoiceAddressHeader.setUnderline(1, 0);
        paragraphInvoiceAddress.add(invoiceAddressHeader);
        paragraphInvoiceAddress.add(Chunk.NEWLINE);
        paragraphInvoiceAddress.add(new Phrase(_invoiceBean.getSubscriberName(), JDSPDF.JDS_FONT_BODY));
        paragraphInvoiceAddress.add(Chunk.NEWLINE);
        paragraphInvoiceAddress.add(new Phrase(_invoiceBean.getInvoiceAddress(), JDSPDF.JDS_FONT_BODY));

        //paragraphShippingAddress.setIndentationLeft(JDSPDF.LEFT_INDENTATION_MORE);
        Chunk shippingAddressHeader = new Chunk("SHIPPING ADDRESS", JDSPDF.JDS_FONT_BODY);
        shippingAddressHeader.setTextRise(2);
        shippingAddressHeader.setUnderline(1, 0);
        paragraphShippingAddress.add(shippingAddressHeader);
        paragraphShippingAddress.add(Chunk.NEWLINE);
        paragraphShippingAddress.add(new Phrase(_invoiceBean.getSubscriberName(), JDSPDF.JDS_FONT_BODY));
        String _department = _invoiceBean.getDepartment();
        String _institute = _invoiceBean.getInstitution();
        String _shipping_address = _invoiceBean.getShippingAddress();
        String _city = _invoiceBean.getCity();
        String _country = _invoiceBean.getCountry();
        String _state = _invoiceBean.getState();
        int _pincode = _invoiceBean.getPincode();

        if (_department != null && _department.length() > 0) {
            paragraphShippingAddress.add(Chunk.NEWLINE);
            paragraphShippingAddress.add(new Phrase(_department, JDSPDF.JDS_FONT_BODY));
        }
        if (_institute != null && _institute.length() > 0) {
            paragraphShippingAddress.add(Chunk.NEWLINE);
            paragraphShippingAddress.add(new Phrase(_institute, JDSPDF.JDS_FONT_BODY));
        }
        if (_shipping_address.length() > 0) {
            paragraphShippingAddress.add(Chunk.NEWLINE);
            paragraphShippingAddress.add(new Phrase(_shipping_address, JDSPDF.JDS_FONT_BODY));
        }
        if (_city.length() > 0) {
            paragraphShippingAddress.add(Chunk.NEWLINE);
            paragraphShippingAddress.add(new Phrase(_city, JDSPDF.JDS_FONT_BODY));
        }
        if (_state.length() > 0) {
            paragraphShippingAddress.add(Chunk.NEWLINE);
            paragraphShippingAddress.add(new Phrase(_state, JDSPDF.JDS_FONT_BODY));
        }
        if (_country.length() > 0 && !_country.equalsIgnoreCase("india")) {
            paragraphShippingAddress.add(Chunk.NEWLINE);
            paragraphShippingAddress.add(new Phrase(_country, JDSPDF.JDS_FONT_BODY));
        }
        if (_invoiceBean.getPincode() > 0) {
            paragraphShippingAddress.add(Chunk.NEWLINE);
            paragraphShippingAddress.add(new Phrase(String.valueOf(_pincode), JDSPDF.JDS_FONT_BODY));
        }

        PdfPCell shippingAddressCell = new PdfPCell(paragraphShippingAddress);
        shippingAddressCell.setBorder(Rectangle.NO_BORDER);
        shippingAddressCell.setPaddingLeft(JDSPDF.LEFT_INDENTATION_MORE * 2);
        shippingAddressCell.setHorizontalAlignment(Element.ALIGN_LEFT);
        shippingAddressCell.setVerticalAlignment(Element.ALIGN_TOP);

        PdfPCell invoiceAddressCell = new PdfPCell(paragraphInvoiceAddress);
        invoiceAddressCell.setBorder(Rectangle.NO_BORDER);
        invoiceAddressCell.setHorizontalAlignment(Element.ALIGN_LEFT);
        invoiceAddressCell.setVerticalAlignment(Element.ALIGN_TOP);
        //invoiceAddressCell.setPaddingLeft(JDSPDF.LEFT_INDENTATION_LESS);

        //addressTable.addCell(invoiceAddressCell);
        //addressTable.addCell(shippingAddressCell);
        this.insertCell(InvoiceInfoTable, "", Element.ALIGN_LEFT, 2, JDS_BOLD_FONT, Rectangle.NO_BORDER);
        this.insertCell(InvoiceInfoTable, "", Element.ALIGN_LEFT, 2, JDS_BOLD_FONT, Rectangle.NO_BORDER);
        InvoiceInfoTable.addCell(invoiceAddressCell);
        InvoiceInfoTable.addCell(shippingAddressCell);

        paragraphBody.setIndentationLeft(JDSPDF.LEFT_INDENTATION_LESS);
        paragraphBody.setSpacingBefore(JDSPDF.INNER_PARAGRAPH_SPACE);

        PdfPTable table = new PdfPTable(6);
        table.setWidthPercentage(75);
        table.setWidths(new int[]{4, 1, 1, 2, 1, 1});

        PdfPCell cell1 = new PdfPCell(new Paragraph("Journal Name", JDSPDF.JDS_FONT_BODY));
        cell1.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell1.setVerticalAlignment(Element.ALIGN_MIDDLE);
        cell1.setColspan(2);

        PdfPCell cell4 = new PdfPCell(new Paragraph("Copies", JDSPDF.JDS_FONT_BODY));
        cell4.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell4.setVerticalAlignment(Element.ALIGN_MIDDLE);

        PdfPCell cell5 = new PdfPCell(new Paragraph("Period", JDSPDF.JDS_FONT_BODY));
        cell5.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell5.setVerticalAlignment(Element.ALIGN_MIDDLE);

        PdfPCell cell2 = new PdfPCell(new Paragraph("No. of Years", JDSPDF.JDS_FONT_BODY));
        cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell2.setVerticalAlignment(Element.ALIGN_MIDDLE);

        PdfPCell cell3 = new PdfPCell(new Paragraph("Rate", JDSPDF.JDS_FONT_BODY));
        cell3.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell3.setVerticalAlignment(Element.ALIGN_MIDDLE);

        table.addCell(cell1);
        table.addCell(cell4);
        table.addCell(cell5);
        table.addCell(cell2);
        table.addCell(cell3);
        float total = 0;

        SubscriptionModel _model = new SubscriptionModel(request);
        java.util.List<IAS.Bean.Subscription.SubscriptionDetail> sub_details = _model.getSubscriptionDetailsObjectsForInward(InwardNumber);
        for (IAS.Bean.Subscription.SubscriptionDetail detail : sub_details) {

            String journalName = detail.getJournalName();
            String copies = String.valueOf(detail.getCopies());
            String startDate = String.valueOf(detail.getStartMonth()) + "/" + String.valueOf(detail.getStartYear());
            String endDate = String.valueOf(detail.getEndMonth()) + "/" + String.valueOf(detail.getEndYear());
            String journalPrice = String.valueOf(detail.getRate());
            String period = String.valueOf(detail.getPeriod());

            //update the total for the entire subscription
            total += detail.getRate();

            PdfPCell c1 = new PdfPCell(new Phrase(journalName, JDSPDF.JDS_FONT_NORMAL_SMALL));
            c1.setHorizontalAlignment(Element.ALIGN_LEFT);
            c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
            c1.setColspan(2);
            table.addCell(c1);

            PdfPCell c4 = new PdfPCell(new Paragraph(copies, JDSPDF.JDS_FONT_NORMAL_SMALL));
            c4.setHorizontalAlignment(Element.ALIGN_CENTER);
            c4.setVerticalAlignment(Element.ALIGN_MIDDLE);

            PdfPCell c5 = new PdfPCell(new Paragraph(startDate + " to " + endDate, JDSPDF.JDS_FONT_NORMAL_SMALL));
            c5.setHorizontalAlignment(Element.ALIGN_CENTER);
            c5.setVerticalAlignment(Element.ALIGN_MIDDLE);

            PdfPCell c2 = new PdfPCell(new Phrase(period, JDSPDF.JDS_FONT_NORMAL_SMALL));
            c2.setHorizontalAlignment(Element.ALIGN_CENTER);
            c2.setVerticalAlignment(Element.ALIGN_MIDDLE);

            PdfPCell c3 = new PdfPCell(new Paragraph(journalPrice, JDSPDF.JDS_FONT_NORMAL_SMALL));
            c3.setHorizontalAlignment(Element.ALIGN_CENTER);
            c3.setVerticalAlignment(Element.ALIGN_MIDDLE);

            table.addCell(c4);
            table.addCell(c5);
            table.addCell(c2);
            table.addCell(c3);
        }

        PdfPCell totalCell = new PdfPCell(new Phrase("Total", JDSPDF.JDS_FONT_NORMAL_SMALL));
        totalCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
        totalCell.setVerticalAlignment(Element.ALIGN_MIDDLE);
        totalCell.setColspan(5);

        String _total = String.format("%.1f", (float) total);
        PdfPCell totalValue = new PdfPCell(new Phrase(_total, JDSPDF.JDS_FONT_NORMAL_SMALL));
        totalValue.setHorizontalAlignment(Element.ALIGN_CENTER);
        totalValue.setVerticalAlignment(Element.ALIGN_MIDDLE);

        table.addCell(totalCell);
        table.addCell(totalValue);
        
        PdfPCell totalDueCell = new PdfPCell(new Phrase("Total after discount(if applicable)", JDSPDF.JDS_FONT_NORMAL_SMALL));
        totalDueCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
        totalDueCell.setVerticalAlignment(Element.ALIGN_MIDDLE);
        totalDueCell.setColspan(5);

        String _totalDiscounted = String.format("%.1f", (float) _invoiceBean.getBalance());
        PdfPCell totalDiscountedValue = new PdfPCell(new Phrase(_totalDiscounted, JDSPDF.JDS_FONT_NORMAL_SMALL));
        totalDiscountedValue.setHorizontalAlignment(Element.ALIGN_CENTER);
        totalDiscountedValue.setVerticalAlignment(Element.ALIGN_MIDDLE);
        
        table.addCell(totalDueCell);
        table.addCell(totalDiscountedValue);

        float amountPaid = _invoiceBean.getInwardAmount();
        if (amountPaid > 0) {
            String lessamount = String.format("Less: Amount received by %s No: %s Dated: %s", _invoiceBean.getInwardPaymentMode(), _invoiceBean.getChqddNumber(), _invoiceBean.getChqDate());
            if (_invoiceBean.getPaymentModeID() == JDSConstants.PAYMENT_MODE_CASH) {
                lessamount = String.format("Less: Amount received by %s on %s", _invoiceBean.getInwardPaymentMode(), _invoiceBean.getChqDate());
            }

            PdfPCell amountPaidCell = new PdfPCell(new Phrase(lessamount, JDSPDF.JDS_FONT_NORMAL_SMALL));
            amountPaidCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
            amountPaidCell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            amountPaidCell.setColspan(5);

            PdfPCell amountPaidValueCell = new PdfPCell(new Phrase(String.valueOf(_invoiceBean.getInwardAmount()), JDSPDF.JDS_FONT_NORMAL_SMALL));
            amountPaidValueCell.setHorizontalAlignment(Element.ALIGN_CENTER);
            amountPaidValueCell.setVerticalAlignment(Element.ALIGN_MIDDLE);

            PdfPCell balanceCell = new PdfPCell(new Phrase("Balance amount due", JDSPDF.JDS_FONT_NORMAL_SMALL));
            balanceCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
            balanceCell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            balanceCell.setColspan(5);

            float balance = _invoiceBean.getBalance();
            PdfPCell balanceValueCell = new PdfPCell(new Phrase(String.valueOf(balance), JDSPDF.JDS_FONT_NORMAL_SMALL));
            balanceValueCell.setHorizontalAlignment(Element.ALIGN_CENTER);
            balanceValueCell.setVerticalAlignment(Element.ALIGN_MIDDLE);

            // the amount paid row
            //table.addCell(blankCell);
            table.addCell(amountPaidCell);
            table.addCell(amountPaidValueCell);
            // the balance row
            //table.addCell(blankCell);
            table.addCell(balanceCell);
            table.addCell(balanceValueCell);
        }

        //paragraphBody.add(new Phrase(bodyText));
        //paragraphBody.add(Chunk.NEWLINE);
        paragraphBody.add(table);

        // add the reference/letter number
        paragraphBody.add(Chunk.NEWLINE);
        String letterNoText = "Ref: Your Order No: %s Dated %s";
        if (_invoiceBean.getLetterNumber().length() > 0) {
            letterNoText = String.format(letterNoText, _invoiceBean.getLetterNumber(), _invoiceBean.getLetterDate());
        } else {
            letterNoText = String.format(letterNoText, ".....", ".....");
        }
        Paragraph refernceLetter = new Paragraph(letterNoText, JDSPDF.JDS_FONT_NORMAL_SMALL);
        refernceLetter.setIndentationLeft(JDSPDF.LEFT_INDENTATION_LESS * 5);
        paragraphBody.add(refernceLetter);
        paragraphBody.add(Chunk.NEWLINE);

        EnglishNumberToWords _EnglishNumberToWords = new EnglishNumberToWords();
        paragraphBody.add(Chunk.NEWLINE);
        Paragraph invoiceAmount = new Paragraph(_EnglishNumberToWords.convertDouble(_invoiceBean.getBalance()).toUpperCase(), JDSPDF.JDS_FONT_NORMAL_SMALL);
        invoiceAmount.setIndentationLeft(JDSPDF.LEFT_INDENTATION_LESS * 5);
        paragraphBody.add(invoiceAmount);//Convert total value in words
        paragraphOuter.add(invoiceHeader);
        paragraphOuter.add(InvoiceInfoTable);
        //paragraphOuter.add(addressParagraph);
        paragraphOuter.add(paragraphBody);

        // return connection to pool
        //conn.close();
        return paragraphOuter;
    }
}
