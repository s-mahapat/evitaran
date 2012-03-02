package IAS.Bean.masterdata;

public class agentFormBean {

    /* fields */
    private int id = 0;
    private String agentName = "";
    private String regDate = null;
    private String emailId = "";
    private String address = "";
    private String city = "";
    private String district = "";
    private String state = "";
    private String country = "";
    private int pinCode = 0;
    private int discount = 0;

    /* Methods getter and setter*/

public int getId() {
        return this.id;
    }

public void setId(int _id) {
        this.id = _id;
    }

public String getAgentName() {
        return this.agentName;
    }

public void setAgentName(String _AgentName) {
        this.agentName = _AgentName;
    }

public String getRegDate() {
        return this.regDate;
    }

public void setRegDate(String _RegDate) {
        this.regDate = _RegDate;
    }

public String getEmailId() {
        return this.emailId;
}

public void setEmailId(String _EmailId) {
        this.emailId = _EmailId;
    }

public String getAddress() {
        return this.address;
}

public void setAddress(String _Address) {
        this.address = _Address;
    }

public String getCity() {
        return this.city;
    }

public void setCity(String _City) {
        this.city = _City;
    }

public String getDistrict() {
        return this.district;
    }

public void setDistrict(String _District) {
        this.district = _District;
    }

public String getState() {
        return this.state;
    }

public void setState(String _State) {
        this.state = _State;
    }

public String getCountry() {
        return (this.country);
    }

public void setCountry(String _Country) {
        this.country = _Country;
    }

public int getPinCode() {
        return (this.pinCode);
    }

public void setPinCode(int _PinCode) {
        this.pinCode = _PinCode;
    }

public int getDiscount() {
        return this.discount;
    }

public void setDiscount(int _Discount) {
        this.discount = _Discount;
    }
}