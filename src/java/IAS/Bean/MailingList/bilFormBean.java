/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Bean.MailingList;

import IAS.Bean.JDSBean;
import IAS.Class.util;


/**
 *
 * @author I038668
 */
public class bilFormBean extends JDSBean {
    
    private String bilCreationDate = util.getDateString();
    
        public String getbilCreationDate() {
        //Format dtformat = new SimpleDateFormat("dd/MM/yyyy");
        return this.bilCreationDate;//!= null ? dtformat.format(this.inwardCreationDate) : "";
    }

    public void setbilCreationDate(String _bilCreationDate) {
        this.bilCreationDate = _bilCreationDate;
    }

}
