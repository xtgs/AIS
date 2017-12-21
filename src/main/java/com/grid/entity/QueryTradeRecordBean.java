package com.grid.entity;

/**
 * Created by wanghuijian on 17/12/20.
 */
public class QueryTradeRecordBean {
    private Integer startnum;
    private Integer getrows;
    private String sort;
    private String order;

    public String tradeType;
    public String pid;
    public String patientCardId;
    public String patientName;
    public String patientPhone;
    public String amount;
    public String afterBalance;
    public String uid;
    public String userName;
    public String createTime;
    public String createTimeFrom;
    public String createTimeTo;


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

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
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

    public String getTradeType() {
        return tradeType;
    }

    public void setTradeType(String tradeType) {
        this.tradeType = tradeType;
    }

    public String getPatientCardId() {
        return patientCardId;
    }

    public void setPatientCardId(String patientCardId) {
        this.patientCardId = patientCardId;
    }

    public String getPatientName() {
        return patientName;
    }

    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }

    public String getPatientPhone() {
        return patientPhone;
    }

    public void setPatientPhone(String patientPhone) {
        this.patientPhone = patientPhone;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getAfterBalance() {
        return afterBalance;
    }

    public void setAfterBalance(String afterBalance) {
        this.afterBalance = afterBalance;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getCreateTimeFrom() {
        return createTimeFrom;
    }

    public void setCreateTimeFrom(String createTimeFrom) {
        this.createTimeFrom = createTimeFrom;
    }

    public String getCreateTimeTo() {
        return createTimeTo;
    }

    public void setCreateTimeTo(String createTimeTo) {
        this.createTimeTo = createTimeTo;
    }
}
