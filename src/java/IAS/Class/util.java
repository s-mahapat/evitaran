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
import java.util.ArrayList;

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

    public static String getDateString(Date dt, String dateFormat) {
        Format dtformat = new SimpleDateFormat(dateFormat);
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

    // The date format to be used everywhere is dd/MM/yyyy.
    // If the date format is of the form yyyy-MM-dd, this function helps to convert back to the correct format
    public static String changeDateFormat(String stringDate) throws ParseException {
        if (stringDate == null || stringDate.length() == 0) {
            return null;
        }
        SimpleDateFormat formater = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date parsedUtilDate = formater.parse(stringDate);
        formater.applyPattern("dd/MM/yyyy");
        return formater.format(parsedUtilDate);
    }

    // The date format to be used everywhere is dd/MM/yyyy.
    // This function checks if the date is in this format.
    public static boolean checkDateFormat(String stringDate) {
        if (stringDate == null || stringDate.length() == 0) {
            return false;
        }
        DateFormat formater = new SimpleDateFormat("dd/MM/yyyy");
        try {
            formater.parse(stringDate);
            return true;
        } catch (ParseException pe) {
            return false;
        }
    }

    public static String convertResultSetToXML(ResultSet rs, int pageNumber,
            int pageSize, int totalQueryCount)
            throws ParserConfigurationException, SQLException, TransformerException {

        String xml = null;
        double totalPages = 0;
        if (totalQueryCount > 0) {
            totalPages = (double) totalQueryCount / (double) pageSize;
            totalPages = java.lang.Math.ceil(totalPages);
        }

        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document doc = builder.newDocument();

        Element results = doc.createElement("results");
        doc.appendChild(results);

        Element page = doc.createElement("page");
        results.appendChild(page);
        page.appendChild(doc.createTextNode(String.valueOf(pageNumber)));

        Element total = doc.createElement("total");
        results.appendChild(total);
        total.appendChild(doc.createTextNode(String.valueOf(totalPages)));

        Element records = doc.createElement("records");
        results.appendChild(records);
        records.appendChild(doc.createTextNode(String.valueOf(totalQueryCount)));

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

    public static String convertStringToXML(String text, String tagName) throws ParserConfigurationException, SQLException, TransformerException, IOException {

        String xml = null;
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document doc = builder.newDocument();

        Element results = doc.createElement("results");
        doc.appendChild(results);

        Element error = doc.createElement(tagName);
        results.appendChild(error);
        error.appendChild(doc.createTextNode(text));

        DOMSource domSource = new DOMSource(doc);
        try (StringWriter writer = new StringWriter()) {
            StreamResult result = new StreamResult(writer);
            TransformerFactory tf = TransformerFactory.newInstance();
            Transformer transformer = tf.newTransformer();
            transformer.transform(domSource, result);
            xml = writer.toString();
        }

        return xml;

    }

    public static String getExceptionStackTraceAsString(Exception exception) {
        StringWriter sw = new StringWriter();
        exception.printStackTrace(new PrintWriter(sw));
        return sw.toString();
    }

    public static void printResultSet(ResultSet result) throws SQLException {
        // Print the data obtained from the query
        ResultSetMetaData rsmd = result.getMetaData();

        printColTypes(rsmd);
        System.out.println("");

        int numberOfColumns = rsmd.getColumnCount();

        for (int i = 1; i <= numberOfColumns; i++) {
            if (i > 1) {
                System.out.print(",  ");
            }
            String columnName = rsmd.getColumnName(i);
            System.out.print(columnName);
        }
        System.out.println("");

        while (result.next()) {
            for (int i = 1; i <= numberOfColumns; i++) {
                if (i > 1) {
                    System.out.print(",  ");
                }
                String columnValue = result.getString(i);
                System.out.print(columnValue);
            }
            System.out.println("");
        }
        // End of print of data obtained from query
    }

    public static void printColTypes(ResultSetMetaData rsmd)
            throws SQLException {
        int columns = rsmd.getColumnCount();
        for (int i = 1; i <= columns; i++) {
            int jdbcType = rsmd.getColumnType(i);
            String name = rsmd.getColumnTypeName(i);
            System.out.print("Column " + i + " is JDBC type " + jdbcType);
            System.out.println(", which the DBMS calls " + name);
        }
    }

    public static String convertResultSetWithoutIDToXML(ResultSet result) throws SQLException {
        String xml = "";
        xml = xml + "<?xml version='1.0' encoding='utf-8'?>\n";
        //System.out.println("<?xml version='1.0' encoding='utf-8'?>\n");
        xml = xml + "<results>";
        //System.out.println("<results>");

        ResultSetMetaData rsmd = result.getMetaData();
        int numberOfColumns = rsmd.getColumnCount();

        int id = 1;
        while (result.next()) {
            for (int i = 1; i <= numberOfColumns; i++) {
                String columnValue = result.getString(i);

                if (i == 1) {
                    xml = xml + "<row>";
                }

                xml = xml + "<id>" + id + "</id>";
                xml = xml + "<" + rsmd.getColumnName(i) + ">" + columnValue + "</" + rsmd.getColumnName(i) + ">";

                if (i == numberOfColumns) {
                    xml = xml + "</row>";
                }
            }
            id++;
        }
        xml = xml + "</results>";

        return xml;
    }

    public static int[] convertStringArraytoIntArray(String[] sarray) throws Exception {
        if (sarray != null) {
            int intarray[] = new int[sarray.length];
            for (int i = 0; i < sarray.length; i++) {
                intarray[i] = Integer.parseInt(sarray[i]);
            }
            return intarray;
        }
        return null;
    }

    public static float[] convertStringArraytoFloatArray(String[] sarray) throws Exception {
        if (sarray != null) {
            float floatarray[] = new float[sarray.length];
            for (int i = 0; i < sarray.length; i++) {
                floatarray[i] = Float.parseFloat(sarray[i]);
            }
            return floatarray;
        }
        return null;
    }
    
    public static int getPreviousMonth(int currentMonth){
        int previousMonth;
        if(currentMonth == 1){
            previousMonth = 12;
        }else{
            previousMonth = currentMonth - 1;
        }
        return previousMonth;
    }

    public static String convertArrayListToXML(ArrayList<String> arr, String tagname) throws ParserConfigurationException, SQLException, TransformerException, IOException {

        String xml = null;
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document doc = builder.newDocument();

        Element results = doc.createElement("results");
        doc.appendChild(results);
        for (int i = 0; i < arr.size(); i++) {
            Element error = doc.createElement(tagname);
            results.appendChild(error);
            error.appendChild(doc.createTextNode(arr.get(i)));
        }

        DOMSource domSource = new DOMSource(doc);
        try (StringWriter writer = new StringWriter()) {
            StreamResult result = new StreamResult(writer);
            TransformerFactory tf = TransformerFactory.newInstance();
            Transformer transformer = tf.newTransformer();
            transformer.transform(domSource, result);
            xml = writer.toString();
        }


        return xml;

    }
}
