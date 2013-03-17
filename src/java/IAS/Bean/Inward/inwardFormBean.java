package IAS.Bean.Inward;

import IAS.Bean.JDSBean;
import IAS.Class.util;

public class inwardFormBean extends JDSBean {

    /*
     * Inward header fields
     */
    private String from = "";
    private String country = "";
    private String state;
    private String district="";
    private String city = "";
    private int pincode = 0;
    private String inwardNumber = "";
    private int inwardID = 0;
    private String inwardCreationDate = util.getDateString();
    private String subscriberId = "";
    private String email = "";
    private String subscriberEmail = null;
    private String institution = "";
    private String department = "";
    private int subscriptionID = 0;
    private int agentID = 0;
    private String agentName = "";

    /*
     * Inward details fields
     */
    private String inwardPurpose;
    private int inwardPurposeID;
    private String paymentMode;
    private String bankName;
    private int chqddNumber = 0;
    private String paymentDate = null;// = new java.util.Date();
    private float amount = 0;
    private String currency;
    private int receiptNumber = 0;
    private boolean chequeDDReturn = false;
    private String chequeDDReturnReason = null;
    private String chequeDDReturnReasonOther = null;
    private String ackDate;
    private String returnDate;
    private String remarks;
    private boolean completed = false;
    private String language = "";

    public int getInwardID() {
        return this.inwardID;
    }

    public void setInwardID(int _inwardID) {
        this.inwardID = _inwardID;
    }

    public String getFrom() {
        return (this.from);
    }

    public void setFrom(String _From) {
        this.from = _From;
    }

    public String getCountry() {
        return this.country;
    }

    public void setCountry(String _Country) {
        this.country = _Country;
    }

    public String getState() {
        return this.state;
    }

    public void setState(String _State) {
        this.state = _State;
    }

    public String getDistrict() {
        return this.district;
    }

    public void setDistrict(String _district) {
        this.district = _district;
    }

    public String getCity() {
        return this.city;
    }

    public void setCity(String _City) {
        this.city = _City;
    }

    public int getPincode() {
        return this.pincode;// == null ? 0 : Integer.parseInt(this.pincode);
    }

    public String getPincodeAsText() {
        return this.pincode == 0 ? "" : String.valueOf(this.pincode);
    }

    public void setPincode(int _PinCode) {
        this.pincode = _PinCode;
    }

    public String getInwardNumber() {
        return this.inwardNumber;
    }

    public void setInwardNumber(String _InwardNumber) {
        this.inwardNumber = _InwardNumber;
    }

    public String getInwardCreationDate() {
        //Format dtformat = new SimpleDateFormat("dd/MM/yyyy");
        return this.inwardCreationDate;//!= null ? dtformat.format(this.inwardCreationDate) : "";
    }

    public void setInwardCreationDate(String _InwardCreationDate) {
        this.inwardCreationDate = _InwardCreationDate;
    }

    public String getSubscriberId() {
        return this.subscriberId;

    }

    public String getSubscriberIdAsText() {
        return this.subscriberId == null ? "" : this.subscriberId;
    }

    public void setSubscriberId(String _SubscriberId) {
        this.subscriberId = _SubscriberId;
    }

    public String getEmail() {
        if(this.email == null || this.email.length() == 0){
            if(this.subscriberEmail != null){
                return this.subscriberEmail;
            }
        }
        return this.email;
    }

    public void setEmail(String _Email) {
        this.email = _Email;
    }

    public void setSubscriberEmail(String _Email) {
        this.subscriberEmail = _Email;
    }

    public String getInstitution() {
        return this.institution;
    }

    public void setInstitution(String _institution) {

        this.institution = _institution;
    }

    public String getDepartment() {
        return this.department;
    }

    public void setDepartment(String _department) {

        this.department = _department;
    }

    public int getInwardPurposeID() {
        return this.inwardPurposeID;
    }

    public void setInwardPurposeID(int _inwardPurposeID) {
        this.inwardPurposeID = _inwardPurposeID;
    }

    public String getInwardPurpose() {
        return this.inwardPurpose;
    }

