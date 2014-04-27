/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.Payment;

import IAS.Class.JDSLogger;
import IAS.Class.Queries;
import IAS.Model.JDSModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import org.apache.log4j.Logger;

/**
 *
 * @author smahapat
 */
public class PaymentModel extends JDSModel {

    private static final Logger logger = JDSLogger.getJDSLogger(PaymentModel.class.getName());

    public PaymentModel() throws SQLException {
    }

    public int UpdatePayment(int invoice_id, int inward_id, float amount, String remarks) {
        String sql = Queries.getQuery("insert_payment");
        try (Connection _conn = this.getConnection(); PreparedStatement pst = _conn.prepareStatement(sql)) {
            pst.setInt(1, inward_id);
            pst.setInt(2, invoice_id);
            pst.setFloat(3, amount);
            pst.setString(4, remarks);
            int rc = pst.executeUpdate();
            return rc;
        } catch (Exception ex) {
            return 0;
        }
    }

    public int UpdatePayments(String[] invoice_ids, int inward_id, String[] amount, String[] remarks) {
        int[] rc = new int[invoice_ids.length];
        try (Connection _conn = this.getConnection()) {
            _conn.setAutoCommit(false);
            String sql = Queries.getQuery("insert_payment");
            try (PreparedStatement pst = _conn.prepareStatement(sql)) {
                for (int i = 0; i < invoice_ids.length; i++) {
                    pst.setInt(1, inward_id);
                    pst.setInt(2, Integer.parseInt(invoice_ids[i]));
                    pst.setFloat(3, Float.parseFloat(amount[i]));
                    pst.setString(4, remarks[i]);
                    pst.addBatch();
                }
                rc = pst.executeBatch();
            } catch (Exception ex) {
                logger.fatal(ex);
                return 0;
            } finally {
                boolean areAllUpdated = true;
                for (int i = 0; i < rc.length; i++) {
                    if (rc[i] == 0) {
                        areAllUpdated = false;
                        break;
                    }
                }
                if (areAllUpdated) {
                    _conn.commit();
                } else {
                    _conn.rollback();
                }
                _conn.setAutoCommit(true);
                return (areAllUpdated == true ? 1 : 0);
            }
        } catch (SQLException ex) {
            logger.fatal(ex);
            return 0;
        }
    }
}
