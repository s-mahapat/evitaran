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
    
    private String mlCreationDate = util.getDateString();
    
        public String getMlCreationDate() {
        //Format dtformat = new SimpleDateFormat("dd/MM/yyyy");
        return this.mlCreationDate;//!= null ? dtformat.format(this.inwardCreationDate) : "";
    }

    public void setMlCreationDate(String _mlCreationDate) {
        this.mlCreationDate = _mlCreationDate;
    }

}
