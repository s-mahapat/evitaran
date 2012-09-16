/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.FileUpload;

import IAS.Bean.Subscriber.subscriberFormBean;
import IAS.Class.DataValidation;
import IAS.Class.ExcelReader;
import IAS.Model.Subscriber.subscriberModel;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import jxl.read.biff.BiffException;
import org.apache.commons.fileupload.FileItem;

public class AgentXLUploadModel extends FileUploadBase {

    private ExcelReader excelReader = null;
    private DataValidation dataValiDB = null;
    private ArrayList<String> returnOutList;
    private Boolean uploadInd = false;
    private subscriberModel _subscriberModel = null;
    private subscriberFormBean _subscriberFormBean = null;

    public AgentXLUploadModel() throws SQLException {
        //call the base class constructor
        //super(request);
    }

    public AgentXLUploadModel(Boolean uploadInd, HttpServletRequest request) throws SQLException {
        //call the base class constructor
        //super(request);
        this.uploadInd = uploadInd;
        _subscriberModel = new IAS.Model.Subscriber.subscriberModel(request);
        _subscriberFormBean = new IAS.Bean.Subscriber.subscriberFormBean();
    }

//    public void validateFile() throws SQLException {
//        try {
//            for (FileItem item : this.getFiles()) {
//                InputStream filecontent = item.getInputStream();
//                try {
//                    excelReader = new ExcelReader(filecontent);
//                    dataValiDB = new DataValidation();
//                    returnOutList = new ArrayList<>();
//                    int rowNo = 1;
//                    while (true) {
//                        String[] rowData = excelReader.getNextRow();
//                        if (rowData == null) { //Break at the end of excel
//                            break;
//                        }
//                        try {
//                            this.validateData(rowData, rowNo); // Validate the data in excel
//                        } catch (SQLException ex) {
//                            Logger.getLogger(AgentXLUploadModel.class.getName()).log(Level.SEVERE, null, ex);
//                        }
//                        //System.out.println(rowData);
//                        rowNo++;
//                    }
//                } catch (IOException | BiffException e) {
//                    System.out.println("Exception: " + e.getMessage());
//                }
//            }
//        } catch (IOException e) {
//            try {
//                throw new ServletException("Cannot parse multipart request.", e);
//            } catch (ServletException ex) {
//                Logger.getLogger(AgentXLUploadModel.class.getName()).log(Level.SEVERE, null, ex);
//            }
//        }
//    }
    @Override
    public void processFiles() throws SQLException {
        try {
            for (FileItem item : this.getFiles()) {
                InputStream filecontent = item.getInputStream();
                excelReader = new ExcelReader(filecontent);
                dataValiDB = new DataValidation();
                returnOutList = new ArrayList<>();
                int rowNo = 1;
                while (true) {
                    String[] rowData = excelReader.getNextRow();
                    if (rowData == null) { //Break at the end of excel
                        break;
                    }
                    this.processData(rowData, rowNo); // Validate the data in excel
                    if (uploadInd == true) {
                        if (_subscriberFormBean.getSubscriberNumber().isEmpty()) {
                            this.returnOutList.add(String.valueOf(_subscriberModel.SaveNewSubscriber(_subscriberFormBean)));
                        } else {//create subscription}
                        }
                        rowNo++;
                    }
                }
            }
        } catch (IOException | BiffException | SQLException | ParseException | InvocationTargetException | IllegalAccessException e) {
        }
    }

    @Override
    public ArrayList<String> getOutputAsLIST() {
        return this.returnOutList;
    }

