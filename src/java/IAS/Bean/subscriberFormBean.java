package IAS.Bean;

import IAS.Class.util;

public class subscriberFormBean extends JDSBean {

    private String subscriberNumber = "";
    private String subscriberCreationDate = util.getDateString();
    private String subscriberName = "";
    private String subscriberAddress = "";
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


    /* Subscriber ID */
    public String getSubscriberNumber() {
        return this.subscriberNumber;
    }

    public void setSubscriberNumber(String _SubscriberNumber) {
        this.subscriberNumber = _SubscriberNumber;
    }


    /* Subscriber Creation Date */
    public String getSubscriberCreationDate() {
        return this.subscriberCreationDate;
    }

    public void setInwardCreationDate(String _SubscriberCreationDate) {
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
    public String getSubscriberAddress() {
        return this.subscriberAddress;
    }

    public void setSubscriberAddress(String _SubscriberAddress) {
        this.subscriberAddress = _SubscriberAddress;
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
        if (this.district == null || this.district == "0") {
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

    public IAS.Bean.subscriberFormBean Clone() {
        return this;
    }
}
