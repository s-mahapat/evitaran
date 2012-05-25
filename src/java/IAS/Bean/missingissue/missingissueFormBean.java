package IAS.Bean.missingissue;
import IAS.Bean.Subscription.*;
import IAS.Bean.JDSBean;

public class missingissueFormBean extends JDSBean{

    private String subscriberNumber;
    private String subscriberName;
    private String inwardNumber;


    public String getSubscriberNumber(){
        return this.subscriberNumber;
    }

    public void setSubscriberNumber(String _subscriberNumber){
        this.subscriberNumber = _subscriberNumber;
    }

    public String getSubscriberName(){
        return this.subscriberName;
    }

    public void setSubscriberName(String _subscriberName){
        this.subscriberName = _subscriberName;
    }

    public String getInwardNumber(){
        return this.inwardNumber;
    }

    public void setInwardNumber(String _inwardNumber){
        this.inwardNumber = _inwardNumber;
    }
    
}
