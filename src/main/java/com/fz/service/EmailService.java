package com.fz.service;

import com.fz.comment.PageQuery;
import com.fz.vo.EmailVo;
import com.fz.vo.UserVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface EmailService extends BaseService<EmailVo>{
    List<EmailVo> pagelists(PageQuery pageQuery,long userId);
    int counts(PageQuery pageQuery, long userId);

    int receiveMail(UserVo userVo);
}
