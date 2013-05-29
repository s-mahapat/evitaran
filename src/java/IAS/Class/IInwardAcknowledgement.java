/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

/**
 * This is an interface for all inward acknowledgments
 *
 * @author smahapat
 */
public interface IInwardAcknowledgement {

    /*
     * Gets the text that should be printed on screen/email of PDF document
     *
     * @param inwardPurpose the inward purpose code from the database
     * @param paymentMode the payment mode specified in the inward. Get the code from the database or JDSConstants file
     * @return the inward acknowledgment text
     */
    public String getAcknowledgementText(int inwardPurposeID, int paymentModeID, String cheque, String chequeDate, float amount, String letterNo, String letterDate);

}
