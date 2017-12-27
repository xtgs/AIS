package com.grid.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.grid.dao.UserScoreDao;
import com.grid.entity.PaginationParamBean;
import com.grid.entity.QueryUserScoreBean;
import com.grid.entity.UserScoreBean;
import com.grid.service.UserScoreService;
import com.grid.util.PaginationUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by wanghuijian on 17/12/22.
 */
@Service
public class UserScoreServiceImpl implements UserScoreService {
    @Resource
    private UserScoreDao userScoreDao;

    @Override
    public String getUserScoreByParam(QueryUserScoreBean queryUserScoreBean, String page, String rows) {

        PaginationParamBean paramBean = PaginationUtil.getPaginationParamBean(page,rows);
        // userBeans = userDao.listAllUserAndAdmin(paramBean); //sqlSession.selectList("com.grid.entity.User.listAllUserAndAdmin", paramBean);
        queryUserScoreBean.setStartnum(paramBean.getStartnum());
        queryUserScoreBean.setGetrows(paramBean.getGetrows());

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();

        //今天
        calendar.setTime(new Date());
        String today = format.format(calendar.getTime());

        //昨天
        calendar.add(Calendar.DATE, -1);
        String yesterday = format.format(calendar.getTime());

        //今月的第一天
        calendar.setTime(new Date());
        calendar.add(Calendar.MONTH, 0);
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        String currentMonthFirstDay = format.format(calendar.getTime());

        //今月的最后一天
        calendar.setTime(new Date());
        calendar.add(Calendar.MONTH, 1);
        calendar.set(Calendar.DAY_OF_MONTH, 0);
        String currentMonthFinalDay = format.format(calendar.getTime());

        //上月的第一天
        calendar.setTime(new Date());
        calendar.add(Calendar.MONTH, -1);
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        String lastMonthFirstDay = format.format(calendar.getTime());

        //上月的最后一天
        calendar.setTime(new Date());
        calendar.add(Calendar.MONTH, 0);
        calendar.set(Calendar.DAY_OF_MONTH, 0);
        String lastMonthFinalDay = format.format(calendar.getTime());

        //今年的第一天
        calendar.setTime(new Date());
        calendar.add(Calendar.YEAR, 0);
        calendar.set(Calendar.DAY_OF_YEAR, 1);
        String currentYearFirstDay = format.format(calendar.getTime());

        //今年的最后一天
        calendar.setTime(new Date());
        calendar.add(Calendar.YEAR, 1);
        calendar.set(Calendar.DAY_OF_YEAR, 0);
        String currentYearFinalDay = format.format(calendar.getTime());

        //去年的第一天
        calendar.setTime(new Date());
        calendar.add(Calendar.YEAR, -1);
        calendar.set(Calendar.DAY_OF_YEAR, 1);
        String lastYearFirstDay = format.format(calendar.getTime());

        //去年的最后一天
        calendar.setTime(new Date());
        calendar.add(Calendar.YEAR, 0);
        calendar.set(Calendar.DAY_OF_YEAR, 0);
        String lastYearFinalDay = format.format(calendar.getTime());

        // 获取特定时间内的业绩, flag = 1
        if (queryUserScoreBean.getDateEnd() != null && queryUserScoreBean.getDateEnd().length() != 0) {
            queryUserScoreBean.setDateEnd(queryUserScoreBean.getDateEnd() + " 23:59:59");
        }
        List<UserScoreBean> someDayScore = userScoreDao.getUserScoreByParam(queryUserScoreBean);

        // 获取今天的业绩, flag = 2
        queryUserScoreBean.setDateStart(today);
        queryUserScoreBean.setDateEnd(today + " 23:59:59");
        List<UserScoreBean> todayScore = userScoreDao.getUserScoreByParam(queryUserScoreBean);

        // 获取昨天的业绩, flag = 3
        queryUserScoreBean.setDateStart(yesterday);
        queryUserScoreBean.setDateEnd(yesterday + " 23:59:59");
        List<UserScoreBean> yesterdayScore = userScoreDao.getUserScoreByParam(queryUserScoreBean);

        // 获取本月的业绩, flag = 4
        queryUserScoreBean.setDateStart(currentMonthFirstDay);
        queryUserScoreBean.setDateEnd(currentMonthFinalDay + " 23:59:59");
        List<UserScoreBean> currentMonthScore = userScoreDao.getUserScoreByParam(queryUserScoreBean);

        // 获取上月的业绩, flag = 5
        queryUserScoreBean.setDateStart(lastMonthFirstDay);
        queryUserScoreBean.setDateEnd(lastMonthFinalDay + " 23:59:59");
        List<UserScoreBean> lastMonthScore = userScoreDao.getUserScoreByParam(queryUserScoreBean);

        // 获取今年的业绩, flag = 6
        queryUserScoreBean.setDateStart(currentYearFirstDay);
        queryUserScoreBean.setDateEnd(currentYearFinalDay + " 23:59:59");
        List<UserScoreBean> currentYearScore = userScoreDao.getUserScoreByParam(queryUserScoreBean);

        // 获取去年的业绩, flag = 7
        queryUserScoreBean.setDateStart(lastYearFirstDay);
        queryUserScoreBean.setDateEnd(lastYearFinalDay + " 23:59:59");
        List<UserScoreBean> lastYearScore = userScoreDao.getUserScoreByParam(queryUserScoreBean);

        List<UserScoreBean> resultList = userScoreDao.getUidAndName(queryUserScoreBean);
        mergeListByUid(resultList, someDayScore, 1);
        mergeListByUid(resultList, todayScore, 2);
        mergeListByUid(resultList, yesterdayScore, 3);
        mergeListByUid(resultList, currentMonthScore, 4);
        mergeListByUid(resultList, lastMonthScore, 5);
        mergeListByUid(resultList, currentYearScore, 6);
        mergeListByUid(resultList, lastYearScore, 7);

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", userScoreDao.getUserNum(queryUserScoreBean));
        jsonObject.put("rows", resultList);
        return jsonObject.toString();
    }

