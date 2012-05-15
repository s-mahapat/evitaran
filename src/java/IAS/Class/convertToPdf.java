/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.Paragraph;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.apache.log4j.Logger;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Font.FontFamily;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Utilities;
import com.itextpdf.text.pdf.ColumnText;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfWriter;
import com.mysql.jdbc.ResultSetMetaData;
import java.io.OutputStream;


/**
 *
 * @author I038668
 */
public class convertToPdf {

    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Class.convertToPdf");

    public static void addLabelContent(ResultSet rs, OutputStream os) throws DocumentException, IOException, SQLException
    {
        /** Definition of two columns */
        // llx (lower-left x), lly (lower-left y), urx (upper-right x), ury (upper-right y), leading, alignment
        // (6, 5, 15, 9), (6, 20.4, 15, 24.4)
        // 2.54cm = 72 points
        float[][] COLUMNS = {
            {170.1f, 141.7f, 425.2f, 255.12f} , {170.1f, 578.27f, 425.2f, 691.65f}
        };

        // step 1
        Document document = new Document(PageSize.A4);
        document.addAuthor("JDS");
        document.addCreator("JDS");
        document.addTitle("Mailing List");

        // step 2
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PdfWriter writer = PdfWriter.getInstance(document, baos);

        // step 3
        document.open();

        ColumnText ct = new ColumnText(writer.getDirectContent());
        int numberOfColumns = 2, count=0;

        while(true)
        {
            // Get the content
            Paragraph info = getContent(rs);
            if(info == null)
            {
                // step 5
                document.close();

                baos.writeTo(os);
                return;
            }

            int col = (count)%numberOfColumns;

            ct.setSimpleColumn(
                COLUMNS[col][0], COLUMNS[col][1],
                COLUMNS[col][2], COLUMNS[col][3]);

            int status = ColumnText.START_COLUMN;

            // Add the content to the column
            ct.addElement(info);
            int go = ct.go();

            if(col == 1)
                document.newPage();

            count++;
        }
    }

    public static void addStickerContent(ResultSet rs, OutputStream os) throws DocumentException, IOException, SQLException
    {
        // step 1
        Document document = new Document(PageSize.A4);
        document.addAuthor("JDS");
        document.addCreator("JDS");
        document.addTitle("Mailing List");

        // step 2
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PdfWriter writer = PdfWriter.getInstance(document, baos);
        //writer.setInitialLeading(8.0f);

        // step 3
        document.open();

        int stickerColumns  = 2;
        int stickerRows     = 8;

        float leftMargin    = 4.9f;     //4.9mm
        float stickerWidth  = 99.1f;    //9.91cms
        float rightMargin   = 4.9f;     //4.9mm
        float gapAcrossStickers = 2.0f; //2mm
        //Total Width = 4.9 + 99.1*2 + 4.9 + 2.0 = 206

        float topMargin     = 12.9f;    //12.9cms
        float stickerHeight = 33.9f;    //3.39cms
        float bottomMargin  = 12.9f;    //12.9mm
        // Total Height = 12.9 + 33.9*8 + 12.9 = 297

        float header        = 1.0f;     // This is the space to be left on top of sticker

        float pageHeight    = 297.0f;   //297mm
        float pageWidth     = 210.0f;   //210mm

        ColumnText ct = new ColumnText(writer.getDirectContent());

        while(true)
        {
            for (int i=1; i<=stickerRows; i++)
            {
                for (int r=1; r<=stickerColumns; r++)
                {
                    // Get the content
                    Paragraph info = getContent(rs);
                    if(info == null)
                    {
                        // step 5
                        document.close();

                        baos.writeTo(os);
                        return;
                    }

                    float x = leftMargin + ((stickerWidth + gapAcrossStickers)*(r-1));
                    float y = pageHeight - (topMargin+(stickerHeight*i));

                    float llx = x;
                    float lly = y + stickerHeight;
                    float urx = llx + stickerWidth;
                    float ury = lly - stickerHeight;
                    x = Utilities.millimetersToPoints(x);
                    y = Utilities.millimetersToPoints(y);

                    //logger.debug("Row: " + i + " Col: " + r + " " + llx + " " + lly + " " + " " + urx + " " + ury);

                    llx = Utilities.millimetersToPoints(llx);
                    lly = Utilities.millimetersToPoints(lly) - Utilities.millimetersToPoints(header);
                    urx = Utilities.millimetersToPoints(urx);
                    ury = Utilities.millimetersToPoints(ury) - Utilities.millimetersToPoints(header);


                    // Draw the boundary
                    PdfContentByte canvas = writer.getDirectContent();
                    canvas.setRGBColorFill(0xFF, 0x45, 0x00);
                    canvas.setColorFill(BaseColor.WHITE);
                    canvas.rectangle(x, y, Utilities.millimetersToPoints(stickerWidth), Utilities.millimetersToPoints(stickerHeight));
                    canvas.fillStroke();

                    // Create a column
                    ct.setSimpleColumn(llx, lly, urx, ury);
                    int status = ColumnText.START_COLUMN;

                    // Add the content to the column
                    ct.addElement(info);

                    int go = ct.go();
                }
            }
            document.newPage();
        }
    }

