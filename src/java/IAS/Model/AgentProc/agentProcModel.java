package IAS.Model.AgentProc;

import IAS.Class.JDSLogger;
import IAS.Class.Queries;
import IAS.Class.SubscriberInfo;
import IAS.Class.SubscriptionInfo;
import IAS.Model.JDSModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.apache.log4j.Logger;

public class agentProcModel extends JDSModel {

    private static Logger logger = JDSLogger.getJDSLogger(agentProcModel.class.getName());

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

    /*
     * Gets the discount for an agent
     */
    public float getDiscount(int agent_id) throws SQLException{
        float discount = 0;
        String sql = Queries.getQuery("get_agent_discount");
        Connection conn = this.getConnection();
        try(PreparedStatement pst = conn.prepareStatement(sql)){
            pst.setInt(1, agent_id);
            try(ResultSet rs = pst.executeQuery()){
                if(rs.first()){
                    discount = rs.getFloat("discount");
                }
            }
        }catch(SQLException ex){
            logger.error(ex);
        }finally{
            conn.close();
            return discount;
        }

    }

    public List searchAgent(String agent_name) throws SQLException{

        ArrayList<String> agents = new ArrayList<>();
        String sql = Queries.getQuery("search_agent");
        Connection conn = this.getConnection();
        try(PreparedStatement pst = conn.prepareStatement(sql)){
            pst.setString(1, agent_name + "%");
            try(ResultSet rs = pst.executeQuery()){
                while(rs.next()){
                    agents.add(rs.getString("agentName"));
                }
            }
        }catch(SQLException ex){
            logger.error(ex);
        }finally{
            conn.close();
            return agents;
        }

    }
}
