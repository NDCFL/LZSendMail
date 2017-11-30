package com.fz.controller;

import com.fz.comment.Message;
import com.fz.comment.PageQuery;
import com.fz.comment.PagingBean;
import com.fz.service.FileService;
import com.fz.vo.FileVo;
import com.fz.vo.UserVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
@RequestMapping("file")
public class FileController {
    @Resource
    private FileService fileService;
    @RequestMapping("fileList")
    @ResponseBody
    public PagingBean fileList(int pageSize, int pageIndex, HttpSession session) throws  Exception{
        UserVo userVo = (UserVo) session.getAttribute("userVo");
        PagingBean pagingBean = new PagingBean();
        pagingBean.setPageSize(pageSize);
        pagingBean.setCurrentPage(pageIndex);
        pagingBean.setTotal(fileService.counts(userVo.getId()));
        pagingBean.setrows(fileService.pagelists(new PageQuery(pagingBean.getStartIndex(),pagingBean.getPageSize()),userVo.getId()));
        return pagingBean;
    }
    @RequestMapping("/deleteManyFile")
    @ResponseBody
    public Message deleteManyfile(@Param("manyId") String manyId) throws  Exception{
        try{
            String str[] = manyId.split(",");
            for (String s: str) {
                fileService.delete(Long.parseLong(s));
            }
            return Message.success("删除成功!");
        }catch (Exception e){
            e.printStackTrace();
            return  Message.fail("删除失败!");
        }
    }
    @RequestMapping("/deleteFile/{id}")
    @ResponseBody
    public Message deletefile(@PathVariable("id") long id) throws  Exception{
        try{
            fileService.delete(id);
            return Message.success("删除成功!");
        }catch (Exception e){
            e.printStackTrace();
            return Message.fail("删除失败!");
        }
    }
    @RequestMapping("/filePage")
    public String table() throws  Exception{
        return "fileList";
    }
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
}
