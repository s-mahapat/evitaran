package IAS.Class;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.Paragraph;
import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.apache.log4j.Logger;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.Utilities;
import com.itextpdf.text.pdf.AcroFields.FieldPosition;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.ColumnText;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.pdf.draw.LineSeparator;
import com.mysql.jdbc.ResultSetMetaData;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.StringReader;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.Properties;
import javax.servlet.ServletContext;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;


public class convertToPdf extends JDSPDF {

    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Class.convertToPdf");

    // Default values
    float leading       = 10.0f;
    int textAlignment   = 0;
    Font.FontFamily fontType = Font.getFamily("HELVETICA");
    int fontSize        = 10;
    int fontStyle       = Font.getStyleValue("BOLD");

public convertToPdf(){
        super();
    }

    /*
     * NOTE: Usually we calculate the width of the columns based on the average.
     * But in this case we calculate the max of the column widths.
     * Currently this is used only for print order. if this is used for any other
     * report then the output will have to be customised.
     */
    public void convertXMLResponseToPDF(OutputStream os, String xml, String query) throws ParserConfigurationException, SAXException, IOException, DocumentException
    {
        Document document = this.getPDFDocumentLandscape();
        //Document document = this.getPDFDocument();

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        PdfWriter pdfWriter = PdfWriter.getInstance(document, outputStream);

        document.open();

        // 1. Add the letter head
        document.add(this.getLetterHead());

        // 2. Leave 2 lines in between
        document.add(Chunk.NEWLINE);
        document.add(Chunk.NEWLINE);

        // 3. Add the query name
        Paragraph info = new Paragraph();
        info.setLeading(leading);
        info.setAlignment(textAlignment);

        Font font = new Font(fontType, fontSize, fontStyle, BaseColor.BLACK);
        if(query != null && !query.isEmpty())
        {
            info.add(Chunk.NEWLINE);
            info.add("Query: " + query);
        }
        document.add(info);

        // 4. Add the table
        document.add(Chunk.NEWLINE);
        //ResultSetMetaData rsmd = (ResultSetMetaData) rs.getMetaData();
        //int colCount = rsmd.getColumnCount();
        int colCount = util.getColCount(xml);
        int rowCount = 0;

        PdfPTable table = new PdfPTable(colCount);
        table.setWidthPercentage(90);

        Font f = new Font(fontType, fontSize);
        BaseFont bf = f.getCalculatedBaseFont(false);

        float[] columnWidth = new float[colCount];

        // Write the Table header first
        //for (int i = 1; i <= colCount; i++)
        for (int i = 0; i < colCount; i++)
        {
            String columnName = util.getColNames(xml, 0, i);
            table.addCell(columnName);
            //columnWidth[i-1] = columnWidth[i-1] + bf.getWidthPoint(columnName, fontSize);
            // We do not include the header row into the average calculation
            //columnWidth[i] = columnWidth[i] + bf.getWidthPoint(columnName, fontSize);
        }
        //rowCount++;

        // Write the table rows
        //while (rs.next()){
        for (int j = 0; j < util.getRowCount(xml); j++) {
            //for (int i = 1; i <= colCount; i++) {
            for (int i = 0; i < colCount; i++) {
                // check if the value is null, then initialize it to a blank string
                //Object value = rs.getObject(i) != null ? rs.getObject(i) : "";
                //table.addCell(value.toString());
                String colValue = util.getColValue(xml, j, i);
                table.addCell(colValue);

                //columnWidth[i-1] = columnWidth[i-1] + bf.getWidthPoint(value.toString(), fontSize);
                //columnWidth[i] = columnWidth[i] + bf.getWidthPoint(colValue, fontSize);
                // We make an exception here, to calculate the width based on the max row size
                if(columnWidth[i] < bf.getWidthPoint(colValue, fontSize)) {
                    columnWidth[i] = bf.getWidthPoint(colValue, fontSize);
                }
            }
            rowCount++;
        }

        // Calculate the average width of the table and set the table width
        /*
        for (int i = 1; i <= colCount; i++) {
            columnWidth[i-1] = columnWidth[i-1] / rowCount;
            // Usually the first column is the id. Because we take the average width, the column text wraps to the next line
            // To prevent that we double the size of the first column.
            //if(i == 1) {
            //    columnWidth[i-1] = columnWidth[i-1] * 2;
            //}
            logger.debug("Column: " + i + "-" + columnWidth[i-1]);
        }
        */
        table.setTotalWidth(columnWidth);

        document.add(table);

        document.close();
        outputStream.writeTo(os);

    }

