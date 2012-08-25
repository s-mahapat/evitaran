


package IAS.Controller.reports;

import IAS.Bean.Reports.printOrderFormBeanReport;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import IAS.Model.Reports.reportModel;
import org.apache.log4j.Logger;
import IAS.Class.JDSLogger;
import IAS.Class.msgsend;
import IAS.Class.util;
import IAS.Controller.JDSController;
import java.sql.ResultSet;
import javax.servlet.ServletContext;
/**
 *
 * @author Deepali
 */
public class reports extends JDSController {

    private reportModel _reportModel = null;
    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Controller.reports");

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String url = null;

        try{

            _reportModel = new IAS.Model.Reports.reportModel(request);
            /*----------------------------------------------------------------*/
            if(action.equalsIgnoreCase("listRates")){

                ResultSet rs = _reportModel.listRates();
                String xml = util.convertResultSetToXML(rs);
                request.setAttribute("xml", xml);
                url = "/xmlserver";

            }else if(action.equalsIgnoreCase("printRates")){

                ResultSet rs = _reportModel.listRates();
                request.setAttribute("ResultSet", rs);
                String query = "Annual Rates for Journals";
                request.setAttribute("query", query);
                url = "/pdfserver?action=printResultset";

            }

            /*----------------------------------------------------------------*/
            if(action.equalsIgnoreCase("listJournalGroup")){

                ResultSet rs = _reportModel.searchJournalGroup();
                String xml = util.convertResultSetToXML(rs);
                request.setAttribute("xml", xml);
                url = "/xmlserver";

            }else if(action.equalsIgnoreCase("printJournalGroup")){

                ResultSet rs = _reportModel.searchJournalGroup();
                request.setAttribute("ResultSet", rs);
                String query = "List of journals in group";
                request.setAttribute("query", query);
                url = "/pdfserver?action=printResultset";

            }
            // This actually generates a html page with table. This functionality is nolonger used
            else if(action.equalsIgnoreCase("listJournalPrint")){

                ResultSet rs = _reportModel.searchJournalGroup();
                request.setAttribute("ResultSet", rs);
                url = "/jsp/reports/listJournalPrint.jsp";

            }
            /*----------------------------------------------------------------*/
            else if(action.equalsIgnoreCase("listSubType")){

                ResultSet rs = _reportModel.searchSubType();
                String xml = util.convertResultSetToXML(rs);
                request.setAttribute("xml", xml);
                url = "/xmlserver";

            }else if(action.equalsIgnoreCase("printSubType")){

                ResultSet rs = _reportModel.searchSubType();
                request.setAttribute("ResultSet", rs);
                String query = "List of subscriber types";
                request.setAttribute("query", query);
                url = "/pdfserver?action=printResultset";
            }
            // This actually generates a html page with table. This functionality is nolonger used
            else if(action.equalsIgnoreCase("listSubTypePrint")){

                ResultSet rs = _reportModel.searchSubType();
                request.setAttribute("ResultSet", rs);
                url = "/jsp/reports/listSubTypePrint.jsp";

            }
            /*----------------------------------------------------------------*/
            else if(action.equalsIgnoreCase("listInwards")){

                ResultSet rs = _reportModel.searchInwardsAll();
                String xml = util.convertResultSetToXML(rs);
                request.setAttribute("xml", xml);
                url = "/xmlserver";
            }else if(action.equalsIgnoreCase("printInwardsList")){

                ResultSet rs = _reportModel.searchInwardsAll();
                request.setAttribute("ResultSet", rs);
                String query = "List of inwards";
                request.setAttribute("query", query);
                url = "/pdfserver?action=printResultset";
            }
            /*----------------------------------------------------------------*/
            else if(action.equalsIgnoreCase("listAgents")){
                ResultSet rs = _reportModel.searchAgents();
                String xml = util.convertResultSetToXML(rs);
                request.setAttribute("xml", xml);
                url = "/xmlserver";
            }else if(action.equalsIgnoreCase("printAgents")){

                ResultSet rs = _reportModel.searchAgents();
                request.setAttribute("ResultSet", rs);
                String query = "List of Agents";
                request.setAttribute("query", query);
                url = "/pdfserver?action=printResultset";
            }
            // This actually generates a html page with table. This functionality is nolonger used
            else if(action.equalsIgnoreCase("listAgentPrint")){

                ResultSet rs = _reportModel.searchAgents();
                request.setAttribute("ResultSet", rs);
                url = "/jsp/reports/listAgentPrint.jsp";
            }
            /*----------------------------------------------------------------*/
            else if(action.equalsIgnoreCase("listSubscribers")){

                ResultSet rs = _reportModel.searchSubscriber();
                String xml = util.convertResultSetToXML(rs);
                request.setAttribute("xml", xml);
                url = "/xmlserver";

            }else if(action.equalsIgnoreCase("printSubscribersReport")){

                ResultSet rs = _reportModel.searchSubscriber();
                request.setAttribute("ResultSet", rs);
                String query = "List of Subscribers";
                request.setAttribute("query", query);
                url = "/pdfserver?action=printResultset";
            }
            // This actually generates a html page with table. This functionality is nolonger used
            else if(action.equalsIgnoreCase("listSubscribersPrint")){

                ResultSet rs = _reportModel.searchSubscriber();
                request.setAttribute("ResultSet", rs);
                url = "/jsp/reports/listSubscriberPrint.jsp";
            }else if(action.equalsIgnoreCase("listCirculationFigures")){

                ResultSet rs = _reportModel.searchCirculationFigures();
                String xml = util.convertResultSetToXML(rs);
                request.setAttribute("xml", xml);
                url = "/xmlserver";
            }else if(action.equalsIgnoreCase("listCirculationFiguresPrint")){

                ResultSet rs = _reportModel.searchCirculationFigures();
                request.setAttribute("ResultSet", rs);
                url = "/jsp/reports/listCirculationFiguresPrint.jsp";
            }
            /*----------------------------------------------------------------*/
            else if(action.equalsIgnoreCase("statement")){

                String xml = _reportModel.statement();
                request.setAttribute("xml", xml);
                url = "/xmlserver";

            }else if(action.equalsIgnoreCase("printStatement")){

                ResultSet rs = null;
                String xml = _reportModel.statement();
                request.setAttribute("xml", xml);
                String query = "Statement for Journal " + request.getParameter("journalName") +
                        " for year " + request.getParameter("year") +
                        " for issue no " + request.getParameter("issue");
                request.setAttribute("query", query);
                url = "/pdfserver?action=printXML";
            }
            /*----------------------------------------------------------------*/
            else if(action.equalsIgnoreCase("circulationFigures")){

                ResultSet rs = _reportModel.circulationFigures();
                String xml = util.convertResultSetToXML(rs);
                request.setAttribute("xml", xml);
                url = "/xmlserver";

            }else if(action.equalsIgnoreCase("printCirculationFigures")){

                ResultSet rs = _reportModel.circulationFigures();
                request.setAttribute("ResultSet", rs);
                String query = "Circulation Figures";
                request.setAttribute("query", query);
                url = "/pdfserver?action=printResultset";
            }
            else if(action.equalsIgnoreCase("constructTableSubcriptionFigures")){
                _reportModel.constructTableSubcriptionFigures();
                url = "/jsp/reports/subscriptionFigures.jsp";
            }
            else if(action.equalsIgnoreCase("subscriptionFigures")){

                String xml = _reportModel.subscriptionFigures();
                request.setAttribute("xml", xml);
                url = "/xmlserver";

            }else if(action.equalsIgnoreCase("printSubscriptionFigures")){

                ResultSet rs = _reportModel.circulationFigures();
                String xml = _reportModel.subscriptionFigures();
                request.setAttribute("ResultSet", rs);
                String query = "Subscription Figures";
                request.setAttribute("query", query);
                url = "/pdfserver?action=printResultset";
            }
            else if(action.equalsIgnoreCase("listMl")){

                ResultSet rs = _reportModel.listMl();
                String xml = util.convertResultSetToXML(rs);
                request.setAttribute("xml", xml);
                url = "/xmlserver";

            }else if(action.equalsIgnoreCase("printlistMl")){

                ResultSet rs = _reportModel.listMl();
                request.setAttribute("ResultSet", rs);
                String query = "Circulation Figures";
                request.setAttribute("query", query);
                url = "/pdfserver?action=printResultset";
            }
            else if(action.equalsIgnoreCase("listBil")){

                ResultSet rs = _reportModel.listBil();
                String xml = util.convertResultSetToXML(rs);
                request.setAttribute("xml", xml);
                url = "/xmlserver";

            }else if(action.equalsIgnoreCase("printlistBil")){

                ResultSet rs = _reportModel.listBil();
                request.setAttribute("ResultSet", rs);
                String query = "Circulation Figures";
                request.setAttribute("query", query);
                url = "/pdfserver?action=printResultset";
            }
    /*----------------------------------------------------------------*/
            else if(action.equalsIgnoreCase("printOrderTableDetailsList")){
       		String xml = _reportModel.printOrderTableDetailsList();
                request.setAttribute("xml", xml);
                url = "/xmlserver";
            }else if(action.equalsIgnoreCase("contructTableForPrintOrderReport")){
                _reportModel.contructTableForPrintOrderReport();
                url = "/jsp/reports/listPrintOrder.jsp";
            }else if(action.equalsIgnoreCase("printPOT")){
                String xml = _reportModel.printOrderTableDetailsList();
                request.setAttribute("xml", xml);
                String query = "Print Order Table";
                request.setAttribute("query", query);
                url = "/pdfserver?action=printXML";
            }
    /*----------------------------------------------------------------*/
        }catch (Exception e) {
            logger.error(e.getMessage(), e);
            throw new javax.servlet.ServletException(e);

        } finally {
            if(url == null){
                url = "/jsp/errors/404.jsp";
                logger.error("Redirect url was not found, forwarding to 404");
            }
            else
            {
                logger.debug("Called->" + url);
            }
            RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
            if (rd != null && url != null) {
                rd.forward(request, response);
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
