/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

/**
 *
 * @author Newton
 */
public class InwardInfo {
    
    private String inwardNo;
    private int chqNo;
    private String subNo;
    private String chqDate;
    private Float amount;
    
    public InwardInfo(String _inwardNo, 
            int _chqNo, 
            String _subNo, 
            String _chqDate, 
            Float _amount){
        
        this.inwardNo = _inwardNo;
        this.chqNo = _chqNo;
        this.subNo = _subNo;
        this.chqDate = _chqDate;
        this.amount = _amount;
    }
    
    public int getInstrumentNo(){
        return this.chqNo;
    }
    
    public String getSubscriberNo(){
        return this.subNo;
    }
    
    public float getAmount(){
        return this.amount;
    }
    
    public String getInwardNo(){
        return this.inwardNo;
    }
    
    public String getInstrumentDate(){
        return this.chqDate;
    }
}
