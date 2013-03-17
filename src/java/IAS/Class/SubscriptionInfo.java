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
    private int subscriptionNumber;
    private SubscriberInfo subscriberInfo;

    public HashMap<String, journalType> getjournalType() {
        return journalType;
    }
    
    public int getSubscriptionNumber(){
        return this.subscriptionNumber;
    }
    
    public void setSubscriptionNumber(int _SubscriptionNumber){
        this.subscriptionNumber = _SubscriptionNumber;
    }
    
    public SubscriberInfo getSubscriberInfo(){
        return this.subscriberInfo;
    }
    
    public void setSubscriberInfo(SubscriberInfo _subscriberInfo){
        this.subscriberInfo = _subscriberInfo;
    }
    
}
