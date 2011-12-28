package IAS.Bean.masterdata;

public class journalFormBean {
    
    /* fields */
    private int journalId = 0;
    private String journalCode = "";
    private String journalName = "";
    private int issnNo = 0;
    private int noOfPages = 0;
    private int startYear = 0;

/* Methods - Getter and Setter */
public int getJournalId() {
        return (this.journalId);
    }

public void setJournalId(int _JournalId) {
        this.journalId = _JournalId;
    }

public String getJournalCode() {
        return (this.journalCode);
    }

public void setJournalCode(String _JournalCode) {
        this.journalCode = _JournalCode;
    }

public String getJournalName() {
        return (this.journalName);
    }

public void setJournalName(String _JournalName) {
        this.journalName = _JournalName;
    }

public int getIssnNo() {
        return (this.issnNo);
    }

public void setIssnNo(int _IssnNo) {
        this.issnNo = _IssnNo;
    }

public int getNoOfPages() {
        return (this.noOfPages);
    }

public void setNoOfPages(int _NoOfPages) {
        this.noOfPages = _NoOfPages;
    }

public int getStartYear() {
        return (this.startYear);
    }

public void setStartYear(int _StartYear) {
        this.startYear = _StartYear;
    }
}