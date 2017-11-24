package com.fz.controller;

import com.fz.comment.Message;
import com.fz.comment.PageQuery;
import com.fz.comment.PagingBean;
import com.fz.service.TypeService;
import com.fz.vo.TypeVo;
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
@RequestMapping("type")
public class TypeController  {
    @Resource
    private TypeService typeService;
    @RequestMapping("typeList")
    @ResponseBody
    public PagingBean typeList(int pageSize, int pageIndex, HttpSession session) throws  Exception{
        UserVo userVo = (UserVo) session.getAttribute("userVo");
        PagingBean pagingBean = new PagingBean();
        pagingBean.setTotal(typeService.count());
        pagingBean.setPageSize(pageSize);
        pagingBean.setCurrentPage(pageIndex);
        pagingBean.setrows(typeService.pageLists(new PageQuery(pagingBean.getStartIndex(),pagingBean.getPageSize()),userVo.getId()));
        return pagingBean;
    }
    @RequestMapping("/typeAddSave")
    @ResponseBody
    public Message addSavetype(TypeVo type) throws  Exception {
        try{
            typeService.add(type);
            return  Message.success("新增成功!");
        }catch (Exception E){
            return Message.fail("新增失败!");
        }

    }
    @RequestMapping("/findType/{id}")
    @ResponseBody
    public TypeVo findtype(@PathVariable("id") long id){
        TypeVo type = typeService.queryById(id);
        return type;
    }
    @RequestMapping("/typeUpdateSave")
    @ResponseBody
    public Message updateType(TypeVo type) throws  Exception{
        try{
            typeService.update(type);
            return  Message.success("修改成功!");
        }catch (Exception e){
            return Message.fail("修改失败!");
        }
    }
    @RequestMapping("/deleteManyType")
    @ResponseBody
    public Message deleteManytype(@Param("manyId") String manyId) throws  Exception{
        try{
            String str[] = manyId.split(",");
            for (String s: str) {
                typeService.delete(Long.parseLong(s));
            }
            return Message.success("删除成功!");
        }catch (Exception e){
            e.printStackTrace();
            return  Message.fail("删除失败!");
        }
    }
    @RequestMapping("/deleteType/{id}")
    @ResponseBody
    public Message deletetype(@PathVariable("id") long id) throws  Exception{
        try{
            typeService.delete(id);
            return Message.success("删除成功!");
        }catch (Exception e){
            e.printStackTrace();
            return Message.fail("删除失败!");
        }
    }
    @RequestMapping("/typePage")
    public String table() throws  Exception{
        return "typeList";
    }
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

}
