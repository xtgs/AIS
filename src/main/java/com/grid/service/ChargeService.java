package com.grid.service;

import com.grid.entity.ChargeBean;
import com.grid.entity.QueryChargeBean;

/**
 * Created by wanghuijian on 17/12/14.
 */
public interface ChargeService {
    String addOneChargeRecord(ChargeBean chargeBean);

    String queryChargeReord(QueryChargeBean queryChargeBean);
}
