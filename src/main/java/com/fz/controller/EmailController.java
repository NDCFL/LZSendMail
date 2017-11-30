package com.fz.controller;

import com.fz.comment.Message;
import com.fz.comment.PageQuery;
import com.fz.comment.PagingBean;
import com.fz.comment.PathAutil;
import com.fz.service.EmailService;
import com.fz.serviceimpl.ReciveMail;
import com.fz.vo.EmailVo;
import com.fz.vo.UserVo;
import com.sun.mail.imap.IMAPFolder;
import com.sun.mail.imap.IMAPStore;
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
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

@Controller
@RequestMapping("email")
public class EmailController {
    @Resource
    private EmailService emailService;
    @RequestMapping("emailList")
    @ResponseBody
    public PagingBean emailList(int pageSize, int pageIndex,String status,String title) throws  Exception{
        PagingBean pagingBean = new PagingBean();
        pagingBean.setPageSize(pageSize);
        pagingBean.setCurrentPage(pageIndex);
        PageQuery p=new PageQuery(pagingBean.getStartIndex(),pagingBean.getPageSize());
        p.setStatus(status);
        p.setTitle(title);
        pagingBean.setTotal(emailService.count(p));
        pagingBean.setrows(emailService.pagelist(p));
        return pagingBean;
    }
    @RequestMapping("emailPage")
    public String emailPage(HttpSession session){
        readMail(session);
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
            readMail(session1);
            return  Message.success("接收邮件成功!");
        }catch (Exception E){
            return Message.fail("接收邮件失败!");
        }
    }
    public void readMail(HttpSession session1){
        try{
            UserVo userVo = (UserVo) session1.getAttribute("userVo");
            Properties prop = System.getProperties();
            prop.put("mail.store.protocol","imap");
            prop.put("mail.imap.host", userVo.getInserverHost());
            Session session = Session.getInstance(prop);
            IMAPStore store = (IMAPStore) session.getStore("imap"); // 使用imap会话机制，连接服务器
            store.connect(userVo.getEmail(), userVo.getPassword());
            IMAPFolder folder = (IMAPFolder) store.getFolder("INBOX"); // 收件箱
            folder.open(Folder.READ_WRITE);
            //获取未读邮件
            javax.mail.Message[] messages = folder.getMessages(folder.getMessageCount()-folder.getUnreadMessageCount()+1,folder.getMessageCount());
            parseMessage(session1,messages); //解析邮件
            //释放资源
            if (folder !=null ) folder.close(true);
            if (store != null) store.close();
            System.out.println("读取成功。。。。。。。。。。。。");
        }catch (Exception E){
            E.printStackTrace();
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
    /**
     * 解析邮件
     * @param messages 要解析的邮件列表
     */
    private void parseMessage(HttpSession session,javax.mail.Message...messages) throws MessagingException, IOException {
        UserVo user = (UserVo) session.getAttribute("userVo");
        if (messages == null || messages.length < 1)
            throw new MessagingException("未找到要解析的邮件!");

        // 解析所有邮件
        for (int i = 0, count = messages.length; i < count; i++) {
            MimeMessage msg = (MimeMessage) messages[i];
            msg.setFlag(Flags.Flag.SEEN, true);
            //存储邮件信息
            EmailVo emaininfo = new EmailVo();
            emaininfo.setEmailcode(msg.getMessageID()); //ID
            InternetAddress address = getFrom(msg);
            emaininfo.setSrcsend(address.getPersonal()+"<" + address.getAddress() + ">");//张三<zhangsan@163.com>
            emaininfo.setTitle(decodeText(msg.getSubject()));//转码后的标题
            emaininfo.setEndsend(getReceiveAddress(msg, javax.mail.Message.RecipientType.TO ));//收件人
            emaininfo.setCreateTime(msg.getSentDate());//收件日期
            emaininfo.setStatus(2);
            emaininfo.setUserid(user.getId());
            StringBuffer content =new StringBuffer();
            getMailTextContent(msg,content);
            List<String> pathlist=new ArrayList<String>();
            if (isContainAttachment(msg)) {//保存附件
                String path = ReciveMail.class.getResource("/").getPath().replaceAll("WEB-INF/classes","upload/recive");
                saveAttachment(msg, path,address.getAddress(),address.getPersonal(),pathlist);
            }
            String con=content.toString();
            String attpath="";
            for (String path : pathlist) {
                String p=path.substring(0,path.lastIndexOf("."));
                if(con.indexOf(path)>-1){
                    con=con.replaceAll("src=\"cid:"+path,"src=\"/upload/recive/"+path);
                }else if(con.indexOf(p)>-1){
                    con=con.replaceAll("src=\"cid:"+p,"src=\"/upload/recive/"+path);
                }else{
                    attpath+=","+path;
                }
            }
            emaininfo.setContent(con);
            if(!"".equals(attpath)){
                emaininfo.setAccessoryPath(attpath.substring(1));
            }
            try {
                emailService.add(emaininfo);
            } catch (Exception e) {
                // TODO: handle exception
                e.printStackTrace();
                System.out.println("----邮件信息存入数据库失败了。。。。。");
            }
        }
    }
    /**
     * 获得邮件文本内容
     * @param part 邮件体
     * @param content 存储邮件文本内容的字符串
     * @throws MessagingException
     * @throws IOException
     */
    public void getMailTextContent(Part part, StringBuffer content) throws MessagingException, IOException {
        //如果是文本类型的附件，通过getContent方法可以取到文本内容，但这不是我们需要的结果，所以在这里要做判断
        boolean isContainTextAttach = part.getContentType().indexOf("name") > 0;
        if (part.isMimeType("text/*") && !isContainTextAttach) {
            content.append(part.getContent().toString());
        } else if (part.isMimeType("message/rfc822")) {
            getMailTextContent((Part)part.getContent(),content);
        } else if (part.isMimeType("multipart/*")) {
            Multipart multipart = (Multipart) part.getContent();
            int partCount = multipart.getCount();
            for (int i = 0; i < partCount; i++) {
                BodyPart bodyPart = multipart.getBodyPart(i);
                getMailTextContent(bodyPart,content);
            }
        }
    }

    /**
     * 获得邮件发件人
     * @param msg 邮件内容
     * @return 地址
     * @throws MessagingException
     * @throws UnsupportedEncodingException
     */
    private InternetAddress getFrom(MimeMessage msg) throws MessagingException, UnsupportedEncodingException {
        Address[] froms = msg.getFrom();
        if (froms.length < 1)
            throw new MessagingException("没有发件人!");

        return (InternetAddress) froms[0];
    }

    /**
     * 根据收件人类型，获取邮件收件人、抄送和密送地址。如果收件人类型为空，则获得所有的收件人
     * <p>Message.RecipientType.TO  收件人</p>
     * <p>Message.RecipientType.CC  抄送</p>
     * <p>Message.RecipientType.BCC 密送</p>
     * @param msg 邮件内容
     * @param type 收件人类型
     * @return 收件人1 <邮件地址1>, 收件人2 <邮件地址2>, ...
     * @throws MessagingException
     */
    private String getReceiveAddress(MimeMessage msg, javax.mail.Message.RecipientType type) throws MessagingException {
        StringBuffer receiveAddress = new StringBuffer();
        Address[] addresss = null;
        if (type == null ) {
            addresss = msg.getAllRecipients();
        } else {
            addresss = msg.getRecipients(type);
        }

        if (addresss ==null  || addresss.length < 1)
            throw new MessagingException("没有收件人!");
        for (Address address : addresss) {
            InternetAddress internetAddress = (InternetAddress)address;
            receiveAddress.append(internetAddress.toUnicodeString()).append(",");
        }

        receiveAddress.deleteCharAt(receiveAddress.length()-1); //删除最后一个逗号

        return receiveAddress.toString();
    }

    /**
     * 判断邮件中是否包含附件
     * @return 邮件中存在附件返回true，不存在返回false
     * @throws MessagingException
     * @throws IOException
     */
    private boolean isContainAttachment(Part part) throws MessagingException, IOException {
        boolean flag = false;
        if (part.isMimeType("multipart/*")) {
            MimeMultipart multipart = (MimeMultipart) part.getContent();
            int partCount = multipart.getCount();
            for (int i = 0; i < partCount; i++) {
                BodyPart bodyPart = multipart.getBodyPart(i);
                String disp = bodyPart.getDisposition();
                if (disp != null && (disp.equalsIgnoreCase(Part.ATTACHMENT) || disp.equalsIgnoreCase(Part.INLINE))) {
                    flag = true;
                } else if (bodyPart.isMimeType("multipart/*")) {
                    flag = isContainAttachment(bodyPart);
                } else {
                    String contentType = bodyPart.getContentType();
                    if (contentType.indexOf("application") != -1) {
                        flag = true;
                    }

                    if (contentType.indexOf("name") != -1) {
                        flag = true;
                    }
                }

                if (flag) break;
            }
        } else if (part.isMimeType("message/rfc822")) {
            flag = isContainAttachment((Part)part.getContent());
        }
        return flag;
    }

    /**
     * 保存附件
     * @param part 邮件中多个组合体中的其中一个组合体
     * @param destDir  附件保存目录
     * @throws UnsupportedEncodingException
     * @throws MessagingException
     * @throws FileNotFoundException
     * @throws IOException
     */
    private void saveAttachment(Part part, String destDir,String email,String sendName,List<String> pathlist) throws UnsupportedEncodingException, MessagingException,
            FileNotFoundException, IOException {
        if (part.isMimeType("multipart/*")) {
            Multipart multipart = (Multipart) part.getContent();    //复杂体邮件
            //复杂体邮件包含多个邮件体
            int partCount = multipart.getCount();
            for (int i = 0; i < partCount; i++) {
                //获得复杂体邮件中其中一个邮件体
                BodyPart bodyPart = multipart.getBodyPart(i);
                //某一个邮件体也有可能是由多个邮件体组成的复杂体
                String disp = bodyPart.getDisposition();
                if (disp != null && (disp.equalsIgnoreCase(Part.ATTACHMENT) || disp.equalsIgnoreCase(Part.INLINE))) {
                    InputStream is = bodyPart.getInputStream();
                    String filename=decodeText(bodyPart.getFileName());
                    pathlist.add(filename);
                    this.saveFile(is, destDir,filename ,email,sendName);
                } else if (bodyPart.isMimeType("multipart/*")) {
                    saveAttachment(bodyPart,destDir,email,sendName,pathlist);
                } else {
                    String contentType = bodyPart.getContentType();
                    if (contentType.indexOf("name") != -1 || contentType.indexOf("application") != -1) {
                        String filename=decodeText(bodyPart.getFileName());
                        pathlist.add(filename);
                        this.saveFile(bodyPart.getInputStream(), destDir, filename,email,sendName);
                    }
                }
            }
        } else if (part.isMimeType("message/rfc822")) {
            saveAttachment((Part) part.getContent(),destDir,email,sendName,pathlist);
        }
    }

    /**
     * 读取输入流中的数据保存至指定目录
     * @param is 输入流
     * @param fileName 文件名
     * @param destDir 文件存储目录
     * @throws FileNotFoundException
     * @throws IOException
     */
    private void saveFile(InputStream is, String destDir, String fileName,String email,String sendName)
            throws FileNotFoundException, IOException {
        //附件格式过滤
        //System.out.println(fileName);
        BufferedInputStream bis = new BufferedInputStream(is);
        BufferedOutputStream bos = new BufferedOutputStream(
                new FileOutputStream(new File(destDir + fileName)));
        int len = -1;
        while ((len = bis.read()) != -1) {
            bos.write(len);
            bos.flush();
        }
        bos.close();
        bis.close();
    }

    /**
     * 文本解码
     * @param encodeText 解码MimeUtility.encodeText(String text)方法编码后的文本
     * @return 解码后的文本
     * @throws UnsupportedEncodingException
     */
    private String decodeText(String encodeText) throws UnsupportedEncodingException {
        if (encodeText == null || "".equals(encodeText)) {
            return "";
        } else {
            return MimeUtility.decodeText(encodeText);
        }
    }
}
