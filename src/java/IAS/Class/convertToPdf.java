package IAS.Class;
import IAS.Bean.reminder.subscriberInfo;
import IAS.Bean.reminder.subscriptionInfo;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Utilities;
import com.itextpdf.text.pdf.AcroFields.FieldPosition;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.ColumnText;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import javax.servlet.ServletContext;
import javax.xml.parsers.ParserConfigurationException;
import org.apache.log4j.Logger;
import org.xml.sax.SAXException;


public class convertToPdf extends JDSPDF {

    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Class.convertToPdf");

    // Common for all
    float leading            = 10.0f;
    int textAlignment   = 0;
    Font.FontFamily fontType = Font.getFamily("HELVETICA");
    int fontSize        = 10;
    int fontStyle       = Font.getStyleValue("NORMAL");

    // Specifics for label
    float lfixedLeading       = 0.0f;
    float lmultipliedLeading  = 1.2f;
    float lmultipliedLeadingPlus = 1.5f;
    int ltextAlignment    = 0;
    Font.FontFamily lfontType = Font.getFamily("HELVETICA");
    int lfontSize        = 10;
    int lfontStyle       = Font.getStyleValue("NORMAL");
    int lfontSizeHeader  = 10;

    // Specifics for sticker
    int stextAlignment    = 0;
    Font.FontFamily sfontType = Font.getFamily("HELVETICA");
    int sfontSize        = 10;
    int sfontStyle       = Font.getStyleValue("NORMAL");
    int sfontSizeHeader  = 10;

    boolean noHeader = false;
    boolean periodicals = false;
    boolean separateOutLatestIssue= false;

    String reminderType1Text = "";
    String reminderType2Text = "";
    String reminderType3Text = "";

    // Used for back issue
    boolean backIssue = false;
    ArrayList BILlabels = new ArrayList();

public convertToPdf(String _noHeader, String _periodicals){
        super();
        if(_noHeader!= null && _noHeader.equals("on")){
            noHeader    = true;
        }
        if(_periodicals!= null && _periodicals.equals("on")){
            periodicals = true;
        }
    }

public convertToPdf(String _noHeader, String _periodicals, String _separateLabel, boolean _backIssue){
        super();
        if(_noHeader!= null && _noHeader.equals("on")){
            noHeader    = true;
        }
        if(_periodicals!= null && _periodicals.equals("on")){
            periodicals = true;
        }
        if(_separateLabel!= null && _separateLabel.equals("on")){
            separateOutLatestIssue = true;
        }
        backIssue = _backIssue;
    }

public convertToPdf(){
        super();
    }

    /*
     * NOTE: Usually we calculate the width of the columns based on the average.
     * But in this case we calculate the max of the column widths.
     * Currently this is used only for print order and statement. if this is used for any other
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
        table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
        table.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);

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
        java.sql.ResultSetMetaData rsmd = rs.getMetaData();
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
            if(i == 1){
                columnWidth[i-1] = columnWidth[i-1] * 2;
            }
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

    public ByteArrayOutputStream generateReminders(List<subscriberInfo> s) throws DocumentException, IOException{

        Properties properties = getRemindersProperties();

        // step 1
        Document document = new Document(PageSize.A4);
        document.addAuthor("JDS");
        document.addCreator("JDS");
        document.addTitle("Reminders");

        // step 2
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PdfWriter writer = PdfWriter.getInstance(document, baos);
        //writer.setInitialLeading(8.0f);

        // step 3
        document.open();

        Iterator itr = s.listIterator();
        while (itr.hasNext()){

            subscriberInfo sinfo = (subscriberInfo)itr.next();
            int reminderType     = sinfo.getReminderType();

            // 1. Add the letter head
            document.add(this.getLetterHead());

            // 2. Add the address, date, subNo
            // Add the address, date, subNo
            //document.add(Chunk.NEWLINE);

            // Setup the font and leading
            //PdfContentByte cb = writer.getDirectContent();
            //setupFontAndLeading(cb);

            PdfPTable table = new PdfPTable(2);
            table.setWidthPercentage(100f);
            table.setHeaderRows(0);
            //PdfPCell c1 = new PdfPCell(new Phrase());
            PdfPCell c1 = new PdfPCell(getSubNo(sinfo));
            c1.setBorder(PdfPCell.NO_BORDER);
            PdfPCell c2 = new PdfPCell(getDate());
            c2.setBorder(PdfPCell.NO_BORDER);
            PdfPCell c3 = new PdfPCell(getInvoiceAddressHeader());
            c3.setBorder(PdfPCell.NO_BORDER);
            PdfPCell c4 = new PdfPCell(getShippingAddressHeader());
            c4.setBorder(PdfPCell.NO_BORDER);
            PdfPCell c5 = new PdfPCell(getInvoiceAddress(sinfo));
            c5.setBorder(PdfPCell.NO_BORDER);
            PdfPCell c6 = new PdfPCell(getShippingAddress(sinfo));
            c6.setBorder(PdfPCell.NO_BORDER);

            table.addCell(c1);
            table.addCell(c2);
            table.addCell(c3);
            table.addCell(c4);
            table.addCell(c5);
            table.addCell(c6);
            document.add(table);

            document.add(Chunk.NEWLINE);

            /*
            Rectangle rect = writer.getPageSize();
            boolean ensureNewLine = false;
            float curY = writer.getVerticalPosition(ensureNewLine);
            float curX = document.leftMargin();
            float deltaX = (float) (rect.getWidth()/2);
            addInitialBody(cb, curX, curY, deltaX, sinfo);

            // Get the location where the next content should go
            // When you have added multiple lines in the previous text addition use getYTLM and getXTLM to get the next location
            curY = cb.getYTLM();
            curX = cb.getXTLM();
            cb.beginText();
            cb.moveText(curX, curY);
            cb.newlineText();
            */

            // 3. Add the subject
            //addSubjectReminderType1(cb, invoiceNo, invoiceDate, invoiceAmount);
            if(reminderType == 1){
                document.add(addSubjectReminderType1(sinfo.getInvoiceNo(), sinfo.getInvoicedate(), sinfo.getBalance()));
            }else if(reminderType == 2){
                document.add(addSubjectReminderType1(sinfo.getInvoiceNo(), sinfo.getInvoicedate(), sinfo.getBalance()));
                //document.add(addSubjectReminderType2());
            }else if(reminderType == 3){
                document.add(addSubjectReminderType1(sinfo.getInvoiceNo(), sinfo.getInvoicedate(), sinfo.getBalance()));
                //document.add(addSubjectReminderType2());
            }
            //cb.endText();

