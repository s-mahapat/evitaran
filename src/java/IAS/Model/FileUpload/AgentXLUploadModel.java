/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.FileUpload;

import IAS.Bean.Inward.inwardFormBean;
import IAS.Bean.Subscriber.subscriberFormBean;
import IAS.Bean.Subscription.SubscriptionDetailBean;
import IAS.Bean.Subscription.SubscriptionFormBean;
import IAS.Class.DataValidation;
import IAS.Class.ExcelReader;
import IAS.Class.util;
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
import javax.servlet.http.HttpSession;
import jxl.read.biff.BiffException;
import org.apache.commons.fileupload.FileItem;

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

    public AgentXLUploadModel() throws SQLException {
        //call the base class constructor
        //super(request);
    }

    public AgentXLUploadModel(Boolean uploadInd, HttpServletRequest request) throws SQLException {
        //call the base class constructor
        //super(request);
        HttpSession session = request.getSession(false);
        this.uploadInd = uploadInd;
        _subscriberModel = new subscriberModel(request);
        _subscriberFormBean = new subscriberFormBean();
        _subscriptionModel = new SubscriptionModel(request);
        this._inwardFormBean = (inwardFormBean) session.getAttribute("inwardUnderProcess");
        this.inwardNumber = _inwardFormBean.getInwardNumber();
        jrnlGrpId = new ArrayList<>();
        jrnlCopies = new ArrayList<>();
    }

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
                            int subscriberId = _subscriberModel.SaveNewSubscriber(_subscriberFormBean);
                            this.returnOutList.add(_subscriberFormBean.getSubscriberNumber());
                        }
                        //create subscription
