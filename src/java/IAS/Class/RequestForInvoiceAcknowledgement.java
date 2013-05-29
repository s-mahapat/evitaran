/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import java.io.IOException;

/**
 * Class for acknowledgment of request for invoice
 * @author smahapat
 */
public class RequestForInvoiceAcknowledgement extends InwardAcknowledgement{

    public RequestForInvoiceAcknowledgement() throws IOException{

    }

    @Override
    public String getAcknowledgementText(int inwardPurposeID, int paymentModeID, String cheque, String chequeDate, float amount, String letterNo, String letterDate){
        String letterBodyText = super.getAcknowledgementText(inwardPurposeID, paymentModeID, cheque, chequeDate, amount, letterNo, letterDate);

        // append the invoice statement
        letterBodyText += this.getPropertyFile().getProperty("invoice_ack");

        return letterBodyText;
    }
}
