package com.grid;

import com.grid.dao.DepartmentScoreDao;
import com.grid.entity.QueryDepartmentScoreBean;
import org.junit.Test;

import javax.annotation.Resource;

/**
 * Created by wanghuijian on 17/12/26.
 */
public class DepartmentScoreTest extends BaseTest {

    @Resource
    private DepartmentScoreDao departmentScoreDao;

    @Test
    public void getDepartmentScoreTest() {
        QueryDepartmentScoreBean queryDepartmentScoreBean = new QueryDepartmentScoreBean();
        String charge = departmentScoreDao.getTotalCharge(queryDepartmentScoreBean);
        String topup = departmentScoreDao.getTotalTopup(queryDepartmentScoreBean);
        System.out.println(charge);
        System.out.println(topup);
    }
}
