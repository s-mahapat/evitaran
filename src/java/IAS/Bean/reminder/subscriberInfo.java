/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Bean.reminder;

import IAS.Bean.JDSBean;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author aloko
 */
public class subscriberInfo extends JDSBean {

    int subscriber_id;
    int subId;
    String subtypecode   = "";
    String subscriberNumber = "";
    String subscriberName = "";
    int balance;
    int reminderType;
    String reminderDate  = "";
    String department    = "";
    String institution   = "";
    String shippingAddress = "";
    String invoiceAddress = "";
    String city          = "";
    String district      = "";
    String state         = "";
    String country       = "";
    String pincode       = "";
    String email         = "";
    int reminders_id;
    int invoiceNo;
    String invoiceDate  = "";
    String letterNumber = "";
    String letterDate = "";

    List<subscriptionInfo> subscriptionInfo = new ArrayList<subscriptionInfo>();

    /*
    subscriberInfo() {
        subscriptionInfo = new ArrayList<subscriptionInfo>();
    }
    */

    public List<subscriptionInfo> getSubscriptionInfo() {
        return this.subscriptionInfo;
    }

    public void setSubscriptionInfo(List<subscriptionInfo> _subscriptionInfo) {
        this.subscriptionInfo = _subscriptionInfo;
    }

    public int getInvoiceNo() {
        return this.invoiceNo;
    }

    public void setInvoiceNo(int _invoiceNo) {
        this.invoiceNo = _invoiceNo;
    }

    /*Email*/
    public String getInvoicedate() {
        return this.invoiceDate;
    }

    public void setInvoiceDate(String _invoiceDate) {
        this.invoiceDate = _invoiceDate;
    }

    public int getReminders_id() {
        return this.reminders_id;
    }

    public void setReminders_id(int _reminders_id) {
        this.reminders_id = _reminders_id;
    }

    /*Email*/
    public String getEmail() {
        return this.email;
    }

    public void setEmail(String _email) {
        this.email = _email;
    }

    /* Subscriber Pin Code */
    public String getPincode() {
        if(this.pincode.equals("0")){
            return "";
        }else {
            return this.pincode; // == null ? 0 : Integer.parseInt(this.pincode);
        }
    }

    public void setPincode(String _PinCode) {
        this.pincode = _PinCode;
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

    /* Subscriber Address */
    public String getShippingAddress() {
        return this.shippingAddress;
    }

    public void setShippingAddress(String _ShippingAddress) {
        this.shippingAddress = _ShippingAddress;
    }

    /* Invoice Address */
    public String getInvoiceAddress() {
        return this.invoiceAddress;
    }

    public void setInvoiceAddress(String _InvoiceAddress) {
        this.invoiceAddress = _InvoiceAddress;
    }

    /*Institution*/
    public String getInstitution() {
        return this.institution;
    }

    public void setInstitution(String _institution) {
        this.institution = _institution;
    }

    /*Department*/
    public String getDepartment() {
        return this.department;
    }

    public void setDepartment(String _department) {
        this.department = _department;
    }

    public String getReminderDate() {
        return this.reminderDate;
    }

    public void setReminderDate(String _reminderDate) {
        this.reminderDate = _reminderDate;
    }

    public int getReminderType() {
        return this.reminderType;
    }

    public void setReminderType(int _reminderType) {
        this.reminderType = _reminderType;
    }

    public int getBalance() {
        return this.balance;
    }

    public void setBalance(int _balance) {
        this.balance = _balance;
    }

    /* Subscriber Name */
    public String getSubscriberName() {
        return this.subscriberName;
    }

    public void setSubscriberName(String _SubscriberName) {
        this.subscriberName = _SubscriberName;
    }

    public String getSubscriberNumber() {
        return this.subscriberNumber;
    }

    public void setSubscriberNumber(String _SubscriberNumber) {
        this.subscriberNumber = _SubscriberNumber;
    }

    public String getSubtypecode() {
        return this.subtypecode;
    }

    public void setSubtypecode(String _subtypecode) {
        this.subtypecode = _subtypecode;
    }

    public int getSubId() {
        return this.subId;
    }

    public void setSubId(int _subId) {
        this.subId = _subId;
    }

    public int getSubscriber_id() {
        return this.subscriber_id;
    }

    public void setSubscriber_id(int _SubscriberID) {
        this.subscriber_id = _SubscriberID;
    }

    public String getLetterNumber() {
        return this.letterNumber;
    }

    public void setLetterNumber(String _letterNumber) {
        this.letterNumber = _letterNumber;
    }
    
    public String getLetterDate() {
        return this.letterDate;
    }

    public void setLetterDate(String _letterDate) {
        this.letterDate = _letterDate;
    }
}
