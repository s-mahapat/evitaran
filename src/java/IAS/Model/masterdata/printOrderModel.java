
package IAS.Model.masterdata;

import java.lang.reflect.InvocationTargetException;
import javax.servlet.http.HttpServletRequest;
import IAS.Bean.masterdata.printOrderFormBean;
import java.sql.*;
import IAS.Model.*;
import java.text.ParseException;
import IAS.Class.Queries;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import IAS.Class.util;
import org.apache.log4j.Logger;
import IAS.Class.JDSLogger;
/**
 *
 * @author Deepali
 */
public class printOrderModel extends JDSModel{

    private printOrderFormBean _printOrderFormBean = null;
    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Model.masterdata");

    public printOrderModel(HttpServletRequest request) throws SQLException{

       super(request);

    }

    public synchronized void Save () throws SQLException, ParseException,
            java.lang.reflect.InvocationTargetException, java.lang.IllegalAccessException, ClassNotFoundException{

        printOrderFormBean printOrderFormBean = new IAS.Bean.masterdata.printOrderFormBean();
        request.setAttribute("printOrderFormBean", printOrderFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, printOrderFormBean);
        this._printOrderFormBean = printOrderFormBean;

        String sql = Queries.getQuery("update_printOrder");

        PreparedStatement st = conn.prepareStatement(sql);

        int paramIndex = 1;

        st.setInt(paramIndex, _printOrderFormBean.getPrintOrder());
        st.setInt(++paramIndex, _printOrderFormBean.getYear());
        st.setString(++paramIndex, _printOrderFormBean.getJournalCode());

        try
        {
            int success = db.executeUpdatePreparedStatement(st);
            if(success == 0)
            {
                // Since we reached here means that this is a new entry into the printOrder table
                // Check if the print_order is >0, if it is then it means that it is anew entry, else ignore it
                if(this._printOrderFormBean.getPrintOrder()>0)
                {
                    // First get the journalID
                    int journalId=0;
                    String query = Queries.getQuery("get_journal_id");
                    PreparedStatement pst = conn.prepareStatement(query);
                    pst.setString(1, _printOrderFormBean.getJournalCode());
                    ResultSet rs = db.executeQueryPreparedStatement(pst);
                    while(rs.next()){
                            journalId = rs.getInt(1);
                        }

                    query = Queries.getQuery("insert_printOrder");
                    pst = conn.prepareStatement(query);

                    int index = 1;
                    pst.setInt(index, _printOrderFormBean.getYear());
                    pst.setInt(++index, journalId);
                    pst.setInt(++index, _printOrderFormBean.getPrintOrder());

                    //db.executeQueryPreparedStatement(pst);
                    db.executeUpdatePreparedStatement(pst);
                }

            }
        }catch (Exception MySQLIntegrityConstraintViolationException)
        {
            logger.error(MySQLIntegrityConstraintViolationException.getMessage(), MySQLIntegrityConstraintViolationException);
        }
        request.setAttribute("printOrderFormBean", this._printOrderFormBean);

    }

    public String searchPrintOrder() throws SQLException, ParseException, ParserConfigurationException, TransformerException, IllegalAccessException, InvocationTargetException {

        printOrderFormBean printOrderFormBean = new IAS.Bean.masterdata.printOrderFormBean();
        request.setAttribute("printOrderFormBean", printOrderFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, printOrderFormBean);
        this._printOrderFormBean = printOrderFormBean;

        request.setAttribute("printOrderFormBean", this._printOrderFormBean);

        String xml = null;
        String sql = Queries.getQuery("get_print_order_by_year");
        PreparedStatement st = conn.prepareStatement(sql);
        st.setInt(1, this._printOrderFormBean.getYear());

        ResultSet rs = this.db.executeQueryPreparedStatement(st);
        xml = util.convertResultSetToXML(rs);
        return xml;
    }


    public String addPrintOrder() throws SQLException, ParseException, ParserConfigurationException, TransformerException, IllegalAccessException, InvocationTargetException {

        printOrderFormBean printOrderFormBean = new IAS.Bean.masterdata.printOrderFormBean();
        request.setAttribute("printOrderFormBean", printOrderFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, printOrderFormBean);
        this._printOrderFormBean = printOrderFormBean;

        request.setAttribute("printOrderFormBean", this._printOrderFormBean);

        String xml = null;
        String sql = Queries.getQuery("add_new_print_order");
        PreparedStatement st = conn.prepareStatement(sql);

        ResultSet rs = this.db.executeQueryPreparedStatement(st);

        xml = this.convertResultSetToXMLForPrintOrder(rs, this._printOrderFormBean.getYear());
        return xml;
    }

    public String convertResultSetToXMLForPrintOrder(ResultSet result, int year) throws SQLException
    {
        String xml = "";
        xml = xml + "<?xml version='1.0' encoding='utf-8'?>\n";
        //System.out.println("<?xml version='1.0' encoding='utf-8'?>\n");
        xml = xml + "<results>";
        //System.out.println("<results>");

        ResultSetMetaData rsmd = result.getMetaData();
        int numberOfColumns = rsmd.getColumnCount();

        int id = 1;
        while (result.next())
        {
            int issues = 0, journalId = 0;
            for (int i = 1; i <= numberOfColumns; i++)
            {
                String columnValue = result.getString(i);

                if(i == 1)
                {
                    xml = xml + "<row>";
                }

                xml = xml + "<" + rsmd.getColumnName(i) + ">" + columnValue + "</" + rsmd.getColumnName(i) + ">";

                if("id".equals(rsmd.getColumnName(i)))
                    journalId = result.getInt(i);
                if("issues".equals(rsmd.getColumnName(i)))
                    issues = result.getInt(i);

                if(i == numberOfColumns)
                {
                    xml = xml + "<year>" + year + "</year>";

                    //Now take the "year" and "journalCode" and check if entry already exists
                    int printOrder = 0;

                    String sql = Queries.getQuery("get_printOrder");
                    PreparedStatement st = conn.prepareStatement(sql);
                    int paramIndex = 1;
                    st.setInt(paramIndex++, year);
                    st.setInt(paramIndex, journalId);
                    ResultSet rs = this.db.executeQueryPreparedStatement(st);

                    ResultSetMetaData rsmds = rs.getMetaData();
                    int numOfCols = rsmds.getColumnCount();
                    while (rs.next())
                    {
                        for (int i1 = 1; i1 <= numOfCols; i1++)
                        {
                            if(rsmds.getColumnName(i1).equals("printOrder"))
                                printOrder = rs.getInt(i1);
                        }
                    }

                    xml = xml + "<printOrder>" + printOrder + "</printOrder>";

                    xml = xml + "<annualPrintOrder>" + printOrder*issues + "</annualPrintOrder>";

                    xml = xml + "</row>";
                }
            }
            id++;
        }
        xml = xml + "</results>";

        return xml;
    }

}