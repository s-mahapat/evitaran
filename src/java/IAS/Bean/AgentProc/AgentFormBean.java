/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Bean.AgentProc;

import IAS.Bean.JDSBean;

public class AgentFormBean extends JDSBean {

    private int agentID = 0;
    private String agentName = "";
    private String inwardNumber = "";
    private int inwardID = 0;

    public int getInwardID() {
        return this.inwardID;
    }

    public void setInwardID(int _inwardID) {
        this.inwardID = _inwardID;
    }

    public String getInwardNumber() {
        return this.inwardNumber;
    }

    public void setInwardNumber(String _InwardNumber) {
        this.inwardNumber = _InwardNumber;
    }

    public int getAgentID() {
        return this.agentID;
    }

    public void setAgentID(int _agentID) {
        this.agentID = _agentID;
    }

    public String getagentName() {
        return this.agentName;
    }

    public void setagentName(String _agentName) {
        this.agentName = _agentName;
    }
}
