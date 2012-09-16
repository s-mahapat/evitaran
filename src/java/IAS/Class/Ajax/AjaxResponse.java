/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class.Ajax;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;
import java.io.IOException;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;

/**
 *
 * @author Shailendra
 */
public class AjaxResponse {       
    
    public String getSuccessXML(boolean isSuccess, String Msg) throws 
            ParserConfigurationException,
            TransformerException,
            IOException{
        
        // create the success object and set the attribute values
        AjaxSuccess ajaxSuccess = new AjaxSuccess();
        ajaxSuccess.setSuccess(isSuccess);
        ajaxSuccess.setMessage(Msg);
        
        XStream xstream = new XStream(new DomDriver());
        xstream.alias("results", AjaxSuccess.class);
        
        String xml = xstream.toXML(ajaxSuccess);
        
        return xml;
  
    }
    
    public void sendXMLResponse(String xml){
        
    }
    

}
