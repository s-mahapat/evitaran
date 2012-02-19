package IAS.Class;

import org.apache.log4j.Logger;

public class JDSLogger {

    public static Logger getJDSLogger(String className) {

        Logger _Logger = Logger.getLogger(className);
        return _Logger;

    }
}
