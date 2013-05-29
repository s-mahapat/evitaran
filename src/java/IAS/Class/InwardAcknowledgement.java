/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import java.io.IOException;
import java.io.InputStream;
import javax.servlet.ServletContext;

/**
 *
 * @author smahapat
 */
public class InwardAcknowledgement implements IInwardAcknowledgement {

    private PropertyReader prop = null;

    public InwardAcknowledgement() throws IOException {
        ServletContext context = ServletContextInfo.getServletContext();
        InputStream _stream = context.getResourceAsStream("/WEB-INF/classes/pdf_templates.properties");
        prop = new PropertyReader(_stream);
    }

    public PropertyReader getPropertyFile() {
        return this.prop;
    }

    @Override
    public String getAcknowledgementText(int inwardPurposeID, int paymentModeID, String cheque, String chequeDate, float amount, String letterNo, String letterDate) {
        JDSConstants constants = new JDSConstants();
        String letterBodyText = null;
        String paymentModeText = constants.getPaymentText(paymentModeID);
        String _text;
        String purposeText = constants.getInwardPurpose(inwardPurposeID);

        //if the letter number if not null we need to add it to the text
        if (letterNo.length() > 0) {
            letterBodyText = String.format(prop.getProperty("inward_letter_received_ack"), letterNo, letterDate);
        }

        // if the amount > 0 append the corresponding text to the previous statement
        if (amount > 0) {
            _text = String.format(prop.getProperty("inward_cheque_received_ack"), paymentModeText, cheque, chequeDate, amount, paymentModeText);
        } else {
            _text = String.format(prop.getProperty("inward_no_amount_ack"), purposeText);
        }
        letterBodyText = letterBodyText == null ? _text : letterBodyText + _text;
        return letterBodyText;
    }
}
