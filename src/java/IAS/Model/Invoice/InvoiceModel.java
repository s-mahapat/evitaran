/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.Invoice;

import IAS.Bean.Invoice.InvoiceFormBean;
import IAS.Class.JDSLogger;
import IAS.Class.Queries;
import IAS.Class.util;
import IAS.Model.JDSModel;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.dbutils.BeanProcessor;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.log4j.Logger;

/**
 *
 * @author Shailendra
 */
public class InvoiceModel extends JDSModel{

    private static final Logger logger = JDSLogger.getJDSLogger(InvoiceModel.class.getName());
    Connection _conn = null;

    public InvoiceModel() throws SQLException{
        //super()
        this._conn = this.getConnection();
    }

    public InvoiceModel(HttpServletRequest request) throws SQLException{
        super(request);
        this._conn = this.getConnection();
    }

    public InvoiceFormBean getInvoiceInfoPRL(String invoice_no) throws SQLException{

        InvoiceFormBean _InvoiceFormBean = null;
        String sql = Queries.getQuery("get_invoice_detail_for_prl");
        try(PreparedStatement pst = _conn.prepareStatement(sql)){
            pst.setString(1, invoice_no);
            try(ResultSet rs = pst.executeQuery()){
                if(rs.first()){
                    BeanProcessor bProc = new BeanProcessor();
                    //Class type = Class.forName("IAS.Bean.Invoice.InvoiceFormBean");
                    _InvoiceFormBean = bProc.toBean(rs, IAS.Bean.Invoice.InvoiceFormBean.class);
                }
            }catch(Exception ex){
                logger.error(ex);
                throw ex;
            }
        }catch(Exception ex){
            logger.error(ex);
        }finally{
            return _InvoiceFormBean;
        }

    }

    public InvoiceFormBean getInvoiceInfo(String invoice_no) throws SQLException{

        InvoiceFormBean _InvoiceFormBean = null;
        String sql = Queries.getQuery("get_invoice_detail_usng_invno");
        try(PreparedStatement pst = _conn.prepareStatement(sql)){
            pst.setString(1, invoice_no);
            try(ResultSet rs = pst.executeQuery()){
                if(rs.first()){
                    BeanProcessor bProc = new BeanProcessor();
                    _InvoiceFormBean = (IAS.Bean.Invoice.InvoiceFormBean) bProc.toBean(rs, IAS.Bean.Invoice.InvoiceFormBean.class);
                }
            }catch(Exception ex){
                logger.error(ex);
                throw ex;
            }
        }catch(Exception ex){
            logger.error(ex);
        }finally{
            return _InvoiceFormBean;
        }

    }

    public int updatePRLEmailStatus(String invoice_no) throws SQLException{

        String sql = Queries.getQuery("update_prl_email_status");
        QueryRunner run = new QueryRunner();
        return run.update(conn, sql, invoice_no);
    }

    public String getPRLEmailBody() throws IOException{
        InputStream is = request.getServletContext().getResourceAsStream("/WEB-INF/classes/email_templates.properties");
        Properties props = new Properties();
        props.load(is);
        return props.getProperty("prl_invoice");
    }

    public String getOutStandingPaymentEmailBody() throws IOException{
        InputStream is = request.getServletContext().getResourceAsStream("/WEB-INF/classes/email_templates.properties");
        Properties props = new Properties();
        props.load(is);
        return props.getProperty("outstanding_payment");
    }

    public String getInvoicePaymentInfo(int invoice_id){

        try{
            //Connection _conn = this.getConnection();
            String sql = Queries.getQuery("invoice_payments");
            try(PreparedStatement pst = _conn.prepareStatement(sql)){
                pst.setInt(1, invoice_id);
                try(ResultSet rs = pst.executeQuery()){
                   return util.convertResultSetToXML(rs);
                }
            }catch(Exception ex){
                logger.error(ex);
                return null;
            }
        }catch(SQLException ex){
            logger.error(ex);
            return null;
        }
    }

    @Override
    public void destroy() {
        try {
            if(this.conn != null && this.conn.isClosed() == false){
                this._conn.close();
            }

        } catch (SQLException e) {
            logger.error("Failed to close Database connection");
        }

    }
}
