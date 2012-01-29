/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Controller.masterdata;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import IAS.Bean.masterdata.subTypeFormBean;
import IAS.Model.masterdata.subTypeModel;
/**
 *
 * @author Shailendra Mahapatra
 */
public class subType extends HttpServlet {
    private subTypeModel _subTypeModel = null;
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        subTypeFormBean _subTypeFormBean = new IAS.Bean.masterdata.subTypeFormBean();
        String url = null;
        try{
            _subTypeModel = new IAS.Model.masterdata.subTypeModel(request, _subTypeFormBean);
            if(action.equalsIgnoreCase("save")){
                _subTypeModel.Save();
                url = "/jsp/masterdata/displaySubType.jsp";
            }else if(action.equalsIgnoreCase("edit")){
                _subTypeModel.editSubType();
                url = "/jsp/masterdata/editSubType.jsp";
                _subTypeModel.viewSubType();
            }else if(action.equalsIgnoreCase("view")){
                url = "/jsp/masterdata/displaySubType.jsp";
            }else if(action.equalsIgnoreCase("search")){
                // searchInward gets all the inwards based on the search criteria entered on screen by the user.
                String xml = _subTypeModel.searchSubType();
                request.setAttribute("xml", xml);
                url = "/xmlserver";            
            }
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        }
        catch(Exception e){

        }
        finally{

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
