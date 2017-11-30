package com.fz.comment;

/**
 * 分页查询对象
 * 创建于2017-08-23
 *
 * @author 陈飞龙
 * @version 1.0
 */
public class PageQuery {

    private Integer pageNo;
    private Integer pageSize;
    private String title;
    private String status;
    private long userId;
    public PageQuery(){}

    public PageQuery(Integer pageNo, Integer pageSize) {
        this.pageNo = pageNo;
        this.pageSize = pageSize;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Integer getPageNo() {
        return pageNo;
    }

    public void setPageNo(Integer pageNo) {
        this.pageNo = pageNo;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public int getBeginIndex() {
        return (pageNo - 1) * pageSize;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }
}
