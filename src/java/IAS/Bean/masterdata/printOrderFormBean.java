package IAS.Bean.masterdata;

public class printOrderFormBean {

    /* fields */
    private int selectedYear;
    private int[] printOrderId;
    private String[] journalCode;
    private String[] journalName;
    private int[] year;
    private int[] issues;
    private int[] printOrder;
    private int[] annualPrintOrder;

/* Methods - Getter and Setter */
public int getSelectedYear() {
        return (this.selectedYear);
    }

public void setSelectedYear(int _selectedYear) {
        this.selectedYear = _selectedYear;
    }

public int[] getPrintOrderId() {
        return (this.printOrderId);
    }

public void setPrintOrderId(int[] _printOrderId) {
    /*
        if(_printOrderId == null){
            _printOrderId = new int[0];
        }
     */
        this.printOrderId = _printOrderId;
    }

public String[] getJournalCode() {
        return (journalCode);
    }

public void setJournalCode(String[] _journalCode) {
    /*
        if(_journalCode == null){
            _journalCode = new String[0];
        }
     */
        this.journalCode = _journalCode;
    }

public String[] getJournalName() {
        return (journalName);
    }

public void setJournalName(String[] _journalName) {
    /*
        if(_journalName == null){
            _journalName = new String[0];
        }
     */
        this.journalName = _journalName;
    }

public int[] getYear() {
        return (this.year);
    }

public void setYear(int[] _year) {
    /*
        if(_year == null){
            _year = new int[0];
        }
     */
        this.year = _year;
    }

public int[] getIssues() {
        return (this.issues);
    }

public void setIssues(int[] _issues) {
    /*
        if(_issues == null){
            _issues = new int[0];
        }
     */
        this.issues = _issues;
    }

public int[] getPrintOrder() {
        return (printOrder);
    }

public void setPrintOrder(int[] _printOrder) {
    /*
        if(_printOrder == null){
            _printOrder = new int[0];
        }
     */
        this.printOrder = _printOrder;
    }

public void setPrintOrder(int ndx, int member){
        printOrder[ndx] = member;
    }

public int[] getAnnualPrintOrder() {
        return (annualPrintOrder);
    }

public void setAnnualPrintOrder(int[] _annualPrintOrder) {
    /*
        if(_annualPrintOrder == null){
            _annualPrintOrder = new int[0];
        }
     */
        this.annualPrintOrder = _annualPrintOrder;
    }
}