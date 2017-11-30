package com.fz.service;

import com.fz.vo.AgencyVo;
import com.fz.vo.TypeVo;
import com.fz.vo.UserVo;

import java.util.List;

/**
 * Created by Administrator on 2017/9/13.
 */
public interface AgencyService extends BaseService<AgencyVo> {
    public List<AgencyVo> listAll();
}
