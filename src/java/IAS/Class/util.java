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

    public static java.sql.Date dateStringToSqlDate(String stringDate) throws ParseException {

        if (stringDate == null || stringDate.length() == 0) {
            return null;
        }
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

    public static String convertStringToXML(String errorMsg,String tagName) throws ParserConfigurationException, SQLException, TransformerException {

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

    public static String getExceptionStackTraceAsString(Exception exception) {
        StringWriter sw = new StringWriter();
        exception.printStackTrace(new PrintWriter(sw));
        return sw.toString();
    }

    public void printResultSet(ResultSet result) throws SQLException
    {
        // Print the data obtained from the query
        ResultSetMetaData rsmd = result.getMetaData();

        printColTypes(rsmd);
        System.out.println("");

        int numberOfColumns = rsmd.getColumnCount();

        for (int i = 1; i <= numberOfColumns; i++)
        {
            if (i > 1) System.out.print(",  ");
            String columnName = rsmd.getColumnName(i);
            System.out.print(columnName);
        }
        System.out.println("");

        while (result.next())
        {
                for (int i = 1; i <= numberOfColumns; i++) {
                if (i > 1) System.out.print(",  ");
                String columnValue = result.getString(i);
                System.out.print(columnValue);
            }
            System.out.println("");
        }
        // End of print of data obtained from query
    }

    public void printColTypes(ResultSetMetaData rsmd)
                            throws SQLException {
    int columns = rsmd.getColumnCount();
    for (int i = 1; i <= columns; i++) {
      int jdbcType = rsmd.getColumnType(i);
      String name = rsmd.getColumnTypeName(i);
      System.out.print("Column " + i + " is JDBC type " + jdbcType);
      System.out.println(", which the DBMS calls " + name);
    }
    }
}
