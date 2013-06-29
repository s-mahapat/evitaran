/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Bean.missingissue;

import IAS.Bean.missingissue.*;
import IAS.Bean.JDSBean;
import IAS.Class.util;


/**
 *
 * @author I038668
 */
public class milFormBean extends JDSBean {
    
    private String milCreationDate = util.getDateString();
    
        public String getmilCreationDate() {
        //Format dtformat = new SimpleDateFormat("dd/MM/yyyy");
        return this.milCreationDate;//!= null ? dtformat.format(this.inwardCreationDate) : "";
    }

    public void setmilCreationDate(String _milCreationDate) {
        this.milCreationDate = _milCreationDate;
    }

}
