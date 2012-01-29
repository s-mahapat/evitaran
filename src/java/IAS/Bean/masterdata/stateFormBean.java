/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Bean.masterdata;

/**
 *
 * @author Deepali
 */
public class stateFormBean {
    
        /* fields */
    private int stateId = 0;
    private String state = "";
    


public int getStateId() {
        return (this.stateId);
    }

public void setStateId(int _StateId) {
        this.stateId = _StateId;
    }

public String getState() {
        return (this.state);
    }

public void setState(String _State) {
        this.state = _State;
    }
}