package IAS.Bean.masterdata;

public class journalDetailsFormBean {

    /* fields */
    private int id = 0;
    private int vid = 0;
    private int journalsId = 0;
    private String journalName = "";
    private int year = 0;
    private String pages = "";
    private int issues = 0;
    private String page_size = "";
    private int no_of_volumes = 0;
    private int volume_number = 0;
    private String start_month = "";

/* Methods - Getter and Setter */
public int getId() {
        return (this.id);
    }

public void setId(int _Id) {
        this.id = _Id;
    }

public int getVid() {
        return (this.vid);
    }

public void setVid(int _Vid) {
        this.vid = _Vid;
    }

public int getJournalsId() {
        return (this.journalsId);
    }

public void setJournalsId(int _JournalsId) {
        this.journalsId = _JournalsId;
    }

public String getJournalName() {
        return (this.journalName);
    }

public void setJournalName(String _JournalName) {
        this.journalName = _JournalName;
    }

public int getYear() {
        return (this.year);
    }

public void setYear(int _Year) {
        this.year = _Year;
    }

public String getPages() {
        return (this.pages);
    }

public void setPages(String _Pages) {
        this.pages = _Pages;
    }

public int getIssues() {
        return (this.issues);
    }

public void setIssues(int _Issues) {
        this.issues = _Issues;
    }

public String getPage_size() {
        return (this.page_size);
    }

public void setPage_size(String _page_size) {
        this.page_size = _page_size;
    }

public int getNo_of_volumes() {
        return (this.no_of_volumes);
    }

public void setNo_of_volumes(int _no_of_volumes) {
        this.no_of_volumes = _no_of_volumes;
    }

public int getVolume_number() {
        return (this.volume_number);
    }

public void setVolume_number(int _Volume_number) {
        this.volume_number = _Volume_number;
    }

public String getStart_month() {
        return (this.start_month);
    }

public void setStart_month(String _Start_month) {
        this.start_month = _Start_month;
    }

}