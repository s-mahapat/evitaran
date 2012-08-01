package IAS.Bean.masterdata;

public class printOrderFormBean {

    /* fields */
    //private int year;
    private int id;
    private String journalCode;
    private String journalName;
    private int year;
    private int annualPrintOrder;
    private int janPrintOrder;
    private int febPrintOrder;
    private int marPrintOrder;
    private int aprPrintOrder;
    private int mayPrintOrder;
    private int junePrintOrder;
    private int julyPrintOrder;
    private int augPrintOrder;
    private int septPrintOrder;
    private int octPrintOrder;
    private int novPrintOrder;
    private int decPrintOrder;

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

public int getAnnualPrintOrder() {
        this.annualPrintOrder = janPrintOrder + febPrintOrder + marPrintOrder + aprPrintOrder + mayPrintOrder + junePrintOrder +
        julyPrintOrder + augPrintOrder + septPrintOrder + octPrintOrder + novPrintOrder + decPrintOrder;
        return (annualPrintOrder);
    }

public void setAnnualPrintOrder(int _annualPrintOrder) {
        this.annualPrintOrder = _annualPrintOrder;
    }

public int getJanPrintOrder() {
        return (janPrintOrder);
    }

public void setJanPrintOrder(int _janPrintOrder) {
        this.janPrintOrder = _janPrintOrder;
    }

public int getFebPrintOrder() {
        return (febPrintOrder);
    }

public void setFebPrintOrder(int _febPrintOrder) {
        this.febPrintOrder = _febPrintOrder;
    }

public int getMarPrintOrder() {
        return (marPrintOrder);
    }

public void setMarPrintOrder(int _marPrintOrder) {
        this.marPrintOrder = _marPrintOrder;
    }

public int getAprPrintOrder() {
        return (aprPrintOrder);
    }

public void setAprPrintOrder(int _aprPrintOrder) {
        this.aprPrintOrder = _aprPrintOrder;
    }

public int getMayPrintOrder() {
        return (mayPrintOrder);
    }

public void setMayPrintOrder(int _mayPrintOrder) {
        this.mayPrintOrder = _mayPrintOrder;
    }

public int getJunePrintOrder() {
        return (junePrintOrder);
    }

public void setJunePrintOrder(int _junePrintOrder) {
        this.junePrintOrder = _junePrintOrder;
    }

public int getJulyPrintOrder() {
        return (julyPrintOrder);
    }

public void setJulyPrintOrder(int _julyPrintOrder) {
        this.julyPrintOrder = _julyPrintOrder;
    }

public int getAugPrintOrder() {
        return (augPrintOrder);
    }

public void setAugPrintOrder(int _augPrintOrder) {
        this.augPrintOrder = _augPrintOrder;
    }

public int getSeptPrintOrder() {
        return (septPrintOrder);
    }

public void setSeptPrintOrder(int _septPrintOrder) {
        this.septPrintOrder = _septPrintOrder;
    }

public int getOctPrintOrder() {
        return (octPrintOrder);
    }

public void setOctPrintOrder(int _octPrintOrder) {
        this.octPrintOrder = _octPrintOrder;
    }

public int getNovPrintOrder() {
        return (novPrintOrder);
    }

public void setNovPrintOrder(int _novPrintOrder) {
        this.novPrintOrder = _novPrintOrder;
    }

public int getDecPrintOrder() {
        return (decPrintOrder);
    }

public void setDecPrintOrder(int _decPrintOrder) {
        this.decPrintOrder = _decPrintOrder;
    }
}
