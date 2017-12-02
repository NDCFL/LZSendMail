package com.fz.serviceimpl;

import com.fz.comment.FmTemplate;
import com.fz.comment.PageQuery;
import com.fz.comment.StatusQuery;
import com.fz.dao.AgencyDAO;
import com.fz.dao.EmailDAO;
import com.fz.dao.InterfaceDAO;
import com.fz.mail.ReceiveMain;
import com.fz.service.EmailService;
import com.fz.vo.AgencyVo;
import com.fz.vo.EmailVo;
import com.fz.vo.UserVo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Service
public class EmailServiceImpl implements EmailService {
    @Resource
    private EmailDAO emailDAO;
    @Resource
    private AgencyDAO agencyDAO;
    @Resource
    private InterfaceDAO interfaceDAO;
    @Override
    public EmailVo queryById(long id) {
        return emailDAO.queryById(id);
    }

    @Override
    public void update(EmailVo emailVo) {
        emailDAO.update(emailVo);
    }

    @Override
    public void add(EmailVo emailVo) {
        emailDAO.add(emailVo);
    }

    @Override
    public void delete(long id) {
        emailDAO.delete(id);
    }

    @Override
    public List<EmailVo> pagelist(PageQuery pageQuery) {
        return emailDAO.pagelist(pageQuery);
    }

    @Override
    public void updateStatus(StatusQuery statusQuery) {
        emailDAO.updateStatus(statusQuery);
    }

    @Override
    public int count(PageQuery pageQuery) {
        return emailDAO.count(pageQuery);
    }

    @Override
    public List<EmailVo> pagelists(PageQuery pageQuery, long userId) {
        return emailDAO.pagelists(pageQuery, userId);
    }

    public int receiveMail(UserVo userVo){
        List list = ReceiveMain.readMail(userVo);
        try {
            if(list.size()>0)
                emailDAO.batchAdd(list);
        }catch (Exception e){
            e.printStackTrace();
        }
        return list.size();
    }

    @Override
    public int counts(PageQuery pageQuery, long userId) {
        return emailDAO.counts(pageQuery, userId);
    }

    @Override
    public long emailAdd(EmailVo emailVo) {
        return emailDAO.emailAdd(emailVo);
    }

    public String emailAutoSave(EmailVo emailVo){
        StringBuffer msg=new StringBuffer("");
        StringBuffer error=new StringBuffer("<br/>未找到经销商：");
        StringBuffer error1=new StringBuffer("<br/>未找到货款担保数据：");
        int count=0,count1=0,success=0;
        if(null!=emailVo && emailVo.getSrcsend()!=null  && emailVo.getSrcsend()!="" ){
            Date currentTime = new Date();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM");
            SimpleDateFormat time = new SimpleDateFormat("yyyyMMddHHmmss");
            String[] mail=emailVo.getSrcsend().split(";");
            List list =new ArrayList();
            for (String m :mail) {
                if(m==null || m=="")continue;
                AgencyVo ag=agencyDAO.findByMail(m);
                if(ag!=null){
                    HashMap param=new HashMap();
                    param.put("customer",ag.getCompanyName());
                    param.put("gdate",formatter.format(currentTime));
                    HashMap map=new HashMap();//interfaceDAO.filingPrice(param);
                    map.put("Customer",ag.getCompanyName());
                    map.put("GuaranteeMoney",600);
                    map.put("LateFine",300);
                    map.put("GuaranteeDate","2017-12-02 11:11:21");
                    map.put("DefSale","邱勋宇");
                    map.put("tReturned","2017-12-06 11:11:21");
                    if(map!=null){
                        try {
                            //装载变量
                            emailVo.setTitle(FmTemplate.template(emailVo.getTitle(),map));
                            emailVo.setContent(FmTemplate.template(emailVo.getContent(),map));
                            String files=emailVo.getAccessoryPath();
                            if(files!=null && files!=""){
                                String[] file=files.split(";");
                                StringBuffer trueFile=new StringBuffer("");
                                for (String f :file) {
                                    if (f == null || f == "") continue;
                                    if(f.indexOf(".xml")>0 || f.indexOf(".XML")>0){
                                        String filename=time.format(currentTime)+"/【"+ag.getCompanyName()+"】"+f.substring(f.lastIndexOf("/")+1).replace(".xml",".xls");
                                        FmTemplate.createExcel(map,f.substring(f.lastIndexOf("/")+1),filename);//附件模版转换Excel
                                        trueFile.append("/upload/"+filename+";");
                                    }else
                                        trueFile.append(f+";");
                                }
                                emailVo.setAccessoryPath(trueFile.toString());
                            }
                            list.add(emailVo);
                        } catch (Exception e2) {
                            msg.append("系统错误，请稍后再试！");
                            e2.printStackTrace();
                        }
                    }else{
                        count1++;
                        error.append(ag.getCompanyName()+";");
                    }

                }else{
                    count++;
                    error.append(m+";");
                }
            }
            if(list.size()>0){
                emailDAO.batchAdd(list);
                msg.append("成功生成"+list.size()+"个邮件！");
            }
        }
        if(count>0)
            msg.append(error);
        if(count1>0)
            msg.append(error1);
        return msg.toString();
    }


}
