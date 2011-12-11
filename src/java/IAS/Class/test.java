/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import java.sql.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.io.File;
import org.w3c.dom.Document;
import org.w3c.dom.*;
import javax.xml.parsers.*;
import java.io.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.stream.*;

/**
 *
 * @author Shailendra Mahapatra
 */
public class test {

    public static void main(String[] args) {

        String xml = null;
        try {
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/JDS", "jds", "jds");

            String query = "select * from cities";
            PreparedStatement st = connection.prepareStatement(query);
            ResultSet rs = st.executeQuery(query);
            //FormattedDataSet fds = new FormattedDataSet();
            //String xml = fds.getFormattedDataSet(rs.getMetaData(), rs, "xml");
            xml = toDocument(rs);
            System.out.println(xml);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
        } finally {
            //db.close();
        }

    }

    public static String toDocument(ResultSet rs)
            throws ParserConfigurationException, SQLException {

        String xml = null;
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document doc = builder.newDocument();

        Element results = doc.createElement("Results");
        doc.appendChild(results);

        ResultSetMetaData rsmd = rs.getMetaData();
        int colCount = rsmd.getColumnCount();

        while (rs.next()) {
            Element row = doc.createElement("Row");
            results.appendChild(row);

            for (int i = 1; i <= colCount; i++) {
                String columnName = rsmd.getColumnName(i);
                Object value = rs.getObject(i);

                Element node = doc.createElement(columnName);
                node.appendChild(doc.createTextNode(value.toString()));
                row.appendChild(node);
            }
        }

        try {
            DOMSource domSource = new DOMSource(doc);
            StringWriter writer = new StringWriter();
            StreamResult result = new StreamResult(writer);
            TransformerFactory tf = TransformerFactory.newInstance();
            Transformer transformer = tf.newTransformer();
            transformer.transform(domSource, result);
            xml = writer.toString();
        } catch (TransformerException ex) {
            ex.printStackTrace();
        }

        return xml;

    }
}
