package com.fz.controller;

import com.fz.comment.Message;
import com.fz.comment.PageQuery;
import com.fz.comment.PagingBean;
import com.fz.service.MailModuleService;
import com.fz.vo.MailModuleVo;
import com.fz.vo.UserVo;
import com.sun.tools.internal.xjc.reader.xmlschema.bindinfo.BIConversion;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
@RequestMapping("mailModule")
public class MailModuleController {
    
    @Resource
    private MailModuleService mailModuleService;
    @RequestMapping("mailModuleList")
    @ResponseBody
    public PagingBean mailModuleList(int pageSize, int pageIndex, HttpSession session) throws  Exception{
        UserVo userVo = (UserVo) session.getAttribute("userVo");
        PagingBean pagingBean = new PagingBean();
        pagingBean.setTotal(mailModuleService.count());
        pagingBean.setPageSize(pageSize);
        pagingBean.setCurrentPage(pageIndex);
        pagingBean.setrows(mailModuleService.pageLists(new PageQuery(pagingBean.getStartIndex(),pagingBean.getPageSize()),userVo.getId()));
        return pagingBean;
    }
    @RequestMapping("/mailModuleAddSave")
    @ResponseBody
    public Message addSavemailModule(MailModuleVo mailModule,HttpSession session) throws  Exception {
        try{
            UserVo userVo = (UserVo) session.getAttribute("userVo");
            mailModule.setUserId(userVo.getId());
            mailModuleService.add(mailModule);
            return  Message.success("新增成功!");
        }catch (Exception E){
            return Message.fail("新增失败!");
        }

    }
    @RequestMapping("/findMailModule/{id}")
    public ModelAndView findmailModule(@PathVariable("id") long id){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("mailModule",mailModuleService.queryById(id));
        modelAndView.setViewName("updateCollection");
        return modelAndView;
    }
    @RequestMapping("/mailModuleUpdateSave")
    @ResponseBody
    public Message updateMailModule(MailModuleVo mailModule) throws  Exception{
        try{
            mailModuleService.update(mailModule);
            return  Message.success("修改成功!");
        }catch (Exception e){
            return Message.fail("修改失败!");
        }
    }
    @RequestMapping("/deleteManyMailModule")
    @ResponseBody
    public Message deleteManymailModule(@Param("manyId") String manyId) throws  Exception{
        try{
            String str[] = manyId.split(",");
            for (String s: str) {
                mailModuleService.delete(Long.parseLong(s));
            }
            return Message.success("删除成功!");
        }catch (Exception e){
            e.printStackTrace();
            return  Message.fail("删除失败!");
        }
    }
    @RequestMapping("/deleteMailModule/{id}")
    @ResponseBody
    public Message deletemailModule(@PathVariable("id") long id) throws  Exception{
        try{
            mailModuleService.delete(id);
            return Message.success("删除成功!");
        }catch (Exception e){
            e.printStackTrace();
            return Message.fail("删除失败!");
        }
    }
    @RequestMapping("/mailModulePage")
    public String table() throws  Exception{
        return "mailModuleList";
    }
    @RequestMapping("/addMail")
    public String addMail() throws  Exception{
        return "writeCollection";
    }
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
}
