/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.ColumnText;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
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
    public static Font JDS_BOLD_FONT = new Font(Font.FontFamily.HELVETICA, 11, Font.BOLD, BaseColor.BLACK);
    public static Font JDS_FONT_NORMAL_SMALL = new Font(Font.FontFamily.HELVETICA, 10, Font.NORMAL, BaseColor.BLACK);
    public static Font JDS_FONT_BODY = new Font(Font.FontFamily.HELVETICA, 10, Font.NORMAL, BaseColor.BLACK);
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

    public void addPaymentFooter(Document document, PdfWriter pdfWriter) throws DocumentException{

        ColumnText ct = new ColumnText(pdfWriter.getDirectContent());
        float pageWidth = pdfWriter.getPageSize().getWidth();
        float pageHeight = pdfWriter.getPageSize().getHeight();

        float llx = (pageWidth - Utilities.millimetersToPoints(JDSConstants.width))/2;
        float lly = Utilities.millimetersToPoints(JDSConstants.heightFromBottomOfPage);
        float urx = llx + Utilities.millimetersToPoints(JDSConstants.width);
        float ury = lly + Utilities.millimetersToPoints(JDSConstants.height);

        PdfContentByte cb = pdfWriter.getDirectContent();
        cb.roundRectangle(llx - Utilities.millimetersToPoints(5), lly - Utilities.millimetersToPoints(3), Utilities.millimetersToPoints(JDSConstants.width + 5), Utilities.millimetersToPoints(JDSConstants.height + 5), 20f);
        cb.stroke();
        //cb.roundRectangle(llx - Utilities.millimetersToPoints(6), lly - Utilities.millimetersToPoints(4), Utilities.millimetersToPoints(JDSConstants.width + 7), Utilities.millimetersToPoints(JDSConstants.height + 7), 20f);
        //cb.stroke();

        // 1. Add the first line
        ct.setSimpleColumn(llx, lly, urx, ury);
        int status = ColumnText.START_COLUMN;

        /*
        Paragraph info = new Paragraph();
        info.add(new Chunk(JDSConstants.IAS_PAYMENTFOOT_HEADER, JDSPDF.JDS_FONT_NORMAL_SMALL));
        ct.addElement(info);
        */

        PdfPTable table0 = new PdfPTable(1);
        table0.setWidthPercentage(100f);
        table0.setHeaderRows(0);
        float[] widths0 = {100f};
        table0.setWidths(widths0);
        table0.getDefaultCell().setBorder(0);
        Phrase header = new Phrase();
        header.setFont(JDSPDF.JDS_FONT_NORMAL_SMALL_BOLD);
        header.add(JDSConstants.IAS_PAYMENTFOOT_HEADER);
        table0.addCell(header);

        PdfPTable table = new PdfPTable(3);
        table.setWidthPercentage(100f);
        table.setHeaderRows(0);
        float[] widths = {40f, 10f, 40f};
        table.setWidths(widths);
        table.getDefaultCell().setBorder(0);

        // The center "-" is common to all
        Phrase common = new Phrase();
        common.setFont(JDSPDF.JDS_FONT_NORMAL_SMALL);
        common.add("-");

        // 2. Add line2 - details on account holder
        Phrase phrase1 = new Phrase();
        phrase1.setFont(JDSPDF.JDS_FONT_NORMAL_SMALL);
        phrase1.add(JDSConstants.IAS_PAYMENTFOOT_ACC);

        Phrase phrase2 = new Phrase();
        phrase2.setFont(JDSPDF.JDS_FONT_NORMAL_SMALL);
        phrase2.add(JDSConstants.IAS_PAYMENTFOOT_ACC_NAME);

        // 3. Add line2 - details of bank
        Phrase phrase3 = new Phrase();
        phrase3.setFont(JDSPDF.JDS_FONT_NORMAL_SMALL);
        phrase3.add(JDSConstants.IAS_PAYMENTFOOT_BANK);

        Phrase phrase4 = new Phrase();
        phrase4.setFont(JDSPDF.JDS_FONT_NORMAL_SMALL);
        phrase4.add(JDSConstants.IAS_PAYMENTFOOT_BANK_NAME);

        // 4. Add line2 - details of branch
        Phrase phrase5 = new Phrase();
        phrase5.setFont(JDSPDF.JDS_FONT_NORMAL_SMALL);
        phrase5.add(JDSConstants.IAS_PAYMENTFOOT_BRANCH);

        Phrase phrase6 = new Phrase();
        phrase6.setFont(JDSPDF.JDS_FONT_NORMAL_SMALL);
        phrase6.add(JDSConstants.IAS_PAYMENTFOOT_BRANCH_NAME);

        // 5. Add line2 - details of a/c no
        Phrase phrase7 = new Phrase();
        phrase7.setFont(JDSPDF.JDS_FONT_NORMAL_SMALL);
        phrase7.add(JDSConstants.IAS_PAYMENTFOOT_ACCNO);

        Phrase phrase8 = new Phrase();
        phrase8.setFont(JDSPDF.JDS_FONT_NORMAL_SMALL);
        phrase8.add(JDSConstants.IAS_PAYMENTFOOT_ACCNO_DTLS);

        // 6. Add line2 - details of IFS code
        Phrase phrase9 = new Phrase();
        phrase9.setFont(JDSPDF.JDS_FONT_NORMAL_SMALL);
        phrase9.add(JDSConstants.IAS_PAYMENTFOOT_IFSCOD);

        Phrase phrase10 = new Phrase();
        phrase10.setFont(JDSPDF.JDS_FONT_NORMAL_SMALL);
        phrase10.add(JDSConstants.IAS_PAYMENTFOOT_IFSCOD_DTLS);

        table.addCell(phrase1);
        table.addCell(common);
        table.addCell(phrase2);
        table.addCell(phrase3);
        table.addCell(common);
        table.addCell(phrase4);
        table.addCell(phrase5);
        table.addCell(common);
        table.addCell(phrase6);
        table.addCell(phrase7);
        table.addCell(common);
        table.addCell(phrase8);
        table.addCell(phrase9);
        table.addCell(common);
        table.addCell(phrase10);

        //document.add(table);
        ct.addElement(table0);
        ct.addElement(table);

        /*
        Phrase footerS = new Phrase();
        footerS.add(Chunk.NEWLINE);
        ct.addElement(footerS);
        */

        /*
        Paragraph paymentFooter = new Paragraph();
        paymentFooter.add(new Chunk(JDSConstants.IAS_PAYMENTFOOTER, JDSPDF.JDS_FONT_NORMAL_SMALL));
        ct.addElement(paymentFooter);
        */
        PdfPTable tableLast = new PdfPTable(1);
        tableLast.setWidthPercentage(100f);
        tableLast.setHeaderRows(0);
        float[] widthsLast = {100f};
        tableLast.setWidths(widthsLast);
        tableLast.getDefaultCell().setBorder(0);
        Phrase footer = new Phrase();
        footer.setFont(JDSPDF.JDS_FONT_NORMAL_SMALL_BOLD);
        footer.add(JDSConstants.IAS_PAYMENTFOOTER);
        tableLast.addCell(footer);

        ct.addElement(tableLast);

        int go = ct.go();
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
        Chunk HeaderIAS = new Chunk(JDSConstants.IAS_LETTERHEAD);
        HeaderIAS.setFont(JDSPDF.JDS_BOLD_FONT);

        Chunk HeaderIASAddress = new Chunk(JDSConstants.IAS_LETTERHEAD_ADDRESS, JDSPDF.JDS_BOLD_FONT);
        Chunk HeaderIASTel = new Chunk(JDSConstants.IAS_LETTERHEAD_TELEPHONE, JDSPDF.JDS_BOLD_FONT);
        Chunk HeaderEmail_Web = new Chunk(JDSConstants.IAS_LETTERHEAD_EMAIL + " " + JDSConstants.IAS_LETTERHEAD_WEB, JDSPDF.JDS_BOLD_FONT);
        Chunk LetterDate = new Chunk("Date: " + util.getDateString(), JDSPDF.JDS_FONT_BODY);
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
        paragraph.add(new Chunk(JDSConstants.IAS_LETTERHEAD_SALUTATION, JDSPDF.JDS_FONT_BODY));
        return paragraph;

    }

    public Paragraph getLetterFooter() {

        Paragraph paragraph = new Paragraph();
        paragraph.setAlignment(Element.ALIGN_RIGHT);
        paragraph.setSpacingBefore(40);

        paragraph.add(new Chunk(JDSConstants.IAS_LETTERFOOT_CLOSING, JDSPDF.JDS_FONT_BODY));
        paragraph.add(Chunk.NEWLINE);

        paragraph.add(new Chunk(JDSConstants.IAS_LETTERFOOT_SIGNATURE, JDSPDF.JDS_FONT_BODY));
        paragraph.add(Chunk.NEWLINE);

        return paragraph;

    }

}