    public void convertResultSetToPdf(OutputStream os, ResultSet rs, String query) throws DocumentException, FileNotFoundException, IOException, SQLException
    {
        Document document = this.getPDFDocumentLandscape();
        //Document document = this.getPDFDocument();

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        PdfWriter pdfWriter = PdfWriter.getInstance(document, outputStream);

        document.open();

        // 1. Add the letter head
        document.add(this.getLetterHead());

        // 2. Leave 2 lines in between
        document.add(Chunk.NEWLINE);
        document.add(Chunk.NEWLINE);

        // 3. Add the query name
        Paragraph info = new Paragraph();
        info.setLeading(leading);
        info.setAlignment(textAlignment);

        Font font = new Font(fontType, fontSize, fontStyle, BaseColor.BLACK);
        if(query != null && !query.isEmpty())
        {
            info.add(Chunk.NEWLINE);
            info.add("Query: " + query);
        }
        document.add(info);

        // 4. Add the table
        document.add(Chunk.NEWLINE);
        ResultSetMetaData rsmd = (ResultSetMetaData) rs.getMetaData();
        int colCount = rsmd.getColumnCount();
        int rowCount = 0;

        PdfPTable table = new PdfPTable(colCount);
        table.setWidthPercentage(90);

        Font f = new Font(fontType, fontSize);
        BaseFont bf = f.getCalculatedBaseFont(false);

        float[] columnWidth = new float[colCount];

        // Write the Table header first
        for (int i = 1; i <= colCount; i++)
        {
            String columnName = rsmd.getColumnName(i);
            table.addCell(columnName);
            columnWidth[i-1] = columnWidth[i-1] + bf.getWidthPoint(columnName, fontSize);
        }
        rowCount++;

        // Write the table rows
        while (rs.next()){
            for (int i = 1; i <= colCount; i++) {
                // check if the value is null, then initialize it to a blank string
                Object value = rs.getObject(i) != null ? rs.getObject(i) : "";
                table.addCell(value.toString());

                columnWidth[i-1] = columnWidth[i-1] + bf.getWidthPoint(value.toString(), fontSize);
            }
            rowCount++;
        }

        // Calculate the average width of the table and set the table width
        for (int i = 1; i <= colCount; i++) {
            columnWidth[i-1] = columnWidth[i-1] / rowCount;
            // Usually the first column is the id. Because we take the average width, the column text wraps to the next line
            // To prevent that we double the size of the first column.
            if(i == 1)
                columnWidth[i-1] = columnWidth[i-1] * 2;
            logger.debug("Column: " + i + "-" + columnWidth[i-1]);
        }
        table.setTotalWidth(columnWidth);

        document.add(table);

        document.close();
        outputStream.writeTo(os);
    }

    public void printMIresponse(OutputStream os, String msg) throws DocumentException, FileNotFoundException, IOException
    {
        Document document = this.getPDFDocument();

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        PdfWriter pdfWriter = PdfWriter.getInstance(document, outputStream);

        //pdfWriter.setPageEvent(new onEndPage());

        document.open();
        Properties properties = getMissingIssueProperties();

        // 1. Add the letter head
        document.add(this.getLetterHead());

        // 2. Leave 2 lines in between
        document.add(Chunk.NEWLINE);
        document.add(Chunk.NEWLINE);

        // Setup the font and leading
        PdfContentByte cb = pdfWriter.getDirectContent();
        setupFontAndLeading(cb);

        boolean ensureNewLine = false;
        float curY = pdfWriter.getVerticalPosition(ensureNewLine);
        float curX = document.leftMargin();

        cb.beginText();
        cb.moveText(curX, curY);
        //cb.newlineShowText(msg);
        cb.endText();

        Paragraph paragraph = new Paragraph();
        paragraph.setAlignment(textAlignment);
        paragraph.setFont(new Font(fontType, fontSize));
        paragraph.add(msg);
        paragraph.add(Chunk.NEWLINE);

        document.add(paragraph);

        document.close();
        outputStream.writeTo(os);
    }

