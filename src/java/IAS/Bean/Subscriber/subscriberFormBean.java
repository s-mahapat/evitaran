package IAS.Bean.Subscriber;

import IAS.Bean.JDSBean;
import IAS.Class.util;

public class subscriberFormBean extends JDSBean {

    private String subscriberNumber = "";
    private int subscriberID;
    private String subscriberCreationDate = util.getDateString();
    private String subscriberName = "";
    private String invoiceAddress = "";
    private String shippingAddress = "";    
    private String city = "";
    private String district = "";
    private String state = "";
    private String country = "";
    private int pincode = 0;
    private String subtype = "";
    private String subtypedesc = "";
    private String department = "";
    private String institution = "";
    private String email = "";
    private String agent = "";
    private boolean deactive = false;
    private String deactivationDate;
    private boolean sameInvoiceAddress = false;
    private int subtypeID;


    /* Subscriber ID */
    public String getSubscriberNumber() {
        return this.subscriberNumber;
    }

    public void setSubscriberNumber(String _SubscriberNumber) {
        this.subscriberNumber = _SubscriberNumber;
    }
    
    public int getSubscriberID() {
        return this.subscriberID;
    }

    public void setSubscriberID(int _SubscriberID) {
        this.subscriberID = _SubscriberID;
    }
    
    public int getSubtypeID() {
        return this.subtypeID;
    }

    public void setSubtypeID(int _setSubtypeID) {
        this.subtypeID = _setSubtypeID;
    }


    /* Subscriber Creation Date */
    public String getSubscriberCreationDate() {
        return this.subscriberCreationDate;
    }

    public void setSubscriberCreationDate(String _SubscriberCreationDate) {
        this.subscriberCreationDate = _SubscriberCreationDate;
    }

    /* Subscriber Name */
    public String getSubscriberName() {
        return this.subscriberName;
    }

    public void setSubscriberName(String _SubscriberName) {
        this.subscriberName = _SubscriberName;
    }

    /* Subscriber Address */
    public String getShippingAddress() {
        return this.shippingAddress;
    }

    public void setShippingAddress(String _ShippingAddress) {
        this.shippingAddress = _ShippingAddress;
    }
    
    public String getInvoiceAddress() {
        if(this.sameInvoiceAddress == true){
            return this.shippingAddress;
        }
        return this.invoiceAddress;
    }

    public void setInvoiceAddress(String _InvoiceAddress) {
        this.invoiceAddress = _InvoiceAddress;
    }

    /* Subscriber City */
    public String getCity() {
        return this.city;
    }

    public void setCity(String _city) {
        this.city = _city;
    }


    /* Subscriber District */
    public String getDistrict() {
        String lclDistrict = "";
        if (this.district == null || this.district.equals("0")) {
            lclDistrict = "";
        } else {
            lclDistrict = this.district;
        }
        return lclDistrict;

        //return this.district == null ? "" : this.district;
    }

    public void setDistrict(String _district) {
        this.district = _district;
    }

    /* Subscriber State */
    public String getState() {
        return this.state;
    }

    public void setState(String _state) {
        this.state = _state;
    }

    /* Subscriber Country */
    public String getCountry() {
        return this.country;
    }

    public void setCountry(String _country) {
        this.country = _country;
    }


    /* Subscriber Pin Code */
    public int getPincode() {
        return this.pincode;// == null ? 0 : Integer.parseInt(this.pincode);
    }

    public String getPincodeAsText() {
        return this.pincode == 0 ? "" : String.valueOf(this.pincode);
    }

    public void setPincode(int _PinCode) {
        this.pincode = _PinCode;
    }

    /*Subscriber Type*/
    public String getSubtype() {
        return this.subtype;
    }

    public void setSubtype(String _subtype) {
        this.subtype = _subtype;
    }

    /*Subscriber Type Description*/
    public String getSubtypedesc() {
        return this.subtypedesc;
    }

    public void setSubtypedesc(String _subtypedesc) {
        this.subtypedesc = _subtypedesc;
    }

    /*Department*/
    public String getDepartment() {
        return this.department;
    }

    public void setDepartment(String _department) {
        this.department = _department;
    }

    /*Institution*/
    public String getInstitution() {
        return this.institution;
    }

    public void setInstitution(String _institution) {
        this.institution = _institution;
    }

    /*Email*/
    public String getEmail() {
        return this.email;
    }

    public void setEmail(String _email) {
        this.email = _email;
    }

    public void setAgentName(String _agent){
        this.agent = _agent;
    }

    public String getAgentName(){
        return this.agent;
    }

    public void setDeactive(boolean _deactive){
        this.deactive = _deactive;
    }

    public boolean isDeactive(){
        return this.deactive;
    }

    public String getDeactivationDate() {
        return this.deactivationDate;
    }

    public void setDeactivationDate(String _deactivationDate){
        this.deactivationDate = _deactivationDate;
    }
    
    public boolean isSameInvoiceAddress(){
        return this.sameInvoiceAddress;
    }
    
    public void setSameInvoiceAddress(boolean _sameInvoiceAddress){
        this.sameInvoiceAddress = _sameInvoiceAddress;
    }

}
