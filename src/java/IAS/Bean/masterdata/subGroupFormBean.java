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
public class subGroupFormBean extends JDSBean{

        /* fields */
    private int id = 0;
    private String subGroupName = "";

public int getId() {
        return (this.id);
    }

public void setId(int _Id) {
        this.id = _Id;
    }

public String getSubGroupName() {
        return (this.subGroupName);
    }

public void setPriceGroupName(String _SubGroupName) {
        this.subGroupName = _SubGroupName;
    }
}