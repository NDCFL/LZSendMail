package com.fz.mail;


import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;

/**
 * Created by Administrator on 2017/9/22.
 */
public class Mail {

    //要发送至哪个邮箱
    private String emailName;
    //抄送对象
    private String cc;
    //密送对象
    private String bcc;
    //邮箱的主题
    private String subject;
    //邮箱的内容
    private String content;
    //邮箱发送的类型，纯文本还是网页，还是其他的格式
    private String contentType;
    //邮箱的接收者
    private String toEmilName;

    private String[] filePath;

    public String[] getFilePath() {
        return filePath;
    }

    public void setFilePath(String[] filePath) {
        this.filePath = filePath;
    }

    public InternetAddress[] getToEmilName() {
        try {
            return InternetAddress.parse(toEmilName);
        } catch (AddressException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void setToEmilName(String toEmilName) {
        this.toEmilName = toEmilName;
    }

    public InternetAddress getEmailName() {
        try {
            return InternetAddress.parse(emailName)[0];
        } catch (AddressException e) {
            e.printStackTrace();
        }
        return  null;
    }

    public void setEmailName(String emailName) {
        this.emailName = emailName;
    }

    public InternetAddress[] getCc() {
        if(cc==null){
            return null;
        }else{
            try {
                return InternetAddress.parse(cc);
            } catch (AddressException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    public void setCc(String cc) {
        this.cc = cc;
    }

    public InternetAddress[] getBcc() {
        if(bcc==null){
            return  null;
        }else{
            try {
                return InternetAddress.parse(bcc);
            } catch (AddressException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    public void setBcc(String bcc) {
        this.bcc = bcc;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getContentType() {
        return contentType;
    }

    public void setContentType(String contentType) {
        this.contentType = contentType;
    }
}
