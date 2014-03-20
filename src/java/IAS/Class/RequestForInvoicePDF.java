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
public class RequestForInvoicePDF extends JDSPDF{

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
        PdfWriter pdfWriter = this.getPDFWriter(document, outputStream);
        //PDFEventHandler footer = new PDFEventHandler();
        //pdfWriter.setPageEvent(footer);
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
            DocumentException{

        //Connection conn = Database.getConnection();

        inwardModel _inwardModel = new inwardModel(this.request);
        InvoiceFormBean _invoiceBean = _inwardModel.getInvoiceDetail(InwardNumber);

        Paragraph paragraphOuter = new Paragraph();
        Paragraph addressParagraph = new Paragraph();
        PdfPTable addressTable = new PdfPTable(2);
        PdfPTable InvoiceInfoTable = new PdfPTable(2);
        Paragraph paragraphInvoiceInfo = new Paragraph();
        Paragraph paragraphBody = new Paragraph();
        Paragraph paragraphShippingAddress = new Paragraph();
        Paragraph paragraphInvoiceAddress = new Paragraph();

        //paragraphOuter.setSpacingBefore(JDSPDF.LESS_OUTER_PARAGRAPH_SPACE);
        //paragraphOuter.setIndentationLeft(JDSPDF.LEFT_INDENTATION_LESS);
        paragraphOuter.setAlignment(Element.ALIGN_LEFT);

        Paragraph invoiceHeader = new Paragraph(new Chunk("INVOICE",JDSPDF.JDS_FONT_BODY));
        invoiceHeader.setAlignment(Element.ALIGN_CENTER);

        InvoiceInfoTable.setWidthPercentage(100);
        Paragraph invoiceNumber = new Paragraph(new Chunk("Invoice No: " + _invoiceBean.getInvoiceNumber(), JDSPDF.JDS_FONT_BODY));
        Paragraph subscriberNumber = new Paragraph(new Chunk("Sub No: " + _invoiceBean.getSubscriberNumber(), JDSPDF.JDS_FONT_BODY));


        PdfPCell subscriberNumberCell = new PdfPCell(subscriberNumber);
        PdfPCell invoiceNumberCell = new PdfPCell(invoiceNumber);
        invoiceNumberCell.setPaddingRight(15);
        //PdfPCell invoiceHeaderCell = new PdfPCell(invoiceHeader);

        subscriberNumberCell.setBorder(Rectangle.NO_BORDER);
        subscriberNumberCell.setHorizontalAlignment(Element.ALIGN_LEFT);
        subscriberNumberCell.setVerticalAlignment(Element.ALIGN_TOP);
        subscriberNumberCell.setPaddingLeft(JDSPDF.LEFT_INDENTATION_LESS);

        //invoiceHeaderCell.setBorder(Rectangle.NO_BORDER);
        //invoiceHeaderCell.setHorizontalAlignment(Element.ALIGN_CENTER);
        //invoiceHeaderCell.setVerticalAlignment(Element.ALIGN_TOP);

        invoiceNumberCell.setBorder(Rectangle.NO_BORDER);
        //invoiceNumberCell.setPaddingLeft(JDSPDF.LEFT_INDENTATION_LESS * 3);
        invoiceNumberCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
        invoiceNumberCell.setVerticalAlignment(Element.ALIGN_TOP);

        InvoiceInfoTable.addCell(subscriberNumberCell);
        //InvoiceInfoTable.addCell(invoiceHeaderCell);
        InvoiceInfoTable.addCell(invoiceNumberCell);

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
        paragraphInvoiceAddress.add(new Phrase(_invoiceBean.getSubscriberName(),JDSPDF.JDS_FONT_BODY));
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
        int _pincode = _invoiceBean.getPincode();
        String _state = _invoiceBean.getState();

        if (_department != null && _department.length() > 0) {
            paragraphShippingAddress.add(Chunk.NEWLINE);
            paragraphShippingAddress.add(new Phrase(_department, JDSPDF.JDS_FONT_BODY));
        }

        if (_institute != null && _institute.length() > 0) {
            paragraphShippingAddress.add(Chunk.NEWLINE);
            paragraphShippingAddress.add(new Phrase(_institute, JDSPDF.JDS_FONT_BODY));
        }

        if(_shipping_address.length() > 0){
            paragraphShippingAddress.add(Chunk.NEWLINE);
            paragraphShippingAddress.add(new Phrase(_shipping_address, JDSPDF.JDS_FONT_BODY));
        }

        if(_city.length() > 0){
            paragraphShippingAddress.add(Chunk.NEWLINE);
            paragraphShippingAddress.add(new Phrase(_city, JDSPDF.JDS_FONT_BODY));
        }
         if(_state.length() > 0){
            paragraphShippingAddress.add(Chunk.NEWLINE);
            paragraphShippingAddress.add(new Phrase(_state, JDSPDF.JDS_FONT_BODY));
        }
        if(_country.length() > 0 && !_country.equalsIgnoreCase("india")){
            paragraphShippingAddress.add(Chunk.NEWLINE);
            paragraphShippingAddress.add(new Phrase(_country, JDSPDF.JDS_FONT_BODY));
        }

        if (_pincode > 0) {
            paragraphShippingAddress.add(Chunk.NEWLINE);
            paragraphShippingAddress.add(new Phrase(String.valueOf(_pincode), JDSPDF.JDS_FONT_BODY));
        }

        PdfPCell shippingAddressCell = new PdfPCell(paragraphShippingAddress);
        shippingAddressCell.setBorder(Rectangle.NO_BORDER);
        shippingAddressCell.setPaddingLeft(JDSPDF.LEFT_INDENTATION_MORE * 3);
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

        PdfPTable table = new PdfPTable(6);
        table.setWidthPercentage(100);
        table.setWidths(new int[]{4,1,1,2,1,1});

        PdfPCell cell1 = new PdfPCell(new Paragraph("Journal Name", JDSPDF.JDS_FONT_BODY));
        cell1.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell1.setVerticalAlignment(Element.ALIGN_MIDDLE);
        cell1.setColspan(2);

        PdfPCell cell4 = new PdfPCell(new Paragraph("Copies", JDSPDF.JDS_FONT_BODY));
        cell4.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell4.setVerticalAlignment(Element.ALIGN_MIDDLE);
        
        PdfPCell cell5 = new PdfPCell(new Paragraph("Subsciption period", JDSPDF.JDS_FONT_BODY));
        cell5.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell5.setVerticalAlignment(Element.ALIGN_MIDDLE);
        //cell5.setColspan(2);

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

        SubscriptionModel _model = new SubscriptionModel(request);
        java.util.List<IAS.Bean.Subscription.SubscriptionDetail> sub_details = _model.getSubscriptionDetailsObjectsForInward(InwardNumber);
        Iterator iterator = sub_details.iterator();

        HashMap JournalNamesHash = new HashMap();
        HashMap JournalGrpPriceHash = new HashMap();
        HashMap JournalGrpCopiesHash = new HashMap();
        HashMap JournalGrpPeriodHash = new HashMap();
        HashMap JournalGrpStartDateHash = new HashMap();
        HashMap JournalGrpEndDateHash = new HashMap();
        int total = 0;

        ArrayList<String> names;
        ArrayList JournalGrpIDs = new ArrayList<>();

        while (iterator.hasNext()) {
            IAS.Bean.Subscription.SubscriptionDetail detail = (IAS.Bean.Subscription.SubscriptionDetail) iterator.next();
            int _journalgrpid = detail.getJournalGroupID();

            // group the journal names by journal grp id
            // this can be done using a hash.
            if (JournalNamesHash.containsKey(_journalgrpid)) {
                // if the hash already contains the journal grp id then get the journal names
                names = (ArrayList) JournalNamesHash.get(_journalgrpid);
            } else {
                // add the journal grp id to array to maintaiin the order of print
                JournalGrpIDs.add(_journalgrpid);

                // if it does not have then initialize the array for the journal grp id
                names = new ArrayList<>();
                JournalNamesHash.put(_journalgrpid, new ArrayList<String>());
            }
            // append the new journal name to the list
            names.add(detail.getJournalName());
            // put it back into the hash
            JournalNamesHash.put(_journalgrpid, names);

            // fill in the price and total for each journal grp
            JournalGrpCopiesHash.put(_journalgrpid, detail.getCopies());
            JournalGrpPriceHash.put(_journalgrpid, detail.getTotal());
            JournalGrpPeriodHash.put(_journalgrpid, detail.getPeriod());
            JournalGrpStartDateHash.put(_journalgrpid, detail.getStartMonth() + "/" + detail.getStartYear());
            JournalGrpEndDateHash.put(_journalgrpid, detail.getEndMonth() + "/" + detail.getEndYear());

        }

        Iterator iterator_ids = JournalGrpIDs.iterator();
        int _journalgrpid;

        while (iterator_ids.hasNext()) {
            _journalgrpid = (int) iterator_ids.next();
            //names = new ArrayList<>();
            names = (ArrayList) JournalNamesHash.get(_journalgrpid);
            int _rowspan = names.size();
            boolean bprinted = false;
            for (String _jname : names) {
                PdfPCell c1 = new PdfPCell(new Phrase(_jname, JDSPDF.JDS_FONT_NORMAL_SMALL));
                c1.setHorizontalAlignment(Element.ALIGN_LEFT);
                c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
                c1.setColspan(2);
                table.addCell(c1);

                if (!bprinted) {
                    PdfPCell c2 = new PdfPCell(new Phrase(String.valueOf(JournalGrpPeriodHash.get(_journalgrpid)), JDSPDF.JDS_FONT_NORMAL_SMALL));
                    c2.setHorizontalAlignment(Element.ALIGN_CENTER);
                    c2.setVerticalAlignment(Element.ALIGN_MIDDLE);
                    c2.setRowspan(_rowspan);

                    int _grptotal = (int)JournalGrpPriceHash.get(_journalgrpid);
                    PdfPCell c3 = new PdfPCell(new Paragraph(String.valueOf(_grptotal), JDSPDF.JDS_FONT_NORMAL_SMALL));
                    c3.setHorizontalAlignment(Element.ALIGN_CENTER);
                    c3.setVerticalAlignment(Element.ALIGN_MIDDLE);
                    c3.setRowspan(_rowspan);
                    total += _grptotal;

                    PdfPCell c4 = new PdfPCell(new Paragraph(String.valueOf(JournalGrpCopiesHash.get(_journalgrpid)), JDSPDF.JDS_FONT_NORMAL_SMALL));
                    c4.setHorizontalAlignment(Element.ALIGN_CENTER);
                    c4.setVerticalAlignment(Element.ALIGN_MIDDLE);
                    c4.setRowspan(_rowspan);
                    
                    PdfPCell c5 = new PdfPCell(new Paragraph(String.valueOf(JournalGrpStartDateHash.get(_journalgrpid) + " to " + String.valueOf(JournalGrpEndDateHash.get(_journalgrpid))), JDSPDF.JDS_FONT_NORMAL_SMALL));
                    c5.setHorizontalAlignment(Element.ALIGN_CENTER);
                    c5.setVerticalAlignment(Element.ALIGN_MIDDLE);
                    //c5.setColspan(2);
                    c5.setRowspan(_rowspan);

                    bprinted = true;

                    table.addCell(c4);
                    table.addCell(c5);
                    table.addCell(c2);
                    table.addCell(c3);
                }
            }
        }

        PdfPCell blankCell = new PdfPCell(new Phrase("", JDSPDF.JDS_FONT_NORMAL_SMALL));
        blankCell.setHorizontalAlignment(Element.ALIGN_CENTER);
        blankCell.setVerticalAlignment(Element.ALIGN_MIDDLE);
        blankCell.setColspan(4);

        PdfPCell totalCell = new PdfPCell(new Phrase("Total", JDSPDF.JDS_FONT_NORMAL_SMALL));
        totalCell.setHorizontalAlignment(Element.ALIGN_CENTER);
        totalCell.setVerticalAlignment(Element.ALIGN_MIDDLE);

        PdfPCell totalValue = new PdfPCell(new Phrase(String.valueOf(total), JDSPDF.JDS_FONT_NORMAL_SMALL));
        totalValue.setHorizontalAlignment(Element.ALIGN_CENTER);
        totalValue.setVerticalAlignment(Element.ALIGN_MIDDLE);

        table.addCell(blankCell);
        table.addCell(totalCell);
        table.addCell(totalValue);

        //paragraphBody.add(new Phrase(bodyText));
        //paragraphBody.add(Chunk.NEWLINE);
        paragraphBody.add(table);

        // add the reference/letter number
        paragraphBody.add(Chunk.NEWLINE);
        String letterNoText = "Ref: Your Order No: %s Dated %s";
        if(_invoiceBean.getLetterNumber().length() > 0){
            letterNoText = String.format(letterNoText, _invoiceBean.getLetterNumber(), _invoiceBean.getLetterDate());
        }else{
            letterNoText = String.format(letterNoText, ".....", ".....");
        }
        paragraphBody.add(new Phrase(letterNoText, JDSPDF.JDS_FONT_BODY));
        paragraphBody.add(Chunk.NEWLINE);

        EnglishNumberToWords _EnglishNumberToWords = new EnglishNumberToWords();
        paragraphBody.add(Chunk.NEWLINE);
        paragraphBody.add(
                new Phrase(_EnglishNumberToWords.convertDouble(total).toUpperCase(), JDSPDF.JDS_FONT_BODY));//Convert total value in words
        paragraphOuter.add(invoiceHeader);
        paragraphOuter.add(InvoiceInfoTable);
        paragraphOuter.add(addressParagraph);
        paragraphOuter.add(paragraphBody);

        // return connection to pool
        //conn.close();
        return paragraphOuter;
    }
}
