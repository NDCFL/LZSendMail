package com.fz.dao;

import com.fz.vo.AgencyVo;
import com.fz.vo.UserVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * Created by Administrator on 2017/9/13.
 */
@Repository
public interface AgencyDAO extends  BaseDAO<AgencyVo> {

    AgencyVo findByMail(String mail);
}