    public static Paragraph getContent(ResultSet rs) throws SQLException
    {
        /*
        String subscriberNumber = "36207";
        String journalCode      = "RES";
        String subtypecode      = "II";
        String startDate        = "Jan 2010";
        String endDate          = "Dec 2010";
        String subscriberName   = "(Ref: ID 123 IMS Engg College)";
        String department       = "South Asia Distributors & Publisher";
        String institution      = "92-C (Part), 1st Floor, SPAN House";
        String address          =  "Gurudwara Road, Madangir";
        String city             = "New Delhi";
        String pincode          = "110 062";
        String state            = "New Delhi";
        String country          = "India";
         *
         */
        String subscriberNumber = null, journalCode = null, subtypecode = null, startDate = null, endDate = null;
        String subscriberName   = null, department = null, institution = null, address = null;
        String city             = null, pincode = null, state = null, country = null;
        String startYear=null, startMonth=null, endYear=null, endMonth=null;

        Paragraph info = null;

        if(rs.next())
        {
            ResultSetMetaData rsmd = (ResultSetMetaData) rs.getMetaData();
            int numberOfColumns = rsmd.getColumnCount();
            for (int i = 1; i <= numberOfColumns; i++)
            {
                String columnName = rsmd.getColumnName(i);
                if(columnName.equals("subscriberNumber"))
                    subscriberNumber = rs.getString(i);
                if(columnName.equals("journalCode"))
                    journalCode = rs.getString(i);
                if(columnName.equals("subtypecode"))
                    subtypecode = rs.getString(i);
                if(columnName.equals("startYear"))
                    startYear = rs.getString(i);
                if(columnName.equals("startMonth"))
                    startMonth = rs.getString(i);
                startDate = startMonth + " " + startYear;

                if(columnName.equals("endYear"))
                    endYear = rs.getString(i);
                if(columnName.equals("endMonth"))
                    endMonth = rs.getString(i);
                endDate = endMonth + " " + endYear;

                if(columnName.equals("subscriberName"))
                    subscriberName = rs.getString(i);
                if(columnName.equals("department"))
                    department = rs.getString(i);
                if(columnName.equalsIgnoreCase("institution"))
                    institution = rs.getString(i);
                if(columnName.equalsIgnoreCase("address"))
                    address = rs.getString(i);
                if(columnName.equalsIgnoreCase("city"))
                    city = rs.getString(i);
                if(columnName.equalsIgnoreCase("pincode"))
                    pincode = rs.getString(i);
                if(columnName.equalsIgnoreCase("state"))
                    state = rs.getString(i);
                if(columnName.equalsIgnoreCase("country"))
                    country = rs.getString(i);
            }


            info = new Paragraph();
            info.setLeading(10.0f);
            info.setAlignment(Element.ALIGN_CENTER);
            Font font = new Font(FontFamily.COURIER, 10, Font.BOLD, BaseColor.BLACK);
            String firstLine = subscriberNumber +
                    " " + journalCode +
                    " " + subtypecode +
                    " " + startDate +
                    " " + "to" +
                    " " + endDate;
            info.add(new Chunk(firstLine, font));
            info.add(Chunk.NEWLINE);
            info.add(new Chunk(subscriberName, font));
            info.add(Chunk.NEWLINE);
            info.add(new Chunk(department, font));
            info.add(Chunk.NEWLINE);
            info.add(new Chunk(institution, font));
            info.add(Chunk.NEWLINE);
            info.add(new Chunk(address, font));
            info.add(Chunk.NEWLINE);
            String lastLine = city +
                    " " + pincode +
                    " " + state +
                    " " + country;
            info.add(new Chunk(lastLine, font));
        }
        return info;
    }

}


