package com.grid.dao;

import com.grid.entity.ChargeBean;
import com.grid.entity.QueryChargeBean;

import java.util.List;

/**
 * Created by wanghuijian on 17/12/14.
 */
public interface ChargeDao {
    int insert(ChargeBean chargeBean);

    List<ChargeBean> getChargeRecordByParam(QueryChargeBean queryChargeBean);
    int getChargeRecordCountByParam(QueryChargeBean queryChargeBean);

}
