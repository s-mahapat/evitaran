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
    private int id = 0;
    private String country = "";
    

public int getId() {
        return (this.id);
    }

public void setId(int _Id) {
        this.id = _Id;
    }

public String getCountry() {
        return (this.country);
    }

public void setCountry(String _Country) {
        this.country = _Country;
    }
}