    public ByteArrayOutputStream reminderType2() throws DocumentException, IOException {

        Document document = this.getPDFDocument();

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        PdfWriter pdfWriter = PdfWriter.getInstance(document, outputStream);
        //pdfWriter.setPageEvent(new onEndPage());

        document.open();
        Properties properties = getRemindersProperties();

        // 1. Add the letter head
        document.add(this.getLetterHead());

        // 2. Leave 2 lines in between
        document.add(Chunk.NEWLINE);
        document.add(Chunk.NEWLINE);

        // Setup the font and leading
        PdfContentByte cb = pdfWriter.getDirectContent();
        setupFontAndLeading(cb);

        // Add the address, date, subNo
        Rectangle rect = pdfWriter.getPageSize();
        boolean ensureNewLine = false;
        float curY = pdfWriter.getVerticalPosition(ensureNewLine);
        float curX = document.leftMargin();
        float deltaX = (float) (rect.getWidth()/2);
        addInitialBody(cb, curX, curY, deltaX);

        // Get the location where the next content should go
        // When you have added multiple lines in the previous text addition use getYTLM and getXTLM to get the next location
        curY = cb.getYTLM();
        curX = cb.getXTLM();
        cb.beginText();
        cb.moveText(curX, curY);
        cb.newlineText();

        // 8. Add the subject
        addSubjectReminderType2(cb);
        cb.endText();

        // 9. Add the list of journals and the period
        curY = cb.getYTLM();
        curX = cb.getXTLM();
        cb.beginText();
        cb.moveText(curX, curY);
        addJournals(cb);
        cb.endText();

        // 10. Add the content
        //document.newPage();
        curY = cb.getYTLM();
        curX = cb.getXTLM();
        cb.beginText();
        cb.moveText(curX, curY);
        addBodyReminderType2(cb, (float)rect.getWidth() - 2*curX);
        //cb.endText();

        // 11. Close the document
        document.close();
        return outputStream;
    }

    public ByteArrayOutputStream reminderType1() throws DocumentException, IOException{

        com.itextpdf.text.Document document = this.getPDFDocument();

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        PdfWriter pdfWriter = PdfWriter.getInstance(document, outputStream);
        //pdfWriter.setPageEvent(new onEndPage());

        document.open();
        Properties properties = getRemindersProperties();

        // 1. Add the letter head
        document.add(this.getLetterHead());

        // 2. Leave 2 lines in between
        document.add(Chunk.NEWLINE);
        document.add(Chunk.NEWLINE);

        // Setup the font and leading
        PdfContentByte cb = pdfWriter.getDirectContent();
        setupFontAndLeading(cb);

        // Add the address, date, subNo
        Rectangle rect = pdfWriter.getPageSize();
        boolean ensureNewLine = false;
        float curY = pdfWriter.getVerticalPosition(ensureNewLine);
        float curX = document.leftMargin();
        float deltaX = (float) (rect.getWidth()/2);
        addInitialBody(cb, curX, curY, deltaX);

        // Get the location where the next content should go
        // When you have added multiple lines in the previous text addition use getYTLM and getXTLM to get the next location
        curY = cb.getYTLM();
        curX = cb.getXTLM();
        cb.beginText();
        cb.moveText(curX, curY);
        cb.newlineText();

        // 8. Add the subject
        int invoiceNo       = 2446;
        String invoiceDate  = "12/01/2010";
        float invoiceAmount = 3000.0f;
        addSubjectReminderType1(cb, invoiceNo, invoiceDate, invoiceAmount);
        cb.endText();

        // 9. Add the list of journals and the period
        curY = cb.getYTLM();
        curX = cb.getXTLM();
        cb.beginText();
        cb.moveText(curX, curY);
        addJournals(cb);
        cb.endText();

        // 10. Add the content
        //document.newPage();
        curY = cb.getYTLM();
        curX = cb.getXTLM();
        cb.beginText();
        cb.moveText(curX, curY);
        addBodyReminderType1(cb, (float)rect.getWidth() - 2*curX);
        //cb.endText();

        // 11. Close the document
        document.close();
        return outputStream;
    }

    // This contains the subNo, date, invoice address and shipping address
    public void addInitialBody(PdfContentByte cb, float curX, float curY, float deltaX)
    {
        // 3. Add the subscriber Id
        cb.beginText();
        cb.moveText(curX, curY);
        addSubscriberId(cb);
        cb.endText();

        // 4. Add the date
        cb.beginText();
        cb.moveText(curX + deltaX, curY);
        cb.showText("DATE: " + getCurrentDate());
        cb.endText();

        // Now move back to left side
        //curY = pdfWriter.getVerticalPosition(ensureNewLine);
        //curX = document.leftMargin();
        //deltaX = rect.getWidth()/2;

        // 5. Add the shipping address
        cb.beginText();
        cb.newlineText();
        cb.moveText(curX + deltaX, curY);
        addShippingAddress(cb);
        cb.endText();

        // 6. Add the mailing address
        cb.beginText();
        cb.newlineText();
        cb.moveText(curX, curY);
        addMailingAddress(cb);
        cb.endText();
    }

