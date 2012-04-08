/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Bean.Subscription;

import IAS.Bean.JDSBean;

/**
 *
 * @author Shailendra Mahapatra
 */
public class SubscriptionDetailBean extends JDSBean{
    private int[] copies;
    private int[] startYear;
    private int[] endYear;
    private float[] total;
    private String[] journalGroupID;

    public int[] getCopies(){
        return this.copies;
    }

    public void setCopies(int[] _copies){
        this.copies = _copies;
    }

    public int[] getStartYear(){
        return this.startYear;
    }

    public void setStartYear(int[] _startYear){
        this.startYear = _startYear;
    }

    public int[] getEndYear(){
        return this.endYear;
    }

    public void setEndYear(int[] _endYear){
        this.endYear = _endYear;
    }

    public float[] getTotal(){
        return this.total;
    }

    public void setTotal(float[] _total){
        this.total = _total;
    }

    public String[] getJournalGroupID(){
        return this.journalGroupID;
    }

    public void setJournalGroupID(String[] _journalgrps){
        this.journalGroupID = _journalgrps;
    }


}
