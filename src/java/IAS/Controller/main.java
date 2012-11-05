package IAS.Controller;

import IAS.Class.JDSLogger;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

public class main extends JDSController {

    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Controller.main");

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String url = null;
        if (action.equalsIgnoreCase("home")) {

            url = "/jsp/home.jsp";

        } else if (action.equalsIgnoreCase("logout")) {

            url = "/jsp/login/logout.jsp";

        } else if (action.equalsIgnoreCase("createinward")) {

            url = "/jsp/inward/createinward.jsp";

        } else if (action.equalsIgnoreCase("searchinward")) {

            url = "/jsp/inward/searchinward.jsp";

        } else if (action.equalsIgnoreCase("pendinginwards")) {

            url = "/jsp/inward/pendinginwards.jsp";

        } else if (action.equalsIgnoreCase("gml")) {

            url = "/jsp/ml/generateml.jsp?list=ml";

        } else if (action.equalsIgnoreCase("vml")) {

            url = "/jsp/ml/viewml.jsp?list=ml";

        }else if (action.equalsIgnoreCase("gbil")) {

            url = "/jsp/ml/generatebil.jsp?list=bil";

        } else if (action.equalsIgnoreCase("vbil")) {

            url = "/jsp/ml/viewbil.jsp?list=bil";

        }else if (action.equalsIgnoreCase("newsubscription")) {

            url = "/jsp/inward/gatekeeperinward.jsp?inwardPurpose=New Subscription";

        } else if (action.equalsIgnoreCase("renewsubscription")) {

            url = "/jsp/inward/gatekeeperinward.jsp?nextAction=renewsubscription&inwardPurpose=Renew Subscription&next=" + request.getContextPath() + "/jsp/subscription/addnewsubscription.jsp";

        } else if (action.equalsIgnoreCase("missingissue")) {

            url = "/jsp/inward/gatekeeperinward.jsp?nextAction=missingissue&inwardPurpose=Missing Issue&next=" + request.getContextPath() + "/jsp/missingissue/missingissuelist.jsp";

        } else if (action.equalsIgnoreCase("gcreatesubscriber")) {
            url = "/jsp/inward/gatekeeperinward.jsp?inwardPurpose=New Subscription";
            //url = "/jsp/inward/gatekeeperinward.jsp?nextAction=createsubscriber&inwardPurpose=New Subscription&next=" + request.getContextPath() + "/main?action=createsubscriber";

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

            url = "/reports?action=constructTableJournalRates";

        } else if (action.equalsIgnoreCase("circulationFigure")) {

            url = "/jsp/reports/circulationFiguresJournal.jsp";

        } else if (action.equalsIgnoreCase("subscriptionFigures")) {
            url = "/reports?action=constructTableSubcriptionFigures";

        } else if (action.equalsIgnoreCase("listprofarmaInvoice")) {

            url = "/jsp/reports/listprofarmaInvoice.jsp";

        } else if (action.equalsIgnoreCase("listInwards")) {

            url = "/jsp/reports/listInwards.jsp";

        } else if (action.equalsIgnoreCase("listprintOrder")) {

            url = "/reports?action=contructTableForPrintOrderReport";
            /*
            printOrderFormBeanReport _printOrderFormBeanReport = new IAS.Bean.Reports.printOrderFormBeanReport();
            request.setAttribute("printOrderFormBeanReport", _printOrderFormBeanReport);
            url = "/jsp/reports/listPrintOrder.jsp";
            */
        } else if (action.equalsIgnoreCase("sendReminders")) {

            url = "/jsp/reminders/sendReminders.jsp";

        } else if (action.equalsIgnoreCase("displayReminders")) {

            url = "/jsp/reminders/displayResendReminders.jsp";

        } else if (action.equalsIgnoreCase("gpi")) {

            url = "/jsp/inward/gatekeeperinward.jsp?nextAction=gpi&inwardPurpose=Request For Invoice&next=" + request.getContextPath() + "/jsp/invoice/proforma.jsp";

        } else if (action.equals("urn")) {

            url = "/jsp/inward/urn.jsp";

        } else if (action.equals("asf")) {

            url = "/jsp/inward/gatekeeperinward.jsp?inwardPurpose=New Subscription&asf=1";

        } else if (action.equals("afs")) {

            url = "/jsp/inward/gatekeeperinward.jsp?inwardPurpose=New Subscription&afs=1";

        } else if (action.equals("printOrder")) {

            url = "/jsp/masterdata/displayPrintOrder.jsp";

        } else if (action.equals("jsGroup")) {

            //url = "/jsp/masterdata/searchJournalSubGroup.jsp";
            url = "/jsp/masterdata/journalSubjectGroup.jsp";

        }else if (action.equals("jpGroup")) {

            //url = "/jsp/masterdata/searchJournalPriceGroup.jsp";
            url = "/jsp/masterdata/journalSubscriptionRateGroup.jsp";

        }else if (action.equals("prl")) {

            //url = "/jsp/masterdata/searchJournalPriceGroup.jsp";
            url = "/jsp/subscription/plreferlist.jsp";

        }else if (action.equals("sendBulkEmails")) {

            //url = "/jsp/masterdata/searchJournalPriceGroup.jsp";
            url = "jsp/BulkEmail/sendBulkEmail.jsp";

        }else if (action.equals("help")) {

            url = "/pdfserver?action=printHelp";

        }

        if(url == null){
            url = "/jsp/errors/404.jsp";
            logger.error("Redirect url was not found, forwarding to 404");
        }
        else
        {
            logger.debug("Called->" + url);
            // if the user clicks on the left menu reset the inwardunderprocess
            // else he may be able to add subscription/edit address without selecting an inward
            if(request.getSession() != null && request.getSession(false).getAttribute("inwardUnderProcess")!=null){
               request.getSession(false).setAttribute("inwardUnderProcess", null);
            }
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
