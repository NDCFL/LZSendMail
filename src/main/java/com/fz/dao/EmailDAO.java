package com.fz.dao;

import com.fz.comment.PageQuery;
import com.fz.vo.EmailVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EmailDAO extends BaseDAO<EmailVo> {
    List<EmailVo> seachEmail(@Param("title") String title,@Param("userId") String userId);
}
