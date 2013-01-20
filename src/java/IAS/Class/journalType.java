/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import java.util.HashMap;

/**
 *
 * @author aloko
 */
public class journalType {

    // Key is journalCode, value is journalInfo
    private HashMap<String, journalInfo> journalInfo = new HashMap();

    public HashMap<String, journalInfo> getjournalInfo() {
        return journalInfo;
    }

}
