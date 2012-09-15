/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.UserMgr;
import IAS.Class.JDSLogger;
import IAS.Class.PasswordGenerator;
import IAS.Class.msgsend;
import IAS.Model.JDSModel;
import java.io.IOException;
import java.sql.SQLException;
import org.apache.log4j.Logger;
/**
 *
 * @author Shailendra
 */
public class ResetPwdModel extends JDSModel{
    
    private static final Logger logger = JDSLogger.getJDSLogger(ResetPwdModel.class.getName());
    public ResetPwdModel() throws SQLException{
        
    }
    
    private String getNewPassword(){
        return PasswordGenerator.getNext();
    }
    
    public boolean emailNewPassword(String email){
        
        boolean isReset = false;
        String _body = "Your Password has been reset by JDS Administrator. Your new password is: " + this.getNewPassword();
        msgsend _msgsend = new msgsend();
        try{
            isReset = _msgsend.sendEmailToSubscriberWithAttachment(email, "Your New Password", _body, null, null, null);
        }catch(IOException e){
            isReset = false;
            logger.error(e);
        }finally{
            return isReset;
        }
        
        
    }
}
