package com.fz.vo;

import java.io.Serializable;
import java.util.Date;

public class MailModuleVo implements Serializable{
    private long id;
    private String title;
    private String content;
    private String accessoryPath;
    private long userId;
    private String touser;
    private Date createTime;
    private String updateFile;
    private int type;
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
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

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public String getTouser() {
        return touser;
    }

    public void setTouser(String touser) {
        this.touser = touser;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getUpdateFile() {
        return updateFile;
    }

    public void setUpdateFile(String updateFile) {
        this.updateFile = updateFile;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }
}
