/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Controller.agentProc;

import IAS.Class.JDSLogger;
import IAS.Controller.JDSController;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

public class agentProc extends JDSController {

    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Controller.agent");

    @Override
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String url = "/jsp/errors/404.jsp";

        try {
            String isAgentXLUpload;
            isAgentXLUpload = request.getParameter("agentXLUpload");
            if ("true".equals(isAgentXLUpload)) {
                url = "/jsp/inward/agentexcelupload.jsp";
            }

            RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
            if (rd != null && url != null) {
                rd.forward(request, response);
            }
        } catch (IOException e) {
            logger.error(e.getMessage(), e);
            throw new javax.servlet.ServletException(e);
        }
    }
}
