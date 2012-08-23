package IAS.Bean.Reports;

import IAS.Bean.JDSBean;

public class printOrderFormBeanReport extends JDSBean{

    /* fields */
    private int id;
    private String journalName;
    private int year;
    private int issueNo;
    private int printOrder;
    //private String colD;
    private String colN = "['Issue No', 'JAA', 'BS']";
    private String colM = "["
            + "{name:'issues', index:'issues', xmlmap:'issues'}, "
            + "{name:'JAA', index:'JAA', xmlmap:'JAA'},"
            + "{name:'BS', index:'BS', xmlmap:'BS'},"
            + "]";

    /*
public String getColD() {

    colD = "['{<issues>10</issues>, <printOrder>10</printOrder>}']";
    return(this.colD);
}

public void setColD(String _colD) {
    this.colD = _colD;
}
*/

public String getColN() {

    return(this.colN);
}

public void setColN(String _colN) {
    this.colN = _colN;
}


public String getColM() {

    return(this.colM);
}

public void setColM(String _colM) {
    this.colM = _colM;
}

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
