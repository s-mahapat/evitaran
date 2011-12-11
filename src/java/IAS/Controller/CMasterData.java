/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import org.w3c.dom.*;
import javax.xml.parsers.*;
import java.io.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.stream.*;
import java.io.PrintWriter;

/**
 *
 * @author Shailendra Mahapatra
 */
public class CMasterData extends HttpServlet {

    private IAS.Class.MasterData MasterDataModel = null;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String mdataRequested = request.getParameter("md");
        MasterDataModel = IAS.Class.MasterData.getInstance(request.getSession());

        if (mdataRequested.equalsIgnoreCase("city")) {
            String[] Columns = {mdataRequested.toLowerCase()};
            String xml = this.convertResultSetToXML(MasterDataModel.getColumnData(Columns,"cities"));
            out.println(xml);
            out.close();
        }

        if (mdataRequested.equalsIgnoreCase("country")) {
            String[] Columns = {mdataRequested.toLowerCase()};
            String xml = this.convertResultSetToXML(MasterDataModel.getColumnData(Columns,"countries"));
            out.println(xml);
            out.close();
        }

        if (mdataRequested.equalsIgnoreCase("state")) {
            String[] Columns = {mdataRequested.toLowerCase()};
            String xml = this.convertResultSetToXML(MasterDataModel.getColumnData(Columns,"states"));
            out.println(xml);
            out.close();
        }


    }

    public String convertResultSetToXML(ResultSet rs) {

        String xml = null;
        try {
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
                    String columnName = rsmd.getColumnName(i);
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
        } catch (ParserConfigurationException ex) {

        }catch(SQLException ex){

        }catch (TransformerException ex) {
            ex.printStackTrace();
        }

        return xml;

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
