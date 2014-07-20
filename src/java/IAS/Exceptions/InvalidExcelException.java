package IAS.Exceptions;

/**
 * The exception to be used when any invalid data is present in the excel and is
 * not handled during validation
 *
 * @author Shailendra
 */
public class InvalidExcelException extends Exception {

    public InvalidExcelException(String message) {
        super(message);
    }

}
