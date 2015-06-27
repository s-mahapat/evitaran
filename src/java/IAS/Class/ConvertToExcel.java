/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.*;
import java.util.ArrayList;
import java.util.Iterator;
import javax.xml.parsers.ParserConfigurationException;
import org.apache.poi.xssf.usermodel.*;
import org.xml.sax.SAXException;

/**
 *
 * @author aloko
 */
public class ConvertToExcel {

    private XSSFWorkbook workbook;
    private XSSFSheet sheet;
    private XSSFFont boldFont;
    private ResultSet resultSet;
    private ResultSetMetaData resultSetMetaData;
    private String[] formatTypes;
    private String xml;
    boolean noHeader = false;
    boolean periodicals = false;
    boolean separateLabelForP= false;
    boolean separateLabelForRES= false;
    boolean separateLabelForCURR= false;
    boolean backIssue = false;    
    ArrayList BILlabels = new ArrayList();

    public ConvertToExcel(ResultSet rs, String sheetName) throws SQLException {
        //throw new UnsupportedOperationException("Not yet implemented");
        workbook = new XSSFWorkbook();
        //sheet = workbook.createSheet("sheetName");
        sheet = workbook.createSheet(sheetName);
        boldFont = workbook.createFont();
        boldFont.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
        this.resultSet = rs;

        this.resultSetMetaData = resultSet.getMetaData();
    }
    
    public ConvertToExcel(String xml, String sheetName) throws SQLException {
        //throw new UnsupportedOperationException("Not yet implemented");
        workbook = new XSSFWorkbook();
        //sheet = workbook.createSheet("sheetName");
        sheet = workbook.createSheet(sheetName);
        boldFont = workbook.createFont();
        boldFont.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
        this.xml = xml;

    }  
    
    public ConvertToExcel(String sheetName, String _noHeader, String _periodicals) throws SQLException {
        
        super();
        
        //throw new UnsupportedOperationException("Not yet implemented");
        workbook = new XSSFWorkbook();
        //sheet = workbook.createSheet("sheetName");
        sheet = workbook.createSheet(sheetName);
        boldFont = workbook.createFont();
        boldFont.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
        
        if(_noHeader!= null && _noHeader.equals("on")){
            noHeader    = true;
        }
        if(_periodicals!= null && _periodicals.equals("on")){
            periodicals = true;
        }

    }    
    
    public ConvertToExcel(String sheetName, String _noHeader, String _periodicals, String _separateLabelForP, String _separateLabelForRES, String _separateLabelForCURR, boolean _backIssue){
        super();
        
        workbook = new XSSFWorkbook();
        //sheet = workbook.createSheet("sheetName");
        sheet = workbook.createSheet(sheetName);
        boldFont = workbook.createFont();
        boldFont.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);        
        
