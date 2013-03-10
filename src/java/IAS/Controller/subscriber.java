
/*
* To change this template, choose Tools | Templates
* and open the template in the editor.
 */
package IAS.Controller;

//~--- non-JDK imports --------------------------------------------------------

import IAS.Bean.Invoice.InvoiceFormBean;
import IAS.Bean.Inward.inwardFormBean;

import IAS.Class.JDSConstants;
import IAS.Class.JDSLogger;
import IAS.Class.util;

import IAS.Model.Subscriber.subscriberModel;

import org.apache.log4j.Logger;

import org.xml.sax.SAXException;

//~--- JDK imports ------------------------------------------------------------

import java.io.IOException;

import java.lang.reflect.InvocationTargetException;

import java.sql.SQLException;

import java.text.ParseException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;

public class subscriber extends JDSController {
    private static final Logger logger           = JDSLogger.getJDSLogger("IAS.Controller.subscriber");
    private subscriberModel     _subscriberModel = null;
    private inwardFormBean      _inwardFormBean;

    @Override
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String      action = request.getParameter("action");
        String      url    = null;
        int         inwardPurposeID;
        HttpSession session = request.getSession(false);

        try {
            _subscriberModel = new IAS.Model.Subscriber.subscriberModel(request);

            if (action.equalsIgnoreCase("createsubscriber")) {
                url = "/jsp/subscriber/createsubscriber.jsp";
            } else if (action.equalsIgnoreCase("save")) {
                url = "/jsp/subscriber/viewdetailsubscriber.jsp";

                // if the record count saved is 1, it indicates that the record was saved else fail.
                if (_subscriberModel.Save() > 0) {
                    if (session.getAttribute("inwardUnderProcess") != null) {
                        this._inwardFormBean = (inwardFormBean) session.getAttribute("inwardUnderProcess");
                        inwardPurposeID      = _inwardFormBean.getInwardPurposeID();

                        // if the inward purpose is new subscription then redirect the user to add subscription after
                        // saving subscriber info, else redirect to view subscriber
                        if ((inwardPurposeID == JDSConstants.INWARD_PURPOSE_NEW_SUBSCRIPTION)
                                || (inwardPurposeID == JDSConstants.INWARD_PURPOSE_REQUEST_FOR_INVOICE)) {
                            url = "/jsp/subscription/addnewsubscription.jsp?purpose=" + inwardPurposeID;
                        }
                    }
                }
            } else if (action.equalsIgnoreCase("edit")) {
                if (_subscriberModel.editSubscriber() != null) {
                    url = "/jsp/subscriber/editsubscriber.jsp";
                }
            } else if (action.equalsIgnoreCase("display")) {
                if (_subscriberModel.viewSubscriber() != null) {
                    url = "/jsp/subscriber/viewdetailsubscriber.jsp";
                }
            } else if (action.equalsIgnoreCase("search")) {
                String xml = _subscriberModel.searchSubscriber();

                request.setAttribute("xml", xml);
                url = "/xmlserver";
            } else if (action.equalsIgnoreCase("subscriberNames")) {
                String searchTerm = request.getParameter("term");
                String xml        = _subscriberModel.getDistinctSubscriberNames(searchTerm);

                request.setAttribute("xml", xml);
                url = "/xmlserver";
            } else if (action.equalsIgnoreCase("depts")) {
                String searchTerm = request.getParameter("term");
                String xml        = _subscriberModel.getDepartmentNames(searchTerm);

                request.setAttribute("xml", xml);
                url = "/xmlserver";
            } else if (action.equalsIgnoreCase("inst")) {
                String searchTerm = request.getParameter("term");
                String xml        = _subscriberModel.getInstitutionNames(searchTerm);

                request.setAttribute("xml", xml);
                url = "/xmlserver";
            } else if (action.equalsIgnoreCase("viewsubscription")) {

                // fill in the subscriber bean
                if (_subscriberModel.GetSubscriber() != null) {
                    url = "/jsp/subscription/viewsubscription.jsp";
                }
            } else if (action.equalsIgnoreCase("editsubscription")) {

                // fill in the subscriber bean
                if (_subscriberModel.GetSubscriber() != null) {
                    url = "/jsp/subscription/viewsubscription.jsp";
                }
            } else if (action.equalsIgnoreCase("add")) {

                // fill in the subscriber bean
                if (_subscriberModel.GetSubscriber() != null) {
                    url = "/jsp/subscription/addnewsubscription.jsp";
                }
            } else if (action.equalsIgnoreCase("subscriberInvoice")) {

                // searchInvoice gets all the invoices based on the search criteria entered on screen by the user.
                String xml = _subscriberModel.subscriberInvoices();

                request.setAttribute("xml", xml);
                url = "/xmlserver";
            } else if (action.equalsIgnoreCase("printInvoice")) {

                // InvoiceFormBean _invoiceFormBean = new IAS.Bean.Invoice.InvoiceFormBean();
                InvoiceFormBean _invoiceFormBean = _subscriberModel.getInvoiceDetail();

                if (_invoiceFormBean.getInvoiceTypeID() == JDSConstants.INVOICE_OUTSTANDING_PAYMENT_INVOICE) {
                    url = "/jsp/subscription/pendingamount.jsp";
                } else {
                    url = "/jsp/invoice/proforma.jsp";
                }

                request.setAttribute("InvoiceFormBean", _invoiceFormBean);
            } else if (action.equalsIgnoreCase("mil")) {
                url = "/jsp/missingissue/missingissuelist.jsp";
            } else if (action.equalsIgnoreCase("getSubscriberType")) {
                int    subType = _subscriberModel.getSubscriberType(request.getParameter("subscriberNumber"));
                String xml     = util.convertStringToXML(String.valueOf(subType), "subtype");

                request.setAttribute("xml", xml);
                url = "/xmlserver";
            } else if (action.equalsIgnoreCase("reminders")) {
                String subscriberNumber = request.getParameter("subscriberNumber");
                String xml              = _subscriberModel.getReminders(subscriberNumber);

                request.setAttribute("xml", xml);
                url = "/xmlserver";
            } else if (action.equalsIgnoreCase("mi")) {
                int    subscriberID = Integer.parseInt(request.getParameter("sid"));
                String xml          = _subscriberModel.getMissingIssues(subscriberID);

                request.setAttribute("xml", xml);
                url = "/xmlserver";
            } else if (action.equalsIgnoreCase("nextsubscriber")) {
                int subscriberID = Integer.parseInt(request.getParameter("sid"));

                if (_subscriberModel.getNextSubscriber(subscriberID) != null) {
                    url = "/jsp/subscriber/viewdetailsubscriber.jsp";
                }
            } else if (action.equalsIgnoreCase("chqreturn")) {
                String _subscriberNumber = request.getParameter("subscriberNumber");
                String xml               = _subscriberModel.getChequeReturn(_subscriberNumber);

                if (xml != null) {
                    request.setAttribute("xml", xml);
                    url = "/xmlserver";
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                                       "Failed to cheque return details for subscriber");
                }
            }

            RequestDispatcher rd = getServletContext().getRequestDispatcher(url);

            if ((rd != null) && (url != null)) {
                rd.forward(request, response);
            }
        } catch (SQLException | ParseException | InvocationTargetException | IllegalAccessException
                 | ClassNotFoundException | ParserConfigurationException | TransformerException | SAXException
                 | IOException e) {
            logger.error(e.getMessage(), e);

            throw new javax.servlet.ServletException(e);
        }
    }

//  <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP
     * <code>GET</code> method.
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
     * Handles the HTTP
     * <code>POST</code> method.
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
    }    // </editor-fold>
}


//~ Formatted by Jindent --- http://www.jindent.com
