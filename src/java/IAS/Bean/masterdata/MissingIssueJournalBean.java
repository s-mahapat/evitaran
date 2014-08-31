/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Bean.masterdata;

/**
 *
 * @author Shailendra
 */
public class MissingIssueJournalBean {

    private int id;
    private int mailinglistid;
    private String subscriberNumber;
    private String subscriberName;
    private String journalCode;
    private String journalName;
    private int year;
    private int volumeNo;
    private int issue;
    private int missingCopies;

    public String getSubscriberNumber() {
        return this.subscriberNumber;
    }

    public void setSubscriberNumber(String val) {
        this.subscriberNumber = val;
    }

    public String getSubscriberName() {
        return this.subscriberName;
    }

    public void setSubscriberName(String val) {
        this.subscriberName = val;
    }

    public String getJournalCode() {
        return this.journalCode;
    }

    public void setJournalCode(String val) {
        this.journalCode = val;
    }

    public String getJournalName() {
        return this.journalName;
    }

    public void setJournalName(String val) {
        this.journalName = val;
    }

    public int getId() {
        return this.id;
    }

    public void setId(int val) {
        this.id = val;
    }

    public int getMailinglistid() {
        return this.mailinglistid;
    }

    public void setMailinglistid(int val) {
        this.mailinglistid = val;
    }

    public int getYear() {
        return this.year;
    }

    public void setYear(int val) {
        this.year = val;
    }

    public int getVolumeNo() {
        return this.volumeNo;
    }

    public void setVolumeNo(int val) {
        this.volumeNo = val;
    }

    public int getIssue() {
        return this.issue;
    }

    public void setIssue(int val) {
        this.issue = val;
    }

    public int getMissingCopies() {
        return this.missingCopies;
    }

    public void setMissingCopies(int val) {
        this.missingCopies = val;
    }

}
