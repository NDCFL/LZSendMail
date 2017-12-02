package com.fz.controller;

import com.fz.comment.Message;
import com.fz.comment.PageQuery;
import com.fz.comment.PagingBean;
import com.fz.comment.PathAutil;
import com.fz.mail.ReceiveMain;
import com.fz.service.EmailService;
import com.fz.vo.EmailVo;
import com.fz.vo.UserVo;
import org.apache.commons.io.FileUtils;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("email")
public class EmailController {
    @Resource
    private EmailService emailService;
    @RequestMapping("emailList")
    @ResponseBody
    public PagingBean emailList(int pageSize, int pageIndex,String status,String title,HttpSession session) throws  Exception{
        UserVo userVo = (UserVo)session.getAttribute("userVo");
        PagingBean pagingBean = new PagingBean();
        pagingBean.setPageSize(pageSize);
        pagingBean.setCurrentPage(pageIndex);
        PageQuery p=new PageQuery(pagingBean.getStartIndex(),pagingBean.getPageSize());
        p.setStatus(status);
        p.setTitle(title);
        pagingBean.setTotal(emailService.counts(p,userVo.getId()));
        pagingBean.setrows(emailService.pagelists(p,userVo.getId()));
        return pagingBean;
    }
    @RequestMapping("emailPage")
    public String emailPage(HttpSession session){
        UserVo userVo = (UserVo) session.getAttribute("userVo");
        int size =emailService.receiveMail(userVo);
        return "emailList";
    }
    @RequestMapping("sendMain")
    public String sendMain(){
        return "sendMain";
    }
    @RequestMapping("/emailAddSave")
    @ResponseBody
    public Message addSaveEmail(HttpSession session1) throws  Exception {
        try{
            UserVo userVo = (UserVo) session1.getAttribute("userVo");
            int size =emailService.receiveMail(userVo);
            return  Message.success("接收邮件成功!");
        }catch (Exception E){
            return Message.fail("接收邮件失败!");
        }
    }
    @RequestMapping("/emailModuleAddSave")
    @ResponseBody
    public Message emailModuleAddSave(HttpSession session,EmailVo emailVo){
        try{
            UserVo userVo = (UserVo) session.getAttribute("userVo");
            emailVo.setEndsend(userVo.getEmail());
            emailVo.setCreateTime(new Date());
            emailVo.setStatus(0);
            emailVo.setUserid(userVo.getId());
            emailVo.setSrcsend(emailVo.getTouser());
            if(emailVo.getSize()==null){
                long id = emailService.emailAdd(emailVo);
                return  Message.success("邮件保存成功!"+id);
            }else{
                emailVo.setId(emailVo.getSize());
                emailService.update(emailVo);
                return Message.success("修改成功!");
            }
        }catch (Exception E){
            E.printStackTrace();
            return Message.fail("邮件保存失败!");
        }
    }

    @RequestMapping("/emailAutoSave")
    @ResponseBody
    public Message emailAutoSave(HttpSession session,EmailVo emailVo) throws  Exception {
        try{
            UserVo userVo = (UserVo) session.getAttribute("userVo");
            emailVo.setEndsend(userVo.getEmail());
            emailVo.setCreateTime(new Date());
            emailVo.setStatus(0);
            emailVo.setUserid(userVo.getId());
            emailVo.setSrcsend(emailVo.getTouser());
            return  Message.success(emailService.emailAutoSave(emailVo));
        }catch (Exception E){
            E.printStackTrace();
            return Message.fail("自动生成邮件失败!");
        }
    }

    @RequestMapping("/findEmail/{id}")
    public ModelAndView findemail(@PathVariable("id") long id){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("emailUpdate");
        EmailVo email = emailService.queryById(id);
        modelAndView.addObject("email",email);
        return modelAndView;
    }
    @RequestMapping("/emailUpdateSave")
    @ResponseBody
    public Message updateEmail(EmailVo email) throws  Exception{
        try{
            emailService.update(email);
            return  Message.success("修改成功!");
        }catch (Exception e){
            return Message.fail("修改失败!");
        }
    }
    @RequestMapping("/deleteManyEmail")
    @ResponseBody
    public Message deleteManyemail(@Param("manyId") String manyId) throws  Exception{
        try{
            String str[] = manyId.split(",");
            for (String s: str) {
                emailService.delete(Long.parseLong(s));
            }
            return Message.success("删除成功!");
        }catch (Exception e){
            e.printStackTrace();
            return  Message.fail("删除失败!");
        }
    }
    @RequestMapping("/deleteEmail/{id}")
    @ResponseBody
    public Message deleteemail(@PathVariable("id") long id) throws  Exception{
        try{
            emailService.delete(id);
            return Message.success("删除成功!");
        }catch (Exception e){
            e.printStackTrace();
            return Message.fail("删除失败!");
        }
    }
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
    @RequestMapping("collection")
    public String collection(){
        return "collectionPage";
    }

    @RequestMapping("lookCollection/{id}")
    public ModelAndView lookCollection(@PathVariable("id") long id){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("lookCollectionPage");
        EmailVo emailVo = emailService.queryById(id);
        if(emailVo.getAccessoryPath()!=null && emailVo.getAccessoryPath()!=""){
            String path[] = emailVo.getAccessoryPath().split(";");
            emailVo.setSize(path.length);
            List<String> fileName = new ArrayList<String>();
            for (String str:path) {
                fileName.add(str);
            }
            emailVo.setFileName(fileName);
        }

        modelAndView.addObject("email",emailVo);
        return modelAndView;
    }
    @RequestMapping("writeCollection")
    public String writeCollection(){
        return "writeCollection";
    }
    @RequestMapping("upload")
    public Message upload(MultipartFile file, HttpServletRequest request) throws  Exception{
       try{
           String newname = getFileName(file.getOriginalFilename());
           FileUtils.copyInputStreamToFile(file.getInputStream(),new File(new PathAutil().getPath(request)+"/",newname));
           return Message.success("上传成功");
       }catch (Exception e){
           e.printStackTrace();
           return Message.success("上传失败");
       }
    }
    private synchronized String getFileName(String filename) {
        int position = filename.lastIndexOf(".");
        String ext = filename.substring(position);
        return System.nanoTime() + ext;
    }

}
