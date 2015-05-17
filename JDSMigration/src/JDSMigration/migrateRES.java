/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package JDSMigration;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import jxl.read.biff.BiffException;
import org.apache.log4j.Logger;

/**
 *
 * @author aloko
 */
public class migrateRES extends MigrationBase {

    private static final Logger logger = Logger.getLogger(migrateCURR.class.getName());

    public migrateRES() throws SQLException {
        this.dataFile = this.dataFolder + "\\jnls.xls";
        this.conn = this.db.getConnection();
        this.conn.setAutoCommit(false);
    }

    public void migrate() throws FileNotFoundException, IOException, BiffException, SQLException, ParseException {

        this.openExcel(dataFile);
        logger.debug("able to open file" + dataFile.toString());
        Corr _corr = new Corr();
        String[] corrdatacolumns;
        String corr_subscriber = null;
        String corr_sub_date = null;
        float corr_balance;
        int counter = 0;

        String[] datacolumns;
        int totalRows = 0, count = 0;

        while (true) {
            datacolumns = this.getNextRow();
            corrdatacolumns = _corr.getCorrNextRow();
            if (datacolumns == null) {
                break;
            }
            if (corrdatacolumns != null) {
                corr_subscriber = corrdatacolumns[3];
                corr_sub_date = corrdatacolumns[14];
            }
            totalRows++;
            counter++;
            if (counter >= 1000) {
                this.conn.commit();
                counter = 0;
            }

            try {

                String subno = datacolumns[0];
                int copies = getCopiesRES(datacolumns);
                float amount = Float.parseFloat(datacolumns[29]);

                java.sql.Date subdate = util.dateStringToSqlDate(null);
                try {
                    if (!corr_subscriber.isEmpty() && Integer.parseInt(corr_subscriber) == Integer.parseInt(subno)) {
                        subdate = util.dateStringToSqlDate(corr_sub_date);
                        corr_balance = corrdatacolumns[15].isEmpty() == false ? Float.parseFloat(corrdatacolumns[15]) : (float) 0;
                    } else {
                        corr_balance = (float) 0;
                    }
                } catch (NumberFormatException | ParseException | NullPointerException e) {
                    logger.fatal(e.toString());
                    logger.fatal("cannot update subscription date and balance for subscriber: " + subno);
                    logger.fatal("subscriber in corr:" + corr_subscriber);

                    corr_balance = (float) 0;
                }

                // Get the proforma_invoice_no
                String legacy_proforma_invoice_no = "";
                if(!(corrdatacolumns[10].isEmpty() || corrdatacolumns[10] == null)) {
                    legacy_proforma_invoice_no = corrdatacolumns[10];
                }

                // Get the legacy_proforma_invoice_date
                java.sql.Date legacy_proforma_invoice_date = util.dateStringToSqlDate(null);
                try {
                    legacy_proforma_invoice_date = util.dateStringToSqlDate(util.convertDateFormat(corrdatacolumns[5], "MM/dd/yyyy", "dd/MM/yyyy"));
                } catch (NumberFormatException | ParseException | NullPointerException e) {
                    // Do nothing if there is an exception
                }

                String CSY = getCSYRES(datacolumns);
                String CEY = getCEYRES(datacolumns);
                boolean active = true;

                if (Integer.parseInt(CEY) < Calendar.getInstance().get(Calendar.YEAR)) {
                    active = false;
                }

                // Start year < 1st-Jan-2013 and End year > 31-July-2012
                // csy.compareTo(dateFormat.parse("01/01/2013")) < 0 && cey.compareTo(dateFormat.parse("31/07/2012")) > 0
                if (checkIfValidSubscriptionRES(datacolumns) && copies > 0) {
                    count = count + Integer.parseInt(datacolumns[22]);
                    //logger.info(subno);

                    // Add logic to migrate the subscribers here
                    int subscriber_id = this.getSubscriberID(Integer.parseInt(subno));
                    if(subscriber_id == 0){
                        logger.fatal("Unable to update subscription for subscriber " + subno + " No subscriber id found in DB");
                        continue;
                    }
                    int subscription_id = this.insertSubscription(subscriber_id, 0, amount, subdate, corr_balance, 0, legacy_proforma_invoice_no, legacy_proforma_invoice_date);

                    logger.debug("Inserted Subscription with id: " + subscription_id);

                    this.insertSubscriptionDetailsForRES(subscription_id, datacolumns);
                    logger.debug("Inserted Subscription details for subscription id: " + subscription_id);

                }

                logger.debug("Rows: " + totalRows + " -> CSY: " + CSY + " -> CEY: " + CEY);
            } catch (ParseException e) {
                logger.fatal("Found incorrect date in row: " + totalRows + " skipping this row");
            }
        }
        logger.info("RES: " + count);
        this.conn.commit();
    }

