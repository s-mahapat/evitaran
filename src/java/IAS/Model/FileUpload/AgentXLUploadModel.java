/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.FileUpload;

import IAS.Bean.Inward.inwardFormBean;
import IAS.Bean.Subscriber.subscriberFormBean;
import IAS.Class.DataValidation;
import IAS.Class.ExcelReader;
import IAS.Class.JDSLogger;
import IAS.Class.util;
import IAS.Model.JDSModel;
import IAS.Model.Subscriber.subscriberModel;
import IAS.Model.Subscription.SubscriptionModel;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import jxl.read.biff.BiffException;
import org.apache.commons.fileupload.FileItem;
import org.apache.log4j.Logger;

public class AgentXLUploadModel extends FileUploadBase {

    private ExcelReader excelReader = null;
    private DataValidation dataValiDB = null;
    private ArrayList<String> returnOutList;
    private Boolean uploadInd = false;
    // For Subscriber
    private subscriberModel _subscriberModel = null;
    private subscriberFormBean _subscriberFormBean = null;
    //For Subscription
    private SubscriptionModel _subscriptionModel = null;
    //For Subscription Details
    private ArrayList<Integer> jrnlGrpId;
    private ArrayList<Integer> jrnlCopies;
    private String jrnlStartYear;
    private String jrnlStartMonth;
    private String jrnlEndYear;
    private inwardFormBean _inwardFormBean;
    private String inwardNumber;
     private static final Logger logger = JDSLogger.getJDSLogger(AgentXLUploadModel.class.getName());


    public AgentXLUploadModel(Boolean uploadInd, HttpServletRequest request) throws SQLException {
        //call the base class constructor
        super(request);
        session = request.getSession(false);
        this.uploadInd = uploadInd;
        _subscriberModel = new subscriberModel(request);
        _subscriberFormBean = new subscriberFormBean();
        _subscriptionModel = new SubscriptionModel(request);
        this._inwardFormBean = (inwardFormBean) session.getAttribute("inwardUnderProcess");
        this.inwardNumber = _inwardFormBean.getInwardNumber();

    }

