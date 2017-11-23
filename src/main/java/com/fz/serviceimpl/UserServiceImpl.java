package com.fz.serviceimpl;

import com.fz.comment.PageQuery;
import com.fz.comment.StatusQuery;
import com.fz.dao.UserDAO;
import com.fz.service.BaseService;
import com.fz.service.UserService;
import com.fz.vo.UserVo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class UserServiceImpl implements UserService{
    @Resource
    private UserDAO userDAO;
    @Override
    public UserVo queryById(long id) {
        return userDAO.queryById(id);
    }

    @Override
    public void update(UserVo userVo) {

        try{
            userDAO.update(userVo);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public void add(UserVo userVo) {
        userDAO.add(userVo);
    }

    @Override
    public void delete(long id) {
        userDAO.delete(id);
    }

    @Override
    public List<UserVo> pagelist(PageQuery pageQuery) {
        return userDAO.pagelist(pageQuery);
    }

    @Override
    public void updateStatus(StatusQuery statusQuery) {
        userDAO.updateStatus(statusQuery);
    }

    @Override
    public int count() {
        return userDAO.count();
    }

    @Override
    public int checkReg(String acc) {
        return userDAO.checkReg(acc);
    }

    @Override
    public int checkAcc(String acc) {
        return userDAO.checkAcc(acc);
    }

    @Override
    public String checkPwd(String loginAcc) {
        return userDAO.checkPwd(loginAcc);
    }
    @Override
    public void updatePwd(long id, String pwd) {
        userDAO.updatePwd(id, pwd);
    }

    @Override
    public void updateEmailPwd(long id, String password) {
        userDAO.updateEmailPwd(id,password);
    }

    @Override
    public String getPassword(long id) {
        return null;
    }

    @Override
    public UserVo getInfo(String loginAcc) {
        return userDAO.getInfo(loginAcc);
    }
}
