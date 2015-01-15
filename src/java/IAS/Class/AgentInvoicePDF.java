/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import IAS.Bean.Invoice.InvoiceFormBean;
import IAS.Bean.Inward.inwardFormBean;
import IAS.Model.AgentProc.agentProcModel;
import IAS.Model.Inward.inwardModel;
import IAS.Model.Subscription.SubscriptionModel;
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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
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
        
        float discount = _agentProcModel.getDiscount(_inwardFormBean.getAgentID());

        double invoiceTotal = 0;

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

        InvoiceInfoTable.setWidthPercentage(75);
        Paragraph invoiceNumber = new Paragraph(new Chunk("Invoice No: " + _invoiceBean.getInvoiceNumber(), JDSPDF.JDS_FONT_BODY));
        Paragraph inwardNumber = new Paragraph(new Chunk("Inward No: " + InwardNumber, JDSPDF.JDS_FONT_BODY));
        Paragraph invoiceDate = new Paragraph(new Chunk("Invoice Date: " + _invoiceBean.getInvoiceCreationDate(), JDSPDF.JDS_FONT_BODY));

        PdfPCell inwardNumberCell = new PdfPCell(inwardNumber);
        PdfPCell invoiceNumberCell = new PdfPCell(invoiceNumber);
        PdfPCell invoiceDateCell = new PdfPCell(invoiceDate);
        PdfPCell blankCell = new PdfPCell();
        blankCell.setBorder(Rectangle.NO_BORDER);

        invoiceNumberCell.setBorder(Rectangle.NO_BORDER);
        invoiceNumberCell.setHorizontalAlignment(Element.ALIGN_LEFT);
        invoiceNumberCell.setVerticalAlignment(Element.ALIGN_TOP);
        invoiceNumberCell.setPaddingLeft(JDSPDF.LEFT_INDENTATION_MORE * 3);

        inwardNumberCell.setBorder(Rectangle.NO_BORDER);
        inwardNumberCell.setHorizontalAlignment(Element.ALIGN_LEFT);
        inwardNumberCell.setVerticalAlignment(Element.ALIGN_TOP);
        
        invoiceDateCell.setBorder(Rectangle.NO_BORDER);
        invoiceDateCell.setHorizontalAlignment(Element.ALIGN_LEFT);
        invoiceDateCell.setVerticalAlignment(Element.ALIGN_TOP);
        invoiceDateCell.setPaddingLeft(JDSPDF.LEFT_INDENTATION_MORE * 3);

        InvoiceInfoTable.addCell(inwardNumberCell);
        InvoiceInfoTable.addCell(invoiceNumberCell);
        InvoiceInfoTable.addCell(blankCell);
        InvoiceInfoTable.addCell(invoiceDateCell);
        
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
        paragraphInvoiceAddress.add(new Phrase(_inwardFormBean.getAgentName(), JDSPDF.JDS_FONT_BODY));
        paragraphInvoiceAddress.add(Chunk.NEWLINE);
        paragraphInvoiceAddress.add(new Phrase(_invoiceBean.getInvoiceAddress(), JDSPDF.JDS_FONT_BODY));
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

        // get all the subscriptions for the agent inward
        SubscriptionModel _model = new SubscriptionModel(request);
        java.util.List<IAS.Bean.Subscription.SubscriptionFormBean> subscriptions = _model.getSubscriptionsForInward(InwardNumber);

        HashMap JournalNamesHash = new HashMap();
        HashMap JournalGrpPriceHash = new HashMap();
        HashMap JournalGrpCopiesHash = new HashMap();
        HashMap JournalGrpPeriodHash = new HashMap();
        HashMap JournalGrpStartDateHash = new HashMap();
        HashMap JournalGrpEndDateHash = new HashMap();

        // for each subscription create the invoice address table and subscription details table
        for (IAS.Bean.Subscription.SubscriptionFormBean subscription : subscriptions) {
            
            JournalNamesHash.clear();
            JournalGrpPriceHash.clear();
            JournalGrpCopiesHash.clear();
            JournalGrpPeriodHash.clear();
            JournalGrpStartDateHash.clear();
            JournalGrpEndDateHash.clear();

            IAS.Bean.Subscriber.subscriberFormBean subscriber = (new IAS.Model.Subscriber.subscriberModel()).GetSubscriber(subscription.getSubscriberNumber());

            PdfPTable addressTable = new PdfPTable(1);
            addressTable.setWidthPercentage(75);

            // subscriber number cell
            PdfPCell subNoCell = new PdfPCell(new Phrase("Sub No: " + String.valueOf(subscription.getSubscriberNumber()), JDSPDF.JDS_FONT_BODY));
            subNoCell.setHorizontalAlignment(Element.ALIGN_LEFT);
            subNoCell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            subNoCell.setBorder(Rectangle.NO_BORDER);

            // subscriber invoice address cell
            PdfPCell subInvAddCell = new PdfPCell(new Phrase(String.valueOf(subscriber.getInvoiceAddress()), JDSPDF.JDS_FONT_BODY));
            subInvAddCell.setHorizontalAlignment(Element.ALIGN_LEFT);
            subInvAddCell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            subInvAddCell.setBorder(Rectangle.NO_BORDER);

            addressTable.addCell(subNoCell);
            addressTable.addCell(subInvAddCell);
            paragraphBody.add(addressTable);

            java.util.List<IAS.Bean.Subscription.SubscriptionDetail> sub_details = _model.getSubscriptionDetailsForSubscription(subscription.getSubscriptionID());

            int total = 0;

            ArrayList<String> names;
            ArrayList JournalGrpIDs = new ArrayList<>();
            
            PdfPTable table = new PdfPTable(6);
            table.setSpacingBefore(JDSPDF.INNER_PARAGRAPH_SPACE);
            table.setSpacingAfter(JDSPDF.INNER_PARAGRAPH_SPACE * 2);
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

            for (IAS.Bean.Subscription.SubscriptionDetail detail : sub_details) {
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

            for (Object _journalgrpid : JournalGrpIDs) {
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

                        int _grptotal = (int) JournalGrpPriceHash.get(_journalgrpid);
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
                        c5.setRowspan(_rowspan);

                        bprinted = true;

                        table.addCell(c4);
                        table.addCell(c5);
                        table.addCell(c2);
                        table.addCell(c3);
                    }
                }
            }
            PdfPCell totalCellText = new PdfPCell(new Paragraph("Total", JDSPDF.JDS_FONT_NORMAL_SMALL));
                        totalCellText.setHorizontalAlignment(Element.ALIGN_RIGHT);
                        totalCellText.setVerticalAlignment(Element.ALIGN_MIDDLE);
                        totalCellText.setColspan(5);
            PdfPCell totalCell = new PdfPCell(new Paragraph(String.valueOf(total), JDSPDF.JDS_FONT_NORMAL_SMALL));
                        totalCell.setHorizontalAlignment(Element.ALIGN_CENTER);
                        totalCell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            table.addCell(totalCellText);
            table.addCell(totalCell);
            
            paragraphBody.add(table);
            
            // add the subscription total to invoice total
            invoiceTotal += total;

        }

        //*********************************
        //Balance Table
        //*********************************
        PdfPTable btable = new PdfPTable(5);
        btable.setSpacingBefore(JDSPDF.INNER_PARAGRAPH_SPACE);
        btable.setWidthPercentage(75);

        PdfPCell bcell1 = new PdfPCell(new Paragraph("Subscription value", JDSPDF.JDS_FONT_BODY));
        bcell1.setHorizontalAlignment(Element.ALIGN_CENTER);
        bcell1.setVerticalAlignment(Element.ALIGN_MIDDLE);
        
        PdfPCell bcell4 = new PdfPCell(new Paragraph("Discount(%)", JDSPDF.JDS_FONT_BODY));
        bcell4.setHorizontalAlignment(Element.ALIGN_CENTER);
        bcell4.setVerticalAlignment(Element.ALIGN_MIDDLE);
        
        PdfPCell bcell5 = new PdfPCell(new Paragraph("Discounted value", JDSPDF.JDS_FONT_BODY));
        bcell5.setHorizontalAlignment(Element.ALIGN_CENTER);
        bcell5.setVerticalAlignment(Element.ALIGN_MIDDLE);

        PdfPCell bcell2 = new PdfPCell(new Paragraph("Amount paid", JDSPDF.JDS_FONT_BODY));
        bcell2.setHorizontalAlignment(Element.ALIGN_CENTER);
        bcell2.setVerticalAlignment(Element.ALIGN_MIDDLE);

        PdfPCell bcell3 = new PdfPCell(new Paragraph("Balance", JDSPDF.JDS_FONT_BODY));
        bcell3.setHorizontalAlignment(Element.ALIGN_CENTER);
        bcell3.setVerticalAlignment(Element.ALIGN_MIDDLE);

        btable.addCell(bcell1);
        btable.addCell(bcell4);
        btable.addCell(bcell5);
        btable.addCell(bcell2);
        btable.addCell(bcell3);

        PdfPCell c1 = new PdfPCell(new Phrase(String.valueOf(invoiceTotal), JDSPDF.JDS_FONT_NORMAL_SMALL));
        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
        c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
        btable.addCell(c1);
        
        PdfPCell c4 = new PdfPCell(new Phrase(String.valueOf(discount), JDSPDF.JDS_FONT_NORMAL_SMALL));
        c4.setHorizontalAlignment(Element.ALIGN_CENTER);
        c4.setVerticalAlignment(Element.ALIGN_MIDDLE);
        btable.addCell(c4);
        
        PdfPCell c5 = new PdfPCell(new Phrase(String.valueOf(_invoiceBean.getSubscriptionTotal()), JDSPDF.JDS_FONT_NORMAL_SMALL));
        c5.setHorizontalAlignment(Element.ALIGN_CENTER);
        c5.setVerticalAlignment(Element.ALIGN_MIDDLE);
        btable.addCell(c5);

        PdfPCell c2 = new PdfPCell(new Phrase(String.valueOf(_inwardFormBean.getAmount()), JDSPDF.JDS_FONT_NORMAL_SMALL));
        c2.setHorizontalAlignment(Element.ALIGN_CENTER);
        c2.setVerticalAlignment(Element.ALIGN_MIDDLE);
        btable.addCell(c2);

        PdfPCell c3 = new PdfPCell(new Phrase(String.valueOf(_invoiceBean.getBalance()), JDSPDF.JDS_FONT_NORMAL_SMALL));
        c3.setHorizontalAlignment(Element.ALIGN_CENTER);
        c3.setVerticalAlignment(Element.ALIGN_MIDDLE);
        btable.addCell(c3);

        //*********************************
        //Convert balance in words
        //*********************************
        paragraphBody.add(btable);
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

    /*private void addSubscriptionDetail(int ){
        
     }*/
}
