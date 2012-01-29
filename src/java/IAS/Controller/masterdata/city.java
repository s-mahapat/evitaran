/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Controller.masterdata;

import IAS.Controller.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import IAS.Bean.masterdata.cityFormBean;
import IAS.Model.masterdata.cityModel;
/**
 *
 * @author Deepali gokhale
 */
public class city extends HttpServlet {
    private cityModel _cityModel = null;
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
       
        cityFormBean _cityFormBean = new IAS.Bean.masterdata.cityFormBean();
        
        String url = null;
        try{
            _cityModel = new IAS.Model.masterdata.cityModel(request, _cityFormBean);
            
            if(action.equalsIgnoreCase("save")){
                _cityModel.Save();
                url = "/jsp/masterdata/displayCity.jsp";
            }else if(action.equalsIgnoreCase("edit")){
                _cityModel.editCity();
                url = "/jsp/masterdata/editCity.jsp";
            }else if(action.equalsIgnoreCase("view")){
                _cityModel.viewCity();
                url = "/jsp/masterdata/displayCity.jsp";
            }else if(action.equalsIgnoreCase("search")){
                // searchInward gets all the inwards based on the search criteria entered on screen by the user.
                String xml = _cityModel.searchCity();
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
