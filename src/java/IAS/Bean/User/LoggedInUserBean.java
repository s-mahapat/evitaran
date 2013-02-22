package IAS.Bean.User;

public class LoggedInUserBean {

    private String userName;
    private String firstName;
    private String lastName;
    private boolean isPasswordReset;
    private String userRole;
    
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
    
    public boolean isIsPasswordReset(){
        return this.isPasswordReset;
    }
    
    public void setIsPasswordReset(boolean _isreset){
        this.isPasswordReset = _isreset;
    }
    
        public String getUserRole(){
        return this.userRole;
    }
    
    public void setUserRole(String _userRole){
        this.userRole = _userRole;
    }
}
