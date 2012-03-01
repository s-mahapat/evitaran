package IAS.Bean.masterdata;

public class subTypeFormBean {

    /* fields */
    private int  id = 0;
    private String subtypecode = "";
    private String subtypedesc = "";
    private String subtype = "";
    private String nationality = "";
    private String institutional = "";
    private int freejrnl = 0;
    private int discount = 0;
/*  Methods Getter and Setter*/
public int getId() {
        return (this.id);
    }

public void setId(int _Id) {
        this.id = _Id;
    }

public String getSubtypecode() {
        return (this.subtypecode);
    }

public void setSubtypecode(String _SubTypeCode) {
        this.subtypecode = _SubTypeCode;
    }

public String getSubtypedesc() {
        return (this.subtypedesc);
    }

public void setSubtypedesc(String _SubTypeDesc) {
        this.subtypedesc = _SubTypeDesc;
    }

public String getSubtype() {
        return (this.subtype);
    }

public void setSubtype(String _SubType) {
        this.subtype = _SubType;
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

public int getFreejrnl() {
        return (this.freejrnl);
    }

public void setFreejrnl(int _FreeJrnl) {
        this.freejrnl = _FreeJrnl;
    }

public int getDiscount() {
        return (this.discount);
    }

public void setDiscount(int _Discount) {
        this.discount = _Discount;
    }
}