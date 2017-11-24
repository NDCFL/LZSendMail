package com.fz.serviceimpl;

import com.fz.comment.PageQuery;
import com.fz.comment.StatusQuery;
import com.fz.dao.TypeDAO;
import com.fz.service.TypeService;
import com.fz.vo.TypeVo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class TypeServiceImpl implements TypeService{
    @Resource
    private TypeDAO typeDAO;
    @Override
    public TypeVo queryById(long id) {
        return typeDAO.queryById(id);
    }

    @Override
    public void update(TypeVo typeVo) {
        typeDAO.update(typeVo);
    }

    @Override
    public void add(TypeVo typeVo) {
        typeDAO.add(typeVo);
    }

    @Override
    public void delete(long id) {
        typeDAO.delete(id);
    }

    @Override
    public List<TypeVo> pagelist(PageQuery pageQuery) {
        return typeDAO.pagelist(pageQuery);
    }

    @Override
    public void updateStatus(StatusQuery statusQuery) {
        typeDAO.updateStatus(statusQuery);
    }

    @Override
    public int count() {
        return typeDAO.count();
    }

    @Override
    public List<TypeVo> listAll() {
        return typeDAO.listAll();
    }

    @Override
    public List<TypeVo> pageLists(PageQuery pageQuery, long userId) {
        return typeDAO.pageLists(pageQuery,userId);
    }
}
