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
/*
public String getVolume_number() {
        return (this.volume_number);
    }

public void setVolume_number(String _Volume_number) {
        this.volume_number = _Volume_number;
    }
*/

}