        if(_noHeader!= null && _noHeader.equals("on")){
            noHeader    = true;
        }
        if(_periodicals!= null && _periodicals.equals("on")){
            periodicals = true;
        }
        if(_separateLabelForP!= null && _separateLabelForP.equals("on")){
            separateLabelForP = true;
        }
        if(_separateLabelForRES!= null && _separateLabelForRES.equals("on")){
            separateLabelForRES = true;
        }
        if(_separateLabelForCURR!= null && _separateLabelForCURR.equals("on")){
            separateLabelForCURR = true;
        }        
        backIssue = _backIssue;
    }    
    
    public void generateFromXML(OutputStream out) throws SQLException, IOException, ParserConfigurationException, SAXException
    {
        int currentRow = 0;
        XSSFRow row = sheet.createRow(currentRow);
        int numCols = util.getColCount(xml);

        formatTypes = new String[numCols];

        //First row which has all the headings
        for (int i = 0; i < numCols; i++) {

            String title = util.getColNames(xml, 0, i);
            //writeCell(row, i, title, excelType, boldFont);
            writeCell(row, i, title, "CELL_TYPE_STRING", boldFont);
        }

        currentRow++;

        // Write report rows
        for (int j = 0; j < util.getRowCount(xml); j++) {
            row = sheet.createRow(currentRow++);

            for (int i = 0; i < numCols; i++) {
                String value = util.getColValue(xml, j, i);    
                writeCell(row, i, value, "CELL_TYPE_STRING");
            }
        }
        
      // Autosize columns
      int width = 7;
      for (int i = 0; i < numCols; i++) {
            //sheet.setColumnWidth(i, width);
            //sheet.setColumnHidden(i, false);
            sheet.autoSizeColumn((short)i);
      }

      //OutputStream  op = new OutputStream();
      //OutputStream op = new FileOutputStream(new File("IBT.xlsx"));
      workbook.write(out);

        //return op.toString();
    }    

    public void generateFromResultSet(OutputStream out) throws SQLException, IOException
    {
        int currentRow = 0;
        XSSFRow row = sheet.createRow(currentRow);
        int numCols = resultSetMetaData.getColumnCount();

        formatTypes = new String[numCols];

        //First row which has all the headings
        for (int i = 0; i < numCols; i++) {
            String title = resultSetMetaData.getColumnName(i + 1);
            //int JDBCType = util.getColTypes(resultSetMetaData, i + 1);
            //String excelType = mapJDBCTypeToExcelType(JDBCType);
            //writeCell(row, i, title, excelType, boldFont);
            writeCell(row, i, title, "CELL_TYPE_STRING", boldFont);
            //formatTypes[i] = excelType;
        }

        currentRow++;

        // Write report rows
        while (resultSet.next()) {
            row = sheet.createRow(currentRow++);

            for (int i = 0; i < numCols; i++) {
                Object value = resultSet.getObject(i + 1);
                //int JDBCType = util.getColTypes(resultSet.getMetaData(), i + 1);
                //String excelType = mapJDBCTypeToExcelType(JDBCType);
                //writeCell(row, i, value, excelType);
                //writeCell(row, i, value, formatTypes[i]);
                if(value == null){
                    value = "";
                }
                writeCell(row, i, value, "CELL_TYPE_STRING");
            }
        }

      // Autosize columns
      int width = 7;
      for (int i = 0; i < numCols; i++) {
            //sheet.setColumnWidth(i, width);
            //sheet.setColumnHidden(i, false);
            sheet.autoSizeColumn((short)i);
      }
      

      //OutputStream  op = new OutputStream();
      //OutputStream op = new FileOutputStream(new File("IBT.xlsx"));
      
        
      sheet.autoSizeColumn(0);
      workbook.write(out);

        //return op.toString();
    }

    public void generateFromArrayList(OutputStream out, ArrayList<String> labels) throws SQLException, IOException, ParserConfigurationException, SAXException
    {
        int currentRow = 0;
        XSSFRow row = sheet.createRow(currentRow);
        //int numCols = util.getColCount(xml);
        int numCols = 1;

        formatTypes = new String[numCols];
        
        writeCell(row, 0, "Labels", "CELL_TYPE_STRING", boldFont);

        currentRow++;

        // Write report rows
        Iterator itr = labels.listIterator();
        while (itr.hasNext()){
            row = sheet.createRow(currentRow++);
            String value = (String)itr.next();
            
            //Cell cell = row.createCell(0);          
            //CellStyle style = workbook.createCellStyle(); //Create new style
            //style.setWrapText(true); //Set wordwrap
            //cell.setCellStyle(style); //Apply style to cell
            writeCell(row, 0, value, "CELL_TYPE_STRING");
        }
        
        sheet.autoSizeColumn((short)0);

        workbook.write(out);

    }        
    
    // This is a same code as in convertToPdf->getLabelContent() stripped off the pdf generation code
    public ArrayList<String> getLabelContentExportToExcel(ResultSet rs) throws SQLException
    {
        ArrayList<String> labels = new ArrayList<>();

        while(rs.next())
        {
            CreateLabels label = new CreateLabels(rs, noHeader);

            String firstLine = label.getFirstLine();
            if(!firstLine.isEmpty()) {
                firstLine = firstLine + "\n";
            }            
            
            String subscriberName = label.getSubscriberName();
            if(!subscriberName.isEmpty()) {
                subscriberName = subscriberName + "\n";
            }
            
            String department = label.getDepartment();
            if(!department.isEmpty()) {
                department = department + "\n";
            }
            
            String institution = label.getInstitution();
            if(!institution.isEmpty()) {
                institution = institution + "\n";
            }

            String address = label.getAddress();
            if(!address.isEmpty()) {
                address = address + "\n";
            }

            String lastLine = label.getLastLine();
            
            labels.add(firstLine + subscriberName + department + institution + address + lastLine);
        }
        return labels;
    }
    
    
    private void writeCell(XSSFRow row, int col, Object value, String formatType)  {
    writeCell(row, col, value, formatType, null, null);
    }

    private void writeCell(XSSFRow row, int col, Object value, String formatType, XSSFFont font)  {
    writeCell(row, col, value, formatType, null, font);
    }

    private void writeCell(XSSFRow row, int col, Object value, String cellFormatTypes,
                         Short bgColor, XSSFFont font)  {

        //XSSFCell cell = XSSFCellUtil.createCell(row, col, null);
        XSSFCell cell = row.createCell(col);
        if (value == null) {
          return;
        }

        XSSFCellStyle style = workbook.createCellStyle();
        style.setWrapText(true); //Set wordwrap
        if (font != null) {
          style.setFont(font);
        }
        cell.setCellStyle(style);        
        
        switch (cellFormatTypes) {
            case "CELL_TYPE_STRING":
                cell.setCellValue(value.toString());
                break;
            case "CELL_TYPE_NUMERIC":
                //cell.setCellValue(((Number) value).intValue());
                cell.setCellValue(Integer.parseInt(value.toString()));
                //cell.setCellValue((value.toString()));
                //cell.setCellStyleProperty(cell, workbook, XSSFCellUtil.DATA_FORMAT, XSSFDataFormat.getBuiltinFormat(("#,##0")));
                break;
            case "CELL_TYPE_FLOAT":
                cell.setCellValue(((Number) value).doubleValue());
                //XSSFCellUtil.setCellStyleProperty(cell, workbook, XSSFCellUtil.DATA_FORMAT, XSSFDataFormat.getBuiltinFormat(("#,##0.00")));
                break;
            case "CELL_TYPE_DATE":
                cell.setCellValue((Timestamp) value);
                //XSSFCellUtil.setCellStyleProperty(cell, workbook, XSSFCellUtil.DATA_FORMAT, XSSFDataFormat.getBuiltinFormat(("m/d/yy")));
                break;
            case "CELL_TYPE_MONEY":
                cell.setCellValue(((Number) value).intValue());
                //XSSFCellUtil.setCellStyleProperty(cell, workbook, XSSFCellUtil.DATA_FORMAT, format.getFormat("($#,##0.00);($#,##0.00)"));
                break;
            case "CELL_TYPE_PERCENTAGE":
                cell.setCellValue(((Number) value).doubleValue());
                //XSSFCellUtil.setCellStyleProperty(cell, workbook, XSSFCellUtil.DATA_FORMAT, XSSFDataFormat.getBuiltinFormat("0.00%"));
                break;

            case "CELL_TYPE_BLANK":
                cell.setCellValue(value.toString());
                //XSSFCellUtil.setCellStyleProperty(cell, workbook, XSSFCellUtil.DATA_FORMAT, XSSFDataFormat.getBuiltinFormat("0.00%"));
                break;
        }

        if (bgColor != null) {
          //XSSFCellUtil.setCellStyleProperty(cell, workbook, XSSFCellUtil.FILL_FOREGROUND_COLOR, bgColor);
          //XSSFCellUtil.setCellStyleProperty(cell, workbook, XSSFCellUtil.FILL_PATTERN, XSSFCellStyle.SOLID_FOREGROUND);
        }
    }

    private String mapJDBCTypeToExcelType(int JDBCType)
    {
        switch (JDBCType)
        {
            case (-7): //System.out.println("BIT,         JAVA type BOOLEAN   CELL_TYPE_BOOLEAN");
                return("Cell.CELL_TYPE_STRING");
            case (-6): //System.out.println("TINYINT,     JAVA type BYTE");
                return("CELL_TYPE_NUMERIC");
            case (-5): //System.out.println("BIGINT,      JAVA type LONGINT");
                return("CELL_TYPE_NUMERIC");
            case (-4): //System.out.println("LONGVARBINARY, JAVA type byte[]");
                return("CELL_TYPE_STRING");
            case (-3): //System.out.println("VARBINARY,   JAVA type byte[]");
                return("CELL_TYPE_STRING");
            case (-2): //System.out.println("BINARY,      JAVA type byte[]");
                return("CELL_TYPE_STRING");
            case (-1): //System.out.println("LONGVARCHAR, JAVA type STRING");
                return("CELL_TYPE_STRING");
            case (0): //System.out.println("NULL");
                return("CELL_TYPE_BLANK");
            case (1): //System.out.println("CHAR,         JAVA type STRING");
                return("CELL_TYPE_STRING");
            case (2): //System.out.println("NUMERIC,      JAVA type java.math.BigDecimal");
                return("CELL_TYPE_NUMERIC");
            case (3): //System.out.println("DECIMAL,      JAVA type java.math.BigDecimal");
                return("CELL_TYPE_NUMERIC");
            case (4): //System.out.println("INTEGER,      JAVA type INT");
                return("CELL_TYPE_NUMERIC");
            case (5): //System.out.println("SMALLINT,     JAVA type SHORT");
                return("CELL_TYPE_NUMERIC");
            case (6): //System.out.println("FLOAT,        JAVA type DOUBLE");
                return("CELL_TYPE_NUMERIC");
            case (7): //System.out.println("REAL,         JAVA type FLOAT");
                return("CELL_TYPE_NUMERIC");
            case (8): //System.out.println("DOUBLE,       JAVA type DOUBLE");
                return("CELL_TYPE_NUMERIC");
            case (12): //System.out.println("VARCHAR,     JAVA type STRING");
                return("CELL_TYPE_STRING");
            case (91): //System.out.println("DATE,        JAVA type java.sql.Date");
                return("CELL_TYPE_STRING");
            case (92): //System.out.println("TIME,        JAVA type java.sql.Time");
                return("CELL_TYPE_STRING");
            case (93): //System.out.println("TIMESTAMP,   JAVA type java.sql.Timestamp");
                return("CELL_TYPE_STRING");
            case (111): //System.out.println("OTHER");
                return("CELL_TYPE_STRING");
            default: //System.out.println("UNKNOWN type found");
                throw new IllegalStateException("UNKNOWN JDBC type found. No matching excel cell type found");
        }
    }

    /*
    private String mapJDBCTypeToExcelType(int JDBCType)
    {
        switch (JDBCType)
        {
            case (-7): //System.out.println("BIT,         JAVA type BOOLEAN   CELL_TYPE_BOOLEAN");
                return("CELL_TYPE_STRING");
            case (-6): //System.out.println("TINYINT,     JAVA type BYTE");
                return("CELL_TYPE_NUMERIC");
            case (-5): //System.out.println("BIGINT,      JAVA type LONGINT");
                return("CELL_TYPE_NUMERIC");
            case (-4): //System.out.println("LONGVARBINARY, JAVA type byte[]");
                return("CELL_TYPE_STRING");
            case (-3): //System.out.println("VARBINARY,   JAVA type byte[]");
                return("CELL_TYPE_STRING");
            case (-2): //System.out.println("BINARY,      JAVA type byte[]");
                return("CELL_TYPE_STRING");
            case (-1): //System.out.println("LONGVARCHAR, JAVA type STRING");
                return("CELL_TYPE_STRING");
            case (0): //System.out.println("NULL");
                return("CELL_TYPE_BLANK");
            case (1): //System.out.println("CHAR,         JAVA type STRING");
                return("CELL_TYPE_STRING");
            case (2): //System.out.println("NUMERIC,      JAVA type java.math.BigDecimal");
                return("CELL_TYPE_NUMERIC");
            case (3): //System.out.println("DECIMAL,      JAVA type java.math.BigDecimal");
                return("CELL_TYPE_NUMERIC");
            case (4): //System.out.println("INTEGER,      JAVA type INT");
                return("CELL_TYPE_NUMERIC");
            case (5): //System.out.println("SMALLINT,     JAVA type SHORT");
                return("CELL_TYPE_NUMERIC");
            case (6): //System.out.println("FLOAT,        JAVA type DOUBLE");
                return("CELL_TYPE_NUMERIC");
            case (7): //System.out.println("REAL,         JAVA type FLOAT");
                return("CELL_TYPE_NUMERIC");
            case (8): //System.out.println("DOUBLE,       JAVA type DOUBLE");
                return("CELL_TYPE_NUMERIC");
            case (12): //System.out.println("VARCHAR,     JAVA type STRING");
                return("CELL_TYPE_STRING");
            case (91): //System.out.println("DATE,        JAVA type java.sql.Date");
                return("CELL_TYPE_STRING");
            case (92): //System.out.println("TIME,        JAVA type java.sql.Time");
                return("CELL_TYPE_STRING");
            case (93): //System.out.println("TIMESTAMP,   JAVA type java.sql.Timestamp");
                return("CELL_TYPE_STRING");
            case (111): //System.out.println("OTHER");
                return("CELL_TYPE_STRING");
            default: //System.out.println("UNKNOWN type found");
                throw new IllegalStateException("UNKNOWN JDBC type found. No matching excel cell type found");
        }
    }
     */

  public enum cellFormatTypes {
    CELL_TYPE_STRING,
    CELL_TYPE_INTEGER,
    CELL_TYPE_FLOAT,
    CELL_TYPE_DATE,
    CELL_TYPE_MONEY,
    CELL_TYPE_PERCENTAGE
  }
}
