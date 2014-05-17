/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;

/**
 *
 * @author aloko
 */
public class volumeInfo {
    // IssueNo, No of issues
    private HashMap<Integer, Integer> issueInfo = new HashMap();    


public void addIssue(int issueNo, int noOfCopies) {
    if(checkIfIssueExists(issueNo)) {
        issueInfo.put(issueNo, issueInfo.get(issueNo)+noOfCopies);
    } else {
        issueInfo.put(issueNo, noOfCopies);
    }
}

private boolean checkIfIssueExists(int issueNo) {
    boolean status = true;
    if(!issueInfo.containsKey(issueNo)){
        status = false;
    }
    return status;
}

public ArrayList<IssueInfo> sortIssueForThisVolume() {
    ArrayList<Integer> intKeys = new ArrayList<Integer>(issueInfo.keySet());
    Collections.sort(intKeys);
    
    ArrayList<IssueInfo> issueInfoArrayList = new ArrayList<IssueInfo>();

    int startIssue = intKeys.get(0);
    int endIssue = startIssue;
    int noOfCopies = issueInfo.get(startIssue);
    for(int i = 1; i < intKeys.size(); i++) {

        int issueNo = intKeys.get(i);
        int copies = issueInfo.get(issueNo);
        if(issueNo == (endIssue + 1) && copies == noOfCopies) {
            endIssue = issueNo;
        } else {
            IssueInfo ii = new IssueInfo();
            ii.setEndIssue(endIssue);
            ii.setStartIssue(startIssue);
            ii.setNo_of_copies(noOfCopies);
            issueInfoArrayList.add(ii);
            
            startIssue = issueNo;
            endIssue = startIssue;
            noOfCopies = copies;
        }
    }
    IssueInfo ii = new IssueInfo();
    ii.setEndIssue(endIssue);
    ii.setStartIssue(startIssue);
    ii.setNo_of_copies(noOfCopies);
    issueInfoArrayList.add(ii);
    
    return(issueInfoArrayList);
}
 
}
