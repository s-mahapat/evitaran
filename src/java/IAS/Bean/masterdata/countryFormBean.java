/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Bean.masterdata;

import IAS.Bean.*;

/**
 *
 * @author Deepali
 */
public class countryFormBean extends JDSBean{
    
        /* fields */
    private int countryId;
    private String country = "";
    

public int getCountryId() {
        return (this.countryId);
    }

public void setCountryId(int _CountryId) {
        this.countryId = _CountryId;
    }

public String getCountry() {
        return (this.country);
    }

public void setCountry(String _Country) {
        this.country = _Country;
    }
}