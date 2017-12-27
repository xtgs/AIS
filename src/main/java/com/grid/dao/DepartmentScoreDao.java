package com.grid.dao;

import com.grid.entity.QueryDepartmentScoreBean;

/**
 * Created by wanghuijian on 17/12/25.
 */
public interface DepartmentScoreDao {
    String getTotalCharge(QueryDepartmentScoreBean queryDepartmentScoreBean);
    String getTotalTopup(QueryDepartmentScoreBean queryDepartmentScoreBean);
}
