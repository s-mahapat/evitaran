/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Bean.masterdata;

/**
 *
 * @author Deepali
 */
public class cityFormBean {
    
        /* fields */
    private int cityId = 0;
    private String city = "";
    


public int getCityId() {
        return (this.cityId);
    }

public void setCityId(int _CityId) {
        this.cityId = _CityId;
    }

public String getCity() {
        return (this.city);
    }

public void setCity(String _City) {
        this.city = _City;
    }
}