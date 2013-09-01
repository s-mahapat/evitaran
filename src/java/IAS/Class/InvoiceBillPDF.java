/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import IAS.Bean.Invoice.InvoiceFormBean;
import IAS.Bean.Subscriber.subscriberFormBean;
import IAS.Model.Invoice.InvoiceModel;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Iterator;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;

/**
 *
 * @author Newton
 */
public class InvoiceBillPDF extends JDSPDF {

    //private HttpServletRequest request = null;

    public ByteArrayOutputStream getPDF(int invoiceid) throws DocumentException,
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
        document.add(this.getLetterBody(invoiceid));
        document.add(this.getLetterFooter());
        this.addPaymentFooter(document, pdfWriter);
        document.close();
        pdfWriter.close();
        return outputStream;

    }

    private Paragraph getLetterBody(int invoiceid) throws SQLException,
            ParseException,
            ParserConfigurationException,
            TransformerException,
            ClassNotFoundException,
            IOException,
            DocumentException {

        //Connection conn = Database.getConnection();

        //inwardModel _inwardModel = new inwardModel(this.request);
        //InvoiceFormBean _invoiceBean = _inwardModel.getInvoiceDetail(invoiceNumber);
        InvoiceModel invoiceModel = new InvoiceModel();
        subscriberFormBean subscriberbean = invoiceModel.getSubscriberInfo(invoiceid);

        Paragraph paragraphOuter = new Paragraph();
        Paragraph addressParagraph = new Paragraph();
        PdfPTable addressTable = new PdfPTable(2);
        PdfPTable InvoiceInfoTable = new PdfPTable(2);
        Paragraph paragraphInvoiceInfo = new Paragraph();
        Paragraph paragraphBody = new Paragraph();
        Paragraph paragraphShippingAddress = new Paragraph();
        Paragraph paragraphInvoiceAddress = new Paragraph();

        paragraphOuter.setSpacingBefore(JDSPDF.LESS_OUTER_PARAGRAPH_SPACE);
        paragraphOuter.setIndentationLeft(JDSPDF.LEFT_INDENTATION_LESS);
        paragraphOuter.setAlignment(Element.ALIGN_LEFT);

        Paragraph invoiceHeader = new Paragraph(new Chunk("STATEMENT", JDSPDF.JDS_FONT_BODY));
        invoiceHeader.setAlignment(Element.ALIGN_CENTER);

        InvoiceInfoTable.setWidthPercentage(100);
        //Paragraph invoiceNumber = new Paragraph(new Chunk("Invoice No: " + _invoiceBean.getInvoiceNumber(), JDSPDF.JDS_FONT_BODY));
        Paragraph subscriberNumber = new Paragraph(new Chunk("Sub No: " + subscriberbean.getSubscriberNumber(), JDSPDF.JDS_FONT_BODY));


        PdfPCell subscriberNumberCell = new PdfPCell(subscriberNumber);
        //PdfPCell invoiceNumberCell = new PdfPCell(invoiceNumber);
        //PdfPCell invoiceHeaderCell = new PdfPCell(invoiceHeader);

        subscriberNumberCell.setBorder(Rectangle.NO_BORDER);
        subscriberNumberCell.setHorizontalAlignment(Element.ALIGN_LEFT);
        subscriberNumberCell.setVerticalAlignment(Element.ALIGN_TOP);
        subscriberNumberCell.setPaddingLeft(JDSPDF.LEFT_INDENTATION_LESS);

        //invoiceHeaderCell.setBorder(Rectangle.NO_BORDER);
        //invoiceHeaderCell.setHorizontalAlignment(Element.ALIGN_CENTER);
        //invoiceHeaderCell.setVerticalAlignment(Element.ALIGN_TOP);

        //invoiceNumberCell.setBorder(Rectangle.NO_BORDER);
        //invoiceNumberCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
        // invoiceNumberCell.setVerticalAlignment(Element.ALIGN_TOP);

        InvoiceInfoTable.addCell(subscriberNumberCell);
        //InvoiceInfoTable.addCell(invoiceHeaderCell);
        //InvoiceInfoTable.addCell(invoiceNumberCell);

        //paragraphInvoiceInfo.setIndentationLeft(40);
        paragraphInvoiceInfo.setSpacingBefore(JDSPDF.OUTER_PARAGRAPH_SPACE);

        // create the shipping and invoice address table with 1 row and 2 cols
        addressParagraph.add(addressTable);
        addressParagraph.setIndentationLeft(JDSPDF.LEFT_INDENTATION_LESS);
        addressParagraph.setSpacingBefore(JDSPDF.LESS_OUTER_PARAGRAPH_SPACE);
        addressTable.setWidthPercentage(100);

        //paragraphInvoiceAddress.setIndentationLeft(JDSPDF.LEFT_INDENTATION_MORE);
        Chunk invoiceAddressHeader = new Chunk("INVOICE ADDRESS", JDSPDF.JDS_FONT_BODY);
        invoiceAddressHeader.setTextRise(2);
        invoiceAddressHeader.setUnderline(1, 0);
        paragraphInvoiceAddress.add(invoiceAddressHeader);
        paragraphInvoiceAddress.add(Chunk.NEWLINE);
        paragraphInvoiceAddress.add(new Phrase(subscriberbean.getSubscriberName(), JDSPDF.JDS_FONT_BODY));
        paragraphInvoiceAddress.add(Chunk.NEWLINE);
        paragraphInvoiceAddress.add(new Phrase(subscriberbean.getInvoiceAddress(), JDSPDF.JDS_FONT_BODY));

        //paragraphShippingAddress.setIndentationLeft(JDSPDF.LEFT_INDENTATION_MORE);
        Chunk shippingAddressHeader = new Chunk("SHIPPING ADDRESS", JDSPDF.JDS_FONT_BODY);
        shippingAddressHeader.setTextRise(2);
        shippingAddressHeader.setUnderline(1, 0);
        paragraphShippingAddress.add(shippingAddressHeader);
        paragraphShippingAddress.add(Chunk.NEWLINE);
        paragraphShippingAddress.add(new Phrase(subscriberbean.getSubscriberName(), JDSPDF.JDS_FONT_BODY));
        String _department = subscriberbean.getDepartment();
        String _institute = subscriberbean.getInstitution();
        String _shipping_address = subscriberbean.getShippingAddress();
        String _city = subscriberbean.getCity();
        String _country = subscriberbean.getCountry();
        String _state = subscriberbean.getState();
        int _pincode = subscriberbean.getPincode();

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
        if (subscriberbean.getPincode() > 0) {
            paragraphShippingAddress.add(Chunk.NEWLINE);
            paragraphShippingAddress.add(new Phrase(String.valueOf(_pincode), JDSPDF.JDS_FONT_BODY));
        }

        PdfPCell shippingAddressCell = new PdfPCell(paragraphShippingAddress);
        shippingAddressCell.setBorder(Rectangle.NO_BORDER);
        shippingAddressCell.setPaddingLeft(JDSPDF.LEFT_INDENTATION_MORE * 4);
        shippingAddressCell.setHorizontalAlignment(Element.ALIGN_LEFT);
        shippingAddressCell.setVerticalAlignment(Element.ALIGN_TOP);

        PdfPCell invoiceAddressCell = new PdfPCell(paragraphInvoiceAddress);
        invoiceAddressCell.setBorder(Rectangle.NO_BORDER);
        invoiceAddressCell.setHorizontalAlignment(Element.ALIGN_LEFT);
        invoiceAddressCell.setVerticalAlignment(Element.ALIGN_TOP);
        invoiceAddressCell.setPaddingLeft(JDSConstants.ADDRESS_LEFT_PADDING);

        addressTable.addCell(invoiceAddressCell);
        addressTable.addCell(shippingAddressCell);

        paragraphBody.setIndentationLeft(JDSPDF.LEFT_INDENTATION_LESS);
        paragraphBody.setSpacingBefore(JDSPDF.INNER_PARAGRAPH_SPACE);

        PdfPTable table = new PdfPTable(5);
        table.setWidthPercentage(100);
        table.setWidths(new int[]{1, 2, 1, 1, 1});

        PdfPCell cell1 = new PdfPCell(new Paragraph("Description", JDSPDF.JDS_FONT_NORMAL_SMALL_BOLD));
        cell1.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell1.setVerticalAlignment(Element.ALIGN_MIDDLE);
        //cell1.setColspan(2);

        PdfPCell cell4 = new PdfPCell(new Paragraph("Remarks", JDSPDF.JDS_FONT_NORMAL_SMALL_BOLD));
        cell4.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell4.setVerticalAlignment(Element.ALIGN_MIDDLE);

        PdfPCell cell3 = new PdfPCell(new Paragraph("Date", JDSPDF.JDS_FONT_NORMAL_SMALL_BOLD));
        cell3.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell3.setVerticalAlignment(Element.ALIGN_MIDDLE);

        PdfPCell cellp = new PdfPCell(new Paragraph("Paid", JDSPDF.JDS_FONT_NORMAL_SMALL_BOLD));
        cellp.setHorizontalAlignment(Element.ALIGN_CENTER);
        cellp.setVerticalAlignment(Element.ALIGN_MIDDLE);

        PdfPCell cell2 = new PdfPCell(new Paragraph("Due", JDSPDF.JDS_FONT_NORMAL_SMALL_BOLD));
        cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell2.setVerticalAlignment(Element.ALIGN_MIDDLE);

        table.addCell(cell1);
        table.addCell(cell4);
        table.addCell(cell3);
        table.addCell(cellp);
        table.addCell(cell2);

        // add the invoice information row
        InvoiceFormBean invoiceBean = invoiceModel.getInvoiceInfo(invoiceid);
        PdfPCell cell5 = new PdfPCell(new Phrase("Balance", JDSPDF.JDS_FONT_NORMAL_SMALL));
        cell5.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell5.setVerticalAlignment(Element.ALIGN_MIDDLE);
        //cell1.setColspan(2);

        PdfPCell cell6 = new PdfPCell(new Phrase("Invoice No: " + invoiceBean.getInvoiceNumber(), JDSPDF.JDS_FONT_NORMAL_SMALL));
        cell6.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell6.setVerticalAlignment(Element.ALIGN_MIDDLE);

        PdfPCell cell7 = new PdfPCell(new Phrase(invoiceBean.getInvoiceCreationDate(), JDSPDF.JDS_FONT_NORMAL_SMALL));
        cell7.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell7.setVerticalAlignment(Element.ALIGN_MIDDLE);

        PdfPCell cell8 = new PdfPCell(new Phrase(String.valueOf(invoiceBean.getAmount()), JDSPDF.JDS_FONT_NORMAL_SMALL));
        cell8.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell8.setVerticalAlignment(Element.ALIGN_MIDDLE);

        PdfPCell cell9 = new PdfPCell(new Phrase(String.valueOf(0), JDSPDF.JDS_FONT_NORMAL_SMALL));
        cell9.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell9.setVerticalAlignment(Element.ALIGN_MIDDLE);

        table.addCell(cell5);
        table.addCell(cell6);
        table.addCell(cell7);
        table.addCell(cell9);
        table.addCell(cell8);


        //end of 2nd row, i.e invoice info

        java.util.List<IAS.Class.PaymentInfo> payment_details = invoiceModel.getInvoicePayments(invoiceid);
        Iterator iterator = payment_details.iterator();
        float totalPaid = 0;
        float invoiceAmount = invoiceBean.getAmount();
        float due;

        while (iterator.hasNext()) {

            IAS.Class.PaymentInfo payment_detail = (IAS.Class.PaymentInfo)iterator.next();

            PdfPCell c1 = new PdfPCell(new Phrase("Payment", JDSPDF.JDS_FONT_NORMAL_SMALL));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            c1.setVerticalAlignment(Element.ALIGN_MIDDLE);

            PdfPCell c2 = new PdfPCell(new Phrase(payment_detail.getPaymentMode() + " No# " + payment_detail.getChqddNumber(), JDSPDF.JDS_FONT_NORMAL_SMALL));
            c2.setHorizontalAlignment(Element.ALIGN_CENTER);
            c2.setVerticalAlignment(Element.ALIGN_MIDDLE);

            PdfPCell c3 = new PdfPCell(new Phrase(payment_detail.getPaymentDate(), JDSPDF.JDS_FONT_NORMAL_SMALL));
            c3.setHorizontalAlignment(Element.ALIGN_CENTER);
            c3.setVerticalAlignment(Element.ALIGN_MIDDLE);

            float paymentAmount = payment_detail.getPaymentAmount();
            totalPaid += paymentAmount;
            due = invoiceAmount - totalPaid;

            PdfPCell c4 = new PdfPCell(new Phrase(String.valueOf(paymentAmount), JDSPDF.JDS_FONT_NORMAL_SMALL));
            c4.setHorizontalAlignment(Element.ALIGN_CENTER);
            c4.setVerticalAlignment(Element.ALIGN_MIDDLE);

            PdfPCell c5 = new PdfPCell(new Phrase(String.valueOf(due), JDSPDF.JDS_FONT_NORMAL_SMALL));
            c5.setHorizontalAlignment(Element.ALIGN_CENTER);
            c5.setVerticalAlignment(Element.ALIGN_MIDDLE);

            table.addCell(c1);
            table.addCell(c2);
            table.addCell(c3);
            table.addCell(c4);
            table.addCell(c5);

        }
        paragraphBody.add(table);

        // add the reference/letter number
        paragraphBody.add(Chunk.NEWLINE);
        /*String letterNoText = "Ref: Your Order No: %s Dated %s";
        if (_invoiceBean.getLetterNumber().length() > 0) {
            letterNoText = String.format(letterNoText, _invoiceBean.getLetterNumber(), _invoiceBean.getLetterDate());
        } else {
            letterNoText = String.format(letterNoText, ".....", ".....");
        }

        paragraphBody.add(new Phrase(letterNoText, JDSPDF.JDS_FONT_BODY));
        paragraphBody.add(Chunk.NEWLINE);
        * */

        EnglishNumberToWords _EnglishNumberToWords = new EnglishNumberToWords();
        paragraphBody.add(Chunk.NEWLINE);
        paragraphBody.add(
                new Phrase("Balance: " + _EnglishNumberToWords.convertDouble(invoiceBean.getBalance()).toUpperCase(), JDSPDF.JDS_FONT_BODY));//Convert total value in words
        paragraphOuter.add(invoiceHeader);
        paragraphOuter.add(InvoiceInfoTable);
        paragraphOuter.add(addressParagraph);
        paragraphOuter.add(paragraphBody);

        // return connection to pool
        //conn.close();
        return paragraphOuter;
    }
}
