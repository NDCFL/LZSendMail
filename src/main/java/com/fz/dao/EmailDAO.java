package com.fz.dao;

import com.fz.comment.PageQuery;
import com.fz.vo.EmailVo;
import com.fz.vo.FileVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EmailDAO extends BaseDAO<EmailVo> {
    List<EmailVo> pagelists(@Param("pageQuery") PageQuery pageQuery, @Param("userId") long userId);
    int counts(@Param("pageQuery") PageQuery pageQuery, @Param("userId") long userId);

    void batchAdd(List list);
}
