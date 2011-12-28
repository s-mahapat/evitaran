/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Bean.masterdata;

/**
 *
 * @author Deepali
 */
public class countryFormBean {
    
        /* fields */
    private int countryId = 0;
    private String country = "";
    


public int getCountryId() {
        return (this.countryId);
    }

public void setCountry(int _CountryId) {
        this.countryId = _CountryId;
    }

public String getCountry() {
        return (this.country);
    }

public void setCountry(String _Country) {
        this.country = _Country;
    }
}