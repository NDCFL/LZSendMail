package com.fz.service;

import com.fz.comment.PageQuery;
import com.fz.dao.BaseDAO;
import com.fz.vo.TypeVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TypeService extends BaseDAO<TypeVo>{
    List<TypeVo> pageLists(@Param("pageQuery") PageQuery pageQuery, @Param("userId") long userId);
}
