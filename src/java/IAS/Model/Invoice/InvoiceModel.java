/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.Invoice;

import IAS.Bean.Invoice.InvoiceFormBean;
import IAS.Bean.Subscriber.subscriberFormBean;
import IAS.Class.JDSLogger;
import IAS.Class.PaymentInfo;
import IAS.Class.Queries;
import IAS.Class.util;
import IAS.Model.JDSModel;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.dbutils.BeanProcessor;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.log4j.Logger;

/**
 *
 * @author Shailendra
 */
public class InvoiceModel extends JDSModel {

    private static final Logger logger = JDSLogger.getJDSLogger(InvoiceModel.class.getName());
    //private Connection _conn = null;

    public InvoiceModel() throws SQLException {
        super();
        //this._conn = this.getConnection();
    }

    public InvoiceModel(HttpServletRequest request) throws SQLException {
        super(request);
        //this._conn = this.getConnection();
    }

    public InvoiceFormBean getInvoiceInfoPRL(String invoice_no) throws SQLException {

        InvoiceFormBean _InvoiceFormBean;
        try (Connection conn = this.getConnection()) {
            _InvoiceFormBean = this.getInvoiceInfoPRL(conn, invoice_no);
        }
        return _InvoiceFormBean;

    }

    /*
     This method is required so that it could be used for generation for PRL list,
     we pass the connection object around else the pool gets full if we pick a new
     connection every time.
     */
    public InvoiceFormBean getInvoiceInfoPRL(Connection conn, String invoice_no) throws SQLException {
        InvoiceFormBean _InvoiceFormBean = null;
        String sql = Queries.getQuery("get_invoice_detail_for_prl");
        try (PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setString(1, invoice_no);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.first()) {
                    BeanProcessor bProc = new BeanProcessor();
                    //Class type = Class.forName("IAS.Bean.Invoice.InvoiceFormBean");
                    _InvoiceFormBean = bProc.toBean(rs, IAS.Bean.Invoice.InvoiceFormBean.class);
                }
            } catch (Exception ex) {
                logger.error(ex);
                throw ex;
            }
        } catch (Exception ex) {
            logger.error(ex);
        } finally {
            return _InvoiceFormBean;
        }
    }

    public InvoiceFormBean getInvoiceInfo(String invoice_no) throws SQLException {

        InvoiceFormBean _InvoiceFormBean = null;
        String sql = Queries.getQuery("get_invoice_detail_usng_invno");
        try (PreparedStatement pst = this.getConnection().prepareStatement(sql)) {
            pst.setString(1, invoice_no);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.first()) {
                    BeanProcessor bProc = new BeanProcessor();
                    _InvoiceFormBean = (IAS.Bean.Invoice.InvoiceFormBean) bProc.toBean(rs, IAS.Bean.Invoice.InvoiceFormBean.class);
                }
            } catch (Exception ex) {
                logger.error(ex);
                throw ex;
            }
        } catch (Exception ex) {
            logger.error(ex);
        } finally {
            return _InvoiceFormBean;
        }

    }

    public InvoiceFormBean getInvoiceInfo(int invoice_id) throws SQLException {

        InvoiceFormBean _InvoiceFormBean = null;
        String sql = Queries.getQuery("get_invoice_detail_usng_invid");
        try (PreparedStatement pst = this.getConnection().prepareStatement(sql)) {
            pst.setInt(1, invoice_id);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.first()) {
                    BeanProcessor bProc = new BeanProcessor();
                    _InvoiceFormBean = (IAS.Bean.Invoice.InvoiceFormBean) bProc.toBean(rs, IAS.Bean.Invoice.InvoiceFormBean.class);
                }
            } catch (Exception ex) {
                logger.error(ex);
                throw ex;
            }
        } catch (Exception ex) {
            logger.error(ex);
        } finally {
            return _InvoiceFormBean;
        }

    }

    public int updatePRLEmailStatus(String invoice_no) throws SQLException {

        String sql = Queries.getQuery("update_prl_email_status");
        QueryRunner run = new QueryRunner();
        return run.update(this.getConnection(), sql, invoice_no);
    }

    public String getPRLEmailBody() throws IOException {
        InputStream is = request.getServletContext().getResourceAsStream("/WEB-INF/classes/email_templates.properties");
        Properties props = new Properties();
        props.load(is);
        return props.getProperty("prl_invoice");
    }

    public String getOutStandingPaymentEmailBody(float amount) throws IOException {
        InputStream is = request.getServletContext().getResourceAsStream("/WEB-INF/classes/email_templates.properties");
        Properties props = new Properties();
        props.load(is);
        return String.format(props.getProperty("outstanding_payment"), amount);
    }

    public String getStatementEmailBody() throws IOException {
        InputStream is = request.getServletContext().getResourceAsStream("/WEB-INF/classes/email_templates.properties");
        Properties props = new Properties();
        props.load(is);
        return props.getProperty("statement");
    }

    public List<IAS.Class.PaymentInfo> getInvoicePayments(int invoice_id) {

        List<IAS.Class.PaymentInfo> payments = new ArrayList<>();
        String sql = Queries.getQuery("invoice_payments");
        try (PreparedStatement pst = this.getConnection().prepareStatement(sql)) {
            pst.setInt(1, invoice_id);
            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    PaymentInfo info = new PaymentInfo();
                    info.setChqddNumber(rs.getString("chqddNumber"));
                    info.setInvoiceID(rs.getInt("invoice_id"));
                    info.setInwardNumber(rs.getString("inwardNumber"));
                    info.setPaymentAmount(rs.getFloat("paymentAmount"));
                    info.setPaymentDate(rs.getString("paymentDate"));
                    info.setPaymentMode(rs.getString("paymentMode"));
                    payments.add(info);
                }
                return payments;
            }
        } catch (Exception ex) {
            logger.error(ex);
            return null;
        }
    }

    public String getInvoicePaymentInfo(int invoice_id) {
        String sql = Queries.getQuery("invoice_payments");
        try (PreparedStatement pst = this.getConnection().prepareStatement(sql)) {
            pst.setInt(1, invoice_id);
            try (ResultSet rs = pst.executeQuery()) {
                return util.convertResultSetToXML(rs);
            }
        } catch (Exception ex) {
            logger.error(ex);
            return null;
        }
    }

    public subscriberFormBean getSubscriberInfo(int invoice_id) {

        subscriberFormBean _subscriberFormBean = null;
        String sql = Queries.getQuery("get_subscriber_info_from_invoice");
        try (PreparedStatement pst = this.getConnection().prepareStatement(sql)) {
            pst.setInt(1, invoice_id);
            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    BeanProcessor bProc = new BeanProcessor();
                    _subscriberFormBean = (IAS.Bean.Subscriber.subscriberFormBean) bProc.toBean(rs, IAS.Bean.Subscriber.subscriberFormBean.class);
                }
                return _subscriberFormBean;
            }
        } catch (Exception ex) {
            logger.error(ex);
            return null;
        }
    }
}
