/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package JDS.report;

import java.sql.*;
import JDS.beans.ConnectionInfoBean;
import JDS.db.DriverUtilities;
import JDS.db.DriverUtilities2;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author aloko
 */
public class generateReport extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {

            ServletContext context = getServletContext();
            String path = context.getRealPath("/WEB-INF/drivers.xml");
            String vendor = "MYSQL";
            DriverUtilities2.loadDrivers(path);
            if(!DriverUtilities.isValidVendor(vendor))
            {
                out.println("Vendor: " + vendor + " not supported" + "<br>");
            }
            else
            {
                String dbName = "bes";
                String host = "HCA-J83Q6BS";
                String driver = DriverUtilities.getDriver(vendor);
                String url = DriverUtilities2.makeURL(host, dbName, vendor);
                Connection connection = ConnectionInfoBean.getConnection(driver, url, "root", "root");

                if (request.getParameter("action").equals("fetchData"))
                {
                    response.setContentType("text/xml;charset=UTF-8");

                    // Get the requested page. By default grid sets this to 1.
                    int page = Integer.parseInt(request.getParameter("page"));
                    // get how many rows we want to have into the grid - rowNum parameter in the grid
                    int limit = Integer.parseInt(request.getParameter("rows"));
                    // get index row - i.e. user click to sort. At first time sortname parameter -
                    // after that the index from colModel
                    String sidx = request.getParameter("sidx");
                    // sorting order - at first time sortorder
                    String sord = request.getParameter("sord");
                    // if we not pass at first time index use the first column for the index or what you want
                    if(sidx == null || sidx.length() == 0) sidx = "id";

                    // Get the total no of rows
                    // Alternate query:
                    String queryFormat = "select count(*) as count from besdata";
                    //String queryFormat = "select count(*) from besdata";
                    Statement statement = connection.createStatement();
                    ResultSet result =  statement.executeQuery(queryFormat);
                    int records=0;
                    while (result.next())
                    records = Integer.parseInt(result.getString(1));
                    //System.out.println("Rows: " + records);

                    // calculate the total pages for the query
                    int total_pages;
                    if( records > 0 ) {
                        total_pages = (int)Math.ceil((float)records/(float)limit);
                    } else {
                        total_pages = 0;
                    }

                    // if for some reasons the requested page is greater than the total
                    // set the requested page to total page
                    if (page > total_pages) page=total_pages;

                    // calculate the starting position of the rows
                    int start;
                    start = limit*page - limit;

                    // if for some reasons start position is negative set it to 0
                    // typical case is that the user type 0 for the requested page
                    if(start <0) start = 0;

                    // the actual query for the grid data
                    // This  type of query returns the id as well
                    // queryFormat = "select * from besdata";
                    // This type of query does not return the id
                    //String queryFormat = "select emailid, subject, text, status, date from besdata";
                    //queryFormat = "SELECT besdata.id, besdata.emailid, besdata.subject, besdata.status, besdata.date, messagetText.messageText FROM besdata LEFT JOIN messageText ON besdata.messageTextID=messageText.messageTextID ORDER BY " + sidx + " " + sord + " " + "LIMIT" + " " + Integer.toString(start) + " , " + Integer.toString(limit);
                    queryFormat = "SELECT besdata.id, besdata.emailid, besdata.status, besdata.date, messagetext.messageText, subject.subject FROM besdata LEFT JOIN messagetext ON besdata.messageTextID=messagetext.messageTextID LEFT JOIN subject ON besdata.subjectID=subject.subjectID ORDER BY " + sidx + " " + sord + " " + "LIMIT" + " " + Integer.toString(start) + " , " + Integer.toString(limit);
                    //queryFormat = "SELECT id, emailid, subject, text, status, date FROM besdata ORDER BY " + sidx + " " + sord + " " + "LIMIT" + " " + Integer.toString(start) + " , " + Integer.toString(limit);
                    statement = connection.createStatement();
                    result =  statement.executeQuery(queryFormat);

                    //printResultSet(result);
                    //System.out.println("Successfully read from database");

                    out.print("<?xml version='1.0' encoding='utf-8'?>\n");
                    //System.out.println("<?xml version='1.0' encoding='utf-8'?>\n");
                    out.print("<results>");
                    //System.out.println("<results>");
                    out.print("<page>" + Integer.toString(page) + "</page>");
                    //System.out.println("<page>" + Integer.toString(page) + "</page>");
                    out.print("<total>" + Integer.toString(total_pages) + "</total>");
                    //System.out.println("<total>" + Integer.toString(total_pages) + "</total>");
                    out.print("<records>" + Integer.toString(records) + "</records>");
                    //System.out.println("<records>" + Integer.toString(records) + "</records>");

                    ResultSetMetaData rsmd = result.getMetaData();
                    int numberOfColumns = rsmd.getColumnCount();

                    while (result.next())
                    {
                        for (int i = 1; i <= numberOfColumns; i++)
                        {
                            String columnValue = result.getString(i);

                            if(i == 1)
                            {
                                //out.print("<row id='" + columnValue + "'>");
                                //out.print("<row " + rsmd.getColumnName(i) + "='" + columnValue + "'>");
                                //System.out.println("<row id='" + columnValue + "'>");
                                //System.out.println("<row " + rsmd.getColumnName(i) + "='" + columnValue + "'>");
                                out.print("<row>");
                                //System.out.println("<row>");
                            }

                            //out.print("<cell>" + columnValue + "</cell>");
                            out.print("<" + rsmd.getColumnName(i) + ">" + columnValue + "</" + rsmd.getColumnName(i) + ">");
                            //System.out.println("<cell>" + columnValue + "</cell>");
                            //System.out.println("<" + rsmd.getColumnName(i) + ">" + columnValue + "</" + rsmd.getColumnName(i) + ">");

                            if(i == numberOfColumns)
                            {
                                out.print("</row>");
                                //System.out.println("</row>");
                             }
                        }
                    }
                    out.print("</results>");
                    //System.out.println("</results>");
                }
            }
        } finally {
            out.close();
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(generateReport.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(generateReport.class.getName()).log(Level.SEVERE, null, ex);
        }
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
