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
public class priceGroupFormBean extends JDSBean{

        /* fields */
    private int id = 0;
    private String priceGroupName = "";

public int getId() {
        return (this.id);
    }

public void setId(int _Id) {
        this.id = _Id;
    }

public String getPriceGroupName() {
        return (this.priceGroupName);
    }

public void setPriceGroupName(String _PriceGroupName) {
        this.priceGroupName = _PriceGroupName;
    }
}