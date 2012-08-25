package IAS.Bean.Reports;

import IAS.Bean.JDSBean;

public class subscriptionFiguresFormBeanReport extends JDSBean{

    /* fields */

    private int year;
    //private String colD;
    private String colN = "['Issue No', 'JAA', 'BS']";
    private String colM = "["
            + "{name:'issues', index:'issues', xmlmap:'issues'}, "
            + "{name:'JAA', index:'JAA', xmlmap:'JAA'},"
            + "{name:'BS', index:'BS', xmlmap:'BS'},"
            + "]";


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

public int getYear() {
        return (this.year);
    }

public void setYear(int _year) {
        this.year = _year;
    }

}
