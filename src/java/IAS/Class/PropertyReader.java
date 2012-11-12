/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 *
 * @author smahapat
 */
public class PropertyReader {

    private Properties prop = null;
    public PropertyReader(String filename) throws IOException{
        prop = new Properties();
        prop.load(new FileInputStream(filename));
    }

    public PropertyReader(InputStream stream) throws IOException{
        prop = new Properties();
        prop.load(stream);
    }

    public String getProperty(String propname){
        return prop.getProperty(propname);
    }
}
