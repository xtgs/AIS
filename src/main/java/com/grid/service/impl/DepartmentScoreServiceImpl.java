package com.grid.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.grid.dao.DepartmentScoreDao;
import com.grid.entity.DepartmentScoreBean;
import com.grid.entity.QueryDepartmentScoreBean;
import com.grid.service.DepartmentScoreService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by wanghuijian on 17/12/26.
 */
@Service
public class DepartmentScoreServiceImpl implements DepartmentScoreService {
    @Resource
    private DepartmentScoreDao departmentScoreDao;

    @Override
    public String getDepartmentScore(QueryDepartmentScoreBean queryDepartmentScoreBean) {
        List<DepartmentScoreBean> departmentScoreList = new ArrayList<DepartmentScoreBean>();
//        DepartmentScoreBean departmentScoreBean1 = new DepartmentScoreBean("时间", "客户总消费额", "客户总充值额");
//        departmentScoreList.add(departmentScoreBean1);
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM");
        SimpleDateFormat format2 = new SimpleDateFormat("yyyy");
        Calendar calendar = Calendar.getInstance();

        //今天
        calendar.setTime(new Date());
        String today = format.format(calendar.getTime());
        QueryDepartmentScoreBean queryDepartmentScoreBean0 = new QueryDepartmentScoreBean(today, today+" 23:59:59");
        departmentScoreList.add(new DepartmentScoreBean(
              today,
                departmentScoreDao.getTotalCharge(queryDepartmentScoreBean0),
                departmentScoreDao.getTotalTopup(queryDepartmentScoreBean0)
        ));

        //前1天
        calendar.setTime(new Date());
        calendar.add(Calendar.DATE, -1);
        String oneDayBefore = format.format(calendar.getTime());
        QueryDepartmentScoreBean queryDepartmentScoreBean1 = new QueryDepartmentScoreBean(oneDayBefore, oneDayBefore+" 23:59:59");
        departmentScoreList.add(new DepartmentScoreBean(
                oneDayBefore,
                departmentScoreDao.getTotalCharge(queryDepartmentScoreBean1),
                departmentScoreDao.getTotalTopup(queryDepartmentScoreBean1)
        ));

        //前2天
        calendar.setTime(new Date());
        calendar.add(Calendar.DATE, -2);
        String twoDayBefore = format.format(calendar.getTime());
        QueryDepartmentScoreBean queryDepartmentScoreBean2 = new QueryDepartmentScoreBean(twoDayBefore, twoDayBefore+" 23:59:59");
        departmentScoreList.add(new DepartmentScoreBean(
                twoDayBefore,
                departmentScoreDao.getTotalCharge(queryDepartmentScoreBean2),
                departmentScoreDao.getTotalTopup(queryDepartmentScoreBean2)
        ));

        //前3天
        calendar.setTime(new Date());
        calendar.add(Calendar.DATE, -3);
        String threeDayBefore = format.format(calendar.getTime());
        QueryDepartmentScoreBean queryDepartmentScoreBean3 = new QueryDepartmentScoreBean(threeDayBefore, threeDayBefore+" 23:59:59");
        departmentScoreList.add(new DepartmentScoreBean(
                threeDayBefore,
                departmentScoreDao.getTotalCharge(queryDepartmentScoreBean3),
                departmentScoreDao.getTotalTopup(queryDepartmentScoreBean3)
        ));

        //前4天
        calendar.setTime(new Date());
        calendar.add(Calendar.DATE, -4);
        String fourDayBefore = format.format(calendar.getTime());
        QueryDepartmentScoreBean queryDepartmentScoreBean4 = new QueryDepartmentScoreBean(fourDayBefore, fourDayBefore+" 23:59:59");
        departmentScoreList.add(new DepartmentScoreBean(
                fourDayBefore,
                departmentScoreDao.getTotalCharge(queryDepartmentScoreBean4),
                departmentScoreDao.getTotalTopup(queryDepartmentScoreBean4)
        ));

        //前5天
        calendar.setTime(new Date());
        calendar.add(Calendar.DATE, -5);
        String fiveDayBefore = format.format(calendar.getTime());
        QueryDepartmentScoreBean queryDepartmentScoreBean5 = new QueryDepartmentScoreBean(fiveDayBefore, fiveDayBefore+" 23:59:59");
        departmentScoreList.add(new DepartmentScoreBean(
                fiveDayBefore,
                departmentScoreDao.getTotalCharge(queryDepartmentScoreBean5),
                departmentScoreDao.getTotalTopup(queryDepartmentScoreBean5)
        ));

        //前6天
        calendar.setTime(new Date());
        calendar.add(Calendar.DATE, -6);
        String sixDayBefore = format.format(calendar.getTime());
        QueryDepartmentScoreBean queryDepartmentScoreBean6 = new QueryDepartmentScoreBean(sixDayBefore, sixDayBefore+" 23:59:59");
        departmentScoreList.add(new DepartmentScoreBean(
                sixDayBefore,
                departmentScoreDao.getTotalCharge(queryDepartmentScoreBean6),
                departmentScoreDao.getTotalTopup(queryDepartmentScoreBean6)
        ));

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

        QueryDepartmentScoreBean queryDepartmentScoreBean100 = new QueryDepartmentScoreBean(currentMonthFirstDay, currentMonthFinalDay+" 23:59:59");
        departmentScoreList.add(new DepartmentScoreBean(
                format1.format(calendar.getTime()),
                departmentScoreDao.getTotalCharge(queryDepartmentScoreBean100),
                departmentScoreDao.getTotalTopup(queryDepartmentScoreBean100)
        ));

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

        QueryDepartmentScoreBean queryDepartmentScoreBean101 = new QueryDepartmentScoreBean(lastMonthFirstDay, lastMonthFinalDay+" 23:59:59");
        departmentScoreList.add(new DepartmentScoreBean(
                format1.format(calendar.getTime()),
                departmentScoreDao.getTotalCharge(queryDepartmentScoreBean101),
                departmentScoreDao.getTotalTopup(queryDepartmentScoreBean101)
        ));

        //前月的第一天
        calendar.setTime(new Date());
        calendar.add(Calendar.MONTH, -2);
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        String twoBeforeMonthFirstDay = format.format(calendar.getTime());
        //前月的最后一天
        calendar.setTime(new Date());
        calendar.add(Calendar.MONTH, -1);
        calendar.set(Calendar.DAY_OF_MONTH, 0);
        String twoBeforeMonthFinalDay = format.format(calendar.getTime());

        QueryDepartmentScoreBean queryDepartmentScoreBean102 = new QueryDepartmentScoreBean(twoBeforeMonthFirstDay, twoBeforeMonthFinalDay+" 23:59:59");
        departmentScoreList.add(new DepartmentScoreBean(
                format1.format(calendar.getTime()),
                departmentScoreDao.getTotalCharge(queryDepartmentScoreBean102),
                departmentScoreDao.getTotalTopup(queryDepartmentScoreBean102)
        ));



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
        QueryDepartmentScoreBean queryDepartmentScoreBean1000 = new QueryDepartmentScoreBean(currentYearFirstDay, currentYearFinalDay+" 23:59:59");
        departmentScoreList.add(new DepartmentScoreBean(
                format2.format(calendar.getTime()),
                departmentScoreDao.getTotalCharge(queryDepartmentScoreBean1000),
                departmentScoreDao.getTotalTopup(queryDepartmentScoreBean1000)
        ));

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
        QueryDepartmentScoreBean queryDepartmentScoreBean1001 = new QueryDepartmentScoreBean(lastYearFirstDay, lastYearFinalDay+" 23:59:59");
        departmentScoreList.add(new DepartmentScoreBean(
                format2.format(calendar.getTime()),
                departmentScoreDao.getTotalCharge(queryDepartmentScoreBean1001),
                departmentScoreDao.getTotalTopup(queryDepartmentScoreBean1001)
        ));

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", departmentScoreList.size());
        jsonObject.put("rows", departmentScoreList);
        return jsonObject.toString();
    }
}
