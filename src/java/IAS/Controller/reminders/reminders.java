package IAS.Controller.reminders;

import IAS.Bean.reminder.subscriberInfo;
import IAS.Model.reminders.reminderModel;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import IAS.Class.JDSLogger;
import IAS.Controller.JDSController;
import java.util.List;
import javax.servlet.RequestDispatcher;

/**
 *
 * @author aloko
 */
public class reminders extends JDSController {
    private reminderModel _reminderModel = null;
    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Controller.masterData");

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String url = null;

        try {
            _reminderModel = new IAS.Model.reminders.reminderModel(request);

                if(action.equalsIgnoreCase("search")){

                String xml = _reminderModel.search();
                request.setAttribute("xml", xml);
                url = "/xmlserver";

            }else if(action.equalsIgnoreCase("generate")){

                String xml = _reminderModel.generate();
                request.setAttribute("xml", xml);
                url = "/xmlserver";

            }else if(action.equalsIgnoreCase("send")){

                String medium = request.getParameter("medium");

                // E = Email Only
                if (medium.equals("E")) {
                    String xml = _reminderModel.sendEmail(medium, "send");
                    request.setAttribute("xml", xml);
                    url = "/xmlserver";
                }
                // P = print only
                else if (medium.equals("P")){
                    //String xml = _reminderModel.printOnly(medium, "send");
                    List<subscriberInfo> sinfo = _reminderModel.printOnly(medium, "send");
                    request.setAttribute("subscriberInfo", sinfo);
                    //request.setAttribute("xml", xml);
                    url = "/pdfserver?action=printRemindersPrintOnly";
                }
                // A = print all
                else if(medium.equals("A")) {
                    //String xml = _reminderModel.printAll(medium, "send");
                    List<subscriberInfo> sinfo = _reminderModel.printAll(medium, "send");
                    request.setAttribute("subscriberInfo", sinfo);
                    //request.setAttribute("xml", xml);
                    url = "/pdfserver?action=printRemindersPrintAll";
                }
            }else if(action.equalsIgnoreCase("resend")){

                String medium = request.getParameter("medium");

                // E = Email Only
                if (medium.equals("E")) {
                    String xml = _reminderModel.sendEmail(medium, "resend");
                    request.setAttribute("xml", xml);
                    url = "/xmlserver";
                }
                // P = print only
                else if (medium.equals("P")){
                    //String xml = _reminderModel.printOnly(medium, "resend");
                    List<subscriberInfo> sinfo = _reminderModel.printOnly(medium, "resend");
                    request.setAttribute("subscriberInfo", sinfo);
                    //request.setAttribute("xml", xml);
                    url = "/pdfserver?action=printRemindersPrintOnly";
                }
                // A = print all
                else if(medium.equals("A")) {
                    //String xml = _reminderModel.printAll(medium, "resend");
                    List<subscriberInfo> sinfo = _reminderModel.printAll(medium, "resend");
                    request.setAttribute("subscriberInfo", sinfo);
                    //request.setAttribute("xml", xml);
                    url = "/pdfserver?action=printRemindersPrintAll";
                }
            }
        } catch (Exception e) {
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
