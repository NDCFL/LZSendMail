package com.fz.service;

import com.fz.comment.PageQuery;
import com.fz.controller.MailModuleController;
import com.fz.vo.MailModuleVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MailModuleService extends BaseService<MailModuleVo>{
    List<MailModuleVo> pageLists(@Param("pageQuery") PageQuery pageQuery, @Param("userId") long userId);
}
