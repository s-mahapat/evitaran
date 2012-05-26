/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import com.itextpdf.text.*;
import java.io.IOException;
/**
 *
 * @author Newton
 */
public class JDSPDF {
    
    public static int OUTER_PARAGRAPH_SPACE  = 10;
    public static int INNER_PARAGRAPH_SPACE  = 30;
    public Document getPDFDocument(){
        com.itextpdf.text.Document document = new com.itextpdf.text.Document(PageSize.A4);        
        document.addAuthor("Indian Academy Of Sciences");
        document.addCreator("Indian Academy Of Sciences");
        document.addSubject("Indian Academy Of Sciences");
        document.addCreationDate();
        document.addTitle("Indian Academy Of Sciences");
        return document;
    }
    
    public Paragraph getLetterHead() throws BadElementException, java.net.MalformedURLException, IOException{
        Paragraph paragraph = new Paragraph();
        paragraph.setAlignment(Element.ALIGN_CENTER);
        
        //Image _logo = Image.getInstance("logo_main.png");
        //paragraph.add(_logo);
        
        Font _IASFont = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD, BaseColor.BLACK);        
        Chunk HeaderIAS = new Chunk(JDSConstants.IAS_LETTERHEAD);
        HeaderIAS.setFont(_IASFont);
        
        Chunk HeaderIASAddress = new Chunk(JDSConstants.IAS_LETTERHEAD_ADDRESS);
        Chunk HeaderIASTel = new Chunk(JDSConstants.IAS_LETTERHEAD_TELEPHONE);
        
        paragraph.add(HeaderIAS);
        paragraph.add(Chunk.NEWLINE);
        paragraph.add(HeaderIASAddress);
        paragraph.add(Chunk.NEWLINE);
        paragraph.add(HeaderIASTel);
        
        return paragraph;
    }
    
    public Paragraph getSalutation(){
        Paragraph paragraph = new Paragraph();
        paragraph.setSpacingBefore(40);
        paragraph.setIndentationLeft(25);
        paragraph.setAlignment(Element.ALIGN_LEFT);
        paragraph.add(new Chunk(JDSConstants.IAS_LETTERHEAD_SALUTATION));
        return paragraph;
        
    }
    
    public Paragraph getLetterFooter(){
        
        Paragraph paragraph = new Paragraph();
        paragraph.setAlignment(Element.ALIGN_RIGHT);
        paragraph.setSpacingBefore(60);
        
        paragraph.add(new Chunk(JDSConstants.IAS_LETTERFOOT_CLOSING));
        paragraph.add(Chunk.NEWLINE);
        
        paragraph.add(new Chunk(JDSConstants.IAS_LETTERFOOT_SIGNATURE));
        paragraph.add(Chunk.NEWLINE);
        
        return paragraph;
        
    }
    
}
