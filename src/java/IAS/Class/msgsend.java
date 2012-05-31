package IAS.Class;

/**
 *
 * @author aloko Using sample code from msgSend.java. This example is part of
 * the javamail package For sending mail using authentication:
 * http://dunithd.wordpress.com/2009/10/22/send-email-using-javamail-api-and-your-gmail-account/
 * http://www.vipan.com/htdocs/javamail.html
 */
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Date;
import java.util.Properties;
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

    public void sendExceptionMail(String exceptionMsg) throws IOException {
        ServletContext context = ServletContextInfo.getServletContext();
        String emailPropertiesFile = context.getRealPath("/WEB-INF/classes/jds_email.properties");
        //String from           = properties.getProperty("FROM");
        this.sendMailWithAuthenticationUseSSL(
                emailPropertiesFile, "jds.adm.all@gmail.com", "", "", "Exception generated in JDS code",
                exceptionMsg, "JDS", "");
    }

    public boolean sendEmailToSubscriberWithAttachment( String SubscriberEmail, String Subject, 
                                                        String body, String FileName,
                                                        byte[] attachment, String attachmentType) throws IOException {
        ServletContext context = ServletContextInfo.getServletContext();
        String emailPropertiesFile = context.getRealPath("/WEB-INF/classes/jds_email.properties");
        final Email email = new Email();
        email.setFromAddress("Indian Academy Of Sciences", "jds.adm.all@gmail.com");
        email.setSubject(Subject);
        email.addRecipient(SubscriberEmail, SubscriberEmail, RecipientType.TO);
        email.setText(body);
        email.addAttachment(FileName, attachment, attachmentType);
        Properties properties = new Properties();
        properties.load(new FileInputStream(emailPropertiesFile));
        String SMTP_HOST_NAME = properties.getProperty("SMTP_HOST_NAME");
        String SMTP_AUTH_USER = properties.getProperty("SMTP_AUTH_USER");
        String SMTP_AUTH_PWD = properties.getProperty("SMTP_AUTH_PWD");
        try{
            new Mailer(SMTP_HOST_NAME, 25, SMTP_AUTH_USER, SMTP_AUTH_PWD, TransportStrategy.SMTP_TLS).sendMail(email);
            return true;
        }catch(Exception e){
            return false;
        }

    }

    // This can be used for gmail
    public boolean sendMailWithAuthenticationUseSSL(String propertiesFile, String to, String cc, String bcc, String subject,
            String msg, String from, String file) {
        try {
            // Read properties file.
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
                message.setFrom();
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

                mbp2.attachFile(file);
                MimeMultipart mp = new MimeMultipart();
                mp.addBodyPart(mbp1);
                mp.addBodyPart(mbp2);
                message.setContent(mp);
            } else {
                // This will send messages as text
                //message.setContent(msg, "text/plain");  // Setting the content type
                // To send html links in mail
                message.setText(msg, "UTF-8", "html");
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

    // Even this method can be used for gmail
    public boolean sendMailWithAuthenticationUseTLS(String propertiesFile, String to, String cc, String bcc, String subject,
            String msg, String from, String file) throws MessagingException, IOException {
        try {
            // Read properties file.
            Properties properties = new Properties();
            properties.load(new FileInputStream(propertiesFile));
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
                message.setFrom();
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
                mbp2.attachFile(file);
                MimeMultipart mp = new MimeMultipart();
                mp.addBodyPart(mbp1);
                mp.addBodyPart(mbp2);
                message.setContent(mp);
            } else {
                // This will send messages as text
                message.setContent(msg, "text/plain");  // Setting the content type
                // To send html links in mail
                // message.setText(msg, "UTF-8", "html");
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
    public boolean sendMailWithoutAuthentication(String propertiesFile, String to, String cc, String bcc, String subject,
            String msg, String from, String file) throws MessagingException, IOException {
        try {
            Properties properties = new Properties();
            properties.load(new FileInputStream(propertiesFile));

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
                message.setFrom();
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
                mbp2.attachFile(file);
                MimeMultipart mp = new MimeMultipart();
                mp.addBodyPart(mbp1);
                mp.addBodyPart(mbp2);
                message.setContent(mp);
            } else {
                // If the desired charset is known, you can use
                // setText(text, charset)
                //message.setText(msg);
                // This will send messages as text
                message.setContent(msg, "text/plain");  // Setting the content type
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
    public boolean sendMailWithAuthenticationNoSSLNoTLS(String propertiesFile, String to, String cc, String bcc, String subject,
            String msg, String from, String file) throws IOException, MessagingException {
        try {
            // Read properties file.
            Properties properties = new Properties();
            properties.load(new FileInputStream(propertiesFile));

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
                message.setFrom();
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
                mbp2.attachFile(file);
                MimeMultipart mp = new MimeMultipart();
                mp.addBodyPart(mbp1);
                mp.addBodyPart(mbp2);
                message.setContent(mp);
            } else {
                // This will send messages as text
                //message.setContent(msg, "text/plain");  // Setting the content type
                // To send html links in mail
                message.setText(msg, "UTF-8", "html");
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
}
