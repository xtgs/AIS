package com.grid;

import com.grid.dao.ChargeDao;
import com.grid.entity.ChargeBean;
import org.junit.Test;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by wanghuijian on 17/12/19.
 */
public class ChargeDaoTest extends BaseTest {
    @Resource
    private ChargeDao chargeDao;

    @Test
    public void getChargeRecordByParamTest() {
        List<ChargeBean> chargeBeanList = chargeDao.getChargeRecordByParam(null);
        for (ChargeBean chargeBean: chargeBeanList) {
            System.out.println(chargeBean);

        }
    }
}
