/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package IAS.Class;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 *
 * @author 310159477
 */
public class BackIssueLabels {
    
    boolean separateLabelForP= false;
    boolean separateLabelForRES= false;
    boolean separateLabelForCURR= false;
    ArrayList BILlabels = new ArrayList();    
    
    float lfixedLeading       = 0.0f;
    float lmultipliedLeading  = 1.2f;
    float lmultipliedLeadingPlus = 1.5f;    
    int textAlignment   = 0;
    
    Font.FontFamily sfontType = Font.getFamily("HELVETICA");
    int sfontSize        = 10;
    int sfontStyle       = Font.getStyleValue("NORMAL");
    int sfontSizeHeader  = 10;    
    
    boolean pdf = false;
    
    public void BackIssueLabel(String _separateLabelForP, String _separateLabelForRES, String _separateLabelForCURR, boolean _pdf){
        
        if(_separateLabelForP!= null && _separateLabelForP.equals("on")){
            separateLabelForP = true;
        }
        if(_separateLabelForRES!= null && _separateLabelForRES.equals("on")){
            separateLabelForRES = true;
        }
        if(_separateLabelForCURR!= null && _separateLabelForCURR.equals("on")){
            separateLabelForCURR = true;
        }
        
        lfixedLeading = 10.0f;
        lmultipliedLeadingPlus = 0.0f;        
        
        pdf = _pdf;
    }

