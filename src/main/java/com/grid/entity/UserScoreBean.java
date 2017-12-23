package com.grid.entity;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * Created by wanghuijian on 17/12/22.
 */
public class UserScoreBean {
    private String uid;
    private String name;
    private String currentMonthScore;
    private String lastMonthScore;
    private String todayScore;
    private String yesterdayScore;
    private String currentYearScore;
    private String lastYearScore;
    private String somedayScore; //由用户指定某一时间段内的业绩。
    private String totalScore;
    private String tempScore;

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

    public String getTodayScore() {
        return todayScore;
    }

    public void setTodayScore(String todayScore) {
        this.todayScore = todayScore;
    }

    public String getYesterdayScore() {
        return yesterdayScore;
    }

    public void setYesterdayScore(String yesterdayScore) {
        this.yesterdayScore = yesterdayScore;
    }

    public String getSomedayScore() {
        return somedayScore;
    }

    public void setSomedayScore(String somedayScore) {
        this.somedayScore = somedayScore;
    }

    public String getTotalScore() {
        return totalScore;
    }

    public void setTotalScore(String totalScore) {
        this.totalScore = totalScore;
    }

    public String getLastYearScore() {
        return lastYearScore;
    }

    public void setLastYearScore(String lastYearScore) {
        this.lastYearScore = lastYearScore;
    }

    public String getCurrentMonthScore() {
        return currentMonthScore;
    }

    public void setCurrentMonthScore(String currentMonthScore) {
        this.currentMonthScore = currentMonthScore;
    }

    public String getLastMonthScore() {
        return lastMonthScore;
    }

    public void setLastMonthScore(String lastMonthScore) {
        this.lastMonthScore = lastMonthScore;
    }

    public String getCurrentYearScore() {
        return currentYearScore;
    }

    public void setCurrentYearScore(String currentYearScore) {
        this.currentYearScore = currentYearScore;
    }

    public String getTempScore() {
        return tempScore;
    }

    public void setTempScore(String tempScore) {
        this.tempScore = tempScore;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }

}
