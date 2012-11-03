/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Bean.reminder;

import IAS.Bean.MailingList.*;
import IAS.Bean.JDSBean;
import IAS.Class.util;


/**
 *
 * @author I038668
 */
public class reminderFormBean  {

    private String reminderDate = util.getDateString();

        public String getreminderDate() {
        //Format dtformat = new SimpleDateFormat("dd/MM/yyyy");
        return this.reminderDate;//!= null ? dtformat.format(this.inwardCreationDate) : "";
    }

    public void setreminderDate(String _reminderDate) {
        this.reminderDate = _reminderDate;
    }

}
