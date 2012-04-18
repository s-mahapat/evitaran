package IAS.Bean.masterdata;

public class printOrderFormBean {

    /* fields */
    //private int year;
    private int id;
    private String journalCode;
    private String journalName;
    private int year;
    private int issues;
    private int printOrder;
    private int annualPrintOrder;

/* Methods - Getter and Setter */
public int getId() {
        return (this.id);
    }

public void setId(int _printOrderId) {

        this.id = _printOrderId;
    }

public String getJournalCode() {
        return (journalCode);
    }

public void setJournalCode(String _journalCode) {
        this.journalCode = _journalCode;
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

public int getIssues() {
        return (this.issues);
    }

public void setIssues(int _issues) {
        this.issues = _issues;
    }

public int getPrintOrder() {
        return (printOrder);
    }

public void setPrintOrder(int _printOrder) {
        this.printOrder = _printOrder;
    }

public int getAnnualPrintOrder() {
        return (annualPrintOrder);
    }

public void setAnnualPrintOrder(int _annualPrintOrder) {
        this.annualPrintOrder = _annualPrintOrder;
    }
}
