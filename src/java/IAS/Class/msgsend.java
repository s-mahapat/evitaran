package IAS.Class;

/**
 *
 * @author aloko Using sample code from msgSend.java. This example is part of
 * the javamail package For sending mail using authentication:
 * http://dunithd.wordpress.com/2009/10/22/send-email-using-javamail-api-and-your-gmail-account/
 * http://www.vipan.com/htdocs/javamail.html
 * If the datasource is not null, then the datasource will be used to get the data and
 * the data will be send as attachment with the name "fileName". No file is written to the disk
 * If datasource is null, then the file "fileName" will be attached with the mail if fileName is not null or empty.
 *
 * jds.adm.all@gmail.com: This account is used to collect all the exception messages
 * jds.ias.mails@gmail.com: This account is used to collect all the mails which are sent by IAS. All mails to this account are sent as bcc
 */
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Date;
import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.mail.Message;
import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.ServletContext;
import org.apache.log4j.Logger;
import org.codemonkey.simplejavamail.Email;
import org.codemonkey.simplejavamail.Mailer;
import org.codemonkey.simplejavamail.TransportStrategy;

public class msgsend {

    private static final Logger logger = JDSLogger.getJDSLogger("IAS.Class.msgsend");
    private String contentType = "text/plain";

    public msgsend() {

    }

    public msgsend(String _contentType){
        contentType = _contentType;
    }

    public String getPropertiesFileLocation()
    {
        ServletContext context = ServletContextInfo.getServletContext();
        return context.getRealPath("/WEB-INF/classes/jds_email.properties");
    }

    public void sendExceptionMail(String exceptionMsg) throws IOException {
        //String from           = properties.getProperty("FROM");
        this.sendMailWithAuthenticationUseSSL(
                "jds.adm.all@gmail.com", "", "", "Exception generated in JDS code",
                exceptionMsg, "", "", null);
    }

    public boolean sendEmailToSubscriberWithAttachment( String SubscriberEmail, String Subject,
                                                        String body, String FileName,
                                                        byte[] attachment, String attachmentType) throws IOException {
        String emailPropertiesFile = getPropertiesFileLocation();
        Properties properties = new Properties();
        properties.load(new FileInputStream(emailPropertiesFile));
        final Email email = new Email();
        email.setFromAddress(properties.getProperty("FROM_TEXT"), properties.getProperty("FROM_EMAIL_ID"));
        email.setSubject(Subject);
        email.addRecipient(SubscriberEmail, SubscriberEmail, RecipientType.TO);
        email.addRecipient("IAS", "jds.ias.mails@gmail.com", RecipientType.BCC);
        email.setText(body);

        // check if there is any attachment to be sent, else just ignore
        if(FileName != null && attachment != null && attachmentType != null){
            email.addAttachment(FileName, attachment, attachmentType);
        }

        String SMTP_HOST_NAME = properties.getProperty("SMTP_HOST_NAME");
        String SMTP_AUTH_USER = properties.getProperty("SMTP_AUTH_USER");
        String SMTP_AUTH_PWD = properties.getProperty("SMTP_AUTH_PWD");

        try{
            Mailer _mailer = new Mailer(SMTP_HOST_NAME, 25, SMTP_AUTH_USER, SMTP_AUTH_PWD, TransportStrategy.SMTP_TLS);
            _mailer.validate(email);
            _mailer.sendMail(email);
            return true;
        }catch(Exception e){
            return false;
        }

    }


