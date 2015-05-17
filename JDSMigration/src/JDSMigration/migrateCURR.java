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
public class migrateCURR extends MigrationBase {

    private static final Logger logger = Logger.getLogger(migrateCURR.class.getName());

    public migrateCURR() throws SQLException {
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
                int copies = getCopiesCURR(datacolumns);
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

                String CSY = getCSYCURR(datacolumns);
                String CEY = getCEYCURR(datacolumns);
                boolean active = true;

                if (Integer.parseInt(CEY) < Calendar.getInstance().get(Calendar.YEAR)) {
                    active = false;
                }

                // Start year < 1st-Jan-2013 and End year > 31-July-2012
                // csy.compareTo(dateFormat.parse("01/01/2013")) < 0 && cey.compareTo(dateFormat.parse("31/07/2012")) > 0
                if (checkIfValidSubscriptionCURR(datacolumns) && copies > 0) {
                    count = count + Integer.parseInt(datacolumns[27]);
                    //logger.info(subno);

                    // Add logic to migrate the subscribers here
                    int subscriber_id = this.getSubscriberID(Integer.parseInt(subno));
                    if (subscriber_id == 0) {
                        logger.fatal("Unable to update subscription for subscriber " + subno + " No subscriber id found in DB");
                        continue;
                    }
                    int subscription_id = this.insertSubscription(subscriber_id, 0, amount, subdate, corr_balance, 0, legacy_proforma_invoice_no, legacy_proforma_invoice_date);
                    logger.debug("Inserted Subscription with id: " + subscription_id);

                    this.insertSubscriptionDetailsForCURR(subscription_id, datacolumns);
                    logger.debug("Inserted Subscription details for subscription id: " + subscription_id);

                }

                logger.debug("Rows: " + totalRows + " -> CSY: " + CSY + " -> CEY: " + CEY);
            } catch (ParseException e) {
                logger.fatal("Found incorrect date in row: " + totalRows + " skipping this row");
            }
        }
        logger.info("CURR: " + count);
        this.conn.commit();
    }

    public boolean insertSubscriptionDetailsForCURR(int subscription_id, String[] datacolumns) throws SQLException, ParseException {

        boolean status = this.insertSubscriptionDetails(subscription_id,
                11,
                getCopiesCURR(datacolumns),
                getstartYearCURR(datacolumns),
                getstartMonthCURR(datacolumns),
                getendYearCURR(datacolumns),
                getendMonthCURR(datacolumns),
                1);
        return status;
    }

    public int getstartYearCURR(String[] datacolumns) throws ParseException {
        Calendar cal = Calendar.getInstance();
        cal.setTime(getcsyCURR(datacolumns));
        int startMonth = cal.get(Calendar.MONTH) + 1;
        int startYear = cal.get(Calendar.YEAR);
        return startYear;
    }

    public int getstartMonthCURR(String[] datacolumns) throws ParseException {
        Calendar cal = Calendar.getInstance();
        cal.setTime(getcsyCURR(datacolumns));
        int startMonth = cal.get(Calendar.MONTH) + 1;
        int startYear = cal.get(Calendar.YEAR);
        return startMonth;
    }

    public int getendYearCURR(String[] datacolumns) throws ParseException {
        Calendar cal = Calendar.getInstance();
        cal.setTime(getceyCURR(datacolumns));
        int endMonth = cal.get(Calendar.MONTH) + 1;
        int endYear = cal.get(Calendar.YEAR);

        return endYear;
    }

    public int getendMonthCURR(String[] datacolumns) throws ParseException {
        Calendar cal = Calendar.getInstance();
        cal.setTime(getceyCURR(datacolumns));
        int endMonth = cal.get(Calendar.MONTH) + 1;
        int endYear = cal.get(Calendar.YEAR);

        return endMonth;
    }

    public int getCopiesCURR(String[] datacolumns) {
        return datacolumns[27].isEmpty() ? 0 : Integer.parseInt(datacolumns[27]);
    }

    public boolean checkIfValidSubscriptionCURR(String[] datacolumns) throws ParseException {
        Date cey = getceyCURR(datacolumns);
        SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        if (cey.compareTo(dateFormat.parse("01/01/2012")) > 0) {
            return true;
        } else {
            return false;
        }
    }

    public String getCSYCURR(String[] datacolumns) throws ParseException {
        String CURRYR = datacolumns[26];
        String DATE_CURR = datacolumns[28];
        String CSY = "0";
        SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        Date csy = dateFormat.parse("01/01/1900");
        if (!(CURRYR.isEmpty() || CURRYR.equals("0") || DATE_CURR.isEmpty())) {
            CSY = DATE_CURR;
            csy = dateFormat.parse(CSY);
        }
        return CSY;
    }

    public Date getcsyCURR(String[] datacolumns) throws ParseException {
        String CSY = getCSYCURR(datacolumns);
        SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        Date csy = dateFormat.parse("01/01/1900");
        csy = dateFormat.parse(CSY);
        return csy;
    }

    public String getCEYCURR(String[] datacolumns) throws ParseException {
        String CURRYR = datacolumns[26];
        String DATE_CURR = datacolumns[28];
        SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        String CEY = "0";
        Date cey = getceyCURR(datacolumns);
        CEY = dateFormat.format(cey);

        return CEY;
    }

    public Date getceyCURR(String[] datacolumns) throws ParseException {
        String CURRYR = datacolumns[26];
        String DATE_CURR = datacolumns[28];
        String CEY = "0";
        SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        Date cey = dateFormat.parse("01/01/1900");
        if (!(getCSYCURR(datacolumns).equals("0"))) {
            Calendar temp = Calendar.getInstance();

            temp.setTime(dateFormat.parse(getCSYCURR(datacolumns)));
            if (!(CURRYR.isEmpty() || CURRYR.equals("0"))) {
                temp.add(Calendar.DAY_OF_YEAR, Integer.parseInt(CURRYR) * 365);
            }
            cey = temp.getTime();
            CEY = dateFormat.format(cey);
        }
        return cey;
    }
}