            // 4. Add the list of journals and the period
            /*
            curY = cb.getYTLM();
            curX = cb.getXTLM();
            cb.beginText();
            cb.moveText(curX, curY);
            */
            document.add(Chunk.NEWLINE);
            //PdfPTable table2 = addJournals(sinfo);
            document.add(addJournals(sinfo));
            //float[] widths = {0.8f, 0.1f, 0.1f, 0.1f, 0.1f};
            //table2.setWidths(widths);
            //table2.setWidthPercentage(100f);
            //table2.setHeaderRows(0);
            //document.add(table2);
            //cb.endText();

            // 5. Add the content
            /*
            curY = cb.getYTLM();
            curX = cb.getXTLM();
            cb.beginText();
            cb.moveText(curX, curY);
            */
            document.add(Chunk.NEWLINE);
            document.add(addRefernce(sinfo.getLetterNumber(), sinfo.getLetterDate()));
            
            document.add(Chunk.NEWLINE);
            if(reminderType == 1){
                //addBodyReminderType1(cb, (float)rect.getWidth() - 2*curX);
                document.add(new Paragraph(reminderType1Text));
            }else if(reminderType == 2){
                //addBodyReminderType2(cb, (float)rect.getWidth() - 2*curX);
                document.add(new Paragraph(reminderType2Text));
            }else if(reminderType == 3){
                //addBodyReminderType2(cb, (float)rect.getWidth() - 2*curX);
                document.add(new Paragraph(reminderType3Text));
            }

            // 6. Add the footer
            this.addPaymentFooter(document, writer);

