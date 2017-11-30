package com.fz.service;

import com.fz.comment.PageQuery;
import com.fz.vo.EmailVo;
import com.fz.vo.UserVo;

import java.util.List;

public interface EmailService extends BaseService<EmailVo>{
    List<EmailVo> seachEmail(String title,String userId);
}
