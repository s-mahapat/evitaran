package IAS.Bean.User;

public class LoggedInUserBean {

    private String userName;
    private String firstName;
    private String lastName;
    
    public String getFirstName(){
        return this.firstName;
    }
    
    public void setFirstName(String _firstName){
        this.firstName = _firstName;
    }
    
    public String getLastName(){
        return this.lastName;
    }
    
    public void setLastName(String _lastName){
        this.lastName = _lastName;
    }
    
    public String getUserName(){
        return this.userName;
    }
    
    public void setUserName(String _userName){
        this.userName = _userName;
    }
}
