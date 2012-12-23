/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.Payment;

import IAS.Class.Queries;
import IAS.Model.JDSModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author smahapat
 */
public class PaymentModel extends JDSModel{

    public PaymentModel() throws SQLException{

    }

    public int UpdatePayment(int invoice_id, int inward_id, float amount, String remarks){

        try{
            Connection _conn = this.getConnection();
            String sql = Queries.getQuery("insert_payment");
            try(PreparedStatement pst = _conn.prepareStatement(sql)){
                pst.setInt(1, inward_id);
                pst.setInt(2, invoice_id);
                pst.setFloat(3, amount);
                pst.setString(4, remarks);
                int rc = pst.executeUpdate();
                return rc;
            }catch(Exception ex){
                return 0;
            }finally{
                _conn.close();
            }
        }catch(SQLException ex){
            return 0;
        }
    }
}