    public void validateTemplate() { // This method validates the template
        try {
            for (FileItem item : this.getFiles()) {
                InputStream filecontent = item.getInputStream();
                excelReader = new ExcelReader(filecontent);
                returnOutList = new ArrayList<>();
                String[] rowData = excelReader.getFirstRow(); // get the first row
                for (int columnNo = 0; columnNo < rowData.length; columnNo++) {
                    switch (columnNo) {
                        case 0:
                            if (!rowData[columnNo].equalsIgnoreCase("subscriberNumber")) { // If the column name is not subscriber number then log an error
                                this.appendToErrorLog(columnNo, "subscriberNumber");
                            }
                            break;
                        case 1:
                            if (!rowData[columnNo].equalsIgnoreCase("subscriberName")) { // If the column name is not subscriber name then log an error
                                this.appendToErrorLog(columnNo, "subscriberName");
                            }
                            break;
                        case 2:
                            if (!rowData[columnNo].equalsIgnoreCase("department")) {
                                this.appendToErrorLog(columnNo, "department");
                            }
                            break;
                        case 3:
                            if (!rowData[columnNo].equalsIgnoreCase("institution")) {
                                this.appendToErrorLog(columnNo, "institution");
                            }
                            break;
                        case 4:
                            if (!rowData[columnNo].equalsIgnoreCase("shippingAddress")) {
                                this.appendToErrorLog(columnNo, "shippingAddress");
                            }
                            break;
                        case 5:
                            if (!rowData[columnNo].equalsIgnoreCase("invoiceAddress")) {
                                this.appendToErrorLog(columnNo, "invoiceAddress");
                            }
                            break;
                        case 6:
                            if (!rowData[columnNo].equalsIgnoreCase("city")) {
                                this.appendToErrorLog(columnNo, "city");
                            }
                            break;
                        case 7:
                            if (!rowData[columnNo].equalsIgnoreCase("district")) {
                                this.appendToErrorLog(columnNo, "district");
                            }
                            break;
                        case 8:
                            if (!rowData[columnNo].equalsIgnoreCase("state")) {
                                this.appendToErrorLog(columnNo, "state");
                            }
                            break;
                        case 9:
                            if (!rowData[columnNo].equalsIgnoreCase("country")) {
                                this.appendToErrorLog(columnNo, "country");
                            }
                            break;
                        case 10:
                            if (!rowData[columnNo].equalsIgnoreCase("pincode")) {
                                this.appendToErrorLog(columnNo, "pincode");
                            }
                            break;
                        case 11:
                            if (!rowData[columnNo].equalsIgnoreCase("email")) {
                                this.appendToErrorLog(columnNo, "email");
                            }
                            break;
                        case 12:
                            if (!rowData[columnNo].equalsIgnoreCase("subtype")) {
                                this.appendToErrorLog(columnNo, "subtype");
                            }
                            break;
                        case 13:
                            if (!rowData[columnNo].equalsIgnoreCase("subtypeDesc")) {
                                this.appendToErrorLog(columnNo, "subtypeDesc");
                            }
                            break;
                        case 14:
                            if (!rowData[columnNo].equalsIgnoreCase("P")) {
                                this.appendToErrorLog(columnNo, "P");
                            }
                            break;
                        case 15:
                            if (!rowData[columnNo].equalsIgnoreCase("JAA")) {
                                this.appendToErrorLog(columnNo, "JAA");
                            }
                            break;
                        case 16:
                            if (!rowData[columnNo].equalsIgnoreCase("MS")) {
                                this.appendToErrorLog(columnNo, "MS");
                            }
                            break;
                        case 17:
                            if (!rowData[columnNo].equalsIgnoreCase("EPS")) {
                                this.appendToErrorLog(columnNo, "EPS");
                            }
                            break;
                        case 18:
                            if (!rowData[columnNo].equalsIgnoreCase("CS")) {
                                this.appendToErrorLog(columnNo, "CS");
                            }
                            break;
                        case 19:
                            if (!rowData[columnNo].equalsIgnoreCase("BMS")) {
                                this.appendToErrorLog(columnNo, "BMS");
                            }
                            break;
                        case 20:
                            if (!rowData[columnNo].equalsIgnoreCase("S")) {
                                this.appendToErrorLog(columnNo, "S");
                            }
                            break;
                        case 21:
                            if (!rowData[columnNo].equalsIgnoreCase("JB")) {
                                this.appendToErrorLog(columnNo, "JB");
                            }
                            break;
                        case 22:
                            if (!rowData[columnNo].equalsIgnoreCase("JG")) {
                                this.appendToErrorLog(columnNo, "JG");
                            }
                            break;
                        case 23:
                            if (!rowData[columnNo].equalsIgnoreCase("RES")) {
                                this.appendToErrorLog(columnNo, "RES");
                            }
                            break;
                        case 24:
                            if (!rowData[columnNo].equalsIgnoreCase("CURR")) {
                                this.appendToErrorLog(columnNo, "CURR");
                            }
                            break;
                        case 25:
                            if (!rowData[columnNo].equalsIgnoreCase("startYear")) {
                                this.appendToErrorLog(columnNo, "startYear");
                            }
                            break;
                        case 26:
                            if (!rowData[columnNo].equalsIgnoreCase("startMonth")) {
                                this.appendToErrorLog(columnNo, "startMonth");
                            }
                            break;
                        case 27:
                            if (!rowData[columnNo].equalsIgnoreCase("endYear")) {
                                this.appendToErrorLog(columnNo, "endYear");
                            }
                            break;
                    }
                }
            }
        } catch (IOException | BiffException e) {
        }
    }

