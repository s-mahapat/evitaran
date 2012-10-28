/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import IAS.Bean.Invoice.InvoiceFormBean;
import IAS.Model.Inward.inwardModel;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;

/**
 *
 * @author Newton
 */
public class RequestForInvoicePDF extends JDSPDF {

    private HttpServletRequest request = null;

    public RequestForInvoicePDF(HttpServletRequest request) throws SQLException {
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
        PdfWriter pdfWriter = PdfWriter.getInstance(document, outputStream);

        document.open();
        document.add(this.getLetterHead());
        //document.add(this.getSalutation());
        document.add(this.getRFILetterBody(InwardNumber));
        document.add(this.getLetterFooter());
        document.add(this.getPaymentFooter());
        document.close();
        return outputStream;

    }

    private Paragraph getRFILetterBody(String InwardNumber) throws SQLException,
            ParseException,
            ParserConfigurationException,
            TransformerException,
            ClassNotFoundException,
            IOException {

        Connection conn = Database.getConnection();

        inwardModel _inwardModel = new inwardModel(this.request);
        InvoiceFormBean _invoiceBean = _inwardModel.getInvoiceDetail(InwardNumber);


        Paragraph paragraphOuter = new Paragraph();
        Paragraph addressParagraph = new Paragraph();
        PdfPTable addressTable = new PdfPTable(2);
        PdfPTable InvoiceInfoTable = new PdfPTable(3);
        Paragraph paragraphInvoiceInfo = new Paragraph();
        Paragraph paragraphBody = new Paragraph();
        Paragraph paragraphShippingAddress = new Paragraph();
        Paragraph paragraphInvoiceAddress = new Paragraph();

        paragraphOuter.setSpacingBefore(JDSPDF.LESS_OUTER_PARAGRAPH_SPACE);
        paragraphOuter.setIndentationLeft(JDSPDF.LEFT_INDENTATION_LESS);
        paragraphOuter.setAlignment(Element.ALIGN_LEFT);
        
        InvoiceInfoTable.setWidthPercentage(100);        
        Paragraph invoiceNumber = new Paragraph(new Chunk("Invoice No: " + _invoiceBean.getInvoiceNumber()));
        Paragraph subscriberNumber = new Paragraph(new Chunk("Sub No: " + _invoiceBean.getSubscriberNumber()));
        Paragraph invoiceHeader = new Paragraph(new Chunk("INVOICE"));
        
        PdfPCell subscriberNumberCell = new PdfPCell(subscriberNumber);
        PdfPCell invoiceNumberCell = new PdfPCell(invoiceNumber);
        PdfPCell invoiceHeaderCell = new PdfPCell(invoiceHeader);
        
        subscriberNumberCell.setBorder(Rectangle.NO_BORDER);
        subscriberNumberCell.setHorizontalAlignment(Element.ALIGN_LEFT);
        subscriberNumberCell.setVerticalAlignment(Element.ALIGN_TOP);
        subscriberNumberCell.setPaddingLeft(JDSPDF.LEFT_INDENTATION_LESS);
        
        invoiceHeaderCell.setBorder(Rectangle.NO_BORDER);
        invoiceHeaderCell.setHorizontalAlignment(Element.ALIGN_CENTER);
        invoiceHeaderCell.setVerticalAlignment(Element.ALIGN_TOP);
        
        invoiceNumberCell.setBorder(Rectangle.NO_BORDER);
        invoiceNumberCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
        invoiceNumberCell.setVerticalAlignment(Element.ALIGN_TOP);
        
        InvoiceInfoTable.addCell(subscriberNumberCell);
        InvoiceInfoTable.addCell(invoiceHeaderCell);
        InvoiceInfoTable.addCell(invoiceNumberCell);
        
        //paragraphInvoiceInfo.setIndentationLeft(40);
        paragraphInvoiceInfo.setSpacingBefore(JDSPDF.OUTER_PARAGRAPH_SPACE);


        // create the shipping and invoice address table with 1 row and 2 cols        
        addressParagraph.add(addressTable);
        addressParagraph.setIndentationLeft(JDSPDF.LEFT_INDENTATION_LESS);
        addressParagraph.setSpacingBefore(JDSPDF.LESS_OUTER_PARAGRAPH_SPACE);
        addressTable.setWidthPercentage(100);

        //paragraphInvoiceAddress.setIndentationLeft(JDSPDF.LEFT_INDENTATION_MORE);
        Chunk invoiceAddressHeader = new Chunk("INVOICE ADDRESS");
        invoiceAddressHeader.setTextRise(2);
        invoiceAddressHeader.setUnderline(1, 0);
        paragraphInvoiceAddress.add(invoiceAddressHeader);
        paragraphInvoiceAddress.add(Chunk.NEWLINE);
        paragraphInvoiceAddress.add(new Phrase(_invoiceBean.getSubscriberName()));
        paragraphInvoiceAddress.add(Chunk.NEWLINE);
        paragraphInvoiceAddress.add(new Phrase(_invoiceBean.getInvoiceAddress()));

        //paragraphShippingAddress.setIndentationLeft(JDSPDF.LEFT_INDENTATION_MORE);
        Chunk shippingAddressHeader = new Chunk("SHIPPING ADDRESS");
        shippingAddressHeader.setTextRise(2);
        shippingAddressHeader.setUnderline(1, 0);
        paragraphShippingAddress.add(shippingAddressHeader);
        paragraphShippingAddress.add(Chunk.NEWLINE);
        paragraphShippingAddress.add(new Phrase(_invoiceBean.getSubscriberName()));
        if (_invoiceBean.getDepartment() != null) {
            paragraphShippingAddress.add(Chunk.NEWLINE);
            paragraphShippingAddress.add(new Phrase(_invoiceBean.getDepartment()));
        }
        if (_invoiceBean.getInstitute() != null) {
            paragraphShippingAddress.add(Chunk.NEWLINE);
            paragraphShippingAddress.add(new Phrase(_invoiceBean.getInstitute()));
        }
        paragraphShippingAddress.add(Chunk.NEWLINE);
        paragraphShippingAddress.add(new Phrase(_invoiceBean.getShippingAddress()));
        paragraphShippingAddress.add(Chunk.NEWLINE);
        paragraphShippingAddress.add(new Phrase(_invoiceBean.getCity()));
        paragraphShippingAddress.add(Chunk.NEWLINE);
        paragraphShippingAddress.add(new Phrase(_invoiceBean.getCountry()));
        if (_invoiceBean.getPincode() > 0) {
            paragraphShippingAddress.add(Chunk.NEWLINE);
            paragraphShippingAddress.add(new Phrase(String.valueOf(_invoiceBean.getPincode())));
        }

        PdfPCell shippingAddressCell = new PdfPCell(paragraphShippingAddress);
        shippingAddressCell.setBorder(Rectangle.NO_BORDER);
        shippingAddressCell.setPaddingLeft(JDSPDF.LEFT_INDENTATION_MORE * 4);
        shippingAddressCell.setHorizontalAlignment(Element.ALIGN_LEFT);
        shippingAddressCell.setVerticalAlignment(Element.ALIGN_TOP);



        PdfPCell invoiceAddressCell = new PdfPCell(paragraphInvoiceAddress);
        invoiceAddressCell.setBorder(Rectangle.NO_BORDER);
        //invoiceAddressCell.setPaddingLeft(JDSPDF.LEFT_INDENTATION_MORE * 4);
        invoiceAddressCell.setHorizontalAlignment(Element.ALIGN_LEFT);
        invoiceAddressCell.setVerticalAlignment(Element.ALIGN_TOP);

        addressTable.addCell(invoiceAddressCell);
        addressTable.addCell(shippingAddressCell);


        paragraphBody.setIndentationLeft(JDSPDF.LEFT_INDENTATION_LESS);
        paragraphBody.setSpacingBefore(JDSPDF.INNER_PARAGRAPH_SPACE);

        /*Properties props = new Properties();
         props.load(this.pdfTemplatesFile);
         String template = props.getProperty("inward_request_for_invoice");
         String bodyText = String.format(template, _invoiceBean.getInvoiceNumber(),
         _invoiceBean.getInvoiceCreationDate(), _invoiceBean.getSubscriptionTotal());*/



        // get all the subscription details for the inward
        String sql = Queries.getQuery("get_subscription_details_for_inward");

        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, InwardNumber);
        PdfPTable table;
        try (ResultSet rs = pst.executeQuery()) {
            table = new PdfPTable(4);
            table.setWidthPercentage(98);

            PdfPCell cell1 = new PdfPCell(new Paragraph("Journal Name"));
            cell1.setHorizontalAlignment(Element.ALIGN_MIDDLE);
            cell1.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell1.setColspan(2);

            PdfPCell cell2 = new PdfPCell(new Paragraph("No. of Years"));
            cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell2.setVerticalAlignment(Element.ALIGN_MIDDLE);

            PdfPCell cell3 = new PdfPCell(new Paragraph("Rs."));
            cell3.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell3.setVerticalAlignment(Element.ALIGN_MIDDLE);

            /*PdfPCell cell4 = new PdfPCell(new Paragraph("Copies"));
            cell4.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell4.setVerticalAlignment(Element.ALIGN_MIDDLE);*/

            table.addCell(cell1);
            table.addCell(cell2);
            table.addCell(cell3);
            //table.addCell(cell4);           
            int total = 0;
            while (rs.next()) {
                String journalName = rs.getString("journalName");
                /*String startYear = String.valueOf(rs.getInt("startYear"));
                String endYear = String.valueOf(rs.getInt("endYear"));*/
                String years = String.valueOf(rs.getInt("period"));
                int _rate = rs.getInt("rate");
                total += _rate;
                String rate = String.valueOf(_rate);
                
                //String copies = String.valueOf(rs.getInt("copies"));

                PdfPCell c1 = new PdfPCell(new Phrase(journalName, JDSPDF.JDS_FONT_NORMAL_SMALL));
                c1.setHorizontalAlignment(Element.ALIGN_LEFT);
                c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
                c1.setColspan(2);

                PdfPCell c2 = new PdfPCell(new Phrase(years, JDSPDF.JDS_FONT_NORMAL_SMALL));
                c2.setHorizontalAlignment(Element.ALIGN_CENTER);
                c2.setVerticalAlignment(Element.ALIGN_MIDDLE);

                PdfPCell c3 = new PdfPCell(new Paragraph(rate, JDSPDF.JDS_FONT_NORMAL_SMALL));
                c3.setHorizontalAlignment(Element.ALIGN_CENTER);
                c3.setVerticalAlignment(Element.ALIGN_MIDDLE);

                /*PdfPCell c4 = new PdfPCell(new Paragraph(copies, JDSPDF.JDS_FONT_NORMAL_SMALL));
                c4.setHorizontalAlignment(Element.ALIGN_CENTER);
                c4.setVerticalAlignment(Element.ALIGN_MIDDLE);*/

                table.addCell(c1);
                table.addCell(c2);
                table.addCell(c3);
                //table.addCell(c4);
            }
            
            PdfPCell blankCell = new PdfPCell(new Phrase("", JDSPDF.JDS_FONT_NORMAL_SMALL));
            blankCell.setHorizontalAlignment(Element.ALIGN_CENTER);
            blankCell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            blankCell.setColspan(2);
            
            PdfPCell totalCell = new PdfPCell(new Phrase("Total", JDSPDF.JDS_FONT_NORMAL_SMALL));
            totalCell.setHorizontalAlignment(Element.ALIGN_CENTER);
            totalCell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            
            PdfPCell totalValue = new PdfPCell(new Phrase(String.valueOf(total), JDSPDF.JDS_FONT_NORMAL_SMALL));
            totalValue.setHorizontalAlignment(Element.ALIGN_CENTER);
            totalValue.setVerticalAlignment(Element.ALIGN_MIDDLE);
            
            table.addCell(blankCell);
            table.addCell(totalCell);
            table.addCell(totalValue);
        }

        //paragraphBody.add(new Phrase(bodyText));
        //paragraphBody.add(Chunk.NEWLINE);
        paragraphBody.add(table);

        /*paragraphBody.add(Chunk.NEWLINE);
         paragraphBody.add(new Chunk("Subscription No: " + _invoiceBean.getSubscriptionID()));
         paragraphBody.add(Chunk.NEWLINE);
         paragraphBody.add(new Chunk("Inward No: " + _invoiceBean.getInwardNumber()));
         paragraphBody.add(Chunk.NEWLINE);
         paragraphBody.add(Chunk.NEWLINE);
         String notice = props.getProperty("subscription_number_notice");
         paragraphBody.add(new Chunk(notice));
         */
        paragraphOuter.add(InvoiceInfoTable);
        paragraphOuter.add(addressParagraph);
        //paragraphOuter.add(paragraphInvoiceAddress);
        //paragraphOuter.add(this.getSalutation());
        //paragraphOuter.add(Chunk.NEWLINE);
        paragraphOuter.add(paragraphBody);

        // return connection to pool
        conn.close();
        return paragraphOuter;
    }
}
