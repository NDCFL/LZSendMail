package com.fz.vo;

import java.io.Serializable;
import java.util.Date;

public class TypeVo implements Serializable {
    private Long id;
    private String typename;
    private Long userId;
    private String agentyId;
    private Date createTime;
    private UserVo userVo;
    private AgencyVo agencyVo;
    private String leader;
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTypename() {
        return typename;
    }

    public void setTypename(String typename) {
        this.typename = typename;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getAgentyId() {
        return agentyId;
    }

    public void setAgentyId(String agentyId) {
        this.agentyId = agentyId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public UserVo getUserVo() {
        return userVo;
    }

    public void setUserVo(UserVo userVo) {
        this.userVo = userVo;
    }

    public AgencyVo getAgencyVo() {
        return agencyVo;
    }

    public void setAgencyVo(AgencyVo agencyVo) {
        this.agencyVo = agencyVo;
    }

    public String getLeader() {
        return leader;
    }

    public void setLeader(String leader) {
        this.leader = leader;
    }
}
