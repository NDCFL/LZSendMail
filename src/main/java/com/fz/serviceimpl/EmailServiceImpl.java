package com.fz.serviceimpl;

import com.fz.comment.PageQuery;
import com.fz.comment.StatusQuery;
import com.fz.dao.EmailDAO;
import com.fz.dao.InterfaceDAO;
import com.fz.mail.ReceiveMain;
import com.fz.service.EmailService;
import com.fz.vo.EmailVo;
import com.fz.vo.UserVo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class EmailServiceImpl implements EmailService {
    @Resource
    private EmailDAO emailDAO;
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
}
