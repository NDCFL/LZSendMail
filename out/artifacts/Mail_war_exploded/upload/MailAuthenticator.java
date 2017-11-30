package com.fz.mail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

/**
 * Created by Administrator on 2017/9/22.
 */
public class MailAuthenticator extends Authenticator {

    private String emailName;
    private String password;
    public MailAuthenticator(){}
    public MailAuthenticator(String emailName,String password){
        this.emailName=emailName;
        this.password=password;
    }
    @Override
    protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication(emailName, password);
    }
}