    public List<UserScoreBean> mergeListByUid(List<UserScoreBean> resultList, List<UserScoreBean> list, int flag) {

        if (flag == 1) { //特定日期段的业绩
            Map<String, String> map = new HashMap<String, String>();
            for (UserScoreBean userScoreBean : list) {
                map.put(userScoreBean.getUid(), userScoreBean.getTempScore());
            }
            for(UserScoreBean userScoreBean : resultList) {
                String somedayScore = map.get(userScoreBean.getUid());
                if (somedayScore != null && somedayScore.length() != 0) {
                    userScoreBean.setSomedayScore(somedayScore);
                }
            }
        } else if (flag == 2) { //今日业绩
            Map<String, String> map = new HashMap<String, String>();
            for (UserScoreBean userScoreBean : list) {
                map.put(userScoreBean.getUid(), userScoreBean.getTempScore());
            }
            for(UserScoreBean userScoreBean : resultList) {
                String todayScore = map.get(userScoreBean.getUid());
                if (todayScore != null && todayScore.length() != 0) {
                    userScoreBean.setTodayScore(todayScore);
                }
            }
        } else if (flag == 3) { //昨日业绩
            Map<String, String> map = new HashMap<String, String>();
            for (UserScoreBean userScoreBean : list) {
                map.put(userScoreBean.getUid(), userScoreBean.getTempScore());
            }
            for(UserScoreBean userScoreBean : resultList) {
                String yesterdayScore = map.get(userScoreBean.getUid());
                if (yesterdayScore != null && yesterdayScore.length() != 0) {
                    userScoreBean.setYesterdayScore(yesterdayScore);
                }
            }
        } else if (flag == 4) { //本月业绩
            Map<String, String> map = new HashMap<String, String>();
            for (UserScoreBean userScoreBean : list) {
                map.put(userScoreBean.getUid(), userScoreBean.getTempScore());
            }
            for(UserScoreBean userScoreBean : resultList) {
                String currentMonthScore = map.get(userScoreBean.getUid());
                if (currentMonthScore != null && currentMonthScore.length() != 0) {
                    userScoreBean.setCurrentMonthScore(currentMonthScore);
                }
            }
        } else if (flag == 5) { //上月业绩
            Map<String, String> map = new HashMap<String, String>();
            for (UserScoreBean userScoreBean : list) {
                map.put(userScoreBean.getUid(), userScoreBean.getTempScore());
            }
            for(UserScoreBean userScoreBean : resultList) {
                String lastMonthScore = map.get(userScoreBean.getUid());
                if (lastMonthScore != null && lastMonthScore.length() != 0) {
                    userScoreBean.setLastMonthScore(lastMonthScore);
                }
            }
        } else if (flag == 6) { //今年业绩
            Map<String, String> map = new HashMap<String, String>();
            for (UserScoreBean userScoreBean : list) {
                map.put(userScoreBean.getUid(), userScoreBean.getTempScore());
            }
            for(UserScoreBean userScoreBean : resultList) {
                String currentYearScore = map.get(userScoreBean.getUid());
                if (currentYearScore != null && currentYearScore.length() != 0) {
                    userScoreBean.setCurrentYearScore(currentYearScore);
                }
            }
        } else if (flag == 7) { //去年业绩
            Map<String, String> map = new HashMap<String, String>();
            for (UserScoreBean userScoreBean : list) {
                map.put(userScoreBean.getUid(), userScoreBean.getTempScore());
            }
            for(UserScoreBean userScoreBean : resultList) {
                String lastYearScore = map.get(userScoreBean.getUid());
                if (lastYearScore != null && lastYearScore.length() != 0) {
                    userScoreBean.setLastYearScore(lastYearScore);
                }
            }
        }
        return resultList;

    }
}
