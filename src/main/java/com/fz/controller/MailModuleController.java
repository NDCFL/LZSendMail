package com.fz.controller;

import com.fz.comment.Message;
import com.fz.comment.PageQuery;
import com.fz.comment.PagingBean;
import com.fz.service.FileService;
import com.fz.service.MailModuleService;
import com.fz.service.TypeService;
import com.fz.vo.*;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("mailModule")
public class MailModuleController {
    
    @Resource
    private MailModuleService mailModuleService;
    @Resource
    private FileService fileService;
    @Resource
    private TypeService typeService;
    @RequestMapping("mailModuleList")
    @ResponseBody
    public PagingBean mailModuleList(int pageSize, int pageIndex, HttpSession session) throws  Exception{
        UserVo userVo = (UserVo) session.getAttribute("userVo");
        PagingBean pagingBean = new PagingBean();
        pagingBean.setPageSize(pageSize);
        pagingBean.setCurrentPage(pageIndex);
        PageQuery p=new PageQuery(pagingBean.getStartIndex(),pagingBean.getPageSize());
        p.setUserId(userVo.getId());
        pagingBean.setTotal(mailModuleService.count(p));
        pagingBean.setrows(mailModuleService.pageLists(p,userVo.getId()));
        return pagingBean;
    }
    @RequestMapping("/mailModuleAddSave")
    @ResponseBody
    public Message addSavemailModule(MailModuleVo mailModule,HttpSession session) throws  Exception {
        try{

            UserVo userVo = (UserVo) session.getAttribute("userVo");
            mailModule.setUserId(userVo.getId());
            mailModule.setAccessoryPath(mailModule.getUpdateFile());
            mailModule.setCreateTime(new Date());
            mailModuleService.add(mailModule);
            return  Message.success("新增成功!");
        }catch (Exception E){
            E.printStackTrace();
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
            mailModule.setAccessoryPath(mailModule.getUpdateFile());
            mailModuleService.update(mailModule);
            return  Message.success("修改成功!");
        }catch (Exception e){
            e.printStackTrace();
            return Message.fail("修改失败!");
        }
    }
    @RequestMapping("/huixin/{id}/{touser}")
    @ResponseBody
    public ModelAndView huixin(@PathVariable("id") long id, @PathVariable("touser") String touser, HttpSession session) throws  Exception{
        UserVo userVo = (UserVo) session.getAttribute("userVo");
        MailModuleVo mailModuleVo = mailModuleService.queryById(id);
        mailModuleVo.setTouser(touser+".com");
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("writeEmail");
        modelAndView.addObject("mailModule",mailModuleVo);
        String fileHref[]= mailModuleVo.getAccessoryPath().split(";");
        if(fileHref.length!=0){
            List<String> listFile = new ArrayList<String>();
            for (String str: fileHref) {
                if(!str.equals("")){
                    listFile.add(str.substring(str.lastIndexOf("/")+1,str.length()));
                }
            }
            modelAndView.addObject("listFile",listFile);
        }
        List<MailModuleVo> mailmod=mailModuleService.pageLists(new PageQuery(0,1000),userVo.getId());
        modelAndView.addObject("mailmod",mailmod);
        List<TypeVo> tlist=typeService.pageLists(new PageQuery(0,1000),userVo.getId());
        modelAndView.addObject("tlist",tlist);
        return modelAndView;
    }
    @RequestMapping("/initUpdateModule/{id}")
    @ResponseBody
    public ModelAndView initUpdateModule(@PathVariable("id") long id) throws  Exception{
        MailModuleVo mailModuleVo = mailModuleService.queryById(id);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("updateCollection");
        modelAndView.addObject("size",mailModuleVo.getAccessoryPath().split(";").length);
        modelAndView.addObject("mailModule",mailModuleVo);
        String fileHref[]= mailModuleVo.getAccessoryPath().split(";");
        if(fileHref.length!=0){
            List<String> listFile = new ArrayList<String>();
            for (String str: fileHref) {
                if(!str.equals("")){
                    listFile.add(str.substring(str.lastIndexOf("/")+1,str.length()));
                }
            }
            modelAndView.addObject("listFile",listFile);
        }
        return modelAndView;
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
    @PostMapping("upload")
    @ResponseBody
    public FileUpVo upload(MultipartFile file, HttpServletRequest request, HttpSession session) throws IOException {
        UserVo userVo = (UserVo) session.getAttribute("userVo");
        FileUpVo fileUp = new FileUpVo();
        try{
            String path = request.getSession().getServletContext().getRealPath("upload");
            String fileName = file.getOriginalFilename();
            File dir = new File(path,fileName);
            if(!dir.exists()){
                dir.mkdirs();
            }
            Map<String,String> data = new HashMap<String, String>();
            data.put("src","/upload/"+fileName);
            file.transferTo(dir);
            fileUp.setData(data);
            FileVo fileVo = new FileVo();
            fileVo.setName(fileName);
            fileVo.setPath("/upload/"+fileName);
            fileVo.setUserId(userVo.getId());
            fileVo.setCreateTime(new Date());
            fileService.add(fileVo);
        }catch (Exception e){
            e.printStackTrace();
            fileUp.setCode(1);
        }
        fileUp.setMsg("上传成功!");
        return fileUp;
    }
    @PostMapping("delete")
    @ResponseBody
    public Message delete(String path,HttpSession session) throws IOException {
        try{
            String fileName = path.substring(path.lastIndexOf("\\")+1,path.length());
            //删除数据库的文件记录
            UserVo userVo = (UserVo) session.getAttribute("userVo");
            FileVo fileVo = new FileVo();
            fileVo.setName(fileName);
            fileVo.setPath(path);
            fileVo.setUserId(userVo.getId());
            fileService.deleteFile(fileVo);
            //删除上传的文件
            File file=new File(path);
            if(file.exists()&&file.isFile()){
                file.delete();
            }
            return Message.success("删除成功!");
        }catch (Exception e){
            return Message.fail("删除失败!");
        }
    }
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
}
