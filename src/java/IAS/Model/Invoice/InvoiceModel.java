/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.Invoice;

import IAS.Bean.Invoice.InvoiceFormBean;
import IAS.Class.JDSLogger;
import IAS.Class.Queries;
import IAS.Model.JDSModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.apache.commons.dbutils.BeanProcessor;
import org.apache.log4j.Logger;

/**
 *
 * @author Shailendra
 */
public class InvoiceModel extends JDSModel{

    private static final Logger logger = JDSLogger.getJDSLogger(InvoiceModel.class.getName());
    Connection _conn = null;

    public InvoiceModel() throws SQLException{
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
                    Class type = Class.forName("IAS.Bean.Invoice.InvoiceFormBean");
                    _InvoiceFormBean = (IAS.Bean.Invoice.InvoiceFormBean) bProc.toBean(rs, type);
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
