package IAS.Controller.fileupload;

import IAS.Class.util;
import IAS.Controller.JDSController;
import IAS.Model.FileUpload.fileUploadModel;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;

public class fileupload extends JDSController {

    private fileUploadModel _fileUploadModel = null;
    private ArrayList<String> errors;
    String url = null;

    @Override
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            _fileUploadModel = new IAS.Model.FileUpload.fileUploadModel(request);
            errors = new ArrayList<>();
            errors = _fileUploadModel.uploadDataInDB();
            if (!errors.isEmpty()) {
                String xml = util.convertArrayListToXML(errors, "errors");
                request.setAttribute("xml", xml);
                url = "/xmlserver";
            }
        } catch (SQLException | ParserConfigurationException |
                TransformerException | IOException e) {
        } finally {
            RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
            if (rd != null && url != null) {
                rd.forward(request, response);
            }
        }

    }
}
