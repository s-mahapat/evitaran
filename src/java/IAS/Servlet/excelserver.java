/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package IAS.Servlet;

import IAS.Class.BackIssueLabels;
import IAS.Class.JDSLogger;
import IAS.Class.ConvertToExcel;
import IAS.Class.convertToPdf;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author 310159477
 */
public class excelserver extends HttpServlet {

    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Servlet.excelserver");
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        try (ServletOutputStream os = response.getOutputStream()) {
            if (action.equalsIgnoreCase("printResultset")) {

                String query = (String) request.getAttribute("query");               
                ResultSet rs = (ResultSet) request.getAttribute("ResultSet");
                
                response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
                response.setHeader("Content-disposition", "attachment; filename=excel");

                ConvertToExcel rs2excel = new ConvertToExcel(rs, query);
                rs2excel.generateFromResultSet(os);

                os.flush();
                

            } else if (action.equalsIgnoreCase("printXML")) {

                String query = (String) request.getAttribute("query");
                String xml = (String) request.getAttribute("xml");

                response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
                response.setHeader("Content-disposition", "attachment; filename=excel");     
                
                ConvertToExcel rs2excel = new ConvertToExcel(xml, query);
                rs2excel.generateFromXML(os);                

                os.flush();

            } else if (action.equalsIgnoreCase("generatemlPrintLabel")) {

                ResultSet rs = (ResultSet) request.getAttribute("ResultSet");              
                
                response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
                response.setHeader("Content-disposition", "attachment; filename=excel");                

                String noHeader = request.getParameter("noHeader");
                String periodicals = request.getParameter("periodicals");                
                ConvertToExcel rs2excel = new ConvertToExcel("label-sticker", noHeader, periodicals);
                ArrayList<String> labels = rs2excel.getLabelContentExportToExcel(rs);
                rs2excel.generateFromArrayList(os, labels);
                
                os.flush();
            }else if (action.equalsIgnoreCase("generatebil")) {

                ResultSet rs = (ResultSet) request.getAttribute("ResultSet");
                
                response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
                response.setHeader("Content-disposition", "attachment; filename=excel");                

                String noHeader = request.getParameter("noHeader");
                String periodicals = request.getParameter("periodicals");
                String separateLabelForP = request.getParameter("separateLabelForP");
                String separateLabelForRES = request.getParameter("separateLabelForRES");
                String separateLabelForCURR = request.getParameter("separateLabelForCURR");

                BackIssueLabels bil = new BackIssueLabels();
                bil.BackIssueSticker(separateLabelForP, separateLabelForRES, separateLabelForCURR, false);
                ArrayList BILlabels = bil.prepareBILLabelContent(rs);    
                
                ConvertToExcel rs2excel = new ConvertToExcel("label-sticker", noHeader, periodicals);
                rs2excel.generateFromArrayList(os, BILlabels);                

                os.flush();
            } 
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            throw new javax.servlet.ServletException(e);
        }            
    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
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
     *
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
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
