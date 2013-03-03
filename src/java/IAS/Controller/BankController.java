/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Controller;

import IAS.Model.MasterDataModel;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;

/**
 *
 * @author smahapat
 */
public class BankController extends JDSController{

    private HttpServletRequest req;
    private HttpServletResponse resp;
    private ServletContext context;
    private String[] params;

    public BankController(HttpServletRequest req, HttpServletResponse resp, ServletContext context, String[] params) {
        this.req = req;
        this.resp = resp;
        this.context = context;
        this.params = params;
    }

    public void actionSearch() throws SQLException, ParserConfigurationException, TransformerException, IOException {
        String term = req.getParameter("term");
        MasterDataModel mm = new MasterDataModel();
        String xml = mm.searchBank(term);
        resp.setContentType("text/xml");
        resp.getWriter().write(xml);
    }
}