    public String processData(String[] Data, int rowNo) throws SQLException {
        String dataError = "";
        for (int columnNo = 0; columnNo < Data.length; columnNo++) {
            switch (columnNo) {
                case 0:
                    String subscriberNo = Data[columnNo];
                    if (!subscriberNo.isEmpty() && uploadInd == false) {
                        if (!dataValiDB.validateSubscriberNo(subscriberNo)) {
                            this.appendToErrorLog(rowNo, columnNo, "SUBSCRIBER NUMBER", subscriberNo);
                        }
                    } else if (!subscriberNo.isEmpty() && uploadInd == true) {
                        // Create directly subscription
                        _subscriberFormBean.setSubscriberNumber(subscriberNo);
                    } else if (subscriberNo.isEmpty() && uploadInd == true) {
                        //Do nothing
                    }
                    break;
                case 1:
                    String subscriberName = Data[columnNo];
                    if (subscriberName.isEmpty() && uploadInd == false) {
                        this.appendToErrorLog(rowNo, columnNo, "SUBSCRIBER NAME", subscriberName);
                    } else if (uploadInd == true) {
                        _subscriberFormBean.setSubscriberName(subscriberName);
                    }
                    break;
                case 2://department
                    String department = Data[columnNo];
                    if (uploadInd == true) {
                        _subscriberFormBean.setDepartment(department);
                    }
                    break;
                case 3://institution
                    String institution = Data[columnNo];
                    if (uploadInd == true) {
                        _subscriberFormBean.setInstitution(institution);
                    }
                    break;
                case 4:
                    String shippingAddress = Data[columnNo];
                    if (shippingAddress.isEmpty()) {
                        this.appendToErrorLog(rowNo, columnNo, "SHIPPING ADDRESS", shippingAddress);
                    } else if (uploadInd == true) {
                        _subscriberFormBean.setShippingAddress(shippingAddress);
                    }
                    break;
                case 5:
                    String invoiceAddress = Data[columnNo];
                    if (invoiceAddress.isEmpty()) {
                        this.appendToErrorLog(rowNo, columnNo, "INVOICE ADDRESS", invoiceAddress);
                    } else if (uploadInd == true) {
                        _subscriberFormBean.setInvoiceAddress(invoiceAddress);
                    }
                    break;
                case 6:
                    String city = Data[columnNo];
                    if (city.isEmpty()) {
                        this.appendToErrorLog(rowNo, columnNo, "CITY", city);
                    } else if (!city.isEmpty() && uploadInd == false) {
                        if (!dataValiDB.validateCity(city)) {
                            this.appendToErrorLog(rowNo, columnNo, "CITY", city);
                        }
                    } else if (uploadInd == true) {
                        _subscriberFormBean.setCity(city);
                    }
                    break;
                case 7:
                    String district = Data[columnNo];
                    if (!district.isEmpty() && uploadInd == false) {
                        if (!dataValiDB.validateDistrict(district)) {
                            this.appendToErrorLog(rowNo, columnNo, "DISTRICT", district);
                        }
                    } else if (uploadInd == true) {
                        _subscriberFormBean.setDistrict(district);
                    }
                    break;
                case 8:
                    String state = Data[columnNo];
                    if (state.isEmpty()) {
                        this.appendToErrorLog(rowNo, columnNo, "STATE", state);
                    } else if (!state.isEmpty() && uploadInd == false) {
                        if (!dataValiDB.validateState(state)) {
                            this.appendToErrorLog(rowNo, columnNo, "STATE", state);
                        }
                    } else if (uploadInd == true) {
                        _subscriberFormBean.setState(state);
                    }
                    break;
                case 9:
                    String country = Data[columnNo];
                    if (country.isEmpty()) {
                        this.appendToErrorLog(rowNo, columnNo, "COUNTRY", country);
                    } else if (!country.isEmpty() && uploadInd == false) {
                        if (!dataValiDB.validateCountry(country)) {
                            this.appendToErrorLog(rowNo, columnNo, "COUNTRY", country);
                        }
                    } else if (uploadInd == true) {
                        _subscriberFormBean.setCountry(country);
                    }
                    break;
                case 10:
                    String pincode = Data[columnNo];
                    if (!pincode.isEmpty() && uploadInd == false) {
                        if (!dataValiDB.validatePincode(pincode)) {
                            this.appendToErrorLog(rowNo, columnNo, "PINCODE", pincode);
                        }
                    } else if (uploadInd == true) {
                        _subscriberFormBean.setPincode(Integer.parseInt(pincode));
                    }
                    break;
                case 11:
                    String email = Data[columnNo];
                    if (uploadInd == true) {
                        _subscriberFormBean.setEmail(email);
                    }
                    break;
                case 12:
                    String subtype = Data[columnNo];
                    String subtypedesc = Data[columnNo + 1];
                    if (subtype.isEmpty()) {
                        this.appendToErrorLog(rowNo, columnNo, "SUBSCRIBER TYPE", subtype);
                    } else if (!subtype.isEmpty() && uploadInd == false) {
                        if (!dataValiDB.validateSubtype(subtype, subtypedesc)) {
                            this.appendToErrorLog(rowNo, columnNo, "SUBSCRIBER TYPE", subtype);
                        }
                    } else if (uploadInd == true) {
                        _subscriberFormBean.setSubtype(subtype);
                        _subscriberFormBean.setSubtypedesc(subtypedesc);
                    }
                    break;
                case 13:
                    break;
                case 14:
                    break;
                case 15:
                    break;
                case 16:
                    break;
                case 17:
                    break;
                case 18:
                    break;
                case 19:
                    break;
                case 20:
                    break;
                case 21:
                    break;
                case 22:
                    break;
                case 23:
                    break;
                case 24:
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

    public void appendToErrorLog(int rowNo, int columnNo, String cellName, String cellValue) {
        String strError = " ";
        String strMandatory = " is mandatory.";
        String strInvalid = " is invalid.";
        String dataError = "Cell ";
        if ((cellName.equalsIgnoreCase("SUBSCRIBER NUMBER"))
                || (cellName.equalsIgnoreCase("DISTRICT"))
                || (cellName.equalsIgnoreCase("SUBSCRIBER TYPE"))
                || (cellName.equalsIgnoreCase("SUBSCRIBER TYPE CODE"))
                || (cellName.equalsIgnoreCase("PINCODE"))
                || (cellName.equalsIgnoreCase("SUBSCRIBER NAME"))
                || (cellName.equalsIgnoreCase("SHIPPING ADDRESS"))
                || (cellName.equalsIgnoreCase("INVOICE ADDRESS"))
                || (cellName.equalsIgnoreCase("CITY"))
                || (cellName.equalsIgnoreCase("STATE"))
                || (cellName.equalsIgnoreCase("COUNTRY"))
                || (cellName.equalsIgnoreCase("SUBSCRIBER NAME"))) {
            if (cellValue.isEmpty()) {
                strError = cellName + strMandatory;
            } else {
                strError = cellName + strError + cellValue + strInvalid;
            }
        }
        dataError = dataError + rowNo + this.getEquivColumn(columnNo) + " -----> " + strError;
        this.returnOutList.add(dataError);
    }

    public void uploadData() {
        String dataError = "Success";
        this.returnOutList.add(dataError);
    }
}
