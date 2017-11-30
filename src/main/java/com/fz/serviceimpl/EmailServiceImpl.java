package com.fz.serviceimpl;

import com.fz.comment.PageQuery;
import com.fz.comment.StatusQuery;
import com.fz.dao.EmailDAO;
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
    public List<EmailVo> seachEmail(String title,String userId) {
        return emailDAO.seachEmail(title,userId);
    }
}
