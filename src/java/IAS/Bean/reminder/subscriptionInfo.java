/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Bean.reminder;

import IAS.Bean.JDSBean;

/**
 *
 * @author aloko
 */
public class subscriptionInfo extends JDSBean {
    String journalCode   = "";
    String journalName   = "";
    String journalGroupName  = "";
    int copies;
    int startYear;
    int startMonth;
    int endMonth;
    int endYear;

    public int getCopies() {
        return this.copies;
    }

    public void setCopies(int _copies) {
        this.copies = _copies;
    }

    public int getStartMonth() {
        return this.startMonth;
    }

    public void setStartMonth(int _startMonth) {
        this.startMonth = _startMonth;
    }

    public int getEndMonth() {
        return this.endMonth;
    }

    public void setEndMonth(int _endMonth) {
        this.endMonth = _endMonth;
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

    /*Email*/
    public String getJournalGroupName() {
        return this.journalGroupName;
    }

    public void setJournalGroupName(String _journalGroupName) {
        this.journalGroupName = _journalGroupName;
    }

    public String getJournalName() {
        return this.journalName;
    }

    public void setJournalName(String _journalName) {
        this.journalName = _journalName;
    }

    public String getJournalCode() {
        return this.journalCode;
    }

    public void setJournalCode(String _journalCode) {
        this.journalCode = _journalCode;
    }

}
