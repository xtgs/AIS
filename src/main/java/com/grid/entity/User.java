package com.grid.entity;

import java.util.Date;

/**
 * Created by wanghuijian on 17/8/15.
 */
public class User {
    private String uid;//主键。后台用户ID
    private String name;//用户姓名
    private String mphone;//手机号码
    private String telphone;
    private String password; //密码，密文存储。加密规则为：md5(uid+明文password)
    private String gender; //性别。1:男，2:女
    private String type; //人员类型。1:超级管理员，2:管理员
    private String loginname; //登录系统时的账户名称
    private String remarks; //备注信息
    private String isdel; //用户是否为已删除状态。1:已删除，0:正常状态
    private String loginnameorginal;//用户判定修改登录名时的重复
    private Date createDate; //用户创建时间
    private String createDatestr;//用户创建时间,对应的string
    private String headerimg;
    private String uauth; //用户权限
    private String ugroup;
    private String department;
    private String managegroup;//审核员所管理的班组

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

    public String getMphone() {
        return mphone;
    }

    public void setMphone(String mphone) {
        this.mphone = mphone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getLoginname() {
        return loginname;
    }

    public void setLoginname(String loginname) {
        this.loginname = loginname;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getIsdel() {
        return isdel;
    }

    public void setIsdel(String isdel) {
        this.isdel = isdel;
    }

    public String getLoginnameorginal() {
        return loginnameorginal;
    }

    public void setLoginnameorginal(String loginnameorginal) {
        this.loginnameorginal = loginnameorginal;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getCreateDatestr() {
        return createDatestr;
    }

    public void setCreateDatestr(String createDatestr) {
        this.createDatestr = createDatestr;
    }

    public String getHeaderimg() {
        return headerimg;
    }

    public void setHeaderimg(String headerimg) {
        this.headerimg = headerimg;
    }

    public String getTelphone() {
        return telphone;
    }

    public void setTelphone(String telphone) {
        this.telphone = telphone;
    }

    public String getUauth() {
        return uauth;
    }

    public void setUauth(String uauth) {
        this.uauth = uauth;
    }

    public String getUgroup() {
        return ugroup;
    }

    public void setUgroup(String ugroup) {
        this.ugroup = ugroup;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getManagegroup() {
        return managegroup;
    }

    public void setManagegroup(String managegroup) {
        this.managegroup = managegroup;
    }
}