    // This can be used for gmail
    public boolean sendMailWithAuthenticationUseSSL(String to, String cc, String bcc, String subject,
            String msg, String from, String file, DataSource dataSource) {
        try {
            // Read properties file.
            String propertiesFile = getPropertiesFileLocation();
            Properties properties = new Properties();
            properties.load(new FileInputStream(propertiesFile));
            String SMTP_HOST_NAME = properties.getProperty("SMTP_HOST_NAME");
            String SMTP_AUTH_USER = properties.getProperty("SMTP_AUTH_USER");
            String SMTP_AUTH_PWD = properties.getProperty("SMTP_AUTH_PWD");
            String PORTFORSSL = properties.getProperty("PORTFORSSL");
            //String STARTTLS       = properties.getProperty("STARTTLS");
            String AUTH = properties.getProperty("AUTH");
            String SOCKET_FACTORY = properties.getProperty("SOCKET_FACTORY");
            String mail_debug = properties.getProperty("mail.debug");
            String session_debug = properties.getProperty("session.debug");

            //Use Properties object to set environment properties
            Properties props = new Properties();
            props.put("mail.smtp.host", SMTP_HOST_NAME);
            props.put("mail.smtp.port", PORTFORSSL);
            props.put("mail.smtp.user", SMTP_AUTH_USER);
            props.put("mail.smtp.auth", AUTH);
            // Most SMTP servers support SSL (Secure Socket Layer) connections which can be used for secure login to the server.
            // They use STARTTLS command (see RFC 2487 and RFC 3501) to switch the connection to be secured by TLS.
            // Use of the STARTTLS command is preferred in cases where the server supports both SSL and non-SSL connections.
            //props.put("mail.smtp.starttls.enable", STARTTLS);
            props.put("mail.smtp.debug", mail_debug);
            props.put("mail.smtp.socketFactory.port", PORTFORSSL);
            props.put("mail.smtp.socketFactory.class", SOCKET_FACTORY);
            props.put("mail.smtp.socketFactory.fallback", "false");

            //Obtain the default mail session
            Session session = Session.getDefaultInstance(props, null);
            if (session_debug.equals("true")) {
                session.setDebug(true);
            }

            //Construct the mail message
            MimeMessage message = new MimeMessage(session);

            if (!from.isEmpty()) {
                message.setFrom(new InternetAddress(from));
            } else {
                InternetAddress addressFrom = new InternetAddress(properties.getProperty("FROM_EMAIL_ID"), properties.getProperty("FROM_TEXT"));
                message.setFrom(addressFrom);
            }

            if (!to.isEmpty()) {
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            }
            // To send mail to multiple people, comma separated
            // message.addRecipients(RecipientType.TO, TO);
            // Parse a comma-separated list of email addresses. Be strict.
            if (!cc.isEmpty()) {
                message.setRecipients(Message.RecipientType.CC, InternetAddress.parse(cc, false));
            }
            // Parse comma/space-separated list. Cut some slack.
            if (!bcc.isEmpty()) {
                message.setRecipients(Message.RecipientType.BCC, InternetAddress.parse(bcc, false));
            }

            message.setSubject(subject);            // Setting the Subject

            if (!file.isEmpty()) {
                // Attach the specified file.
                // We need a multipart message to hold the attachment.
                MimeBodyPart mbp1 = new MimeBodyPart();
                mbp1.setText(msg);
                MimeBodyPart mbp2 = new MimeBodyPart();
                if(dataSource != null)
                {
                    mbp2.setDataHandler(new DataHandler(dataSource));
                    mbp2.setFileName(file);
                }
                else {
                    mbp2.attachFile(file);
                }
                MimeMultipart mp = new MimeMultipart();
                mp.addBodyPart(mbp1);
                mp.addBodyPart(mbp2);
                message.setContent(mp);
            } else {
                // This will send messages as text
                //message.setContent(msg, "text/html");  // Setting the content type
                //message.setContent(msg, "text/html");  // Setting the content type
                message.setContent(msg, contentType);
                // To send html links in mail
                //message.setText(msg, "text/plain; charset=utf-8");
            }

            message.setHeader("X-Mailer", "msgSend");
            message.setSentDate(new Date());

            message.saveChanges();

            //Use Transport to deliver the message
            Transport transport = session.getTransport("smtp");
            transport.connect(SMTP_HOST_NAME, SMTP_AUTH_USER, SMTP_AUTH_PWD);
            transport.sendMessage(message, message.getAllRecipients());
            transport.close();
        } catch (IOException | MessagingException ex) {
            return false;
        }
        return true;
    }

