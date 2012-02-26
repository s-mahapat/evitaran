/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Bean.masterdata;

/**
 *
 * @author Deepali
 */
public class districtFormBean {
    
        /* fields */
    private int id = 0;
    private String district = "";
    


public int getId() {
        return (this.id);
    }

public void setId(int _Id) {
        this.id = _Id;
    }

public String getDistrict() {
        return (this.district);
    }

public void setDistrict(String _District) {
        this.district = _District;
    }
}