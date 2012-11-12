/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.util.Properties;

/**
 *
 * @author Newton
 */
public class ChequeReturnPDF extends JDSPDF{

    //private InputStream pdfTemplatesFile = null;

    public ChequeReturnPDF(){
        super();
    }

    public ByteArrayOutputStream getPDF( String SubscriberNumber, String InwardNumber,
                                    String ChequeNumber, String ChequeDate,
                                    float Amount, String Reason) throws DocumentException, MalformedURLException, IOException{

        com.itextpdf.text.Document document = this.getPDFDocument();

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        PdfWriter pdfWriter = PdfWriter.getInstance(document, outputStream);

        document.open();
        document.add(this.getLetterHead());
        document.add(this.getSalutation());
        document.add(this.getChequeReturnLetterBody(SubscriberNumber, InwardNumber,
                                                    ChequeNumber, ChequeDate,
                                                    Amount, Reason));
        document.add(this.getLetterFooter());
        document.close();
        return outputStream;

    }

    private Paragraph getChequeReturnLetterBody( String SubscriberNumber, String InwardNumber,
                                                String ChequeNumber, String ChequeDate,
                                                float Amount, String Reason) throws IOException{
        Paragraph paragraph = new Paragraph();
        Paragraph paragraph2 = new Paragraph();
        Paragraph paragraph3 = new Paragraph();

        //Font _IASFont = new Font(Font.FontFamily.HELVETICA, 11, Font.NORMAL, BaseColor.BLACK);
        paragraph.setSpacingBefore(JDSPDF.OUTER_PARAGRAPH_SPACE);
        paragraph.setIndentationLeft(JDSPDF.LEFT_INDENTATION_LESS);
        //paragraph.setFont(_IASFont);
        paragraph.setAlignment(Element.ALIGN_LEFT);

        paragraph2.setIndentationLeft(JDSPDF.LEFT_INDENTATION_LESS);
        //paragraph2.setFont(_IASFont);
        paragraph2.setSpacingBefore(JDSPDF.INNER_PARAGRAPH_SPACE);
        paragraph2.setAlignment(Element.ALIGN_LEFT);

        paragraph3.setIndentationLeft(JDSPDF.LEFT_INDENTATION_LESS);
        //paragraph2.setFont(_IASFont);
        paragraph3.setSpacingBefore(JDSPDF.INNER_PARAGRAPH_SPACE);
        paragraph3.setAlignment(Element.ALIGN_LEFT);

        Properties props = new Properties();
        props.load(this.pdfTemplatesFile);
        String template = props.getProperty("cheque_return");
        String _body = String.format(template, ChequeNumber,
                                     ChequeDate, String.valueOf(Amount));

        Chunk _bodychunk = new Chunk(_body, JDS_FONT_BODY);
        paragraph2.add(_bodychunk);

        paragraph2.add(Chunk.NEWLINE);
        //paragraph2.add(Chunk.NEWLINE);
        List orderedList = new List(List.UNORDERED);
        //orderedList.setListSymbol("*");
        orderedList.add(new ListItem(Reason, JDS_FONT_BODY));
        paragraph2.add(orderedList);
        paragraph.add(paragraph2);

        String _subscriber = String.format("%-13s : %-11s", "Subscriber No", SubscriberNumber);
        paragraph3.add(new Chunk(_subscriber, JDS_FONT_BODY));
        paragraph3.add(Chunk.NEWLINE);

        String _inward = String.format("%-15s : %-11s", "Inward No", InwardNumber);
        paragraph3.add(new Chunk(_inward, JDS_FONT_BODY));
        paragraph3.add(Chunk.NEWLINE);
        paragraph.add(paragraph3);


        return paragraph;

    }
}