    // Even this method can be used for gmail, this is even secure
    public boolean sendMailWithAuthenticationUseTLS(String to, String cc, String bcc, String subject,
            String msg, String from, String file, DataSource dataSource) {
        try {
            // Read properties file.
            String emailPropertiesFile = getPropertiesFileLocation();
            Properties properties = new Properties();
            properties.load(new FileInputStream(emailPropertiesFile));
            String SMTP_HOST_NAME = properties.getProperty("SMTP_HOST_NAME");
            String SMTP_AUTH_USER = properties.getProperty("SMTP_AUTH_USER");
            String SMTP_AUTH_PWD = properties.getProperty("SMTP_AUTH_PWD");
            String PORTFOR_TLS_STARTTLS = properties.getProperty("PORTFOR_TLS_STARTTLS");
            String STARTTLS = properties.getProperty("STARTTLS");

            String AUTH = properties.getProperty("AUTH");
            String SOCKET_FACTORY = properties.getProperty("SOCKET_FACTORY");
            String mail_debug = properties.getProperty("mail.debug");
            String session_debug = properties.getProperty("session.debug");


            //Use Properties object to set environment properties
            Properties props = new Properties();
            props.put("mail.smtp.host", SMTP_HOST_NAME);
            props.put("mail.smtp.port", PORTFOR_TLS_STARTTLS);
            props.put("mail.smtp.user", SMTP_AUTH_USER);
            props.put("mail.smtp.auth", AUTH);
            // Most SMTP servers support SSL (Secure Socket Layer) connections which can be used for secure login to the server.
            // They use STARTTLS command (see RFC 2487 and RFC 3501) to switch the connection to be secured by TLS.
            // Use of the STARTTLS command is preferred in cases where the server supports both SSL and non-SSL connections.
            props.put("mail.smtp.starttls.enable", STARTTLS);
            props.put("mail.smtp.debug", mail_debug);
            //props.put("mail.smtp.socketFactory.port", PORTFORSSL);
            //props.put("mail.smtp.socketFactory.class", SOCKET_FACTORY);
            //props.put("mail.smtp.socketFactory.fallback", "false");

            //Obtain the default mail session
            Session session = Session.getDefaultInstance(props, null);
            if (session_debug.equals("true")) {
                session.setDebug(true);
            }

            //Construct the mail message
            MimeMessage message = new MimeMessage(session);

            if (!from.isEmpty()) {
                message.setFrom(new InternetAddress(from));
            } else {
                InternetAddress addressFrom = new InternetAddress(properties.getProperty("FROM_EMAIL_ID"), properties.getProperty("FROM_TEXT"));
                message.setFrom(addressFrom);
            }

            if (!to.isEmpty()) {
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            }
            // To send mail to multiple people, comma separated
            // message.addRecipients(RecipientType.TO, TO);
            // Parse a comma-separated list of email addresses. Be strict.
            if (!cc.isEmpty()) {
                message.setRecipients(Message.RecipientType.CC, InternetAddress.parse(cc, false));
            }
            // Parse comma/space-separated list. Cut some slack.
            if (!bcc.isEmpty()) {
                message.setRecipients(Message.RecipientType.BCC, InternetAddress.parse(bcc, false));
            }

            message.setSubject(subject);            // Setting the Subject

            if (!file.isEmpty()) {
                // Attach the specified file.
                // We need a multipart message to hold the attachment.
                MimeBodyPart mbp1 = new MimeBodyPart();
                mbp1.setText(msg);
                MimeBodyPart mbp2 = new MimeBodyPart();
                if(dataSource != null)
                {
                    mbp2.setDataHandler(new DataHandler(dataSource));
                    mbp2.setFileName(file);
                }
                else {
                    mbp2.attachFile(file);
                }
                MimeMultipart mp = new MimeMultipart();
                mp.addBodyPart(mbp1);
                mp.addBodyPart(mbp2);
                message.setContent(mp);
            } else {
                // This will send messages as text
                //message.setContent(msg, "text/html");  // Setting the content type
                message.setContent(msg, contentType);
                // To send html links in mail
                //message.setText(msg, "UTF-8", "html");
            }

            message.setHeader("X-Mailer", "msgSend");
            message.setSentDate(new Date());

            message.saveChanges();

            //Use Transport to deliver the message
            Transport transport = session.getTransport("smtp");
            transport.connect(SMTP_HOST_NAME, SMTP_AUTH_USER, SMTP_AUTH_PWD);
            transport.sendMessage(message, message.getAllRecipients());
            transport.close();
        } catch (IOException | MessagingException ex) {
            return false;
        }
        return true;
    }

