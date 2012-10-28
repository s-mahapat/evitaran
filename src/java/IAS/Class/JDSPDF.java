/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import javax.servlet.ServletContext;

public class JDSPDF implements IJDSPDF {

    public InputStream pdfTemplatesFile = null;
    public static int OUTER_PARAGRAPH_SPACE = 10;
    public static int LESS_OUTER_PARAGRAPH_SPACE = 2;
    public static int INNER_PARAGRAPH_SPACE = 10;
    public static int LEFT_INDENTATION_LESS = 15;
    public static int RIGHT_INDENTATION_LESS = 15;
    public static int LEFT_INDENTATION_MORE = 30;
    public static Font JDS_BOLD_FONT = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD, BaseColor.BLACK);
    public static Font JDS_FONT_NORMAL_SMALL = new Font(Font.FontFamily.HELVETICA, 10, Font.NORMAL, BaseColor.BLACK);
    public static Font JDS_FONT_NORMAL_SMALL_BOLD = new Font(Font.FontFamily.HELVETICA, 10, Font.BOLD, BaseColor.BLACK);

    public JDSPDF() {
        ServletContext context = ServletContextInfo.getServletContext();
        this.pdfTemplatesFile = context.getResourceAsStream("/WEB-INF/classes/pdf_templates.properties");
    }

    @Override
    public ByteArrayOutputStream getPDF() {
        throw (new UnsupportedOperationException("This method has to be overriden"));
    }

    public Document getPDFDocument() {
        com.itextpdf.text.Document document = new com.itextpdf.text.Document(PageSize.A4);
        document.addAuthor("Indian Academy Of Sciences");
        document.addCreator("Indian Academy Of Sciences");
        document.addSubject("Indian Academy Of Sciences");
        document.addCreationDate();
        document.addTitle("Indian Academy Of Sciences");
        return document;
    }

    public Document getPDFDocumentLandscape() {
        com.itextpdf.text.Document document = new com.itextpdf.text.Document(PageSize.A4.rotate());
        document.addAuthor("Indian Academy Of Sciences");
        document.addCreator("Indian Academy Of Sciences");
        document.addSubject("Indian Academy Of Sciences");
        document.addCreationDate();
        document.addTitle("Indian Academy Of Sciences");
        return document;
    }

    public Paragraph getLetterHead() throws BadElementException, java.net.MalformedURLException, IOException {
        Paragraph paragraph = new Paragraph();
        Paragraph paragraphDate = new Paragraph();

        paragraph.setAlignment(Element.ALIGN_CENTER);
        paragraphDate.setAlignment(Element.ALIGN_RIGHT);
        paragraphDate.setIndentationRight(JDSPDF.RIGHT_INDENTATION_LESS);

        ServletContext context = ServletContextInfo.getServletContext();
        String logo = context.getRealPath("/images/pdflogo.jpg");

        Image _logo = Image.getInstance(logo);
        _logo.setAlignment(Element.ALIGN_CENTER);
        paragraph.add(_logo);

        Font _IASFont = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD, BaseColor.BLACK);
        Chunk HeaderIAS = new Chunk(JDSConstants.IAS_LETTERHEAD);
        HeaderIAS.setFont(_IASFont);

        Chunk HeaderIASAddress = new Chunk(JDSConstants.IAS_LETTERHEAD_ADDRESS);
        Chunk HeaderIASTel = new Chunk(JDSConstants.IAS_LETTERHEAD_TELEPHONE);
        Chunk HeaderEmail_Web = new Chunk(JDSConstants.IAS_LETTERHEAD_EMAIL + " " + JDSConstants.IAS_LETTERHEAD_WEB);
        Chunk LetterDate = new Chunk("Date: " + util.getDateString());
        paragraphDate.add(LetterDate);

        paragraph.add(HeaderIAS);
        paragraph.add(Chunk.NEWLINE);
        paragraph.add(HeaderIASAddress);
        paragraph.add(Chunk.NEWLINE);
        paragraph.add(HeaderIASTel);
        paragraph.add(Chunk.NEWLINE);
        paragraph.add(HeaderEmail_Web);

        paragraphDate.setSpacingBefore(INNER_PARAGRAPH_SPACE);
        paragraph.add(paragraphDate);

        return paragraph;
    }

    public Paragraph getSalutation() {
        Paragraph paragraph = new Paragraph();
        paragraph.setSpacingBefore(40);
        paragraph.setIndentationLeft(LEFT_INDENTATION_LESS);
        paragraph.setAlignment(Element.ALIGN_LEFT);
        paragraph.add(new Chunk(JDSConstants.IAS_LETTERHEAD_SALUTATION));
        return paragraph;

    }

    public Paragraph getLetterFooter() {

        Paragraph paragraph = new Paragraph();
        paragraph.setAlignment(Element.ALIGN_RIGHT);
        paragraph.setSpacingBefore(70);

        paragraph.add(new Chunk(JDSConstants.IAS_LETTERFOOT_CLOSING));
        paragraph.add(Chunk.NEWLINE);

        paragraph.add(new Chunk(JDSConstants.IAS_LETTERFOOT_SIGNATURE));
        paragraph.add(Chunk.NEWLINE);

        return paragraph;

    }

    public Paragraph getPaymentFooter() {
        Paragraph paragraph = new Paragraph();
        paragraph.setAlignment(Element.ALIGN_CENTER);
        paragraph.setSpacingBefore(20);
        PdfPTable table;
        table = new PdfPTable(1);
        table.setWidthPercentage(80);

        PdfPCell cell1 = new PdfPCell(new Paragraph(new Chunk(JDSConstants.IAS_PAYMENTFOOT_HEADER, JDSPDF.JDS_FONT_NORMAL_SMALL_BOLD)));
        cell1.setHorizontalAlignment(Element.ALIGN_MIDDLE);
        cell1.setVerticalAlignment(Element.ALIGN_MIDDLE);
        table.addCell(cell1);

        String ArrString[] = new String[10];
        ArrString[0] = JDSConstants.IAS_PAYMENTFOOT_ACC;
        ArrString[1] = JDSConstants.IAS_PAYMENTFOOT_ACC_NAME;
        ArrString[2] = JDSConstants.IAS_PAYMENTFOOT_BANK;
        ArrString[3] = JDSConstants.IAS_PAYMENTFOOT_BANK_NAME;
        ArrString[4] = JDSConstants.IAS_PAYMENTFOOT_BRANCH;
        ArrString[5] = JDSConstants.IAS_PAYMENTFOOT_BRANCH_NAME;
        ArrString[6] = JDSConstants.IAS_PAYMENTFOOT_ACCNO;
        ArrString[7] = JDSConstants.IAS_PAYMENTFOOT_ACCNO_DTLS;
        ArrString[8] = JDSConstants.IAS_PAYMENTFOOT_IFSCOD;
        ArrString[9] = JDSConstants.IAS_PAYMENTFOOT_IFSCOD_DTLS;

        PdfPTable innerTable;
        innerTable = new PdfPTable(3);
        innerTable.setWidthPercentage(80);
        PdfPCell cellInnerTable1;
        PdfPCell cellInnerTable2;
        PdfPCell cellInnerTable3;

        for (int i = 0; i < ArrString.length; i++) {

            cellInnerTable1 = new PdfPCell(new Paragraph(new Chunk(ArrString[i], JDSPDF.JDS_FONT_NORMAL_SMALL)));
            cellInnerTable1.setHorizontalAlignment(Element.ALIGN_LEFT);
            cellInnerTable1.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cellInnerTable1.setBorder(Rectangle.NO_BORDER);
            innerTable.addCell(cellInnerTable1);
            cellInnerTable2 = new PdfPCell(new Paragraph(new Chunk("-", JDSPDF.JDS_FONT_NORMAL_SMALL)));
            cellInnerTable2.setHorizontalAlignment(Element.ALIGN_CENTER);
            cellInnerTable2.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cellInnerTable2.setBorder(Rectangle.NO_BORDER);
            innerTable.addCell(cellInnerTable2);
            cellInnerTable3 = new PdfPCell(new Paragraph(new Chunk(ArrString[i + 1], JDSPDF.JDS_FONT_NORMAL_SMALL)));
            cellInnerTable3.setHorizontalAlignment(Element.ALIGN_LEFT);
            cellInnerTable3.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cellInnerTable3.setBorder(Rectangle.NO_BORDER);
            innerTable.addCell(cellInnerTable3);
            i++;
        }
        table.addCell(innerTable);

        cell1 = new PdfPCell(new Paragraph(new Chunk(JDSConstants.IAS_PAYMENTFOOTER, JDSPDF.JDS_FONT_NORMAL_SMALL_BOLD)));
        cell1.setHorizontalAlignment(Element.ALIGN_MIDDLE);
        cell1.setVerticalAlignment(Element.ALIGN_MIDDLE);
        table.addCell(cell1);

        paragraph.add(table);

        return paragraph;

    }
}
