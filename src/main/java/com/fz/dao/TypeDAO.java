package com.fz.dao;

import com.fz.comment.PageQuery;
import com.fz.vo.MailModuleVo;
import com.fz.vo.TypeVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TypeDAO extends BaseDAO<TypeVo>{
    List<TypeVo> pageLists(@Param("pageQuery") PageQuery pageQuery, @Param("userId") long userId);
}
