
package IAS.Model.missingissue;

import IAS.Model.missingissue.*;
import IAS.Bean.missingissue.missingissueFormBean;
import IAS.Model.JDSModel;
import com.itextpdf.text.DocumentException;
import java.io.IOException;
import javax.xml.transform.TransformerException;
import org.apache.log4j.Logger;
import IAS.Class.JDSLogger;
import javax.servlet.http.HttpServletRequest;
import java.sql.*;
import IAS.Class.Queries;
import IAS.Class.convertToPdf;
import IAS.Class.util;
import java.io.ByteArrayOutputStream;
import java.io.OutputStream;
import javax.xml.parsers.ParserConfigurationException;
import java.text.ParseException;
import javax.servlet.http.HttpServletResponse;
import IAS.Class.JDSConstants;
import IAS.Class.util;
import IAS.Model.JDSModel;
import com.mysql.jdbc.Statement;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Calendar;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import org.apache.log4j.Logger;

/**
 *
 * @author aloko
 */
public class missingissueModel extends JDSModel {

    private missingissueFormBean _missingissueFormBean = null;
    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Model.missingissue");

    public missingissueModel(HttpServletRequest request) throws SQLException{

       super(request);

    }

     public String save()  throws IllegalAccessException, ParseException,
            ParserConfigurationException, SQLException, TransformerException,
            IOException, InvocationTargetException, Exception {
        String xml = null;
        int ins = 1;
        xml = util.convertStringToXML("1", "missingissueId");
        return xml;
    }


     public String getmissingissue()  throws SQLException, ParseException, ParserConfigurationException, TransformerException {
        String xml = null;

        ResultSet rs = null;

        xml = util.convertResultSetToXML(rs);
        return xml;
    }
     
     public String getList()  throws IllegalAccessException, ParseException,
            ParserConfigurationException, SQLException, TransformerException,
            IOException, InvocationTargetException, Exception {
        String xml = null;
        int ins = 1;
        xml = util.convertStringToXML("1", "missingissueId");
        return xml;
    }
}