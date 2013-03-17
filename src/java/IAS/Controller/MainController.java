
/*
* To change this template, choose Tools | Templates
* and open the template in the editor.
 */
package IAS.Controller;

//~--- non-JDK imports --------------------------------------------------------

import IAS.Class.JDSLogger;
import java.io.IOException;
import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author smahapat
 */
public class MainController extends JDSController {
    private static final Logger logger = JDSLogger.getJDSLogger(MainController.class.getName());

    public void RESTProcess(HttpServletRequest req, HttpServletResponse resp, ServletContext context, String vars)
            throws IOException, ServletException {
        String[] url;
        int      nvars;
        String   controller;
        String   action = null;
        String[] params = null;
        int      i;
        int      n;
        String   controllerName;
        String   actionName;

        if ((vars == null) || "".equals(vars.trim())) {
            this.redirect(resp, "/home");
        } else {
            url   = vars.split("/");
            nvars = url.length;

            if (nvars > 0) {
                controller = url[0].trim();                                // users

                if (nvars > 1) {
                    action = url[1].trim();                                // edit

                    if (nvars > 2) {
                        n      = 0;
                        params = new String[nvars - 2];                    // array[0] = 5 (iduser)

                        for (i = 2; i < nvars; i++) {
                            params[n] = url[i];
                            n++;
                        }
                    }
                }

                controllerName = this.getFirstUpper(controller) + "Controller";    // HomeController, UserController pattern

                if (!controllerName.equals("Controller")) {
                    actionName = "action" + this.getFirstUpper(action);    // actionIndex, actionEdit pattern

                    if (!action.equals("action")) {
                        try {
                            Class classe = Class.forName("IAS.Controller." + controllerName);

                            try {
                                Constructor c = classe.getConstructor(HttpServletRequest.class,
                                                    HttpServletResponse.class, ServletContext.class, String[].class);

                                try {
                                    Object obj = c.newInstance(req, resp, context, params);
                                    Method m   = obj.getClass().getMethod(actionName);

                                    m.invoke(obj);
                                } catch (InstantiationException | IllegalAccessException | IllegalArgumentException
                                         | InvocationTargetException | NoSuchMethodException | SecurityException e) {
                                    logger.error(e.getCause());
                                    this.forward(req, resp, "/errorHandler");
                                }
                            } catch (NoSuchMethodException | SecurityException e) {
                                logger.error(e);
                                this.forward(req, resp, "/errorHandler");
                            }
                        } catch (ClassNotFoundException | IOException | ServletException e) {
                            logger.error(e);
                            this.forward(req, resp, "/errorHandler");
                        }
                    }
                }
            } else {
                this.redirect(resp, "/home");
            }
        }
    }

    public String getFirstUpper(String str) {
        Integer x = str.length();

        str = str.substring(0, 1).toUpperCase().concat(str.substring(1, x));

        return str;
    }
}


//~ Formatted by Jindent --- http://www.jindent.com
