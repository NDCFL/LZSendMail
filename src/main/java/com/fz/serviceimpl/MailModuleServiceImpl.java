package com.fz.serviceimpl;

import com.fz.comment.PageQuery;
import com.fz.comment.StatusQuery;
import com.fz.dao.MailModuleDAO;
import com.fz.service.MailModuleService;
import com.fz.vo.MailModuleVo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class MailModuleServiceImpl implements MailModuleService {
    @Resource
    private MailModuleDAO mailModuleDAO;
    @Override
    public List<MailModuleVo> pageLists(PageQuery pageQuery, long userId) {
        return mailModuleDAO.pageLists(pageQuery, userId);
    }

    @Override
    public MailModuleVo queryById(long id) {
        return mailModuleDAO.queryById(id);
    }

    @Override
    public void update(MailModuleVo mailModuleVo) {
        mailModuleDAO.update(mailModuleVo);
    }

    @Override
    public void add(MailModuleVo mailModuleVo) {
        mailModuleDAO.add(mailModuleVo);
    }

    @Override
    public void delete(long id) {
        mailModuleDAO.delete(id);
    }

    @Override
    public List<MailModuleVo> pagelist(PageQuery pageQuery) {
        return mailModuleDAO.pagelist(pageQuery);
    }

    @Override
    public void updateStatus(StatusQuery statusQuery) {
        mailModuleDAO.updateStatus(statusQuery);
    }

    @Override
    public int count(PageQuery pageQuery) {
        return mailModuleDAO.count(pageQuery);
    }
}
