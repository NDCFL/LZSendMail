package com.fz.service;

import com.fz.comment.PageQuery;
import com.fz.vo.FileVo;
import org.apache.ibatis.annotations.Param;

import java.io.File;
import java.util.List;

public interface FileService extends BaseService<FileVo>{
    int counts(long userId);
    List<FileVo> pagelists(PageQuery pageQuery,long userId);
    void deleteFile(FileVo fileVo);
}
