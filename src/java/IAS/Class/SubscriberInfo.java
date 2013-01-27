/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import java.util.ArrayList;
import java.util.HashMap;

/**
 *
 * @author aloko
 */
public class SubscriberInfo {
    // Key is subscriptionId, value is SubscriptionInfo
    private HashMap<String, SubscriptionInfo> SubscriptionInfo = new HashMap();
    private subInfo sLabelInfo;

public subInfo getSubscriberLabelInfo() {
        return (this.sLabelInfo);
    }

public void setSubscriberLabelInfo(subInfo _SubscriberLabelInfo) {
        this.sLabelInfo = _SubscriberLabelInfo;
    }

public HashMap<String, SubscriptionInfo> getSubscriberInfo() {
    return SubscriptionInfo;
}

}
