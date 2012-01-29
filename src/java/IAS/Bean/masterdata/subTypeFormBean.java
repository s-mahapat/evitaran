
package IAS.Bean.masterdata;

public class subTypeFormBean {
    
        /* fields */

    private int  subTypeId = 0;
    private String subTypeCode = "";            
    private String subTypeName = "";
    private String freePaid = "";
    private String nationality = "";
    private String institutional = "";
    private int freeCopies = 0;
    private int discount = 0;
    
/*  Methods Getter and Setter*/
public int getSubTypeId() {
        return (this.subTypeId);
    }

public void setSubTypeId(int _SubTypeId) {
        this.subTypeId = _SubTypeId;
    }

public String getSubTypeCode() {
        return (this.subTypeCode);
    }

public void setSubTypeCode(String _SubTypeCode) {
        this.subTypeCode = _SubTypeCode;
    }

public String getSubTypeName() {
        return (this.subTypeName);
    }

public void setSubTypeName(String _SubTypeName) {
        this.subTypeName = _SubTypeName;
    }

public String getFreePaid() {
        return (this.freePaid);
    }

public void setFreePaid(String _FreePaid) {
        this.freePaid = _FreePaid;
    }

public String getNationality() {
        return (this.nationality);
    }

public void setNationality(String _Nationality) {
        this.nationality = _Nationality;
    }

public String getInstitutional() {
        return (this.institutional);
    }

public void setInstitutional(String _Institutional) {
        this.institutional = _Institutional;
    }

public int getFreeCopies() {
        return (this.freeCopies);
    }

public void setFreeCopies(int _FreeCopies) {
        this.freeCopies = _FreeCopies;
    }

public int getDiscount() {
        return (this.discount);
    }

public void setDiscount(int _Discount) {
        this.discount = _Discount;
    }
}