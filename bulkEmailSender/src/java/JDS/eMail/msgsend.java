package JDS.eMail;

/**
 *
 * @author aloko
 * Using sample code from msgSend.java. This example is part of the javamail package
 * For sending mail using authentication: http://dunithd.wordpress.com/2009/10/22/send-email-using-javamail-api-and-your-gmail-account/
 */
import java.io.FileInputStream;
import java.io.IOException;
import java.util.*;

import javax.mail.*;
import javax.mail.internet.*;

public class msgsend
{

    public void sendMailWithoutAuthentication(String propertiesFile, String to, String cc, String bcc, String subject,
                            String message, String from, String file) throws MessagingException, IOException
    {
        Properties properties = new Properties();
        properties.load(new FileInputStream(propertiesFile));
        String SMTP_HOST_NAME = properties.getProperty("SMTP_HOST_NAME");
        String mail_debug     = properties.getProperty("mail.debug");
        String session_debug  = properties.getProperty("session.debug");

        // Initialize the JavaMail Session.
        Properties props = System.getProperties();
        // XXX - could use Session.getTransport() and Transport.connect()
        // XXX - assume we're using SMTP
        props.put("mail.smtp.host", SMTP_HOST_NAME);
        props.put("mail.debug", mail_debug);

        // Get a Session object
        Session session = Session.getInstance(props, null);
        if (session_debug.equals("true"))
        session.setDebug(true);

        // Construct the message and send it.
        Message msg = new MimeMessage(session);
        if (!from.isEmpty())
            msg.setFrom(new InternetAddress(from));
        else
            msg.setFrom();

        if (!to.isEmpty())
        msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));

        if (!cc.isEmpty())
        msg.setRecipients(Message.RecipientType.CC, InternetAddress.parse(cc, false));

        if (!bcc.isEmpty())
        msg.setRecipients(Message.RecipientType.BCC, InternetAddress.parse(bcc, false));

        msg.setSubject(subject);

        if (!file.isEmpty())
        {
            // Attach the specified file.
            // We need a multipart message to hold the attachment.
            MimeBodyPart mbp1 = new MimeBodyPart();
            mbp1.setText(message);
            MimeBodyPart mbp2 = new MimeBodyPart();
            mbp2.attachFile(file);
            MimeMultipart mp = new MimeMultipart();
            mp.addBodyPart(mbp1);
            mp.addBodyPart(mbp2);
            msg.setContent(mp);
        }
        else
        {
            // If the desired charset is known, you can use
            // setText(text, charset)
            msg.setText(message);
        }

        msg.setHeader("X-Mailer", "msgSend");
        msg.setSentDate(new Date());

        // send the thing off
        Transport.send(msg);

    }

    public void sendMailWithAuthentication(String propertiesFile, String to, String cc, String bcc, String subject,
                            String msg, String from, String file) throws IOException, MessagingException
    {
        // Read properties file.
        Properties properties = new Properties();
        properties.load(new FileInputStream(propertiesFile));
        String SMTP_HOST_NAME = properties.getProperty("SMTP_HOST_NAME");
        String SMTP_AUTH_USER = properties.getProperty("SMTP_AUTH_USER");
        String SMTP_AUTH_PWD  = properties.getProperty("SMTP_AUTH_PWD");
        String PORTFORSSL     = properties.getProperty("PORTFORSSL");
        String STARTTLS       = properties.getProperty("STARTTLS");
        String AUTH           = properties.getProperty("AUTH");
        String SOCKET_FACTORY = properties.getProperty("SOCKET_FACTORY");
        String mail_debug     = properties.getProperty("mail.debug");
        String session_debug  = properties.getProperty("session.debug");


        //Use Properties object to set environment properties
        Properties props = new Properties();
        props.put("mail.smtp.host", SMTP_HOST_NAME);
        props.put("mail.smtp.port", PORTFORSSL);
        props.put("mail.smtp.user", SMTP_AUTH_USER);
        props.put("mail.smtp.auth", AUTH);
        // Most SMTP servers support SSL (Secure Socket Layer) connections which can be used for secure login to the server.
        // They use STARTTLS command (see RFC 2487 and RFC 3501) to switch the connection to be secured by TLS.
        // Use of the STARTTLS command is preferred in cases where the server supports both SSL and non-SSL connections.
        props.put("mail.smtp.starttls.enable", STARTTLS);
        props.put("mail.smtp.debug", mail_debug);
        props.put("mail.smtp.socketFactory.port", PORTFORSSL);
        props.put("mail.smtp.socketFactory.class", SOCKET_FACTORY);
        props.put("mail.smtp.socketFactory.fallback", "false");

        //Obtain the default mail session
        Session session = Session.getDefaultInstance(props, null);
        if (session_debug.equals("true"))
        session.setDebug(true);

        //Construct the mail message
        MimeMessage message = new MimeMessage(session);

        if(!from.isEmpty())
            message.setFrom(new InternetAddress(from));
        else
            message.setFrom();

        if (!to.isEmpty())
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
        // To send mail to multiple people, comma separated
        // message.addRecipients(RecipientType.TO, TO);
        // Parse a comma-separated list of email addresses. Be strict.
        if (!cc.isEmpty())
        message.setRecipients(Message.RecipientType.CC, InternetAddress.parse(cc, false));
        // Parse comma/space-separated list. Cut some slack.
        if (!bcc.isEmpty())
        message.setRecipients(Message.RecipientType.BCC, InternetAddress.parse(bcc, false));

        message.setSubject(subject);            // Setting the Subject

        if (!file.isEmpty())
        {
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
        }
        else
        {
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

    }
}