    public void BackIssueSticker(String _separateLabelForP, String _separateLabelForRES, String _separateLabelForCURR, boolean _pdf){
        
        if(_separateLabelForP!= null && _separateLabelForP.equals("on")){
            separateLabelForP = true;
        }
        if(_separateLabelForRES!= null && _separateLabelForRES.equals("on")){
            separateLabelForRES = true;
        }
        if(_separateLabelForCURR!= null && _separateLabelForCURR.equals("on")){
            separateLabelForCURR = true;
        }        
       
        pdf = _pdf;
    }    

public ArrayList prepareBILLabelContent(ResultSet rs) throws SQLException {

        HashMap<String, SubscriberInfo> subscriber = new HashMap<>();

        // Subscriber: Key is subscriber no, value is SubscriberInfo
        // SubscriberInfo: Key is page_size, value is journalType
        // journalType: Key is journalCode, value is journalInfo
        // journalInfo: Key is volumeNo, value is volumeInfo

        // Subscriber: Key is subscriber no, value is SubscriberInfo
        // SubscriberInfo: Key is subscriptionId, value is SubscriptionInfo
        // sunbscriptionInfo: Key is page_size, value is journalType
        // journalType: Key is journalCode, value is journalInfo
        // journalInfo: Key is volumeNo, value is volumeInfo

        while(rs.next()) {
            subInfo sInfo = new subInfo(rs);

            SubscriberInfo subInfo = subscriber.get(sInfo.getsubscriberNumber());
            // Null means subscriber does not exist
            if(subInfo == null) {

                // If subscriber does not exist, then add him to the subscribers list

                // 1. Create the volume info
                volumeInfo vInfo = new volumeInfo();
                vInfo.addIssue(sInfo.getissue(), sInfo.getcopies());

                // 2. Create the journal info and add the volume info
                journalInfo jInfo = new journalInfo();
                jInfo.getvolumeInfo().put(Integer.toString(sInfo.getvolume_number()), vInfo);

                // 3. Create the journal type and add the journal info
                journalType jType = new journalType();
                jType.getjournalInfo().put(sInfo.getjournalCode(), jInfo);

                // 4. Create subscriptionInfo and add the journal type to the subscription info
                SubscriptionInfo subscriptionInfo = new SubscriptionInfo();
                subscriptionInfo.getjournalType().put(sInfo.getpage_size(), jType);

                // 5. Create subscriberInfo and Add the journal type to the subscriber info
                SubscriberInfo SInfo = new SubscriberInfo();
                SInfo.getSubscriberInfo().put(sInfo.getSubscriptionId(), subscriptionInfo);
                SInfo.setSubscriberLabelInfo(sInfo);

                // 6. Add the subscriber info in the list of subscriber
                subscriber.put(sInfo.getsubscriberNumber(), SInfo);

            }
            // Subscriber exists
            else {
                // Subscriber exists, check if the subscription exists
                if(subInfo.getSubscriberInfo().get(sInfo.getSubscriptionId()) != null) {
                    // Subscription exists, check if the journalType exists
                    if(subInfo.getSubscriberInfo().get(sInfo.getSubscriptionId()).getjournalType().get(sInfo.getpage_size()) != null) {
                        // JournalType exists, now check if the journalInfo exists
                        if(subInfo.getSubscriberInfo().get(sInfo.getSubscriptionId()).getjournalType().get(sInfo.getpage_size()).getjournalInfo().get(sInfo.getjournalCode()) != null) {
                            // JournalInfo exists, now check if the volume number exists
                            if(subInfo.getSubscriberInfo().get(sInfo.getSubscriptionId()).getjournalType().get(sInfo.getpage_size()).getjournalInfo().get(sInfo.getjournalCode()).getvolumeInfo().get(Integer.toString(sInfo.getvolume_number())) != null) {
                                subInfo.getSubscriberInfo().get(sInfo.getSubscriptionId()).getjournalType().get(sInfo.getpage_size()).getjournalInfo().get(sInfo.getjournalCode()).getvolumeInfo().get(Integer.toString(sInfo.getvolume_number())).addIssue(sInfo.getissue(), sInfo.getcopies());

                            } else {
                                // volume number does not exist
                                volumeInfo vInfo = new volumeInfo();
                                vInfo.addIssue(sInfo.getissue(), sInfo.getcopies());
                                subInfo.getSubscriberInfo().get(sInfo.getSubscriptionId()).getjournalType().get(sInfo.getpage_size()).getjournalInfo().get(sInfo.getjournalCode()).getvolumeInfo().put(Integer.toString(sInfo.getvolume_number()), vInfo);
                            }

                        } else {
                            // journalInfo does not exist
                            // 1. Create the volume info
                            volumeInfo vInfo = new volumeInfo();
                            vInfo.addIssue(sInfo.getissue(), sInfo.getcopies());

                            // 2. Create the journal info and add the volume info
                            journalInfo jInfo = new journalInfo();
                            jInfo.getvolumeInfo().put(Integer.toString(sInfo.getvolume_number()), vInfo);

                            subInfo.getSubscriberInfo().get(sInfo.getSubscriptionId()).getjournalType().get(sInfo.getpage_size()).getjournalInfo().put(sInfo.getjournalCode(), jInfo);
                        }

                    } else {
                        // Journal Type does not exist
                        // 1. Create the volume info
                        volumeInfo vInfo = new volumeInfo();
                        vInfo.addIssue(sInfo.getissue(), sInfo.getcopies());

                        // 2. Create the journal info and add the volume info
                        journalInfo jInfo = new journalInfo();
                        jInfo.getvolumeInfo().put(Integer.toString(sInfo.getvolume_number()), vInfo);

                        // 3. Create the journal type and add the journal info
                        journalType jType = new journalType();
                        jType.getjournalInfo().put(sInfo.getjournalCode(), jInfo);

                        // 4. Add the journalType to the subscriberInfo
                        subInfo.getSubscriberInfo().get(sInfo.getSubscriptionId()).getjournalType().put(sInfo.getpage_size(), jType);
                    }
                } else {
                    // 1. Create the volume info
                    volumeInfo vInfo = new volumeInfo();
                    vInfo.addIssue(sInfo.getissue(), sInfo.getcopies());

                    // 2. Create the journal info and add the volume info
                    journalInfo jInfo = new journalInfo();
                    jInfo.getvolumeInfo().put(Integer.toString(sInfo.getvolume_number()), vInfo);

                    // 3. Create the journal type and add the journal info
                    journalType jType = new journalType();
                    jType.getjournalInfo().put(sInfo.getjournalCode(), jInfo);

                    // 4. Create subscriptionInfo and add the journal type to the subscription info
                    SubscriptionInfo subscriptionInfo = new SubscriptionInfo();
                    subscriptionInfo.getjournalType().put(sInfo.getpage_size(), jType);

                    // 5. Create subscriberInfo and Add the journal type to the subscriber info
                    subInfo.getSubscriberInfo().put(sInfo.getSubscriptionId(), subscriptionInfo);
                }
            }
        }

        //Now extract the labels
        Iterator subscriberIterator = subscriber.entrySet().iterator();

        // Loop over subscribers
        while(subscriberIterator.hasNext())
        {
            Map.Entry pairs1 = (Map.Entry)subscriberIterator.next();
            String subscriberNumber = pairs1.getKey().toString();
            SubscriberInfo sInfo = (SubscriberInfo)pairs1.getValue();

            subInfo sLabelInfo = sInfo.getSubscriberLabelInfo();

            Iterator subscriberInfoIter = sInfo.getSubscriberInfo().entrySet().iterator();

            // Loop over subscriberInfo
            while(subscriberInfoIter.hasNext()) {
                Map.Entry pairs2 = (Map.Entry)subscriberInfoIter.next();
                String SubscriptionId = pairs2.getKey().toString();
                SubscriptionInfo subscriptionInfo = (SubscriptionInfo)pairs2.getValue();

                Iterator SubscriptionInfoIter = subscriptionInfo.getjournalType().entrySet().iterator();

                ArrayList<String> labels = new ArrayList<String>();

                // Loop over subscriptionInfo, i.e loop over each subscription of a subscriber
                while(SubscriptionInfoIter.hasNext()) {
                    Map.Entry pairs3 = (Map.Entry)SubscriptionInfoIter.next();
                    String journalType = pairs3.getKey().toString();
                    journalType jType = (journalType)pairs3.getValue();

                    Iterator journalTypeIter = jType.getjournalInfo().entrySet().iterator();

                    String label="";
                    // Loop over journalType i.e loop over journals of certain page type
                    while(journalTypeIter.hasNext()) {
                        Map.Entry pairs4 = (Map.Entry)journalTypeIter.next();
                        String journalCode = pairs4.getKey().toString();
                        journalInfo jInfo = (journalInfo)pairs4.getValue();

                        Iterator journalInfoIter1 = jInfo.getvolumeInfo().entrySet().iterator();
                        // get the no of elements
                        int highestVolumeNo=0;
                        while(journalInfoIter1.hasNext()) {
                            Map.Entry pairs5Temp = (Map.Entry)journalInfoIter1.next();
                            String volume_number = pairs5Temp.getKey().toString();
                            if(Integer.parseInt(volume_number) > highestVolumeNo) {
                                highestVolumeNo = Integer.parseInt(volume_number);
                            }
                        }
                        Iterator journalInfoIter = jInfo.getvolumeInfo().entrySet().iterator();

                        // Loop over journalInfo, i.e loop over volume_number
                        while(journalInfoIter.hasNext()) {
                            Map.Entry pairs5 = (Map.Entry)journalInfoIter.next();
                            String volume_number = pairs5.getKey().toString();
                            volumeInfo vInfo = (volumeInfo)pairs5.getValue();
                            
                            ArrayList<IssueInfo> issueInfo = vInfo.sortIssueForThisVolume();
                            
                            for (IssueInfo sueInfo : issueInfo) {
                                int endIssue = sueInfo.getEndIssue();
                                int startIssue = sueInfo.getStartIssue();
                                int no_of_copies = sueInfo.getNo_of_copies();
                                
                                // If this is the last volume and for the select journal check if there are more than 1 issue
                                if(Integer.parseInt(volume_number) == highestVolumeNo &&
                                        (separateLabelForP && journalCode.equals("P") && (startIssue < endIssue || startIssue == endIssue))) {
                                    
                                    String labelSeparate = createLabel(journalCode, volume_number, endIssue, endIssue, no_of_copies);
                                    labels.add(labelSeparate);

                                    endIssue = endIssue - 1;
                                }
                                if(Integer.parseInt(volume_number) == highestVolumeNo &&
                                        (separateLabelForRES && journalCode.equals("RES") && (startIssue < endIssue || startIssue == endIssue))) {
                                    
                                    String labelSeparate = createLabel(journalCode, volume_number, endIssue, endIssue, no_of_copies);
                                    labels.add(labelSeparate);

                                    endIssue = endIssue - 1;
                                }
                                if(Integer.parseInt(volume_number) == highestVolumeNo &&
                                        (separateLabelForCURR && journalCode.equals("CURR") && (startIssue < endIssue || startIssue == endIssue))) {
                                    
                                    String labelSeparate = createLabel(journalCode, volume_number, endIssue, endIssue, no_of_copies);
                                    labels.add(labelSeparate);

                                    endIssue = endIssue - 1;
                                }
                                if(endIssue != 0)
                                label = label + createLabel(journalCode, volume_number, startIssue, endIssue, no_of_copies);
                            }
                        }
                    }
                    //Paragraph p = prepareBILLabelPDFContent(sLabelInfo, label);
                    //BILlabels.add(p);
                    labels.add(label);
                }

                for(int i=0; i < labels.size(); i++){
                    String label = labels.get(i);
                    if(pdf){
                        Paragraph p = prepareBILLabelPDFContent(sLabelInfo, label);
                        BILlabels.add(p);
                    } else {
                        String op = prepareBILLabelExcelContent(sLabelInfo, label);
                        BILlabels.add(op);
                    }
                }
            }
        }
        return BILlabels;
    }

