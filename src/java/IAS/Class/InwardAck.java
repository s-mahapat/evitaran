/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import java.io.IOException;

/**
 *
 * @author smahapat
 */
public class InwardAck {

    /*
     * Factory method to get an instance of inward acknowledgment object
     * @param purposeid the inward purpose ID
     * @param paymentID the payment id
     * @return an instance of IInwardAcknowledgement
     */
    public IInwardAcknowledgement getInwardAckInstance(int purposeid, int paymentModeID) throws IOException {
        IInwardAcknowledgement inwardAckObj;
        if (purposeid == JDSConstants.INWARD_PURPOSE_REQUEST_FOR_INVOICE) {
            inwardAckObj = new RequestForInvoiceAcknowledgement();
        } else if (paymentModeID == JDSConstants.PAYMENT_MODE_BANK_TRANSFER
                || paymentModeID == JDSConstants.PAYMENT_MODE_MONEY_ORDER) {
            inwardAckObj = new ConfirmedPaymentAcknowledgment();
        } else if (paymentModeID == JDSConstants.PAYMENT_MODE_CASH) {
            inwardAckObj = new CashPaymentAcknowledgment();
        } else {
            inwardAckObj = new InwardAcknowledgement();
        }
        return inwardAckObj;
    }

    /*
     * Returns the text that should be printed in the pdf or email for inward ack
     */
    public String getText(String _cheque, String _cheque_date, float amount, int paymentModeID, int purposeid, String letter_no, String letter_date) {
        String _text;
        IInwardAcknowledgement inwardAckObj;
        try {
            inwardAckObj = this.getInwardAckInstance(purposeid, paymentModeID);
            _text = inwardAckObj.getAcknowledgementText(purposeid, paymentModeID, _cheque, _cheque_date, amount, letter_no, letter_date);

        } catch (IOException ex) {
            _text = ex.getMessage();
        }

        return _text;
    }
}