    public void setupFontAndLeading(PdfContentByte cb)
    {
        Font f = new Font(fontType, fontSize);
        BaseFont bf = f.getCalculatedBaseFont(false);
        cb.setFontAndSize(bf, fontSize);
        cb.setLeading(leading);
    }

    public void addJournals(PdfContentByte cb)
    {
        String journalName  = "Current Science";
        String startMonth   = "JAN";
        String startYear    = "2012";
        String endMonth     = "DEC";
        String endYear      = "2012";
        cb.newlineText();
        for(int i=0; i<=15; i++)
        {
            cb.newlineShowText(journalName + " " + startMonth + " " + startYear + " to " + endMonth + " " + endYear);
        }
    }

    public void addBodyReminderType2(PdfContentByte cb, float width)
    {
        String template1 = "Dear Subscriber";
        String template2 = "Please refer to our Invoice towards the supply of the journals";
        String template3 = "mentioned above. We are sorry that in spite of repeated reminders";
        String template4 = "our bill remains unpaid till now. However, we have mailed all";
        String template5 = "the issues AS ON DATE in anticipation of payment.";
        String template6 = "We solicit your kind co-operation in settlement of out bill";
        String template7 = "immediately.";
        String template8 = "Thanking you,";
        String template9 = "Yours Sincerely,";
        String template10 = "For Circulation Department.";
        String template11 = "EMail:orders@ias.ernet.in";

        cb.newlineText();
        cb.newlineShowText(template1);
        cb.newlineText();
        cb.newlineShowText(template2);
        cb.newlineShowText(template3);
        cb.newlineShowText(template4);
        cb.newlineShowText(template5);
        cb.newlineText();

        cb.newlineShowText(template6);
        cb.newlineShowText(template7);
        cb.newlineText();
        cb.newlineShowText(template8);
        cb.newlineText();
        cb.newlineShowText(template9);
        cb.newlineShowText(template10);
        cb.newlineShowText(template11);
        cb.endText();

    }

    public void addBodyReminderType1(PdfContentByte cb, float width)
    {
        String template1 = "Dear Sir(s),";
        String template2 = "The invoice referred to above is outstanding.";
        String template3 = "Kindly look into the matter and expedite payment.";
        String template4 = "Thanking you in anticipation,";
        String template5 = "Yours Sincerely,";
        String template6 = "For Circulation Department.";
        String template7 = "EMail:orders@ias.ernet.in";
        String template8    = "***************************************";
        String template9    = "PLEASE ALWAYS QUOTE THE";
        String template10   = "ABOVE MENTIONED SUB. NO.";
        String template11   = "IN ALL CORRESPONDENCE,";
        String template12   = "CLAIMS, ETC.";

        cb.newlineText();
        cb.newlineShowText(template1);
        cb.newlineShowText(template2);
        cb.newlineShowText(template3);
        cb.newlineShowText(template4);
        cb.newlineText();

        cb.newlineShowText(template5);
        cb.newlineShowText(template6);
        cb.newlineShowText(template7);
        cb.newlineText();
        //cb.endText();

        //LineSeparator ls = new LineSeparator();
        //ls.drawLine(cb, cb.getXTLM(), cb.getXTLM() + width, cb.getYTLM());

        //float curY = cb.getYTLM();
        //float curX = cb.getXTLM();
        //cb.beginText();
        //cb.moveText(curX, curY);
        cb.newlineShowText(template8);
        cb.newlineShowText(template9);
        cb.newlineShowText(template10);
        cb.newlineShowText(template11);
        cb.newlineShowText(template12);
        cb.newlineShowText(template8);
        //cb.newlineText();
        cb.endText();

        //ls.drawLine(cb, cb.getXTLM(), cb.getXTLM() + width, cb.getYTLM());
    }

