package IAS.Class;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.sql.Connection;
import java.sql.SQLException;

public class InwardAckPDF extends JDSPDF {

    Connection conn = null;

    public InwardAckPDF(Connection _conn) {
        super();
        this.conn = _conn;
    }

    public ByteArrayOutputStream getPDF(int subscriptionID,
            String inwardNumber,
            String paymentMode,
            String inwardPurpose,
            int inwardPurposeID,
            String chqDDNumber,
            String chqDate,
            float amount,
            String LetterNumber,
            String LetterDate,
            String customText) throws SQLException, DocumentException, MalformedURLException, IOException {

        com.itextpdf.text.Document document = this.getPDFDocument();

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        PdfWriter pdfWriter = this.getPDFWriter(document, outputStream);

        document.open();
        document.add(this.getLetterHead());
        document.add(this.getSalutation());
        document.add(this.getInwardAckLetterBody(String.valueOf(subscriptionID),
                inwardNumber,
                paymentMode,
                inwardPurpose,
                inwardPurposeID,
                LetterNumber,
                LetterDate,
                chqDDNumber,
                chqDate,
                String.valueOf(amount),
                customText));
        document.add(this.getLetterFooter());
        document.close();
        pdfWriter.close();
        return outputStream;

    }

    private Paragraph getInwardAckLetterBody(String subscriptionID,
            String inwardNumber,
            String paymentMode,
            String inwardPurpose,
            int inwardPurposeID,
            String letterNumber,
            String LetterDate,
            String chequeDDNo,
            String chqDate,
            String amount,
            String customText) throws SQLException, IOException {

        Paragraph paragraph1 = new Paragraph();
        Paragraph paragraph2 = new Paragraph();
        Paragraph paragraph3 = new Paragraph();
        //Paragraph pcustomText = new Paragraph();
        //Paragraph paragraphinwardNumber = new Paragraph(inwardNumber, JDSPDF.JDS_FONT_BODY);
        //paragraphinwardNumber.setAlignment(Element.ALIGN_LEFT);

        paragraph1.setSpacingBefore(JDSPDF.OUTER_PARAGRAPH_SPACE);
        paragraph1.setIndentationLeft(JDSPDF.LEFT_INDENTATION_LESS);
        paragraph1.setAlignment(Element.ALIGN_LEFT);

        paragraph2.setIndentationLeft(JDSPDF.LEFT_INDENTATION_LESS);
        paragraph2.setSpacingBefore(JDSPDF.INNER_PARAGRAPH_SPACE);

        paragraph3.setIndentationLeft(JDSPDF.LEFT_INDENTATION_LESS);
        paragraph3.setSpacingBefore(JDSPDF.INNER_PARAGRAPH_SPACE);

        //pcustomText.setIndentationLeft(JDSPDF.LEFT_INDENTATION_LESS);
        //pcustomText.setSpacingBefore(JDSPDF.INNER_PARAGRAPH_SPACE);

        //paragraph1.add(paragraphinwardNumber);
        paragraph1.add(new Chunk("Subject: Acknowledgement of your request", JDSPDF.JDS_FONT_BODY));
        paragraph1.add(Chunk.NEWLINE);

        // do not add the letter number header if it is not present/given
        // by the user/ui
        /*if (letterNumber != null && letterNumber.length() > 0) {
            paragraph1.add(Chunk.NEWLINE);
            paragraph1.add(new Chunk("Your Letter No: " + letterNumber + " Dated: " + LetterDate, JDSPDF.JDS_FONT_BODY));
        }*/

        String bodyText;
        float _amount = Float.parseFloat(amount);

        InwardAck _ack = new InwardAck();
        bodyText = _ack.getText(chequeDDNo, chqDate, _amount, paymentMode, inwardPurposeID, inwardPurpose, letterNumber, LetterDate);
        if (!customText.isEmpty()) {
            bodyText = bodyText + " " + customText;
        }
        paragraph2.add(new Phrase(bodyText, JDSPDF.JDS_FONT_BODY));

        // get all the subscription details for the inward
        /*String sql = Queries.getQuery("get_subscription_details_for_inward");
         PreparedStatement pst = conn.prepareStatement(sql);
         pst.setString(1, inwardNumber);
         PdfPTable table;
         try (ResultSet rs = pst.executeQuery()) {
         table = new PdfPTable(4);
         table.setWidthPercentage(98);

         PdfPCell cell1 = new PdfPCell(new Paragraph("Journal Name"));
         cell1.setHorizontalAlignment(Element.ALIGN_CENTER);
         cell1.setVerticalAlignment(Element.ALIGN_MIDDLE);

         PdfPCell cell2 = new PdfPCell(new Paragraph("Start Year"));
         cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
         cell2.setVerticalAlignment(Element.ALIGN_MIDDLE);

         PdfPCell cell3 = new PdfPCell(new Paragraph("End Year"));
         cell3.setHorizontalAlignment(Element.ALIGN_CENTER);
         cell3.setVerticalAlignment(Element.ALIGN_MIDDLE);

         PdfPCell cell4 = new PdfPCell(new Paragraph("Copies"));
         cell4.setHorizontalAlignment(Element.ALIGN_CENTER);
         cell4.setVerticalAlignment(Element.ALIGN_MIDDLE);

         table.addCell(cell1);
         table.addCell(cell2);
         table.addCell(cell3);
         table.addCell(cell4);


         while (rs.next()) {
         String journalName = rs.getString("journalName");
         String startYear = String.valueOf(rs.getInt("startYear"));
         String endYear = String.valueOf(rs.getInt("endYear"));;
         String copies = String.valueOf(rs.getInt("copies"));

         PdfPCell c1 = new PdfPCell(new Phrase(journalName, JDSPDF.JDS_FONT_NORMAL_SMALL));
         c1.setHorizontalAlignment(Element.ALIGN_CENTER);
         c1.setVerticalAlignment(Element.ALIGN_MIDDLE);

         PdfPCell c2 = new PdfPCell(new Phrase(startYear, JDSPDF.JDS_FONT_NORMAL_SMALL));
         c2.setHorizontalAlignment(Element.ALIGN_CENTER);
         c2.setVerticalAlignment(Element.ALIGN_MIDDLE);

         PdfPCell c3 = new PdfPCell(new Paragraph(endYear, JDSPDF.JDS_FONT_NORMAL_SMALL));
         c3.setHorizontalAlignment(Element.ALIGN_CENTER);
         c3.setVerticalAlignment(Element.ALIGN_MIDDLE);

         PdfPCell c4 = new PdfPCell(new Paragraph(copies, JDSPDF.JDS_FONT_NORMAL_SMALL));
         c4.setHorizontalAlignment(Element.ALIGN_CENTER);
         c4.setVerticalAlignment(Element.ALIGN_MIDDLE);

         table.addCell(c1);
         table.addCell(c2);
         table.addCell(c3);
         table.addCell(c4);
         }
         }*/

        paragraph1.add(paragraph2);
        //paragraph3.add(table);
        //paragraph3.add(Chunk.NEWLINE);

        paragraph1.add(paragraph3);
        //paragraph3.add(Chunk.NEWLINE);
        //paragraph3.add(new Chunk("Subscription No: " + subscriptionID));
        paragraph3.add(Chunk.NEWLINE);
        paragraph3.add(new Chunk("Inward No: " + inwardNumber, JDSPDF.JDS_FONT_BODY));
        //paragraph3.add(Chunk.NEWLINE);


        return paragraph1;

    }
}