    // Servers that do not require any authentication. This should be used for sending emails from IAS
    public boolean sendMailWithoutAuthentication(String to, String cc, String bcc, String subject,
            String msg, String from, String file, DataSource dataSource)  {
        try {
            String emailPropertiesFile = getPropertiesFileLocation();
            Properties properties = new Properties();
            properties.load(new FileInputStream(emailPropertiesFile));

            String SMTP_HOST_NAME = properties.getProperty("SMTP_HOST_NAME");
            String mail_debug = properties.getProperty("mail.debug");
            String session_debug = properties.getProperty("session.debug");

            // Initialize the JavaMail Session.
            Properties props = System.getProperties();
            // XXX - could use Session.getTransport() and Transport.connect()
            // XXX - assume we're using SMTP
            props.put("mail.smtp.host", SMTP_HOST_NAME);
            props.put("mail.debug", mail_debug);

            // Get a Session object
            Session session = Session.getInstance(props, null);
            if (session_debug.equals("true")) {
                session.setDebug(true);
            }

            // Construct the message and send it.
            Message message = new MimeMessage(session);
            if (!from.isEmpty()) {
                message.setFrom(new InternetAddress(from));
            } else {
                InternetAddress addressFrom = new InternetAddress(properties.getProperty("FROM_EMAIL_ID"), properties.getProperty("FROM_TEXT"));
                message.setFrom(addressFrom);
            }

            if (!to.isEmpty()) {
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            }

            if (!cc.isEmpty()) {
                message.setRecipients(Message.RecipientType.CC, InternetAddress.parse(cc, false));
            }

            if (!bcc.isEmpty()) {
                message.setRecipients(Message.RecipientType.BCC, InternetAddress.parse(bcc, false));
            }

            message.setSubject(subject);

            if (!file.isEmpty()) {
                // Attach the specified file.
                // We need a multipart message to hold the attachment.
                MimeBodyPart mbp1 = new MimeBodyPart();
                mbp1.setText(msg);
                MimeBodyPart mbp2 = new MimeBodyPart();
                if(dataSource != null)
                {
                    mbp2.setDataHandler(new DataHandler(dataSource));
                    mbp2.setFileName(file);
                }
                else {
                    mbp2.attachFile(file);
                }
                MimeMultipart mp = new MimeMultipart();
                mp.addBodyPart(mbp1);
                mp.addBodyPart(mbp2);
                message.setContent(mp);
            } else {
                // If the desired charset is known, you can use
                // setText(text, charset)
                //message.setText(msg);
                // This will send messages as text
                //message.setContent(msg, "text/html");  // Setting the content type
                message.setContent(msg, contentType);
                // To send html links in mail
                //message.setText(msg, "UTF-8", "html");
            }

            message.setHeader("X-Mailer", "msgSend");
            message.setSentDate(new Date());

            // send the thing off
            Transport.send(message);
        } catch (IOException | MessagingException ex) {
            return false;
        }
        return true;

    }