    public Paragraph getBody()
    {
        String template1 = "Dear Sir(s),";
        String template2 = "The invoice referred to above is outstanding.";
        String template3 = "Kindly look into the matter and expedite payment.";
        String template4 = "Thanking you in anticipation,";
        String template5 = "Yours Sincerely,";
        String template6 = "For Circulation Department.";
        String template7 = "EMail:orders@ias.ernet.in";
        String template8    = "****************************";
        String template9    = "PLEASE ALWAYS QUOTE THE ABOVE MENTIONED SUB. NO. IN ALL CORRESPONDENCE CLAIMS, ETC.";

        Paragraph paragraph = new Paragraph();
        paragraph.setAlignment(textAlignment);
        paragraph.setFont(new Font(fontType, fontSize));
        paragraph.add(template1);
        paragraph.add(Chunk.NEWLINE);
        paragraph.add(template2);
        paragraph.add(Chunk.NEWLINE);
        paragraph.add(template3);
        paragraph.add(Chunk.NEWLINE);
        paragraph.add(template4);
        paragraph.add(Chunk.NEWLINE);
        paragraph.add(Chunk.NEWLINE);
        paragraph.add(template5);
        paragraph.add(Chunk.NEWLINE);
        paragraph.add(template6);
        paragraph.add(Chunk.NEWLINE);
        paragraph.add(template7);
        paragraph.add(Chunk.NEWLINE);
        paragraph.add(Chunk.NEWLINE);
        //paragraph.add(template8);
        LineSeparator ls = new LineSeparator();
        paragraph.add(new Chunk(ls));

        paragraph.add(Chunk.NEWLINE);
        paragraph.add(template9);
        paragraph.add(Chunk.NEWLINE);
        //paragraph.add(template8);
        paragraph.add(new Chunk(ls));

        return paragraph;
    }

    public Paragraph getJournal(String journalName, String startMonth, String startYear, String endMonth, String endYear)
    {
        String template1 = " to ";
        Paragraph paragraph = new Paragraph();
        paragraph.setAlignment(Element.ALIGN_LEFT);
        paragraph.setFont(new Font(fontType, fontSize));

        paragraph.add(journalName + " " + startMonth + " " + startYear + template1 + endMonth + " " + endYear);

        return paragraph;
    }

    public void addSubjectReminderType2(PdfContentByte cb)
    {
        String template = "Sub:- NON PAYMENT OF SUBSCRIPTION FOR 2011";
        cb.newlineShowText(template);

    }

    public void addSubjectReminderType1(PdfContentByte cb, int invoiceNo, String invoiceDate, float invoiceAmount)
    {
        String template1 = "Sub:- Settlement of our Proforma Invoice No. ";
        String template2 = " dated ";
        String template3 = " for Rs. ";
        String template4 = " towards subscription of";

        cb.newlineShowText(template1 + invoiceNo);
        cb.newlineShowText(template2 + invoiceDate + template3 + invoiceAmount);
        cb.newlineShowText(template4);

    }

    public Paragraph getSubject(int invoiceNo, String invoiceDate, float invoiceAmount)
    {
        String template1 = "Sub:- Settlement of our Proforma Invoice No. ";
        String template2 = " dated ";
        String template3 = " for Rs. ";
        String template4 = " towards subscription of";

        Paragraph paragraph = new Paragraph();
        paragraph.setAlignment(Element.ALIGN_LEFT);
        paragraph.setFont(new Font(fontType, fontSize));

        paragraph.add(template1 + invoiceNo + template2 + invoiceDate + template3 + invoiceAmount + template4);
        //paragraph.add(Chunk.NEWLINE);
        //paragraph.add(template2 + invoiceDate + template3 + invoiceAmount);
        //paragraph.add(template4);

        return paragraph;
    }

    public String getCurrentDate()
    {
        Format dtformat = new SimpleDateFormat("dd MMM yyyy");
        java.util.Date dt = new java.util.Date();
        String date = dtformat.format(dt);
        return date;
    }

    public void addSubscriberId(PdfContentByte cb)
    {
        String template = "SUB.NO. ";
        String subscriberId = "3962";
        cb.showText(template + subscriberId);
    }

    public Paragraph addShippingAddress()
    {

        String subscriberName   = "(Ref: ID 123 IMS Engg College)";
        String department       = "South Asia Distributors & Publisher";
        String institution      = "92-C (Part), 1st Floor, SPAN House";
        String address          =  "Gurudwara Road, Madangir";
        String city             = "New Delhi";
        String pincode          = "110 062";
        String state            = "New Delhi";
        String country          = "India";

        Paragraph info = new Paragraph();
        info.setLeading(leading);
        info.setAlignment(textAlignment);

        Font font = new Font(fontType, fontSize, fontStyle, BaseColor.BLACK);
        info.add(new Chunk("SHIPPING ADDRESS", font));
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

        return info;

    }

