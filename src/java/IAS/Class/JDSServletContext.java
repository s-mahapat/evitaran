/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;
import javax.servlet.*;
import IAS.Model.InwardSubscriberHelper;
/**
 *
 * @author Shailendra Mahapatra
 */
public class JDSServletContext implements ServletContextListener{

    @Override
    public void contextInitialized(ServletContextEvent event){

        InwardSubscriberHelper inwardSubHelper = new InwardSubscriberHelper(event.getServletContext());

    }

    @Override
    public void contextDestroyed(ServletContextEvent event){

    }
}
