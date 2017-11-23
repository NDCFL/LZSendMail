package com.fz.service;

import com.fz.vo.UserVo;
import org.apache.ibatis.annotations.Param;

/**
 * Created by Administrator on 2017/9/13.
 */
public interface UserService extends BaseService<UserVo> {
    int checkReg(String acc);
    int checkAcc(String acc);
    String checkPwd(String loginAcc);
    void updatePwd(long id,String pwd);
    void updateEmailPwd(long id, String password);
    String getPassword(long id);
    UserVo getInfo(String loginAcc);
}