    public void addShippingAddress(PdfContentByte cb)
    {
        String subscriberName   = "(Ref: ID 123 IMS Engg College)";
        String department       = "South Asia Distributors & Publisher";
        String institution      = "92-C (Part), 1st Floor, SPAN House";
        String address          =  "Gurudwara Road, Madangir";
        String city             = "New Delhi";
        String pincode          = "110 062";
        String state            = "New Delhi";
        String country          = "India";

        cb.showText("SHIPPING ADDRESS");
        //cb.newlineShowText("=================");
        cb.newlineShowText("-----------------");
        cb.newlineShowText(subscriberName);
        cb.newlineShowText(department);
        cb.newlineShowText(institution);
        cb.newlineShowText(address);

        String lastLine = city +
                " " + pincode +
                " " + state +
                " " + country;
        cb.newlineShowText(lastLine);
    }

    public void addMailingAddress(PdfContentByte cb)
    {
        String subscriberName   = "(Ref: ID 123 IMS Engg College)";
        String department       = "South Asia Distributors & Publisher";
        String institution      = "92-C (Part), 1st Floor, SPAN House";
        String address          =  "Gurudwara Road, Madangir";
        String city             = "New Delhi";
        String pincode          = "110 062";
        String state            = "New Delhi";
        String country          = "India";

        cb.showText("Mailing ADDRESS");
        //cb.newlineShowText("===============");
        cb.newlineShowText("---------------");
        cb.newlineShowText(subscriberName);
        cb.newlineShowText(department);
        cb.newlineShowText(institution);
        cb.newlineShowText(address);

        String lastLine = city +
                " " + pincode +
                " " + state +
                " " + country;
        cb.newlineShowText(lastLine);
    }

    public boolean addParagraph(Paragraph p, PdfContentByte canvas, FieldPosition f, boolean simulate) throws DocumentException {
        ColumnText ct = new ColumnText(canvas);
        ct.setSimpleColumn(
            f.position.getLeft(2), f.position.getBottom(2), f.position.getRight(2), f.position.getTop());
        ct.addElement(p);
        return ColumnText.hasMoreText(ct.go(simulate));
    }

