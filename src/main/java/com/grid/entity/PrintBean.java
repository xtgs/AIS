package com.grid.entity;

import java.math.BigDecimal;

/**
 * Created by wanghuijian on 18/4/7.
 */
public class PrintBean {
    private String pid;
    private String tradeType;
    private String billName;
    private String patientName;
    private String docterName;
    private String itemName;
    private BigDecimal originalPrice;
    private BigDecimal realPrice;
    private BigDecimal afterBalance;
    private BigDecimal topupAmount;


    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public String getBillName() {
        return billName;
    }

    public void setBillName(String billName) {
        this.billName = billName;
    }

    public String getPatientName() {
        return patientName;
    }

    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }

    public String getDocterName() {
        return docterName;
    }

    public void setDocterName(String docterName) {
        this.docterName = docterName;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public BigDecimal getOriginalPrice() {
        return originalPrice;
    }

    public void setOriginalPrice(BigDecimal originalPrice) {
        this.originalPrice = originalPrice;
    }

    public BigDecimal getRealPrice() {
        return realPrice;
    }

    public void setRealPrice(BigDecimal realPrice) {
        this.realPrice = realPrice;
    }

    public BigDecimal getAfterBalance() {
        return afterBalance;
    }

    public void setAfterBalance(BigDecimal afterBalance) {
        this.afterBalance = afterBalance;
    }

    public String getTradeType() {
        return tradeType;
    }

    public void setTradeType(String tradeType) {
        this.tradeType = tradeType;
    }

    public BigDecimal getTopupAmount() {
        return topupAmount;
    }

    public void setTopupAmount(BigDecimal topupAmount) {
        this.topupAmount = topupAmount;
    }
}
