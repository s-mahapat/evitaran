/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Controller;

import IAS.Class.Database;
import IAS.Class.Queries;
import IAS.Class.util;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Shailendra Mahapatra
 */
public class CMasterData extends JDSController {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String xml = null;
        String strDBValue = null;
        String mdataRequested = request.getParameter("md").toLowerCase();
        Database db = (Database) request.getSession().getAttribute("db_connection");
        String mdataReqKey = request.getParameter("mdkey");
        String mdataReqValue = request.getParameter("mdvalue");
        try {
            if (mdataReqValue == null) {
                xml = util.convertResultSetToXML(db.executeQuery(Queries.getQuery(mdataRequested)));
            }
            if (mdataReqValue != null) {
                PreparedStatement ps = db.getConnection().prepareStatement(Queries.getQuery(mdataRequested));
                ps.setString(1, mdataReqValue);
                ResultSet rs = ps.executeQuery();
                xml = util.convertResultSetToXML(rs);
            }
        } catch (SQLException ex) {

        } catch (Exception ex) {

        } finally {
            response.setContentType("text/xml");
            out.println(xml);
            out.close();
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
