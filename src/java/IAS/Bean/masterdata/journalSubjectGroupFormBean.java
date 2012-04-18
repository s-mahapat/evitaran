package IAS.Bean.masterdata;

public class journalSubjectGroupFormBean {

    //private int id;
    private String journalGroupName;
    // This variable will be used to store the newly created group
    private String newJournalGroupName;
    private String journalName;
    private int year;
    //private int select;

/*
public int getId() {
        return (this.id);
    }

public void setId(int _printOrderId) {

        this.id = _printOrderId;
    }
*/
public String getJournalGroupName() {
        return (journalGroupName);
    }

public void setJournalGroupName(String _journalGroupName) {
        this.journalGroupName = _journalGroupName;
    }

public String getNewJournalGroupName() {
        if(newJournalGroupName == null)
            return ("");
        else
            return(newJournalGroupName);
    }

public void setNewJournalGroupName(String _newJournalGroupName) {
        this.newJournalGroupName = _newJournalGroupName;
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
/*
public int getSelect() {
        return (this.select);
    }

public void setSelect(int _select) {

        this.id = _select;
    }
*/
}