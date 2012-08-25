package IAS.Bean.Reports;

import IAS.Bean.JDSBean;

public class statementFormBean {

    /* fields */

    private String journalName = "";
    private int issue = 0;
    private int year = 0;

    /* Methods getter and setter*/

public String getJournalName() {
        return this.journalName;
    }

public void setJournalName(String _JournalName) {
        this.journalName = _JournalName;
    }

public int getIssue() {
        return (this.issue);
    }

public void setIssue(int _Issue) {
        this.issue = _Issue;
    }

public int getYear() {
        return this.year;
    }

public void setYear(int _Year) {
        this.year = _Year;
    }
}