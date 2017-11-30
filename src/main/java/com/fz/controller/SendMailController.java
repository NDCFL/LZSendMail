package com.fz.controller;

import com.fz.comment.Info;
import com.fz.comment.PageQuery;
import com.fz.comment.StatusQuery;
import com.fz.dao.EmailDAO;
import com.fz.mail.Mail;
import com.fz.mail.MailAuthenticator;
import com.fz.service.AgencyService;
import com.fz.service.EmailService;
import com.fz.service.MailModuleService;
import com.fz.service.TypeService;
import com.fz.vo.EmailVo;
import com.fz.vo.MailModuleVo;
import com.fz.vo.TypeVo;
import com.fz.vo.UserVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.annotation.Resource;
import javax.mail.*;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.Date;
import java.util.List;
import java.util.Properties;

/**
 * Created by Administrator on 2017/9/22.
 */
@Controller
@RequestMapping("mail")
public class SendMailController {
    @Resource
    private TypeService typeService;
    @Resource
    private AgencyService agencyService;
    @Resource
    private EmailService emailService;
    @Resource
    private MailModuleService mailModuleService;
    public void sendEmail(Mail mail, HttpSession session1) throws  Exception{
        UserVo userVo = (UserVo) session1.getAttribute("userVo");
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


    @RequestMapping("send")
    @ResponseBody
    public Info send(final HttpSession session, final MailModuleVo mailModuleVo){
        UserVo user = (UserVo) session.getAttribute("userVo");
        try{
            //启用一个线程
            //实例化一个邮箱内容参数类
            Mail mail = new Mail();
            //标题
            mail.setSubject(mailModuleVo.getTitle());
            //内容
            mail.setContent(mailModuleVo.getContent());
            //收件人
            mail.setToEmilName(mailModuleVo.getTouser());
            //邮箱的附件
            String root = session.getServletContext().getRealPath("/");
            if(mailModuleVo.getAccessoryPath()!=null && mailModuleVo.getAccessoryPath()!=""){
                String path[] = mailModuleVo.getAccessoryPath().split(";");
                String realPath = "";
                for (String str: path) {
                    realPath+=root+str+";";
                }
                mail.setFilePath(realPath.split(";"));
            }
            //邮箱的内容
            mail.setContentType("text/html;charset=utf-8");
            try {
                sendEmail(mail,session);
                if(mailModuleVo.getType()==-1){
                }else{
                    EmailVo emailVo = new EmailVo();
                    emailVo.setSrcsend(user.getEmail());
                    emailVo.setCreateTime(new Date());
                    emailVo.setTitle(mailModuleVo.getTitle());
                    emailVo.setContent(mailModuleVo.getContent());
                    emailVo.setAccessoryPath(mailModuleVo.getAccessoryPath());
                    emailVo.setUserid(user.getId());
                    emailVo.setStatus(1);
                    emailVo.setEndsend(mailModuleVo.getTouser());
                    emailService.add(emailVo);
                }
                return Info.success("发送成功!");
            } catch (Exception e) {
                e.printStackTrace();
                return  Info.fail("发送失败!");
            }
        }catch (Exception e){
            e.printStackTrace();
            return  Info.fail("发送失败!");
        }
    }
    @RequestMapping("update/{id}")
    @ResponseBody
    public com.fz.comment.Message update(@PathVariable("id") long id){
        try {
            emailService.updateStatus(new StatusQuery(id,1));
            return  com.fz.comment.Message.success("审核通过!");
        }catch (Exception e){
            e.printStackTrace();
            return com.fz.comment.Message.fail("审核失败!");
        }
    }
    @RequestMapping("sendPage/{id}")
    public ModelAndView sendPage(@PathVariable("id") long id,HttpSession session) throws  Exception{
        ModelAndView view =new ModelAndView();
        view.setViewName("writeEmail");
        view.addObject("emailVo",emailService.queryById(id));
        UserVo userVo = (UserVo) session.getAttribute("userVo");
        List<MailModuleVo> mailmod=mailModuleService.pageLists(new PageQuery(0,1000),userVo.getId());
        view.addObject("mailmod",mailmod);
        List<TypeVo> tlist=typeService.pageLists(new PageQuery(0,1000),userVo.getId());
        view.addObject("tlist",tlist);
        return  view;
    }
    @RequestMapping("sendPage")
    public ModelAndView sendPage(HttpSession session) throws  Exception{
        ModelAndView view =new ModelAndView();
        view.setViewName("writeEmail");
        UserVo userVo = (UserVo) session.getAttribute("userVo");
        List<MailModuleVo> mailmod=mailModuleService.pageLists(new PageQuery(0,1000),userVo.getId());
        view.addObject("mailmod",mailmod);
        List<TypeVo> tlist=typeService.pageLists(new PageQuery(0,1000),userVo.getId());
        view.addObject("tlist",tlist);
        return  view;
    }
}
