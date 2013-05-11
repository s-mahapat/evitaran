/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

public class JDSConstants {

    //inward ids
    public static int INWARD_PURPOSE_NEW_SUBSCRIPTION = 1;
    public static int INWARD_PURPOSE_RENEW_SUBSCRIPTION = 2;
    public static int INWARD_PURPOSE_ADDRESS_CHANGE = 10;
    public static int INWARD_PURPOSE_REQUEST_FOR_INVOICE = 4;
    public static int INWARD_PURPOSE_MISSING_ISSUE = 5;
    public static int INWARD_PURPOSE_REPRINT = 6;
    public static int INWARD_PURPOSE_ADVERTISEMENT = 7;
    public static int INWARD_PURPOSE_MANUSCRIPT = 8;
    public static int INWARD_PURPOSE_PAYMENT = 3;
    public static int INWARD_COMPLETE = 1;

    public static int INVOICE_REQUEST_FOR_INVOICE = 1;
    public static int INVOICE_OUTSTANDING_PAYMENT_INVOICE = 2;
    public static int INVOICE_UPCOMING_YEAR_INVOICE = 3;

    //IAS Address
    public static String IAS_LETTERHEAD = "Indian Academy of Sciences";
    public static String IAS_LETTERHEAD_ADDRESS = "C. V. Raman Avenue, P.B. No. 8005, Sadashivanagar, Bangalore 560 080, India";
    public static String IAS_LETTERHEAD_TELEPHONE = "Phone: +91-80-2266 1209, FAX: +91-80-2361 6094";
    public static String IAS_LETTERHEAD_EMAIL = "E-mail: orders@ias.ernet.in";
    public static String IAS_LETTERHEAD_WEB = "Website: http://www.ias.ac.in/";
    public static String IAS_LETTERHEAD_SALUTATION = "Dear Sir/Madam,";
    public static String IAS_LETTERFOOT_CLOSING = "For Circulation Department";
    public static String IAS_LETTERFOOT_SIGNATURE = "(Indian Academy of Sciences)";

    //IAS Payment Footer for Letters
    public static String IAS_PAYMENTFOOT_HEADER = "Payment can also be made through electronic transfer "
                + "and the details of account are given here";
    public static String IAS_PAYMENTFOOT_ACC = "Name of account holder";
    public static String IAS_PAYMENTFOOT_ACC_NAME = "Indian Academy of Sciences";
    public static String IAS_PAYMENTFOOT_BANK = "Name of the Bank";
    public static String IAS_PAYMENTFOOT_BANK_NAME = "State Bank of India";
    public static String IAS_PAYMENTFOOT_BRANCH = "Branch";
    public static String IAS_PAYMENTFOOT_BRANCH_NAME = "Sadashivanagar Branch";
    public static String IAS_PAYMENTFOOT_ACCNO = "A/c No.(Savings Bank)";
    public static String IAS_PAYMENTFOOT_ACCNO_DTLS = "10356 553343";
    public static String IAS_PAYMENTFOOT_IFSCOD = "IFS Code(For non-SBI banks)";
    public static String IAS_PAYMENTFOOT_IFSCOD_DTLS = "SBI N 000 1811";
    public static String IAS_PAYMENTFOOTER = "* After electronic transfer please confirm the remittance made by e-mail/post.";

    // Footer dimensions (in mm) and other details
    public static float width = 140.0f;
    public static float height = 40.0f;
    public static float heightFromBottomOfPage = 15.0f;


}
