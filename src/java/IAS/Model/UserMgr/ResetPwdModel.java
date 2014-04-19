/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.UserMgr;

import IAS.Class.JDSLogger;
import IAS.Class.PasswordGenerator;
import IAS.Class.Queries;
import IAS.Class.msgsend;
import IAS.Model.JDSModel;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import org.apache.log4j.Logger;

/**
 *
 * @author Shailendra
 */
public class ResetPwdModel extends JDSModel {

    private static final Logger logger = JDSLogger.getJDSLogger(ResetPwdModel.class.getName());

    public ResetPwdModel() throws SQLException {
    }

    private String getNewPassword() {
        return PasswordGenerator.getNext();
    }

    public boolean updatePassword(String email, String newPassword) throws SQLException {

        boolean isReset = false;
        Connection _conn = this.getConnection();

        String sql = Queries.getQuery("update_password");
        try (PreparedStatement pst = _conn.prepareStatement(sql)) {
            pst.setString(1, newPassword);
            pst.setBoolean(2, false);
            pst.setString(3, email);
            int rc = pst.executeUpdate();
            if(rc == 1){
                isReset = true;
            }
        }catch(Exception ex){
            logger.error(ex);
        }finally{
            _conn.close();
            return isReset;
        }
    }

    public boolean emailNewPassword(String email) throws SQLException, FileNotFoundException, IOException {

        boolean isReset = false;
        Connection _conn = this.getConnection();

        // get the new password from the password generator
        String newPassword = this.getNewPassword();

        String _body = "As Per your request, the password has been reset by JDS Administrator. Your new password is: " + newPassword;
        _body += "\n" + "You will be prompted to change your password on next login";

        msgsend _msgsend = new msgsend();

        try {
            String sql = Queries.getQuery("update_password");
            try (PreparedStatement pst = _conn.prepareStatement(sql)) {
                pst.setString(1, newPassword);
                pst.setBoolean(2, true);
                pst.setString(3, email);
                int rc = pst.executeUpdate();

                // send an email only if the password was reset successfully
                if (rc == 1) {
                    isReset = _msgsend.sendEmailToSubscriberWithAttachment(email, "Your New Password", _body, null, null, null);
                }
            }

        } catch (SQLException | IOException e) {
            isReset = false;
            logger.error(e);
        } finally {
            _conn.close();            
        }
        return isReset;

    }
}
