package IAS.Model.AgentProc;

import IAS.Class.JDSLogger;
import IAS.Bean.Invoice.InvoiceFormBean;
import IAS.Bean.Inward.inwardFormBean;
import IAS.Class.Queries;
import IAS.Class.SubscriberInfo;
import IAS.Class.SubscriptionInfo;
import IAS.Class.util;
import IAS.Model.Inward.inwardModel;
import IAS.Model.JDSModel;
import com.mysql.jdbc.Statement;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import org.apache.log4j.Logger;
import java.util.Calendar;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.dbutils.BeanProcessor;

public class agentProcModel extends JDSModel {

    private static Logger logger = JDSLogger.getJDSLogger(agentProcModel.class.getName());

    public agentProcModel() throws SQLException {
    }

    public agentProcModel(HttpServletRequest request) throws SQLException, IOException {
        //call the base class constructor
        super(request);
        this.request = request;
    }

    public ArrayList getSubscriptionInfo(String inwardNumber) throws SQLException {
        String sql = Queries.getQuery("result_process_agent_inward");
        ArrayList<SubscriptionInfo> listSubsriptionInfo = new ArrayList<>();
        try (Connection conn = this.getConnection(); PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setString(1, inwardNumber);
            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    SubscriberInfo oSubscriberInfo = new SubscriberInfo();
                    SubscriptionInfo oSubscriptionInfo = new SubscriptionInfo();
                    oSubscriberInfo.setSubscriberNumber(rs.getString("subscriberNumber"));
                    oSubscriptionInfo.setSubscriberInfo(oSubscriberInfo);
                    oSubscriptionInfo.setSubscriptionNumber(rs.getInt("subscriptionNumber"));
                    listSubsriptionInfo.add(oSubscriptionInfo);
                }
            }
        }

        return listSubsriptionInfo;
    }

    /*
     * Gets the discount for an agent
     */
    public float getDiscount(int agent_id) throws SQLException {
        float discount = 0;
        String sql = Queries.getQuery("get_agent_discount");

        try (Connection conn = this.getConnection(); PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, agent_id);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.first()) {
                    discount = rs.getFloat("discount");
                }
            }
        } catch (SQLException ex) {
            logger.error(ex);
        } finally {
            return discount;
        }

    }

    public List searchAgent(String agent_name) throws SQLException {

        ArrayList<String> agents = new ArrayList<>();
        String sql = Queries.getQuery("search_agent");
        try (Connection conn = this.getConnection(); PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setString(1, agent_name + "%");
            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    agents.add(rs.getString("agentName"));
                }
            }
        } catch (SQLException ex) {
            logger.error(ex);
        } finally {
            return agents;
        }

    }

    public InvoiceFormBean followOnProcessForAgentInward(String inward_number, HttpServletRequest request) throws SQLException, ParseException,
            InvocationTargetException, IllegalAccessException, ClassNotFoundException, IOException {

        String sql;
        inwardModel _inwardModel = new inwardModel(request);
        inwardFormBean _inwardFormBean = _inwardModel.GetInward(inward_number);
        InvoiceFormBean invoiceFormBean = new IAS.Bean.Invoice.InvoiceFormBean();
        sql = Queries.getQuery("get_agent_invoice_dtls");
        try (Connection _conn = this.getConnection();
                PreparedStatement st = _conn.prepareStatement(sql)) {
            st.setString(1, inward_number);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    BeanProcessor bProc = new BeanProcessor();
                    invoiceFormBean = bProc.toBean(rs, IAS.Bean.Invoice.InvoiceFormBean.class);
                }
            }
        }
        invoiceFormBean.setInwardNumber(inward_number);
        invoiceFormBean.setInwardID(_inwardFormBean.getInwardID());
        request.setAttribute("invoiceFormBean", invoiceFormBean);
        request.setAttribute("inwardFormBean", _inwardFormBean);
        this.updateAgentInvoice(invoiceFormBean, request);
        return invoiceFormBean;
    }

    private synchronized String getNextAgentInvoiceNumber() throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException {

        String nextAgentInvoice = null;
        // Invoice Type to be tagged in the invoice number similar to subscriber and inward
        String agentinvoiceType = "AI";
        //get the last invoice number from invoice table
        String lastAgentInvoiceSql = Queries.getQuery("get_last_agent_invoice");
        String lastAgentInvoice;

        // get connection from pool
        try (Connection _conn = this.getConnection();
                PreparedStatement pst = _conn.prepareStatement(lastAgentInvoiceSql);) {
            try (ResultSet rs = pst.executeQuery()) {
                Calendar calendar = Calendar.getInstance();
                //if true there exists a previous invoice for the year, so just increment the invoice number.
                if (rs.first()) {
                    lastAgentInvoice = rs.getString(1);
                    // if this condition succeeds then it menas we found an invoice with the new naming pattern
                    if (lastAgentInvoice.length() == 12 && lastAgentInvoice.contains("-")) {
                        // get the last invoice number after the split
                        int agentinvoice = Integer.parseInt(lastAgentInvoice.substring(7));
                        //increment
                        ++agentinvoice;
                        //apend the year, month character and new invoice number.
                        nextAgentInvoice = lastAgentInvoice.substring(0, 2) + getMonthToCharacterMap(calendar.get(Calendar.MONTH)) + "-" + agentinvoiceType + "-" + String.format("%05d", agentinvoice);
                        return nextAgentInvoice;
                    }

                }
                // there is no previous record for the year, so start the numbering afresh
                String year = String.valueOf(calendar.get(Calendar.YEAR)).substring(2);
                nextAgentInvoice = year + getMonthToCharacterMap(calendar.get(Calendar.MONTH)) + "-" + agentinvoiceType + "-" + String.format("%05d", 1);

            }
        } finally {
            //_conn.close();
        }
        return nextAgentInvoice;
    }

    private int updateAgentInvoice(InvoiceFormBean invoiceFormBean, HttpServletRequest request) throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException {

        String sql;
        int paramIndex = 0;
        int invoiceID = 0;
        int invoice_type_id = 2;
        //get the next invoice number and fill the bean
        String invoiceNumber = getNextAgentInvoiceNumber();
        invoiceFormBean.setInvoiceNumber(invoiceNumber);
        invoiceFormBean.setInvoiceTypeID(invoice_type_id);

        //subscription ID
        int inwardID = invoiceFormBean.getInwardID();
        float amount = invoiceFormBean.getBalance();
        invoiceFormBean.setAmount(amount);
        // the query name from the jds_sql properties files in WEB-INF/properties folder
        sql = Queries.getQuery("agent_invoice_insert");
        try (Connection _conn = this.getConnection();
                PreparedStatement st = _conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            st.setString(++paramIndex, invoiceNumber);
            st.setInt(++paramIndex, inwardID);
            st.setDate(++paramIndex, util.dateStringToSqlDate(util.getDateString()));
            st.setInt(++paramIndex, invoice_type_id);
            st.setFloat(++paramIndex, amount);
            if (st.executeUpdate() == 1) {
                try (ResultSet rs = st.getGeneratedKeys()) {
                    rs.first();
                    invoiceID = rs.getInt(1);
                }
            }
        } finally {
            //_conn.close();
        }
        return invoiceID;
    }

    public InvoiceFormBean getAgentInvoiceDetail(String inwardNumber, HttpServletRequest request) throws SQLException, ParseException,
            InvocationTargetException, IllegalAccessException, ClassNotFoundException, IOException {
        // get the connection from connection pool

        String invoiceNumber;
        inwardModel _inwardModel = new inwardModel(request);
        inwardFormBean _inwardFormBean = _inwardModel.GetInward(inwardNumber);
        InvoiceFormBean invoiceFormBean = new IAS.Bean.Invoice.InvoiceFormBean();
        String sql = Queries.getQuery("get_agent_invoice_dtls");
        String sql1 = Queries.getQuery("get_agent_invoice_number");
        try (Connection _conn = this.getConnection();
                PreparedStatement st = _conn.prepareStatement(sql);
                PreparedStatement st1 = _conn.prepareStatement(sql1)) {
            st.setString(1, inwardNumber);
            st1.setString(1, inwardNumber);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    BeanProcessor bProc = new BeanProcessor();
                    invoiceFormBean = bProc.toBean(rs, IAS.Bean.Invoice.InvoiceFormBean.class);
                }
            }
            try (ResultSet rs1 = st1.executeQuery();) {
                rs1.first();
                invoiceNumber = rs1.getString("invoiceNumber");
            }
            invoiceFormBean.setInwardNumber(inwardNumber);
            invoiceFormBean.setInwardID(_inwardFormBean.getInwardID());
            invoiceFormBean.setInvoiceNumber(invoiceNumber);
            request.setAttribute("invoiceFormBean", invoiceFormBean);
            request.setAttribute("inwardFormBean", _inwardFormBean);
            return invoiceFormBean;
        }
    }
}
