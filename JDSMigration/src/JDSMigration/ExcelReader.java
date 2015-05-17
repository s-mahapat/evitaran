/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package JDSMigration;

import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;
import jxl.*;
import jxl.read.biff.BiffException;

public class ExcelReader {

    private FileInputStream fis = null;
    private int workSheetNumber = 0;
    private Sheet s = null;
    private Workbook workbook = null;
    private int rowCount = 0;
    private int columnCount = 0;
    private int currentRow = 1;

    public ExcelReader(String filePath, int sheetNo) throws FileNotFoundException, IOException, BiffException {
        fis = new FileInputStream(new File(filePath));
        workSheetNumber = sheetNo;
        WorkbookSettings ws = new WorkbookSettings();
        workbook = Workbook.getWorkbook(fis, ws);
        //Getting Sheet
        s = workbook.getSheet(workSheetNumber);
        rowCount = s.getRows();
        columnCount = s.getColumns();
    }

    public String[] getNextRow() throws IOException, BiffException {

        String[] Data = new String[columnCount];
        for(int i=0; i<columnCount; i++){
            Data[i] = "";
        }
        if (this.currentRow == this.rowCount) {
            return null;
        }
        Cell rowData[] = s.getRow(this.currentRow);
        for (int j = 0; j < rowData.length; j++) {
            if (rowData[j].getType() == CellType.DATE) {
                DateCell dCell = (DateCell) rowData[j];
                TimeZone gmtZone = TimeZone.getTimeZone("GMT");
                DateFormat destFormat = new SimpleDateFormat("MM/dd/yyyy");
                destFormat.setTimeZone(gmtZone);
                String datecell = destFormat.format(dCell.getDate());
                Data[j] = datecell;

            }else{
                Data[j] = rowData[j].getContents();
            }
            
        }

        this.currentRow++;
        return Data;
    }

    public String[] contentReading(InputStream fileInputStream) throws IOException, BiffException {
        WorkbookSettings ws;
        Workbook workbook;
        Sheet s;
        Cell rowData[];
        int rowCount0;
        int columnCount0;
        DateCell dc;
        int totalSheet;

        ws = new WorkbookSettings();
        ws.setLocale(new Locale("en", "EN"));
        workbook = Workbook.getWorkbook(fileInputStream, ws);

        totalSheet = workbook.getNumberOfSheets();
        if (totalSheet > 0) {
            System.out.println("Total Sheet Found:" + totalSheet);
            for (int j = 0; j < totalSheet; j++) {
                System.out.println("Sheet Name:" + workbook.getSheet(j).getName());
            }
        }

        //Getting Default Sheet i.e. 0
        s = workbook.getSheet(0);

        //Reading Individual Cell
        //getHeadingFromXlsFile(s);

        //Total Total No Of Rows in Sheet, will return you no of rows that are occupied with some data
        //System.out.println("Total Rows inside Sheet:" + s.getRows());
        rowCount = s.getRows();

        //Total Total No Of Columns in Sheet
        //System.out.println("Total Column inside Sheet:" + s.getColumns());
        columnCount = s.getColumns();
        String[] Data = new String[columnCount];

        //Reading Individual Row Content
        for (int i = 0; i < rowCount; i++) {
            //Get Individual Row
            rowData = s.getRow(i);
            for (int j = 0; j < columnCount; j++) {
                Data[j] = rowData[0].getContents();
            }
        }
        workbook.close();
        return Data;
    }
}