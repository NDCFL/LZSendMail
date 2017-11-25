package com.fz.mail;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

/**
 * Created by Administrator on 2017/9/22.
 */
public class SendEmail  {

    public static void sendEmail() throws  Exception{
        Properties properties = SendMailUtil.getEmailInfo("src/main/resources/config/mail.properties");
        Session session = Session.getInstance(properties,new MailAuthenticator(SendMailUtil.getString("emailName"),SendMailUtil.getString("passWord")));
        System.out.println(SendMailUtil.getString("emailName")+"=====");
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(SendMailUtil.getString("emailName")));
        message.setSubject("每天的心情");
        message.setContent("今天心情不好！","text/plain;charset=utf-8");
        message.setReplyTo(new InternetAddress[]{new InternetAddress("xljx_888888@163.com")});
        Transport transport = session.getTransport();
        transport.connect();
        transport.sendMessage(message,message.getReplyTo());
    }
    public static void main(String...arg){
        try {
           sendEmail();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
