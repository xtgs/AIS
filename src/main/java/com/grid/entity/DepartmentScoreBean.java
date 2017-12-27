package com.grid.entity;

/**
 * Created by wanghuijian on 17/12/26.
 */
public class DepartmentScoreBean {
    private String time;
    private String totalCharge;
    private String totalTopup;

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getTotalCharge() {
        return totalCharge;
    }

    public void setTotalCharge(String totalCharge) {
        this.totalCharge = totalCharge;
    }

    public String getTotalTopup() {
        return totalTopup;
    }

    public void setTotalTopup(String totalTopup) {
        this.totalTopup = totalTopup;
    }

    public DepartmentScoreBean() {}

    public DepartmentScoreBean(String time, String totalCharge, String totalTopup) {
        this.time = time;
        this.totalCharge = totalCharge;
        this.totalTopup = totalTopup;
    }
}
