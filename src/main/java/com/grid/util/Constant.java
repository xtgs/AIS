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

    //交易类型
    public static final String TradeType_Charge = "1";
    public static final String TradeType_Topup = "2";

}
