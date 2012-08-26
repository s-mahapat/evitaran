/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.FileUpload;

import IAS.Class.DataValidationFromDB;
import IAS.Class.ExcelReader;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import jxl.read.biff.BiffException;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class AgentXLUploadModel extends FileUploadBase {

    private ExcelReader excelReader = null;
    private DataValidationFromDB dataValiDB = null;
    private ArrayList<String> errors;

    
    public AgentXLUploadModel() throws SQLException {
        //call the base class constructor
        //super(request);
    }
    
    @Override
    public void processFiles() throws SQLException {
        try {
            //List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
            for (FileItem item : this.getFiles()) {
                InputStream filecontent = item.getInputStream();
                try {
                    excelReader = new ExcelReader(filecontent);
                    dataValiDB = new DataValidationFromDB();
                    errors = new ArrayList<>();
                    int rowNo = 1;
                    while (true) {
                        String[] rowData = excelReader.getNextRow();
                        if (rowData == null) { //Break at the end of excel
                            break;
                        }
                        String dataError = null;
                        try {
                            dataError = this.validateData(rowData, rowNo); // Validate the data in excel
                        } catch (SQLException ex) {
                            Logger.getLogger(AgentXLUploadModel.class.getName()).log(Level.SEVERE, null, ex);
                        }
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
        } catch ( IOException e) {
            try {
                throw new ServletException("Cannot parse multipart request.", e);
            } catch (ServletException ex) {
                Logger.getLogger(AgentXLUploadModel.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public ArrayList<String> getOutputAsLIST() {
        return this.errors;
    }

    public ArrayList<String> uploadDataInDB() throws ServletException, SQLException {
        try {
            List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
            for (FileItem item : items) {
                InputStream filecontent = item.getInputStream();
                try {
                    excelReader = new ExcelReader(filecontent);
                    dataValiDB = new DataValidationFromDB();
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
        this.errors.add(dataError);
    }

    public String uploadData() {
        return "";
    }
}