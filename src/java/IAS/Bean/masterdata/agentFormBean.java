package IAS.Bean.masterdata;
import IAS.Class.util;

public class agentFormBean {
    
    /* fields */
    private int agentId = 0;
    private String agentName = "";
    private String regDate = util.getDateString();
    private String emailId = "";
    private String address = "";
    private int cityId = 0;
    private int districtId = 0;
    private int stateId = 0;
    private int countryId = 0;
    private int pincode = 0;
    
    /* Methods getter and setter*/
    
public int getAgentId() {
        return this.agentId;
    }

public void setAgentId(int _AgentId) {
        this.agentId = _AgentId;
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

public int getCityId() {
        return (this.cityId);
    }

public void setCityId(int _CityId) {
        this.cityId = _CityId;
    }

public int getDistrictId() {
        return (this.districtId);
    }

public void setDistrictId(int _DistrictId) {
        this.districtId = _DistrictId;
    }

public int getStateId() {
        return (this.stateId);
    }

public void setStateId(int _StateId) {
        this.stateId = _StateId;
    }

public int getCountryId() {
        return (this.countryId);
    }

public void setCountryId(int _CountryId) {
        this.countryId = _CountryId;
    }

public int getPincode() {
        return (this.pincode);
    }

public void setPincode(int _Pincode) {
        this.pincode = _Pincode;
    }
}