package com.fz.vo;

import java.util.Date;

public class EmailVo {
    private  Integer id;
    private  String srcsend;
    private  String endsend;
    private  String title;
    private  String content;
    private  String accessoryPath;
    private Date createTime;
    private  String emailcode;//收件code
    private  Integer status;//0未审核 1 已发送 2 收件箱
    private  Integer userid;

    public String getEmailcode() {
        return emailcode;
    }

    public void setEmailcode(String emailcode) {
        this.emailcode = emailcode;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getSrcsend() {
        return srcsend;
    }

    public void setSrcsend(String srcsend) {
        this.srcsend = srcsend;
    }

    public String getEndsend() {
        return endsend;
    }

    public void setEndsend(String endsend) {
        this.endsend = endsend;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getAccessoryPath() {
        return accessoryPath;
    }

    public void setAccessoryPath(String accessoryPath) {
        this.accessoryPath = accessoryPath;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }
}
