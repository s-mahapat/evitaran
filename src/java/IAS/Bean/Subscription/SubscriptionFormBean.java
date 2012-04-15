package IAS.Bean.Subscription;
import IAS.Bean.JDSBean;

public class SubscriptionFormBean extends JDSBean{

    private int subscriptionID;
    private String subscriberNumber;
    private String inwardNumber;
    private float subscriptionTotal;
    private float amount;
    private float balance;

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

    public float getAmount(){
        return this.amount;
    }

    public void setAmount(float _value){
        this.amount = _value;
    }

    public float getBalance(){
        return this.balance;
    }

    public void setBalance(float _value){
        this.balance = _value;
    }

}
