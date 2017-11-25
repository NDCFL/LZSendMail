package com.fz.serviceimpl;

import com.fz.comment.PageQuery;
import com.fz.comment.StatusQuery;
import com.fz.dao.AgencyDAO;
import com.fz.service.AgencyService;
import com.fz.vo.AgencyVo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
@Service
public class AgencyServiceImpl implements AgencyService {
    @Resource
    private AgencyDAO agencyDAO;
    @Override
    public AgencyVo queryById(long id) {
        return agencyDAO.queryById(id);
    }

    @Override
    public void update(AgencyVo agencyVo) {
        agencyDAO.update(agencyVo);
    }

    @Override
    public void add(AgencyVo agencyVo) {
        agencyDAO.add(agencyVo);
    }

    @Override
    public void delete(long id) {
        agencyDAO.delete(id);
    }

    @Override
    public List<AgencyVo> pagelist(PageQuery pageQuery) {
        return agencyDAO.pagelist(pageQuery);
    }

    @Override
    public void updateStatus(StatusQuery statusQuery) {
        agencyDAO.updateStatus(statusQuery);
    }

    @Override
    public int count() {
        return agencyDAO.count();
    }

    @Override
    public List<AgencyVo> listAll() {
        return agencyDAO.listAll();
    }
}