//            int subscriptionID,
//            int[] journalGroupID,
//            int startYear,
//            int startMonth,
//            int endYear,
//            int[] copies,
//            String subscriberNumber
                        DateFormat date = new SimpleDateFormat("dd/MM/yyyy");
                        int[] arrJrnlGrpId = util.convertIntegers(jrnlGrpId);
                        int[] arrJrnlCopies = util.convertIntegers(jrnlCopies);
                        int subscriptionID = _subscriptionModel.addNewSubscription(_subscriberFormBean.getSubscriberNumber(),
                                this.inwardNumber,
                                date.format(new Date()));
                        _subscriptionModel.addNewSubscriptionDetail(subscriptionID,
                                arrJrnlGrpId,
                                Integer.parseInt(jrnlStartYear),
                                Integer.parseInt(jrnlStartMonth),
                                Integer.parseInt(jrnlEndYear),
                                arrJrnlCopies,
                                _subscriberFormBean.getSubscriberNumber());
                    }
                    rowNo++;
                }
            }
        } catch (IOException | BiffException | SQLException | ParseException | InvocationTargetException | IllegalAccessException e) {
        }
    }

    @Override
    public ArrayList<String> getOutputAsLIST() {
        return this.returnOutList;
    }

    public String processData(String[] Data, int rowNo) throws SQLException { // Process each cell of the Excel
        // if uploadInd(upload indicator) is false then only validate the cells
        // if upload indicator is true then add cell from A till N to Subscriber Bean, O till AB to corresponding subscription string 
        // And then use the subscriber bean and the corresponding subscription strings to create subscriber and subscription
        String dataError = "";
        for (int columnNo = 0; columnNo < Data.length; columnNo++) {
            switch (columnNo) {
                case 0: // Subscriber Number
                    String subscriberNo = Data[columnNo];
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
                    if (subscriberName.isEmpty() && uploadInd == false) {
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
                    if (shippingAddress.isEmpty()) { // Shipping Address is mandatory, if not provided in the excel then log an error
                        this.appendToErrorLog(rowNo, columnNo, "SHIPPING ADDRESS", shippingAddress);
                    } else if (uploadInd == true) {
                        _subscriberFormBean.setShippingAddress(shippingAddress);
                    }
                    break;
                case 5:
                    String invoiceAddress = Data[columnNo];
                    if (invoiceAddress.isEmpty()) { // Invoice Address is mandatory, if not provided in the excel then log an error
                        this.appendToErrorLog(rowNo, columnNo, "INVOICE ADDRESS", invoiceAddress);
                    } else if (uploadInd == true) {
                        _subscriberFormBean.setInvoiceAddress(invoiceAddress);
                    }
                    break;
                case 6:
                    String city = Data[columnNo];
                    if (city.isEmpty()) { // City is mandatory, if not provided in the excel then log an error
                        this.appendToErrorLog(rowNo, columnNo, "CITY", city);
                    } else if (!city.isEmpty() && uploadInd == false) { // Validate city
                        if (!dataValiDB.validateCity(city)) {
                            this.appendToErrorLog(rowNo, columnNo, "CITY", city);
                        }
                    } else if (uploadInd == true) { // Append to subscriber bean
                        _subscriberFormBean.setCity(city);
                    }
                    break;
                case 7:
                    String district = Data[columnNo];
                    if (!district.isEmpty() && uploadInd == false) { // District is not mandatory. If district is provided, validate it 
                        if (!dataValiDB.validateDistrict(district)) {
                            this.appendToErrorLog(rowNo, columnNo, "DISTRICT", district);
                        }
                    } else if (!district.isEmpty() && uploadInd == true) { //Append to subscriber bean
                        _subscriberFormBean.setDistrict(district);
                    }
                    break;
                case 8:
                    String state = Data[columnNo];
                    if (state.isEmpty()) { // State is mandatory, if not provided in the excel then log an error
                        this.appendToErrorLog(rowNo, columnNo, "STATE", state);
                    } else if (!state.isEmpty() && uploadInd == false) {
                        if (!dataValiDB.validateState(state)) { // Validate State
                            this.appendToErrorLog(rowNo, columnNo, "STATE", state);
                        }
                    } else if (uploadInd == true) { // Append to subscriber bean
                        _subscriberFormBean.setState(state);
                    }
                    break;
                case 9:
                    String country = Data[columnNo];
                    if (country.isEmpty()) { // Country is mandatory, if not provided in the excel then log an error
                        this.appendToErrorLog(rowNo, columnNo, "COUNTRY", country);
                    } else if (!country.isEmpty() && uploadInd == false) { // Validate Country
                        if (!dataValiDB.validateCountry(country)) {
                            this.appendToErrorLog(rowNo, columnNo, "COUNTRY", country);
                        }
                    } else if (uploadInd == true) { // Append it to subscriber bean
                        _subscriberFormBean.setCountry(country);
                    }
                    break;
                case 10:
                    String pincode = Data[columnNo];
                    if (!pincode.isEmpty() && uploadInd == false) { // pincode is not mandatory, if provided then validate
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
                    if (subtype.isEmpty()) { // Sub type is mandatory, if not provided log error
                        this.appendToErrorLog(rowNo, columnNo, "SUBSCRIBER TYPE", subtype);
                        this.appendToErrorLog(rowNo, columnNo+1, "SUBSCRIBER TYPE DESCRIPTION", subtypedesc);
                    } else if (uploadInd == false) { // validate subtype and subtype description
                        if (!dataValiDB.validateSubtype(subtype, subtypedesc)) {
                            this.appendToErrorLog(rowNo, columnNo, "SUBSCRIBER TYPE", subtype);
                            this.appendToErrorLog(rowNo, columnNo+1, "SUBSCRIBER TYPE DESCRIPTION", subtypedesc);
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
                    String jrnlP = Data[columnNo];
                    if (!jrnlP.isEmpty() && uploadInd == true) { // If provided append journal group id and number of copies to the array list
                        this.jrnlGrpId.add(1);
                        this.jrnlCopies.add(Integer.parseInt(jrnlP));
                    }
                    break;
                case 15: // Journal of Astrophysics and Astronomy --> jrnl grp id is 2
                    String jrnlJAA = Data[columnNo];
                    if (!jrnlJAA.isEmpty() && uploadInd == true) { // If provided append journal group id and number of copies to the array list
                        this.jrnlGrpId.add(2);
                        this.jrnlCopies.add(Integer.parseInt(jrnlJAA));
                    }
                    break;
                case 16: //Proceedings (Mathematical Sciences) --> jrnl grp id is 3
                    String jrnlMS = Data[columnNo];
                    if (!jrnlMS.isEmpty() && uploadInd == true) { // If provided append journal group id and number of copies to the array list
                        this.jrnlGrpId.add(3);
                        this.jrnlCopies.add(Integer.parseInt(jrnlMS));
                    }
                    break;
                case 17: // Journal of Earth System Science (formerly Proc. Earth Planet Sci.) --> jrnl id is 4
                    String jrnlEPS = Data[columnNo];
                    if (!jrnlEPS.isEmpty() && uploadInd == true) {// If provided append journal group id and number of copies to the array list
                        this.jrnlGrpId.add(4);
                        this.jrnlCopies.add(Integer.parseInt(jrnlEPS));
                    }
                    break;
                case 18: // Journal of Chemical Sciences (formerly Proc. Chemical Sci.) --> jrnl id is 5
                    String jrnlCS = Data[columnNo];
                    if (!jrnlCS.isEmpty() && uploadInd == true) {// If provided append journal group id and number of copies to the array list
                        this.jrnlGrpId.add(5);
                        this.jrnlCopies.add(Integer.parseInt(jrnlCS));
                    }
                    break;
                case 19: // Bulletin of Materials Science --> jrnl id is 6
                    String jrnlBMS = Data[columnNo];
                    if (!jrnlBMS.isEmpty() && uploadInd == true) {// If provided append journal group id and number of copies to the array list
                        this.jrnlGrpId.add(6);
                        this.jrnlCopies.add(Integer.parseInt(jrnlBMS));
                    }
                    break;
                case 20: // Sadhana (Engineering Sciences) --> jrnl id is 7
                    String jrnlS = Data[columnNo];
                    if (!jrnlS.isEmpty() && uploadInd == true) {// If provided append journal group id and number of copies to the array list
                        this.jrnlGrpId.add(7);
                        this.jrnlCopies.add(Integer.parseInt(jrnlS));
                    }
                    break;
                case 21: // Journal of Biosciences --> jrnl id is 8
                    String jrnlJB = Data[columnNo];
                    if (!jrnlJB.isEmpty() && uploadInd == true) {// If provided append journal group id and number of copies to the array list
                        this.jrnlGrpId.add(8);
                        this.jrnlCopies.add(Integer.parseInt(jrnlJB));
                    }
                    break;
                case 22: // Journal of Genetics --> jrnl id is 9
                    String jrnlJG = Data[columnNo];
                    if (!jrnlJG.isEmpty() && uploadInd == true) {// If provided append journal group id and number of copies to the array list
                        this.jrnlGrpId.add(9);
                        this.jrnlCopies.add(Integer.parseInt(jrnlJG));
                    }
                    break;
                case 23: // Resonanace - Journal of Science Education --> jrnl id is 10
                    String jrnlRES = Data[columnNo];
                    if (!jrnlRES.isEmpty() && uploadInd == true) {// If provided append journal group id and number of copies to the array list
                        this.jrnlGrpId.add(10);
                        this.jrnlCopies.add(Integer.parseInt(jrnlRES));
                    }
                    break;
                case 24: // Current Science --> jrnl id is 11
                    String jrnlCURR = Data[columnNo];
                    if (!jrnlCURR.isEmpty() && uploadInd == true) {// If provided append journal group id and number of copies to the array list
                        this.jrnlGrpId.add(11);
                        this.jrnlCopies.add(Integer.parseInt(jrnlCURR));
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

    public void uploadData() {
        String dataError = "Success";
        this.returnOutList.add(dataError);
    }
}
