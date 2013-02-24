/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author aloko
 */
public class subInfo {

    private String subscriberNumber = null, journalCode = null, subtypecode = null, startDate = null, endDate = null;
    private String subscriberName   = null, department = null, institution = null, address = null;
    private String city             = null, pincode = null, state = null, country = null;
    private String startYear=null, startMonth=null, endYear=null, endMonth=null;
    private String subType=null; int copies = 0;
    private String page_size=null;
    private int volume_number=0, issue=0;
    private String subscriptionId = null;

    subInfo(ResultSet rs) throws SQLException {
        java.sql.ResultSetMetaData rsmd = rs.getMetaData();
        int numberOfColumns = rsmd.getColumnCount();
        for (int i = 1; i <= numberOfColumns; i++)
        {
            String columnName = rsmd.getColumnName(i);
            //System.out.println("Column: " + i + " " +columnName);
            if(columnName.equals("subscriptionId")) {
                subscriptionId = Integer.toString(rs.getInt(i));
            }
            if(columnName.equals("page_size")) {
                page_size = rs.getString(i);
            }
            if(columnName.equals("volumeNumber")) {
                volume_number = rs.getInt(i);
            }
            if(columnName.equals("issue")) {
                issue = rs.getInt(i);
            }
            if(columnName.equals("subscriberNumber")) {
                subscriberNumber = rs.getString(i);
            } if(columnName.equals("journalCode")) {
                journalCode = rs.getString(i);
            } if(columnName.equals("subtypecode")) {
                subtypecode = rs.getString(i);
            } if(columnName.equals("startYear")) {
                startYear = rs.getString(i);
            } if(columnName.equals("startMonth")) {
                startMonth = rs.getString(i);
                startDate = startMonth + " " + startYear;
            } if(columnName.equals("endYear")) {
                endYear = rs.getString(i);
            } if(columnName.equals("endMonth")) {
                endMonth = rs.getString(i);
                endDate = endMonth + " " + endYear;
            } if(columnName.equals("subscriberName")) {
                subscriberName = rs.getString(i);
                if(subscriberName == null) {
                    subscriberName = "";
                }
            } if(columnName.equals("department")) {
                department = rs.getString(i);
                if(department == null) {
                    department = "";
                }
            } if(columnName.equalsIgnoreCase("institution")) {
                institution = rs.getString(i);
                if(institution == null) {
                    institution = "";
                }
            } if(columnName.equalsIgnoreCase("address") || columnName.equalsIgnoreCase("shippingAddress")) {
                address = rs.getString(i);
                if(address == null) {
                    address = "";
                }
            } if(columnName.equalsIgnoreCase("city")) {
                city = rs.getString(i);
                if(city == null) {
                    city = "";
                }
            } if(columnName.equalsIgnoreCase("pincode")){
                pincode = rs.getString(i);
                // If pincode is found to be zero, then do not print
                if(pincode.equalsIgnoreCase("0") || pincode == null){
                    pincode = "";
                }
            } if(columnName.equalsIgnoreCase("state")) {
                state = rs.getString(i);
                if(state == null) {
                    state = "";
                }
            }
            if(columnName.equalsIgnoreCase("country")) {
                country = rs.getString(i);
                if(country == null) {
                    country = "";
                }
            }
            if(columnName.equalsIgnoreCase("subType")) {
                subType = rs.getString(i);
            }
            if(columnName.equalsIgnoreCase("copies")) {
                copies = rs.getInt(i);
            }
        }
    }

public String getSubscriptionId() {
        return (this.subscriptionId);
    }

public void setSubscriptionId(String _subscriptionId) {
        this.subscriptionId = _subscriptionId;
    }

public String getpage_size() {
        return (this.page_size);
    }

public void setpage_size(String page_size) {
        this.page_size = page_size;
    }

public int getissue() {
        return (this.issue);
    }

public void setissue(int issue) {
        this.issue = issue;
    }

public int getvolume_number() {
        return (this.volume_number);
    }

public void setvolume_number(int volume_number) {
        this.volume_number = volume_number;
    }

public int getcopies() {
        return (this.copies);
    }

public void setcopies(int copies) {
        this.copies = copies;
    }

public String getsubType() {
        return (this.subType);
    }

public void setsubType(String subType) {
        this.subType = subType;
    }

public String getendMonth() {
        return (this.endMonth);
    }

public void setendMonth(String endMonth) {
        this.endMonth = endMonth;
    }

public String getendYear() {
        return (this.endYear);
    }

public void setendYear(String endYear) {
        this.endYear = endYear;
    }

public String getstartMonth() {
        return (this.startMonth);
    }

public void setstartMonth(String startMonth) {
        this.startMonth = startMonth;
    }

public String getstartYear() {
        return (this.startYear);
    }

public void setstartYear(String startYear) {
        this.startYear = startYear;
    }

public String getcountry() {
        return (this.country);
    }

public void setcountry(String country) {
        this.country = country;
    }

public String getstate() {
        return (this.state);
    }

public void setstate(String state) {
        this.state = state;
    }

public String getpincode() {
        return (this.pincode);
    }

public void setpincode(String pincode) {
        this.pincode = pincode;
    }

public String getcity() {
        return (this.city);
    }

public void setcity(String city) {
        this.city = city;
    }

public String getaddress() {
        return (this.address);
    }

public void setaddress(String address) {
        this.address = address;
    }

public String getinstitution() {
        return (this.institution);
    }

public void setinstitution(String institution) {
        this.institution = institution;
    }

public String getdepartment() {
        return (this.department);
    }

public void setdepartment(String department) {
        this.department = department;
    }

public String getsubscriberName() {
        return (this.subscriberName);
    }

public void setsubscriberName(String subscriberName) {
        this.subscriberName = subscriberName;
    }

public String getsubscriberNumber() {
        return (this.subscriberNumber);
    }

public void setsubscriberNumber(String subscriberNumber) {
        this.subscriberNumber = subscriberNumber;
    }

public String getjournalCode() {
        return (this.journalCode);
    }

public void setjournalCode(String journalCode) {
        this.journalCode = journalCode;
    }

public String getsubtypecode() {
        return (this.subtypecode);
    }

public void setsubtypecode(String subtypecode) {
        this.subtypecode = subtypecode;
    }

public String getstartDate() {
        return (this.startDate);
    }

public void setstartDate(String startDate) {
        this.startDate = startDate;
    }

public String getendDate() {
        return (this.endDate);
    }

public void setendDate(String endDate) {
        this.endDate = endDate;
    }

}
