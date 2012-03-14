package IAS.Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import org.apache.log4j.*;
import IAS.Class.JDSLogger;

public class main extends HttpServlet {

    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Controller.main");

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
        String url = null;
        if (action.equalsIgnoreCase("home")) {

            url = "/jsp/home.jsp";

        } else if (action.equalsIgnoreCase("logout")) {

            request.getSession().invalidate();
            //response.sendRedirect(request.getContextPath() + "/home");
            url = "/jsp/login/logout.jsp";

        } else if (action.equalsIgnoreCase("createinward")) {

            url = "/jsp/inward/createinward.jsp";

        } else if (action.equalsIgnoreCase("searchinward")) {

            url = "/jsp/inward/searchinward.jsp";

        } else if (action.equalsIgnoreCase("pendinginwards")) {

            url = "/jsp/inward/pendinginwards.jsp";

        } else if (action.equalsIgnoreCase("gml")) {

            url = "/jsp/ml/generateml.jsp?list=ml";

        } else if (action.equalsIgnoreCase("gbil")) {

            url = "/jsp/ml/generateml.jsp?list=bil";

        } else if (action.equalsIgnoreCase("newsubscription")) {

            url = "/jsp/inward/gatekeeperinward.jsp?nextAction=newsubscription&inwardPurpose=New Subscription&next=" + request.getContextPath() + "/jsp/subscriber/createsubscriber.jsp";

        } else if (action.equalsIgnoreCase("renewsubscription")) {

            url = "/jsp/inward/gatekeeperinward.jsp?nextAction=renewsubscription&inwardPurpose=Renew Subscription&next=" + request.getContextPath() + "/jsp/subscription/addnewsubscription.jsp";

        } else if (action.equalsIgnoreCase("missingissue")) {

            url = "/jsp/inward/gatekeeperinward.jsp?nextAction=missingissue&inwardPurpose=Missing Issue&next=" + request.getContextPath() + "/jsp/missingissue/missingissuelist.jsp";

        } else if (action.equalsIgnoreCase("gcreatesubscriber")) {

            url = "/jsp/inward/gatekeeperinward.jsp?nextAction=createsubscriber&inwardPurpose=New Subscription&next=" + request.getContextPath() + "/main?action=createsubscriber";

        } else if (action.equalsIgnoreCase("createsubscriber")) {

            url = "/jsp/subscriber/createsubscriber.jsp";
            
        } else if (action.equalsIgnoreCase("searchsubscriber")) {

            url = "/jsp/subscriber/searchsubscriber.jsp";

        } else if (action.equalsIgnoreCase("addresschange")) {

            url = "/jsp/inward/gatekeeperinward.jsp?nextAction=addresschange&inwardPurpose=Address Change&next=" + request.getContextPath() + "/jsp/subscriber/editsubscriber.jsp";

        } else if (action.equalsIgnoreCase("searchSubType")) {

            url = "/jsp/masterdata/searchSubType.jsp";

        } else if (action.equalsIgnoreCase("searchJournal")) {

            url = "/jsp/masterdata/searchJournal.jsp";

        } else if (action.equalsIgnoreCase("searchAgent")) {

            url = "/jsp/masterdata/searchAgent.jsp";

        } else if (action.equalsIgnoreCase("subRate")) {

            url = "/jsp/masterdata/annualSubscriptionrates.jsp";

        } else if (action.equalsIgnoreCase("searchCity")) {

            url = "/jsp/masterdata/searchCity.jsp";

        } else if (action.equalsIgnoreCase("searchCountry")) {

            url = "/jsp/masterdata/searchCountry.jsp";

        } else if (action.equalsIgnoreCase("searchDistrict")) {

            url = "/jsp/masterdata/searchDistirct.jsp";

        } else if (action.equalsIgnoreCase("searchState")) {

            url = "/jsp/masterdata/searchState.jsp";

        } else if (action.equalsIgnoreCase("listAgent")) {

            url = "/jsp/reports/listAgent.jsp";

        } else if (action.equalsIgnoreCase("listBackissue")) {

            url = "/jsp/reports/listBackissue.jsp";

        } else if (action.equalsIgnoreCase("listJournals")) {

            url = "/jsp/reports/listJournals.jsp";

        } else if (action.equalsIgnoreCase("listReminder")) {

            url = "/jsp/reports/listRenewalReminder.jsp";

        } else if (action.equalsIgnoreCase("listSubType")) {

            url = "/jsp/reports/listSubType.jsp";

        } else if (action.equalsIgnoreCase("listSubscriber")) {

            url = "/jsp/reports/listSubscriber.jsp";

        } else if (action.equalsIgnoreCase("listmailinglist")) {

            url = "/jsp/reports/listmailinglist.jsp";

        } else if (action.equalsIgnoreCase("statement")) {

            url = "/jsp/reports/statement.jsp";

        } else if (action.equalsIgnoreCase("journalRates")) {

            url = "/jsp/reports/journalRates.jsp";

        } else if (action.equalsIgnoreCase("circulationFigure")) {

            url = "/jsp/reports/circulationFiguresJournal.jsp";

        } else if (action.equalsIgnoreCase("listprofarmaInvoice")) {

            url = "/jsp/reports/listprofarmaInvoice.jsp";

        } else if (action.equalsIgnoreCase("listInwards")) {

            url = "/jsp/reports/listInwards.jsp";

        }else if (action.equalsIgnoreCase("sendReminders")) {

            url = "/jsp/reminders/sendReminders.jsp";

        } else if (action.equalsIgnoreCase("gpi")) {

            url = "/jsp/inward/gatekeeperinward.jsp?nextAction=gpi&inwardPurpose=Request For Invoice&next=" + request.getContextPath() + "/jsp/invoice/proforma.jsp";

        } else if (action.equals("urn")) {

            url = "/jsp/inward/urn.jsp";

        } else if (action.equals("asf")) {

            url = "/jsp/inward/gatekeeperinward.jsp?nextAction=createsubscriber&inwardPurpose=New Subscription&purpose=200";

        } else if (action.equals("afs")) {

            url = "/jsp/inward/gatekeeperinward.jsp?nextAction=createsubscriber&inwardPurpose=New Subscription&purpose=100";

        } else if (action.equals("printOrder")) {

            url = "/jsp/masterdata/displayPrintOrder.jsp";

        } else if (action.equals("jsGroup")) {

            url = "/jsp/masterdata/searchJournalSubGroup.jsp";

        }else if (action.equals("jpGroup")) {

            url = "/jsp/masterdata/searchJournalPriceGroup.jsp";

        }

        if(url == null){
            url = "/jsp/errors/404.jsp";
            logger.error("Redirect url was not found, forwarding to 404");
        }
        else
        {
            logger.debug("Called->" + url);
        }


        RequestDispatcher rd = request.getRequestDispatcher(url);
        rd.forward(request, response);


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
