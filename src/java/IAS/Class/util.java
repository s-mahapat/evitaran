/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;
import java.util.*;
import java.text.*;

/**
 *
 * @author Shailendra Mahapatra
 */
public final class util {

    public static String getDateString(){
        Format dtformat = new SimpleDateFormat("dd/MM/yyyy");
        Date dt = new Date();
        return dtformat.format(dt);
    }

     public static String getDateString(String dateFormat){
        Format dtformat = new SimpleDateFormat(dateFormat);
        Date dt = new Date();
        return dtformat.format(dt);
    }

}
