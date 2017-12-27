package com.grid.entity;

/**
 * Created by wanghuijian on 17/12/25.
 */
public class QueryDepartmentScoreBean {
    private String dateStart;
    private String dateEnd;

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

    public QueryDepartmentScoreBean() {
    }

    public QueryDepartmentScoreBean(String dateStart, String dateEnd) {
        this.dateStart = dateStart;
        this.dateEnd = dateEnd;
    }
}
