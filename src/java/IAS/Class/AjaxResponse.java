/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import java.io.IOException;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;

/**
 *
 * @author Shailendra
 */
public class AjaxResponse {
    
    public String getSuccessXML(boolean isSuccess) throws 
            ParserConfigurationException,
            TransformerException,
            IOException{
        
        String _val = isSuccess == true ? "1" : "0";
        return util.convertStringToXML(_val, "success");
    }
    
    public void sendXMLResponse(String xml){
        
    }
    

}
