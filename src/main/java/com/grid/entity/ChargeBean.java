package com.grid.entity;

import java.math.BigDecimal;

/**
 * Created by wanghuijian on 17/11/15.
 */
public class ChargeBean {
    private String cid; //id
    private String pid; //病人id
    private String uid; //医生id
    private String iid; //收费项目id
    private BigDecimal originalPrice;
    private BigDecimal discount;
    private BigDecimal reslPrice;
    private String isdel;


    public String getCid() {
        return cid;
    }

    public void setCid(String cid) {
        this.cid = cid;
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getIid() {
        return iid;
    }

    public void setIid(String iid) {
        this.iid = iid;
    }

    public BigDecimal getOriginalPrice() {
        return originalPrice;
    }

    public void setOriginalPrice(BigDecimal originalPrice) {
        this.originalPrice = originalPrice;
    }

    public BigDecimal getDiscount() {
        return discount;
    }

    public void setDiscount(BigDecimal discount) {
        this.discount = discount;
    }

    public BigDecimal getReslPrice() {
        return reslPrice;
    }

    public void setReslPrice(BigDecimal reslPrice) {
        this.reslPrice = reslPrice;
    }

    public String getIsdel() {
        return isdel;
    }

    public void setIsdel(String isdel) {
        this.isdel = isdel;
    }
}
