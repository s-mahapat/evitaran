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
    private String invoiceNumber = "";
    private String invoiceCreationDate = util.getDateString();
    private int subscriptionID = 0;

    /*
     * -----------------------------------------------------------------------
     * Invoice ID
     */
    public int getInvoiceID() {
        return this.invoiceID;
    }

    public void setInvoiceID(int _id) {
        this.invoiceID = _id;
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
     */
}
