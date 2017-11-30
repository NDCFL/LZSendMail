package com.fz.dao;

import com.fz.comment.PageQuery;
import com.fz.dao.BaseDAO;
import com.fz.vo.FileVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface  FileDAO  extends BaseDAO<FileVo>{
    int counts(long userId);
    List<FileVo> pagelists(@Param("pageQuery") PageQuery pageQuery, @Param("userId") long userId);
    void deleteFile(FileVo fileVo);
}
