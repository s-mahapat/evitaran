package IAS.Bean.masterdata;

public class printOrderFormBean {

    /* fields */
    private int id = 0;
    private String journalCode = "";
    private String journalName = "";
    private String issnNo = "";
    private int pages = 0;
    private int startYear = 0;
    private int issues = 0;
/* Methods - Getter and Setter */
public int getId() {
        return (this.id);
    }

public void setId(int _Id) {
        this.id = _Id;
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

public String getIssnNo() {
        return (this.issnNo);
    }

public void setIssnNo(String _IssnNo) {
        this.issnNo = _IssnNo;
    }

public int getPages() {
        return (this.pages);
    }

public void setPages(int _Pages) {
        this.pages = _Pages;
    }

public int getStartYear() {
        return (this.startYear);
    }

public void setStartYear(int _StartYear) {
        this.startYear = _StartYear;
    }

public int getIssues() {
        return (this.issues);
    }

public void setIssues(int _Issues) {
        this.issues = _Issues;
    }
}