    // For corporate email which require authentication but no SSL or TTLS required
    public boolean sendMailWithAuthenticationNoSSLNoTLS(String to, String cc, String bcc, String subject,
            String msg, String from, String file, DataSource dataSource)  {
        try {
            // Read properties file.
            String emailPropertiesFile = getPropertiesFileLocation();
            Properties properties = new Properties();
            properties.load(new FileInputStream(emailPropertiesFile));

            String SMTP_HOST_NAME = properties.getProperty("SMTP_HOST_NAME");
            String SMTP_AUTH_USER = properties.getProperty("SMTP_AUTH_USER");
            String SMTP_AUTH_PWD = properties.getProperty("SMTP_AUTH_PWD");
            String AUTH = properties.getProperty("AUTH");
            String mail_debug = properties.getProperty("mail.debug");
            String session_debug = properties.getProperty("session.debug");

            //Use Properties object to set environment properties
            Properties props = new Properties();
            props.put("mail.smtp.host", SMTP_HOST_NAME);
            props.put("mail.smtp.user", SMTP_AUTH_USER);
            props.put("mail.smtp.auth", AUTH);
            props.put("mail.smtp.debug", mail_debug);

            //Obtain the default mail session
            Session session = Session.getDefaultInstance(props, null);
            if (session_debug.equals("true")) {
                session.setDebug(true);
            }

            //Construct the mail message
            MimeMessage message = new MimeMessage(session);

            if (!from.isEmpty()) {
                message.setFrom(new InternetAddress(from));
            } else {
                InternetAddress addressFrom = new InternetAddress(properties.getProperty("FROM_EMAIL_ID"), properties.getProperty("FROM_TEXT"));
                message.setFrom(addressFrom);
            }

            if (!to.isEmpty()) {
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            }
            // To send mail to multiple people, comma separated
            // message.addRecipients(RecipientType.TO, TO);
            // Parse a comma-separated list of email addresses. Be strict.
            if (!cc.isEmpty()) {
                message.setRecipients(Message.RecipientType.CC, InternetAddress.parse(cc, false));
            }
            // Parse comma/space-separated list. Cut some slack.
            if (!bcc.isEmpty()) {
                message.setRecipients(Message.RecipientType.BCC, InternetAddress.parse(bcc, false));
            }

            message.setSubject(subject);            // Setting the Subject

            if (!file.isEmpty()) {
                // Attach the specified file.
                // We need a multipart message to hold the attachment.
                MimeBodyPart mbp1 = new MimeBodyPart();
                mbp1.setText(msg);
                MimeBodyPart mbp2 = new MimeBodyPart();
                if(dataSource != null)
                {
                    mbp2.setDataHandler(new DataHandler(dataSource));
                    mbp2.setFileName(file);
                }
                else {
                    mbp2.attachFile(file);
                }
                MimeMultipart mp = new MimeMultipart();
                mp.addBodyPart(mbp1);
                mp.addBodyPart(mbp2);
                message.setContent(mp);
            } else {
                // This will send messages as text
                //message.setContent(msg, "text/plain");  // Setting the content type
                // To send html links in mail
                //message.setText(msg, "text/html");
                message.setContent(msg, contentType);
            }

            message.setHeader("X-Mailer", "msgSend");
            message.setSentDate(new Date());

            message.saveChanges();

            //Use Transport to deliver the message
            Transport transport = session.getTransport("smtp");
            transport.connect(SMTP_HOST_NAME, SMTP_AUTH_USER, SMTP_AUTH_PWD);
            transport.sendMessage(message, message.getAllRecipients());
            transport.close();
        } catch (IOException | MessagingException ex) {
            return false;
        }
        return true;

    }

    // IAS mails do not require authentication
    public boolean sendMail(String to, String cc, String bcc, String subject,
                String msg, String from, String file, DataSource dataSource){

        try {

            String emailPropertiesFile = getPropertiesFileLocation();
            Properties properties = new Properties();
            properties.load(new FileInputStream(emailPropertiesFile));
            String AUTH = properties.getProperty("AUTH");

            if(AUTH.equalsIgnoreCase("true")){
                boolean status = this.sendMailWithAuthenticationUseTLS(to, cc, bcc, subject, msg, from, file, dataSource);
                return status;
            }else {
                boolean status = this.sendMailWithoutAuthentication(to, cc, bcc, subject, msg, from, file, dataSource);
                return status;
            }
        }catch(Exception ex) {
            return false;
        }
    }
}