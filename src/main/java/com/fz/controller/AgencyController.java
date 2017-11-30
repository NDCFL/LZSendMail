package com.fz.controller;

import com.fz.comment.*;
import com.fz.service.AgencyService;
import com.fz.vo.AgencyVo;
import com.fz.vo.FileUpVo;
import com.fz.vo.FileVo;
import com.fz.vo.UserVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

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
    @RequestMapping("upload")
    @ResponseBody
    public FileUpVo upload(MultipartFile file, HttpServletRequest request){
        FileUpVo fileUp = new FileUpVo();
        try {
            String path = request.getSession().getServletContext().getRealPath("upload");
            String fileName = file.getOriginalFilename();
            File dir = new File(path, fileName);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            Map<String,String> data = new HashMap<String, String>();
            data.put("src","/upload/"+fileName);
            file.transferTo(dir);
            fileUp.setData(data);
            fileUp.setMsg("上传成功!");
        }catch (Exception e){
            e.printStackTrace();
            fileUp.setCode(1);
            fileUp.setMsg("上传失败!");
        }
        return fileUp;
    }
    @PostMapping("delete")
    @ResponseBody
    public Message delete(String path, HttpServletRequest request) throws IOException {
        String dir = request.getSession().getServletContext().getRealPath("/");
        try{
            File file=new File(dir+path);
            if(file.exists()&&file.isFile()){
                file.delete();
            }
            return Message.success("删除成功!");
        }catch (Exception e){
            return Message.fail("删除失败!");
        }
    }
    @PostMapping("daoru")
    @ResponseBody
    public Message daoru(String path,HttpServletRequest request) throws IOException {
        String dir[] = path.split(";");
        List<AgencyVo> agencyVoList = new ArrayList<AgencyVo>();
        String root = request.getSession().getServletContext().getRealPath("/");
        try{
            for (String str:dir) {
                File file=new File(root+str);
                FileInputStream fileInputStream = new FileInputStream(file);
                agencyVoList = ExcelUtil.importAgencyByPoi(fileInputStream);
                if(agencyVoList.size()==1){
                    if(agencyVoList.get(0).getInfo()!=null){
                        return Message.fail("导入失败!"+agencyVoList.get(0).getInfo());
                    }
                }
            }
            for (AgencyVo agencyVo:agencyVoList) {
                agencyService.add(agencyVo);
            }
            return Message.success("导入成功!");
        }catch (Exception e){
            e.printStackTrace();
            return Message.fail("导入失败!");
        }
    }
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
}
