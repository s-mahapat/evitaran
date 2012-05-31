/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.util.Properties;
import javax.servlet.ServletContext;

/**
 *
 * @author Newton
 */
public class ChequeReturnPDF extends JDSPDF{
    
    private InputStream pdfTemplatesFile = null;
    
    public ChequeReturnPDF(){
        super();
        ServletContext context = ServletContextInfo.getServletContext();
        pdfTemplatesFile = context.getResourceAsStream("/WEB-INF/classes/pdf_templates.properties");
    }
    
    public ByteArrayOutputStream getPDF( String SubscriberNumber, String InwardNumber, 
                                    int ChequeNumber, String ChequeDate,
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
                                                int ChequeNumber, String ChequeDate,
                                                float Amount, String Reason) throws IOException{
        Paragraph paragraph = new Paragraph();
        Paragraph paragraph2 = new Paragraph();        
        Paragraph paragraph3 = new Paragraph();
        
        //Font _IASFont = new Font(Font.FontFamily.HELVETICA, 11, Font.NORMAL, BaseColor.BLACK);
        paragraph.setSpacingBefore(JDSPDF.OUTER_PARAGRAPH_SPACE);
        paragraph.setIndentationLeft(25);
        //paragraph.setFont(_IASFont);
        paragraph.setAlignment(Element.ALIGN_LEFT);
        
        paragraph2.setIndentationLeft(50);
        //paragraph2.setFont(_IASFont);
        paragraph2.setSpacingBefore(JDSPDF.INNER_PARAGRAPH_SPACE);
        
        paragraph3.setIndentationLeft(50);
        //paragraph2.setFont(_IASFont);
        paragraph3.setSpacingBefore(JDSPDF.INNER_PARAGRAPH_SPACE);
        
        Properties props = new Properties();
        props.load(pdfTemplatesFile);
        String template = props.getProperty("cheque_return");
        String _body = String.format(template, String.valueOf(ChequeNumber),
                                     ChequeDate, String.valueOf(Amount));
                
//        String _body =  "The Cheque/DD No: " + String.valueOf(ChequeNumber) + " dated " 
//                        + ChequeDate 
//                        + " for INR " 
//                        + String.valueOf(Amount) 
//                        + " is returned herewith for want of the following information";
        Chunk _bodychunk = new Chunk(_body);
        paragraph2.add(_bodychunk);
                
        paragraph2.add(Chunk.NEWLINE);
        paragraph2.add(Chunk.NEWLINE);
        List orderedList = new List(List.UNORDERED);
        //orderedList.setListSymbol("*");
        orderedList.add(new ListItem(Reason));
        paragraph2.add(orderedList);
        paragraph.add(paragraph2);                
        
        String _subscriber = String.format("%-13s : %-11s", "Subscriber No", SubscriberNumber);
        paragraph3.add(new Chunk(_subscriber));
        paragraph3.add(Chunk.NEWLINE);
        
        String _inward = String.format("%-15s : %-11s", "Inward No", InwardNumber);
        paragraph3.add(new Chunk(_inward));
        paragraph3.add(Chunk.NEWLINE);
        paragraph.add(paragraph3);
        
        
        return paragraph;
         
    }
}
