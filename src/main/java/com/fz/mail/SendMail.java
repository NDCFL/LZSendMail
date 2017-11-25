package com.fz.mail;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimePartDataSource;
import java.io.File;
import java.util.Properties;

/**
 * Created by Administrator on 2017/9/22.
 */
public class SendMail {

    public static void sendEmail(Mail mail) throws  Exception{
        //读取配置文件
        Properties properties = SendMailUtil.getEmailInfo("src/main/resources/config/mail.properties");
        //设置邮箱的发送者
        mail.setEmailName(SendMailUtil.getString("emailName"));
        //验证身份，和密码
        Session session = Session.getInstance(properties,new MailAuthenticator(SendMailUtil.getString("emailName"),SendMailUtil.getString("passWord")));
        //实例化一个消息类
        Message message = new MimeMessage(session);
        //设置消息的主题
        message.setSubject(mail.getSubject());
        //设置消息的放松这
        message.setFrom(mail.getEmailName());
        //发送邮箱的内容，并发送附件
        Multipart multipart = new MimeMultipart();
       for (String str: mail.getFilePath()) {
            BodyPart bodyPart = new MimeBodyPart();
            bodyPart.setDataHandler(new DataHandler((new FileDataSource(new File(str)))));
           multipart.addBodyPart(bodyPart);
       }
        //设置邮箱的内容
        message.setContent(multipart,mail.getContentType());
        //调用邮箱发送的函数
        message.setRecipients(Message.RecipientType.TO, mail.getToEmilName());
        //设置抄送人
        if(mail.getCc()==null){
        }else{
            message.setRecipients(Message.RecipientType.CC, mail.getCc());
        }
        //设置密送人
        if(mail.getBcc()==null){
        }else{
            message.setRecipients(Message.RecipientType.BCC, mail.getBcc());
        }
        //邮件输送连接
        Transport transport = session.getTransport();
        transport.connect();
        transport.sendMessage(message,message.getAllRecipients());
    }
    public static  void main(String ... arg){
                //实例化一个邮箱内容参数类
                Mail mail = new Mail();
                //标题
                mail.setSubject("邮件测试！");
                //内容
                mail.setContent("<a href='http://www.ganzhouche.com/cfl'>H-ui地址</a>");
                //收件人
                mail.setToEmilName("xljx_888888@163.com");
                //邮箱的抄送
                mail.setCc("781579156@qq.com");
                //邮箱的密送
                mail.setBcc("781579156@qq.com");
                //邮箱的内容
                mail.setContentType("text/html;charset=utf-8");
                String path[]={""};
                mail.setFilePath("d:\\HSoft4_2.dll".split(""));
                try {
                    sendEmail(mail);
                    System.out.println("发送成功！");
                } catch (Exception e) {
                    e.printStackTrace();
                }
    }
}
