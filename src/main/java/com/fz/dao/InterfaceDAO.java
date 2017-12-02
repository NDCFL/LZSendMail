package com.fz.dao;

import com.fz.vo.EmailVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository
public interface InterfaceDAO {
    HashMap filingPrice(HashMap map);

    List<HashMap> h_CtDetail(HashMap map);
}