    public String prepareBILLabelExcelContent(subInfo sLabelInfo, String bilLabel) {

        String header = "";
        if(!bilLabel.isEmpty() && !sLabelInfo.getsubscriberNumber().isEmpty()) {
            header = sLabelInfo.getsubscriberNumber() + " " + bilLabel + "\n";
        }

        String firstLine = sLabelInfo.getsubscriberName();

        if(!firstLine.isEmpty()) {
            firstLine = firstLine + "\n";
        }

        if(!sLabelInfo.getdepartment().isEmpty()) {
            firstLine = firstLine + sLabelInfo.getdepartment() + "\n";
        }
        
        if(!sLabelInfo.getinstitution().isEmpty()) {
            firstLine = firstLine + sLabelInfo.getinstitution() + "\n";
        }

        if(!sLabelInfo.getaddress().isEmpty()) {
            firstLine = firstLine + sLabelInfo.getaddress() + "\n";
        }

        String lastLine = "";
        if(!sLabelInfo.getcity().isEmpty()) {
            lastLine = lastLine + sLabelInfo.getcity();
        }
        if(sLabelInfo.getcity().isEmpty()) {
            lastLine = lastLine + sLabelInfo.getpincode();
        } else {
            lastLine = lastLine + " " + sLabelInfo.getpincode();
        }
        if(sLabelInfo.getpincode().isEmpty()){
            lastLine = lastLine + sLabelInfo.getstate();
        } else {
            lastLine = lastLine + " " + sLabelInfo.getstate();
        }

        String country = "";
        if(!sLabelInfo.getcountry().equals("India")){
            country = sLabelInfo.getcountry();
        }

        if(sLabelInfo.getstate().isEmpty()){
            lastLine = lastLine + country;
        } else {
            lastLine = lastLine + " " + country;
        }

        if(!lastLine.isEmpty()) {
            lastLine = lastLine.trim();
            // Remove the leading spaces
            //lastLine.replaceAll("^\\s+", "");
        }

        String op = header + firstLine + lastLine;
        return op;

    }

