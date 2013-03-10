
/*
* To change this template, choose Tools | Templates
* and open the template in the editor.
 */
package IAS.Controller;

//~--- non-JDK imports --------------------------------------------------------

import IAS.Class.JDSLogger;
import IAS.Class.util;
import IAS.Model.Subscription.SubscriptionModel;
import com.thoughtworks.xstream.XStream;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author smahapat
 */
public class SubscriptionController extends JDSController {
    private static final Logger logger = JDSLogger.getJDSLogger(SubscriptionController.class.getName());
    private HttpServletRequest  req;
    private HttpServletResponse resp;
    private ServletContext      context;
    private String[]            params;

    public SubscriptionController(HttpServletRequest req, HttpServletResponse resp, ServletContext context,
                                  String[] params) {
        this.req     = req;
        this.resp    = resp;
        this.context = context;
        this.params  = params;
    }

    public void actionDupcheck() {
        int   subscriber_id = Integer.parseInt(params[0]);
        int[] start_years   = util.convertStringArraytoIntArray(req.getParameterValues("startYear"));

        // int[] end_years = util.convertStringArraytoIntArray(req.getParameterValues("endYear"));
        int[] start_months    = util.convertStringArraytoIntArray(req.getParameterValues("startMonth"));
        int[] journal_grp_ids = util.convertStringArraytoIntArray(req.getParameterValues("journalGroupID"));

        try {
            SubscriptionModel subscriptionModel         = new SubscriptionModel();
            List<Integer>     duplicate_journal_grp_ids = subscriptionModel.getDuplicateSubscription(subscriber_id,
                                                              journal_grp_ids, start_years, start_months);
            XStream xstream = new XStream();

            xstream.alias("row", int.class);
            xstream.alias("results", List.class);

            String xml = xstream.toXML(duplicate_journal_grp_ids);

            this.resp.getWriter().print(xml);
        } catch (SQLException | IOException ex) {
            logger.error(ex);

            try {
                this.forward(req, resp, "/errorHandler");
            } catch (IOException | ServletException e) {
                logger.error(ex);
            }
        }
    }
}


//~ Formatted by Jindent --- http://www.jindent.com
