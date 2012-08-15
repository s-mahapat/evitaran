/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.FileUpload;

import IAS.Class.DataValidationFromDB;
import IAS.Class.ExcelReader;
import IAS.Model.JDSModel;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import jxl.read.biff.BiffException;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class fileUploadModel extends JDSModel {

    private ExcelReader excelReader = null;
    private DataValidationFromDB dataValiDB = null;
    private ArrayList<String> errors;

    public fileUploadModel(HttpServletRequest request) throws SQLException, IOException {
        //call the base class constructor
        super(request);
    }

    public ArrayList<String> uploadDataInDB() throws ServletException, SQLException {
        try {
            List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
            for (FileItem item : items) {
                InputStream filecontent = item.getInputStream();
                try {
                    excelReader = new ExcelReader(filecontent);
                    dataValiDB = new DataValidationFromDB(this.db, this.conn);
                    errors = new ArrayList<>();
                    int rowNo = 1;
                    while (true) {
                        String[] rowData = excelReader.getNextRow();
                        if (rowData == null) { //Break at the end of excel
                            break;
                        }
                        String dataError = this.validateData(rowData, rowNo); // Validate the data in excel
                        if (!dataError.isEmpty()) {
                            System.out.println("ERROR WHILE UPLOADING EXCEL");
                            //break;
                        } else {
                            String dataUploaded = this.uploadData(); //Update the DB with data
                        }
                        System.out.println(rowData);
                        rowNo++;
                    }
                } catch (IOException | BiffException e) {
                    System.out.println("Exception: " + e.getMessage());
                }
            }
        } catch (FileUploadException | IOException e) {
            throw new ServletException("Cannot parse multipart request.", e);
        }
        return errors;
    }

    public String validateData(String[] Data, int rowNo) throws SQLException {
        String dataError = "";
        for (int columnNo = 0; columnNo < Data.length; columnNo++) {
            switch (columnNo) {
                case 0:
                    String city = Data[columnNo];
                    if (!dataValiDB.validateCity(city)) {
                        this.appendToErrorLog(rowNo, columnNo);
                    }
                    break;
                case 1:
                    String district = Data[columnNo];
                    if (!dataValiDB.validateDistrict(district)) {
                        this.appendToErrorLog(rowNo, columnNo);
                    }
                    break;
                case 2:
                    String country = Data[columnNo];
                    if (!dataValiDB.validateCountry(country)) {
                        this.appendToErrorLog(rowNo, columnNo);
                    }
                    break;
            }
        }
        return dataError;
    }

    public String getEquivColumn(int number) { // to get the column no. converted
        String converted = "";
        // Repeatedly divide the number by 26 and convert the
        // remainder into the appropriate letter.
        while (number >= 0) {
            int remainder = number % 26;
            converted = (char) (remainder + 'A') + converted;
            number = (number / 26) - 1;
        }
        return converted;
    }

    public void appendToErrorLog(int rowNo, int columnNo) {
        String dataError = "Excel has error at cell " + rowNo + this.getEquivColumn(columnNo);
        errors.add(dataError);
    }

    public String uploadData() {
        return "";
    }
}