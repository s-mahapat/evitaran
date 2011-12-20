/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model;
import javax.servlet.http.HttpServletRequest;
import java.util.*;
import org.apache.commons.beanutils.*;
/**
 *
 * @author Shailendra Mahapatra
 */
public class JDSModel {

    public void FillBean(HttpServletRequest request, Object _bean) throws IllegalAccessException, java.lang.reflect.InvocationTargetException{
         HashMap paramMap = new HashMap();
        Enumeration names = request.getParameterNames();
        while (names.hasMoreElements()) {
            String name = (String) names.nextElement();
            paramMap.put(name, request.getParameterValues(name));
        }
        BeanUtils.populate(_bean, paramMap);
    }
}
