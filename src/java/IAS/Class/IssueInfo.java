/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package IAS.Class;

public class IssueInfo {
    
    private int no_of_copies;    
    private int startIssue = 0;
    private int endIssue = 0;    
    
public void setNo_of_copies(int _no_of_copies) {
        this.no_of_copies = _no_of_copies;
    }

public int getNo_of_copies() {
        return (this.no_of_copies);
    }

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
    
}
