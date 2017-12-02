package com.fz.controller;

import com.fz.comment.Info;
import com.fz.comment.PageQuery;
import com.fz.comment.StatusQuery;
import com.fz.dao.EmailDAO;
import com.fz.mail.Mail;
import com.fz.mail.MailAuthenticator;
import com.fz.mail.SendMain;
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
            if(mailModuleVo.getCsend()!=null){
                mail.setCc(mailModuleVo.getCsend());
            }
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
                SendMain.sendEmail(mail,user);
                if(mailModuleVo.getType()==-1){
                    emailService.updateStatus(new StatusQuery(mailModuleVo.getId(),1));
                }else{
                    EmailVo emailVo = new EmailVo();
                    emailVo.setSrcsend(user.getEmail());
                    emailVo.setCreateTime(new Date());
                    emailVo.setTitle(mailModuleVo.getTitle());
                    emailVo.setContent(mailModuleVo.getContent());
                    emailVo.setAccessoryPath(mailModuleVo.getAccessoryPath());
                    emailVo.setUserid(user.getId());
                    emailVo.setStatus(1);
                    emailVo.setCsend(mailModuleVo.getCsend());
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
