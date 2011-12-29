package IAS.Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import IAS.Model.inwardModel;
import java.sql.SQLException;

public class inward extends HttpServlet {

    private inwardModel _inwardModel = null;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String url = null;

        try {

            _inwardModel = new IAS.Model.inwardModel(request);

            /*
             * If the action is to save the inward
             */
            if (action.equalsIgnoreCase("save")) {
                //if the record count saved is 1, it indicates that the record was saved else fail.
                if (_inwardModel.Save() == 1) {
                    url = "/jsp/inward/viewinward.jsp";
                } else {
                    url = "/jsp/errors/error.jsp";
                }
            }
            /*
             * If the action is to edit the inward
             */
            else if (action.equalsIgnoreCase("edit")) {

                if (_inwardModel.editInward() != null) {
                    url = "/jsp/inward/editinward.jsp";
                } else {
                    url = "/jsp/errors/error.jsp";
                }

            }
            /*
             * If the action is to view the inward
             */
            else if (action.equalsIgnoreCase("view")) {

                if (_inwardModel.viewInward() != null) {
                    url = "/jsp/inward/viewinward.jsp";
                } else {
                    url = "/jsp/errors/error.jsp";
                }

            } else if (action.equalsIgnoreCase("sendAck")) {
                url = "/jsp/inward/ackinward.jsp";
            } else if (action.equalsIgnoreCase("sendReturn")) {
                url = "/jsp/inward/returninward.jsp";
            } else if (action.equalsIgnoreCase("search")) {

                // searchInward gets all the inwards based on the search criteria entered on screen by the user.
                String xml = _inwardModel.searchInward();
                request.setAttribute("xml", xml);
                url = "/xmlserver";

            }else if (action.equalsIgnoreCase("pendinginwards")){
                // searchInward gets all the inwards based on the search criteria entered on screen by the user.
                String xml = _inwardModel.getPendngInwards();
                request.setAttribute("xml", xml);
                url = "/xmlserver";

            }else if (action.equalsIgnoreCase("processinward")){

                String inwardNumber = request.getParameter("inwardNumber");
                int subscriberId = Integer.parseInt(request.getParameter("subscriberId"));
                String purpose = request.getParameter("purpose");
            }
        } catch (SQLException e) {
            url = "/jsp/errors/error.jsp";

        } catch (Exception e) {
            url = "/jsp/errors/error.jsp";

        } finally {
            RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
            if (rd != null) {
                rd.forward(request, response);
                //response.sendRedirect(request.getContextPath() + url);
            }
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
