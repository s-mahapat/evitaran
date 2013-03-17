package IAS.Model.AgentProc;

import IAS.Class.Queries;
import IAS.Class.SubscriberInfo;
import IAS.Class.SubscriptionInfo;
import IAS.Model.JDSModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class agentProcModel extends JDSModel {

    public agentProcModel() throws SQLException {
    }

    public ArrayList getSubscriptionInfo(String inwardNumber) throws SQLException {
        String sql;
        ArrayList<SubscriptionInfo> listSubsriptionInfo = new ArrayList<>();
        Connection conn = this.getConnection();
        sql = Queries.getQuery("result_process_agent_inward");
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, inwardNumber);
        ResultSet rs;
        rs = pst.executeQuery();
        while (rs.next()) {
            SubscriberInfo oSubscriberInfo = new SubscriberInfo();
            SubscriptionInfo oSubscriptionInfo = new SubscriptionInfo();
            oSubscriberInfo.setSubscriberNumber(rs.getString("subscriberNumber"));
            oSubscriptionInfo.setSubscriberInfo(oSubscriberInfo);
            oSubscriptionInfo.setSubscriptionNumber(rs.getInt("subscriptionNumber"));
            listSubsriptionInfo.add(oSubscriptionInfo);
        }
        return listSubsriptionInfo;
    }
}
