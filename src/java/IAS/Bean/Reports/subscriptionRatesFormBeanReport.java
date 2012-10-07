package IAS.Bean.Reports;

import IAS.Bean.JDSBean;

public class subscriptionRatesFormBeanReport extends JDSBean{

    /* fields */

    private int year=0;
    //private String colD;
    private String subscriberType="";

    private String colN = "['Journal Group', 'Year', '1 Year']";
    private String colM = "["
            + "{name:'journalGroup', index:'journalGroup', xmlmap:'journalGroup'}, "
            + "{name:'year', index:'year', xmlmap:'year'},"
            + "{name:'1 Year', index:'1 Year', xmlmap:'1 Year'},"
            + "]";
    private String data = "";

public String getData() {

    return(this.data);
}

public void setData(String _data) {
    this.data = _data;
}

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

public void setSubscriberType(String _subscriberType) {
    this.subscriberType = _subscriberType;
}

public String getSubscriberType() {

    return(this.subscriberType);
}

}
