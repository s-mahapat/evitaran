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
    private int districtId = 0;
    private String district = "";
    


public int getDistrictId() {
        return (this.districtId);
    }

public void setDistrict(int _DistrictId) {
        this.districtId = _DistrictId;
    }

public String getDistrict() {
        return (this.district);
    }

public void setDistrict(String _District) {
        this.district = _District;
    }
}