    public boolean insertSubscriptionDetailsForRES(int subscription_id, String[] datacolumns) throws SQLException, ParseException{

        boolean status = this.insertSubscriptionDetails(subscription_id,
                            10,
                            getCopiesRES(datacolumns),
                            getstartYearRES(datacolumns),
                            getstartMonthRES(datacolumns),
                            getendYearRES(datacolumns),
                            getendMonthRES(datacolumns),
                            1);
        return status;
    }

    public int getstartYearRES(String[] datacolumns) throws ParseException{
        Calendar cal = Calendar.getInstance();
        cal.setTime(getcsyRES(datacolumns));
        int startMonth = cal.get(Calendar.MONTH) + 1;
        int startYear = cal.get(Calendar.YEAR);
        return startYear;
    }

    public int getstartMonthRES(String[] datacolumns) throws ParseException{
        Calendar cal = Calendar.getInstance();
        cal.setTime(getcsyRES(datacolumns));
        int startMonth = cal.get(Calendar.MONTH) + 1;
        int startYear = cal.get(Calendar.YEAR);
        return startMonth;
    }

    public int getendYearRES(String[] datacolumns) throws ParseException{
        Calendar cal = Calendar.getInstance();
        cal.setTime(getceyRES(datacolumns));
        int endMonth = cal.get(Calendar.MONTH) + 1;
        int endYear = cal.get(Calendar.YEAR);

        return endYear;
    }

    public int getendMonthRES(String[] datacolumns) throws ParseException{
        Calendar cal = Calendar.getInstance();
        cal.setTime(getceyRES(datacolumns));
        int endMonth = cal.get(Calendar.MONTH) + 1;
        int endYear = cal.get(Calendar.YEAR);

        return endMonth;
    }

    public int getCopiesRES(String[] datacolumns){
        return datacolumns[22].isEmpty() ? 0 : Integer.parseInt(datacolumns[22]);
    }

    public boolean checkIfValidSubscriptionRES(String[] datacolumns) throws ParseException{
        Date cey = getceyRES(datacolumns);
        SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        if(cey.compareTo(dateFormat.parse("01/01/2012")) > 0){
            return true;
        }else {
            return false;
        }
    }

    public String getCSYRES(String[] datacolumns) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        String CURRYR = datacolumns[21];
        String DATE_CURR = datacolumns[23];
        String CSY = "0";
        Date csy = dateFormat.parse("01/01/1900");
        if (!(CURRYR.isEmpty() || CURRYR.equals("0") || DATE_CURR.isEmpty())) {
            CSY = DATE_CURR;
            csy = dateFormat.parse(CSY);
        }
        return CSY;
    }

    public Date getcsyRES(String[] datacolumns) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        String CURRYR = datacolumns[21];
        String DATE_CURR = datacolumns[23];
        String CSY = "0";
        Date csy = dateFormat.parse("01/01/1900");
        if (!(CURRYR.isEmpty() || CURRYR.equals("0") || DATE_CURR.isEmpty())) {
            CSY = DATE_CURR;
            csy = dateFormat.parse(CSY);
        }
        return csy;
    }

    public String getCEYRES(String[] datacolumns) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        String CURRYR = datacolumns[21];
        String CEY = "0";
        Date cey = dateFormat.parse("01/01/1900");
        if (!(getCSYRES(datacolumns).equals("0"))) {
            Calendar temp = Calendar.getInstance();

            temp.setTime(dateFormat.parse(getCSYRES(datacolumns)));
            if (!(CURRYR.isEmpty() || CURRYR.equals("0"))) {
                temp.add(Calendar.DAY_OF_YEAR, Integer.parseInt(CURRYR) * 365);
            }
            cey = temp.getTime();
            CEY = dateFormat.format(cey);
        }
        return CEY;
    }

    public Date getceyRES(String[] datacolumns) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        String CURRYR = datacolumns[21];
        String CEY = "0";
        Date cey = dateFormat.parse("01/01/1900");
        if (!(getCSYRES(datacolumns).equals("0"))) {
            Calendar temp = Calendar.getInstance();

            temp.setTime(dateFormat.parse(getCSYRES(datacolumns)));
            if (!(CURRYR.isEmpty() || CURRYR.equals("0"))) {
                temp.add(Calendar.DAY_OF_YEAR, Integer.parseInt(CURRYR) * 365);
            }
            cey = temp.getTime();
            CEY = dateFormat.format(cey);
        }
        return cey;
    }
}
