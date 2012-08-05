package IAS.Bean.masterdata;

public class printOrderFormBean {

    /* fields */
    //private int year;
    private int id;
    private String journalName;
    private int year;
    private int issueNo;
    private int printOrder;

/* Methods - Getter and Setter */
public int getId() {
        return (this.id);
    }

public void setId(int _printOrderId) {

        this.id = _printOrderId;
    }

public String getJournalName() {
        return (journalName);
    }

public void setJournalName(String _journalName) {
        this.journalName = _journalName;
    }

public int getYear() {
        return (this.year);
    }

public void setYear(int _year) {
        this.year = _year;
    }

public int getPrintOrder() {
        return (printOrder);
    }

public void setPrintOrder(int _printOrder) {
        this.printOrder = _printOrder;
    }

public int getIssueNo() {
        return (issueNo);
    }

public void setIssueNo(int _issueNo) {
        this.issueNo = _issueNo;
    }
}