    public void addLabelContent(ResultSet rs, OutputStream os) throws DocumentException, IOException, SQLException
    {
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
        Properties properties = getMailingListProperties();
        float[][] COLUMNS = new float[2][4];
        COLUMNS[1][0] = Float.valueOf(properties.getProperty("llx1").trim()).floatValue();
        COLUMNS[1][1] = Float.valueOf(properties.getProperty("lly1").trim()).floatValue();
        COLUMNS[1][2] = Float.valueOf(properties.getProperty("urx1").trim()).floatValue();
        COLUMNS[1][3] = Float.valueOf(properties.getProperty("ury1").trim()).floatValue();

        COLUMNS[0][0] = Float.valueOf(properties.getProperty("llx2").trim()).floatValue();
        COLUMNS[0][1] = Float.valueOf(properties.getProperty("lly2").trim()).floatValue();
        COLUMNS[0][2] = Float.valueOf(properties.getProperty("urx2").trim()).floatValue();
        COLUMNS[0][3] = Float.valueOf(properties.getProperty("ury2").trim()).floatValue();

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

    public Properties getRemindersProperties() throws FileNotFoundException, IOException
    {
        ServletContext context = ServletContextInfo.getServletContext();
        String mlPropertiesFile = context.getRealPath("/WEB-INF/classes/jds_reminders.properties");
        Properties properties = new Properties();
        properties.load(new FileInputStream(mlPropertiesFile));

        // Read common information
        leading         = Float.valueOf(properties.getProperty("leading").trim()).floatValue();
        textAlignment   = Integer.parseInt(properties.getProperty("textAlignment"));
        fontType        = Font.getFamily(properties.getProperty("fontFamily"));
        fontSize        = Integer.parseInt(properties.getProperty("fontSize"));
        fontStyle       = Font.getStyleValue(properties.getProperty("fontStyle"));

        return properties;
    }

    public Properties getMailingListProperties() throws FileNotFoundException, IOException
    {
        ServletContext context = ServletContextInfo.getServletContext();
        String mlPropertiesFile = context.getRealPath("/WEB-INF/classes/jds_mailinglist.properties");
        Properties properties = new Properties();
        properties.load(new FileInputStream(mlPropertiesFile));

        // Read common information
        leading         = Float.valueOf(properties.getProperty("leading").trim()).floatValue();
        textAlignment   = Integer.parseInt(properties.getProperty("textAlignment"));
        fontType        = Font.getFamily(properties.getProperty("fontFamily"));
        fontSize        = Integer.parseInt(properties.getProperty("fontSize"));
        fontStyle       = Font.getStyleValue(properties.getProperty("fontStyle"));

        return properties;
    }

    public Properties getMissingIssueProperties() throws FileNotFoundException, IOException
    {
        ServletContext context = ServletContextInfo.getServletContext();
        String mlPropertiesFile = context.getRealPath("/WEB-INF/classes/jds_missingissue.properties");
        Properties properties = new Properties();
        properties.load(new FileInputStream(mlPropertiesFile));

        // Read common information
        leading         = Float.valueOf(properties.getProperty("leading").trim()).floatValue();
        textAlignment   = Integer.parseInt(properties.getProperty("textAlignment"));
        fontType        = Font.getFamily(properties.getProperty("fontFamily"));
        fontSize        = Integer.parseInt(properties.getProperty("fontSize"));
        fontStyle       = Font.getStyleValue(properties.getProperty("fontStyle"));

        return properties;
    }

    public void addStickerContent(ResultSet rs, OutputStream os) throws DocumentException, IOException, SQLException
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

        Properties properties = getMailingListProperties();

        int stickerColumns = Integer.parseInt(properties.getProperty("stickerColumns"));
        //int stickerRows  = Integer.getInteger(properties.getProperty("stickerRows"));
        int stickerRows     = Integer.parseInt(properties.getProperty("stickerRows"));

        float leftMargin    = Float.valueOf(properties.getProperty("leftMargin").trim()).floatValue();     //4.9mm
        float stickerWidth  = Float.valueOf(properties.getProperty("stickerWidth").trim()).floatValue();   //9.91cms
        float rightMargin   = Float.valueOf(properties.getProperty("rightMargin").trim()).floatValue();    //4.9mm
        float gapAcrossStickers = Float.valueOf(properties.getProperty("gapAcrossStickers").trim()).floatValue(); //2mm
        //Total Width = 4.9 + 99.1*2 + 4.9 + 2.0 = 206

        float topMargin     = Float.valueOf(properties.getProperty("topMargin").trim()).floatValue();    //12.9cms
        float stickerHeight = Float.valueOf(properties.getProperty("stickerHeight").trim()).floatValue();    //3.39cms
        float bottomMargin  = Float.valueOf(properties.getProperty("bottomMargin").trim()).floatValue();    //12.9mm
        // Total Height = 12.9 + 33.9*8 + 12.9 = 297

        float header        = Float.valueOf(properties.getProperty("header").trim()).floatValue();     // This is the space to be left on top of sticker

        float pageHeight    = Float.valueOf(properties.getProperty("pageHeight").trim()).floatValue();   //297mm
        float pageWidth     = Float.valueOf(properties.getProperty("pageWidth").trim()).floatValue();   //210mm

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
                    /*
                    PdfContentByte canvas = writer.getDirectContent();
                    canvas.setRGBColorFill(0xFF, 0x45, 0x00);
                    canvas.setColorFill(BaseColor.WHITE);
                    canvas.rectangle(x, y, Utilities.millimetersToPoints(stickerWidth), Utilities.millimetersToPoints(stickerHeight));
                    canvas.fillStroke();
                    */

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

    public Paragraph getAddress()
    {

        String subscriberName   = "(Ref: ID 123 IMS Engg College)";
        String department       = "South Asia Distributors & Publisher";
        String institution      = "92-C (Part), 1st Floor, SPAN House";
        String address          =  "Gurudwara Road, Madangir";
        String city             = "New Delhi";
        String pincode          = "110 062";
        String state            = "New Delhi";
        String country          = "India";

        Paragraph info = null;
        info = new Paragraph();
        info.setLeading(leading);
        info.setAlignment(textAlignment);

        Font font = new Font(fontType, fontSize, fontStyle, BaseColor.BLACK);
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

        return info;

    }

    public Paragraph getContent(ResultSet rs) throws SQLException
    {
        //String subscriberNumber = "36207";
        //String journalCode      = "RES";
        //String subtypecode      = "II";
        //String startDate        = "Jan 2010";
        //String endDate          = "Dec 2010";
        //String subscriberName   = "(Ref: ID 123 IMS Engg College)";
        //String department       = "South Asia Distributors & Publisher";
        //String institution      = "92-C (Part), 1st Floor, SPAN House";
        //String address          =  "Gurudwara Road, Madangir";
        //String city             = "New Delhi";
        //String pincode          = "110 062";
        //String state            = "New Delhi";
        //String country          = "India";

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
            info.setLeading(leading);
            info.setAlignment(textAlignment);

            Font font = new Font(fontType, fontSize, fontStyle, BaseColor.BLACK);
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


    /*
    public void addLabelContent(ResultSet rs, OutputStream os) throws DocumentException, IOException, SQLException
    {
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
        Properties properties = getMailingListProperties();
        float[][] COLUMNS = new float[2][4];
        COLUMNS[0][0] = Float.valueOf(properties.getProperty("llx1").trim()).floatValue();
        COLUMNS[0][1] = Float.valueOf(properties.getProperty("lly1").trim()).floatValue();
        COLUMNS[0][2] = Float.valueOf(properties.getProperty("urx1").trim()).floatValue();
        COLUMNS[0][3] = Float.valueOf(properties.getProperty("ury1").trim()).floatValue();

        COLUMNS[1][0] = Float.valueOf(properties.getProperty("llx2").trim()).floatValue();
        COLUMNS[1][1] = Float.valueOf(properties.getProperty("lly2").trim()).floatValue();
        COLUMNS[1][2] = Float.valueOf(properties.getProperty("urx2").trim()).floatValue();
        COLUMNS[1][3] = Float.valueOf(properties.getProperty("ury2").trim()).floatValue();

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

    public Properties getMailingListProperties() throws FileNotFoundException, IOException
    {
        ServletContext context = ServletContextInfo.getServletContext();
        String mlPropertiesFile = context.getRealPath("/WEB-INF/classes/jds_mailinglist.properties");
        Properties properties = new Properties();
        properties.load(new FileInputStream(mlPropertiesFile));

        // Read common information
        leading         = Float.valueOf(properties.getProperty("leading").trim()).floatValue();
        textAlignment   = Integer.parseInt(properties.getProperty("textAlignment"));
        fontType        = Font.getFamily(properties.getProperty("fontFamily"));
        fontSize        = Integer.parseInt(properties.getProperty("fontSize"));
        fontStyle       = Font.getStyleValue(properties.getProperty("fontStyle"));

        return properties;
    }

    public void addStickerContent(ResultSet rs, OutputStream os) throws DocumentException, IOException, SQLException
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

        Properties properties = getMailingListProperties();

        int stickerColumns = Integer.parseInt(properties.getProperty("stickerColumns"));
        //int stickerRows  = Integer.getInteger(properties.getProperty("stickerRows"));
        int stickerRows     = Integer.parseInt(properties.getProperty("stickerRows"));

        float leftMargin    = Float.valueOf(properties.getProperty("leftMargin").trim()).floatValue();     //4.9mm
        float stickerWidth  = Float.valueOf(properties.getProperty("stickerWidth").trim()).floatValue();   //9.91cms
        float rightMargin   = Float.valueOf(properties.getProperty("rightMargin").trim()).floatValue();    //4.9mm
        float gapAcrossStickers = Float.valueOf(properties.getProperty("gapAcrossStickers").trim()).floatValue(); //2mm
        //Total Width = 4.9 + 99.1*2 + 4.9 + 2.0 = 206

        float topMargin     = Float.valueOf(properties.getProperty("topMargin").trim()).floatValue();    //12.9cms
        float stickerHeight = Float.valueOf(properties.getProperty("stickerHeight").trim()).floatValue();    //3.39cms
        float bottomMargin  = Float.valueOf(properties.getProperty("bottomMargin").trim()).floatValue();    //12.9mm
        // Total Height = 12.9 + 33.9*8 + 12.9 = 297

        float header        = Float.valueOf(properties.getProperty("header").trim()).floatValue();     // This is the space to be left on top of sticker

        float pageHeight    = Float.valueOf(properties.getProperty("pageHeight").trim()).floatValue();   //297mm
        float pageWidth     = Float.valueOf(properties.getProperty("pageWidth").trim()).floatValue();;   //210mm

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

    public Paragraph getContent(ResultSet rs) throws SQLException
    {
        //String subscriberNumber = "36207";
        //String journalCode      = "RES";
        //String subtypecode      = "II";
        //String startDate        = "Jan 2010";
        //String endDate          = "Dec 2010";
        //String subscriberName   = "(Ref: ID 123 IMS Engg College)";
        //String department       = "South Asia Distributors & Publisher";
        //String institution      = "92-C (Part), 1st Floor, SPAN House";
        //String address          =  "Gurudwara Road, Madangir";
        //String city             = "New Delhi";
        //String pincode          = "110 062";
        //String state            = "New Delhi";
        //String country          = "India";

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
            info.setLeading(leading);
            info.setAlignment(textAlignment);

            Font font = new Font(fontType, fontSize, fontStyle, BaseColor.BLACK);
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
    */

}


