package IAS.Controller.Inward;

import IAS.Bean.Invoice.InvoiceFormBean;
import IAS.Bean.Inward.inwardFormBean;
import IAS.Bean.Subscriber.subscriberFormBean;
import IAS.Bean.missingissue.missingissueFormBean;
import IAS.Class.JDSConstants;
import IAS.Class.JDSLogger;
import IAS.Controller.JDSController;
import IAS.Model.Inward.inwardModel;
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
import org.apache.log4j.Logger;
import org.xml.sax.SAXException;

public class inward extends JDSController {

    private inwardModel _inwardModel = null;
    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Controller.inward");

    @Override
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String url = "/jsp/errors/404.jsp";

        try {

            _inwardModel = new IAS.Model.Inward.inwardModel(request);
            inwardFormBean _inwardFormBean = new IAS.Bean.Inward.inwardFormBean();

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

                _inwardFormBean = _inwardModel.editInward();
                if (_inwardFormBean != null) {
                    request.setAttribute("inwardFormBean", _inwardFormBean);
                    url = "/jsp/inward/editinward.jsp";
                }

            } /*
             * If the action is to view the inward
             */ else if (action.equalsIgnoreCase("view")) {

                _inwardFormBean = _inwardModel.viewInward();
                if (_inwardFormBean != null) {
                    request.setAttribute("inwardFormBean", _inwardFormBean);
                    url = "/jsp/inward/viewinward.jsp";
                }

            } else if (action.equalsIgnoreCase("sendAck")) {

                _inwardFormBean = _inwardModel.viewInward();
                if (_inwardFormBean != null) {
                    request.setAttribute("inwardFormBean", _inwardFormBean);
                    url = "/jsp/inward/ackinward.jsp";
                }


            } else if (action.equalsIgnoreCase("sendReturn")) {
                _inwardFormBean = _inwardModel.viewInward();
                if (_inwardFormBean != null) {
                    request.setAttribute("inwardFormBean", _inwardFormBean);
                    url = "/jsp/inward/returninward.jsp";
                }

            } else if (action.equalsIgnoreCase("search")) {

                // searchInward gets all the inwards based on the search criteria entered on screen by the user.
                String xml = _inwardModel.searchInward();
                request.setAttribute("xml", xml);
                url = "/xmlserver";

            } else if (action.equalsIgnoreCase("subscriberInward")) {

                // searchInward gets all the inwards based on the search criteria entered on screen by the user.
                String xml = _inwardModel.subscriberInward();
                request.setAttribute("xml", xml);
                url = "/xmlserver";

            } else if (action.equalsIgnoreCase("pendinginwards")) {
                // searchInward gets all the inwards based on the search criteria entered on screen by the user.
                String xml = _inwardModel.getPendngInwards();
                request.setAttribute("xml", xml);
                url = "/xmlserver";

            } else if (action.equalsIgnoreCase("processinward")) {

                //String inwardNumber = request.getParameter("inwardNumber");
                String subscriberNumber = request.getParameter("subscriberNumber");
                HttpSession session = request.getSession(false);
                _inwardFormBean = _inwardModel.GetInward();
                session.setAttribute("inwardUnderProcess", _inwardFormBean);
                String agentName = _inwardFormBean.getagentName(); // agent changes PINKI
                // we should use the purpose id rather than the purpose name, it can change in the database
                // but id should not change
                int purposeID = Integer.parseInt(request.getParameter("purpose"));

                // check if the flow is from add free subscriber/summer fellow.
                int isFreeSubscriber = Integer.parseInt(request.getParameter("afs"));
                int isSummerFellow = Integer.parseInt(request.getParameter("asf"));


                // Get into this if block for only new subscription and request for invoice
                // if its add free subscribers or add summer fellows move on
                if (isFreeSubscriber == 0
                        && isSummerFellow == 0
                        && (purposeID == JDSConstants.INWARD_PURPOSE_NEW_SUBSCRIPTION
                        || purposeID == JDSConstants.INWARD_PURPOSE_REQUEST_FOR_INVOICE)) {

                    if (subscriberNumber != null
                            && !subscriberNumber.equalsIgnoreCase("null")
                            && !subscriberNumber.isEmpty()
                            && agentName == null) {
                        url = "/subscriber?action=add";
                    } else if (agentName != null && !agentName.isEmpty()) {
                        url = "/jsp/inward/agentexcelupload.jsp";
                    } //agent changes - PINKI
                    else {

                        //IAS.Model.Subscriber.subscriberModel _subscriberModel = new IAS.Model.Subscriber.subscriberModel(request);
                        // create a subscriber form bean and fill the values from the selected inward
                        subscriberFormBean _subscriberFormBean = new IAS.Bean.Subscriber.subscriberFormBean();
                        _subscriberFormBean.setSubscriberName(_inwardFormBean.getFrom());
                        _subscriberFormBean.setCity(_inwardFormBean.getCity());
                        _subscriberFormBean.setDistrict(_inwardFormBean.getDistrict());
                        _subscriberFormBean.setState(_inwardFormBean.getState());
                        _subscriberFormBean.setCountry(_inwardFormBean.getCountry());
                        _subscriberFormBean.setPincode(_inwardFormBean.getPincode());
                        _subscriberFormBean.setEmail(_inwardFormBean.getEmail());
                        _subscriberFormBean.setDepartment(_inwardFormBean.getDepartment());
                        _subscriberFormBean.setInstitution(_inwardFormBean.getInstitution());
                        request.setAttribute("subscriberFormBean", _subscriberFormBean);
                        url = "/subscriber?action=createsubscriber";
                    }
                } else if (purposeID == JDSConstants.INWARD_PURPOSE_RENEW_SUBSCRIPTION) {
                    // Renew subscription
                    //IAS.Model.subscriberModel _subscriberModel = new IAS.Model.subscriberModel(request);
                    url = "/subscriber?action=add";
                } else if (purposeID == JDSConstants.INWARD_PURPOSE_ADDRESS_CHANGE) {
                    //Address change
                    url = "/subscriber?action=edit";

                } else if (purposeID == 1 && isFreeSubscriber == 1) {
                    // Add Free Subscriber
                    subscriberFormBean _subscriberFormBean = new IAS.Bean.Subscriber.subscriberFormBean();
                    _subscriberFormBean.setSubscriberName(_inwardFormBean.getFrom());
                    _subscriberFormBean.setCity(_inwardFormBean.getCity());
                    _subscriberFormBean.setDistrict(_inwardFormBean.getDistrict());
                    _subscriberFormBean.setState(_inwardFormBean.getState());
                    _subscriberFormBean.setCountry(_inwardFormBean.getCountry());
                    _subscriberFormBean.setPincode(_inwardFormBean.getPincode());
                    _subscriberFormBean.setEmail(_inwardFormBean.getEmail());
                    _subscriberFormBean.setDepartment(_inwardFormBean.getDepartment());
                    _subscriberFormBean.setInstitution(_inwardFormBean.getInstitution());
                    request.setAttribute("subscriberFormBean", _subscriberFormBean);
                    url = "/jsp/subscriber/afs.jsp";
                } else if (purposeID == 1 && isSummerFellow == 1) {
                    // Add Summer Fellows
                    subscriberFormBean _subscriberFormBean = new IAS.Bean.Subscriber.subscriberFormBean();
                    _subscriberFormBean.setSubscriberName(_inwardFormBean.getFrom());
                    _subscriberFormBean.setCity(_inwardFormBean.getCity());
                    _subscriberFormBean.setDistrict(_inwardFormBean.getDistrict());
                    _subscriberFormBean.setState(_inwardFormBean.getState());
                    _subscriberFormBean.setCountry(_inwardFormBean.getCountry());
                    _subscriberFormBean.setPincode(_inwardFormBean.getPincode());
                    _subscriberFormBean.setEmail(_inwardFormBean.getEmail());
                    _subscriberFormBean.setDepartment(_inwardFormBean.getDepartment());
                    _subscriberFormBean.setInstitution(_inwardFormBean.getInstitution());
                    request.setAttribute("subscriberFormBean", _subscriberFormBean);
                    url = "/jsp/subscriber/asf.jsp";
                } else if (purposeID == JDSConstants.INWARD_PURPOSE_MISSING_ISSUE) {
                    missingissueFormBean _missingissueFormBean = new IAS.Bean.missingissue.missingissueFormBean();
                    _missingissueFormBean.setSubscriberNumber(subscriberNumber);
                    _missingissueFormBean.setInwardNumber(_inwardFormBean.getInwardNumber());
                    _missingissueFormBean.setSubscriberName(_inwardFormBean.getFrom());
                    request.setAttribute("missingissueFormBean", _missingissueFormBean);
                    url = "/missingissue?action=addInfo";

                }

            } else if (action.equalsIgnoreCase("saveReturn")) {
                // save the return
                if (_inwardModel.updateChequeReturn() != null) {
                    url = "/jsp/inward/returninward.jsp";
                }

            } else if (action.equalsIgnoreCase("followOnProcess")) {

                int inwardPurposeID = Integer.parseInt(request.getParameter("purpose"));
                _inwardFormBean = _inwardModel.viewInward();
                float amount = _inwardFormBean.getAmount();

                /*if ( amount > 0 && 
                 (inwardPurposeID == JDSConstants.INWARD_PURPOSE_NEW_SUBSCRIPTION || 
                 inwardPurposeID == JDSConstants.INWARD_PURPOSE_RENEW_SUBSCRIPTION)
                 ) {

                 if (_inwardFormBean != null) {
                 request.setAttribute("inwardFormBean", _inwardFormBean);
                 url = "/jsp/inward/ackinward.jsp";
                 }
                 }*/
                // for acknowledgement amount > 0
                if ((inwardPurposeID == JDSConstants.INWARD_PURPOSE_NEW_SUBSCRIPTION
                        || inwardPurposeID == JDSConstants.INWARD_PURPOSE_RENEW_SUBSCRIPTION)) {
                    url = "/jsp/inward/pendinginwards.jsp";

                } else if (inwardPurposeID == JDSConstants.INWARD_PURPOSE_REQUEST_FOR_INVOICE) {
                    InvoiceFormBean _invoiceFormBean = _inwardModel.getInvoiceDetail(); //new IAS.Bean.Invoice.InvoiceFormBean();
                    request.setAttribute("invoiceFormBean", _invoiceFormBean);
                    url = "/jsp/invoice/proforma.jsp";
                } else {
                    url = "/home";
                }


            }
        } catch (SQLException | IOException | ParseException | InvocationTargetException | IllegalAccessException | ClassNotFoundException | ParserConfigurationException | TransformerException | SAXException | NumberFormatException e) {
            logger.error(e.getMessage(), e);
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
    }// </editor-fold>
}
