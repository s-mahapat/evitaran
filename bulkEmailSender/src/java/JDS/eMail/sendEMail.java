package JDS.eMail;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import JDS.beans.ConnectionInfoBean;
import JDS.db.DriverUtilities;
import JDS.db.DriverUtilities2;
import com.mysql.jdbc.Connection;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.StringTokenizer;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author aloko
 */
public class sendEMail extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{

    String recipients = request.getParameter("emailid");
    String content = request.getParameter("content");
    String subject = request.getParameter("subject");
    String emailFromAddress = "JDS";

    response.setContentType("text/html;charset=UTF-8");
    PrintWriter out = response.getWriter();

    try
    {
        // TODO output your page here
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Servlet sendEMail</title>");
        out.println("</head>");
        out.println("<body>");

        out.println("<h1>Servlet sendEMail at " + request.getContextPath () + "</h1>");

        ServletContext context = getServletContext();
        String path = context.getRealPath("/WEB-INF/drivers.xml");
        String vendor = "MYSQL";
        DriverUtilities2.loadDrivers(path);
        if(!DriverUtilities.isValidVendor(vendor))
        {
            System.out.println("Vendor: " + vendor + " not supported" + "<br>");
        }
        else
        {
            String dbName = "bes";
            String host = "HCA-J83Q6BS";
            String driver = DriverUtilities.getDriver(vendor);
            String url = DriverUtilities2.makeURL(host, dbName, vendor);
            Connection connection = (Connection) ConnectionInfoBean.getConnection(driver, url, "root", "root");
            if(connection == null)
            {
                System.out.println("Cannot open connection to database " + dbName + " on host " + host + "<br>");
                System.out.println("Url: " + url);
            }
            else
            {
                String emailPropertiesFile = context.getRealPath("/WEB-INF/classes/jds_email.properties");
                //ArrayList recipientsArray = new ArrayList();
                // Set delimiters to a comma, quotes, semicolon, colon and space.
                // The default set of delimiters consists of the whitespace characters: space, tab, newline, and carriage return.
                StringTokenizer st = new StringTokenizer(recipients,",\";: ");
                int subjectID=0, messageTextID=0;
                boolean once=true;
                while (st.hasMoreElements()) {

                    //recipientsArray.add(st.nextToken());
                    String recipient = (String) st.nextElement();

                    long startTime = System.currentTimeMillis();
                    msgsend smtpMailSender = new msgsend();

                    String cc="", bcc="", file="";
                    smtpMailSender.sendMailWithAuthentication(emailPropertiesFile, recipient, cc, bcc, subject, content, emailFromAddress, file);

                    long stopTime = System.currentTimeMillis();
                    long elapsedTime = stopTime - startTime;
                    System.out.println(elapsedTime);
                    out.println("Time for sending email: " + Long.toString(elapsedTime) + "ms <br>");


                    emailUtilities eU = new emailUtilities();
                    if(once)
                    {
                        once = false;
                        subjectID = eU.saveSubjectToDB(connection, subject);
                        messageTextID = eU.saveMessageToDB(connection, content);
                    }
                    eU.saveMsgToDB(connection, recipient, subjectID, messageTextID, "1");

                    out.println("Send email to:" + recipient + "<br>");
                }
                out.println("Subject: " + subject + "<br>");
                out.println("Content of email is: " + content + "<br>");
            }
        }

        out.println("</body>");
        out.println("</html>");
    }
    catch (Exception e)
    {
        out.println(e.toString() + "<br>");
    }
    finally
    {
    }
}

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
