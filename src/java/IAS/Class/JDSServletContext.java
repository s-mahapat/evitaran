/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
/**
 *
 * @author Shailendra Mahapatra
 */
public class JDSServletContext implements ServletContextListener{

    @Override
    public void contextInitialized(ServletContextEvent event){

        ServletContext context = event.getServletContext();
        ServletContextInfo.setServletContext(context);
        ServletContextInfo.setContextPath(context.getContextPath());
    }

    @Override
    public void contextDestroyed(ServletContextEvent event){

    }
}
