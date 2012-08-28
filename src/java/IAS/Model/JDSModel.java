/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model;

import IAS.Class.Database;
import IAS.Class.JDSLogger;
import IAS.Class.Queries;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.HashMap;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.log4j.Logger;

/**
 *
 * @author Shailendra Mahapatra
 */
public class JDSModel extends HttpServlet {

    protected HttpServletRequest request = null;
    protected Database db = null;
    protected HttpSession session = null;
    protected Connection conn = null;
    private static final Logger logger = JDSLogger.getJDSLogger(JDSModel.class.getName());

    public JDSModel() throws SQLException {
        this.conn = Database.getConnection();
        this.db = new Database();

    }

    public JDSModel(HttpServletRequest request) throws SQLException {
        this.conn = Database.getConnection();
        this.db = new Database();
        this.request = request;
        this.session = request.getSession(false);
    }

    public void FillBean(HttpServletRequest request, Object _bean) throws IllegalAccessException, java.lang.reflect.InvocationTargetException {
        HashMap paramMap = new HashMap();
        Enumeration names = request.getParameterNames();
        while (names.hasMoreElements()) {
            String name = (String) names.nextElement();
            paramMap.put(name, request.getParameterValues(name));
        }
        BeanUtils.populate(_bean, paramMap);
    }

    public int CompleteInward(int inwardID) throws SQLException {
        //Update inward with completed flag once the transaction is completed
        int rc = 0;
        String sql = Queries.getQuery("update_inward_complete_flag");
        PreparedStatement st = conn.prepareStatement(sql);
        st.setInt(1, inwardID);
        if (db.executeUpdatePreparedStatement(st) == 1) {
            session.setAttribute("inwardUnderProcess", null);
            rc = 1;
        }
        st.close();        
        return (rc);
    }

    public String getMonthToCharacterMap(int _month) {
        char[] alphabet = "abcdefghijkl".toCharArray();
        // the calendar objects month starts from 0
        String monthChar = Character.toString(alphabet[_month]);
        return monthChar.toUpperCase();
    }

    @Override
    public void destroy() {
        try {
            this.conn.close();
        } catch (SQLException e) {
            logger.error("Failed to close Database connection");
        }

    }
}
