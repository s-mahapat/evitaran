/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Bean.masterdata;

import IAS.Bean.JDSBean;

/**
 *
 * @author Deepali
 */
public class cityFormBean extends JDSBean{

        /* fields */
    private int id = 0;
    private String city = "";

public int getId() {
        return (this.id);
    }

public void setId(int _Id) {
        this.id = _Id;
    }

public String getCity() {
        return (this.city);
    }

public void setCity(String _City) {
        this.city = _City;
    }
}