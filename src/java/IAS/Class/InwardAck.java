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
public class InwardAck {

    private PropertyReader _prop = null;

    public InwardAck() throws IOException{
        ServletContext context = ServletContextInfo.getServletContext();
        InputStream _stream = context.getResourceAsStream("/WEB-INF/classes/pdf_templates.properties");
        _prop = new PropertyReader(_stream);
    }

    public String getText(String _cheque, String _cheque_date, float amount, String paymentmode, int purposeid, String purpose, String letter_no, String letter_date){
        String _text = null;
        if(amount > 0 && purposeid != JDSConstants.INWARD_PURPOSE_REQUEST_FOR_INVOICE){
            _text = _prop.getProperty("inward_ack_with_amount");
            _text  = String.format(_text, letter_no, letter_date, _cheque, _cheque_date, amount, purpose);
        }else if(amount == 0 && purposeid != JDSConstants.INWARD_PURPOSE_REQUEST_FOR_INVOICE){
            _text = _prop.getProperty("inward_ack_no_amount");
            _text  = String.format(_text, purpose);
        }else if(amount > 0 && purposeid == JDSConstants.INWARD_PURPOSE_REQUEST_FOR_INVOICE){
            _text = _prop.getProperty("inward_ack_invoice_with_amount");
            _text  = String.format(_text, paymentmode, _cheque, amount, purpose);
        }else if(amount == 0 && purposeid == JDSConstants.INWARD_PURPOSE_REQUEST_FOR_INVOICE){
            _text = _prop.getProperty("inward_ack_invoice_no_amount");
            _text  = String.format(_text, purpose);
        }
        return _text;
    }
}
