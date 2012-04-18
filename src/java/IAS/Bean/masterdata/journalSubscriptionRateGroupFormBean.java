package IAS.Bean.masterdata;

public class journalSubscriptionRateGroupFormBean {

    private int year;
    private int subTypeId;
    private String journalGroupName;

public int getSubTypeId() {
        return (this.subTypeId);
    }

public void setId(int _subTypeId) {

        this.subTypeId = _subTypeId;
    }

public String getJournalGroupName() {
        return (journalGroupName);
    }

public void setJournalGroupName(String _journalGroupName) {
        this.journalGroupName = _journalGroupName;
    }

public int getYear() {
        return (this.year);
    }

public void setYear(int _year) {
        this.year = _year;
    }

}