/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

//import java.util.*;
import java.text.*;
import java.sql.*;
import org.w3c.dom.*;
import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.stream.*;
import java.io.*;

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

    public static java.sql.Date dateStringToSqlDate(String stringDate) throws ParseException{

        DateFormat formater = new SimpleDateFormat("dd/MM/yyyy");
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
                Object value = rs.getObject(i);

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
}
