/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Bean.Subscription;

/**
 *
 * @author Shailendra
 */
public class SubscriptionDetail {

    private int copies;
    private int startYear;
    private int endYear;
    private int total;
    private int journalGroupID;
    private int journalID;
    private int subscriptionID;
    private String journalName;
    private int startMonth;
    private int period;
    private float rate;
    private int endMonth;
    private int subType;

    public int getCopies() {
        return this.copies;
    }

    public void setCopies(int _copies) {
        this.copies = _copies;
    }

    public int getStartYear() {
        return this.startYear;
    }

    public void setStartYear(int _startYear) {
        this.startYear = _startYear;
    }

    public int getEndYear() {
        return this.endYear;
    }

    public void setEndYear(int _endYear) {
        this.endYear = _endYear;
    }

    public int getTotal() {
        return this.total;
    }

    public void setTotal(int _total) {
        this.total = _total;
    }

    public int getJournalGroupID() {
        return this.journalGroupID;
    }

    public void setJournalGroupID(int _journalgrpid) {
        this.journalGroupID = _journalgrpid;
    }

    public int getJournalID() {
        return this.journalID;
    }

    public void setJournalID(int _journalid) {
        this.journalID = _journalid;
    }

    public int getsubscriptionID() {
        return this.subscriptionID;
    }

    public void setsubscriptionID(int _subscriptionid) {
        this.subscriptionID = _subscriptionid;
    }

    public String getJournalName() {
        return this.journalName;
    }

    public void setJournalName(String _journalName) {
        this.journalName = _journalName;
    }

    public int getStartMonth() {
        return this.startMonth;
    }

    public void setStartMonth(int _month) {
        this.startMonth = _month;
    }

    public int getEndMonth() {
        return this.endMonth;
    }

    public void setEndMonth(int _month) {
        this.endMonth = _month;
    }

    public int getPeriod() {
        return this.period;
    }

    public void setPeriod(int _period) {
        this.period = _period;
    }

    public float getRate() {
        return this.rate;
    }

    public void setRate(float _rate) {
        this.rate = _rate;
    }

    public int getSubType() {
        return this.subType;
    }

    public void setSubType(int _val) {
        this.subType = _val;
    }
}
