package com.grid.util;


import com.grid.exception.BgException;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.TimeZone;

/**
 * Created by Administrator on 2017/3/15.
 * 各数据库表的 主键ID的生成类
 */
public class IdUtils {

    /**
     * 自动生成uid的方法
     * @return 生成的uid
     */
    public String getUid() throws BgException {
        String curDateStr = getCurrentDate();
        String user_seq = new SeqUtils().getSeqNextVal(Constant.userSeqName);
        user_seq = SeqUtils.autoAttachZeroFromStart(user_seq, Constant.userSeqLength);
        return "u" + curDateStr + user_seq;
    }

    /**
     * 获取当前日期的方法
     * @return 当前日期，格式为 年(后两位)+月+日，例如 170312
     */
    private String getCurrentDate(){
        Calendar now = Calendar.getInstance(TimeZone.getTimeZone("GMT+08:00"));//获得东八区时间
        SimpleDateFormat s=new SimpleDateFormat("yyMMdd");
        String curDate = s.format(now.getTime());
        return curDate;
    }

}
