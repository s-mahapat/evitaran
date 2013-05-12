/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.ColumnText;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfWriter;

/**
 *
 * @author smahapat
 */
public class PDFEventHandler extends PdfPageEventHelper {

    /**
     * Alternating phrase for the header.
     */
    //Phrase[] header = new Phrase[2];
    /**
     * Current page number (will be reset for every chapter).
     */
    int pagenumber;

    /**
     * Initialize one of the headers, based on the chapter title; reset the page
     * number.
     *
     * @see com.itextpdf.text.pdf.PdfPageEventHelper#onChapter(
     * com.itextpdf.text.pdf.PdfWriter, com.itextpdf.text.Document, float,
     * com.itextpdf.text.Paragraph)
     */
    @Override
    public void onChapter(PdfWriter writer, Document document,
            float paragraphPosition, Paragraph title) {
        //header[1] = new Phrase(title.getContent());
        pagenumber = 1;
    }

    /**
     * Increase the page number.
     *
     * @see com.itextpdf.text.pdf.PdfPageEventHelper#onStartPage(
     * com.itextpdf.text.pdf.PdfWriter, com.itextpdf.text.Document)
     */
    @Override
    public void onStartPage(PdfWriter writer, Document document) {
        pagenumber++;
    }

    @Override
    public void onEndPage(PdfWriter writer, Document document) {

        PdfContentByte cb = writer.getDirectContent();
        cb.setLineWidth(1.0f); // Make a bit thicker than 1.0 default
        cb.setGrayStroke(0.75f); // 1 = black, 0 = white
        float x = JDSPDF.JDS_PDF_LEFT_MARGIN;
        float y = JDSPDF.JDS_PDF_BOTTOM_MARGIN + 10;
        float page_width = writer.getPageSize().getWidth();
        float length = page_width - JDSPDF.JDS_PDF_RIGHT_MARGIN;
        cb.moveTo(x, y);
        cb.lineTo(length, y);
        // draw the horizontal line here, x= page margin, y=bottom margin + 10
        cb.stroke();

        //ColumnText ct = new ColumnText(writer.getDirectContent());
        ColumnText.showTextAligned(cb, Element.ALIGN_CENTER,
                new Phrase("This page is printed from e-Vitaran", JDSPDF.JDS_FONT_AUTOGEN_FOOTER),
                writer.getPageSize().getWidth() / 2,
                JDSPDF.JDS_PDF_BOTTOM_MARGIN + 1f,
                0);

        /*Rectangle rect = writer.getBoxSize("art");
         switch (writer.getPageNumber() % 2) {
         case 0:
         ColumnText.showTextAligned(writer.getDirectContent(),
         Element.ALIGN_RIGHT, header[0],
         rect.getRight(), rect.getTop(), 0);
         break;
         case 1:
         ColumnText.showTextAligned(writer.getDirectContent(),
         Element.ALIGN_LEFT, header[1],
         rect.getLeft(), rect.getTop(), 0);
         break;
         }
         ColumnText.showTextAligned(writer.getDirectContent(),
         Element.ALIGN_CENTER, new Phrase(String.format("page %d", pagenumber)),
         (rect.getLeft() + rect.getRight()) / 2, rect.getBottom() - 18, 0);
         */

    }
}
