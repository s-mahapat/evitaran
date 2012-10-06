
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

        // Get the ID if present in the print_order table
        String sql = Queries.getQuery("get_print_order_id");
        PreparedStatement st = conn.prepareStatement(sql);
        int paramIndex = 1;
        st.setInt(paramIndex, _printOrderFormBean.getYear());
        st.setString(++paramIndex, _printOrderFormBean.getJournalName());
        st.setInt(++paramIndex, _printOrderFormBean.getIssueNo());
        ResultSet rs = db.executeQueryPreparedStatement(st);
        // Update the print_order if it exists, else it means it is a new print_order
        if(rs.next()){
            int printOrderId = rs.getInt(1);
            sql = Queries.getQuery("update_printOrder");
            st = conn.prepareStatement(sql);
            paramIndex = 1;
            st.setInt(paramIndex++, _printOrderFormBean.getPrintOrder());
            st.setInt(paramIndex++, printOrderId);
            int success = db.executeUpdatePreparedStatement(st);
        }
        else
        {
            // Since the print order does not exist in the table add a new entry
            // Check if the print_order is >0, if it is then it means that it is a new entry, else ignore it
            if(this._printOrderFormBean.getPrintOrder()>0)
            {
                // First get the journalID
                int journalId=0;

                String query = Queries.getQuery("insert_printOrder");
                PreparedStatement pst = conn.prepareStatement(query);

                int index = 1;
                pst.setInt(index, _printOrderFormBean.getYear());
                pst.setString(++index, _printOrderFormBean.getJournalName());
                pst.setInt(++index, _printOrderFormBean.getIssueNo());
                pst.setInt(++index, _printOrderFormBean.getPrintOrder());

                db.executeUpdatePreparedStatement(pst);
            }
        }
        request.setAttribute("printOrderFormBean", this._printOrderFormBean);
    }

    public String searchPrintOrder() throws SQLException, ParseException, ParserConfigurationException, TransformerException, IllegalAccessException, InvocationTargetException
    {

        printOrderFormBean printOrderFormBean = new IAS.Bean.masterdata.printOrderFormBean();
        request.setAttribute("printOrderFormBean", printOrderFormBean);

        //FillBean is defined in the parent class IAS.Model/JDSModel.java
        FillBean(this.request, printOrderFormBean);
        this._printOrderFormBean = printOrderFormBean;

        request.setAttribute("printOrderFormBean", this._printOrderFormBean);

        String sql = Queries.getQuery("getNoOfIssues");
        PreparedStatement st = conn.prepareStatement(sql);
        st.setString(1, this._printOrderFormBean.getJournalName());

        ResultSet rs = this.db.executeQueryPreparedStatement(st);
        //xml = util.convertResultSetToXML(rs);
        String xml = this.convertResultSetToXMLForPrintOrder(rs, this._printOrderFormBean.getYear(), this._printOrderFormBean.getJournalName());
        return xml;
    }

    public String convertResultSetToXMLForPrintOrder(ResultSet result, int year, String journalName) throws SQLException
    {
        String xml = "";
        xml = xml + "<?xml version='1.0' encoding='utf-8'?>\n";
        //System.out.println("<?xml version='1.0' encoding='utf-8'?>\n");
        xml = xml + "<results>";
        //System.out.println("<results>");

        ResultSetMetaData rsmd = result.getMetaData();
        String colName = rsmd.getColumnName(1);
        int noOfIssues = 0;
        if(result.next())
            noOfIssues = result.getInt(1);

        for (int i = 1; i <= noOfIssues; i++)
        {
            xml = xml + "<row>";

            String sql = Queries.getQuery("get_printOrder");
            PreparedStatement st = conn.prepareStatement(sql);
            int paramIndex = 1;
            st.setInt(paramIndex++, year);
            st.setString(paramIndex++, journalName);
            st.setInt(paramIndex, i);
            ResultSet rs = this.db.executeQueryPreparedStatement(st);

            ResultSetMetaData rsMD = rs.getMetaData();
            int printOrder = 0;
            if(rs.next())
                printOrder = rs.getInt(1);

            xml = xml + "<" + colName + ">" + i + "</" + colName + ">";
            xml = xml + "<" + rsMD.getColumnName(1) + ">" + printOrder + "</" + rsMD.getColumnName(1) + ">";

            xml = xml + "</row>";

        }
        xml = xml + "</results>";

        return xml;
    }

    /*
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

    public String convertResultSetToXMLForPrintOrder(ResultSet result, int year, String journalName) throws SQLException
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
                    int printOrder = 0, annualPrintOrder = 0;

                    for(int monthID=1; monthID<=12; monthID++)
                    {
                        String sql = Queries.getQuery("get_printOrder");
                        PreparedStatement st = conn.prepareStatement(sql);
                        int paramIndex = 1;
                        st.setInt(paramIndex++, year);
                        st.setInt(paramIndex++, journalId);
                        st.setInt(paramIndex, monthID);
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

                        annualPrintOrder = annualPrintOrder + printOrder;

                        if(monthID == 1)
                        xml = xml + "<janPrintOrder>" + printOrder + "</janPrintOrder>";

                        if(monthID == 2)
                        xml = xml + "<febPrintOrder>" + printOrder + "</febPrintOrder>";

                        if(monthID == 3)
                        xml = xml + "<marPrintOrder>" + printOrder + "</marPrintOrder>";

                        if(monthID == 4)
                        xml = xml + "<aprPrintOrder>" + printOrder + "</aprPrintOrder>";

                        if(monthID == 5)
                        xml = xml + "<mayPrintOrder>" + printOrder + "</mayPrintOrder>";

                        if(monthID == 6)
                        xml = xml + "<junePrintOrder>" + printOrder + "</junePrintOrder>";

                        if(monthID == 7)
                        xml = xml + "<julyPrintOrder>" + printOrder + "</julyPrintOrder>";

                        if(monthID == 8)
                        xml = xml + "<augPrintOrder>" + printOrder + "</augPrintOrder>";

                        if(monthID == 9)
                        xml = xml + "<septPrintOrder>" + printOrder + "</septPrintOrder>";

                        if(monthID == 10)
                        xml = xml + "<octPrintOrder>" + printOrder + "</octPrintOrder>";

                        if(monthID == 11)
                        xml = xml + "<novPrintOrder>" + printOrder + "</novPrintOrder>";

                        if(monthID == 12)
                        xml = xml + "<decPrintOrder>" + printOrder + "</decPrintOrder>";

                    }
                    xml = xml + "<annualPrintOrder>" + printOrder + "</annualPrintOrder>";

                    xml = xml + "</row>";
                }
            }
            id++;
        }
        xml = xml + "</results>";

        return xml;
    }
    *
    */
}