    @Override
    public void processFiles() throws SQLException {
        try {
            for (FileItem item : this.getFiles()) {
                InputStream filecontent = item.getInputStream();
                excelReader = new ExcelReader(filecontent);
                dataValiDB = new DataValidation();
                returnOutList = new ArrayList<>();

                int rowNo = 0;
                while (true) { // process the excel - validate data/process data
                    String[] rowData = excelReader.getNextRow();
                    jrnlGrpId = new ArrayList<>();
                    jrnlCopies = new ArrayList<>();
                    if (rowData == null) { //Break at the end of excel
                        break;
                    }
                    this.processData(rowData, rowNo); // Validate the data in excel
                    if (uploadInd == true) {
                        if (_subscriberFormBean.getSubscriberNumber().isEmpty()) {
                            int subscriberId = _subscriberModel.SaveNewSubscriber(_subscriberFormBean);
                        }
                        String returnOutList = _subscriberFormBean.getSubscriberNumber();

                        //create subscription
                        DateFormat date = new SimpleDateFormat("dd/MM/yyyy");
                        int[] arrJrnlGrpId = util.convertIntegers(jrnlGrpId);
                        int[] arrJrnlCopies = util.convertIntegers(jrnlCopies);
                        int subscriptionID = _subscriptionModel.addNewSubscription(_subscriberFormBean.getSubscriberNumber(),
                                this.inwardNumber,
                                date.format(new Date()));
                        this.returnOutList.add(returnOutList.concat(" / " + String.valueOf(subscriptionID))); // To add subscriber and subscription to display in the table
                        _subscriptionModel.addNewSubscriptionDetail(subscriptionID,
                                arrJrnlGrpId,
                                Integer.parseInt(jrnlStartYear),
                                Integer.parseInt(jrnlStartMonth),
                                Integer.parseInt(jrnlEndYear),
                                arrJrnlCopies,
                                _subscriberFormBean.getSubscriberNumber());
                    }
                    rowNo++;
                    if (uploadInd == true) {
                        _subscriberFormBean.setSubscriberNumber("");//Reset the subscriber number as one row from the excel is successfully executed
                    }
                }
                if (uploadInd == true) {
                    this.CompleteInward(this._inwardFormBean.getInwardID());// Complete the inward after upload
                }
            }
        } catch (IOException | BiffException | SQLException | ParseException | InvocationTargetException | IllegalAccessException e) {
            logger.fatal(e);
        }
    }

