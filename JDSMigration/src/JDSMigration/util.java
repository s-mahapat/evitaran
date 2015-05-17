 /*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package JDSMigration;

//import java.util.*;
import java.io.StringWriter;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.Format;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

/**
 *
 * @author Shailendra Mahapatra
 */
public final class util {

    public static String getDateString() {
        Format dtformat = new SimpleDateFormat("dd/MM/yyyy");
        java.util.Date dt = new java.util.Date();
        return dtformat.format(dt);
    }

    public static String getDateString(String dateFormat) {
        Format dtformat = new SimpleDateFormat(dateFormat);
        java.util.Date dt = new java.util.Date();
        return dtformat.format(dt);
    }

    public static java.sql.Date dateStringToSqlDate(String stringDate) throws ParseException {

        if (stringDate == null || stringDate.length() == 0) {
            stringDate = "01/01/1900";
        }
        DateFormat formater = new SimpleDateFormat("dd/MM/yyyy");
        java.util.Date parsedUtilDate = formater.parse(stringDate);
        java.sql.Date sqlDate = new java.sql.Date(parsedUtilDate.getTime());
        return sqlDate;
    }

    public static java.sql.Date dateStringToSqlDate(String stringDate, String Format) throws ParseException {

        if (stringDate == null || stringDate.length() == 0) {
            return null;
        }
        DateFormat formater = new SimpleDateFormat(Format);
        java.util.Date parsedUtilDate = formater.parse(stringDate);
        java.sql.Date sqlDate = new java.sql.Date(parsedUtilDate.getTime());
        return sqlDate;
    }

    public static String convertResultSetToXML(ResultSet rs) throws ParserConfigurationException, SQLException, TransformerException {

        String xml = null;
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document doc = builder.newDocument();

        Element results = doc.createElement("results");
        doc.appendChild(results);

        ResultSetMetaData rsmd = rs.getMetaData();
        int colCount = rsmd.getColumnCount();

        while (rs.next()) {
            Element row = doc.createElement("row");
            results.appendChild(row);

            for (int i = 1; i <= colCount; i++) {
                //String columnName = rsmd.getColumnName(i);
                String columnName = rsmd.getColumnLabel(i);
                // check if the value is null, then initialize it to a blank string
                Object value = rs.getObject(i) != null ? rs.getObject(i) : "";
                Element node = doc.createElement(columnName);
                node.appendChild(doc.createTextNode(value.toString()));
                row.appendChild(node);
            }
        }
        DOMSource domSource = new DOMSource(doc);
        StringWriter writer = new StringWriter();
        StreamResult result = new StreamResult(writer);
        TransformerFactory tf = TransformerFactory.newInstance();
        Transformer transformer = tf.newTransformer();
        transformer.transform(domSource, result);
        xml = writer.toString();

        return xml;

    }

    public static String convertStringToXML(String errorMsg, String tagName) throws ParserConfigurationException, SQLException, TransformerException {

        String xml = null;
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document doc = builder.newDocument();

        Element results = doc.createElement("results");
        doc.appendChild(results);

        Element error = doc.createElement(tagName);
        results.appendChild(error);
        error.appendChild(doc.createTextNode(errorMsg));

        DOMSource domSource = new DOMSource(doc);
        StringWriter writer = new StringWriter();
        StreamResult result = new StreamResult(writer);
        TransformerFactory tf = TransformerFactory.newInstance();
        Transformer transformer = tf.newTransformer();
        transformer.transform(domSource, result);
        xml = writer.toString();

        return xml;

    }

    public static String convertDateFormat(String date, String old_format, String new_format) throws ParseException {

        String oldDateString = date;
        String newDateString;

        SimpleDateFormat sdf = new SimpleDateFormat(old_format);
        java.util.Date d = sdf.parse(oldDateString);
        sdf.applyPattern(new_format);
        newDateString = sdf.format(d);
        return newDateString;
    }
}
