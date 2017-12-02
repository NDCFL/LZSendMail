package com.fz.dao;

import com.fz.vo.UserVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * Created by Administrator on 2017/9/13.
 */
@Repository
public interface UserDAO extends  BaseDAO<UserVo> {
    int checkReg(String acc);
    int checkAcc(String acc);
    String checkPwd(@Param("loginAcc") String loginAcc);
    void updatePwd(@Param("id") long id, @Param("loginPassword") String loginPassword);
    void updateEmailPwd(@Param("id") long id, @Param("password") String password);
    String getPassword(long id);
    UserVo getInfo(String loginAcc);
    void resetUpdate(UserVo userVo);
}
