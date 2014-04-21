/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import org.apache.log4j.Logger;

public class Queries {

    private static final String propFileName = "jds_sql.properties";
    private static final Logger logger = JDSLogger.getJDSLogger(IAS.Class.Queries.class.getName());
    private static Properties props;

    public static Properties getQueries() throws IOException {
        InputStream is = Queries.class.getResourceAsStream("/properties/" + propFileName);
        if (is == null) {
            throw new IOException("Unable to load property file: " + propFileName);
        }
        //singleton
        if (props == null) {
            props = new Properties();
            try {
                props.load(is);
            } catch (IOException e) {
                throw new IOException("Unable to load property file: " + propFileName + "\n" + e.getMessage());
            }
        }
        return props;
    }

    public static String getQuery(String query) {
        String property = null;
        try {
            property = getQueries().getProperty(query);
        } catch (IOException ex) {
            logger.error(ex);
        }
        return property;
    }

}
