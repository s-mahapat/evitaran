package IAS.Controller.fileupload;

import IAS.Class.util;
import IAS.Controller.JDSController;
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
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class fileupload extends JDSController {

    private ArrayList<String> errors;
    String url = null;

    @Override
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action").toLowerCase();
        try {
            List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
            if (action.equals("urn")) {
                URNModel _urnModel = new URNModel();
                _urnModel.addFiles(items);
                _urnModel.processFiles();
            }

            if (action.equals("agentxlupload")) { //Agent Excel Upload - PINKI
                AgentXLUploadModel _agentXLUploadModel = new AgentXLUploadModel();
                _agentXLUploadModel.addFiles(items);
                _agentXLUploadModel.processFiles();
                errors = new ArrayList<>();
                errors = _agentXLUploadModel.getOutputAsLIST();
                if (!errors.isEmpty()) {
                    String xml = util.convertArrayListToXML(errors, "errors");
                    request.setAttribute("xml", xml);
                    url = "/xmlserver";
                }
            }
        } catch (ParserConfigurationException | SQLException |
                TransformerException | IOException | FileUploadException e) {
        } finally {
            RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
            if (rd != null && url != null) {
                rd.forward(request, response);
            }
        }

    }
}
