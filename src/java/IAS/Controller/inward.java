package IAS.Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import IAS.Model.Inward.inwardModel;
import javax.servlet.http.HttpSession;

public class inward extends HttpServlet {

    private inwardModel _inwardModel = null;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String url = null;

        try {

            _inwardModel = new IAS.Model.Inward.inwardModel(request);

            /*
             * If the action is to save the inward
             */
            if (action.equalsIgnoreCase("save")) {
                //if the record count saved is 1, it indicates that the record was saved else fail.
                if (_inwardModel.Save() == 1) {
                    url = "/jsp/inward/viewinward.jsp";
                }
            } /*
             * If the action is to edit the inward
             */ else if (action.equalsIgnoreCase("edit")) {

                if (_inwardModel.editInward() != null) {
                    url = "/jsp/inward/editinward.jsp";
                }

            } /*
             * If the action is to view the inward
             */ else if (action.equalsIgnoreCase("view")) {

                if (_inwardModel.viewInward() != null) {
                    url = "/jsp/inward/viewinward.jsp";
                }

            } else if (action.equalsIgnoreCase("sendAck")) {
                url = "/jsp/inward/ackinward.jsp";
            } else if (action.equalsIgnoreCase("sendReturn")) {
                if (_inwardModel.viewInward() != null) {
                    url = "/jsp/inward/returninward.jsp";
                }
            } else if (action.equalsIgnoreCase("search")) {

                // searchInward gets all the inwards based on the search criteria entered on screen by the user.
                String xml = _inwardModel.searchInward();
                request.setAttribute("xml", xml);
                url = "/xmlserver";

            } else if (action.equalsIgnoreCase("pendinginwards")) {
                // searchInward gets all the inwards based on the search criteria entered on screen by the user.
                String xml = _inwardModel.getPendngInwards();
                request.setAttribute("xml", xml);
                url = "/xmlserver";

            } else if (action.equalsIgnoreCase("processinward")) {

                String inwardNumber = request.getParameter("inwardNumber");
                String subscriberNumber = request.getParameter("subscriberNumber");
                HttpSession session = request.getSession(false);
                session.setAttribute("inwardUnderProcess", inwardNumber);

                // we should use the purpose id rather than the purpose name, it can change in the database
                // but id should not change
                int purposeID = Integer.parseInt(request.getParameter("purpose"));

                if (purposeID == 1) {

                    if (subscriberNumber != null && !subscriberNumber.isEmpty()) {

                        IAS.Model.subscriberModel _subscriberModel = new IAS.Model.subscriberModel(request);
                        if (_subscriberModel.GetSubscriber() != null) {
                            url = "/subscriber?action=add";
                        }

                    } else {

                        url = "/main?action=createsubscriber";
                    }
                } else if (purposeID == 2) {
                    // Renew subscription
                    IAS.Model.subscriberModel _subscriberModel = new IAS.Model.subscriberModel(request);
                    if (_subscriberModel.GetSubscriber() != null) {
                        url = "/subscriber?action=add";
                    }
                } else if (purposeID == 3) {
                    //Address change
                    url = "/subscriber?action=edit";

                }else if (purposeID == 4) {
                    //Request for Invoice
                    url = "/jsp/invoice/proforma.jsp";

                }

            } else if (action.equalsIgnoreCase("saveReturn")) {
                // save the return
                if (_inwardModel.updateChequeReturn() != null) {
                    url = "/jsp/inward/returninward.jsp";
                }
            }
        } catch (Exception e) {
            throw new javax.servlet.ServletException(e);

        } finally {
            RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
            if (rd != null && url != null) {
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
