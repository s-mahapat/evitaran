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
    private String subscriberAddress = "";
    private String subscriberName;
    private String email;

    
    public String getEmail(){
        return this.email;
    }
    
    public void setEmail(String _email){
        this.email = _email;
    }
    
    /*
     * Subscriber Name
     */
    public String getSubscriberName(){
        return this.subscriberName;
    }
    
    public void setSubscriberName(String _name){
        this.subscriberName = _name;
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
    public String getSubscriberAddress() {
        return this.subscriberAddress;
    }

    public void setSubscriberAddress(String _subscriberAddress) {
        this.subscriberAddress = _subscriberAddress;
    }
    /*
     * -----------------------------------------------------------------------
     */
}