    public void setInwardPurpose(String _InwardPurpose) {
        this.inwardPurpose = _InwardPurpose;
    }

    public String getPaymentMode() {
        return this.paymentMode;
    }

    public void setPaymentMode(String _PaymentMode) {
        this.paymentMode = _PaymentMode;
    }

    public String getBankName() {
        return this.bankName;
    }

    public void setBankName(String _BankName) {
        this.bankName = _BankName;
    }

    public int getChqddNumber() {
        return this.chqddNumber;
    }

    public String getChqddNumberAsText() {
        if (this.chqddNumber == 0) {
            return "";
        } else {
            return String.format("%06d", this.chqddNumber);//String.valueOf(this.chqddNumber);

        }

    }

    public void setChqddNumber(int _ChqddNumber) {
        this.chqddNumber = _ChqddNumber;
    }

    public String getPaymentDate() {
        //Format dtformat = new SimpleDateFormat("dd/MM/yyyy");
        return this.paymentDate; // != null ? dtformat.format(this.paymentDate) : "";
    }

    public void setPaymentDate(String _PaymentDate) {
        this.paymentDate = _PaymentDate;
    }

    public float getAmount() {
        return this.amount;
    }

    public void setAmount(float _Amount) {
        this.amount = _Amount;
    }

    public String getCurrency() {
        return this.currency;
    }

    public void setCurrency(String _Currency) {
        this.currency = _Currency;
    }

    public int getReceiptNumber() {
        return this.receiptNumber;
    }

    public String getReceiptNumberAsText() {
        return this.receiptNumber == 0 ? "" : String.valueOf(this.receiptNumber);
    }

    public void setReceiptNumber(int _ReceiptNumber) {
        this.receiptNumber = _ReceiptNumber;
    }

    public boolean isChequeDDReturn() {
        return this.chequeDDReturn;
    }

    public void setChequeDDReturn(boolean _isChequeReturn) {
        this.chequeDDReturn = _isChequeReturn;
    }

    public String getChequeDDReturnReason() {
        return this.chequeDDReturnReason;
    }

    public void setChequeDDReturnReason(String _ChequeReturnReason) {
        this.chequeDDReturnReason = _ChequeReturnReason;
    }

    public String getChequeDDReturnReasonOther() {
        return this.chequeDDReturnReasonOther;
    }

    public void setChequeDDReturnReasonOther(String _ChequeReturnReasonOther) {
        this.chequeDDReturnReasonOther = _ChequeReturnReasonOther;
    }

    public String getAckDate() {
        return this.ackDate;
    }

    public void setAckDate(String _AckDate) {
        this.ackDate = _AckDate;
    }

    public String getReturnDate() {
        return this.returnDate;
    }

    public void setReturnDate(String _ReturnDate) {
        this.returnDate = _ReturnDate;
    }

    public String getRemarks() {
        return this.remarks;
    }

    public void setRemarks(String _Remarks) {
        this.remarks = _Remarks;
    }

    public boolean isCompleted() {
        return this.completed;
    }

    public void setCompleted(boolean _completed) {
        this.completed = _completed;
    }

    public String getLanguage() {
        return this.language;
    }

    public void setLanguage(String _language) {
        this.language = _language;
    }

    public int getSubscriptionID() {
        return this.subscriptionID;
    }

    public String getSubscriptionIDAsText() {
        return this.subscriptionID == 0 ? "" : String.valueOf(this.subscriptionID);
    }

    public void setSubscriptionID(int _subscriptionID) {
        this.subscriptionID = _subscriptionID;
    }

    public int getAgentID() {
        return this.agentID;
    }

    public void setAgentID(int _agentID) {
        this.agentID = _agentID;
    }

    public String getAgentName() {
        return this.agentName;
    }

    public void setAgentName(String _agentName) {
        this.agentName = _agentName;
    }

    public String getReturnReason(){
        /*
         * This is a method to get the consolidated message, if the reason is
         * 'others', it returns the free form text
         */
        String _reason = this.chequeDDReturnReason;
        if(this.chequeDDReturnReason.equalsIgnoreCase("others")){
            _reason = this.chequeDDReturnReasonOther;
        }
        return _reason;
    }
}
