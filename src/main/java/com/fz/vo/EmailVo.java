package com.fz.vo;

import java.util.Date;
import java.util.List;

public class EmailVo {
    private  long id;
    private  String srcsend;//发送人
    private  String endsend;//接收人
    private  String title;//主题
    private  String content;//内容
    private  String accessoryPath;//附件地址
    private Date createTime=new Date();//发送时间或者是接收时间
    private  String emailcode;//收件code
    private  Integer status;//0未审核 1 已发送 2 收件箱
    private  long userid;//所属用户编号
    private Integer size;
    private List<String> fileName;

    public long getId() {
        return id;
    }

    public void setId(long id) {
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

    public String getEmailcode() {
        return emailcode;
    }

    public void setEmailcode(String emailcode) {
        this.emailcode = emailcode;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public long getUserid() {
        return userid;
    }

    public void setUserid(long userid) {
        this.userid = userid;
    }

    public Integer getSize() {
        return size;
    }

    public void setSize(Integer size) {
        this.size = size;
    }

    public List<String> getFileName() {
        return fileName;
    }

    public void setFileName(List<String> fileName) {
        this.fileName = fileName;
    }
}
