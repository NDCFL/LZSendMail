package com.fz.serviceimpl;

import com.fz.comment.PageQuery;
import com.fz.comment.StatusQuery;
import com.fz.dao.FileDAO;
import com.fz.service.FileService;
import com.fz.vo.FileVo;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;

@Service
public class FileServiceImpl implements FileService {
    @Resource
    private FileDAO fileDAO;
    @Override
    public FileVo queryById(long id) {
        return fileDAO.queryById(id);
    }

    @Override
    public void update(FileVo fileVo) {
        fileDAO.update(fileVo);
    }

    @Override
    public void add(FileVo fileVo) {
        fileDAO.add(fileVo);
    }

    @Override
    public void delete(long id) {
        fileDAO.delete(id);
    }

    @Override
    public List<FileVo> pagelist(PageQuery pageQuery) {
        return fileDAO.pagelist(pageQuery);
    }

    @Override
    public void updateStatus(StatusQuery statusQuery) {
        fileDAO.updateStatus(statusQuery);
    }

    @Override
    public int count(PageQuery pageQuery) {
        return fileDAO.count(pageQuery);
    }

    @Override
    public int counts(long userId) {
        return fileDAO.counts(userId);
    }

    @Override
    public List<FileVo> pagelists(PageQuery pageQuery, long userId) {
        return fileDAO.pagelists(pageQuery, userId);
    }

    @Override
    public void deleteFile(FileVo fileVo) {
        fileDAO.deleteFile(fileVo);
    }
}
