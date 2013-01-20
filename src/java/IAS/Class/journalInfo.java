/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import java.util.HashMap;

/**
 *
 * @author aloko
 */
public class journalInfo {

    // Key is volume_number, Value is volumeInfo
    private HashMap<String, volumeInfo> volumeInfo = new HashMap();

    public HashMap<String, volumeInfo> getvolumeInfo() {
        return volumeInfo;
    }

}

