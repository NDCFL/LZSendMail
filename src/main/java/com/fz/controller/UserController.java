package com.fz.controller;

import com.fz.comment.Message;
import com.fz.comment.PageQuery;
import com.fz.comment.PagingBean;
import com.fz.comment.StatusQuery;
import com.fz.service.UserService;
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
import sun.security.pkcs11.Secmod;

import javax.annotation.Resource;
import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.fz.comment.PasswordPlugin.EncoderByMd5;

/**
 * Created by Administrator on 2017/9/13.
 */
@Controller
@RequestMapping("/user")
public class UserController {
    @Resource
    private UserService userService;
    @RequestMapping("login")
    public String login() {
       return "loginPage";
    }
    @RequestMapping("main")
    public ModelAndView main(HttpSession session) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("index");
        modelAndView.addObject("userVo");
        session.setAttribute("userVo",(UserVo)session.getAttribute("userVo"));
        return modelAndView;
    }
    @RequestMapping("myInfoPage")
    public String myInfoPage() {
        return  "myInfoPage";
    }
    @RequestMapping("myInfo")
    @ResponseBody
    public UserVo myInfo(HttpSession session) {
        UserVo userVo = (UserVo) session.getAttribute("userVo");
        return  userService.queryById(userVo.getId());
    }
    @RequestMapping("userReg")
    public String userReg(UserVo userVo) {
        try {
            userService.add(userVo);
            return "loginPage";
        } catch (Exception e) {
            e.printStackTrace();
            return "regPage";
        }
    }
    @RequestMapping("checkReg")
    @ResponseBody
    public Map<String, Boolean> checkReg(String acc) {
        Map<String, Boolean> result = new HashMap<String, Boolean>();
        int count = userService.checkReg(acc);
        if (count == 0) {
            result.put("valid", true);
        } else {
            result.put("valid", false);
        }
        return result;
    }

    @RequestMapping("checkAcc")
    @ResponseBody
    public Map<String, Boolean> checkAcc(String loginAcc) {
        Map<String, Boolean> result = new HashMap<String, Boolean>();
        int count = userService.checkAcc(loginAcc);
        if (count == 0) {
            result.put("valid", false);
        } else {
            result.put("valid", true);
        }
        return result;

    }
    @RequestMapping("checkPassword")
    @ResponseBody
    public Map<String, Boolean> checkPassword(String loginAcc, String loginPassword, HttpSession session) throws Exception{
        Map<String, Boolean> result = new HashMap<String, Boolean>();
        System.out.println("加密后的密码=="+EncoderByMd5(loginPassword));
        String pwd = userService.checkPwd(loginAcc);
        if(!pwd.equals(EncoderByMd5(loginPassword))){
            result.put("valid", false);
        } else {
            session.setAttribute("userVo",userService.getInfo(loginAcc));
            result.put("valid", true);
        }
        return result;

    }
    @RequestMapping("checkPwd")
    @ResponseBody
    public Map<String, Boolean> checkPwd(String oldpwd, HttpSession session) throws Exception{
        Map<String, Boolean> result = new HashMap<String, Boolean>();
        UserVo userVo = (UserVo) session.getAttribute("userVo");
        String pwd = userService.checkPwd(userVo.getLoginAcc());
        if(!pwd.equals(EncoderByMd5(oldpwd))){
            result.put("valid", false);
        } else {
            result.put("valid", true);
        }
        return result;

    }
    @RequestMapping("updatePassword")
    public String updatePassword() {
        return  "updatePwd";
    }
    @RequestMapping("updatePwd")
    @ResponseBody
    public Message updatePwd(String newPwd,HttpSession session) throws Exception{
        try{
            UserVo userVo = (UserVo) session.getAttribute("userVo");
            userService.updatePwd(userVo.getId(),EncoderByMd5(newPwd));
            return Message.success("修改登录密码成功!");
        }catch (Exception e){
           e.printStackTrace();
            return Message.fail("修改登录密码失败!");
        }
    }
    @RequestMapping("updateEmilPwd")
    @ResponseBody
    public Message updateEmilPwd(String newEmailPwd,HttpSession session) throws Exception{
        try{
            UserVo userVo = (UserVo) session.getAttribute("userVo");
            userService.updateEmailPwd(userVo.getId(),EncoderByMd5(newEmailPwd));
            return Message.success("修改服务器邮箱登录密码成功!");
        }catch (Exception e){
            e.printStackTrace();
            return Message.fail("修改服务器邮箱登录密码失败!");
        }
    }
    @RequestMapping("userList")
    @ResponseBody
    public PagingBean userList(int pageSize, int pageIndex) throws  Exception{
        PagingBean pagingBean = new PagingBean();
        pagingBean.setTotal(userService.count());
        pagingBean.setPageSize(pageSize);
        pagingBean.setCurrentPage(pageIndex);
        pagingBean.setrows(userService.pagelist(new PageQuery(pagingBean.getStartIndex(),pagingBean.getPageSize())));
        return pagingBean;
    }
    @RequestMapping("/userAddSave")
    @ResponseBody
    public Message addSaveuser(UserVo user) throws  Exception {
        try{
            userService.add(user);
            return  Message.success("新增成功!");
        }catch (Exception E){
            return Message.fail("新增失败!");
        }

    }
    @RequestMapping("/findUser/{id}")
    @ResponseBody
    public UserVo findUser(@PathVariable("id") long id){
        UserVo user = userService.queryById(id);
        return user;
    }
    @RequestMapping("/userUpdateSave")
    @ResponseBody
    public Message updateUser(UserVo user) throws  Exception{
        try{
            userService.update(user);
            return  Message.success("修改成功!");
        }catch (Exception e){
            return Message.fail("修改失败!");
        }
    }
    @RequestMapping("/deleteManyUser")
    @ResponseBody
    public Message deleteManyuser(@Param("manyId") String manyId) throws  Exception{
        try{
            String str[] = manyId.split(",");
            for (String s: str) {
                userService.delete(Long.parseLong(s));
            }
            return Message.success("删除成功!");
        }catch (Exception e){
            e.printStackTrace();
            return  Message.fail("删除失败!");
        }
    }
    @RequestMapping("/deleteUser/{id}")
    @ResponseBody
    public Message deleteUser(@PathVariable("id") long id) throws  Exception{
        try{
            userService.delete(id);
            return Message.success("删除成功!");
        }catch (Exception e){
            e.printStackTrace();
            return Message.fail("删除失败!");
        }
    }
    @RequestMapping("/userPage")
    public String userPage() throws  Exception{
        return "user/userList";
    }
    @RequestMapping("/updateInfo")
    public Message updateInfo(UserVo userVo){
        try{
            userService.update(userVo);
            return Message.success("修改成功!");
        }catch (Exception e){
            e.printStackTrace();
            return Message.success("修改失败!");
        }
    }
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
}
