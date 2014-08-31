/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class.Ajax;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;

/**
 *
 * @author Shailendra
 */
public class AjaxResponse {

    public String getSuccessXML(boolean isSuccess, String Msg) {

        // create the success object and set the attribute values
        AjaxSuccess ajaxSuccess = new AjaxSuccess();
        ajaxSuccess.setSuccess(isSuccess);
        ajaxSuccess.setMessage(Msg);
        XStream xstream = new XStream(new DomDriver());
        xstream.alias("results", AjaxSuccess.class);
        String xml = xstream.toXML(ajaxSuccess);
        return xml;

    }

    public String getXMLFromObject(Object obj) {
        XStream xstream = new XStream(new DomDriver());
        String xml = xstream.toXML(obj);
        return xml;
    }

}
