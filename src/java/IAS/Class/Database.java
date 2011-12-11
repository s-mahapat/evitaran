/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;
import javax.servlet.*;
import java.sql.*;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

public class Database implements HttpSessionBindingListener{

    ServletContext context;
    private Connection connection = null;

    public Database(){

    }

    public Database(Connection conn,ServletContext context){
        this.connection = conn;
        this.context = context;
    }

    public void setConnection(Connection conn){
        this.connection = conn;
    }

    @Override
    public void valueUnbound(HttpSessionBindingEvent e){

        try{
            if(connection != null){
                connection.rollback();
                connection.close();
            }
        }catch(SQLException ex){

        }
    }

    @Override
    public void valueBound(HttpSessionBindingEvent e){
        context.log("Session Bound event");
    }



    public Connection getConnection(){
        return connection;
    }

    public ResultSet executeQuery(String query) {
        PreparedStatement st = null;
        ResultSet rs = null;
        try{

            st = connection.prepareStatement(query);
            rs = st.executeQuery();

        }catch(SQLException e){

        }finally{
            if(st == null)
                return null;
            else
                return rs;
        }


    }

    public int executeUpdate(String statement){

        PreparedStatement st = null;
        int rs = 0;
        try{

            st = connection.prepareStatement(statement);
            rs = st.executeUpdate();

        }catch(SQLException e){

        }finally{
            if(st == null)
                return -1;
            else
                return rs;
        }
    }

    public void close() {
        try {
            connection.close();
        } catch (SQLException sqlException) {
            //sqlException.printStackTrace();
            connection = null;
        }
    }

    @Override
    protected void finalize() {
        try{
            super.finalize();
        }catch(java.lang.Throwable e){

        }
        close();
    }
}
