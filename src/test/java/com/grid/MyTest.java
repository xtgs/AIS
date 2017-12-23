package com.grid;

import org.junit.Test;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by wanghuijian on 17/12/22.
 */
public class MyTest {

    @Test
    public void dateTest() {
        Calendar calendar = Calendar.getInstance();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

        //今天
        calendar.setTime(new Date());
        String today = format.format(calendar.getTime());
        System.out.println("today: " + today);

        //昨天
        calendar.add(Calendar.DATE, -1);
        String yesterday = format.format(calendar.getTime());
        System.out.println("yesterday: " + yesterday);


        //今月的第一天
        calendar.setTime(new Date());
        calendar.add(Calendar.MONTH, 0);
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        String currentMonthFirstDay = format.format(calendar.getTime());
        System.out.println("currentMonthFirstDay: " + currentMonthFirstDay);



        //今月的最后一天
        calendar.setTime(new Date());
        calendar.add(Calendar.MONTH, 1);
        calendar.set(Calendar.DAY_OF_MONTH, 0);
        String currentMonthFinalDay = format.format(calendar.getTime());
        System.out.println("currentMonthFinalDay: " + currentMonthFinalDay);

        //上月的第一天
        calendar.setTime(new Date());
        calendar.add(Calendar.MONTH, -1);
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        String lastMonthFirstDay = format.format(calendar.getTime());
        System.out.println("lastMonthFirstDay: " + lastMonthFirstDay);

        //上月的最后一天
        calendar.setTime(new Date());
        calendar.add(Calendar.MONTH, 0);
        calendar.set(Calendar.DAY_OF_MONTH, 0);
        String lastMonthFinalDay = format.format(calendar.getTime());
        System.out.println("lastMonthFinalDay: " + lastMonthFinalDay);

        //当前年的第一天
        calendar.setTime(new Date());
        calendar.add(Calendar.YEAR, 0);
        calendar.set(Calendar.DAY_OF_YEAR, 1);
        String currentYearFirstDay = format.format(calendar.getTime());
        System.out.println("currentYearFirstDay: " + currentYearFirstDay);

        //今年的最后一天
        calendar.setTime(new Date());
        calendar.add(Calendar.YEAR, 1);
        calendar.set(Calendar.DAY_OF_YEAR, 0);
        String currentYearFinalDay = format.format(calendar.getTime());
        System.out.println("currentYearFinalDay: " + currentYearFinalDay);

        //去年的第一天
        calendar.setTime(new Date());
        calendar.add(Calendar.YEAR, -1);
        calendar.set(Calendar.DAY_OF_YEAR, 1);
        String lastYearFirstDay = format.format(calendar.getTime());
        System.out.println("lastYearFirstDay: " + lastYearFirstDay);

        //去年的最后一天
        calendar.setTime(new Date());
        calendar.add(Calendar.YEAR, 0);
        calendar.set(Calendar.DAY_OF_YEAR, 0);
        String lastYearFinalDay = format.format(calendar.getTime());
        System.out.println("lastYearFinalDay: " + lastYearFinalDay);
    }
}
