package com.fz.mail;

import com.fz.vo.UserVo;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import java.io.File;
import java.util.Properties;

public class SendMain {
    public static void sendEmail(Mail mail, UserVo userVo) throws  Exception{
        //读取配置文件
        //String path = session1.getServletContext().getRealPath("/WEB-INF/classes/config/mail.properties");
        Properties properties = new Properties();
        properties.put("mail.transport.protocol", "smtp");
        properties.put("mail.smtp.host", userVo.getServerHost());
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.ssl.enable", "true");
        properties.put("mail.smtp.port",userVo.getServerPort());
        //设置邮箱的发送者
        mail.setEmailName(userVo.getEmail());
        //验证身份，和密码
        Session session = Session.getInstance(properties,new MailAuthenticator(userVo.getEmail(),userVo.getPassword()));
        //实例化一个消息类
        Message message = new MimeMessage(session);
        //设置消息的主题
        message.setSubject(mail.getSubject());
        //设置消息的放松这
        message.setFrom(mail.getEmailName());
        //发送邮箱的内容，并发送附件
        Multipart multipart = new MimeMultipart();
        BodyPart bodyPart = new MimeBodyPart();
        bodyPart.setContent(mail.getContent(), "text/html;charset=utf-8");
        multipart.addBodyPart(bodyPart);
        if(mail.getFilePath()!=null)
            for (String str: mail.getFilePath()) {
                File usFile = new File(str);
                MimeBodyPart fileBody = new MimeBodyPart();
                DataSource source = new FileDataSource(str);
                fileBody.setDataHandler(new DataHandler(source));
                sun.misc.BASE64Encoder enc = new sun.misc.BASE64Encoder();
                fileBody.setFileName("=?GBK?B?"
                        + enc.encode(usFile.getName().getBytes()) + "?=");
                multipart.addBodyPart(fileBody);
            }
        //设置邮箱的内容
        message.setContent(multipart);
        //调用邮箱发送的函数
        message.setRecipients(Message.RecipientType.TO, mail.getToEmilName());
        //设置抄送人
        if(mail.getCc()!=null){
            message.setRecipients(Message.RecipientType.CC, mail.getCc());
        }
        //设置密送人
        if(mail.getBcc()!=null){
            message.setRecipients(Message.RecipientType.BCC, mail.getBcc());
        }
        //邮件输送连接
        Transport.send(message);
    }
}
