package IAS.Bean;
import IAS.Class.util;

public class inwardFormBean extends JDSBean{

    /* Inward header fields */
    private String from = "";
    private String country = "";
    private String state = "";
    private String city = "";
    private int pincode = 0;
    private String inwardNumber = "";
    private String inwardCreationDate = util.getDateString();
    private int subscriberId = 0;
    private String email = "";
    private String institution="";
    private String department = "";

    /* Inward details fields */
    private String inwardPurpose;
    private String paymentMode;
    private String bankName;
    private int chqddNumber = 0;
    private String paymentDate = util.getDateString();
    private float amount = 0;
    private String currency;
    private int receiptNumber = 0;
    private boolean chequeReturn = false;
    private String chequeReturnReason;
    private String chequeReturnReasonOther;
    private String ackDate;
    private String returnDate;
    private String remarks;

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
        return this.pincode==0 ? "" : String.valueOf(this.pincode);
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
        return this.inwardCreationDate;
    }

    public void setInwardCreationDate(String _InwardCreationDate) {
        this.inwardCreationDate = _InwardCreationDate;
    }

    public int getSubscriberId() {
        return this.subscriberId;

    }

    public String getSubscriberIdAsText() {
        return this.subscriberId==0 ? "" : String.valueOf(this.subscriberId);
    }

    public void setSubscriberId(int _SubscriberId) {
        this.subscriberId = _SubscriberId;
    }

    public String getEmail() {
        return this.email;
    }

    public void setEmail(String _Email) {
        this.email = _Email;
    }

    public String getInstitution(){
        return this.institution;
    }

    public void setInstitution(String _institution){

        this.institution = _institution;
    }

    public String getDepartment(){
        return this.department;
    }

    public void setDepartment(String _department){

        this.department = _department;
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
        if(this.chqddNumber==0){
            return "";
        }else{
            return String.valueOf(this.chqddNumber);
        }

    }

    public void setChqddNumber(int _ChqddNumber) {
        this.chqddNumber = _ChqddNumber;
    }

    public String getPaymentDate() {
        return this.paymentDate;
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
        return this.amount==0 ? "" : String.valueOf(this.receiptNumber);
    }

    public void setReceiptNumber(int _ReceiptNumber) {
        this.receiptNumber = _ReceiptNumber;
    }

    public boolean isChequeReturn() {
        return this.chequeReturn;
    }

    public void  setChequeReturn(boolean  _isChequeReturn) {
        this.chequeReturn = _isChequeReturn;
    }

    public String getChequeReturnReason() {
        return this.chequeReturnReason;
    }

    public void setChequeReturnReason(String _ChequeReturnReason) {
        this.chequeReturnReason = _ChequeReturnReason;
    }

    public String getChequeReturnReasonOther() {
        return this.chequeReturnReasonOther;
    }

    public void setChequeReturnReasonOther(String _ChequeReturnReasonOther) {
        this.chequeReturnReasonOther = _ChequeReturnReasonOther;
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
}
