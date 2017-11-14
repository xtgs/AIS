package com.grid.util;

/**
 * Created by Administrator on 2017/3/15.
 * 系统中用到的常量定义
 */

public class Constant {

    //数据库中 uid编码序列的名称
    public static final String userSeqName = "user_seq";
    //uid中编码中，最后面部分的，数字序列的长度
    public static final int userSeqLength = 3;

    //前端资源的版本号
    public static final String FrontEndVersion = "v2.2";
    public static final String CharSet = "utf-8";

    //往session中放置的User对象时，使用的key值
    public static final String LoginUserKey = "loginuser";

    //用户身份类型常量
    public static final String UserType_User = "1";
    public static final String UserType_Admin = "2";
    public static final String UserType_Auditor = "3";
    public static final String UserType_GroupAuditor = "4";
    public static final String UserType_RoomAuditor = "5";
    public static final String UserType_DevAuditor = "6";
    public static final String UserType_DepartAuditor = "7";

    //用户权限
    public static final String UserAuth_BatchDownload = "11";
    public static final String UserAuth_ManageUser = "12";
    public static final String UserAuth_DevModifyDelete = "13";

    public static final String UserAuth_DepartAudit = "3";
    public static final String UserAuth_GroupAudit = "4";
    public static final String UserAuth_RoomAudit = "5";
    public static final String UserAuth_DevAudit = "6";


    //台账信息审核状态常量
    public static final String devToBeAudit = "1"; //待审核
    public static final String devAudited = "2"; //已审核

    //审核状态
    public static final String auditState_Auditing = "0";
    public static final String auditState_AuditAllow = "1";
    public static final String auditState_AuditRefuse = "2";

    //审核类型
    public static final String groupAudit = "group_audit";//"1";
    public static final String roomAudit ="room_audit";// "2";
    public static final String devAudit = "dev_audit"; //"3";
    public static final String departAudit = "depart_audit";//"4";

    public static final String groupAuditor = "group_auditor";//"1";
    public static final String roomAuditor ="room_auditor";// "2";
    public static final String devAuditor = "dev_auditor"; //"3";
    public static final String departAuditor = "depart_auditor";//"4";

    //审核结果,呈现给所有用户
    public static final String allowed = "2"; //通过
    public static final String refused = "1"; //拒绝
    public static final String notAudit = "0"; //待审核,普通用户,和,审核员且无该审核权限下使用该数字,呈现"待审核"字样。
    public static final String toMakeAudit = "3"; //待审核,只针对审核员,数据库中不出现该字样,后台处理使用,对审核员呈现审核点击按键。


    //操作类型
    public static final String OperateType_add = "0"; //新增
    public static final String OperateType_update = "1"; //修改
    public static final String OperateType_delete = "2"; //删除

    //可否撤销,针对用户提交申请后,是否可以撤销,设定在没有审核员审核前是可以撤销的,被任何一个审核员审核后就不可以撤销了
    public static final String CancelState_Yes = "0"; //可以撤销
    public static final String CancelState_No = "1"; //不可撤销

}
