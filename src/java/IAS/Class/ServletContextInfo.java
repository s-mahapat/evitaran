/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import javax.servlet.ServletContext;


/**
 *
 * @author Shailendra Mahapatra
 */
public class ServletContextInfo {

    private static String contextPath;
    private static ServletContext servletContext;

    public static String getContextPath(){
        return contextPath;
    }
    
    public static String getContextRealPath(){
        return servletContext.getRealPath("");
    }

    public static void setContextPath(String _contextpath){
        contextPath = _contextpath;
    }

    public static ServletContext getServletContext(){
        return servletContext;
    }

    public static void setServletContext(ServletContext _servletContext){
        servletContext = _servletContext;
    }
}
