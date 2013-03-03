/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Bean.Invoice;

import IAS.Class.util;

/**
 *
 * @author Shailendra Mahapatra
 */
public class InvoiceFormBean {

    private int invoiceID = 0;
    private int inwardID = 0;
    private String inwardNumber = "";
    private int subscriptionID = 0;
    private int subscriberID = 0;
    private String invoiceNumber = "";
    private String invoiceCreationDate = util.getDateString();
    private int subscriptionTotal = 0;
    private String shippingAddress = "";
    private String invoiceAddress = "";
    private String subscriberName;
    private String email;
    private String inwardEmail;
    private String department;
    private String institute;
    private String city;
    private String country;
    private int pincode;
    private String subsciberNumber;
    private int subscriberType;
    private String subscriberTypeText;
    private float balance;
    private float amount;
    private float inwardamount;
    private int invoiceTypeID;

    public int getInvoiceTypeID() {
        return this.invoiceTypeID;
    }

    public void setInvoiceTypeID(int _type) {
        this.invoiceTypeID = _type;
    }

    public float getAmount() {
        return this.amount;
    }

    public void setAmount(float _amount) {
        this.amount = _amount;
    }

    public float getInwardAmount() {
        return this.inwardamount;
    }

    public void setInwardAmount(float _amount) {
        this.inwardamount = _amount;
    }

    public float getBalance() {
        return this.balance;
    }

    public void setBalance(float _balance) {
        this.balance = _balance;
    }

    public int getSubscriberType() {
        return this.subscriberType;
    }

    public void setSubscriberType(int _subtypeid) {
        this.subscriberType = _subtypeid;
    }

    public String getSubscriberTypeText() {
        return this.subscriberTypeText;
    }

    public void setSubscriberTypeText(String _subtypetext) {
        this.subscriberTypeText = _subtypetext;
    }

    public String getEmail() {
        return this.email != null ? this.email : this.getInwardEmail();
    }

    public void setEmail(String _email) {
        this.email = _email;
    }

    public String getInwardEmail() {
        return this.inwardEmail;
    }

    public void setInwardEmail(String _email) {
        this.inwardEmail = _email;
    }

    /*
     * Subscriber Name
     */
    public String getSubscriberName() {
        return this.subscriberName;
    }

    public void setSubscriberName(String _name) {
        this.subscriberName = _name;
    }

    public String getSubscriberNumber() {
        return this.subsciberNumber;
    }

    public void setSubscriberNumber(String _number) {
        this.subsciberNumber = _number;
    }
    /*
     * -----------------------------------------------------------------------
     * Invoice ID
     */

    public int getInvoiceID() {
        return this.invoiceID;
    }

    public void setInvoiceID(int _invoiceID) {
        this.invoiceID = _invoiceID;
    }
    /*
     * -----------------------------------------------------------------------
     * Inward ID
     */

    public int getInwardID() {
        return this.inwardID;
    }

    public void setInwardID(int _inwardID) {
        this.inwardID = _inwardID;
    }

    /*
     * -----------------------------------------------------------------------
     * Inward Number
     */
    public String getInwardNumber() {
        return this.inwardNumber;
    }

    public void setInwardNumber(String _inwardNumber) {
        this.inwardNumber = _inwardNumber;
    }

    /*
     * -----------------------------------------------------------------------
     * Subscription ID
     */
    public int getSubscriptionID() {
        return this.subscriptionID;
    }

    public void setSubscriptionID(int _id) {
        this.subscriptionID = _id;
    }

    /*
     * -----------------------------------------------------------------------
     * Subscriber ID
     */
    public int getSubscriberID() {
        return this.subscriberID;
    }

    public void setSubscriberID(int _subscriberID) {
        this.subscriberID = _subscriberID;
    }

    /*
     * -----------------------------------------------------------------------
     * Invoice Number
     */
    public String getInvoiceNumber() {
        return this.invoiceNumber;
    }

    public void setInvoiceNumber(String _InvoiceNumber) {
        this.invoiceNumber = _InvoiceNumber;
    }

    /*
     * -----------------------------------------------------------------------
     * Invoice Creation Date
     */
    public String getInvoiceCreationDate() {
        return this.invoiceCreationDate;
    }

    public void setInvoiceCreationDate(String _invoiceCreationDate) {
        this.invoiceCreationDate = _invoiceCreationDate;
    }

    /*
     * -----------------------------------------------------------------------
     * Subscription Total
     */
    public int getSubscriptionTotal() {
        return this.subscriptionTotal;
    }

    public void setSubscriptionTotal(int _subscriptionTotal) {
        this.subscriptionTotal = _subscriptionTotal;
    }

    /*
     * -----------------------------------------------------------------------
     * Subscriber Address
     */
    /* Subscriber Address */
    public String getShippingAddress() {
        return this.shippingAddress;
    }

    public void setShippingAddress(String _ShippingAddress) {
        this.shippingAddress = _ShippingAddress;
    }

    public String getInvoiceAddress() {
        return this.invoiceAddress;
    }

    public void setInvoiceAddress(String _InvoiceAddress) {
        this.invoiceAddress = _InvoiceAddress;
    }

    public String getInvoiceAddressForJSP() {
        String invoiceAdd = this.invoiceAddress;
        invoiceAdd = invoiceAdd.replaceAll("\n", "<br>");
        return invoiceAdd;
    }

    public String getDepartment() {
        return this.department;
    }

    public void setDepartment(String _dept) {
        this.department = _dept;
    }

    public String getInstitute() {
        return this.institute;
    }

    public void setInstitute(String _inst) {
        this.institute = _inst;
    }

    public String getCity() {
        return this.city;
    }

    public void setCity(String _city) {
        this.city = _city;
    }

    public String getCountry() {
        return this.country;
    }

    public void setCountry(String _country) {
        this.country = _country;
    }

    public int getPincode() {
        return this.pincode;
    }

    public void setPincode(int _pincode) {
        this.pincode = _pincode;
    }
}
