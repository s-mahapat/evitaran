/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author My
 */
public class CreateLabels {

    private String firstLine        = "";
    private String subscriberName   = "";
    private String department       = "";    
    private String institution      = "";    
    private String address          = "";    
    private String lastLine         = "";    
    
    public String getFirstLine(){
        return firstLine;
    }
    
    public String getSubscriberName(){
        return subscriberName;
    }
    
    public String getDepartment() {
        return department;
    }
    
    public String getInstitution() {
        return institution;
    }
    
    public String getAddress() {
        return address;
    }
    
    public String getLastLine() {
        return lastLine;
    }
    
    public CreateLabels(ResultSet rs, boolean noHeader) throws SQLException {
            
        subInfo sLabelInfo = new subInfo(rs);

        if(!noHeader){

            firstLine = sLabelInfo.getsubscriberNumber() + " " + sLabelInfo.getjournalCode();

            if(sLabelInfo.getcopies() > 1){
                firstLine = firstLine + " " + sLabelInfo.getcopies();
            }

            firstLine = firstLine + " " + sLabelInfo.getsubtypecode();

            if(sLabelInfo.equals("Paid")) {
                firstLine = firstLine + " " + sLabelInfo.getstartDate()+
                    " " + "to" +
                    " " + sLabelInfo.getendDate();
            }
        }
        
        if(!sLabelInfo.getsubscriberName().isEmpty()) {
            subscriberName = sLabelInfo.getsubscriberName();
        }
        
        if(!sLabelInfo.getdepartment().isEmpty()) {
            department = sLabelInfo.getdepartment();
        }
        
        if(!sLabelInfo.getinstitution().isEmpty()) {
            institution = sLabelInfo.getinstitution();
        }

        if(!sLabelInfo.getaddress().isEmpty()) {
            address = sLabelInfo.getaddress();
        }

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
        }
    }
    
    public void createLabelContent (ResultSet rs, boolean noHeader) throws SQLException {

        subInfo sLabelInfo = new subInfo(rs);

        firstLine = sLabelInfo.getsubscriberNumber() + " " + sLabelInfo.getjournalCode();

        if(sLabelInfo.getcopies() > 1){
            firstLine = firstLine + " " + sLabelInfo.getcopies();
        }
        firstLine = firstLine + " " + sLabelInfo.getsubtypecode();            

        if(!noHeader){
            if(sLabelInfo.getsubType().equals("Paid")) {
                firstLine = firstLine + " " + sLabelInfo.getstartDate() +
                    " " + "to" +
                    " " + sLabelInfo.getendDate();
            }
        }            

        if(!sLabelInfo.getsubscriberName().isEmpty()) {
            subscriberName = sLabelInfo.getsubscriberName();
        }

        if(!sLabelInfo.getdepartment().isEmpty()) {
            department = sLabelInfo.getdepartment();
        }

        if(!sLabelInfo.getinstitution().isEmpty()) {
            institution = sLabelInfo.getinstitution();
        }

        if(!sLabelInfo.getaddress().isEmpty()) {
            address = sLabelInfo.getaddress();
        }

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
        }
    }

    
}
