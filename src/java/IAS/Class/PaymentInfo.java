/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

/**
 *
 * @author smahapat
 */
public class PaymentInfo {

    private int id;
    private int invoiceID;
    private String inwardNumber;
    private float paymentAmount;
    private String paymentDate;
    private String paymentMode;
    private String chqddNumber;

    public int getId(){
        return this.id;
    }

    public void setId(int _id){
        this.id = _id;
    }

    public float getPaymentAmount(){
        return this.paymentAmount;
    }

    public void setPaymentAmount(float _in){
        this.paymentAmount = _in;
    }

    public int getInvoiceID(){
        return this.invoiceID;
    }

    public void setInvoiceID(int _id){
        this.id = invoiceID;
    }

    public String getInwardNumber(){
        return this.inwardNumber;
    }

    public void setInwardNumber(String _inward){
        this.inwardNumber = _inward;
    }

    public String getPaymentDate(){
        return this.paymentDate;
    }

    public void setPaymentDate(String _in){
        this.paymentDate = _in;
    }

    public String getPaymentMode(){
        return this.paymentMode;
    }

    public void setPaymentMode(String _in){
        this.paymentMode = _in;
    }

    public String getChqddNumber(){
        return this.chqddNumber;
    }

    public void setChqddNumber(String _in){
        this.chqddNumber = _in;
    }

}
