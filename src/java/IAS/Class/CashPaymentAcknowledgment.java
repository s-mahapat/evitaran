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
public class CashPaymentAcknowledgment extends InwardAcknowledgement {

    public CashPaymentAcknowledgment() throws IOException {
        //super();
    }

    @Override
    public String getAcknowledgementText(int inwardPurposeID, int paymentModeID, String cheque, String chequeDate, float amount, String letterNo, String letterDate) {
        JDSConstants constants = new JDSConstants();
        String letterBodyText = null;
        //String paymentModeText = constants.getPaymentText(paymentModeID);
        String _text;
        String purposeText = constants.getInwardPurpose(inwardPurposeID);

        //if the letter number if not null we need to add it to the text
        if (letterNo.length() > 0) {
            letterBodyText = String.format(this.getPropertyFile().getProperty("inward_letter_received_ack"), letterNo, letterDate);
        }

        // if the amount > 0 append the corresponding text to the previous statement
        if (amount > 0) {
            _text = String.format(this.getPropertyFile().getProperty("cash_payment_ack"), chequeDate, amount);
            letterBodyText = letterBodyText == null ? _text : letterBodyText + _text;
        } else {
            letterBodyText = String.format(this.getPropertyFile().getProperty("inward_no_amount_ack"), purposeText);
        }

        return letterBodyText;
    }
}
