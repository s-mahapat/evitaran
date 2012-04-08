package IAS.Bean.Subscription;
import IAS.Bean.JDSBean;

public class SubscriptionFormBean extends JDSBean{

    private int subscriptionID;
    private String subscriberNumber;
    private String inwardNumber;
    private float subscriptionTotal;

    public int getSubscriptionID(){
        return this.subscriptionID;
    }

    public void setSubscriptionID(int _id){
        this.subscriptionID = _id;
    }

    public String getSubscriberNumber(){
        return this.subscriberNumber;
    }

    public void setSubscriberNumber(String _subscriberNumber){
        this.subscriberNumber = _subscriberNumber;
    }

    public String getInwardNumber(){
        return this.inwardNumber;
    }

    public void setInwardNumber(String _inwardNumber){
        this.inwardNumber = _inwardNumber;
    }

    public float getSubscriptionTotal(){
        return this.subscriptionTotal;
    }

    public void setSubscriptionTotal(float _value){
        this.subscriptionTotal = _value;
    }

}
