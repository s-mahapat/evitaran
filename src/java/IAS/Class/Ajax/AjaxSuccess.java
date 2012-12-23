/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class.Ajax;

/**
 *
 * @author Shailendra
 */
public class AjaxSuccess {

    private boolean success;
    private String message;

    public void setMessage(String _msg) {
        this.message = _msg;
    }

    public void setSuccess(boolean _success) {
        this.success = _success;
    }

    public String getMessage() {
        return this.message;
    }

    public boolean getSuccess() {
        return this.success;
    }
}
