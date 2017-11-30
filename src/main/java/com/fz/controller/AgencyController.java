package com.fz.controller;

import com.fz.comment.Message;
import com.fz.comment.PageQuery;
import com.fz.comment.PagingBean;
import com.fz.comment.StatusQuery;
import com.fz.service.AgencyService;
import com.fz.vo.AgencyVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by chenfeilong on 2017/10/21.
 */
@Controller
@RequestMapping("agency")
public class AgencyController {

    @Resource
    private AgencyService agencyService;
    @RequestMapping("agencyList")
    @ResponseBody
    public PagingBean agencyList(int pageSize, int pageIndex) throws  Exception{
        PagingBean pagingBean = new PagingBean();
        pagingBean.setPageSize(pageSize);
        pagingBean.setCurrentPage(pageIndex);
        PageQuery p=new PageQuery(pagingBean.getStartIndex(),pagingBean.getPageSize());
        pagingBean.setTotal(agencyService.count(p));
        pagingBean.setrows(agencyService.pagelist(p));
        return pagingBean;
    }
    @RequestMapping("/agencyAddSave")
    @ResponseBody
    public Message addSaveagency(AgencyVo agency) throws  Exception {
        try{
            agencyService.add(agency);
            return  Message.success("新增成功!");
        }catch (Exception E){
            return Message.fail("新增失败!");
        }

    }
    @RequestMapping("/findAgency/{id}")
    @ResponseBody
    public AgencyVo findagency(@PathVariable("id") long id){
        AgencyVo agency = agencyService.queryById(id);
        return agency;
    }
    @RequestMapping("/agencyUpdateSave")
    @ResponseBody
    public Message updateAgency(AgencyVo agency) throws  Exception{
        try{
            agencyService.update(agency);
            return  Message.success("修改成功!");
        }catch (Exception e){
            return Message.fail("修改失败!");
        }
    }
    @RequestMapping("/deleteManyAgency")
    @ResponseBody
    public Message deleteManyagency(@Param("manyId") String manyId) throws  Exception{
        try{
            String str[] = manyId.split(",");
            for (String s: str) {
                agencyService.delete(Long.parseLong(s));
            }
            return Message.success("删除成功!");
        }catch (Exception e){
            e.printStackTrace();
            return  Message.fail("删除失败!");
        }
    }
    @RequestMapping("/deleteAgency/{id}")
    @ResponseBody
    public Message deleteagency(@PathVariable("id") long id) throws  Exception{
        try{
            agencyService.delete(id);
            return Message.success("删除成功!");
        }catch (Exception e){
            e.printStackTrace();
            return Message.fail("删除失败!");
        }
    }
    @RequestMapping("/agencyPage")
    public String table() throws  Exception{
        return "agencyList";
    }
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
}
