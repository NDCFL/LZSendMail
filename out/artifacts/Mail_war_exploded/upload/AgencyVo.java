package com.fz.vo;

import java.io.Serializable;

public class AgencyVo implements Serializable {
    private  Integer id;
    private  String companyName;
    private  String leader;
    private  String emailAcc;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getLeader() {
        return leader;
    }

    public void setLeader(String leader) {
        this.leader = leader;
    }

    public String getEmailAcc() {
        return emailAcc;
    }

    public void setEmailAcc(String emailAcc) {
        this.emailAcc = emailAcc;
    }
}