            document.newPage();
        }

        // 11. Close the document
        document.close();

        return baos;
    }

    public Paragraph getDate(){
        Paragraph paragraph = new Paragraph();
        paragraph.setAlignment(textAlignment);
        paragraph.setFont(new Font(fontType, fontSize));
        paragraph.add("DATE: " + getCurrentDate());

        return paragraph;
    }

    public Paragraph getSubNo(subscriberInfo sinfo) {

        Paragraph paragraph = new Paragraph();
        paragraph.setAlignment(textAlignment);
        paragraph.setFont(new Font(fontType, fontSize));
        paragraph.add("SUB.NO. " + sinfo.getSubscriberNumber());

        return paragraph;

    }

    public Paragraph getInvoiceAddress(subscriberInfo sinfo)
    {

        Paragraph paragraph = new Paragraph();
        paragraph.setAlignment(textAlignment);
        paragraph.setFont(new Font(fontType, fontSize));
        paragraph.add(sinfo.getSubscriberName());
        paragraph.add(Chunk.NEWLINE);
        paragraph.add(sinfo.getDepartment());
        paragraph.add(Chunk.NEWLINE);
        paragraph.add(sinfo.getInstitution());
        paragraph.add(Chunk.NEWLINE);
        paragraph.add(sinfo.getInvoiceAddress());
        paragraph.add(Chunk.NEWLINE);

        String lastLine = sinfo.getCity() +
                " " + sinfo.getPincode() +
                " " + sinfo.getState();
                //" " + sinfo.getCountry();

        paragraph.add(lastLine);
        return paragraph;
    }

    public Paragraph getShippingAddress(subscriberInfo sinfo)
    {

        Paragraph paragraph = new Paragraph();
        paragraph.setAlignment(textAlignment);
        paragraph.setFont(new Font(fontType, fontSize));
        paragraph.add(sinfo.getSubscriberName());
        paragraph.add(Chunk.NEWLINE);
        paragraph.add(sinfo.getDepartment());
        paragraph.add(Chunk.NEWLINE);
        paragraph.add(sinfo.getInstitution());
        paragraph.add(Chunk.NEWLINE);
        paragraph.add(sinfo.getShippingAddress());
        paragraph.add(Chunk.NEWLINE);

        String lastLine = sinfo.getCity() +
                " " + sinfo.getPincode() +
                " " + sinfo.getState();
                //" " + sinfo.getCountry();

        paragraph.add(lastLine);
        return paragraph;
    }

    public Paragraph getInvoiceAddressHeader(){

        Paragraph paragraph = new Paragraph();
        paragraph.setAlignment(textAlignment);
        paragraph.setFont(new Font(fontType, fontSize));
        Chunk c = new Chunk("Invoice ADDRESS");
        c.setUnderline(0.1f, -2f);
        paragraph.add(c);

        return paragraph;
    }

    public Paragraph getShippingAddressHeader(){

        Paragraph paragraph = new Paragraph();
        paragraph.setAlignment(textAlignment);
        paragraph.setFont(new Font(fontType, fontSize));
        Chunk c = new Chunk("Shipping ADDRESS");
        c.setUnderline(0.1f, -2f);
        paragraph.add(c);

        return paragraph;
    }

    public void setupFontAndLeading(PdfContentByte cb)
    {
        Font f = new Font(fontType, fontSize);
        BaseFont bf = f.getCalculatedBaseFont(false);
        cb.setFontAndSize(bf, fontSize);
        cb.setLeading(leading);
    }

    public Paragraph addJournals(subscriberInfo sinfo)
    {
        //cb.newlineText();

        //PdfPTable table = new PdfPTable(5);
        //table.setWidthPercentage(100f);
        //table.setHeaderRows(0);

        Paragraph paragraph = new Paragraph();
        paragraph.setAlignment(textAlignment);
        paragraph.setFont(new Font(fontType, fontSize));

        List<subscriptionInfo> s = sinfo.getSubscriptionInfo();
        Iterator itr = s.listIterator();
        while (itr.hasNext()){
            subscriptionInfo sCurrent = (subscriptionInfo)itr.next();
            /*
            String journalName  = "Current Science";
            String startMonth   = "JAN";
            String startYear    = "2012";
            String endMonth     = "DEC";
            String endYear      = "2012";
            */
            String journalName  = sCurrent.getJournalName();
            int startMonth   = sCurrent.getStartMonth();
            int startYear    = sCurrent.getStartYear();
            int endMonth     = sCurrent.getEndMonth();
            int endYear      = sCurrent.getEndYear();

            int noOfYears = 1;
            if(endMonth != 12) {
                noOfYears = endYear - startYear + 1;
            }else {
                noOfYears = endYear - startYear + 1;
            }

            String period = Integer.toString(startYear);
            if(endYear != startYear){
                period = Integer.toString(startYear) + "-" + Integer.toString(endYear);
            }

            Chunk c = new Chunk(journalName + " (" + Integer.toString(noOfYears) + " YEAR)" + " for the year(s) " + period);
            paragraph.add(c);
            paragraph.add(Chunk.NEWLINE);

            /*
            PdfPCell c1 = new PdfPCell(new Paragraph(journalName));
            PdfPCell c2 = new PdfPCell(new Paragraph(Integer.toString(startMonth)));
            PdfPCell c3 = new PdfPCell(new Paragraph(Integer.toString(startYear)));
            PdfPCell c4 = new PdfPCell(new Paragraph(Integer.toString(endMonth)));
            PdfPCell c5 = new PdfPCell(new Paragraph(Integer.toString(endYear)));

            table.addCell(c1);
            table.addCell(c2);
            table.addCell(c3);
            table.addCell(c4);
            table.addCell(c5);
            */

            //cb.newlineShowText(journalName + " " + startMonth + " " + startYear + " to " + endMonth + " " + endYear);
            /*
            for(int i=0; i<=15; i++)
            {
                cb.newlineShowText(journalName + " " + startMonth + " " + startYear + " to " + endMonth + " " + endYear);
            }
            */
        }
        return paragraph;
    }

    public Paragraph addSubjectReminderType2()
    {
        String template = "Sub:- NON PAYMENT OF SUBSCRIPTION/ BALANCE PAYMENT";
        Paragraph paragraph = new Paragraph();
        //cb.newlineShowText(template);
        paragraph.add(template);

        return paragraph;

    }

    public Paragraph addSubjectReminderType1(int invoiceNo, String invoiceDate, float invoiceAmount)
    {
        Paragraph paragraph = new Paragraph();

        String template1 = "Sub:- Settlement of our Proforma Invoice No. ";
        String template5 = "Sub:- Settlement of balance payment ";
        String template2 = " dated ";
        String template3 = " for Rs. ";
        String template4 = " towards subscription of";
        

        String op="";

        if(invoiceNo == 0){
            //cb.newlineShowText(template5);
            op = op + template5;
        }else {
            //cb.newlineShowText(template1 + invoiceNo);
            op = op + template1 + invoiceNo;
        }

        if(invoiceDate.isEmpty()){
            //cb.newlineShowText(template2 + invoiceDate + template3 + invoiceAmount);
            op = op + template3 + invoiceAmount;
        }else {
            //cb.newlineShowText(template3 + invoiceAmount);
            op = op + template2 + invoiceDate + template3 + invoiceAmount;
        }
        //cb.newlineShowText(template4);
        op = op + template4;
        paragraph.setAlignment(Element.ALIGN_LEFT);
        paragraph.setFont(new Font(fontType, fontSize));

        paragraph.add(op);

        return paragraph;

    }

        public Paragraph addRefernce(String letterNumber, String letterDate)
    {
        Paragraph paragraph = new Paragraph();

        String template1 = "Ref:- Your Order No. ";
        String template2 = " dated ";
       

        String op="";

        op = op + template1 + letterNumber + template2 + letterDate;
        
        paragraph.setAlignment(Element.ALIGN_LEFT);
        paragraph.setFont(new Font(fontType, fontSize));

        paragraph.add(op);

        return paragraph;

    }
        
    public String getCurrentDate()
    {
        Format dtformat = new SimpleDateFormat("dd MMM yyyy");
        java.util.Date dt = new java.util.Date();
        String date = dtformat.format(dt);
        return date;
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

        float[][] FOOTER_COLUMNS = new float[2][4];
        FOOTER_COLUMNS[1][0] = Float.valueOf(properties.getProperty("fllx1").trim()).floatValue();
        FOOTER_COLUMNS[1][1] = Float.valueOf(properties.getProperty("flly1").trim()).floatValue();
        FOOTER_COLUMNS[1][2] = Float.valueOf(properties.getProperty("furx1").trim()).floatValue();
        FOOTER_COLUMNS[1][3] = Float.valueOf(properties.getProperty("fury1").trim()).floatValue();

        FOOTER_COLUMNS[0][0] = Float.valueOf(properties.getProperty("fllx2").trim()).floatValue();
        FOOTER_COLUMNS[0][1] = Float.valueOf(properties.getProperty("flly2").trim()).floatValue();
        FOOTER_COLUMNS[0][2] = Float.valueOf(properties.getProperty("furx2").trim()).floatValue();
        FOOTER_COLUMNS[0][3] = Float.valueOf(properties.getProperty("fury2").trim()).floatValue();

        float[][] SLNO_COLUMNS = new float[2][4];
        SLNO_COLUMNS[1][0] = Float.valueOf(properties.getProperty("sllx1").trim()).floatValue();
        SLNO_COLUMNS[1][1] = Float.valueOf(properties.getProperty("slly1").trim()).floatValue();
        SLNO_COLUMNS[1][2] = Float.valueOf(properties.getProperty("surx1").trim()).floatValue();
        SLNO_COLUMNS[1][3] = Float.valueOf(properties.getProperty("sury1").trim()).floatValue();

        SLNO_COLUMNS[0][0] = Float.valueOf(properties.getProperty("sllx2").trim()).floatValue();
        SLNO_COLUMNS[0][1] = Float.valueOf(properties.getProperty("slly2").trim()).floatValue();
        SLNO_COLUMNS[0][2] = Float.valueOf(properties.getProperty("surx2").trim()).floatValue();
        SLNO_COLUMNS[0][3] = Float.valueOf(properties.getProperty("sury2").trim()).floatValue();

        float[][] PDCLS_COLUMNS = new float[2][4];
        PDCLS_COLUMNS[1][0] = Float.valueOf(properties.getProperty("pllx1").trim()).floatValue();
        PDCLS_COLUMNS[1][1] = Float.valueOf(properties.getProperty("plly1").trim()).floatValue();
        PDCLS_COLUMNS[1][2] = Float.valueOf(properties.getProperty("purx1").trim()).floatValue();
        PDCLS_COLUMNS[1][3] = Float.valueOf(properties.getProperty("pury1").trim()).floatValue();

        PDCLS_COLUMNS[0][0] = Float.valueOf(properties.getProperty("pllx2").trim()).floatValue();
        PDCLS_COLUMNS[0][1] = Float.valueOf(properties.getProperty("plly2").trim()).floatValue();
        PDCLS_COLUMNS[0][2] = Float.valueOf(properties.getProperty("purx2").trim()).floatValue();
        PDCLS_COLUMNS[0][3] = Float.valueOf(properties.getProperty("pury2").trim()).floatValue();

        ColumnText ct = new ColumnText(writer.getDirectContent());
        int numberOfColumns = 2, count=0;
        int serialNo=1, noOfPages=0;

        Iterator bilLabelIter = BILlabels.iterator();

        while(true)
        {
            // Get the content
            Paragraph info = null;
            if(backIssue){
                if(bilLabelIter.hasNext()) {
                    info = (Paragraph)bilLabelIter.next();
                }
            } else {
            info = getLabelContent(rs);
            }

            if(info == null)
            {
                // step 5
                if(noOfPages == 0){
                    document.newPage();
                }
                document.close();

                baos.writeTo(os);
                return;
            }

            int col = (count)%numberOfColumns;


            // Add the serial no
            ct.setSimpleColumn(SLNO_COLUMNS[col][0], SLNO_COLUMNS[col][1], SLNO_COLUMNS[col][2], SLNO_COLUMNS[col][3]);
            int status = ColumnText.START_COLUMN;
            Paragraph info1 = getSerialNo(serialNo);
            ct.addElement(info1);
            int go = ct.go();

            // Add the text "P E R I O D I C A L"
            if(periodicals){
                ct.setSimpleColumn(PDCLS_COLUMNS[col][0], PDCLS_COLUMNS[col][1], PDCLS_COLUMNS[col][2], PDCLS_COLUMNS[col][3]);
                status = ColumnText.START_COLUMN;
                Paragraph info2 = getPERIODICAL();
                ct.addElement(info2);
            }
            go = ct.go();

            // Add the address
            ct.setSimpleColumn(COLUMNS[col][0], COLUMNS[col][1],COLUMNS[col][2], COLUMNS[col][3]);
            status = ColumnText.START_COLUMN;
            ct.addElement(info);
            go = ct.go();

            // Add the footer
            ct.setSimpleColumn(FOOTER_COLUMNS[col][0], FOOTER_COLUMNS[col][1],FOOTER_COLUMNS[col][2], FOOTER_COLUMNS[col][3]);
            status = ColumnText.START_COLUMN;
            info = getFooterForLabel();
            ct.addElement(info);
            go = ct.go();

            if(col == 1){
                document.newPage();
                noOfPages++;
            }

            count++;
            serialNo++;
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
        reminderType1Text    = properties.getProperty("reminderType1");
        reminderType2Text    = properties.getProperty("reminderType2");
        reminderType3Text    = properties.getProperty("reminderType3");

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
        lfixedLeading         = Float.valueOf(properties.getProperty("lfixedLeading").trim()).floatValue();
        lmultipliedLeading    = Float.valueOf(properties.getProperty("lmultipliedLeading").trim()).floatValue();
        lmultipliedLeadingPlus  = Float.valueOf(properties.getProperty("lmultipliedLeadingPlus").trim()).floatValue();
        textAlignment   = Integer.parseInt(properties.getProperty("textAlignment"));
        fontType        = Font.getFamily(properties.getProperty("fontFamily"));
        fontSize        = Integer.parseInt(properties.getProperty("fontSize"));
        fontStyle       = Font.getStyleValue(properties.getProperty("fontStyle"));

        // Read information required for label
        ltextAlignment   = Integer.parseInt(properties.getProperty("ltextAlignment"));
        lfontType        = Font.getFamily(properties.getProperty("lfontFamily"));
        lfontSize        = Integer.parseInt(properties.getProperty("lfontSize"));
        lfontStyle       = Font.getStyleValue(properties.getProperty("lfontStyle"));
        lfontSizeHeader  = Integer.parseInt(properties.getProperty("lfontSizeHeader"));

        // Read information required for label
        stextAlignment   = Integer.parseInt(properties.getProperty("stextAlignment"));
        sfontType        = Font.getFamily(properties.getProperty("sfontFamily"));
        sfontSize        = Integer.parseInt(properties.getProperty("sfontSize"));
        sfontStyle       = Font.getStyleValue(properties.getProperty("sfontStyle"));
        sfontSizeHeader  = Integer.parseInt(properties.getProperty("sfontSizeHeader"));

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

    public void prepareBILStickerContent(ResultSet rs) throws SQLException {
        lfixedLeading = 10.0f;
        lmultipliedLeadingPlus = 0.0f;
        prepareBILLabelContent(rs);

    }

    public void prepareBILLabelContent(ResultSet rs) throws SQLException {

        HashMap<String, SubscriberInfo> subscriber = new HashMap<>();

        // Subscriber: Key is subscriber no, value is SubscriberInfo
        // SubscriberInfo: Key is page_size, value is journalType
        // journalType: Key is journalCode, value is journalInfo
        // journalInfo: Key is volumeNo, value is volumeInfo

        // Subscriber: Key is subscriber no, value is SubscriberInfo
        // SubscriberInfo: Key is subscriptionId, value is SubscriptionInfo
        // sunbscriptionInfo: Key is page_size, value is journalType
        // journalType: Key is journalCode, value is journalInfo
        // journalInfo: Key is volumeNo, value is volumeInfo

        while(rs.next()) {
            subInfo sInfo = new subInfo(rs);

            SubscriberInfo subInfo = subscriber.get(sInfo.getsubscriberNumber());
            // Null means subscriber does not exist
            if(subInfo == null) {

                // If subscriber does not exist, then add him to the subscribers list

                // 1. Create the volume info
                volumeInfo vInfo = new volumeInfo();
                vInfo.setEndIssue(sInfo.getissue());
                vInfo.setStartIssue(sInfo.getissue());
                vInfo.setNo_of_copies(sInfo.getcopies());

                // 2. Create the journal info and add the volume info
                journalInfo jInfo = new journalInfo();
                jInfo.getvolumeInfo().put(Integer.toString(sInfo.getvolume_number()), vInfo);

                // 3. Create the journal type and add the journal info
                journalType jType = new journalType();
                jType.getjournalInfo().put(sInfo.getjournalCode(), jInfo);

                // 4. Create subscriptionInfo and add the journal type to the subscription info
                SubscriptionInfo subscriptionInfo = new SubscriptionInfo();
                subscriptionInfo.getjournalType().put(sInfo.getpage_size(), jType);

                // 5. Create subscriberInfo and Add the journal type to the subscriber info
                SubscriberInfo SInfo = new SubscriberInfo();
                SInfo.getSubscriberInfo().put(sInfo.getSubscriptionId(), subscriptionInfo);
                SInfo.setSubscriberLabelInfo(sInfo);

                // 6. Add the subscriber info in the list of subscriber
                subscriber.put(sInfo.getsubscriberNumber(), SInfo);

            }
            // Subscriber exists
            else {
                // Subscriber exists, check if the subscription exists
                if(subInfo.getSubscriberInfo().get(sInfo.getSubscriptionId()) != null) {
                    // Subscription exists, check if the journalType exists
                    if(subInfo.getSubscriberInfo().get(sInfo.getSubscriptionId()).getjournalType().get(sInfo.getpage_size()) != null) {
                        // JournalType exists, now check if the journalInfo exists
                        if(subInfo.getSubscriberInfo().get(sInfo.getSubscriptionId()).getjournalType().get(sInfo.getpage_size()).getjournalInfo().get(sInfo.getjournalCode()) != null) {
                            // JournalInfo exists, now check if the volume number exists
                            if(subInfo.getSubscriberInfo().get(sInfo.getSubscriptionId()).getjournalType().get(sInfo.getpage_size()).getjournalInfo().get(sInfo.getjournalCode()).getvolumeInfo().get(Integer.toString(sInfo.getvolume_number())) != null) {
                                // Volume number exists, check if the issue no crosses either the max or min
                                if(subInfo.getSubscriberInfo().get(sInfo.getSubscriptionId()).getjournalType().get(sInfo.getpage_size()).getjournalInfo().get(sInfo.getjournalCode()).getvolumeInfo().get(Integer.toString(sInfo.getvolume_number())).getEndIssue() < sInfo.getissue()) {
                                    subInfo.getSubscriberInfo().get(sInfo.getSubscriptionId()).getjournalType().get(sInfo.getpage_size()).getjournalInfo().get(sInfo.getjournalCode()).getvolumeInfo().get(Integer.toString(sInfo.getvolume_number())).setEndIssue(sInfo.getissue());
                                }
                                if(subInfo.getSubscriberInfo().get(sInfo.getSubscriptionId()).getjournalType().get(sInfo.getpage_size()).getjournalInfo().get(sInfo.getjournalCode()).getvolumeInfo().get(Integer.toString(sInfo.getvolume_number())).getStartIssue() > sInfo.getissue()) {
                                    subInfo.getSubscriberInfo().get(sInfo.getSubscriptionId()).getjournalType().get(sInfo.getpage_size()).getjournalInfo().get(sInfo.getjournalCode()).getvolumeInfo().get(Integer.toString(sInfo.getvolume_number())).setStartIssue(sInfo.getissue());
                                }
                                subInfo.getSubscriberInfo().get(sInfo.getSubscriptionId()).getjournalType().get(sInfo.getpage_size()).getjournalInfo().get(sInfo.getjournalCode()).getvolumeInfo().get(Integer.toString(sInfo.getvolume_number())).setNo_of_copies(sInfo.getcopies());

                            } else {
                                // volume number does not exist
                                volumeInfo vInfo = new volumeInfo();
                                vInfo.setEndIssue(sInfo.getissue());
                                vInfo.setStartIssue(sInfo.getissue());
                                vInfo.setNo_of_copies(sInfo.getcopies());
                                subInfo.getSubscriberInfo().get(sInfo.getSubscriptionId()).getjournalType().get(sInfo.getpage_size()).getjournalInfo().get(sInfo.getjournalCode()).getvolumeInfo().put(Integer.toString(sInfo.getvolume_number()), vInfo);
                            }

                        } else {
                            // journalInfo does not exist
                            // 1. Create the volume info
                            volumeInfo vInfo = new volumeInfo();
                            vInfo.setEndIssue(sInfo.getissue());
                            vInfo.setStartIssue(sInfo.getissue());
                            vInfo.setNo_of_copies(sInfo.getcopies());

                            // 2. Create the journal info and add the volume info
                            journalInfo jInfo = new journalInfo();
                            jInfo.getvolumeInfo().put(Integer.toString(sInfo.getvolume_number()), vInfo);

                            subInfo.getSubscriberInfo().get(sInfo.getSubscriptionId()).getjournalType().get(sInfo.getpage_size()).getjournalInfo().put(sInfo.getjournalCode(), jInfo);
                        }

                    } else {
                        // Journal Type does not exist
                        // 1. Create the volume info
                        volumeInfo vInfo = new volumeInfo();
                        vInfo.setEndIssue(sInfo.getissue());
                        vInfo.setStartIssue(sInfo.getissue());
                        vInfo.setNo_of_copies(sInfo.getcopies());

                        // 2. Create the journal info and add the volume info
                        journalInfo jInfo = new journalInfo();
                        jInfo.getvolumeInfo().put(Integer.toString(sInfo.getvolume_number()), vInfo);

                        // 3. Create the journal type and add the journal info
                        journalType jType = new journalType();
                        jType.getjournalInfo().put(sInfo.getjournalCode(), jInfo);

                        // 4. Add the journalType to the subscriberInfo
                        subInfo.getSubscriberInfo().get(sInfo.getSubscriptionId()).getjournalType().put(sInfo.getpage_size(), jType);
                    }
                } else {
                    // 1. Create the volume info
                    volumeInfo vInfo = new volumeInfo();
                    vInfo.setEndIssue(sInfo.getissue());
                    vInfo.setStartIssue(sInfo.getissue());
                    vInfo.setNo_of_copies(sInfo.getcopies());

                    // 2. Create the journal info and add the volume info
                    journalInfo jInfo = new journalInfo();
                    jInfo.getvolumeInfo().put(Integer.toString(sInfo.getvolume_number()), vInfo);

                    // 3. Create the journal type and add the journal info
                    journalType jType = new journalType();
                    jType.getjournalInfo().put(sInfo.getjournalCode(), jInfo);

                    // 4. Create subscriptionInfo and add the journal type to the subscription info
                    SubscriptionInfo subscriptionInfo = new SubscriptionInfo();
                    subscriptionInfo.getjournalType().put(sInfo.getpage_size(), jType);

                    // 5. Create subscriberInfo and Add the journal type to the subscriber info
                    subInfo.getSubscriberInfo().put(sInfo.getSubscriptionId(), subscriptionInfo);
                }
            }
        }

        //Now extract the labels
        Iterator subscriberIterator = subscriber.entrySet().iterator();

        // Loop over subscribers
        while(subscriberIterator.hasNext())
        {
            Map.Entry pairs1 = (Map.Entry)subscriberIterator.next();
            String subscriberNumber = pairs1.getKey().toString();
            SubscriberInfo sInfo = (SubscriberInfo)pairs1.getValue();

            subInfo sLabelInfo = sInfo.getSubscriberLabelInfo();

            Iterator subscriberInfoIter = sInfo.getSubscriberInfo().entrySet().iterator();

            // Loop over subscriberInfo
            while(subscriberInfoIter.hasNext()) {
                Map.Entry pairs2 = (Map.Entry)subscriberInfoIter.next();
                String SubscriptionId = pairs2.getKey().toString();
                SubscriptionInfo subscriptionInfo = (SubscriptionInfo)pairs2.getValue();

                Iterator SubscriptionInfoIter = subscriptionInfo.getjournalType().entrySet().iterator();

                ArrayList<String> labels = new ArrayList<String>();

                // Loop over subscriptionInfo, i.e loop over each subscription of a subscriber
                while(SubscriptionInfoIter.hasNext()) {
                    Map.Entry pairs3 = (Map.Entry)SubscriptionInfoIter.next();
                    String journalType = pairs3.getKey().toString();
                    journalType jType = (journalType)pairs3.getValue();

                    Iterator journalTypeIter = jType.getjournalInfo().entrySet().iterator();

                    String label="";
                    // Loop over journalType i.e loop over journals of certain page type
                    while(journalTypeIter.hasNext()) {
                        Map.Entry pairs4 = (Map.Entry)journalTypeIter.next();
                        String journalCode = pairs4.getKey().toString();
                        journalInfo jInfo = (journalInfo)pairs4.getValue();

                        Iterator journalInfoIter1 = jInfo.getvolumeInfo().entrySet().iterator();
                        // get the no of elements
                        int highestVolumeNo=0;
                        while(journalInfoIter1.hasNext()) {
                            Map.Entry pairs5Temp = (Map.Entry)journalInfoIter1.next();
                            String volume_number = pairs5Temp.getKey().toString();
                            if(Integer.parseInt(volume_number) > highestVolumeNo) {
                                highestVolumeNo = Integer.parseInt(volume_number);
                            }
                        }
                        Iterator journalInfoIter = jInfo.getvolumeInfo().entrySet().iterator();

                        // Loop over journalInfo, i.e loop over volume_number
                        while(journalInfoIter.hasNext()) {
                            Map.Entry pairs5 = (Map.Entry)journalInfoIter.next();
                            String volume_number = pairs5.getKey().toString();
                            volumeInfo vInfo = (volumeInfo)pairs5.getValue();
                            int startIssue = vInfo.getStartIssue();
                            int endIssue = vInfo.getEndIssue();
                            int no_of_copies = vInfo.getNo_of_copies();

                            // If this is the last volume and for the select journal check if there are more than 1 issue
                            if(Integer.parseInt(volume_number) == highestVolumeNo &&
                            (separateOutLatestIssue && journalCode.equals("P") && startIssue < endIssue ||
                             separateOutLatestIssue && journalCode.equals("RES") && startIssue < endIssue ||
                             separateOutLatestIssue && journalCode.equals("CURR") && startIssue < endIssue)) {

                                String labelSeparate = createLabel(journalCode, volume_number, endIssue, endIssue, no_of_copies);
                                labels.add(labelSeparate);

                                endIssue = endIssue - 1;
                            }

                            label = label + createLabel(journalCode, volume_number, startIssue, endIssue, no_of_copies);
                        }
                    }
                    //Paragraph p = prepareBILLabelPDFContent(sLabelInfo, label);
                    //BILlabels.add(p);
                    labels.add(label);
                }

                for(int i=0; i < labels.size(); i++){
                    String label = labels.get(i);
                    Paragraph p = prepareBILLabelPDFContent(sLabelInfo, label);
                    BILlabels.add(p);
                }
            }
        }
    }

    public String createLabel(String journalCode, String volume_number, int startIssue, int endIssue, int no_of_copies){

        String label="";
        label = label + journalCode;
        label = label + "/" + volume_number;

        // Add information about issues
        String issue;
        // If start and end issue are same, then only mention startissue no
        if(startIssue == endIssue) {
            issue = "/" +  startIssue;
        } else {
            issue = "/" + startIssue + "-" + endIssue;
        }
        label = label + issue;

        //Add information about no of copies
        String noOfCopies;
        if(no_of_copies == 1) {
            noOfCopies = "";
        } else {
            noOfCopies = "(" + no_of_copies + ")";
        }
        label = label + noOfCopies + " ";

        return(label);
    }

    public Paragraph prepareBILLabelPDFContent(subInfo sLabelInfo, String bilLabel) {
        Paragraph info = null;

        info = new Paragraph();
        info.setLeading(lfixedLeading, lmultipliedLeadingPlus);
        info.setAlignment(textAlignment);

        Font font;
        font = new Font(sfontType, sfontSizeHeader-1, sfontStyle, BaseColor.BLACK);
        info.add(new Chunk(bilLabel, font));
        info.add(Chunk.NEWLINE);

        font = new Font(sfontType, sfontSize, sfontStyle, BaseColor.BLACK);
        String firstLine = sLabelInfo.getsubscriberName() + " " + sLabelInfo.getsubscriberNumber();
        // + " " + sLabelInfo.getjournalCode();

        //if(!noHeader){

            //if(sLabelInfo.getcopies() > 1){
            //    firstLine = firstLine + " " + sLabelInfo.getcopies();
            //}

            //firstLine = firstLine + " " + sLabelInfo.getsubtypecode();

            //if(sLabelInfo.equals("Paid")) {
            //    firstLine = firstLine + " " + sLabelInfo.getstartDate()+
            //        " " + "to" +
            //        " " + sLabelInfo.getendDate();
            //}
            info.add(new Chunk(firstLine, font));
            info.add(Chunk.NEWLINE);
        //}

        //info.add(new Chunk(sLabelInfo.getsubscriberName(), font));
        //info.add(Chunk.NEWLINE);
        info.add(new Chunk(sLabelInfo.getdepartment(), font));
        info.add(Chunk.NEWLINE);
        info.add(new Chunk(sLabelInfo.getinstitution(), font));
        info.add(Chunk.NEWLINE);
        info.add(new Chunk(sLabelInfo.getaddress(), font));
        info.add(Chunk.NEWLINE);
        font = new Font(sfontType, sfontSize, Font.BOLD);
        String lastLine = sLabelInfo.getcity() +
                " " + sLabelInfo.getpincode() +
                " " + sLabelInfo.getstate() +
                " ";
        if(!sLabelInfo.getcountry().equals("India")){
            lastLine = lastLine + sLabelInfo.getcountry();
        }

        info.add(new Chunk(lastLine, font));

        return info;

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

        Iterator bilLabelIter = BILlabels.iterator();

        while(true)
        {
            for (int i=1, k=0; i<=stickerRows; i++)
            {
                for (int r=1; r<=stickerColumns; r++, k++)
                {
                    // Get the content
                    Paragraph info = null;
                    if(backIssue){
                        if(bilLabelIter.hasNext()) {
                            info = (Paragraph)bilLabelIter.next();
                        }
                    }else {
                        info = getStickerContent(rs);
                    }
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

    public Paragraph getFooterForLabel() {
        Paragraph info;
        info = new Paragraph();
        info.setLeading(lfixedLeading, lmultipliedLeading);
        info.setAlignment(textAlignment);

        Font font = new Font(lfontType, lfontSizeHeader, Font.ITALIC);
        info.add(new Chunk("If undelivered please return to:", font));
        info.add(Chunk.NEWLINE);
        font = new Font(lfontType, lfontSizeHeader, Font.BOLD);
        info.add(new Chunk("Indian Academy of Sciences", font));
        font = new Font(lfontType, lfontSizeHeader, lfontStyle, BaseColor.BLACK);
        info.add(Chunk.NEWLINE);
        info.add(new Chunk("P.B. No.8005, C V Raman Avenue", font));
        info.add(Chunk.NEWLINE);
        info.add(new Chunk("Bangalore 560 080, INDIA.", font));

        return info;
    }

    public Paragraph getPERIODICAL() {
        Paragraph info;
        info = new Paragraph();
        info.setLeading(lfixedLeading, lmultipliedLeading);
        info.setAlignment(textAlignment);

        Font font = new Font(lfontType, lfontSizeHeader, lfontStyle, BaseColor.BLACK);
        info.add(new Chunk("P E R I O D I C A L S", font));
        info.add(Chunk.NEWLINE);

        return info;
    }

    public Paragraph getSerialNo(int slNo) {
        Paragraph info;
        info = new Paragraph();
        info.setLeading(lfixedLeading, lmultipliedLeading);
        info.setAlignment(textAlignment);

        Font font = new Font(lfontType, lfontSizeHeader, lfontStyle, BaseColor.BLACK);
        info.add(new Chunk("S.l. No. " + Integer.toString(slNo), font));
        info.add(Chunk.NEWLINE);

        return info;
    }

    public Paragraph getLabelContent(ResultSet rs) throws SQLException
    {
        /*
        String subscriberNumber = null, journalCode = null, subtypecode = null, startDate = null, endDate = null;
        String subscriberName   = null, department = null, institution = null, address = null;
        String city             = null, pincode = null, state = null, country = null;
        String startYear=null, startMonth=null, endYear=null, endMonth=null;
        String subType=null; int copies = 0;
        */

        Paragraph info = null;

        if(rs.next())
        {
            subInfo sLabelInfo = new subInfo(rs);

            info = new Paragraph();
            info.setLeading(lfixedLeading, lmultipliedLeadingPlus);
            info.setAlignment(ltextAlignment);

            Font font;

            if(!noHeader){
                font = new Font(lfontType, lfontSizeHeader, lfontStyle, BaseColor.BLACK);
                String firstLine = sLabelInfo.getsubscriberNumber() + " " + sLabelInfo.getjournalCode();

                if(sLabelInfo.getcopies() > 1){
                    firstLine = firstLine + " " + sLabelInfo.getcopies();
                }

                firstLine = firstLine + " " + sLabelInfo.getsubtypecode();

                if(sLabelInfo.getsubType().equals("Paid")) {
                    firstLine = firstLine + " " + sLabelInfo.getstartDate() +
                        " " + "to" +
                        " " + sLabelInfo.getendDate();
                }
                if(!firstLine.isEmpty()) {
                    info.add(new Chunk(firstLine, font));
                    info.add(Chunk.NEWLINE);
                }
            }
            font = new Font(lfontType, lfontSize, lfontStyle, BaseColor.BLACK);
            if(!sLabelInfo.getsubscriberName().isEmpty()) {
                info.add(new Chunk(sLabelInfo.getsubscriberName(), font));
                info.add(Chunk.NEWLINE);
            }
            if(!sLabelInfo.getdepartment().isEmpty()) {
                info.add(new Chunk(sLabelInfo.getdepartment(), font));
                info.add(Chunk.NEWLINE);
            }
            if(!sLabelInfo.getinstitution().isEmpty()) {
                info.add(new Chunk(sLabelInfo.getinstitution(), font));
                info.add(Chunk.NEWLINE);
            }
            if(!sLabelInfo.getaddress().isEmpty()) {
                info.add(new Chunk(sLabelInfo.getaddress(), font));
                info.add(Chunk.NEWLINE);
            }
            font = new Font(lfontType, lfontSize, Font.BOLD);
            /*String lastLine = sLabelInfo.getcity() +
                    " " + sLabelInfo.getpincode() +
                    " " + sLabelInfo.getstate() +
                    " ";
            */
            String lastLine = "";
            if(!sLabelInfo.getcity().isEmpty()) {
                lastLine = lastLine + sLabelInfo.getcity();
            }
            if(sLabelInfo.getcity().isEmpty()) {
                lastLine = lastLine + sLabelInfo.getpincode();
            } else {
                lastLine = lastLine + " " + sLabelInfo.getpincode();
            }
            if(sLabelInfo.getpincode().isEmpty()){
                lastLine = lastLine + sLabelInfo.getstate();
            } else {
                lastLine = lastLine + " " + sLabelInfo.getstate();
            }
            
            String country = "";
            if(!sLabelInfo.getcountry().equals("India")){
                country = sLabelInfo.getcountry();
            }            
            
            if(sLabelInfo.getstate().isEmpty()){
                lastLine = lastLine + country;
            } else {
                lastLine = lastLine + " " + country;
            }
                
            if(!lastLine.isEmpty()) {
                lastLine = lastLine.trim();
                // Remove the leading spaces
                //lastLine.replaceAll("^\\s+", "");
                info.add(new Chunk(lastLine, font));
            }
        }
        return info;
    }

    public Paragraph getStickerContent(ResultSet rs) throws SQLException
    {
        /*
        String subscriberNumber = null, journalCode = null, subtypecode = null, startDate = null, endDate = null;
        String subscriberName   = null, department = null, institution = null, address = null;
        String city             = null, pincode = null, state = null, country = null;
        String startYear=null, startMonth=null, endYear=null, endMonth=null;
        String subType=null; int copies = 0;
        */

        Paragraph info = null;

        if(rs.next())
        {
            subInfo sLabelInfo = new subInfo(rs);

            info = new Paragraph();
            info.setLeading(leading);
            info.setAlignment(textAlignment);

            Font font;
            if(!noHeader){
                font = new Font(sfontType, sfontSizeHeader, sfontStyle, BaseColor.BLACK);
                String firstLine = sLabelInfo.getsubscriberNumber() + " " + sLabelInfo.getjournalCode();

                if(sLabelInfo.getcopies() > 1){
                    firstLine = firstLine + " " + sLabelInfo.getcopies();
                }

                firstLine = firstLine + " " + sLabelInfo.getsubtypecode();

                if(sLabelInfo.equals("Paid")) {
                    firstLine = firstLine + " " + sLabelInfo.getstartDate()+
                        " " + "to" +
                        " " + sLabelInfo.getendDate();
                }
                if(!firstLine.isEmpty()) {
                    info.add(new Chunk(firstLine, font));
                    info.add(Chunk.NEWLINE);
                }
            }
            font = new Font(sfontType, sfontSize, sfontStyle, BaseColor.BLACK);
            if(!sLabelInfo.getsubscriberName().isEmpty()) {
                info.add(new Chunk(sLabelInfo.getsubscriberName(), font));
                info.add(Chunk.NEWLINE);
            }
            if(!sLabelInfo.getdepartment().isEmpty()) {
                info.add(new Chunk(sLabelInfo.getdepartment(), font));
                info.add(Chunk.NEWLINE);                
            }
            if(!sLabelInfo.getinstitution().isEmpty()) {
                info.add(new Chunk(sLabelInfo.getinstitution(), font));
                info.add(Chunk.NEWLINE);                
            }
            if(!sLabelInfo.getaddress().isEmpty()) {
                info.add(new Chunk(sLabelInfo.getaddress(), font));
                info.add(Chunk.NEWLINE);                
            }
            /*
            String address = sLabelInfo.getaddress();
            if(!(address.isEmpty())){
                info.add(new Chunk(address, font));
            }else{
                System.out.println("Detected address which is empty or null");
            }*/

            font = new Font(sfontType, sfontSize, Font.BOLD);
            /*
            String lastLine = sLabelInfo.getcity() +
                    " " + sLabelInfo.getpincode() +
                    " " + sLabelInfo.getstate() +
                    " ";
            */ 
            String lastLine = "";
            if(!sLabelInfo.getcity().isEmpty()) {
                lastLine = lastLine + sLabelInfo.getcity();
            }
            if(sLabelInfo.getcity().isEmpty()) {
                lastLine = lastLine + sLabelInfo.getpincode();
            } else {
                lastLine = lastLine + " " + sLabelInfo.getpincode();
            }
            if(sLabelInfo.getpincode().isEmpty()){
                lastLine = lastLine + sLabelInfo.getstate();
            } else {
                lastLine = lastLine + " " + sLabelInfo.getstate();
            }
            
            String country = "";
            if(!sLabelInfo.getcountry().equals("India")){
                country = sLabelInfo.getcountry();
            }            
            
            if(sLabelInfo.getstate().isEmpty()){
                lastLine = lastLine + country;
            } else {
                lastLine = lastLine + " " + country;
            }
                
            if(!lastLine.isEmpty()) {
                lastLine = lastLine.trim();
                // Remove the leading spaces
                //lastLine.replaceAll("^\\s+", "");
                info.add(new Chunk(lastLine, font));
            }
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

    public Paragraph addShippingAddress()
    {

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

    */
    /*
    public ByteArrayOutputStream reminderType2(subscriberInfo sinfo) throws DocumentException, IOException {

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
        addInitialBody(cb, curX, curY, deltaX, sinfo);

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
        addJournals(cb, sinfo);
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
    */
    /*
    // This contains the subNo, date, invoice address and shipping address
    public void addInitialBody(PdfContentByte cb, float curX, float curY, float deltaX, subscriberInfo sinfo)
    {
        // 3. Add the subscriber Id
        cb.beginText();
        cb.moveText(curX, curY);
        addSubscriberId(cb, sinfo);
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
         cb.newlineText();

        // 5. Add the shipping address
        cb.beginText();
        cb.newlineText();
        cb.moveText(curX + deltaX, curY);
        addShippingAddress(cb, sinfo);
        cb.endText();

        // 6. Add the mailing address
        cb.beginText();
        cb.newlineText();
        cb.moveText(curX, curY);
        addInvoiceAddress(cb, sinfo);
        cb.endText();
    }
    */
    /*
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
    */
    /*
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

    public void addSubscriberId(PdfContentByte cb, subscriberInfo s)
    {
        String template = "SUB.NO. ";
        //String subscriberId = "3962";
        String subscriberNumber = s.getSubscriberNumber();
        cb.showText(template + subscriberNumber);
    }

    */
    /*
    public void addShippingAddress(PdfContentByte cb, subscriberInfo sinfo)
    {

        cb.showText("SHIPPING ADDRESS");
        cb.newlineShowText("----------------------");

        //cb.newlineShowText(subscriberName);
        //cb.newlineShowText(department);
        //cb.newlineShowText(institution);
        //cb.newlineShowText(s_address);

        cb.newlineShowText(sinfo.getSubscriberName());
        cb.newlineShowText(sinfo.getDepartment());
        cb.newlineShowText(sinfo.getInstitution());
        cb.newlineShowText(sinfo.getShippingAddress());


        //String lastLine = city +
        //        " " + pincode +
        //        " " + state +
        //        " " + country;

        String lastLine = sinfo.getCity() +
                " " + sinfo.getPincode() +
                " " + sinfo.getState() +
                " " + sinfo.getCountry();

        cb.newlineShowText(lastLine);
    }

    public void addInvoiceAddress(PdfContentByte cb, subscriberInfo sinfo)
    {
        cb.showText("Invoice ADDRESS");
        //cb.newlineShowText("===============");
        cb.newlineShowText("--------------------");
        cb.newlineShowText(sinfo.getSubscriberName());
        cb.newlineShowText(sinfo.getDepartment());
        cb.newlineShowText(sinfo.getInstitution());
        cb.newlineShowText(sinfo.getInvoiceAddress());

        String lastLine = sinfo.getCity() +
                " " + sinfo.getPincode() +
                " " + sinfo.getState() +
                " " + sinfo.getCountry();

        cb.newlineShowText(lastLine);
    }
    */
    /*
    public ByteArrayOutputStream reminderType(List<subscriberInfo> sinfo) throws DocumentException, IOException, ParserConfigurationException, SAXException{
        //Parse the xml here and decide which reminder function to be called

        String xml = "";
        //int reminderType = sinfo.getReminderType();

        if(reminderType == 1){
            ByteArrayOutputStream outputStream = reminderType1(sinfo);
            return outputStream;
        }else if(reminderType == 2) {
            ByteArrayOutputStream outputStream = reminderType2(sinfo);
            return outputStream;
        }else if(reminderType == 3) {
            ByteArrayOutputStream outputStream = reminderType2(sinfo);
            return outputStream;
        }
        return null;
    }
    */


}


