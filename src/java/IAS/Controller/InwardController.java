package IAS.Controller;

import IAS.Class.JDSConstants;
import IAS.Class.JDSLogger;
import IAS.Class.Queries;
import IAS.Model.Inward.inwardModel;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author smahapat
 */
public class InwardController extends JDSController {

    private HttpServletRequest req;
    private HttpServletResponse resp;
    private ServletContext context;
    private String[] params;
    private static final Logger logger = JDSLogger.getJDSLogger(InwardController.class.getName());

    public InwardController(HttpServletRequest req, HttpServletResponse resp, ServletContext context,
            String[] params) {
        this.req = req;
        this.resp = resp;
        this.context = context;
        this.params = params;
    }

    public void actionConverttopayment() throws IOException, ServletException {
        try {
            inwardModel inwardmodel = new inwardModel();
            String inward_number = params[0];
            String subscriber_number = params[1];
            int rc = inwardmodel.modifyInwardPurpose(inward_number, JDSConstants.INWARD_PURPOSE_PAYMENT);
            if (rc == 1) {
                String url = "/inward?action=processinward&inwardNumber="
                        + inward_number + "&purpose="
                        + JDSConstants.INWARD_PURPOSE_PAYMENT
                        + "&subscriberNumber=" + subscriber_number;
                this.forward(req, resp, url);
            }
        } catch (SQLException ex) {
            logger.error(ex);
            throw new ServletException(ex);
        }
    }
}
