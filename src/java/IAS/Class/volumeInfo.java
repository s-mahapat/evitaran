/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

/**
 *
 * @author aloko
 */
public class volumeInfo {
    private int startIssue = 0;
    private int endIssue = 0;
    private int no_of_copies;
    //private String volume_number = "";

public int getStartIssue() {
        return (this.startIssue);
    }

public void setStartIssue(int _StartIssue) {
        this.startIssue = _StartIssue;
    }

public void setEndIssue(int _EndIssue) {
        this.endIssue = _EndIssue;
    }

public int getEndIssue() {
        return (this.endIssue);
    }

public void setNo_of_copies(int _no_of_copies) {
        this.no_of_copies = _no_of_copies;
    }

public int getNo_of_copies() {
        return (this.no_of_copies);
    }
/*
public String getVolume_number() {
        return (this.volume_number);
    }

public void setVolume_number(String _Volume_number) {
        this.volume_number = _Volume_number;
    }
*/

}
