package com.grid.entity;

/**
 * Created by wanghuijian on 17/12/22.
 */
public class QueryUserScoreBean {
    private String uid;
    private String name;
    private String dateStart;
    private String dateEnd;

    private Integer startnum;
    private Integer getrows;
    private String sort;
    private String order;

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDateStart() {
        return dateStart;
    }

    public void setDateStart(String dateStart) {
        this.dateStart = dateStart;
    }

    public String getDateEnd() {
        return dateEnd;
    }

    public void setDateEnd(String dateEnd) {
        this.dateEnd = dateEnd;
    }

    public Integer getStartnum() {
        return startnum;
    }

    public void setStartnum(Integer startnum) {
        this.startnum = startnum;
    }

    public Integer getGetrows() {
        return getrows;
    }

    public void setGetrows(Integer getrows) {
        this.getrows = getrows;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public String getOrder() {
        return order;
    }

    public void setOrder(String order) {
        this.order = order;
    }
}