    public Paragraph prepareBILLabelPDFContent(subInfo sLabelInfo, String bilLabel) {
        Paragraph info = null;

        info = new Paragraph();
        info.setLeading(lfixedLeading, lmultipliedLeadingPlus);
        info.setAlignment(textAlignment);

        Font font;
        font = new Font(sfontType, sfontSizeHeader-1, sfontStyle, BaseColor.BLACK);
        if(!bilLabel.isEmpty() && !sLabelInfo.getsubscriberNumber().isEmpty()) {
            String header = sLabelInfo.getsubscriberNumber() + " " + bilLabel;
            info.add(new Chunk(header, font));
            info.add(Chunk.NEWLINE);
        }

        font = new Font(sfontType, sfontSize, sfontStyle, BaseColor.BLACK);
        String firstLine = sLabelInfo.getsubscriberName();
        // + " " + sLabelInfo.getjournalCode();

        //if(!noHeader){

            //if(sLabelInfo.getcopies() > 1){
            //    firstLine = firstLine + " " + sLabelInfo.getcopies();
            //}

            //firstLine = firstLine + " " + sLabelInfo.getsubtypecode();

            //if(sLabelInfo.equals("Paid")) {
            //    firstLine = firstLine + " " + sLabelInfo.getstartDate()+
            //        " " + "to" +
            //        " " + sLabelInfo.getendDate();
            //}
            if(!firstLine.isEmpty()) {
                info.add(new Chunk(firstLine, font));
                info.add(Chunk.NEWLINE);
            }
        //}

        //info.add(new Chunk(sLabelInfo.getsubscriberName(), font));
        //info.add(Chunk.NEWLINE);
        if(!sLabelInfo.getdepartment().isEmpty()) {
            info.add(new Chunk(sLabelInfo.getdepartment(), font));
            info.add(Chunk.NEWLINE);
        }
        if(!sLabelInfo.getinstitution().isEmpty()) {
            info.add(new Chunk(sLabelInfo.getinstitution(), font));
            info.add(Chunk.NEWLINE);
        }

        if(!sLabelInfo.getaddress().isEmpty()) {
            info.add(new Chunk(sLabelInfo.getaddress(), font));
            info.add(Chunk.NEWLINE);
        }
        font = new Font(sfontType, sfontSize, Font.BOLD);
        /*
        String lastLine = sLabelInfo.getcity() +
                " " + sLabelInfo.getpincode() +
                " " + sLabelInfo.getstate() +
                " ";
        if(!sLabelInfo.getcountry().equals("India")){
            lastLine = lastLine + sLabelInfo.getcountry();
        }
        */

        String lastLine = "";
        if(!sLabelInfo.getcity().isEmpty()) {
            lastLine = lastLine + sLabelInfo.getcity();
        }
        if(sLabelInfo.getcity().isEmpty()) {
            lastLine = lastLine + sLabelInfo.getpincode();
        } else {
            lastLine = lastLine + " " + sLabelInfo.getpincode();
        }
        if(sLabelInfo.getpincode().isEmpty()){
            lastLine = lastLine + sLabelInfo.getstate();
        } else {
            lastLine = lastLine + " " + sLabelInfo.getstate();
        }

        String country = "";
        if(!sLabelInfo.getcountry().equals("India")){
            country = sLabelInfo.getcountry();
        }

        if(sLabelInfo.getstate().isEmpty()){
            lastLine = lastLine + country;
        } else {
            lastLine = lastLine + " " + country;
        }

        if(!lastLine.isEmpty()) {
            lastLine = lastLine.trim();
            // Remove the leading spaces
            //lastLine.replaceAll("^\\s+", "");
            info.add(new Chunk(lastLine, font));
        }

        return info;

    }


    public String createLabel(String journalCode, String volume_number, int startIssue, int endIssue, int no_of_copies){

        String label="";
        label = label + journalCode;
        label = label + "/" + volume_number;

        // Add information about issues
        String issue;
        // If start and end issue are same, then only mention startissue no
        if(startIssue == endIssue) {
            issue = "/" +  startIssue;
        } else {
            issue = "/" + startIssue + "-" + endIssue;
        }
        label = label + issue;

        //Add information about no of copies
        String noOfCopies;
        if(no_of_copies == 1) {
            noOfCopies = "";
        } else {
            noOfCopies = "(" + no_of_copies + ")";
        }
        label = label + noOfCopies + " ";

        return(label);
    }

}