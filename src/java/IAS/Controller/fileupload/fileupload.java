package IAS.Controller.fileupload;

import IAS.Class.Ajax.AjaxResponse;
import IAS.Class.util;
import IAS.Controller.JDSController;
import IAS.Exceptions.InvalidExcelException;
import IAS.Model.FileUpload.AgentXLUploadModel;
import IAS.Model.FileUpload.URNModel;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class fileupload extends JDSController {

    private ArrayList<String> returnOutList;
    String url = null;
    static List<FileItem> heldItems;

    @Override
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String action = request.getParameter("action").toLowerCase();
        try {

            if (action.equals("urn")) {
                List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
                URNModel _urnModel = new URNModel(request);
                _urnModel.addFiles(items);
                _urnModel.processFiles();
                String xml = _urnModel.getOutputAsXML();
                request.setAttribute("xml", xml);
                url = "/xmlserver";
            }

            if (action.equals("agentxlvalidate")) { //Agent Excel Upload - Validate Excel
                Boolean uploadInd = false;
                List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
                AgentXLUploadModel _agentXLUploadModel = new AgentXLUploadModel(uploadInd, request);
                _agentXLUploadModel.addFiles(items);
                _agentXLUploadModel.validateTemplate();
                returnOutList = new ArrayList<>();
                returnOutList = _agentXLUploadModel.getOutputAsLIST();
                if (!returnOutList.isEmpty()) {
                    String xml = util.convertArrayListToXML(returnOutList, "rows");
                    request.setAttribute("xml", xml);
                    url = "/xmlserver";
                } else {
                    _agentXLUploadModel.processFiles();
                    returnOutList = new ArrayList<>();
                    returnOutList = _agentXLUploadModel.getOutputAsLIST();
                    if (!returnOutList.isEmpty()) {
                        String xml = util.convertArrayListToXML(returnOutList, "rows");
                        request.setAttribute("xml", xml);
                        url = "/xmlserver";
                    } else {
                        heldItems = items;
                    }
                }
            }

            if (action.equals("agentxlupload")) {//Agent Excel Upload - Upload Excel
                String inwardNumber;
                Boolean uploadInd = true;
                if (session.getAttribute("inwardUnderProcess") != null) {
                    AgentXLUploadModel _agentXLUploadModel = new AgentXLUploadModel(uploadInd, request);
                    _agentXLUploadModel.addFiles(heldItems);
                    _agentXLUploadModel.processFiles();
                    returnOutList = new ArrayList<>();
                    returnOutList = _agentXLUploadModel.getOutputAsLIST();
                    if (!returnOutList.isEmpty()) {
                        String xml = util.convertArrayListToXML(returnOutList, "id");
                        request.setAttribute("xml", xml);
                        url = "/xmlserver";
                    }
                } else {
                    url = "";
                    //throw error;
                }
            }
        } catch (ParserConfigurationException | SQLException |
                TransformerException | IOException | FileUploadException | InvalidExcelException e) {
            AjaxResponse ajaxResponse = new AjaxResponse();
            String xml = ajaxResponse.getSuccessXML(false, e.getMessage());
            request.setAttribute("xml", xml);
            url = "/xmlserver";

        } finally {
            RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
            if (rd != null && url != null) {
                rd.forward(request, response);
            }
        }
    }
}