    public String processData(String[] Data, int rowNo) throws SQLException { // Process each cell of the Excel
        // if uploadInd(upload indicator) is false then only validate the cells
        // if upload indicator is true then add cell from A till N to Subscriber Bean, O till AB to corresponding subscription string
        // And then use the subscriber bean and the corresponding subscription strings to create subscriber and subscription
        String dataError = "";
        String subscriberNo = "";
        for (int columnNo = 0; columnNo < Data.length; columnNo++) {
            switch (columnNo) {
                case 0: // Subscriber Number
                    subscriberNo = Data[columnNo];
                    if (!subscriberNo.isEmpty() && uploadInd == false) { //If subscriber Number is given in the excel then validate if it exists in DB
                        if (!dataValiDB.validateSubscriberNo(subscriberNo)) {
                            this.appendToErrorLog(rowNo, columnNo, "SUBSCRIBER NUMBER", subscriberNo);
                        }
                    } else if (!subscriberNo.isEmpty() && uploadInd == true) { // If subscriber number is given in the excel, add it to the subscriber bean to create subscription
                        // Create directly subscription
                        _subscriberFormBean.setSubscriberNumber(subscriberNo);
                    } else if (subscriberNo.isEmpty() && uploadInd == true) {// If subscriber number is not given in the excel, simply create a new subscriber
                        //Do nothing
                    }
                    break;
                case 1:
                    String subscriberName = Data[columnNo];
                    if (subscriberName.isEmpty() && uploadInd == false && subscriberNo.isEmpty()) { // Subscriber name is mandatory only if it is a new subscriber
                        this.appendToErrorLog(rowNo, columnNo, "SUBSCRIBER NAME", subscriberName);
                    } else if (uploadInd == true) {
                        _subscriberFormBean.setSubscriberName(subscriberName);
                    }
                    break;
                case 2://department
                    String department = Data[columnNo];
                    if (!department.isEmpty() && uploadInd == true) { // If dept number is provided in the excel, add it to the subscriber bean
                        _subscriberFormBean.setDepartment(department);
                    }
                    break;
                case 3://institution
                    String institution = Data[columnNo];
                    if (!institution.isEmpty() && uploadInd == true) {// If institution is provided in the excel, add it to the subscriber bean
                        _subscriberFormBean.setInstitution(institution);
                    }
                    break;
                case 4:
                    String shippingAddress = Data[columnNo];
                    if (shippingAddress.isEmpty() && subscriberNo.isEmpty()) { // Shipping Address is mandatory, if not provided in the excel then log an error only if it is a new subscriber
                        this.appendToErrorLog(rowNo, columnNo, "SHIPPING ADDRESS", shippingAddress);
                    } else if (uploadInd == true) {
                        _subscriberFormBean.setShippingAddress(shippingAddress);
                    }
                    break;
                case 5:
                    String invoiceAddress = Data[columnNo];
                    if (invoiceAddress.isEmpty() && subscriberNo.isEmpty()) { // Invoice Address is mandatory, if not provided in the excel then log an error only if it is a new subscriber
                        this.appendToErrorLog(rowNo, columnNo, "INVOICE ADDRESS", invoiceAddress);
                    } else if (uploadInd == true) {
                        _subscriberFormBean.setInvoiceAddress(invoiceAddress);
                    }
                    break;
                case 6:
                    String city = Data[columnNo];
                    if (city.isEmpty() && subscriberNo.isEmpty()) { // City is mandatory, if not provided in the excel then log an error only if it is a new subscriber
                        this.appendToErrorLog(rowNo, columnNo, "CITY", city);
                    } else if (!city.isEmpty() && uploadInd == false && subscriberNo.isEmpty()) { // Validate city only if it is a new subscriber
                        if (!dataValiDB.validateCity(city)) {
                            this.appendToErrorLog(rowNo, columnNo, "CITY", city);
                        }
                    } else if (uploadInd == true) { // Append to subscriber bean
                        _subscriberFormBean.setCity(city);
                    }
                    break;
                case 7:
                    String district = Data[columnNo];
                    if (!district.isEmpty() && uploadInd == false && subscriberNo.isEmpty()) { // District is not mandatory. If district is provided, validate it  only if it is a new subscriber
                        if (!dataValiDB.validateDistrict(district)) {
                            this.appendToErrorLog(rowNo, columnNo, "DISTRICT", district);
                        }
                    } else if (!district.isEmpty() && uploadInd == true) { //Append to subscriber bean
                        _subscriberFormBean.setDistrict(district);
                    }
                    break;
                case 8:
                    String state = Data[columnNo];
                    if (state.isEmpty()&& subscriberNo.isEmpty()) { // State is mandatory, if not provided in the excel then log an error only if it is a new subscriber
                        this.appendToErrorLog(rowNo, columnNo, "STATE", state);
                    } else if (!state.isEmpty() && uploadInd == false && subscriberNo.isEmpty()) { // Validate state only if it is a new subscriber
                        if (!dataValiDB.validateState(state)) { // Validate State
                            this.appendToErrorLog(rowNo, columnNo, "STATE", state);
                        }
                    } else if (uploadInd == true) { // Append to subscriber bean
                        _subscriberFormBean.setState(state);
                    }
                    break;
                case 9:
                    String country = Data[columnNo];
                    if (country.isEmpty() && subscriberNo.isEmpty()) { // Country is mandatory, if not provided in the excel then log an error only if it is a new subscriber
                        this.appendToErrorLog(rowNo, columnNo, "COUNTRY", country);
                    } else if (!country.isEmpty() && uploadInd == false && subscriberNo.isEmpty()) { // Validate Country only if it is a new subscriber
                        if (!dataValiDB.validateCountry(country)) {
                            this.appendToErrorLog(rowNo, columnNo, "COUNTRY", country);
                        }
                    } else if (uploadInd == true) { // Append it to subscriber bean
                        _subscriberFormBean.setCountry(country);
                    }
                    break;
                case 10:
                    String pincode = Data[columnNo];
                    if (!pincode.isEmpty() && uploadInd == false && subscriberNo.isEmpty()) { // pincode is not mandatory, if provided then validate only if it is a new subscriber
                        if (!dataValiDB.validatePincode(pincode)) {
                            this.appendToErrorLog(rowNo, columnNo, "PINCODE", pincode);
                        }
                    } else if (!pincode.isEmpty() && uploadInd == true) { // if pincode is provided then append it to subscriber bean
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
                    if (subtype.isEmpty() && subscriberNo.isEmpty()) { // Sub type is mandatory, if not provided log error only if it is a new subscriber
                        this.appendToErrorLog(rowNo, columnNo, "SUBSCRIBER TYPE", subtype);
                        this.appendToErrorLog(rowNo, columnNo + 1, "SUBSCRIBER TYPE DESCRIPTION", subtypedesc);
                    } else if (uploadInd == false && subscriberNo.isEmpty()) { // validate subtype and subtype description only if it is a new subscriber
                        if (!dataValiDB.validateSubtype(subtype, subtypedesc)) {
                            this.appendToErrorLog(rowNo, columnNo, "SUBSCRIBER TYPE", subtype);
                            this.appendToErrorLog(rowNo, columnNo + 1, "SUBSCRIBER TYPE DESCRIPTION", subtypedesc);
                        }
                    } else if (uploadInd == true) { // append to subscriber bean
                        _subscriberFormBean.setSubtype(subtype);
                        _subscriberFormBean.setSubtypedesc(subtypedesc);
                    }
                    break;
                case 13:
                    // Sub type description is already added along with sub type. Hence do nothing.
                    break;
                case 14: // Pramana --> journal grp id for Pramana is 1 from DB table journal_groups
                    int jrnlP = Data[columnNo].isEmpty() ? 0: Integer.parseInt(Data[columnNo]);
                    if (jrnlP > 0 && uploadInd == true) { // If provided append journal group id and number of copies to the array list
                        this.jrnlGrpId.add(1);
                        this.jrnlCopies.add(jrnlP);
                    }
                    break;
                case 15: // Journal of Astrophysics and Astronomy --> jrnl grp id is 2
                    int jrnlJAA = Data[columnNo].isEmpty() ? 0: Integer.parseInt(Data[columnNo]);
                    if (jrnlJAA > 0 && uploadInd == true) { // If provided append journal group id and number of copies to the array list
                        this.jrnlGrpId.add(2);
                        this.jrnlCopies.add(jrnlJAA);
                    }
                    break;
                case 16: //Proceedings (Mathematical Sciences) --> jrnl grp id is 3
                    int jrnlMS = Data[columnNo].isEmpty() ? 0: Integer.parseInt(Data[columnNo]);
                    if (jrnlMS > 0 && uploadInd == true) { // If provided append journal group id and number of copies to the array list
                        this.jrnlGrpId.add(3);
                        this.jrnlCopies.add(jrnlMS);
                    }
                    break;
                case 17: // Journal of Earth System Science (formerly Proc. Earth Planet Sci.) --> jrnl id is 4
                    int jrnlEPS = Data[columnNo].isEmpty() ? 0: Integer.parseInt(Data[columnNo]);
                    if (jrnlEPS > 0 && uploadInd == true) {// If provided append journal group id and number of copies to the array list
                        this.jrnlGrpId.add(4);
                        this.jrnlCopies.add(jrnlEPS);
                    }
                    break;
                case 18: // Journal of Chemical Sciences (formerly Proc. Chemical Sci.) --> jrnl id is 5
                    int jrnlCS = Data[columnNo].isEmpty() ? 0: Integer.parseInt(Data[columnNo]);
                    if (jrnlCS > 0&& uploadInd == true) {// If provided append journal group id and number of copies to the array list
                        this.jrnlGrpId.add(5);
                        this.jrnlCopies.add(jrnlCS);
                    }
                    break;
                case 19: // Bulletin of Materials Science --> jrnl id is 6
                    int jrnlBMS = Data[columnNo].isEmpty() ? 0: Integer.parseInt(Data[columnNo]);
                    if (jrnlBMS > 0 && uploadInd == true) {// If provided append journal group id and number of copies to the array list
                        this.jrnlGrpId.add(6);
                        this.jrnlCopies.add(jrnlBMS);
                    }
                    break;
                case 20: // Sadhana (Engineering Sciences) --> jrnl id is 7
                    int jrnlS = Data[columnNo].isEmpty() ? 0: Integer.parseInt(Data[columnNo]);
                    if (jrnlS > 0 && uploadInd == true) {// If provided append journal group id and number of copies to the array list
                        this.jrnlGrpId.add(7);
                        this.jrnlCopies.add(jrnlS);
                    }
                    break;
                case 21: // Journal of Biosciences --> jrnl id is 8
                    int jrnlJB = Data[columnNo].isEmpty() ? 0: Integer.parseInt(Data[columnNo]);
                    if (jrnlJB > 0 && uploadInd == true) {// If provided append journal group id and number of copies to the array list
                        this.jrnlGrpId.add(8);
                        this.jrnlCopies.add(jrnlJB);
                    }
                    break;
                case 22: // Journal of Genetics --> jrnl id is 9
                    int jrnlJG = Data[columnNo].isEmpty() ? 0: Integer.parseInt(Data[columnNo]);
                    if (jrnlJG > 0 && uploadInd == true) {// If provided append journal group id and number of copies to the array list
                        this.jrnlGrpId.add(9);
                        this.jrnlCopies.add(jrnlJG);
                    }
                    break;
                case 23: // Resonanace - Journal of Science Education --> jrnl id is 10
                    int jrnlRES = Data[columnNo].isEmpty() ? 0: Integer.parseInt(Data[columnNo]);
                    if (jrnlRES > 0 && uploadInd == true) {// If provided append journal group id and number of copies to the array list
                        this.jrnlGrpId.add(10);
                        this.jrnlCopies.add(jrnlRES);
                    }
                    break;
                case 24: // Current Science --> jrnl id is 11
                    int jrnlCURR = Data[columnNo].isEmpty() ? 0: Integer.parseInt(Data[columnNo]);
                    if (jrnlCURR > 0 && uploadInd == true) {// If provided append journal group id and number of copies to the array list
                        this.jrnlGrpId.add(11);
                        this.jrnlCopies.add(jrnlCURR);
                    }
                    break;
                case 25:
                    this.jrnlStartYear = Data[columnNo];
                    if (this.jrnlStartYear.isEmpty()) { // Start year is mandatory to create subscription
                        this.appendToErrorLog(rowNo, columnNo, "START YEAR", jrnlStartYear);
                    }
                    break;
                case 26:
                    this.jrnlStartMonth = Data[columnNo];
                    if (this.jrnlStartMonth.isEmpty()) { // Start month is mandatory to create subscription
                        this.appendToErrorLog(rowNo, columnNo, "START MONTH", jrnlStartMonth);
                    }
                    break;
                case 27:
                    this.jrnlEndYear = Data[columnNo];
                    if (this.jrnlEndYear.isEmpty()) { // End year is mandatory to create subscription
                        this.appendToErrorLog(rowNo, columnNo, "END YEAR", jrnlEndYear);
                    }
                    int startMonth = Integer.parseInt(this.jrnlStartMonth);
                    int startYear = Integer.parseInt(this.jrnlStartYear);
                    int endYear = Integer.parseInt(this.jrnlEndYear);
                    if(startMonth > 1 && endYear <= startYear){
                        this.appendToErrorLog(rowNo, columnNo, "END YEAR", jrnlEndYear);
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

    public void appendToErrorLog(int rowNo, int columnNo, String cellName, String cellValue) {
        String strError = " ";
        String strMandatory = " is mandatory.";
        String strInvalid = " is invalid.";
        String dataError = "Cell ";
        if ((cellName.equalsIgnoreCase("SUBSCRIBER NUMBER"))
                || (cellName.equalsIgnoreCase("DISTRICT"))
                || (cellName.equalsIgnoreCase("SUBSCRIBER TYPE"))
                || (cellName.equalsIgnoreCase("SUBSCRIBER TYPE DESCRIPTION"))
                || (cellName.equalsIgnoreCase("PINCODE"))
                || (cellName.equalsIgnoreCase("SUBSCRIBER NAME"))
                || (cellName.equalsIgnoreCase("SHIPPING ADDRESS"))
                || (cellName.equalsIgnoreCase("INVOICE ADDRESS"))
                || (cellName.equalsIgnoreCase("CITY"))
                || (cellName.equalsIgnoreCase("STATE"))
                || (cellName.equalsIgnoreCase("COUNTRY"))
                || (cellName.equalsIgnoreCase("SUBSCRIBER NAME"))
                || (cellName.equalsIgnoreCase("START YEAR"))
                || (cellName.equalsIgnoreCase("START MONTH"))
                || (cellName.equalsIgnoreCase("END YEAR"))) {
            if (cellValue.isEmpty()) {
                strError = cellName + strMandatory;
            } else {
                strError = cellName + strError + cellValue + strInvalid;
            }
        }
        dataError = dataError + rowNo + this.getEquivColumn(columnNo) + " -----> " + strError;
        this.returnOutList.add(dataError);
    }

    public void appendToErrorLog(int columnNo, String columnName) {
        String dataError = " ";
        dataError = "The template is incorrect. " + columnName + " is not found";
        this.returnOutList.add(dataError);
    }

    public void uploadData() {
        String dataError = "Success";
        this.returnOutList.add(dataError);
    }

    @Override
    public ArrayList<String> getOutputAsLIST() {
        return this.returnOutList;
    }
}
