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
public class SubscriptionInfo {

    // Key is page_size, value is journalType
    private HashMap<String, journalType> journalType = new HashMap();

public HashMap<String, journalType> getjournalType() {
        return journalType;
    }
}

