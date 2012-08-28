/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model;

import IAS.Class.Database;
import IAS.Class.Queries;
import IAS.Class.util;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;

/**
 *
 * @author Newton
 */
public class MasterDataModel extends JDSModel {

    private Connection _conn;
    public MasterDataModel() throws SQLException {
        this._conn = Database.getConnection();
    }

    public String getMasterData(String mdataRequested, String mdataReqValue,
            String[] optionalParam) throws SQLException, ParserConfigurationException,
            TransformerException   {
        String xml;
        try (PreparedStatement ps = this._conn.prepareStatement(Queries.getQuery(mdataRequested))) {
            if (mdataReqValue != null) {
                //PreparedStatement ps = conn.prepareStatement(Queries.getQuery(mdataRequested));
                ps.setString(1, mdataReqValue);

                if (optionalParam != null) {
                    for (int i = 0, j = 2; i < optionalParam.length; i++) {
                        ps.setInt(j++, Integer.parseInt(optionalParam[i]));
                    }
                }
            }
            try (ResultSet rs = ps.executeQuery()) {
                xml = util.convertResultSetToXML(rs);
            }
        }
        this._conn.close();
        return xml;
    }
}
