package com.fz.vo;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by Administrator on 2017/9/13.
 */
public class UserVo implements Serializable {

    private Long id;
    private String loginAcc;
    private String loginPassword;
    private String email;
    private String password;
    private String serverHost;
    private Integer serverPort;
    private String nickname;
    private String inserverHost;
    private Integer inserverPort;
    private Integer status;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getLoginAcc() {
        return loginAcc;
    }

    public void setLoginAcc(String loginAcc) {
        this.loginAcc = loginAcc;
    }

    public String getLoginPassword() {
        return loginPassword;
    }

    public void setLoginPassword(String loginPassword) {
        this.loginPassword = loginPassword;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getServerHost() {
        return serverHost;
    }

    public void setServerHost(String serverHost) {
        this.serverHost = serverHost;
    }

    public Integer getServerPort() {
        return serverPort;
    }

    public void setServerPort(Integer serverPort) {
        this.serverPort = serverPort;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getInserverHost() {
        return inserverHost;
    }

    public void setInserverHost(String inserverHost) {
        this.inserverHost = inserverHost;
    }

    public Integer getInserverPort() {
        return inserverPort;
    }

    public void setInserverPort(Integer inserverPort) {
        this.inserverPort = inserverPort;
    }
}
