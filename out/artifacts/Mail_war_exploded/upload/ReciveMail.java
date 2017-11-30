package com.fz.serviceimpl;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.BodyPart;
import javax.mail.Flags;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Part;
import javax.mail.Session;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

import com.fz.vo.EmailVo;
import com.sun.mail.imap.IMAPFolder;
import com.sun.mail.imap.IMAPStore;
import org.springframework.stereotype.Service;

@Service
public class ReciveMail{
    public void readMail(){
        try {
            Properties prop = System.getProperties();
            prop.put("mail.store.protocol","imap");
            prop.put("mail.imap.host", "imap.qq.com");

            Session session = Session.getInstance(prop);
            IMAPStore store = (IMAPStore) session.getStore("imap"); // 使用imap会话机制，连接服务器
            store.connect("275300091@qq.com", "zwrdfwntpketbjeh");
            IMAPFolder folder = (IMAPFolder) store.getFolder("INBOX"); // 收件箱
            folder.open(Folder.READ_WRITE);
            //获取未读邮件
            Message[] messages = folder.getMessages(folder.getMessageCount()-folder.getUnreadMessageCount()+1,folder.getMessageCount());
            parseMessage(messages); //解析邮件
            //释放资源
            if (folder !=null ) folder.close(true);
            if (store != null) store.close();
            System.out.println("读取成功。。。。。。。。。。。。");
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        new ReciveMail().readMail();
    }
    /**
     * 解析邮件
     * @param messages 要解析的邮件列表
     */
    private void parseMessage(Message ...messages) throws MessagingException, IOException {
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
            emaininfo.setEndsend(getReceiveAddress(msg,Message.RecipientType.TO ));//收件人
            emaininfo.setCreateTime(msg.getSentDate());//收件日期
            emaininfo.setStatus(2);
            StringBuffer content =new StringBuffer();
            getMailTextContent(msg,content);
            List<String> pathlist=new ArrayList<String>();
            if (isContainAttachment(msg)) {//保存附件
                String path = ReciveMail.class.getResource("/").getPath().replaceAll("WEB-INF/classes","upload/recive");
                System.out.println(path+"============");
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
                    attpath+=";"+path;
                }
            }
            emaininfo.setContent(con);
            if(!"".equals(attpath)){
                emaininfo.setAccessoryPath(attpath.substring(1));
            }
            try {
                //emailInfoMapper.insert(emaininfo);
                System.out.println("内容:"+emaininfo.getContent());
                System.out.println("主题:"+emaininfo.getTitle());
                System.out.println("发件人："+emaininfo.getSrcsend());
                System.out.println("附件地址:"+emaininfo.getAccessoryPath());
                System.out.println("emialcode:"+emaininfo.getEmailcode());
                System.out.println("接收者:"+emaininfo.getEndsend());
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
    private String getReceiveAddress(MimeMessage msg, Message.RecipientType type) throws MessagingException {
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