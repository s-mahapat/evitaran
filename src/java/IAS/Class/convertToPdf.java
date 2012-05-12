/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;
import com.itextpdf.text.Document;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.DocumentException;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.Date;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;


/**
 *
 * @author I038668
 */
public class convertToPdf {
    
    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Class.msgsend");
    
    public ByteArrayOutputStream getPdf(ResultSet rs, HttpServletResponse response) throws DocumentException, IOException
    {                
            response.setContentType("application/pdf");
            // step 1
            Document document = new Document();
            // step 2
            PdfWriter.getInstance(document, response.getOutputStream());
            // step 3
            document.open();
            // step 4
            document.add(new Paragraph("Hello World"));
            document.add(new Paragraph(new Date().toString()));
            // step 5
            document.close();

        // step 2
        ByteArrayOutputStream baos = new ByteArrayOutputStream();       
        return baos;
    }
    
}

    
