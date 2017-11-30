package com.fz.dao;

import com.fz.comment.PageQuery;
import com.fz.controller.MailModuleController;
import com.fz.vo.MailModuleVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MailModuleDAO extends BaseDAO<MailModuleVo>{
    List<MailModuleVo> pageLists(@Param("pageQuery") PageQuery pageQuery,@Param("userId") long userId);
}
